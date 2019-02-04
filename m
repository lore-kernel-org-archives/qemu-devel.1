Received: from eggs.gnu.org ([209.51.188.92]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqZca-0005sG-Lx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqZcZ-0008Hh-IS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:28:52 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gqZcZ-0008D2-91
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:28:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r17so7434519wrp.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 00:28:46 -0800 (PST)
References: <20190201171229.3361-1-alex.bennee@linaro.org>
	<154920806837.29184.3179104591954776176@ebba9967afc0>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <154920806837.29184.3179104591954776176@ebba9967afc0>
Date: Mon, 04 Feb 2019 08:28:43 +0000
Message-ID: <87r2coot38.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: separate tools and docs into
 another entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net


no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20190201171229.3361-1-alex.bennee@l=
inaro.org/
>
>
>
> Hi,
>
> This series failed the docker-mingw@fedora build test. Please find the te=
sting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/tmp/qemu-test/install --python=3D/usr/bin/python3 --cross-prefix=3Dx86_=
64-w64-mingw32- --enable-trace-backends=3Dsimple --enable-gnutls --enable-n=
ettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent --with=
-sdlabi=3D2.0
> ERROR: unknown option --with-sdlabi=3D2.0
> Try '/tmp/qemu-test/src/configure --help' for more information

That looks like patchew is confused.

--
Alex Benn=C3=A9e
