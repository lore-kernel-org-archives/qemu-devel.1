Received: from eggs.gnu.org ([2001:4830:134:3::10]:59069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUsi-0000ZX-Bp
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUsh-0007Zt-FV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:32 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJUsh-0007Ze-A5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:31 -0400
Received: by mail-ot0-x242.google.com with SMTP id 15-v6so7343004otn.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 19:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17b6d0aba8f00cf598c066de7aac478c32323415.1526342674.git.alistair.francis@wdc.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
	<17b6d0aba8f00cf598c066de7aac478c32323415.1526342674.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 14:12:30 +1200
Message-ID: <CAHNT7NuzHBnWciihZz2KJnwHr3dWk60V-8t0wQoC9nmsBB1=Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/7] hw/riscv/sifive_u: Set the soc
 device tree node as a simple-bus
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

On Tue, May 15, 2018 at 12:07 PM, Alistair Francis <alistair.francis@wdc.com
> wrote:

> To allow Linux to ennumerate devices on the /soc/ node set it as a
> "simple-bus".
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 3883d7ff9c..f438a72c27 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -97,7 +97,7 @@ static void create_fdt(SiFiveUState *s, const struct
> MemmapEntry *memmap,
>
>      qemu_fdt_add_subnode(fdt, "/soc");
>      qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible",
> "ucbbar,spike-bare-soc");
> +    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> --
> 2.17.0
>
>
