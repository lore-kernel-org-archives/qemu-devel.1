Received: from eggs.gnu.org ([2001:4830:134:3::10]:53817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fTYtP-0007AQ-5M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fTYtO-0004rm-53
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:30:51 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fTYtN-0004n6-Te
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:30:50 -0400
Received: by mail-lf0-x242.google.com with SMTP id n3-v6so11377517lfe.12
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:30:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614202502.668-2-edgar.iglesias@gmail.com>
References: <20180614202502.668-1-edgar.iglesias@gmail.com>
	<20180614202502.668-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 Jun 2018 13:30:17 -0700
Message-ID: <CAKmqyKOG=-fzWykjph7NdrNzbCRgD37VCG7j8S6ZPFHz3kamSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-microblaze: mmu: Correct
 masking of output addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

On Thu, Jun 14, 2018 at 1:25 PM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Correct the masking of output addresses.
>
> This fixes Coverity CID 1391441.
>
> Fixes: commit 3924a9aa02
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/mmu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index f4ceaea520..fcf86b12d5 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -159,7 +159,6 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>
>              lu->vaddr = tlb_tag;
>              lu->paddr = tlb_rpn & mmu->c_addr_mask;
> -            lu->paddr = tlb_rpn;
>              lu->size = tlb_size;
>              lu->err = ERR_HIT;
>              lu->idx = i;
> --
> 2.14.1
>
>
