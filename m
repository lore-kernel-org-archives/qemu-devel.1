Received: from eggs.gnu.org ([2001:4830:134:3::10]:40181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFPY-0004dn-Nc
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFPV-0004V4-Id
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:05:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLFPV-0004Ub-CC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:05:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id bi12-v6so11684737plb.12
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 15:05:37 -0700 (PDT)
References: <20180522194943.24871-1-pbonzini@redhat.com>
	<f8ad161c-f411-1b60-d81f-7d65cf4ec69f@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2184144-2032-3070-0b51-93cc3f64854c@redhat.com>
Date: Wed, 23 May 2018 00:05:31 +0200
MIME-Version: 1.0
In-Reply-To: <f8ad161c-f411-1b60-d81f-7d65cf4ec69f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: allow compiling out SCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 22/05/2018 22:37, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 05/22/2018 04:49 PM, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  default-configs/mips-softmmu-common.mak | 1 +
>>  default-configs/pci.mak                 | 1 +
>>  default-configs/riscv32-softmmu.mak     | 1 +
>>  default-configs/riscv64-softmmu.mak     | 1 +
>>  default-configs/s390x-softmmu.mak       | 1 +
>>  default-configs/sparc-softmmu.mak       | 1 +
>>  default-configs/usb.mak                 | 1 +
>>  hw/Makefile.objs                        | 2 +-
>>  8 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index e31f046b3b..fae2347ee7 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -4,6 +4,7 @@ include pci.mak
>>  include sound.mak
>>  include usb.mak
>>  CONFIG_ESP=y
>> +CONFIG_SCSI=y
>>  CONFIG_VGA_ISA=y
>>  CONFIG_VGA_ISA_MM=y
>>  CONFIG_VGA_CIRRUS=y
>> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
>> index 35e7596949..163dd814c7 100644
>> --- a/default-configs/pci.mak
>> +++ b/default-configs/pci.mak
>> @@ -15,6 +15,7 @@ CONFIG_PCNET_COMMON=y
>>  CONFIG_AC97=y
>>  CONFIG_HDA=y
>>  CONFIG_ES1370=y
>> +CONFIG_SCSI=y
>>  CONFIG_LSI_SCSI_PCI=y
>>  CONFIG_VMW_PVSCSI_SCSI_PCI=y
>>  CONFIG_MEGASAS_SCSI_PCI=y
>> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
>> index f9e742120c..9159a4a8af 100644
>> --- a/default-configs/riscv32-softmmu.mak
>> +++ b/default-configs/riscv32-softmmu.mak
>> @@ -2,3 +2,4 @@
>>  
>>  CONFIG_SERIAL=y
>>  CONFIG_VIRTIO=y
>> +CONFIG_SCSI=y
>> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
>> index f9e742120c..9159a4a8af 100644
>> --- a/default-configs/riscv64-softmmu.mak
>> +++ b/default-configs/riscv64-softmmu.mak
>> @@ -2,3 +2,4 @@
>>  
>>  CONFIG_SERIAL=y
>>  CONFIG_VIRTIO=y
>> +CONFIG_SCSI=y
>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
>> index 2f4bfe73b4..729033b25a 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -2,6 +2,7 @@ CONFIG_PCI=y
>>  CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
>>  CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>  CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>> +CONFIG_SCSI=y
>>  CONFIG_VIRTIO=y
>>  CONFIG_SCLPCONSOLE=y
>>  CONFIG_TERMINAL3270=y
>> diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
>> index 004b0f4e77..12f97eeb20 100644
>> --- a/default-configs/sparc-softmmu.mak
>> +++ b/default-configs/sparc-softmmu.mak
>> @@ -2,6 +2,7 @@
>>  
>>  CONFIG_ISA_BUS=y
>>  CONFIG_ECC=y
>> +CONFIG_SCSI=y
>>  CONFIG_ESP=y
>>  CONFIG_ESCC=y
>>  CONFIG_M48T59=y
>> diff --git a/default-configs/usb.mak b/default-configs/usb.mak
>> index f4b85684f0..e42cfeabbe 100644
>> --- a/default-configs/usb.mak
>> +++ b/default-configs/usb.mak
>> @@ -3,6 +3,7 @@ CONFIG_USB_TABLET_WACOM=y
>>  CONFIG_USB_STORAGE_BOT=y
>>  CONFIG_USB_STORAGE_UAS=y
>>  CONFIG_USB_STORAGE_MTP=y
>> +CONFIG_SCSI=y
> 
> What about:
> 
> ifeq ($(CONFIG_SCSI),y)
> CONFIG_USB_STORAGE_BOT=y
> CONFIG_USB_STORAGE_UAS=y
> CONFIG_USB_STORAGE_MTP=y
> endif

The question is where the dependency goes: is it USB storage (BOT and
UAS; MTP is different) that should bring in SCSI support, or the other
way round?  Or, in Kconfig terms, whether it is a "depends on SCSI" or a
"select SCSI"...

Paolo

>>  CONFIG_USB_SMARTCARD=y
>>  CONFIG_USB_AUDIO=y
>>  CONFIG_USB_SERIAL=y
>> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
>> index 6a0ffe0afd..a19c1417ed 100644
>> --- a/hw/Makefile.objs
>> +++ b/hw/Makefile.objs
>> @@ -23,7 +23,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += nvram/
>>  devices-dirs-$(CONFIG_SOFTMMU) += pci/
>>  devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
>>  devices-dirs-$(CONFIG_SOFTMMU) += pcmcia/
>> -devices-dirs-$(CONFIG_SOFTMMU) += scsi/
>> +devices-dirs-$(CONFIG_SCSI) += scsi/
>>  devices-dirs-$(CONFIG_SOFTMMU) += sd/
>>  devices-dirs-$(CONFIG_SOFTMMU) += ssi/
>>  devices-dirs-$(CONFIG_SOFTMMU) += timer/
>>
> 
