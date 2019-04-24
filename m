Received: from eggs.gnu.org ([209.51.188.92]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6h4-0002zp-IA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6h3-00079e-Jg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ6h1-00077B-Kw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id 8so8403729pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 18:27:22 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59198f7b-231e-939a-6bf4-77649513f881@linaro.org>
Date: Tue, 23 Apr 2019 18:27:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/26] target/arm: Add lazy-FP-stacking
 support to v7m_stack_write()
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
> Pushing registers to the stack for v7M needs to handle three cases:
>  * the "normal" case where we pend exceptions
>  * an "ignore faults" case where we set FSR bits but
>    do not pend exceptions (this is used when we are
>    handling some kinds of derived exception on exception entry)
>  * a "lazy FP stacking" case, where different FSR bits
>    are set and the exception is pended differently
> 
> Implement this by changing the existing flag argument that
> tells us whether to ignore faults or not into an enum that
> specifies which of the 3 modes we should handle.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 118 +++++++++++++++++++++++++++++---------------
>  1 file changed, 79 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
