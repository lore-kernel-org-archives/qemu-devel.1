Received: from eggs.gnu.org ([2001:4830:134:3::10]:56053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlCgE-0000Gn-28
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlCgD-0007Fj-9h
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:21:38 -0400
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-4-git-send-email-gengdongjiu@huawei.com>
	<599ECEF3.80001@huawei.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <6afc4dfa-5ad1-8df1-7dce-4704a796d8aa@huawei.com>
Date: Fri, 25 Aug 2017 19:20:57 +0800
MIME-Version: 1.0
In-Reply-To: <599ECEF3.80001@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 3/6] ACPI: build and enable APEI GHES
 in the Makefile and configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, zhengqiang10@huawei.com



On 2017/8/24 21:04, Shannon Zhao wrote:
> 
> 
> On 2017/8/18 22:23, Dongjiu Geng wrote:
>> Add CONFIG_ACPI_APEI configuration in the Makefile and
>> enable it in the arm-softmmu.mak
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  default-configs/arm-softmmu.mak | 1 +
>>  hw/acpi/Makefile.objs           | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index bbdd3c1..c362113 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -129,3 +129,4 @@ CONFIG_ACPI=y
>>  CONFIG_SMBIOS=y
>>  CONFIG_ASPEED_SOC=y
>>  CONFIG_GPIO_KEY=y
>> +CONFIG_ACPI_APEI=y
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 11c35bc..bafb148 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>> +common-obj-$(CONFIG_ACPI_APEI) += hest_ghes.o
>>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>>  
>>  common-obj-y += acpi_interface.o
>>
> Fold this patch into previous one.
Ok, thanks

> 
> Thanks,
> 
