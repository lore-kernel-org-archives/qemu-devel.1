Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt8U-0005NY-6O
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt8P-0005Ve-0h
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:49:38 -0500
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejt8O-0005V6-Re
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:49:32 -0500
Received: by mail-it0-x22f.google.com with SMTP id u12so779716ite.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:49:32 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6490bc6d-b35d-f9a9-1016-fbc85585b328@linaro.org>
Date: Thu, 8 Feb 2018 12:49:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/32] arm/translate-a64: add FP16
 FADD/FABD/FSUB/FMUL/FDIV to simd_three_reg_same_fp16
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
> The fprintf is only there for debugging as the skeleton is added to,
> it will be removed once the skeleton is complete.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>  - add absh helper
>  - fix checkpatch violation
> ---
>  target/arm/helper-a64.c    |  9 +++++++++
>  target/arm/helper-a64.h    |  5 +++++
>  target/arm/translate-a64.c | 28 ++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
