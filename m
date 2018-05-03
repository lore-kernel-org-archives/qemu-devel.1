Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM6z-0005Er-Se
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM6z-0001Jb-5Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:50:01 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEM6y-0001HX-UT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:50:01 -0400
Received: by mail-lf0-x244.google.com with SMTP id j16-v6so28142265lfb.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-25-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-25-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:49:33 +0000
Message-ID: <CAKmqyKN9-y9Yww=BXWYrWkeq+hKJZTP+h81Tji0-=YxVe-fg9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 24/29] target-microblaze: mmu: Add
 R_TBLX_MISS macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:41 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Add a R_TBLX_MISS MASK and SHIFT macros.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/mmu.c | 5 +++--
>   target/microblaze/mmu.h | 4 ++++
>   2 files changed, 7 insertions(+), 2 deletions(-)

> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 0019ebd18f..f4a4c339c9 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -292,8 +292,9 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t
v)
>                                   v & TLB_EPN_MASK, 0, cpu_mmu_index(env,
false));
>               if (hit) {
>                   env->mmu.regs[MMU_R_TLBX] = lu.idx;
> -            } else
> -                env->mmu.regs[MMU_R_TLBX] |= 0x80000000;
> +            } else {
> +                env->mmu.regs[MMU_R_TLBX] |= R_TBLX_MISS_MASK;
> +            }
>               break;
>           }
>           default:
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 3b7a9983d5..113539c6e9 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -54,6 +54,10 @@
>   #define TLB_M                 0x00000002 /* Memory is coherent */
>   #define TLB_G                 0x00000001 /* Memory is guarded from
prefetch */

> +/* TLBX  */
> +#define R_TBLX_MISS_SHIFT 31
> +#define R_TBLX_MISS_MASK (1U << R_TBLX_MISS_SHIFT)
> +
>   #define TLB_ENTRIES    64

>   struct microblaze_mmu
> --
> 2.14.1
