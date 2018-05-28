Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN9oW-0004Bc-Kw
	for qemu-devel@nongnu.org; Mon, 28 May 2018 00:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN9oV-0006r7-6k
	for qemu-devel@nongnu.org; Mon, 28 May 2018 00:31:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
Date: Mon, 28 May 2018 01:30:58 -0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="GZrjDPkwQ9UHphZR25lCf1REIrwqyJ8xp"
Subject: [Qemu-devel] cmdline: How to connect a SD card to a specific SD
 controller?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GZrjDPkwQ9UHphZR25lCf1REIrwqyJ8xp
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Message-ID: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
Subject: cmdline: How to connect a SD card to a specific SD controller?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to connect a specific SD card to a specific SDHCI from command
line, and I'm getting a bit lost with command line options.

I'm using an updated version of this patch, but this is not relevant to
this thread:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01914.html

In the following example, I'd like to connect an UHS-I enabled SD card
to the first SHDCI of the Exynos4210 board (Nuri).

I tried:

$ ./arm-softmmu/qemu-system-arm -M nuri \
  -device sd-card,id=3Dsd0,uhs=3D1 \
  -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D4G \
  -monitor stdio -S

But then the QTree looks unexpected:

(qemu) info qtree
bus: main-system-bus
  type System
  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 2 (0x2)
    uhs =3D 0 (0x0)
    capareg =3D 99090560 (0x5e80080)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma =3D ""
    mmio 0000000012540000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id "sd0"
        drive =3D ""
        spi =3D false
        uhs =3D 1 (0x1)
      dev: sd-card, id ""
        drive =3D ""
        spi =3D false
        uhs =3D 0 (0x0)

      ^---- 2 cards

  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 2 (0x2)
    uhs =3D 0 (0x0)
    capareg =3D 99090560 (0x5e80080)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma =3D ""
    mmio 0000000012530000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id ""
        drive =3D ""
        spi =3D false
        uhs =3D 0 (0x0)
  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 2 (0x2)
    uhs =3D 0 (0x0)
    capareg =3D 99090560 (0x5e80080)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma =3D ""
    mmio 0000000012520000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id ""
        drive =3D ""
        spi =3D false
        uhs =3D 0 (0x0)
  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 2 (0x2)
    uhs =3D 0 (0x0)
    capareg =3D 99090560 (0x5e80080)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma =3D ""
    mmio 0000000012510000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id ""
        drive =3D "sd0"

        ^------- drive is here

        spi =3D false
        uhs =3D 0 (0x0)

in hw/sd/core.c we have:

static SDState *get_card(SDBus *sdbus)
{
    /* We only ever have one child on the bus so just return it */
    BusChild *kid =3D QTAILQ_FIRST(&sdbus->qbus.children);

    if (!kid) {
        return NULL;
    }
    return SD_CARD(kid->child);
}

Spec v1 allow multiple cards per bus but Spec v2 (and up) restrict to 1
per bus.


in exynos4210_init() we have:

        di =3D drive_get(IF_SD, 0, n);
        blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
        carddev =3D qdev_create(qdev_get_child_bus(dev, "sd-bus"),
TYPE_SD_CARD);

so there are no restriction in connecting various slaves to the same bus.=


I also wonder about this drive_get(), is this an outdated API?

Only used in 3 boards:

$ git grep 'drive_get(IF_SD'
hw/arm/exynos4210.c:397:        di =3D drive_get(IF_SD, 0, n);
hw/arm/omap1.c:3990:    dinfo =3D drive_get(IF_SD, 0, 0);
hw/arm/omap2.c:2489:    dinfo =3D drive_get(IF_SD, 0, 0);
hw/arm/pxa2xx.c:2098:    dinfo =3D drive_get(IF_SD, 0, 0);
hw/arm/pxa2xx.c:2222:    dinfo =3D drive_get(IF_SD, 0, 0);

versus drive_get_next() used in others:

hw/arm/mcimx7d-sabre.c:70:        di =3D drive_get_next(IF_SD);
hw/arm/raspi.c:200:    di =3D drive_get_next(IF_SD);
hw/arm/xilinx_zynq.c:269:        di =3D drive_get_next(IF_SD);
hw/arm/xlnx-zcu102.c:114:        DriveInfo *di =3D drive_get_next(IF_SD);=

hw/sd/milkymist-memcard.c:279:    dinfo =3D drive_get_next(IF_SD);
hw/sd/pl181.c:508:    dinfo =3D drive_get_next(IF_SD);
hw/sd/ssi-sd.c:254:    dinfo =3D drive_get_next(IF_SD);

Now trying with the PC machine:

$ x86_64-softmmu/qemu-system-x86_64 -M pc \
  -device sdhci-pci,id=3Dsdhci1 \
  -device sdhci-pci,id=3Dsdhci2,sd-spec-version=3D3,uhs=3D2 \
  -device sd-card,id=3Dsdcard0 \
  -device sd-card,uhs=3D1,id=3Dsdcard1 \
  -monitor stdio -S

