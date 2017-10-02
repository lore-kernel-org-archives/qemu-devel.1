Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dz1SC-0005MQ-6T
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dz1S8-0002vv-22
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:16 -0400
Date: Mon, 2 Oct 2017 10:11:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171002141128.GE32241@stefanha-x1.localdomain>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<4ad78c1162706cd67654b2ad08daa1b5d5f8f9f1.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad78c1162706cd67654b2ad08daa1b5d5f8f9f1.1506730372.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/47] Replace all occurances of
 __FUNCTION__ with __func__
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 05:14:58PM -0700, Alistair Francis wrote:
> Replace all occurs of __FUNCTION__ except for the check in checkpatch
> with the non GCC specific __func__.
> 
> One line in hcd-musb.c was manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> 
>  audio/audio_int.h          |  2 +-
>  hw/arm/nseries.c           |  2 +-
>  hw/arm/omap1.c             | 42 +++++++++++++++++++++---------------------
>  hw/arm/omap2.c             | 12 ++++++------
>  hw/arm/palm.c              | 14 +++++++-------
>  hw/arm/pxa2xx.c            | 46 +++++++++++++++++++++++-----------------------
>  hw/arm/pxa2xx_gpio.c       |  6 +++---
>  hw/arm/pxa2xx_pic.c        |  4 ++--
>  hw/arm/tosa.c              | 10 +++++-----
>  hw/audio/hda-codec.c       | 10 +++++-----
>  hw/audio/intel-hda.c       | 28 ++++++++++++++--------------
>  hw/audio/wm8750.c          |  4 ++--
>  hw/block/nand.c            |  4 ++--
>  hw/block/onenand.c         |  8 ++++----
>  hw/bt/core.c               | 10 +++++-----
>  hw/bt/hci-csr.c            | 14 +++++++-------
>  hw/bt/hci.c                | 26 +++++++++++++-------------
>  hw/bt/hid.c                |  2 +-
>  hw/bt/l2cap.c              | 22 +++++++++++-----------
>  hw/bt/sdp.c                |  6 +++---
>  hw/display/blizzard.c      | 18 +++++++++---------
>  hw/display/omap_dss.c      |  6 +++---
>  hw/display/pxa2xx_lcd.c    | 14 +++++++-------
>  hw/display/qxl-render.c    |  6 +++---
>  hw/display/qxl.h           |  2 +-
>  hw/display/tc6393xb.c      |  2 +-
>  hw/display/xenfb.c         |  2 +-
>  hw/dma/omap_dma.c          | 26 +++++++++++++-------------
>  hw/dma/pxa2xx_dma.c        | 14 +++++++-------
>  hw/gpio/max7310.c          |  8 ++++----
>  hw/gpio/omap_gpio.c        |  2 +-
>  hw/i2c/omap_i2c.c          |  6 +++---
>  hw/ide/ahci.c              |  2 +-
>  hw/ide/microdrive.c        |  4 ++--
>  hw/input/lm832x.c          |  6 +++---
>  hw/input/pxa2xx_keypad.c   |  6 +++---
>  hw/input/tsc2005.c         |  8 ++++----
>  hw/input/tsc210x.c         |  4 ++--
>  hw/intc/omap_intc.c        |  2 +-
>  hw/isa/vt82c686.c          |  2 +-
>  hw/mips/gt64xxx_pci.c      |  2 +-
>  hw/misc/cbus.c             | 12 ++++++------
>  hw/misc/omap_clk.c         |  4 ++--
>  hw/misc/omap_gpmc.c        |  6 +++---
>  hw/misc/omap_l4.c          |  4 ++--
>  hw/misc/omap_sdrc.c        |  2 +-
>  hw/misc/omap_tap.c         |  6 +++---
>  hw/misc/tmp105.c           |  2 +-
>  hw/pci-host/bonito.c       |  2 +-
>  hw/sd/pxa2xx_mmci.c        |  6 +++---
>  hw/ssi/omap_spi.c          |  6 +++---
>  hw/timer/omap_gptimer.c    |  6 +++---
>  hw/timer/twl92230.c        |  6 +++---
>  hw/usb/desc.c              |  2 +-
>  hw/usb/dev-bluetooth.c     |  4 ++--
>  hw/usb/hcd-musb.c          |  4 ++--
>  hw/usb/tusb6010.c          | 14 +++++++-------
>  hw/xenpv/xen_domainbuild.c | 16 ++++++++--------
>  hw/xenpv/xen_machine_pv.c  |  2 +-
>  include/hw/arm/omap.h      | 10 +++++-----
>  include/hw/arm/sharpsl.h   |  2 +-
>  memory_mapping.c           |  2 +-
>  migration/block.c          |  4 ++--
>  ui/cursor.c                |  6 +++---
>  ui/spice-display.c         |  4 ++--
>  65 files changed, 273 insertions(+), 273 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
