Received: from eggs.gnu.org ([209.51.188.92]:54002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7TE-0006ht-4d
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7TD-00011H-A4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:37223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7TD-00010A-4f
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id 8so8459335pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:17:11 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b16e2960-e35d-7dc2-2613-3d29a0d7f735@linaro.org>
Date: Tue, 23 Apr 2019 19:17:06 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/26] target/arm: Implement VLSTM for v7M
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
> Implement the VLSTM instruction for v7M for the FPU present case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  2 +
>  target/arm/helper.h    |  2 +
>  target/arm/helper.c    | 84 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c | 15 +++++++-
>  4 files changed, 102 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
