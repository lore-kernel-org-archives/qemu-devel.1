Received: from eggs.gnu.org ([209.51.188.92]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gs9WG-0001X4-Lo
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gs9WE-0001Ze-H3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gs9WE-0000zX-8Y
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:00:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<21d093b7-d414-f049-6dbc-e15af138ca8f@redhat.com>
Date: Fri, 08 Feb 2019 17:59:53 +0100
In-Reply-To: <21d093b7-d414-f049-6dbc-e15af138ca8f@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Feb 2019 17:07:13
	+0100")
Message-ID: <874l9e1aie.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Anthony PERARD <anthony.perard@citrix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/8/19 8:30 AM, Markus Armbruster wrote:
>> Short story: please add
>>=20
>>     [am]
>>             messageid =3D true
>>=20
>> to your .gitconfig.
>>=20
>> Long story.  git-am can add a Message-id: tag.  Looks like this:
>>=20
>>     commit 335dbb5de1e98c4dc73590349f17bb2a4d72596c
>>     Author: Thomas Huth <thuth@redhat.com>
>>     Date:   Mon Feb 4 09:25:43 2019 +0100
>>     Commit:     Peter Maydell <peter.maydell@linaro.org>
>>     CommitDate: Mon Feb 4 15:25:21 2019 +0000
>>=20
>>         tests/docker/test-mingw and docs: Remove --with-sdlabi=3D2.0
>>=20
>>         Patchew currently reports failures with the mingw docker test - =
this
>>         is due to --with-sdlabi=3D2.0 configure flag which does not exis=
t anymore.
>>         Remove this remainder from the docker test and the docs now.
>>=20
>>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>>         Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>         Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
>>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>=20
>> The Message-id identifies the patch e-mail.  It makes finding the review
>> thread easier and more reliable.  It's also a valid key on Patchew[*].
>
> It is sometimes confusing however, see:
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01992.html
>
> We have:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190123065618.3520-23-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> This is probably a special case, and eventually a Patchew limitation,
> but I first wondered who wrote this patch? Since the Message-Id is from
> Yang Zhong, is the Signed-off-by tag incorrect?
> Then I went thru the previous version and understood the author is
> indeed Paolo, but his patch was first sent by Yang Zhong, then he
> applied his own patch sent by Yang.
>
> And yet this isn't a pull request but a simple patch, so the Message-Id
> might not be very relevant there.

git-am appears to add a Message-Id only if none is present.

Ideally, people don't submit patches with Message-Id, and maintainers do
use git-am -m.  Given how losely we enforce our process, we're bound to
deviate from the ideal, just like for other patch submission details.
All I'm asking for is a best effort.

>> Sadly, not all of our commits don't carry it.  Here's how top committers
>
> 'committers' -> 'maintainers'?
>
> (Actually committers don't know their patch Message-Id before sending
> the patch).

I used "committers" in the sense of "whoever git-log shows in the
"Commit:" line.  I agree these are maintainers in our work flow.
Calling them maintainers would've been clearer.

>> have been doing recently[**]:
>>=20
>>    with without
>>     264      21 Peter Maydell <peter.maydell@linaro.org>
>>      65       2 Gerd Hoffmann <kraxel@redhat.com>
>>      64       0 Laurent Vivier <laurent@vivier.eu>
>>      64       0 Eric Blake <eblake@redhat.com>
>>      62       1 Eduardo Habkost <ehabkost@redhat.com>
>>      56       0 Markus Armbruster <armbru@redhat.com>
>>      29      72 Richard Henderson <richard.henderson@linaro.org>
>>      24      24 Paolo Bonzini <pbonzini@redhat.com>
>>      10      31 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>       0     107 Kevin Wolf <kwolf@redhat.com>
>>       0     106 David Gibson <david@gibson.dropbear.id.au>
>>       0      93 Michael S. Tsirkin <mst@redhat.com>
>>       0      81 Aleksandar Markovic <amarkovic@wavecomp.com>
>>       0      69 Samuel Thibault <samuel.thibault@ens-lyon.org>
>>       0      54 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>       0      50 Thomas Huth <thuth@redhat.com>
>>       0      29 Anthony PERARD <anthony.perard@citrix.com>
>>       0      28 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> Not bad, but there's room for improvement.
>>=20
>>=20
>> [*] Try https://patchew.org/search?q=3Did%3A1549268743-18502-1-git-send-=
email-thuth%40redhat.com
>>=20
>> [**] git-log master --no-merges --pretty=3Dfuller --since '3 months ago'=
 | gawk '/^Commit: / { if (c) h[c][m]++; c=3D$0; m=3D0 } /^    Message-[Ii]=
d: / { m=3D1 } END { for (c in h) if (h[c][0] + h[c][1] > 25) printf "%7d %=
7d %s\n", h[c][1], h[c][0], substr(c,13) }' | sort -nr
>>=20
