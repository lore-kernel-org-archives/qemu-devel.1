Received: from eggs.gnu.org ([2001:4830:134:3::10]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtm5-0002kp-3L
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejtm1-0004sY-Tk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:30:33 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:44313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejtm1-0004sH-DL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:30:29 -0500
Received: by mail-io0-x243.google.com with SMTP id z6so7350417iob.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:30:29 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9687356b-e2f1-0e94-e6a0-b216ea57244c@linaro.org>
Date: Thu, 8 Feb 2018 13:30:24 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/32] arm/translate-a64: add FP16
 pairwise ops simd_three_reg_same_fp16
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
> This includes FMAXNMP, FADDP, FMAXP, FMINNMP, FMINP.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> ---
>  target/arm/translate-a64.c | 208 +++++++++++++++++++++++++++++----------------
>  1 file changed, 133 insertions(+), 75 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
