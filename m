Received: from eggs.gnu.org ([2001:4830:134:3::10]:35797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3kP-0005dc-28
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3kL-0001Qa-3X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:18:57 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:46107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3kK-0001QM-TZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:18:53 -0500
Received: by mail-pg0-x233.google.com with SMTP id b11so9709793pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:18:52 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <068f6754-8fb9-129f-118e-89898d38c76d@linaro.org>
Date: Mon, 18 Dec 2017 14:18:47 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 10/19] fpu/softfloat: re-factor add/sub
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
> We can now add float16_add/sub and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 add and sub functions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

I was involved in writing this, so

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

However,

> +/*
> + * Returns the result of adding the absolute values of the
> + * floating-point values `a' and `b'. If `subtract' is set, the sum is
> + * negated before being returned. `subtract' is ignored if the result
> + * is a NaN. The addition is performed according to the IEC/IEEE
> + * Standard for Binary Floating-Point Arithmetic.
> + */
> +
> +static decomposed_parts add_decomposed(decomposed_parts a, decomposed_parts b,
> +                                       bool subtract, float_status *s)

The comment does not accurately describe what the function does, particularly
wrt subtract.

> +        if (a.cls >= float_class_qnan
> +            ||
> +            b.cls >= float_class_qnan)

Would you please fix this up throughout the patch set?
While I prefer the GNU

  (X
   || Y)

I'm also ok with

  (X ||
   Y)

but || on a line by itself is just weird.


r~
