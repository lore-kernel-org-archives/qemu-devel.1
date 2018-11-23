Received: from eggs.gnu.org ([2001:4830:134:3::10]:59056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQF-0004vB-WC
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ7-0005Op-64
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:11 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 23:30:19 +0800
Message-Id: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 00/21] QOM'ify SysBusDeviceClass->init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, alistair.francis@wdc.com, anthony.perard@citrix.com, armbru@redhat.com, borntraeger@de.ibm.com, chouteau@adacore.com, cohuck@redhat.com, david@gibson.dropbear.id.au, david@redhat.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, f4bug@amsat.org, gxt@mprc.pku.edu.cn, jan.kiszka@web.de, kraxel@redhat.com, kwolf@redhat.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, michael@walle.cc, mreitz@redhat.com, mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org, rth@twiddle.net, sstabellini@kernel.org, thuth@redhat.com, xen-devel@lists.xenproject.org

The SysBusDeviceClass::init() interface is considered
as a legacy interface and there are currently some
efforts going on to get rid of it. Thus convert 
SysBusDeviceClass::init to DeviceClass::realize.

v2 -> v1:

- SYS_BUS_DEVICE(dev) was used in a function several
  times, so use a variable 'sbd' to replace it, like:
  SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
- remove the xen_sysdev_init() function
- drop the patch21 in v1
- fix the broken in sysbus_realize of patch22


Cc: alistair.francis@wdc.com
Cc: anthony.perard@citrix.com
Cc: armbru@redhat.com
Cc: borntraeger@de.ibm.com
Cc: chouteau@adacore.com
Cc: cohuck@redhat.com
Cc: david@gibson.dropbear.id.au
Cc: david@redhat.com
Cc: edgar.iglesias@gmail.com
Cc: ehabkost@redhat.com
Cc: f4bug@amsat.org
Cc: gxt@mprc.pku.edu.cn
Cc: jan.kiszka@web.de
Cc: kraxel@redhat.com
Cc: kwolf@redhat.com
Cc: marcandre.lureau@redhat.com
Cc: marcel.apfelbaum@gmail.com
Cc: michael@walle.cc
Cc: mreitz@redhat.com
Cc: mst@redhat.com
Cc: pbonzini@redhat.com
Cc: peter.maydell@linaro.org
Cc: peter.maydell@linaro.org                                                                                                                                                                  
Cc: qemu-arm@nongnu.org
Cc: qemu-block@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org
Cc: rth@twiddle.net
Cc: sstabellini@kernel.org
Cc: thuth@redhat.com
Cc: xen-devel@lists.xenproject.org

Mao Zhongyi (21):
  musicpal: Convert sysbus init function to realize function
  block/noenand: Convert sysbus init function to realize function
  char/grlib_apbuart: Convert sysbus init function to realize function
  core/empty_slot: Convert sysbus init function to realize function
  display/g364fb: Convert sysbus init function to realize function
  dma/puv3_dma: Convert sysbus init function to realize function
  gpio/puv3_gpio: Convert sysbus init function to realize function
  milkymist-softusb: Convert sysbus init function to realize function
  input/pl050: Convert sysbus init function to realize function
  intc/puv3_intc: Convert sysbus init function to realize function
  milkymist-hpdmc: Convert sysbus init function to realize function
  milkymist-pfpu: Convert sysbus init function to realize function
  puv3_pm.c: Convert sysbus init function to realize function
  nvram/ds1225y: Convert sysbus init function to realize function
  pci-bridge/dec: Convert sysbus init function to realize function
  timer/etraxfs_timer: Convert sysbus init function to realize function
  timer/grlib_gptimer: Convert sysbus init function to realize function
  timer/puv3_ost: Convert sysbus init function to realize function
  usb/tusb6010: Convert sysbus init function to realize function
  xen_backend: remove xen_sysdev_init() function
  core/sysbus: remove the SysBusDeviceClass::init path

 hw/arm/musicpal.c            |  9 ++++-----
 hw/block/onenand.c           | 16 +++++++---------
 hw/char/grlib_apbuart.c      | 12 +++++-------
 hw/core/empty_slot.c         |  9 ++++-----
 hw/core/sysbus.c             | 15 +++++----------
 hw/display/g364fb.c          |  9 +++------
 hw/dma/puv3_dma.c            | 10 ++++------
 hw/gpio/puv3_gpio.c          | 29 ++++++++++++++---------------
 hw/input/milkymist-softusb.c | 16 +++++++---------
 hw/input/pl050.c             | 11 +++++------
 hw/intc/puv3_intc.c          | 11 ++++-------
 hw/misc/milkymist-hpdmc.c    |  9 +++------
 hw/misc/milkymist-pfpu.c     | 12 +++++-------
 hw/misc/puv3_pm.c            | 10 ++++------
 hw/nvram/ds1225y.c           | 12 +++++-------
 hw/pci-bridge/dec.c          | 11 +++++------
 hw/timer/etraxfs_timer.c     | 14 +++++++-------
 hw/timer/grlib_gptimer.c     | 11 +++++------
 hw/timer/puv3_ost.c          | 13 ++++++-------
 hw/usb/tusb6010.c            |  8 +++-----
 hw/xen/xen_backend.c         |  7 -------
 include/hw/sysbus.h          |  3 ---
 22 files changed, 105 insertions(+), 152 deletions(-)

-- 
2.17.1
