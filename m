Received: from eggs.gnu.org ([2001:4830:134:3::10]:40753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKaCw-00038X-GJ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKaCs-0007wD-DV
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:38:10 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKaCr-0007ur-Ht
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:38:06 -0500
Received: by mail-pl1-x643.google.com with SMTP id o19-v6so8777515pll.12
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 18:38:03 -0800 (PST)
Date: Wed, 07 Nov 2018 18:38:01 -0800 (PST)
In-Reply-To: <1793576616012e06e68cd9e0215eb907ff2ef12b.1541627403.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2f508723-0da1-4d97-9e9e-cbc12898023f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com

On Wed, 07 Nov 2018 13:51:45 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4a137a503c..2b38f89070 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    g_free(nodename);
>  
>      nodename = g_strdup_printf("/uart@%lx",
>          (long)memmap[VIRT_UART0].base);
> -- 
> 2.19.1

Thanks.  I got a bit behind this week so I didn't send the pre-PR, but I indent 
to send a PR tomorrow.  That PR currently only contains this patch.
