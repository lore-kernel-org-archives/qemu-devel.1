Received: from eggs.gnu.org ([2001:4830:134:3::10]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epObe-0006ZE-Q3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epObb-0007Ad-MK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:26:30 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epObb-00079l-FO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 20:26:27 -0500
Received: by mail-pf0-x244.google.com with SMTP id y186so3537256pfb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 17:26:27 -0800 (PST)
References: <20180223145959.18761-1-laurent@vivier.eu>
	<20180223145959.18761-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53776cc1-6c33-365e-a19f-965cd1d3c8d5@linaro.org>
Date: Fri, 23 Feb 2018 17:26:23 -0800
MIME-Version: 1.0
In-Reply-To: <20180223145959.18761-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] softfloat: export some functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 02/23/2018 06:59 AM, Laurent Vivier wrote:
> Move fpu/softfloat-macros.h to include/fpu/
> 
> Export floatx80 functions to be used by target floatx80
> specific implementations.
> 
> Exports:
>   propagateFloatx80NaN(), extractFloatx80Frac(),
>   extractFloatx80Exp(), extractFloatx80Sign(),
>   normalizeFloatx80Subnormal(), packFloatx80(),
>   roundAndPackFloatx80(), normalizeRoundAndPackFloatx80()
> 
> Also exports packFloat32() that will be used to implement
> m68k fsinh, fcos, fsin, ftan operations.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Alex Bennée <alex.bennee@linaro.org>
> CC: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
