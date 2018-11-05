Received: from eggs.gnu.org ([2001:4830:134:3::10]:50103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJf9O-000677-K6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJev1-0004al-Q6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:27:52 -0500
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-13-eric.auger@redhat.com>
	<20181022144026.3171d287@igors-macbook-pro.local>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <249aec02-24a7-a401-8236-638f54352fc2@redhat.com>
Date: Mon, 5 Nov 2018 14:27:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181022144026.3171d287@igors-macbook-pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 12/16] hw/arm/virt-acpi-build: Add PC-DIMM
 in SRAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, david@redhat.com, Suzuki.Poulose@arm.com, qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, dgilbert@redhat.com, qemu-arm@nongnu.org, kwangwoo.lee@sk.com, eric.auger.pro@gmail.com

Hi Igor,

On 10/22/18 3:40 PM, Igor Mammedov wrote:
> On Thu, 18 Oct 2018 16:30:38 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>
>> Generate Memory Affinity Structures for PC-DIMM ranges.
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v3 -> v4:
>> - do not use vms->bootinfo.device_memory_start/device_memory_size anymore
>>
>> v1 -> v2:
>> - build_srat_hotpluggable_memory movedc to aml-build
>> ---
>>  hw/arm/virt-acpi-build.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 5785fb697c..8818bbf5ec 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -545,6 +545,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      int i, srat_start;
>>      uint64_t mem_base;
>>      MachineClass *mc = MACHINE_GET_CLASS(vms);
>> +    MachineState *ms = MACHINE(vms);
>>      const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
>>  
>>      srat_start = table_data->len;
>> @@ -570,6 +571,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>          }
>>      }
>>  
>> +    build_srat_hotpluggable_memory(table_data, ms->device_memory->base,
>> +                                   ms->device_memory->mr.size, 0);
> on x86, we use the last node here to make windows happy. I'd use the same value here.
OK thank you for the information.

Regards

Eric
> 
>> +
>>      build_header(linker, table_data, (void *)(table_data->data + srat_start),
>>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>>  }
> 
> 
