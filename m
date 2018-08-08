Received: from eggs.gnu.org ([2001:4830:134:3::10]:47581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnRnv-0007Et-T8
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 12:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnRnq-0006Kl-Uh
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 12:59:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnRnq-0006Ir-NJ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 12:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4739940241C6
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 16:59:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <96e995b7-9dec-05af-5835-ab200bb1a743@redhat.com> (Thomas Huth's
	message of "Wed, 8 Aug 2018 14:10:34 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-7-quintela@redhat.com>
	<96e995b7-9dec-05af-5835-ab200bb1a743@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 08 Aug 2018 18:59:10 +0200
Message-ID: <87pnysx09t.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/22] i386-softmmu: Configuration is
 identical to x86_64-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> On 08/08/2018 01:48 PM, Juan Quintela wrote:
>> If we ever changed that, just make the things that are different
>> explicit.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/i386-softmmu.mak | 65 +-------------------------------
>>  1 file changed, 1 insertion(+), 64 deletions(-)
>> 
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index 8827166ba1..6ec7a3b0ae 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -1,66 +1,3 @@
>>  # Default configuration for i386-softmmu
>>  
>> -include pci.mak
>> -include sound.mak
>> -include usb.mak
>> -CONFIG_QXL=$(CONFIG_SPICE)
>> -CONFIG_VGA_ISA=y
>> -CONFIG_VGA_CIRRUS=y
>> -CONFIG_VMWARE_VGA=y
>> -CONFIG_VMXNET3_PCI=y
>> -CONFIG_VIRTIO_VGA=y
>> -CONFIG_VMMOUSE=y
>> -CONFIG_IPMI=y
>> -CONFIG_IPMI_LOCAL=y
>> -CONFIG_IPMI_EXTERN=y
>> -CONFIG_ISA_IPMI_KCS=y
>> -CONFIG_ISA_IPMI_BT=y
>> -CONFIG_PARALLEL=y
>> -CONFIG_I8254=y
>> -CONFIG_PCSPK=y
>> -CONFIG_PCKBD=y
>> -CONFIG_FDC=y
>> -CONFIG_ACPI=y
>> -CONFIG_ACPI_X86=y
>> -CONFIG_ACPI_X86_ICH=y
>> -CONFIG_ACPI_MEMORY_HOTPLUG=y
>> -CONFIG_ACPI_CPU_HOTPLUG=y
>> -CONFIG_APM=y
>> -CONFIG_I8257=y
>> -CONFIG_IDE_ISA=y
>> -CONFIG_IDE_PIIX=y
>> -CONFIG_NE2000_ISA=y
>> -CONFIG_HPET=y
>> -CONFIG_APPLESMC=y
>> -CONFIG_I8259=y
>> -CONFIG_PFLASH_CFI01=y
>> -CONFIG_TPM_TIS=$(CONFIG_TPM)
>> -CONFIG_TPM_CRB=$(CONFIG_TPM)
>> -CONFIG_MC146818RTC=y
>> -CONFIG_PCI_PIIX=y
>> -CONFIG_WDT_IB700=y
>> -CONFIG_ISA_DEBUG=y
>> -CONFIG_ISA_TESTDEV=y
>> -CONFIG_VMPORT=y
>> -CONFIG_SGA=y
>> -CONFIG_LPC_ICH9=y
>> -CONFIG_PCI_Q35=y
>> -CONFIG_APIC=y
>> -CONFIG_IOAPIC=y
>> -CONFIG_PVPANIC=y
>> -CONFIG_MEM_HOTPLUG=y
>> -CONFIG_NVDIMM=y
>> -CONFIG_ACPI_NVDIMM=y
>> -CONFIG_PCIE_PORT=y
>> -CONFIG_XIO3130=y
>> -CONFIG_IOH3420=y
>> -CONFIG_I82801B11=y
>> -CONFIG_SMBIOS=y
>> -CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
>> -CONFIG_PXB=y
>> -CONFIG_ACPI_VMGENID=y
>> -CONFIG_FW_CFG_DMA=y
>> -CONFIG_I2C=y
>> -CONFIG_SEV=$(CONFIG_KVM)
>> -CONFIG_VTD=y
>> -CONFIG_AMD_IOMMU=y
>> +include x86_64-softmmu.mak
>
> That's theoretically a good idea, but I think I'd rather do it the other
> way round: include i386-softmmu.mak in the x86_64 config file.
> Rationale: x86_64 is supposed to be a superset of i386, not the other
> way round, so when we will ever get a CONFIG_SWITCH_FOR_X86_64_ONLY,
> it's easier to handle if the includes are done the other way round.

[1]

> And that's also how we do it in aarch64-softmmu.mak an ppc64-softmmu.mak.

This is a good point.

But for (1), I really think that we should make i386 only for old stuff,
and remove things like ISA devices from x86_64 (ok, I know that there is
some ISA on all chipsets, but ne2000-isa is not one of them).

Anyways, I don't really care enough, so I will change that.

Later, Juan.
