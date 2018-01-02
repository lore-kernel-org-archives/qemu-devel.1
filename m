Received: from eggs.gnu.org ([2001:4830:134:3::10]:43814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWPcb-0008KS-Ij
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWPcZ-0006Q2-Md
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:41:01 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213232025.24503-1-f4bug@amsat.org>
	<CAKmqyKNR4ECfJL7ymgyBdVSJKPcxFVJ2=svAE0aUQCW5=qHvSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b825be1-bc57-49c2-d1c9-be83577e8ce1@amsat.org>
Date: Tue, 2 Jan 2018 13:40:42 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNR4ECfJL7ymgyBdVSJKPcxFVJ2=svAE0aUQCW5=qHvSg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="5D817ZYTAZn9H3q0OFXo77dENaWpkY8Pl"
Subject: Re: [Qemu-devel] [PATCH 00/26] SDCard housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, Isaac Lozano <109lozanoi@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Yurovsky <yurovsky@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5D817ZYTAZn9H3q0OFXo77dENaWpkY8Pl
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <famz@redhat.com>, Isaac Lozano <109lozanoi@gmail.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Andrey Yurovsky <yurovsky@gmail.com>
Message-ID: <2b825be1-bc57-49c2-d1c9-be83577e8ce1@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 00/26] SDCard housekeeping
References: <20171213232025.24503-1-f4bug@amsat.org>
 <CAKmqyKNR4ECfJL7ymgyBdVSJKPcxFVJ2=svAE0aUQCW5=qHvSg@mail.gmail.com>
In-Reply-To: <CAKmqyKNR4ECfJL7ymgyBdVSJKPcxFVJ2=svAE0aUQCW5=qHvSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'll try to give a status on this series.

First, let me collect few subthreads here to recapitulate:

>> On 14/12/2017 10:06, Kevin Wolf wrote:
> [...]
>> Doing this kind of thing over QMP doesn't look right to me. qtests
>> should access hardware the same way as real guests access the hardware=

>> (i.e. MMIO and I/O ports).
>
> Yes, I agree with you, however this command does not implement a guest
> access behavior (MMIO and I/O ports) but a _bus_ access.
>
> Guests access buses via MMIO/IOP hardware frontend (bus master), bus
> slave devices might be considered as backend, like the BlockBackend.
>
> As the current iotests are meant for backend testing, this command is
> meant for SDBus backend testing.
>
> Actually with SDHCI I started to qtest the hardware frontend then
> realized the backend was incorrect, so I had to go this way to fix it.
> Later series do test the HCI using C qtests.
>
> This approach should works for any buses, and start to be quite
> interesting with:
> - hot-plug buses to unplug/plug slaves
> - multi-master buses like I2C to inject noise on the bus and see if the=

> host can recover/continue
> - testing slave failures like a bricked SPI slave keeping some bus line=
s
> held and checking if the HCI expose this failure to the guest (or the
> guest checking the HCI for failures)
> [...]
>> On 12/14/2017 06:34 AM, Paolo Bonzini wrote:
>> Yeah, what we usually do is not test the device (e.g. SCSI) directly,
>> but only through the HBA (e.g. virtio-scsi or AHCI, it would be SDHCI =
in
>> this case).
>
> Yes, a SDHCI qtest is added in a later series (in C) using MMIO access:=

> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02391.html
>
> But to be sure the SDHCI is correct I needed a SD slave to behave
> correctly ;) Hence this "bus test".
On 12/15/2017 09:13 PM, Alistair Francis wrote:
>> Based-on: 20171213213557.26561-7-f4bug@amsat.org
>>           (QTests: use Python to run complex tests)
>
> As this series can't be merged until the Python for Qtest series is
> merged I'm not going to go over this now. Let's wait and see how that
> discussion goes first.

On 12/14/2017 06:34 AM, Paolo Bonzini wrote:
>>  create mode 100755 tests/sdcard_tests.py
>
> How hard would it be to rewrite this test as an SDHCI test?

Sadly, more than two weeks later, I can tell you it was somehow hard.

I previously spent 1 day to write this quick python test, 1 more to
write more tests (different sdcard size and handle SD/MMC/SPI protocols).=


Remember this series' goal was to have a correct sdcard model so we
could improve the various SDHCI safely (fix bugs, add support for Spec
v3.01).

Back to C.

Apparently the easiest HCI was the PXA2xx one.
First let find an image and boot it to see how it behaves.
After spending time digging on the Gumstix web, I could find a correct
set of u-boot + uImage + rootfs, and generate the test image.

Let's boot it:

$ qemu-system-arm -M connex -nographic -pflash connex.img \
  -drive if=3Dsd,cache=3Dunsafe,file=3Dsdcard.img
qemu: hardware error: pxa2xx_timer_write: Bad offset 0x00000000000000d8
CPU #0:
R00=3D40f00030 R01=3D40a000d8 R02=3D000000c9 R03=3D48000004
R04=3D00000300 R05=3D00000000 R06=3D00000000 R07=3D00000000
R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
R12=3D00000868 R13=3D00000000 R14=3D0000090c R15=3D00000f0c
PSR=3D000001d3 ---- A svc32
FPSCR: 00000000
Aborted

