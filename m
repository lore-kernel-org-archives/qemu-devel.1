Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Nf-0005tp-Bz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Na-0007Nz-4E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:27 -0500
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3NZ-0007LP-Rv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:22 -0500
Received: by mail-pl0-x22c.google.com with SMTP id i6so5660291plt.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:55:21 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
Date: Mon, 18 Dec 2017 13:44:36 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> +static inline float16 float16_set_sign(float16 a, int sign)
> +{
> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
> +}
> +

1) Do we use this anywhere?

2) While this is probably in line with the other implementations,
but going to a more qemu-ish style this should use deposit32.

Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
