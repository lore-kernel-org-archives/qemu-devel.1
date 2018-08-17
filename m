Received: from eggs.gnu.org ([2001:4830:134:3::10]:54235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqnrR-0007IR-KU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqnrM-00005u-Gv
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:08:53 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqnrM-00005L-4C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:08:48 -0400
Received: by mail-vk0-x242.google.com with SMTP id k82-v6so3957530vkd.5
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 16:08:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1534435831.git.alistair.francis@wdc.com>
	<170c5841b13e1854f276592dfe4296b942edb15e.1534435831.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77344daf-098f-ca8d-ee44-b0b5ed96c6b3@amsat.org>
Date: Fri, 17 Aug 2018 20:08:42 -0300
MIME-Version: 1.0
In-Reply-To: <170c5841b13e1854f276592dfe4296b942edb15e.1534435831.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] hw/riscv/virtio: Set the soc device
 tree node as a simple-bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair23@gmail.com

Hi Alistair,

On 08/16/2018 01:11 PM, Alistair Francis wrote:
> To allow Linux to ennumerate devices on the /soc/ node set it as a

enumerate

> "simple-bus".
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 248bbdffd3..e8ba4d192d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -121,7 +121,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/soc");
>      qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "riscv-virtio-soc");
> +    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");

For consistency can you do the same patch for the Spike board?

>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>  

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
