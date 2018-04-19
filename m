Received: from eggs.gnu.org ([2001:4830:134:3::10]:55403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9Ijr-0001bx-GJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9Ijq-0008CP-AU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:13:15 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1f9Ijq-00089E-2M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:13:14 -0400
Received: by mail-lf0-x244.google.com with SMTP id d79-v6so2537377lfd.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 16:13:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419112131.16932-6-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-6-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Apr 2018 16:12:42 -0700
Message-ID: <CAKmqyKNs7L1O8u5LEfxE05sFDnRj242Yp4+WgoTaiN+0ysdhEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] target-microblaze: mmu: Make the
 TLBX MISS bit read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On Thu, Apr 19, 2018 at 4:21 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Make the TLBX MISS bit read-only.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 8391811900..9d5e6aa8a5 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -273,6 +273,10 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
>                  env->mmu.regs[rn] = v;
>              }
>              break;
> +        case MMU_R_TLBX:
> +            /* Bit 31 is read-only.  */
> +            env->mmu.regs[rn] = deposit32(env->mmu.regs[rn], 0, 31, v);
> +            break;
>          case MMU_R_TLBSX:
>          {
>              struct microblaze_mmu_lookup lu;
> --
> 2.14.1
>
>
