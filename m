Received: from eggs.gnu.org ([2001:4830:134:3::10]:51744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuu0-0003B8-Ao
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejutx-0007ca-Es
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:42:48 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:51846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejutx-0007cM-A2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:42:45 -0500
Received: by mail-it0-x244.google.com with SMTP id p139so8599189itb.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:42:45 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbbc1aa9-079f-044b-0af6-08082730f3c2@linaro.org>
Date: Thu, 8 Feb 2018 14:42:41 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 21/32] arm/translate-a64: add FP16
 SCVTF/UCVFT to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> I've re-factored the handle_simd_intfp_conv helper to properly handle
> half-precision as well as call plain conversion helpers when we are
> not doing fixed point conversion.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c        |   4 ++
>  target/arm/helper.h        |  10 ++++
>  target/arm/translate-a64.c | 121 +++++++++++++++++++++++++++++++++++----------
>  3 files changed, 108 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
