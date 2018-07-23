Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhhas-0001yd-5Q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhhar-0002yu-Bz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:38:10 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhhaq-0002yW-S5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:38:09 -0400
Received: by mail-pl0-x241.google.com with SMTP id m16-v6so706088pls.11
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:38:08 -0700 (PDT)
References: <20180723180337.17378-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe08bc19-8a5d-a0ae-66de-5a0ba81d4f9c@linaro.org>
Date: Mon, 23 Jul 2018 13:38:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180723180337.17378-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0?] hw/intc/arm_gicv3: Check correct
 HCR_EL2 bit when routing IRQ
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

On 07/23/2018 11:03 AM, Peter Maydell wrote:
> In icc_dir_write() we were incorrectly checking HCR_EL2.FMO
> when determining whether IRQ should be routed to EL2; this should
> be HCR_EL2.IMO (compare the GICv3 pseudocode ICC_DIR_EL1[]).
> Use the correct mask.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Cut-n-paste bug we've had since forever. Linux always sets
> FMO and IMO to the same thing, so we haven't noticed this.
> Probably should go into 3.0, though...
> 
>  hw/intc/arm_gicv3_cpuif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
