Received: from eggs.gnu.org ([2001:4830:134:3::10]:45334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJsF-00034O-VS
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJsA-0005K8-95
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:10:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAJsA-0005Hk-1x
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:10:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so6947827wrb.6
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:10:17 -0700 (PDT)
References: <cover.1539023064.git.alistair.francis@wdc.com>
	<1813e888a55667b7097df2a75fa626c98390240d.1539023064.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <103d900d-b0f6-3dab-f543-14fbc30cf519@redhat.com>
Date: Wed, 10 Oct 2018 21:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <1813e888a55667b7097df2a75fa626c98390240d.1539023064.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 08/10/2018 20:25, Alistair Francis wrote:
> From: Michael Clark <mjc@sifive.com>
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
