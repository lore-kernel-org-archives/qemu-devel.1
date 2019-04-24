Received: from eggs.gnu.org ([209.51.188.92]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7Gr-0003Fl-B9
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7Gq-00038J-8l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7Gp-000377-VD
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id o7so6195353pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:04:23 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88fec784-bb2c-b80b-9e71-104296f063ed@linaro.org>
Date: Tue, 23 Apr 2019 19:04:18 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/26] target/arm: Implement M-profile lazy
 FP state preservation
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
> The M-profile architecture floating point system supports
> lazy FP state preservation, where FP registers are not
> pushed to the stack when an exception occurs but are instead
> only saved if and when the first FP instruction in the exception
> handler is executed. Implement this in QEMU, corresponding
> to the check of LSPACT in the pseudocode ExecuteFPCheck().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |   3 ++
>  target/arm/helper.h    |   2 +
>  target/arm/translate.h |   1 +
>  target/arm/helper.c    | 112 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c |  22 ++++++++
>  5 files changed, 140 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
