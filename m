Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj9K-00037k-1W
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj9F-0003hT-Qp
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:21:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBj9F-0003gt-AI
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:21:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id g12-v6so8007065pgs.1
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 09:21:44 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a7c5c0d-0027-38c4-26b3-322cf9ffb42f@linaro.org>
Date: Sun, 14 Oct 2018 09:21:40 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] target/arm: Implement HCR.FB
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
> The HCR.FB virtualization configuration register bit requests that
> TLB maintenance, branch predictor invalidate-all and icache
> invalidate-all operations performed in NS EL1 should be upgraded
> from "local CPU only to "broadcast within Inner Shareable domain".
> For QEMU we NOP the branch predictor and icache operations, so
> we only need to upgrade the TLB invalidates:
>  AArch32 TLBIALL, TLBIMVA, TLBIASID, DTLBIALL, DTLBIMVA, DTLBIASID,
>          ITLBIALL, ITLBIMVA, ITLBIASID, TLBIMVAA, TLBIMVAL, TLBIMVAAL
>  AArch64 TLBI VMALLE1, TLBI VAE1, TLBI ASIDE1, TLBI VAAE1,
>          TLBI VALE1, TLBI VAALE1
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 191 +++++++++++++++++++++++++++-----------------
>  1 file changed, 116 insertions(+), 75 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
