Received: from eggs.gnu.org ([2001:4830:134:3::10]:60330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLchD-0007Ym-1U
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLchC-0006fB-4t
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:57:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLchB-0006eZ-Ue
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:57:26 -0400
Received: by mail-wr0-x244.google.com with SMTP id 94-v6so29313203wrf.5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 15:57:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180523224745.30402-2-edgar.iglesias@gmail.com>
References: <20180523224745.30402-1-edgar.iglesias@gmail.com>
	<20180523224745.30402-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 May 2018 15:56:53 -0700
Message-ID: <CAKmqyKNHERg+twEx+LvJ_TFdtnBGTW288ZvLB5YuJs9CHVQSKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 09/38] target-microblaze: Conditionalize
 setting of PVR11_USE_MMU
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

On Wed, May 23, 2018 at 3:47 PM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Conditionalize setting of PVR11_USE_MMU on the use_mmu
> CPU property, otherwise we may incorrectly advertise an
> MMU via PVR when the core in fact has none.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 06476f6efc..a6f1ce6549 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -201,7 +201,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
>
>      env->pvr.regs[10] = 0x0c000000; /* Default to spartan 3a dsp family.  */
> -    env->pvr.regs[11] = PVR11_USE_MMU | (16 << 17);
> +    env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
> +                        16 << 17;
>
>      mcc->parent_realize(dev, errp);
>  }
> --
> 2.14.1
>
>
