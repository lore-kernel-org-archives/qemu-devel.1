Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC508-0008Bx-HF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC503-0000vv-J8
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:41:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC503-0000vW-C9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:41:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so9876490pfi.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 08:41:43 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df0c727c-97cb-97c5-8f98-7f9255442282@linaro.org>
Date: Mon, 15 Oct 2018 08:41:38 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/10] target/arm: Get IL bit correct for
 v7 syndrome values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/12/18 7:42 AM, Peter Maydell wrote:
> For the v7 version of the Arm architecture, the IL bit in
> syndrome register values where the field is not valid was
> defined to be UNK/SBZP. In v8 this is RES1, which is what
> QEMU currently implements. Handle the desired v7 behaviour
> by squashing the IL bit for the affected cases:
>  * EC == EC_UNCATEGORIZED
>  * prefetch aborts
>  * data aborts where ISV is 0
> 
> (The fourth case listed in the v8 Arm ARM DDI 0487C.a in
> section G7.2.70, "illegal state exception", can't happen
> on a v7 CPU.)
> 
> This deals with a corner case noted in a comment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>      if (cs->exception_index != EXCP_IRQ && cs->exception_index != EXCP_FIQ) {
> +
> +        if (!arm_feature(env, ARM_FEATURE_V8)) {

Extra line.


r~
