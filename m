Received: from eggs.gnu.org ([2001:4830:134:3::10]:38483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dwgul-0003dz-GN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dwguj-0001ZV-Rl
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:52:07 -0400
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<bf3dd056ce55cbea81ca762c3c40d22683a542e7.1506384414.git.alistair.francis@xilinx.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <1d317e5b-9de9-9186-1c00-573ca96f3d25@tuxfamily.org>
Date: Tue, 26 Sep 2017 05:51:44 +0200
MIME-Version: 1.0
In-Reply-To: <bf3dd056ce55cbea81ca762c3c40d22683a542e7.1506384414.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/8] hw: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Marek Vasut <marex@denx.de>, Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>, qemu-block@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Stefan Hajnoczi <stefanha@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, alistair23@gmail.com, Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>, Thomas Huth <huth@tuxfamily.org>, Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 26.09.2017 02:08, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: Anthony Green <green@moxielogic.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jia Liu <proljc@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> Cc: qemu-ppc@nongnu.org
> ---
> 
>  hw/arm/armv7m.c                 |  2 +-
>  hw/arm/boot.c                   | 34 +++++++++----------
>  hw/arm/gumstix.c                | 13 ++++----
>  hw/arm/mainstone.c              |  7 ++--
>  hw/arm/musicpal.c               |  2 +-
>  hw/arm/omap1.c                  |  5 +--
>  hw/arm/omap2.c                  | 21 ++++++------
>  hw/arm/omap_sx1.c               |  6 ++--
>  hw/arm/palm.c                   | 10 +++---
>  hw/arm/pxa2xx.c                 |  7 ++--
>  hw/arm/stellaris.c              |  3 +-
>  hw/arm/tosa.c                   | 17 +++++-----
>  hw/arm/versatilepb.c            |  2 +-
>  hw/arm/vexpress.c               |  8 ++---
>  hw/arm/z2.c                     |  6 ++--
>  hw/block/dataplane/virtio-blk.c |  6 ++--
>  hw/block/onenand.c              |  8 ++---
>  hw/block/tc58128.c              | 44 ++++++++++++-------------
>  hw/bt/core.c                    | 15 +++++----
>  hw/bt/hci-csr.c                 | 17 +++++-----
>  hw/bt/hci.c                     | 30 ++++++++---------
>  hw/bt/hid.c                     |  2 +-
>  hw/bt/l2cap.c                   | 47 ++++++++++++++-------------
>  hw/bt/sdp.c                     |  7 ++--
>  hw/char/exynos4210_uart.c       |  6 ++--
>  hw/char/mcf_uart.c              |  5 +--
>  hw/char/sh_serial.c             |  9 +++---
>  hw/core/loader.c                | 31 +++++++++---------
>  hw/core/ptimer.c                |  7 ++--
>  hw/cris/axis_dev88.c            |  3 +-
>  hw/cris/boot.c                  |  5 +--
>  hw/display/blizzard.c           | 20 ++++++------
>  hw/display/omap_dss.c           | 14 ++++----
>  hw/display/pl110.c              |  2 +-
>  hw/display/pxa2xx_lcd.c         |  2 +-
>  hw/display/qxl-render.c         |  7 ++--
>  hw/display/qxl.c                | 10 +++---
>  hw/display/tc6393xb.c           | 36 ++++++++++++---------
>  hw/display/virtio-gpu-3d.c      |  4 +--
>  hw/display/vmware_vga.c         | 22 ++++++-------
>  hw/dma/omap_dma.c               | 26 ++++++++-------
>  hw/dma/soc_dma.c                | 37 ++++++++++-----------
>  hw/gpio/omap_gpio.c             |  2 +-
>  hw/i2c/omap_i2c.c               | 10 +++---
>  hw/i386/kvm/apic.c              |  9 +++---
>  hw/i386/kvm/clock.c             |  7 ++--
>  hw/i386/kvm/i8254.c             |  7 ++--
>  hw/i386/kvm/i8259.c             |  5 +--
>  hw/i386/kvm/ioapic.c            |  5 +--
>  hw/i386/multiboot.c             | 21 ++++++------
>  hw/i386/pc.c                    | 18 +++++------
>  hw/i386/pc_piix.c               |  2 +-
>  hw/i386/pc_sysfw.c              |  5 +--
>  hw/i386/xen/xen-hvm.c           | 32 +++++++++---------
>  hw/i386/xen/xen-mapcache.c      | 12 +++----
>  hw/i386/xen/xen_apic.c          |  2 +-
>  hw/ide/ahci.c                   |  6 ++--
>  hw/ide/core.c                   |  2 +-
>  hw/input/lm832x.c               |  6 ++--
>  hw/input/pckbd.c                |  3 +-
>  hw/input/pxa2xx_keypad.c        |  2 +-
>  hw/input/tsc2005.c              | 17 +++++-----
>  hw/input/tsc210x.c              | 72 ++++++++++++++++++++---------------------
>  hw/input/virtio-input-hid.c     | 14 ++++----
>  hw/input/virtio-input.c         |  5 +--
>  hw/intc/arm_gic_kvm.c           | 12 +++----
>  hw/intc/omap_intc.c             |  4 +--
>  hw/intc/openpic.c               |  7 ++--
>  hw/intc/openpic_kvm.c           |  8 ++---
>  hw/intc/s390_flic_kvm.c         |  4 +--
>  hw/ipmi/ipmi.c                  |  1 +
>  hw/ipmi/ipmi_bmc_extern.c       |  5 +--
>  hw/isa/isa-bus.c                |  7 ++--
>  hw/lm32/lm32_boards.c           |  5 +--
>  hw/lm32/milkymist.c             |  5 +--
>  hw/m68k/an5206.c                |  4 +--
>  hw/m68k/mcf5206.c               |  3 +-
>  hw/m68k/mcf5208.c               |  7 ++--
>  hw/microblaze/boot.c            |  2 +-
>  hw/mips/boston.c                |  4 +--
>  hw/mips/mips_fulong2e.c         |  4 +--
>  hw/mips/mips_jazz.c             |  4 +--
>  hw/mips/mips_malta.c            |  4 +--
>  hw/mips/mips_mipssim.c          |  4 +--
>  hw/mips/mips_r4k.c              |  6 ++--
>  hw/misc/a9scu.c                 |  3 +-
>  hw/misc/omap_gpmc.c             | 11 ++++---
>  hw/misc/omap_l4.c               |  5 +--
>  hw/misc/omap_sdrc.c             |  3 +-
>  hw/misc/vmport.c                |  2 +-
>  hw/moxie/moxiesim.c             |  7 ++--
>  hw/net/fsl_etsec/etsec.c        |  2 +-
>  hw/net/pcnet.c                  |  2 +-
>  hw/net/smc91c111.c              |  5 +--
>  hw/net/vhost_net.c              | 16 ++++-----
>  hw/nios2/boot.c                 |  2 +-
>  hw/nvram/eeprom93xx.c           |  5 +--
>  hw/nvram/fw_cfg.c               |  4 +--
>  hw/openrisc/openrisc_sim.c      |  3 +-
>  hw/pci-host/bonito.c            |  6 ++--
>  hw/pci/pci.c                    | 10 +++---
>  hw/ppc/e500.c                   | 20 ++++++------
>  hw/ppc/mac_newworld.c           |  2 +-
>  hw/ppc/mac_oldworld.c           |  2 +-
>  hw/ppc/mpc8544_guts.c           |  5 +--
>  hw/ppc/ppc405_boards.c          |  8 ++---
>  hw/ppc/ppc440_bamboo.c          | 19 +++++------
>  hw/ppc/ppc4xx_pci.c             |  3 +-
>  hw/ppc/prep.c                   |  4 +--
>  hw/ppc/virtex_ml507.c           |  4 +--
>  hw/s390x/virtio-ccw.c           |  2 +-
>  hw/scsi/lsi53c895a.c            |  4 +--
>  hw/scsi/spapr_vscsi.c           | 49 ++++++++++++++--------------
>  hw/scsi/virtio-scsi-dataplane.c |  6 ++--
>  hw/sd/pl181.c                   |  5 +--
>  hw/sd/sd.c                      | 14 ++++----
>  hw/sh4/r2d.c                    |  9 +++---
>  hw/sh4/sh7750.c                 | 64 ++++++++++++++++++------------------
>  hw/sparc/leon3.c                |  9 +++---
>  hw/sparc/sun4m.c                |  8 ++---
>  hw/sparc64/niagara.c            |  2 +-
>  hw/sparc64/sun4u.c              |  9 +++---
>  hw/ssi/omap_spi.c               |  5 +--
>  hw/timer/omap_gptimer.c         | 11 ++++---
>  hw/timer/twl92230.c             |  2 +-
>  hw/timer/xilinx_timer.c         |  8 ++---
>  hw/usb/core.c                   | 15 +++++----
>  hw/usb/desc.c                   |  4 +--
>  hw/usb/dev-audio.c              | 29 +++++++++--------
>  hw/usb/dev-bluetooth.c          |  4 +--
>  hw/usb/dev-mtp.c                |  9 +++---
>  hw/usb/dev-network.c            | 20 ++++++------
>  hw/usb/hcd-ehci.c               | 32 +++++++++---------
>  hw/usb/hcd-musb.c               |  4 +--
>  hw/usb/hcd-xhci.c               |  3 +-
>  hw/usb/host-legacy.c            |  2 +-
>  hw/watchdog/watchdog.c          |  9 +++---
>  hw/watchdog/wdt_i6300esb.c      |  8 +++--
>  hw/xen/xen-common.c             | 10 +++---
>  hw/xen/xen_pt.c                 |  4 +--
>  hw/xenpv/xen_domainbuild.c      | 24 +++++++-------
>  hw/xenpv/xen_machine_pv.c       |  8 ++---
>  142 files changed, 769 insertions(+), 705 deletions(-)

This patch is IMHO way to big! Can you please break this down into the
individual hw/* subsystems, so that people who are familiar with a
certain subsystem have a chance to review just their part? Thanks.

 Thomas
