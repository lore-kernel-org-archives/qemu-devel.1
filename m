Received: from eggs.gnu.org ([209.51.188.92]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3JU4-0000Vj-0h
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3JFR-0002Kk-9G
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:37:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3JFR-0002JC-1l
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:37:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so4103787wmj.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 04:37:36 -0700 (PDT)
References: <20190311005618.19007-1-philmd@redhat.com>
	<20190311005618.19007-3-philmd@redhat.com>
	<50e483c6-9580-dcdb-65aa-a8d66040c5a7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <24ecc3f9-4c22-d162-50a1-ad913fe56807@redhat.com>
Date: Mon, 11 Mar 2019 12:37:32 +0100
MIME-Version: 1.0
In-Reply-To: <50e483c6-9580-dcdb-65aa-a8d66040c5a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/mips: Express dependencies of
 the Jazz machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Thomas,

On 3/11/19 12:17 PM, Thomas Huth wrote:
> On 11/03/2019 01.56, Philippe Mathieu-Daudé wrote:
>> The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ. The
>> framebuffer display is managed by a G364, the network card is a Sonic
>> DP83932. A QLogic ESP216 provides a SCSI bus.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v3: Keep CONFIG_JAZZ in default-configs/mips64el-softmmu.mak (Thomas)
>> ---
>>  default-configs/mips-softmmu-common.mak |  1 -
>>  default-configs/mips64-softmmu.mak      |  5 -----
>>  default-configs/mips64el-softmmu.mak    |  5 -----
>>  hw/mips/Kconfig                         | 17 +++++++++++++++++
>>  4 files changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index 8c5fdf5ee1..caebafd416 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -3,7 +3,6 @@
>>  CONFIG_ISA_BUS=y
>>  CONFIG_PCI=y
>>  CONFIG_PCI_DEVICES=y
>> -CONFIG_ESP=y
>>  CONFIG_VGA_ISA=y
>>  CONFIG_VGA_ISA_MM=y
>>  CONFIG_VGA_CIRRUS=y
>> diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips64-softmmu.mak
>> index bad7496672..a169738635 100644
>> --- a/default-configs/mips64-softmmu.mak
>> +++ b/default-configs/mips64-softmmu.mak
>> @@ -1,9 +1,4 @@
>>  # Default configuration for mips64-softmmu
>>  
>>  include mips-softmmu-common.mak
>> -CONFIG_RC4030=y
>> -CONFIG_DP8393X=y
>> -CONFIG_DS1225Y=y
>>  CONFIG_JAZZ=y
>> -CONFIG_G364FB=y
>> -CONFIG_JAZZ_LED=y
>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>> index 8b255efc54..a7b88318b2 100644
>> --- a/default-configs/mips64el-softmmu.mak
>> +++ b/default-configs/mips64el-softmmu.mak
>> @@ -2,13 +2,8 @@
>>  
>>  include mips-softmmu-common.mak
>>  CONFIG_IDE_VIA=y
>> -CONFIG_RC4030=y
>> -CONFIG_DP8393X=y
>> -CONFIG_DS1225Y=y
>>  CONFIG_FULONG=y
>>  CONFIG_JAZZ=y
>> -CONFIG_G364FB=y
>> -CONFIG_JAZZ_LED=y
>>  CONFIG_VT82C686=y
>>  CONFIG_AHCI=y
>>  CONFIG_MIPS_BOSTON=y
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index 3433e97e1a..ab006477c7 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -12,6 +12,23 @@ config MIPSSIM
>>  
>>  config JAZZ
>>      bool
>> +    select ISA_BUS
>> +    select RC4030
>> +    select I8259
>> +    select I8254
>> +    select I8257
>> +    select PCSPK
>> +    select VGA_ISA_MM
>> +    select G364FB
>> +    select DP8393X
> 
> Looking at the code, it seems like you can also run the machine with
> "-net none", so I'd rather use "imply DP8393X" here instead.

Well here I'm not sure.
For the both machine variants (PICA-61 and Magnum 4000), the chipset is
soldered on the board, and is MMIO mapped (via a ChipSelect, no via a
bus you can plug/unplug). So it looks the code inherited habits from
boards having network card via busses.

Not sure the code can be fixed in time for soft freeze.
I might improve the commit message explaining this chipset is soldered
on the board.

Regards,

Phil.
