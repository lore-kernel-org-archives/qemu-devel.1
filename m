Received: from eggs.gnu.org ([2001:4830:134:3::10]:49456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKhl-000318-Vv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKhk-00038X-VT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:53 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKhk-00037q-Ny
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:52 -0400
Received: by mail-lf0-x241.google.com with SMTP id o123-v6so27820053lfe.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-11-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-11-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:19:25 +0000
Message-ID: <CAKmqyKMTT4ssZswv-XPXSCrh0pH2OBJ4v7cxT648aB1KnmO=Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 10/29] target-microblaze: Bypass MMU
 with MMU_NOMMU_IDX
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

On Thu, May 3, 2018 at 2:22 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Bypass MMU translation when mmu-index MMU_NOMMU_IDX is used.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index a9f4ca93e3..261dcc74c7 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -58,7 +58,8 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr
address, int size, int rw,
>       int prot;

>       /* Translate if the MMU is available and enabled.  */
> -    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)) {
> +    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
> +        && mmu_idx != MMU_NOMMU_IDX) {
>           uint32_t vaddr, paddr;
>           struct microblaze_mmu_lookup lu;

> --
> 2.14.1
