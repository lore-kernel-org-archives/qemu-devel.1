Received: from eggs.gnu.org ([2001:4830:134:3::10]:54571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPWn5-0004Np-1d
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPWn3-000772-R2
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:59:55 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<005f96f5dbffd4c2e370f8b0ee102d3b477e19b0.1542819633.git.alistair.francis@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e49bd19c-ebac-f6c7-d861-2465a5705662@deltatee.com>
Date: Wed, 21 Nov 2018 10:59:43 -0700
MIME-Version: 1.0
In-Reply-To: <005f96f5dbffd4c2e370f8b0ee102d3b477e19b0.1542819633.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 2/6] hw/riscv/virt: Adjust
 memory layout spacing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "abologna@redhat.com" <abologna@redhat.com>



On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  hw/riscv/virt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2b38f89070..6b6fa39aaa 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -47,14 +47,14 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } virt_memmap[] = {
> -    [VIRT_DEBUG] =    {        0x0,      0x100 },
> -    [VIRT_MROM] =     {     0x1000,    0x11000 },
> -    [VIRT_TEST] =     {   0x100000,     0x1000 },
> -    [VIRT_CLINT] =    {  0x2000000,    0x10000 },
> -    [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
> -    [VIRT_UART0] =    { 0x10000000,      0x100 },
> -    [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
> -    [VIRT_DRAM] =     { 0x80000000,        0x0 },
> +    [VIRT_DEBUG] =       {        0x0,         0x100 },
> +    [VIRT_MROM] =        {     0x1000,       0x11000 },
> +    [VIRT_TEST] =        {   0x100000,        0x1000 },
> +    [VIRT_CLINT] =       {  0x2000000,       0x10000 },
> +    [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
> +    [VIRT_UART0] =       { 0x10000000,         0x100 },
> +    [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
> +    [VIRT_DRAM] =        { 0x80000000,           0x0 },
>  };
>  
>  static uint64_t load_kernel(const char *kernel_filename)
> 
