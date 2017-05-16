Received: from eggs.gnu.org ([2001:4830:134:3::10]:39717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAczH-0000fq-52
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAczB-0005rL-Nr
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:58:07 -0400
Received: from sonic311-57.consmr.mail.ir2.yahoo.com ([77.238.176.189]:44136)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAczB-0005r7-Bx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:58:01 -0400
Date: Tue, 16 May 2017 13:53:56 +0000 (UTC)
From: John Bradley <flypie1@yahoo.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <290007707.907996.1494942836719@mail.yahoo.com>
In-Reply-To: <96776f9a-ab8c-b92a-fd07-f69f495d0381@web.de>
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
	<757990479.60759.1494722527715@mail.yahoo.com>
	<CAKmqyKPy35OuMkixGnDXOvApAu82uXrtQStSz4GzHNRStdFFNA@mail.gmail.com>
	<1337329283.3100470.1494870647989@mail.yahoo.com>
	<90703952-bc99-ecfe-96c7-810bb1784dce@amsat.org>
	<1901691584.9094.1494892886522@mail.yahoo.com>
	<96776f9a-ab8c-b92a-fd07-f69f495d0381@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Geert Martin Ijewski <gm.ijewski@web.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, John Bradley <flypie@rocketmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

The idea of an RFC is good, but with it I would like to have a demo. Someth=
ing with no mass implementation to worry about and this would be it.=20
I should also add a version number to the initialisation of the protocol to=
 increase robustness, between versions. I'll call this one V 0.
=C2=A0John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge H=
ill Liverpool L7 7AF=20

    On Tuesday, 16 May 2017, 9:56, Geert Martin Ijewski <gm.ijewski@web.de>=
 wrote:
=20

 Am 16.05.2017 um 02:01 schrieb John Bradley via Qemu-devel:
> Hi,
> The XML files in the base are not in the patch. They where net beans file=
s. I can easily get it into 3 files, one large at 91KB but contains only ne=
w files and so is easy to read. Could be smaller but seems pointless.
>
I think what Alistar meant was something along the lines of:
patch/commit 1) add the remaining bcm2835 devices from Markus=20
Armbruster's code to QEMU (btw: any reason why that hasn't been done?=20
The USB stuff does seem nice to have)
-- with a more meaningful commit title
2) add utils/panelemu.c and the include
3) bcm2835 now uses the emupanel
and then your other commits e.g.
4) USB CDC Ethernet driver dropped packets
5) emupanel: fixed compilation errors on linux
6) emupanel: removed last blocking I/O

Along the way you also seem to fix indentation in other code a lot, that=20
makes following the patches more confusing than they need to be.
It's harder to gauge at a quick glance whether you changed something=20
meaingul or not.

Maybe even send a RFC just detailing the protocol, because it's probably=20
important to get that right from the start.

Geert
> another which is about 19KB of quite simple changes to mostly make files.
> Then one 15KB which quite straight forward when you look at it. Applying =
them in that order should allow step wise addition. I've uploaded them to a=
 share if anyone wants to comment.
>
> The 3 files are new.patch
>
> |
> |
> |
> |=C2=A0 |=C2=A0 =C2=A0 |
>
>=C2=A0 =C2=A0 |
>
>=C2=A0 |
> |
> |=C2=A0 =C2=A0 |
> new.patch
>=C2=A0 Shared with Dropbox=C2=A0 |=C2=A0 |
>
>=C2=A0 |
>
>=C2=A0 |
>
>
>=C2=A0 mod1.patch
>
>
> |
> |
> |
> |=C2=A0 |=C2=A0 =C2=A0 |
>
>=C2=A0 =C2=A0 |
>
>=C2=A0 |
> |
> |=C2=A0 =C2=A0 |
> mod1.patch
>=C2=A0 Shared with Dropbox=C2=A0 |=C2=A0 |
>
>=C2=A0 |
>
>=C2=A0 |
>
>
>
> and
>=C2=A0 a_hw_gpio_bcm2835_gpio.c.patch
>
> |
> |
> |
> |=C2=A0 |=C2=A0 =C2=A0 |
>
>=C2=A0 =C2=A0 |
>
>=C2=A0 |
> |
> |=C2=A0 =C2=A0 |
> a_hw_gpio_bcm2835_gpio.c.patch
>=C2=A0 Shared with Dropbox=C2=A0 |=C2=A0 |
>
>=C2=A0 |
>
>=C2=A0 |
>
>
>
>
>
> John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill =
Liverpool L7 7AF
>
>=C2=A0 =C2=A0 On Tuesday, 16 May 2017, 0:20, Philippe Mathieu-Daud=C3=A9 <=
f4bug@amsat.org> wrote:
>
>
>=C2=A0 Hi John,
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
>>> .gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 54 ++
>>> hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 2 +-
>>> hw/arm/bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 114 ++++
>>> hw/arm/bcm2835_peripherals.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 104 +++=
+
>>> hw/arm/bcm2836.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-
>>> hw/arm/raspi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 77 ++-
>>> hw/gpio/bcm2835_gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 333 ++++++-----
>>> hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 2 +
>>> hw/misc/bcm2835_mphi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 163 ++++++
>>> hw/misc/bcm2835_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 106 ++++
>>> hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A0 2 +
>>> hw/timer/bcm2835_st.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 202 +++++++
>>> hw/timer/bcm2835_timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 224 +++++++
>>> hw/usb/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 4 +-
>>> hw/usb/bcm2835_usb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 604 +++++++++++++++++++
>>> hw/usb/bcm2835_usb_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10=
61
>> ++++++++++++++++++++++++++++++++++
>>> hw/usb/dev-network.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 2 +-
>>> include/hw/arm/bcm2835.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 37 ++
>>> include/hw/arm/bcm2835_peripherals.h |=C2=A0 10 +
>>> include/hw/gpio/bcm2835_gpio.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +
>>> include/hw/intc/bcm2835_control.h=C2=A0 =C2=A0 |=C2=A0 53 ++
>>> include/hw/intc/bcm2836_control.h=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +
>>> include/hw/misc/bcm2835_mphi.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 +
>>> include/hw/misc/bcm2835_power.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 +
>>> include/hw/timer/bcm2835_st.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +
>>> include/hw/timer/bcm2835_timer.h=C2=A0 =C2=A0 |=C2=A0 32 +
>>> include/hw/usb/bcm2835_usb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 78 +++
>>> include/qemu/PanelEmu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 53 ++
>>> util/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 1 +
>>> util/PanelEmu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 293 ++++++++++
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



  =20
