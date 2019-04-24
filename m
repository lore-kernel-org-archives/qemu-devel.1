Received: from eggs.gnu.org ([209.51.188.92]:60196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7l4-0001LH-9a
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7X9-0006Km-U6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:21:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7X8-0006HW-0V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:21:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id o7so6214092pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:21:13 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <772b2b44-cdaf-7fb3-2c1e-a9ad5f7ba76e@linaro.org>
Date: Tue, 23 Apr 2019 19:21:09 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/26] target/arm: Implement VLLDM for v7M
 CPUs with an FPU
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
> Implement the VLLDM instruction for v7M for the FPU present cas.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h    |  1 +
>  target/arm/helper.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c |  2 +-
>  3 files changed, 56 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
