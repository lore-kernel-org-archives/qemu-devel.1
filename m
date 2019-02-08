Received: from eggs.gnu.org ([209.51.188.92]:53559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gs0cZ-0001R3-3H
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gs0cI-0002k9-TT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gs0cE-0002hI-Lu
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:30:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 08 Feb 2019 08:30:11 +0100
Message-ID: <87d0o24u0s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Anthony PERARD <anthony.perard@citrix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>

Short story: please add

    [am]
            messageid =3D true

to your .gitconfig.

Long story.  git-am can add a Message-id: tag.  Looks like this:

    commit 335dbb5de1e98c4dc73590349f17bb2a4d72596c
    Author: Thomas Huth <thuth@redhat.com>
    Date:   Mon Feb 4 09:25:43 2019 +0100
    Commit:     Peter Maydell <peter.maydell@linaro.org>
    CommitDate: Mon Feb 4 15:25:21 2019 +0000

        tests/docker/test-mingw and docs: Remove --with-sdlabi=3D2.0

        Patchew currently reports failures with the mingw docker test - this
        is due to --with-sdlabi=3D2.0 configure flag which does not exist a=
nymore.
        Remove this remainder from the docker test and the docs now.

        Signed-off-by: Thomas Huth <thuth@redhat.com>
        Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
        Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
        Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
        Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
        Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

The Message-id identifies the patch e-mail.  It makes finding the review
thread easier and more reliable.  It's also a valid key on Patchew[*].

Sadly, not all of our commits don't carry it.  Here's how top committers
have been doing recently[**]:

   with without
    264      21 Peter Maydell <peter.maydell@linaro.org>
     65       2 Gerd Hoffmann <kraxel@redhat.com>
     64       0 Laurent Vivier <laurent@vivier.eu>
     64       0 Eric Blake <eblake@redhat.com>
     62       1 Eduardo Habkost <ehabkost@redhat.com>
     56       0 Markus Armbruster <armbru@redhat.com>
     29      72 Richard Henderson <richard.henderson@linaro.org>
     24      24 Paolo Bonzini <pbonzini@redhat.com>
     10      31 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
      0     107 Kevin Wolf <kwolf@redhat.com>
      0     106 David Gibson <david@gibson.dropbear.id.au>
      0      93 Michael S. Tsirkin <mst@redhat.com>
      0      81 Aleksandar Markovic <amarkovic@wavecomp.com>
      0      69 Samuel Thibault <samuel.thibault@ens-lyon.org>
      0      54 Alex Benn=C3=A9e <alex.bennee@linaro.org>
      0      50 Thomas Huth <thuth@redhat.com>
      0      29 Anthony PERARD <anthony.perard@citrix.com>
      0      28 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Not bad, but there's room for improvement.


[*] Try https://patchew.org/search?q=3Did%3A1549268743-18502-1-git-send-ema=
il-thuth%40redhat.com

[**] git-log master --no-merges --pretty=3Dfuller --since '3 months ago' | =
gawk '/^Commit: / { if (c) h[c][m]++; c=3D$0; m=3D0 } /^    Message-[Ii]d: =
/ { m=3D1 } END { for (c in h) if (h[c][0] + h[c][1] > 25) printf "%7d %7d =
%s\n", h[c][1], h[c][0], substr(c,13) }' | sort -nr
