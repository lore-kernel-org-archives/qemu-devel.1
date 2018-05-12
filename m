Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHQhh-0005Zf-LB
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHQhg-0005Nd-BU
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:20:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fHQhg-0005NT-4v
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:20:36 -0400
Received: by mail-oi0-x241.google.com with SMTP id a6-v6so6763893oia.2
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 02:20:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <983ec72e6da807c6297e1bf12a8cc6ec02223c9e.1526081108.git.alistair.francis@wdc.com>
References: <cover.1526081108.git.alistair.francis@wdc.com>
	<983ec72e6da807c6297e1bf12a8cc6ec02223c9e.1526081108.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 12 May 2018 21:20:34 +1200
Message-ID: <CAHNT7NsHnAC3MwcVgxw28xf-9d8VoH_gpwM2cvy4ncUA61o8UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] hw/riscv/sifive_u: Set the
 interrupt controler number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On Sat, May 12, 2018 at 11:28 AM, Alistair Francis <alistair.francis@wdc.com
> wrote:

> Set the interrupt-controller ndev to the correct number taken from the
> HiFive Unleashed board.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

If you look at hw/riscv/virt.c we have removed hardcoding a few more
constants using in the device tree. e.g. we allocate and resolve phandles
vs hardcoding them. We can alwauys make a follow up commits to move some of
these magic numbers into constants in the headers, preferably with enum vs
#define.

Reviewed-by: Michael Clark <mjc@sifive.com>

---
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 859f43c6f9..50389cdc90 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -187,7 +187,7 @@ static void create_fdt(SiFiveUState *s, const struct
> MemmapEntry *memmap,
>          0x0, memmap[SIFIVE_U_PLIC].size);
>      qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 4);
> +    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
>      qemu_fdt_setprop_cells(fdt, nodename, "phandle", 2);
>      qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", 2);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> --
> 2.17.0
>
>