Ok, let's find the PXA255 datasheet, find the timer section, look
registers, implement what's missing, try again later...

$ qemu-system-arm -M connex -nographic -pflash connex.img \
  -drive if=3Dsd,cache=3Dunsafe,file=3Dsdcard.img

U-Boot 1.2.0 (May 10 2008 - 21:17:19) - PXA270@400 MHz - 1604
Hit any key to stop autoboot:  0
## Booting image at a2000000 ...
   Image Name:   Angstrom/2.6.21/gumstix-custom-c
   Image Type:   ARM Linux Kernel Image (uncompressed)
Starting kernel ...
Linux version 2.6.21 (otto@otto) (gcc version 4.1.2) #1 PREEMPT Mon May
12 14:33:32 PDT 2008
CPU: XScale-PXA255 [69052d00] revision 0 (ARMv5TE), cr=3D00007977
Machine: The Gumstix Platform
Probing Gumstix Flash ROM at physical address 0x00000000 (16-bit bankwidt=
h)
Gumstix Flash ROM: Found 1 x16 devices at 0x0 in 16-bit bank
Creating 3 MTD partitions on "Gumstix Flash ROM":
0x00000000-0x00040000 : "Bootloader"
0x00040000-0x00f00000 : "RootFS"
0x00f00000-0x01000000 : "Kernel"
VFS: Mounted root (jffs2 filesystem).
INIT: version 2.86 booting
qemu-system-arm: Trying to execute code outside RAM or ROM at 0x000618e8
qemu: fatal: Trying to execute code outside RAM or ROM at 0x000618e8
Your guest kernel has a bug and crashed by jumping off into nowhere
Execution cannot continue; stopping here.
R00=3D00000000 R01=3Dbeda1d04 R02=3D000bd818 R03=3D000b1d78
R04=3D000bd838 R05=3D000bd80c R06=3D00000001 R07=3D000bda88
R08=3D00000000 R09=3D00000000 R10=3D401d7000 R11=3D00000000
R12=3D00000000 R13=3Dbeda1a38 R14=3D000876b8 R15=3D000618e8
PSR=3D60000010 -ZC- A usr32
FPSCR: 00000000

No time to figure out this, but at least U-Boot worked and have shell
accessible:

U-Boot 1.2.0 (May 10 2008 - 21:17:19) - PXA270@400 MHz - 1604
Hit any key to stop autoboot:  0
GUM> mmcinit
5366@1514908231.461749:sdcard_normal_command SD        GO_IDLE_STATE/
CMD00 arg 0x00000000 (state idle)
5366@1514908231.461760:sdcard_reset
5366@1514908231.662147:sdcard_app_command SD
SD_SEND_OP_COND/ACMD41 arg 0x00200000 (state idle)
5366@1514908231.662278:sdcard_normal_command SD         ALL_SEND_CID/
CMD02 arg 0x00000000 (state ready)
5366@1514908231.662419:sdcard_normal_command SD   SEND_RELATIVE_ADDR/
CMD03 arg 0x00000000 (state identification)
5366@1514908231.662515:sdcard_normal_command SD             SEND_CSD/
CMD09 arg 0x45670000 (state standby)
Detected: 32768 blocks of 512 bytes (16MB) SD card.
Vendor: Man aa OEM XY "QEMU!" Date 02/2006
Product: 3735928559
Revision: 0.1
5366@1514908231.664080:sdcard_normal_command SD SELECT/DESELECT_CARD/
CMD07 arg 0x45670000 (state standby)
5366@1514908231.664168:sdcard_app_command SD
SET_BUS_WIDTH/ACMD06 arg 0x00000002 (state transfer)
5366@1514908231.664568:sdcard_normal_command SD         SET_BLOCKLEN/
CMD16 arg 0x00000200 (state transfer)
5366@1514908231.664642:sdcard_normal_command SD    READ_SINGLE_BLOCK/
CMD17 arg 0x00000000 (state transfer)
5366@1514908231.664648:sdcard_read_block addr 0x0 size 0x200
GUM>

Ok this might be useful, however this board is supposed to have the card
plugged in MMC mode which is not yet modelled. We'll can still use it to
test the SD protocol! Good.

Let's write a MMC qtest adapter using this MMIO device.
We have to follow the datashit state machines change, [........]

3 days later: I still didn't succeed to reproduce U-Boot SD commands.
Bad choice, this wasn't probably the easiest HCI.

Let's try with another one.


What about this simple SPI mode modelled in hw/sd/ssi-sd.c?

$ git grep ssi-sd
hw/arm/stellaris.c:1377:  sddev =3D ssi_create_slave(bus, "ssi-sd");

Cool, let's use the lm3s6965evb machine.
[...] write SPI test [...]

