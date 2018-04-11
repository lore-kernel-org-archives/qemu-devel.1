Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6D1D-0006Mo-MY
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6D18-0002OL-22
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6D17-0002Nu-U3
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:30:17 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-12-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6b63e895-c7ad-af1c-8d3c-972643b05b24@redhat.com>
Date: Wed, 11 Apr 2018 12:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 11/24] tests/tcg: move i386 specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 10.04.2018 21:39, Alex Benn=C3=A9e wrote:
> These only need to be built for i386 guests. This includes a stub
> tests/tcg/i386/Makfile.target which absorbs some of what was in
> tests/tcg/Makefile.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/README                        |  39 ------------------------=
--------
>  tests/tcg/i386/Makefile.target          |  10 ++++++++
>  tests/tcg/i386/README                   |  38 ++++++++++++++++++++++++=
+++++++
>  tests/tcg/{ =3D> i386}/hello-i386.c       |   0
>  tests/tcg/{ =3D> i386}/pi_10.com          | Bin
>  tests/tcg/{ =3D> i386}/runcom.c           |   0
>  tests/tcg/{ =3D> i386}/test-i386-code16.S |   0
>  tests/tcg/{ =3D> i386}/test-i386-fprem.c  |   0
>  tests/tcg/{ =3D> i386}/test-i386-muldiv.h |   0
>  tests/tcg/{ =3D> i386}/test-i386-shift.h  |   0
>  tests/tcg/{ =3D> i386}/test-i386-ssse3.c  |   0
>  tests/tcg/{ =3D> i386}/test-i386-vm86.S   |   0

Maybe remove the "-i386-" part from the file name now?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
