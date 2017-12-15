Received: from eggs.gnu.org ([2001:4830:134:3::10]:48479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ePp2W-0006nz-0B
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ePp2R-0002Cw-UL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:24:31 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ePp2R-0002Ag-N8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:24:27 -0500
Received: by mail-wm0-x242.google.com with SMTP id f140so17199365wmd.2
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 04:24:27 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-6-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171211125705.16120-6-alex.bennee@linaro.org>
Date: Fri, 15 Dec 2017 12:24:24 +0000
Message-ID: <87bmj089hj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This defines the same set of common constants for float 16 as defined
> for 32 and 64 bit floats. These are often used by target helper
> functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 17dfe60dbd..5a9258c57c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -395,6 +395,13 @@ static inline float16 float16_set_sign(float16 a, in=
t sign)
>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>  }
>
> +#define float16_zero make_float16(0)
> +#define float16_one make_float16(0x3a00)
> +#define float16_ln2 make_float16(0x34d1)
> +#define float16_pi make_float16(0x4448)
> +#define float16_half make_float16(0x3800)
> +#define float16_infinity make_float16(0x7a00)

And:
#define float16_infinity make_float16(0x7c00)


> +
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated half-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/


--
Alex Benn=C3=A9e
