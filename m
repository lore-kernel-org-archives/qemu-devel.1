Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eOdWN-0005xs-Sv
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eOdWJ-00058L-OJ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:54:27 -0500
Received: from [45.249.212.32] (port=51618 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhaoshenglong@huawei.com>)
	id 1eOdWJ-000561-DK
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:54:23 -0500
Message-ID: <5A2F6ED9.5030605@huawei.com>
Date: Tue, 12 Dec 2017 13:53:29 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>



On 2017/12/8 23:02, Peter Maydell wrote:
> Add the second UART to the ACPI tables.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Pure guesswork, as I don't have a UEFI setup to hand and
> am not familiar with ACPI table formats either...
> ---
>  hw/arm/virt-acpi-build.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3d78ff6..a38287b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -689,6 +689,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      Aml *scope, *dsdt;
>      const MemMapEntry *memmap = vms->memmap;
>      const int *irqmap = vms->irqmap;
> @@ -706,6 +707,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> +    if (!vmc->no_second_uart) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART_2],
> +                           (irqmap[VIRT_UART_2] + ARM_SPI_BASE));
> +    }
>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> 
Reviewed-by: Shannon Zhao <zhaoshenglong@huawei.com>

-- 
Shannon
