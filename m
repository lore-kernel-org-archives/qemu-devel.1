Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT42-0002GZ-TC
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT3z-0003dM-3D
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:40:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT3y-0003cp-US
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:40:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id h2-v6so27795046qtp.7
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:40:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-19-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <058fbe8c-e23c-4c72-8a0c-684c01e62b94@amsat.org>
Date: Wed, 23 May 2018 09:40:14 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-19-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 18/30] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 09:15 PM, Michael Clark wrote:
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ad03113e0f72..321fa6e8122a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *machine)
>      serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>          0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    g_free(plic_hart_config);
>  }
>  
>  static void riscv_virt_board_machine_init(MachineClass *mc)
> 
