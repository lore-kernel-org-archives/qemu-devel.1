Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKhE-0002dF-7L
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKhD-0002Q9-6p
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:20 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKhC-0002PJ-Va
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:19:19 -0400
Received: by mail-lf0-x242.google.com with SMTP id f18-v6so2198631lfc.5
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-10-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-10-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:18:51 +0000
Message-ID: <CAKmqyKNSAd6HTbrvfdR7XOuNN23W=Upyz08m=yXGRZ0PNWka1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 09/29] target-microblaze: Conditionalize
 setting of PVR11_USE_MMU
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

> Conditionalize setting of PVR11_USE_MMU on the use_mmu
> CPU property, otherwise we may incorrectly advertise an
> MMU via PVR when the core in fact has none.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 06476f6efc..6fdf0fd223 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -201,7 +201,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error
**errp)
>                                           PVR5_DCACHE_WRITEBACK_MASK : 0;

>       env->pvr.regs[10] = 0x0c000000; /* Default to spartan 3a dsp family.
  */
> -    env->pvr.regs[11] = PVR11_USE_MMU | (16 << 17);
> +    env->pvr.regs[11] = cpu->cfg.use_mmu ? PVR11_USE_MMU : 0 |
> +                        16 << 17;

>       mcc->parent_realize(dev, errp);
>   }
> --
> 2.14.1
