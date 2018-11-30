Received: from eggs.gnu.org ([2001:4830:134:3::10]:57317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSm7F-0003d1-EQ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSm7D-0004XB-QE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:58:09 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSm7D-0004Wa-Hs
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:58:07 -0500
Received: by mail-ot1-x342.google.com with SMTP id n8so1845380otl.6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:57:55 +0000
Message-ID: <CAFEAcA_OF=58BwNdUeRVuK72XenY7bPLk0VVrYop4+C4A0wL_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/21] QOM'ify SysBusDeviceClass->init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>, Anthony PERARD <anthony.perard@citrix.com>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fabien Chouteau <chouteau@adacore.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Michael Walle <michael@walle.cc>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Thomas Huth <thuth@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, 30 Nov 2018 at 09:39, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
>
> v3 -> v2:
>
> - rebase to the HEAD
> - use SysBusDevice *sbd variable in patch15

> Mao Zhongyi (21):
>   musicpal: Convert sysbus init function to realize function
>   block/noenand: Convert sysbus init function to realize function
>   char/grlib_apbuart: Convert sysbus init function to realize function
>   core/empty_slot: Convert sysbus init function to realize function
>   display/g364fb: Convert sysbus init function to realize function
>   dma/puv3_dma: Convert sysbus init function to realize function
>   gpio/puv3_gpio: Convert sysbus init function to realize function
>   milkymist-softusb: Convert sysbus init function to realize function
>   input/pl050: Convert sysbus init function to realize function
>   intc/puv3_intc: Convert sysbus init function to realize function
>   milkymist-hpdmc: Convert sysbus init function to realize function
>   milkymist-pfpu: Convert sysbus init function to realize function
>   puv3_pm.c: Convert sysbus init function to realize function
>   nvram/ds1225y: Convert sysbus init function to realize function
>   pci-bridge/dec: Convert sysbus init function to realize function
>   timer/etraxfs_timer: Convert sysbus init function to realize function
>   timer/grlib_gptimer: Convert sysbus init function to realize function
>   timer/puv3_ost: Convert sysbus init function to realize function
>   usb/tusb6010: Convert sysbus init function to realize function
>   xen_backend: remove xen_sysdev_init() function
>   core/sysbus: remove the SysBusDeviceClass::init path
>
>  hw/arm/musicpal.c            |  9 ++++-----
>  hw/block/onenand.c           | 16 +++++++---------
>  hw/char/grlib_apbuart.c      | 12 +++++-------
>  hw/core/empty_slot.c         |  9 ++++-----
>  hw/core/sysbus.c             | 15 +++++----------
>  hw/display/g364fb.c          |  9 +++------
>  hw/dma/puv3_dma.c            | 10 ++++------
>  hw/gpio/puv3_gpio.c          | 29 ++++++++++++++---------------
>  hw/input/milkymist-softusb.c | 16 +++++++---------
>  hw/input/pl050.c             | 11 +++++------
>  hw/intc/puv3_intc.c          | 11 ++++-------
>  hw/misc/milkymist-hpdmc.c    |  9 +++------
>  hw/misc/milkymist-pfpu.c     | 12 +++++-------
>  hw/misc/puv3_pm.c            | 10 ++++------
>  hw/nvram/ds1225y.c           | 12 +++++-------
>  hw/pci-bridge/dec.c          | 12 ++++++------
>  hw/timer/etraxfs_timer.c     | 14 +++++++-------
>  hw/timer/grlib_gptimer.c     | 11 +++++------
>  hw/timer/puv3_ost.c          | 13 ++++++-------
>  hw/usb/tusb6010.c            |  8 +++-----
>  hw/xen/xen_backend.c         |  7 -------
>  include/hw/sysbus.h          |  3 ---
>  22 files changed, 106 insertions(+), 152 deletions(-)

I think all these patches have now been reviewed. Does anybody
have a preference for which tree it goes through, given that it
touches lots of devices?

I can take this via target-arm, unless anybody would particularly
like to have some or all of it go some other route.

thanks
-- PMM
