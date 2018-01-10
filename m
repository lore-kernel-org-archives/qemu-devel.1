Received: from eggs.gnu.org ([2001:4830:134:3::10]:56449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZFPb-0006cT-Cc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZFPa-0003wL-H7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:23:19 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-5-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-sZrr71e0KtTYXao7WQzDoAGtdDqVL1Swjqqs2jUWtWw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <fc41a8ab-3e94-8c8d-6c46-219f1dff82d3@huawei.com>
Date: Wed, 10 Jan 2018 20:20:45 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sZrr71e0KtTYXao7WQzDoAGtdDqVL1Swjqqs2jUWtWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 4/9] ACPI: enable APEI GHES in the
 configure file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James
	Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU
	Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

On 2018/1/10 1:16, Peter Maydell wrote:
> On 28 December 2017 at 05:54, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>> Add CONFIG_ACPI_APEI configuration in the arm-softmmu.mak
>> and add build choice in the Makefile.objs.
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
> 
> You should include this in the patch which first adds the
> new host_ghes.c file. Otherwise that patch won't compile.

sure, will modify it.

> 
> thanks
> -- PMM
> 
> .
> 
