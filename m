Received: from eggs.gnu.org ([2001:4830:134:3::10]:35451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIWLI-0006lQ-3c
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIWLA-0004vw-KN
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:06:15 -0400
From: Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-6-sameo@linux.intel.com>
	<c88b4769-a517-36da-b181-e59a4380bcea@gmail.com>
Message-ID: <46c01c7d-cab1-8096-821d-dd77c62b240f@gmail.com>
Date: Fri, 2 Nov 2018 18:05:55 +0800
MIME-Version: 1.0
In-Reply-To: <c88b4769-a517-36da-b181-e59a4380bcea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 05/23] hw: arm: Switch to the AML build
 RSDP building routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>



On 2018/11/2 17:35, Shannon Zhao wrote:
> 
> 
> On 2018/11/1 18:22, Samuel Ortiz wrote:
>> We make the ARM virt ACPI code use the now shared build_rsdp() API from
>> aml-build.c. By doing so we fix a bug where the ARM implementation was
>> missing adding both the legacy and extended checksums, which was
>> building an invalid RSDP table.
>>
>> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>>   hw/arm/virt-acpi-build.c | 31 +------------------------------
>>   1 file changed, 1 insertion(+), 30 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 0ed132b79b..0a6a88380a 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -35,6 +35,7 @@
>>   #include "target/arm/cpu.h"
>>   #include "hw/acpi/acpi-defs.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/acpi/aml-build.h"
>>   #include "hw/nvram/fw_cfg.h"
>>   #include "hw/acpi/bios-linker-loader.h"
>>   #include "hw/loader.h"
>> @@ -366,36 +367,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>>       aml_append(scope, dev);
>>   }
>> -/* RSDP */
>> -static void
>> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned 
>> xsdt_tbl_offset)
> Note: here we use xsdt table not rsdt for ARM. After your change which 
> assigns xsdt table address to rsdt_physical_address, it doesn't work.
> 
Oops. I didn't notice your patch "[PATCH v4 04/23] hw: acpi: Implement 
XSDT support for RSDP".

Thanks,
Shannon
