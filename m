Received: from eggs.gnu.org ([209.51.188.92]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExZ1-00084S-Dv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExZ0-0000Ps-4V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:53:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hExYz-0000PA-RO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:53:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so12330371wre.7
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:53:57 -0700 (PDT)
References: <20190317002259.25994-1-philmd@redhat.com>
	<20190317002259.25994-2-philmd@redhat.com>
	<alpine.BSF.2.21.9999.1903170254400.9264@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34b2dd6e-8c40-f639-8cb9-59d37f4ce9fd@redhat.com>
Date: Fri, 12 Apr 2019 16:53:50 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903170254400.9264@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/input/Kconfig: Rename the 8042 PS/2
 Keyboard Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>

On 3/17/19 3:05 AM, BALATON Zoltan wrote:
> On Sun, 17 Mar 2019, Philippe Mathieu-Daudé wrote:
>> The Intel 8042 chipset also includes some functions unrelated to
>> the keyboard, such the A20-Gate. Rename it using the chipset name.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> default-configs/mips-softmmu-common.mak | 2 +-
>> hw/alpha/Kconfig                        | 2 +-
>> hw/i386/Kconfig                         | 2 +-
>> hw/input/Kconfig                        | 2 +-
>> hw/input/Makefile.objs                  | 2 +-
>> hw/sparc64/Kconfig                      | 2 +-
>> hw/unicore32/Kconfig                    | 2 +-
>> 7 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak
>> b/default-configs/mips-softmmu-common.mak
>> index 0795d522db..bad7ee3360 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -13,7 +13,7 @@ CONFIG_SERIAL_ISA=y
>> CONFIG_PARALLEL=y
>> CONFIG_I8254=y
>> CONFIG_PCSPK=y
>> -CONFIG_PCKBD=y
>> +CONFIG_I8042=y
>> CONFIG_FDC=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_X86=y
>> diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
>> index 22cefd9577..eb99765123 100644
>> --- a/hw/alpha/Kconfig
>> +++ b/hw/alpha/Kconfig
>> @@ -8,5 +8,5 @@ config DP264
>>     select IDE_CMD646
>>     select MC146818RTC
>>     select PCI
>> -    select PCKBD
>> +    select I8042
>>     select SMC37C669
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 78fd70396a..7fa5395894 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -20,7 +20,7 @@ config PC
>>     select FDC
>>     select I8259
>>     select I8254
>> -    select PCKBD
>> +    select I8042
>>     select PCSPK
>>     select I82374
>>     select I8257
>> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
>> index e2e66f0858..14e76c5df4 100644
>> --- a/hw/input/Kconfig
>> +++ b/hw/input/Kconfig
>> @@ -5,7 +5,7 @@ config LM832X
>>     bool
>>     depends on I2C
>>
>> -config PCKBD
>> +config I8042
>>     bool
>>     default y
>>     depends on ISA_BUS
>> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
>> index c8b00f71ec..6e4c3389be 100644
>> --- a/hw/input/Makefile.objs
>> +++ b/hw/input/Makefile.objs
>> @@ -1,7 +1,7 @@
>> common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
>> common-obj-y += hid.o
>> common-obj-$(CONFIG_LM832X) += lm832x.o
>> -common-obj-$(CONFIG_PCKBD) += pckbd.o
>> +common-obj-$(CONFIG_I8042) += pckbd.o
> 
> This makes config option different from the filename so I wonder if it's
> worth changing it or better to keep it same as its file like the others?
> A20 gate is controlled by AT keyboard controller but that's probably a
> hack made by the designers of that machine, it's still used mainly as a
> keyboard controller so just to avoid changes we could live with the
> PCKBD name as well (which might even be simpler to understand for people
> not familiar with chip numbers).

Regarding Kconfig, when we model a machine, I find clearer to name the
chipset used by their name. Now when it is about optional feature, I
don't mind.

The other Intel chipset are named similarly:

$ ls -1 hw/*/i[0-9]*c
hw/dma/i82374.c
hw/dma/i8257.c
hw/i2c/i2c-ddc.c
hw/intc/i8259.c
hw/intc/i8259_common.c
hw/isa/i82378.c
hw/timer/i8254.c
hw/timer/i8254_common.c

I'm happy to rename the file as i8042.c as you suggested, however I'll
do it in another patch previous to this one.

Thanks,

Phil.

> Regards,
> BALATON Zoltan
> 
>> common-obj-$(CONFIG_PL050) += pl050.o
>> common-obj-y += ps2.o
>> common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
>> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
>> index 4a8166ebb7..24ccb11c87 100644
>> --- a/hw/sparc64/Kconfig
>> +++ b/hw/sparc64/Kconfig
>> @@ -10,7 +10,7 @@ config SUN4U
>>     select PCI_SABRE
>>     select IDE_CMD646
>>     select PARALLEL
>> -    select PCKBD
>> +    select I8042
>>     select SIMBA
>>
>> config NIAGARA
>> diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
>> index 4443a29dd2..67f4c867c1 100644
>> --- a/hw/unicore32/Kconfig
>> +++ b/hw/unicore32/Kconfig
>> @@ -1,5 +1,5 @@
>> config PUV3
>>     bool
>>     select ISA_BUS
>> -    select PCKBD
>> +    select I8042
>>     select PTIMER
>>
