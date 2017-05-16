Received: from eggs.gnu.org ([2001:4830:134:3::10]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dAYHH-0007qr-HN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dAYHG-0006tC-9F
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:56:23 -0400
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
	<757990479.60759.1494722527715@mail.yahoo.com>
	<CAKmqyKPy35OuMkixGnDXOvApAu82uXrtQStSz4GzHNRStdFFNA@mail.gmail.com>
	<1337329283.3100470.1494870647989@mail.yahoo.com>
	<90703952-bc99-ecfe-96c7-810bb1784dce@amsat.org>
	<1901691584.9094.1494892886522@mail.yahoo.com>
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <96776f9a-ab8c-b92a-fd07-f69f495d0381@web.de>
Date: Tue, 16 May 2017 10:55:18 +0200
MIME-Version: 1.0
In-Reply-To: <1901691584.9094.1494892886522@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] Changes to Broadcom(BCM) files and
 Raspberry Pi files. Addition of PanelEmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, John Bradley <flypie@rocketmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Am 16.05.2017 um 02:01 schrieb John Bradley via Qemu-devel:
> Hi,
> The XML files in the base are not in the patch. They where net beans files. I can easily get it into 3 files, one large at 91KB but contains only new files and so is easy to read. Could be smaller but seems pointless.
>
I think what Alistar meant was something along the lines of:
patch/commit 1) add the remaining bcm2835 devices from Markus 
Armbruster's code to QEMU (btw: any reason why that hasn't been done? 
The USB stuff does seem nice to have)
-- with a more meaningful commit title
2) add utils/panelemu.c and the include
3) bcm2835 now uses the emupanel
and then your other commits e.g.
4) USB CDC Ethernet driver dropped packets
5) emupanel: fixed compilation errors on linux
6) emupanel: removed last blocking I/O

Along the way you also seem to fix indentation in other code a lot, that 
makes following the patches more confusing than they need to be.
It's harder to gauge at a quick glance whether you changed something 
meaingul or not.

Maybe even send a RFC just detailing the protocol, because it's probably 
important to get that right from the start.

