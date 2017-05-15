Received: from eggs.gnu.org ([2001:4830:134:3::10]:35739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dAJ9e-0000hS-Bd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dAJ9d-0002VZ-6f
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:47:30 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <757990479.60759.1494722527715@mail.yahoo.com>
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
	<757990479.60759.1494722527715@mail.yahoo.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 15 May 2017 09:46:57 -0700
Message-ID: <CAKmqyKPy35OuMkixGnDXOvApAu82uXrtQStSz4GzHNRStdFFNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: John Bradley <flypie1@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

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
> .gitignore                           |   54 ++
> hw/arm/Makefile.objs                 |    2 +-
> hw/arm/bcm2835.c                     |  114 ++++
> hw/arm/bcm2835_peripherals.c         |  104 ++++
> hw/arm/bcm2836.c                     |    3 +-
> hw/arm/raspi.c                       |   77 ++-
> hw/gpio/bcm2835_gpio.c               |  333 ++++++-----
> hw/misc/Makefile.objs                |    2 +
> hw/misc/bcm2835_mphi.c               |  163 ++++++
> hw/misc/bcm2835_power.c              |  106 ++++
> hw/timer/Makefile.objs               |    2 +
> hw/timer/bcm2835_st.c                |  202 +++++++
> hw/timer/bcm2835_timer.c             |  224 +++++++
> hw/usb/Makefile.objs                 |    4 +-
> hw/usb/bcm2835_usb.c                 |  604 +++++++++++++++++++
> hw/usb/bcm2835_usb_regs.h            | 1061 ++++++++++++++++++++++++++++++++++
> hw/usb/dev-network.c                 |    2 +-
> include/hw/arm/bcm2835.h             |   37 ++
> include/hw/arm/bcm2835_peripherals.h |   10 +
> include/hw/gpio/bcm2835_gpio.h       |    5 +
> include/hw/intc/bcm2835_control.h    |   53 ++
> include/hw/intc/bcm2836_control.h    |    2 +
> include/hw/misc/bcm2835_mphi.h       |   28 +
> include/hw/misc/bcm2835_power.h      |   22 +
> include/hw/timer/bcm2835_st.h        |   25 +
> include/hw/timer/bcm2835_timer.h     |   32 +
> include/hw/usb/bcm2835_usb.h         |   78 +++
> include/qemu/PanelEmu.h              |   53 ++
> util/Makefile.objs                   |    1 +
> util/PanelEmu.c                      |  293 ++++++++++
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
