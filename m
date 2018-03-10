Received: from eggs.gnu.org ([2001:4830:134:3::10]:35557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euatE-0007eO-2W
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 04:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euat8-0007lk-Ed
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 04:34:08 -0500
References: <20180308223946.26784-1-f4bug@amsat.org>
	<20180308223946.26784-3-f4bug@amsat.org>
	<05abdc35-ef9e-e1b6-e30d-5e7e350ea0a4@ilande.co.uk>
	<534accee-ff52-9e3d-be8d-188297c6004d@amsat.org>
	<d8d3c77a-8088-4925-47e6-52160d0f06ee@ilande.co.uk>
	<CACXAS8A+GwX87MfCP-FAEpasfAv7T=W=E+YifwhWtH_CFq41LQ@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <78bca327-5d31-065f-166e-09823b8dbd0e@ilande.co.uk>
Date: Sat, 10 Mar 2018 09:33:27 +0000
MIME-Version: 1.0
In-Reply-To: <CACXAS8A+GwX87MfCP-FAEpasfAv7T=W=E+YifwhWtH_CFq41LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/25] hw/dma/i8257: Rename DMA_init() to
 i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 09/03/18 20:51, Artyom Tarasenko wrote:

> On Fri, Mar 9, 2018 at 1:19 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> On 09/03/18 10:43, Philippe Mathieu-Daudé wrote:
>>>
>>> Hi Mark,
>>>
>>> On 03/09/2018 11:32 AM, Mark Cave-Ayland wrote:
>>>>
>>>> On 08/03/18 22:39, Philippe Mathieu-Daudé wrote:
>>>>
>>>>> - Move the header from hw/isa/ to hw/dma/
>>>>> - Remove the old i386/pc dependency
>>>>> - use a bool type for the high_page_enable argument
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>>     include/hw/{isa => dma}/i8257.h | 6 ++++++
>>>>>     include/hw/isa/isa.h            | 2 --
>>>>>     hw/dma/i82374.c                 | 3 ++-
>>>>>     hw/dma/i8257.c                  | 4 ++--
>>>>>     hw/i386/pc.c                    | 3 ++-
>>>>>     hw/mips/mips_fulong2e.c         | 3 ++-
>>>>>     hw/mips/mips_jazz.c             | 3 ++-
>>>>>     hw/mips/mips_malta.c            | 3 ++-
>>>>>     hw/sparc/sun4m.c                | 4 ----
>>>>>     hw/sparc64/sun4u.c              | 4 ----
>>>>>     MAINTAINERS                     | 2 +-
>>>>>     11 files changed, 19 insertions(+), 18 deletions(-)
>>>>>     rename include/hw/{isa => dma}/i8257.h (86%)
>>>>>
>>>>> diff --git a/include/hw/isa/i8257.h b/include/hw/dma/i8257.h
>>>>> similarity index 86%
>>>>> rename from include/hw/isa/i8257.h
>>>>> rename to include/hw/dma/i8257.h
>>>>> index 88a2766a3f..2cab50bb6c 100644
>>>>> --- a/include/hw/isa/i8257.h
>>>>> +++ b/include/hw/dma/i8257.h
>>>>> @@ -1,6 +1,10 @@
>>>>>     #ifndef HW_I8257_H
>>>>>     #define HW_I8257_H
>>>>>     +#include "hw/hw.h"
>>>>> +#include "hw/isa/isa.h"
>>>>> +#include "exec/ioport.h"
>>>>> +
>>>>>     #define TYPE_I8257 "i8257"
>>>>>       typedef struct I8257Regs {
>>>>> @@ -40,4 +44,6 @@ typedef struct I8257State {
>>>>>         PortioList portio_pageh;
>>>>>     } I8257State;
>>>>>     +void i8257_dma_init(ISABus *bus, bool high_page_enable);
>>>>> +
>>>>>     #endif
>>>>> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
>>>>> index 95593408ef..b9dbab24b4 100644
>>>>> --- a/include/hw/isa/isa.h
>>>>> +++ b/include/hw/isa/isa.h
>>>>> @@ -151,6 +151,4 @@ static inline ISABus
>>>>> *isa_bus_from_device(ISADevice *d)
>>>>>         return ISA_BUS(qdev_get_parent_bus(DEVICE(d)));
>>>>>     }
>>>>>     -/* i8257.c */
>>>>> -void DMA_init(ISABus *bus, int high_page_enable);
>>>>>     #endif
>>>>> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
>>>>> index 6c0f975df0..83c87d92e0 100644
>>>>> --- a/hw/dma/i82374.c
>>>>> +++ b/hw/dma/i82374.c
>>>>> @@ -24,6 +24,7 @@
>>>>>       #include "qemu/osdep.h"
>>>>>     #include "hw/isa/isa.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>       #define TYPE_I82374 "i82374"
>>>>>     #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
>>>>> @@ -123,7 +124,7 @@ static void i82374_realize(DeviceState *dev, Error
>>>>> **errp)
>>>>>         portio_list_add(&s->port_list,
>>>>> isa_address_space_io(&s->parent_obj),
>>>>>                         s->iobase);
>>>>>     -    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
>>>>> +    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
>>>>>         memset(s->commands, 0, sizeof(s->commands));
>>>>>     }
>>>>>     diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
>>>>> index bd23e893bf..52675e97c9 100644
>>>>> --- a/hw/dma/i8257.c
>>>>> +++ b/hw/dma/i8257.c
>>>>> @@ -24,7 +24,7 @@
>>>>>     #include "qemu/osdep.h"
>>>>>     #include "hw/hw.h"
>>>>>     #include "hw/isa/isa.h"
>>>>> -#include "hw/isa/i8257.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>     #include "qemu/main-loop.h"
>>>>>     #include "trace.h"
>>>>>     @@ -622,7 +622,7 @@ static void i8257_register_types(void)
>>>>>       type_init(i8257_register_types)
>>>>>     -void DMA_init(ISABus *bus, int high_page_enable)
>>>>> +void i8257_dma_init(ISABus *bus, bool high_page_enable)
>>>>>     {
>>>>>         ISADevice *isa1, *isa2;
>>>>>         DeviceState *d;
>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>> index 81364932d3..ec75b09a8f 100644
>>>>> --- a/hw/i386/pc.c
>>>>> +++ b/hw/i386/pc.c
>>>>> @@ -41,6 +41,7 @@
>>>>>     #include "elf.h"
>>>>>     #include "multiboot.h"
>>>>>     #include "hw/timer/mc146818rtc.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>     #include "hw/timer/i8254.h"
>>>>>     #include "hw/audio/pcspk.h"
>>>>>     #include "hw/pci/msi.h"
>>>>> @@ -1609,7 +1610,7 @@ void pc_basic_device_init(ISABus *isa_bus,
>>>>> qemu_irq *gsi,
>>>>>         port92_init(port92, a20_line[1]);
>>>>>         g_free(a20_line);
>>>>>     -    DMA_init(isa_bus, 0);
>>>>> +    i8257_dma_init(isa_bus, 0);
>>>>>           for(i = 0; i < MAX_FD; i++) {
>>>>>             fd[i] = drive_get(IF_FLOPPY, 0, i);
>>>>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>>>>> index dc77b55755..0545fcd899 100644
>>>>> --- a/hw/mips/mips_fulong2e.c
>>>>> +++ b/hw/mips/mips_fulong2e.c
>>>>> @@ -22,6 +22,7 @@
>>>>>     #include "qapi/error.h"
>>>>>     #include "hw/hw.h"
>>>>>     #include "hw/i386/pc.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>     #include "hw/char/serial.h"
>>>>>     #include "hw/char/parallel.h"
>>>>>     #include "hw/block/fdc.h"
>>>>> @@ -360,7 +361,7 @@ static void mips_fulong2e_init(MachineState
>>>>> *machine)
>>>>>           /* init other devices */
>>>>>         pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>>>> -    DMA_init(isa_bus, 0);
>>>>> +    i8257_dma_init(isa_bus, 0);
>>>>>           /* Super I/O */
>>>>>         isa_create_simple(isa_bus, "i8042");
>>>>> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
>>>>> index b24305b7b4..827ffdcd4a 100644
>>>>> --- a/hw/mips/mips_jazz.c
>>>>> +++ b/hw/mips/mips_jazz.c
>>>>> @@ -27,6 +27,7 @@
>>>>>     #include "hw/mips/mips.h"
>>>>>     #include "hw/mips/cpudevs.h"
>>>>>     #include "hw/i386/pc.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>     #include "hw/char/serial.h"
>>>>>     #include "hw/char/parallel.h"
>>>>>     #include "hw/isa/isa.h"
>>>>> @@ -220,7 +221,7 @@ static void mips_jazz_init(MachineState *machine,
>>>>>         /* ISA devices */
>>>>>         i8259 = i8259_init(isa_bus, env->irq[4]);
>>>>>         isa_bus_irqs(isa_bus, i8259);
>>>>> -    DMA_init(isa_bus, 0);
>>>>> +    i8257_dma_init(isa_bus, 0);
>>>>>         pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>>>>         pcspk_init(isa_bus, pit);
>>>>>     diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>>>> index c74882c7e9..9cb86c432e 100644
>>>>> --- a/hw/mips/mips_malta.c
>>>>> +++ b/hw/mips/mips_malta.c
>>>>> @@ -27,6 +27,7 @@
>>>>>     #include "cpu.h"
>>>>>     #include "hw/hw.h"
>>>>>     #include "hw/i386/pc.h"
>>>>> +#include "hw/dma/i8257.h"
>>>>>     #include "hw/char/serial.h"
>>>>>     #include "hw/char/parallel.h"
>>>>>     #include "hw/block/fdc.h"
>>>>> @@ -1209,7 +1210,7 @@ void mips_malta_init(MachineState *machine)
>>>>>         smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
>>>>>         g_free(smbus_eeprom_buf);
>>>>>         pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
>>>>> -    DMA_init(isa_bus, 0);
>>>>> +    i8257_dma_init(isa_bus, 0);
>>>>>           /* Super I/O */
>>>>>         isa_create_simple(isa_bus, "i8042");
>>>>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>>>>> index 0f5804b3b4..fa1bfd6c92 100644
>>>>> --- a/hw/sparc/sun4m.c
>>>>> +++ b/hw/sparc/sun4m.c
>>>>> @@ -99,10 +99,6 @@ struct sun4m_hwdef {
>>>>>         uint8_t nvram_machine_id;
>>>>>     };
>>>>>     -void DMA_init(ISABus *bus, int high_page_enable)
>>>>> -{
>>>>> -}
>>>>> -
>>>>>     static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>>>>                                 Error **errp)
>>>>>     {
>>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>>> index ceb1ba7eaf..0ca0243821 100644
>>>>> --- a/hw/sparc64/sun4u.c
>>>>> +++ b/hw/sparc64/sun4u.c
>>>>> @@ -90,10 +90,6 @@ typedef struct EbusState {
>>>>>     #define TYPE_EBUS "ebus"
>>>>>     #define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
>>>>>     -void DMA_init(ISABus *bus, int high_page_enable)
>>>>> -{
>>>>> -}
>>>>> -
>>>>>     static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>>>>                                 Error **errp)
>>>>>     {
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index c0f1620f3a..335c6c9f65 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -929,8 +929,8 @@ F: hw/timer/mc146818rtc*
>>>>>     F: hw/watchdog/wdt_ib700.c
>>>>>     F: include/hw/display/vga.h
>>>>>     F: include/hw/char/parallel.h
>>>>> +F: include/hw/dma/i8257.h
>>>>>     F: include/hw/i2c/pm_smbus.h
>>>>> -F: include/hw/isa/i8257.h
>>>>>     F: include/hw/timer/hpet.h
>>>>>     F: include/hw/timer/i8254*
>>>>>     F: include/hw/timer/mc146818rtc*
>>>>>
>>>>
>>>> Presumably these DMA_init() functions have been unused on sun4u/sun4m
>>>> for a while which is why they are being removed? Might be worth a
>>>> mention of this in the commit message.
>>>
>>>
>>> Apparently (from git log) once the Sparc machine was copied from the PC
>>> machine (~ 6f7e9aec5), using an empty stub, and finally got cleaned in
>>> ba0a71022 but this function was missed. So this function has never been
>>> implemented.
>>>
>>> I'll add a comment if I need to respin, or gently add the maintainer to
>>> update the commit message if this series is accepted :)
>>>
>>> Thanks!
>>>
>>> Phil.
>>
>>
>> Got it. In that case for sun4/sun4u:
>>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> Out of curiosity, isn't ISA-DMA used by FDthree on Ultra-5/Ultra-10 machines?

Possibly - it's something I really test on a regular basis though. I 
believe Hervé switched the DMA interface over to use the new API on a 
previous patchset, so the function itself is obsolete regardless.


ATB,

Mark.