Geert
> another which is about 19KB of quite simple changes to mostly make files.
> Then one 15KB which quite straight forward when you look at it. Applying them in that order should allow step wise addition. I've uploaded them to a share if anyone wants to comment.
>
> The 3 files are new.patch
>
> |
> |
> |
> |   |    |
>
>    |
>
>   |
> |
> |    |
> new.patch
>  Shared with Dropbox  |   |
>
>   |
>
>   |
>
>
>  mod1.patch
>
>
> |
> |
> |
> |   |    |
>
>    |
>
>   |
> |
> |    |
> mod1.patch
>  Shared with Dropbox  |   |
>
>   |
>
>   |
>
>
>
> and
>  a_hw_gpio_bcm2835_gpio.c.patch
>
> |
> |
> |
> |   |    |
>
>    |
>
>   |
> |
> |    |
> a_hw_gpio_bcm2835_gpio.c.patch
>  Shared with Dropbox  |   |
>
>   |
>
>   |
>
>
>
>
>
> John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF
>
>     On Tuesday, 16 May 2017, 0:20, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>
>
>  Hi John,
>
>> That is going to be very difficult as a lot of the changes are
>> interlinked the vast majority of the patch is new files.
>
> I rebased your branch on latest qemu/master here:
>
> https://github.com/philmd/qemu/tree/flypie-GDummyPanel-rebased
>
> It is much easier to follow now, the big XML files you added/removed
> also disappeared (gitk was crashing 'Out Of Memory' trying to look at
> your tree).
>
> I hope it can help you to continue reordering in smaller patches.
>
> Regards,
>
> Phil.
>
> On 05/15/2017 01:46 PM, Alistair Francis wrote:
>>
>> Hey John,
>>
>> Thanks for the patch!
>>
>> Unfortunately this patch is too long to review, you need to split the
>> patch up into shorter more readable patches. Otherwise it's too hard
>> to people to understand what you are changing and why.
>>
>> There are some details here:
>> http://wiki.qemu.org/Contribute/SubmitAPatch
>> <http://wiki.qemu.org/Contribute/SubmitAPatch>about how to split up
>> patches. Each patch applied in order shouldn't break any compilation
>> or runtime. Generally the flow is to add the logic in earlier patches
>> and then connect it and switch it on in the later patches.
>>
>> Try splitting up adding/editing each individual device and send that
>> our first. That is generally the easiest to review/accept.
>>
>> Thanks,
>>
>> Alistair
>>
>>> ---
>>> .gitignore                          |  54 ++
>>> hw/arm/Makefile.objs                |    2 +-
>>> hw/arm/bcm2835.c                    |  114 ++++
>>> hw/arm/bcm2835_peripherals.c        |  104 ++++
>>> hw/arm/bcm2836.c                    |    3 +-
>>> hw/arm/raspi.c                      |  77 ++-
>>> hw/gpio/bcm2835_gpio.c              |  333 ++++++-----
>>> hw/misc/Makefile.objs                |    2 +
>>> hw/misc/bcm2835_mphi.c              |  163 ++++++
>>> hw/misc/bcm2835_power.c              |  106 ++++
>>> hw/timer/Makefile.objs              |    2 +
>>> hw/timer/bcm2835_st.c                |  202 +++++++
>>> hw/timer/bcm2835_timer.c            |  224 +++++++
>>> hw/usb/Makefile.objs                |    4 +-
>>> hw/usb/bcm2835_usb.c                |  604 +++++++++++++++++++
>>> hw/usb/bcm2835_usb_regs.h            | 1061
>> ++++++++++++++++++++++++++++++++++
>>> hw/usb/dev-network.c                |    2 +-
>>> include/hw/arm/bcm2835.h            |  37 ++
>>> include/hw/arm/bcm2835_peripherals.h |  10 +
>>> include/hw/gpio/bcm2835_gpio.h      |    5 +
>>> include/hw/intc/bcm2835_control.h    |  53 ++
>>> include/hw/intc/bcm2836_control.h    |    2 +
>>> include/hw/misc/bcm2835_mphi.h      |  28 +
>>> include/hw/misc/bcm2835_power.h      |  22 +
>>> include/hw/timer/bcm2835_st.h        |  25 +
>>> include/hw/timer/bcm2835_timer.h    |  32 +
>>> include/hw/usb/bcm2835_usb.h        |  78 +++
>>> include/qemu/PanelEmu.h              |  53 ++
>>> util/Makefile.objs                  |    1 +
>>> util/PanelEmu.c                      |  293 ++++++++++
>>> 30 files changed, 3547 insertions(+), 149 deletions(-)
>>> create mode 100644 hw/arm/bcm2835.c
>>> create mode 100644 hw/misc/bcm2835_mphi.c
>>> create mode 100644 hw/misc/bcm2835_power.c
>>> create mode 100644 hw/timer/bcm2835_st.c
>>> create mode 100644 hw/timer/bcm2835_timer.c
>>> create mode 100644 hw/usb/bcm2835_usb.c
>>> create mode 100644 hw/usb/bcm2835_usb_regs.h
>>> create mode 100644 include/hw/arm/bcm2835.h
>>> create mode 100644 include/hw/intc/bcm2835_control.h
>>> create mode 100644 include/hw/misc/bcm2835_mphi.h
>>> create mode 100644 include/hw/misc/bcm2835_power.h
>>> create mode 100644 include/hw/timer/bcm2835_st.h
>>> create mode 100644 include/hw/timer/bcm2835_timer.h
>>> create mode 100644 include/hw/usb/bcm2835_usb.h
>>> create mode 100644 include/qemu/PanelEmu.h
>>> create mode 100644 util/PanelEmu.c
>>>
>>
>>
>
>
>
>