[...] implement the qtest SD SPI adapter [...]
test it!
not working, the bus is never accessed... :(

After a few debugging, it seems we correctly MMIO access the PL022 but
then our sdcard isn't responding, why?

Looking at the monitor:

$ arm-softmmu/qemu-system-arm -M lm3s6965evb -monitor stdio \
  -drive if=3Dsd,cache=3Dunsafe,file=3D/tmp/ok -accel qtest
(qemu) info qtree
bus: main-system-bus
  type System
  dev: pl022, id ""
    gpio-out "sysbus-irq" 1
    mmio 0000000040008000/0000000000001000
    bus: ssi
      type SSI
      dev: ssd0323, id ""
        gpio-in "" 1
        gpio-in "ssi-gpio-cs" 1
      dev: ssi-sd, id ""
        gpio-in "ssi-gpio-cs" 1

Where is dangling our sdcard?...

Looking at the code, stellaris_init() never use a SD card.

I suppose the code using ssi-sd.c was lost during some refactor, we'll
look later in git history, for now let's add the missing code to
plug/use our card.
[...]

(qemu) info qtree
bus: main-system-bus
  type System
  dev: pl022, id ""
    gpio-out "sysbus-irq" 1
    mmio 0000000040008000/0000000000001000
    bus: ssi
      type SSI
      dev: ssd0323, id ""
        gpio-in "" 1
        gpio-in "ssi-gpio-cs" 1
      dev: ssi-sd, id ""
        gpio-in "ssi-gpio-cs" 1
        bus: sd-bus
          type sd-bus
          dev: sd-card, id ""
            drive =3D "sd0"
            spi =3D true

Cool, our card is here! Now run qtests!

Oops, many many failures...
Again, probably nobody used the sdcard code in SPI mode since age.

Remember, I try to have a working card to test the generic SDHCI to
implement the v3...
This SPI mode could have been the simpler way to test the card if it was
working but it isn't, no time for that.

Let's drop our MMC and SPI tests and find some working board using the
SD mode.


Ok we have the nuri board (exynos4210), with a SDHCI v2.
Hmm but wait ... Am I going to test the card with the HCI I want to
test? ...

Ok, clock is ticking, let's forget about using HCI via MMIO and try
again our first idea, access the _bus_ via QMP!
[... lot of fun trying with qobjects, qobject_to_qdict, qlist =3D
qdict_get(), qobject_to_qstring, qstring_get_str, ...]
4 days. lots of leaks, not enough QDECREF()?
2 days. What am I doing with valgrind? I'm supposed to spend time on the
SDHCI model.
Let's ignore those leaks, and run the test.

Plug a card. We need a Spec v3 working to plug a SDXC card, but smaller
cards are supposed to work.
Let's test the easiest, the smaller card!
Plug a SDSC card: tests fail.... Oh, SDSC support broken for cards
between 1G-2G. Now I remember and understand the warning I read when
preparing the first Connex card:
"The current qemu version seems to be limited to 1GB card images." [1]

Luckily the SDHC cards work better, cool! let's start working!
Oh but wait which day is it...?! The deadline is over, I'm out of
schedule, too late.
No time to write more qtests, I'll just run the first python sample test
and send the series as it :(

Regards,

Phil.

https://wiki.gumstix.com/index.php/Making_qemu_images#mmc.2FCF_images



--5D817ZYTAZn9H3q0OFXo77dENaWpkY8Pl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpLtgoACgkQ4+MsLN6t
wN5GlQ//RiCkIofJ2pnR2ljcTcafL9eKciuIrI6i7EzfbWMYtuF97XH1V/xWhkQU
LvCTVWotrskRk/l6ZxdQEC2uRccb7yA9AS0CbvB0/zG1xwP2AlazuLWZ6bQQv+it
BTQXfKmbQqGxBK0d1UMe1U038eRW51IzazY5bJebqSDXx4JDtHoiVIX0yjtLmCJT
zHXK5mwo8GtyAXvWD04mG+KCNncaRBGd/Q7jCiJi6eTHuN+E6dxxEtAwwQFYT9jt
OVvewT49Ev5NpUd8jQxsa9dX/9+pliU/62+h5m9C8M2hAwpEDsN+MDiw8vi86D3G
5j+qXnVokW/vN9V+uND7M1zSo+LGXFDTkK7qAeYNu2kpPFs839sbUzTYqFtm46A7
bm4dF3UtPE+ogggKSMsGPBqsNuTLYJpPYICvgt5bCKgr51FvmySb0z/LqkHXomO9
wPAnVsdbOwuxT3yJc9tfbrSBkY7DaT3UlS/nNjOFimQXhXSY6EGG05pBd0wEU1tS
lFsZAKwn6bTWQ4v4XG0nUlec6lCDaCs7lLXjL2L9ZuclMGsL6uKSCorl7xiu1iB0
UteZqIrgyziSfnf4+dP+5DE+6f3JNYZbjuVdDBqDEzlM4AfNSUp/QS3ro+Tfpzpu
GgOfTcVyFAsl8UcAEWTc+x8rVG1eGh4g8kTjoARFrVpTW11BWC4=
=bHjY
-----END PGP SIGNATURE-----

--5D817ZYTAZn9H3q0OFXo77dENaWpkY8Pl--
