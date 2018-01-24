Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOwj-0006er-CI
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOwg-0008AO-36
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:34:49 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeOwf-0008AA-T3
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:34:46 -0500
Received: by mail-pf0-x22d.google.com with SMTP id 23so3632559pfp.3
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 09:34:45 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf12b90b-d3a2-5973-6e66-9b13dcc3d38e@linaro.org>
Date: Wed, 24 Jan 2018 09:34:42 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 22/22] fpu/softfloat: re-factor sqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/24/2018 05:13 AM, Alex Bennée wrote:
> +/*
> + * Returns an approximation to the square root of the fraction given
> + * by `a'. Considered as an integer, `a' must be at least 2^31. If bit
> + * 0 of `aExp' (the least significant bit) is 1, the integer returned
> + * approximates 2^31*sqrt(`a'/2^31), where `a' is considered an
> + * integer. If bit 0 of `aExp' is 0, the integer returned approximates
> + * 2^31*sqrt(`a'/2^30). In either case, the approximation returned
> + * lies strictly within +/-2 of the exact value.
> + */

The commentary we copied from old softfloat is wrong.
We produce an exactly rounded result.

> +    if (a.cls >= float_class_qnan) {

is_nan.


r~
