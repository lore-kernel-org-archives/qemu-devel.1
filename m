Received: from eggs.gnu.org ([2001:4830:134:3::10]:34944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hpq-0008IT-Tz
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hpm-0002h8-5H
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:38:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6Hpm-0002gp-0q
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:38:54 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-16-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb07e36b-5438-c635-07fd-ccf51310994b@redhat.com>
Date: Wed, 11 Apr 2018 17:38:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 15/24] tests/tcg/i368: fix hello-i386
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
> This is a direct syscall test so needs additional CFLAGS and LDFLAGS.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.target | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.t=
arget
> index 1df69e0dab..44803c0382 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -9,6 +9,12 @@ CFLAGS+=3D$(CROSS_CC_GUEST_CFLAGS)
>  endif
>  endif
> =20
> +#
> +# hello-i386 is a barebones app
> +#
> +hello-i386: CFLAGS+=3D-ffreestanding
> +hello-i386: LDFLAGS+=3D-nostdlib
> +
>  #
>  # test-386 includes a couple of additional objects that need to be lin=
ked together
>  #
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
