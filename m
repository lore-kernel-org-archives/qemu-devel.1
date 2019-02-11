Received: from eggs.gnu.org ([209.51.188.92]:60989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gtLJ7-0002Ir-N1
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gtLFu-0003b0-Fu
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:44:55 -0500
MIME-Version: 1.0
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
In-Reply-To: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Feb 2019 15:43:57 -0800
Message-ID: <CAKmqyKPXLgqqnQn3hMiE=6XPB9hyh2yu=E6zEYnMOiMd54XNgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Sun, Feb 10, 2019 at 2:12 PM Lukas Auer
<lukas.auer@aisec.fraunhofer.de> wrote:
>
> Re-add the previous compatible string "riscv-virtio-soc" to the soc
> device tree node to allow U-Boot and Linux to bind machine-specific
> drivers to it. The current compatible string "simple-bus" is retained.
>
> This is required by U-Boot to bind devices early, as part of the
> pre-relocation driver model.
>
> Fixes: 53f54508dae6("hw/riscv/virtio: Set the soc device tree node as a
> simple-bus")
> Signed-off-by: Lukas Auer <lukas.auer@aisec.fraunhofer.de>

This looks fine to me.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 3e8b19c668..c53bb905ff 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -157,6 +157,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      char *nodename;
>      uint32_t plic_phandle, phandle = 1;
>      int i;
> +    const char soc_compat[] = "riscv-virtio-soc\0simple-bus";
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -171,7 +172,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>
>      qemu_fdt_add_subnode(fdt, "/soc");
>      qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
> +    qemu_fdt_setprop(fdt, "/soc", "compatible", soc_compat, sizeof(soc_compat));
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> --
> 2.20.1
>
>
