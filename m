Received: from eggs.gnu.org ([2001:4830:134:3::10]:51396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAK96-0004oJ-QU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAK92-0004mv-OU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:51:00 -0400
Received: from nm10-vm8.bullet.mail.ir2.yahoo.com ([212.82.96.160]:45306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dAK92-0004lP-3w
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:50:56 -0400
Date: Mon, 15 May 2017 17:50:47 +0000 (UTC)
From: John Bradley <flypie1@yahoo.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <1337329283.3100470.1494870647989@mail.yahoo.com>
In-Reply-To: <CAKmqyKPy35OuMkixGnDXOvApAu82uXrtQStSz4GzHNRStdFFNA@mail.gmail.com>
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
	<757990479.60759.1494722527715@mail.yahoo.com>
	<CAKmqyKPy35OuMkixGnDXOvApAu82uXrtQStSz4GzHNRStdFFNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Changes to Broadcom(BCM) files and Raspberry Pi
 files. Addition of PanelEmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi,
That is going to be very difficult as a lot of the changes are interlinked =
the vast majority of the patch is new files.=C2=A0John BradleyTel: 07896 83=
9635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF=20

    On Monday, 15 May 2017, 17:54, Alistair Francis <alistair.francis@xilin=
x.com> wrote:
=20

 On Sat, May 13, 2017 at 5:42 PM, John Bradley via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> From 7f74f048f135d9c9c230a9e90f72451c841c6d35 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Sat, 13 May 2017 23:07:47 +0100
> Subject: [PATCH] Changes to Broadcom(BCM) files and Raspberry Pi files.
> Addition of PanelEmu
>
> The files add the ability to attach, via TCP, a panel emulator
> The include a unification of several PD Raspberry PI additions
> A modification to dev-network to all circle SDK WWW client to work
> The DummyPanel is not included but available at
> https://github.com/flypie/GDummyPanel.git
>
> Signed-off-by: John Bradley <flypie@rocketmail.com>

Hey John,

Thanks for the patch!

Unfortunately this patch is too long to review, you need to split the
patch up into shorter more readable patches. Otherwise it's too hard
to people to understand what you are changing and why.

There are some details here:
http://wiki.qemu.org/Contribute/SubmitAPatch about how to split up
patches. Each patch applied in order shouldn't break any compilation
or runtime. Generally the flow is to add the logic in earlier patches
and then connect it and switch it on in the later patches.

Try splitting up adding/editing each individual device and send that
our first. That is generally the easiest to review/accept.

Thanks,

Alistair

> ---
> .gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 54 ++
> hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +-
> hw/arm/bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 114 ++++
> hw/arm/bcm2835_peripherals.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 104 ++++
> hw/arm/bcm2836.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-
> hw/arm/raspi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 77 ++-
> hw/gpio/bcm2835_gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 333 ++++++-----
> hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +
> hw/misc/bcm2835_mphi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 163 ++++++
> hw/misc/bcm2835_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 106 ++++
> hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 2 +
> hw/timer/bcm2835_st.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 202 +++++++
> hw/timer/bcm2835_timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 224 +++++++
> hw/usb/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 4 +-
> hw/usb/bcm2835_usb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 604 +++++++++++++++++++
> hw/usb/bcm2835_usb_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1061=
 ++++++++++++++++++++++++++++++++++
> hw/usb/dev-network.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +-
> include/hw/arm/bcm2835.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 37 ++
> include/hw/arm/bcm2835_peripherals.h |=C2=A0 10 +
> include/hw/gpio/bcm2835_gpio.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +
> include/hw/intc/bcm2835_control.h=C2=A0 =C2=A0 |=C2=A0 53 ++
> include/hw/intc/bcm2836_control.h=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +
> include/hw/misc/bcm2835_mphi.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 +
> include/hw/misc/bcm2835_power.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 +
> include/hw/timer/bcm2835_st.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +
> include/hw/timer/bcm2835_timer.h=C2=A0 =C2=A0 |=C2=A0 32 +
> include/hw/usb/bcm2835_usb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 78 +++
> include/qemu/PanelEmu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 53 ++
> util/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A0 1 +
> util/PanelEmu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 293 ++++++++++
> 30 files changed, 3547 insertions(+), 149 deletions(-)
> create mode 100644 hw/arm/bcm2835.c
> create mode 100644 hw/misc/bcm2835_mphi.c
> create mode 100644 hw/misc/bcm2835_power.c
> create mode 100644 hw/timer/bcm2835_st.c
> create mode 100644 hw/timer/bcm2835_timer.c
> create mode 100644 hw/usb/bcm2835_usb.c
> create mode 100644 hw/usb/bcm2835_usb_regs.h
> create mode 100644 include/hw/arm/bcm2835.h
> create mode 100644 include/hw/intc/bcm2835_control.h
> create mode 100644 include/hw/misc/bcm2835_mphi.h
> create mode 100644 include/hw/misc/bcm2835_power.h
> create mode 100644 include/hw/timer/bcm2835_st.h
> create mode 100644 include/hw/timer/bcm2835_timer.h
> create mode 100644 include/hw/usb/bcm2835_usb.h
> create mode 100644 include/qemu/PanelEmu.h
> create mode 100644 util/PanelEmu.c
>


  =20