(qemu) info qtree
bus: main-system-bus
  type System
  dev: i440FX-pcihost, id ""
    bus: pci.0
      type PCI
      dev: sdhci-pci, id "sdhci2"
        sd-spec-version =3D 3 (0x3)
        uhs =3D 2 (0x2)
        capareg =3D 91763892 (0x57834b4)
        maxcurr =3D 0 (0x0)
        addr =3D 05.0
        romfile =3D ""
        rombar =3D 1 (0x1)
        multifunction =3D false
        command_serr_enable =3D true
        x-pcie-lnksta-dllla =3D true
        x-pcie-extcap-init =3D true
        class Class 0805, addr 00:05.0, pci id 1b36:0007 (sub 1af4:1100)
        bar 0: mem at 0xffffffffffffffff [0xfe]
        bus: sd-bus
          type sdhci-bus
          dev: sd-card, id "sdcard1"
            drive =3D ""
            spi =3D false
            uhs =3D 1 (0x1)
          dev: sd-card, id "sdcard0"
            drive =3D ""
            spi =3D false
            uhs =3D 0 (0x0)

          ^--- 2 cards...

      dev: sdhci-pci, id "sdhci1"
        sd-spec-version =3D 2 (0x2)
        uhs =3D 0 (0x0)
        capareg =3D 91763892 (0x57834b4)
        maxcurr =3D 0 (0x0)
        addr =3D 04.0
        romfile =3D ""
        rombar =3D 1 (0x1)
        multifunction =3D false
        command_serr_enable =3D true
        x-pcie-lnksta-dllla =3D true
        x-pcie-extcap-init =3D true
        class Class 0805, addr 00:04.0, pci id 1b36:0007 (sub 1af4:1100)
        bar 0: mem at 0xffffffffffffffff [0xfe]
        bus: sd-bus
          type sdhci-bus

        ^--- no card

And trying the -drive option:

$ x86_64-softmmu/qemu-system-x86_64 -M pc \
  -device sdhci-pci,id=3Dsdhci1 \
  -device sdhci-pci,id=3Dsdhci2,sd-spec-version=3D3,uhs=3D2 \
  -device sd-card,id=3Dsdcard0 \
  -device sd-card,uhs=3D1,id=3Dsdcard1 \
  -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D2G \
  -drive if=3Dsd,id=3Dsd1,driver=3Dnull-co,size=3D4G
qemu-system-x86_64: -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D2G: m=
achine
type does not support if=3Dsd,bus=3D0,unit=3D0
qemu-system-x86_64: -drive if=3Dsd,id=3Dsd1,driver=3Dnull-co,size=3D4G: m=
achine
type does not support if=3Dsd,bus=3D0,unit=3D1

How can I create the card with UHS-I enabled and connect it to the 2nd
SDHCI?

Thanks!

Phil.


--GZrjDPkwQ9UHphZR25lCf1REIrwqyJ8xp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsLhgIACgkQ4+MsLN6t
wN6MnhAAn7BOzUZOhdMJdobZwazn/mL8Vrqw99yNb1c/2ekGeVEDX6PiDZP1yEv2
aj8FH2Tc0xoJbupIzhIArmsc1Mb+b3nbceCJpunV3dwv/ht+RIZjRBK2tS9Vs0zr
HAB0iR2G55iI8/Fffc5rO5eARZSut9U1FQaVm6N97m4UfPEw6ds4oo7o7ilQKTqs
Z8FadfLH6gFy6lS1YoyM+vK5T5EDEYAbinP3AtXjlr7sXuJrhzbhcjE4niVooIau
dJhWQr71PSv7KFs/YqWHI5m+iMSwhCfpHviKj/RsR64irlgQhlFWCkBE5hfQ6x2z
7vhz8ldNhCwDBOUwiMmatu4PVbZiCUWZLqOXHlz127zuWpwzIQ4xr8cqvJSkT84+
qdS4LqFMZDftMPWa4myre3aPTgKdMpnfkiHzbS5g4czQl6QpgodMAKcHqEM980uN
jXwbcbaRbcgSk5cah88cwaXzDoODawcJJBCaKNOc7CEqeUpTKT59aLI0UKhR6Mjy
kAq0L+7jCLs48dPddSnaWekDXlwLvAA5C5CVsYde3xCgWu6ip2EHk+ftBPx/1/TL
vPsLK8Hl11h3Nt/RCsFbx0TYIH70TKUOiEPLhqBldXn//ttRMA+7HznKf7pVpIOF
pZjDipGZc12UPhkajfNDuTREG/2w8HhLD1qUZJS/u302C6MM0S0=
=SgiL
-----END PGP SIGNATURE-----

--GZrjDPkwQ9UHphZR25lCf1REIrwqyJ8xp--
