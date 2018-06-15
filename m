Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTehg-0003Ro-4L
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTehd-0004HP-1N
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:43:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTehc-0004Fy-Pi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:43:04 -0400
Received: by mail-qk0-x243.google.com with SMTP id y4-v6so4893397qka.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:43:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614202502.668-1-edgar.iglesias@gmail.com>
	<20180614202502.668-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <62874723-24a9-33ad-356a-fc3105a6eb8b@amsat.org>
Date: Thu, 14 Jun 2018 23:42:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180614202502.668-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 06/14/2018 05:25 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Correct the masking of output addresses.
> 
> This fixes Coverity CID 1391441.
> 
> Fixes: commit 3924a9aa02
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
