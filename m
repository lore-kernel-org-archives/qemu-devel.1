Received: from eggs.gnu.org ([2001:4830:134:3::10]:57503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNFj-0004UL-3X
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNFe-00057E-9x
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:59:47 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNFe-00056h-30
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:59:42 -0500
Received: by mail-pl0-x241.google.com with SMTP id bb3so5795530plb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 15:59:41 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10368265-15cd-a473-f8a6-83c075bce825@linaro.org>
Date: Fri, 23 Feb 2018 15:59:38 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/31] arm/translate-a64: add FP16
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
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
