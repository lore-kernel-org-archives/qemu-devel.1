Received: from eggs.gnu.org ([2001:4830:134:3::10]:39500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpaw-0004ks-NZ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpas-0002BJ-6X
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:03:58 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKpar-00027v-L6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:03:54 -0500
Received: by mail-pl1-x643.google.com with SMTP id s5-v6so9948091plq.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 11:03:53 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 8 Nov 2018 10:58:05 -0800
References: <1793576616012e06e68cd9e0215eb907ff2ef12b.1541627403.git.alistair.francis@wdc.com>
In-Reply-To: <1793576616012e06e68cd9e0215eb907ff2ef12b.1541627403.git.alistair.francis@wdc.com>
Message-ID: <CANs6eMmcgZMoNbv83idynU_qt6GKrGNMu0GkbpxDidw_=QNNOw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 3.1 v1 1/1] hw/riscv/virt: Free the
 test device tree node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com

On Wed, Nov 7, 2018 at 1:52 PM Alistair Francis <Alistair.Francis@wdc.com> 
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4a137a503c..2b38f89070 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const 
> struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    g_free(nodename);
>
>      nodename = g_strdup_printf("/uart@%lx",
>          (long)memmap[VIRT_UART0].base);
> -- 
> 2.19.1
>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com> 
