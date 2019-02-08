Received: from eggs.gnu.org ([209.51.188.92]:39156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs1yh-0002fI-Uh
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs1yh-0006yZ-22
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:57:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gs1yg-0006pr-FL
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:57:42 -0500
Date: Fri, 8 Feb 2019 09:57:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190208095720.3d3f3cb4.cohuck@redhat.com>
In-Reply-To: <87d0o24u0s.fsf@dusky.pond.sub.org>
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?UTF-8?B?QmVubsOp?= =?UTF-8?B?ZQ==?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 08 Feb 2019 08:30:11 +0100
Markus Armbruster <armbru@redhat.com> wrote:

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
>         Patchew currently reports failures with the mingw docker test - t=
his
>         is due to --with-sdlabi=3D2.0 configure flag which does not exist=
 anymore.
>         Remove this remainder from the docker test and the docs now.
>=20
>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>         Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com =20
>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> The Message-id identifies the patch e-mail.  It makes finding the review
> thread easier and more reliable.  It's also a valid key on Patchew[*].

I'm using it for anything I git am, but I'm usually not git am'ing my
own patches (I just merge from the branch I have them on). Is the
message id valuable enough to warrant the extra round-trip for patches
that are committed by the authors themselves?

[I can't say I've used it much myself, if at all.]
