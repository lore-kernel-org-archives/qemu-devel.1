Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecDMD-00050A-RG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecDMA-00038i-QG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:48:05 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:41115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecDMA-00038I-Jk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:48:02 -0500
Received: by mail-pf0-x22c.google.com with SMTP id j3so15044520pfh.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:48:02 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-12-alex.bennee@linaro.org>
	<CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
	<87r2qnnmlx.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb388d43-c72a-8bb2-ab90-732b53fe7fce@linaro.org>
Date: Thu, 18 Jan 2018 08:47:57 -0800
MIME-Version: 1.0
In-Reply-To: <87r2qnnmlx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/20] fpu/softfloat: re-factor add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 01/18/2018 08:43 AM, Alex Bennée wrote:
>   /* Expand fields based on the size of exponent and fraction */
>   #define FRAC_PARAMS(E, F)                                            \
>       .exp_size       = E,                                             \
>       .frac_size      = F,                                             \
>       .frac_shift     = DECOMPOSED_BINARY_POINT - F,                   \
>       .frac_lsb       = 1ull << (DECOMPOSED_BINARY_POINT - F),         \
>       .frac_lsbm1     = 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),   \
>       .round_mask     = (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
>       .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
> 
>   static const FloatFmt float16_params = {
>       .exp_bias       = 0x0f,
>       .exp_max        = 0x1f,
>       FRAC_PARAMS(5, 10)
>   };

You can compute exp_bias and exp_max from E as well.


r~
