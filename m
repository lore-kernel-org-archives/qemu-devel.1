Received: from eggs.gnu.org ([2001:4830:134:3::10]:58305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhO-0005jE-9x
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAKhN-0007Dd-BV
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:14 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:45185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAKhL-0007BU-Nt
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:03:12 -0400
Received: by mail-pg1-x529.google.com with SMTP id t70-v6so3002022pgd.12
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:11 -0700 (PDT)
Date: Wed, 10 Oct 2018 13:03:09 -0700 (PDT)
In-Reply-To: <17e897f16e0972da80a22d50b50293dc893731b0.1539023064.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-5258b4f7-a300-4768-a238-85b72cc855d6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] RISC-V: Don't add NULL bootargs to
 device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, alistair23@gmail.com, Alistair.Francis@wdc.com

On Mon, 08 Oct 2018 11:25:56 PDT (-0700), Alistair.Francis@wdc.com wrote:
> From: Michael Clark <mjc@sifive.com>
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c | 4 +++-
>  hw/riscv/spike.c    | 6 ++++--
>  hw/riscv/virt.c     | 4 +++-
>  3 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 862f8ff5f7..ef07df2442 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -230,7 +230,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  }
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index be5ef85e81..8a712ed490 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -156,8 +156,10 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>  
> -    qemu_fdt_add_subnode(fdt, "/chosen");
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_add_subnode(fdt, "/chosen");
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>   }
>  
>  static void spike_v1_10_0_board_init(MachineState *machine)
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 6bd723dc3a..4a137a503c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -254,7 +254,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  
>      return fdt;
> -- 
> 2.17.1
