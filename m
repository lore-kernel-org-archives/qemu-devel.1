Received: from eggs.gnu.org ([2001:4830:134:3::10]:54490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecHT5-0002WD-M0
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecHT4-0005X3-RT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:11:27 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516300623.git.alistair.francis@xilinx.com>
	<3ddf66fa53e18ba941908bdba5e056e67ccf854b.1516300623.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77046075-c43f-17b7-40cb-6ecc28d0b9c3@amsat.org>
Date: Thu, 18 Jan 2018 18:11:17 -0300
MIME-Version: 1.0
In-Reply-To: <3ddf66fa53e18ba941908bdba5e056e67ccf854b.1516300623.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 1/9] microblaze: boot.c: Don't try to
 find NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com, qemu-arm@nongnu.org

On 01/18/2018 03:37 PM, Alistair Francis wrote:
> Previously if no device tree was passed to microblaze_load_kernel() then
> qemu_find_file() would try to find a NULL pointer. To avoid this put a
> check around qemu_find_file().
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  hw/microblaze/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index 457a08a2fe..35bfeda7aa 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -124,7 +124,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
>      kernel_cmdline = qemu_opt_get(machine_opts, "append");
>      dtb_arg = qemu_opt_get(machine_opts, "dtb");
>      /* default to pcbios dtb as passed by machine_init */
> -    if (!dtb_arg) {
> +    if (!dtb_arg && dtb_filename) {
>          filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
>      }
>  
> 
