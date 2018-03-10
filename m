Received: from eggs.gnu.org ([2001:4830:134:3::10]:38264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulCt-0006Rs-K1
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulCq-0000PU-Fz
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:35:07 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulCq-0000Oe-98
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:35:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id z81so9625072wmb.4
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:35:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-5-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <097a8b2f-327c-fdc9-9e0e-ad5546743c8f@amsat.org>
Date: Sat, 10 Mar 2018 21:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/23] RISC-V: Use ROM base address and
 size from memmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/09/2018 05:12 AM, Michael Clark wrote:
> Another case of replaceing hard coded constants, this time
> referring to the definition in the virt machine's memmap.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/virt.c         | 4 ++--
>  include/hw/riscv/virt.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0055439..0d101fc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -338,11 +338,11 @@ static void riscv_virt_board_init(MachineState *machine)
>      };
>  
>      /* copy in the reset vector */
> -    copy_le32_to_phys(ROM_BASE, reset_vec, sizeof(reset_vec));
> +    copy_le32_to_phys(memmap[VIRT_MROM].base, reset_vec, sizeof(reset_vec));
>  
>      /* copy in the device tree */
>      qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
> -    cpu_physical_memory_write(ROM_BASE + sizeof(reset_vec),
> +    cpu_physical_memory_write(memmap[VIRT_MROM].base + sizeof(reset_vec),
>          s->fdt, s->fdt_size);
>  
>      /* create PLIC hart topology configuration string */
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 2fbe808..655e85d 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -23,8 +23,6 @@
>  #define VIRT(obj) \
>      OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
>  
> -enum { ROM_BASE = 0x1000 };
> -
>  typedef struct {
>      /*< private >*/
>      SysBusDevice parent_obj;
> 
