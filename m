Received: from eggs.gnu.org ([209.51.188.92]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gs0qn-0004LY-BB
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gs0qk-0008Ay-TM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gs0qd-00084p-Sy
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:45:24 -0500
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b9153c1-2a2d-f55a-3c00-121752bf3036@redhat.com>
Date: Fri, 8 Feb 2019 08:45:05 +0100
MIME-Version: 1.0
In-Reply-To: <87d0o24u0s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2019-02-08 08:30, Markus Armbruster wrote:
> Short story: please add
>=20
>     [am]
>             messageid =3D true
>=20
> to your .gitconfig.
>=20
> Long story.  git-am can add a Message-id: tag.  Looks like this:
>=20
>     commit 335dbb5de1e98c4dc73590349f17bb2a4d72596c
>     Author: Thomas Huth <thuth@redhat.com>
>     Date:   Mon Feb 4 09:25:43 2019 +0100
>     Commit:     Peter Maydell <peter.maydell@linaro.org>
>     CommitDate: Mon Feb 4 15:25:21 2019 +0000
>=20
>         tests/docker/test-mingw and docs: Remove --with-sdlabi=3D2.0
>=20
>         Patchew currently reports failures with the mingw docker test -=
 this
>         is due to --with-sdlabi=3D2.0 configure flag which does not exi=
st anymore.
>         Remove this remainder from the docker test and the docs now.
>=20
>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>         Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> The Message-id identifies the patch e-mail.  It makes finding the revie=
w
> thread easier and more reliable.  It's also a valid key on Patchew[*].
>=20
> Sadly, not all of our commits don't carry it.  Here's how top committer=
s
> have been doing recently[**]:
>=20
>    with without
>     264      21 Peter Maydell <peter.maydell@linaro.org>
>      65       2 Gerd Hoffmann <kraxel@redhat.com>
>      64       0 Laurent Vivier <laurent@vivier.eu>
>      64       0 Eric Blake <eblake@redhat.com>
>      62       1 Eduardo Habkost <ehabkost@redhat.com>
>      56       0 Markus Armbruster <armbru@redhat.com>
>      29      72 Richard Henderson <richard.henderson@linaro.org>
>      24      24 Paolo Bonzini <pbonzini@redhat.com>
>      10      31 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>       0     107 Kevin Wolf <kwolf@redhat.com>
>       0     106 David Gibson <david@gibson.dropbear.id.au>
>       0      93 Michael S. Tsirkin <mst@redhat.com>
>       0      81 Aleksandar Markovic <amarkovic@wavecomp.com>
>       0      69 Samuel Thibault <samuel.thibault@ens-lyon.org>
>       0      54 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>       0      50 Thomas Huth <thuth@redhat.com>
>       0      29 Anthony PERARD <anthony.perard@citrix.com>
>       0      28 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Not bad, but there's room for improvement.

I'd like to, but I can't. I'm still using git 1.8 and the -m parameter
is not supported there yet.

 Thomas
