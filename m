Received: from eggs.gnu.org ([209.51.188.92]:42608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5No-0001DK-54
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5Cc-0007SK-2S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:51:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5Cb-0007Rn-Rt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:51:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id y3so8381678pgk.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:51:53 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f32055b7-e698-9130-0949-825f27938692@linaro.org>
Date: Tue, 23 Apr 2019 16:51:49 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/26] target/arm: Overlap VECSTRIDE and
 XSCALE_CPAR TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> We are close to running out of TB flags for AArch32; we could
> start using the cs_base word, but before we do that we can
> economise on our usage by sharing the same bits for the VFP
> VECSTRIDE field and the XScale XSCALE_CPAR field. This
> works because no XScale CPU ever had VFP.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 10 ++++++----
>  target/arm/cpu.c       |  7 +++++++
>  target/arm/helper.c    |  6 +++++-
>  target/arm/translate.c |  9 +++++++--
>  4 files changed, 25 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
