Received: from eggs.gnu.org ([2001:4830:134:3::10]:33067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQTL-0003iI-2r
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQTK-0007cX-8i
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:14:03 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNQTK-0007bV-1t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:14:02 -0400
Received: by mail-wr0-x241.google.com with SMTP id x23so20775294wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:14:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497973886-26257-3-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-3-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:13:30 -0700
Message-ID: <CAKmqyKNqRbA0xi40CeKAqsGgGpxTXn5ASM8Mav3PB8tfuvOHUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/8] target-microblaze: Don't hard code
 0xb as initial MB version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistai@xilinx.com>

On Tue, Jun 20, 2017 at 8:51 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Don't hard code 0xb as initial MB version.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/microblaze/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index af70faa..4bc77df 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -152,8 +152,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                         | PVR0_USE_HW_MUL_MASK \
>                         | PVR0_USE_EXC_MASK \
>                         | PVR0_USE_ICACHE_MASK \
> -                       | PVR0_USE_DCACHE_MASK \
> -                       | (0xb << 8);
> +                       | PVR0_USE_DCACHE_MASK;
>      env->pvr.regs[2] = PVR2_D_OPB_MASK \
>                          | PVR2_D_LMB_MASK \
>                          | PVR2_I_OPB_MASK \
> --
> 2.7.4
>
>
