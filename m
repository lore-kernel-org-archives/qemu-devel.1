Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhb-0005sM-DB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhX-0007GM-Ok
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:25 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAKhS-0007EU-Ho
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id r64-v6so3152099pfb.13
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:16 -0700 (PDT)
Date: Wed, 10 Oct 2018 13:03:13 -0700 (PDT)
In-Reply-To: <1813e888a55667b7097df2a75fa626c98390240d.1539023064.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-02bc8040-38b8-4caf-92da-d3a1fb227cac@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, alistair23@gmail.com, Alistair.Francis@wdc.com

On Mon, 08 Oct 2018 11:25:45 PDT (-0700), Alistair.Francis@wdc.com wrote:
> From: Michael Clark <mjc@sifive.com>
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 005169eabc..6bd723dc3a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *machine)
>      serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    g_free(plic_hart_config);
>  }
>  
>  static void riscv_virt_board_machine_init(MachineClass *mc)
> -- 
> 2.17.1

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
