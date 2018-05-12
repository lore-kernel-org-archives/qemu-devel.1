Received: from eggs.gnu.org ([2001:4830:134:3::10]:60306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHQWy-0002vH-QF
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fHQWx-0000Vk-SA
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:09:32 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fHQWx-0000VX-Mx
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:09:31 -0400
Received: by mail-ot0-x242.google.com with SMTP id g7-v6so8967569otj.11
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 02:09:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bef3e1502d6417c1d533cbf12a032a2963ea4424.1526081108.git.alistair.francis@wdc.com>
References: <cover.1526081108.git.alistair.francis@wdc.com>
	<bef3e1502d6417c1d533cbf12a032a2963ea4424.1526081108.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 12 May 2018 21:09:30 +1200
Message-ID: <CAHNT7NsJHeHFJR99CUFJ8Utwn2tPkpBm-y0MgsTSy-JiMsvsXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] hw/riscv/sifive_u: Move the uart
 device tree node under /soc/
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

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 50389cdc90..540d53bf2f 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -194,7 +194,7 @@ static void create_fdt(SiFiveUState *s, const struct
> MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> -    nodename = g_strdup_printf("/uart@%lx",
> +    nodename = g_strdup_printf("/soc/uart@%lx",
>          (long)memmap[SIFIVE_U_UART0].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
> --
> 2.17.0
>
>
