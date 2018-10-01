Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XW-00041R-GI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76O3-0007DM-W3
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:09:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76O3-0007D7-L6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:09:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 206-v6so276134wmb.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:09:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:27 +0200
Message-Id: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/15] another SysBusDevice::init to
 Device::realize cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Peter suggested [1] another crusade for this merge window,
then Cédric jumped on his horse [2]. My turn on my dromedary.

- convert few devices to DeviceState::realize,
- kill the empty_slot device,
- remove unuseful class_init() code [RFC, do we want to keep this?]
- few other minor fixes catched while editing

Regards,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03605.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00001.html

Philippe Mathieu-Daudé (15):
  trace-events: Fix copy/paste typo
  hw/timer/sun4v-rtc: Convert from DPRINTF() macro to trace events
  hw/timer/sun4v-rtc: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/ssi/xilinx_spi: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/sh4/sh_pci: Use DeviceState::realize rather than SysBusDevice::init
  hw/pci-host/bonito: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/mips/gt64xxx_pci: Convert gt64120_reset() function into Device
    reset method
  hw/mips/gt64xxx_pci: Mark as bridge device
  hw/mips/malta: Replace 'empty_slot' by 'unimplemented_device'
  hw/sparc64/niagara: Replace 'empty_slot' by 'unimplemented_device'
  hw/sparc/sun4m: Replace 'empty_slot' by 'unimplemented_device'
  hw/core: Remove the 'empty_slot' device
  hw/alpha/typhoon: Remove unuseful code
  hw/hppa/dino: Remove unuseful code
  hw/mips/malta: Remove unuseful code

 default-configs/mips-softmmu-common.mak |   1 -
 default-configs/sparc-softmmu.mak       |   1 -
 default-configs/sparc64-softmmu.mak     |   1 -
 include/hw/empty_slot.h                 |   7 --
 hw/alpha/typhoon.c                      |  13 ---
 hw/core/empty_slot.c                    | 103 ------------------------
 hw/hppa/dino.c                          |   7 --
 hw/mips/gt64xxx_pci.c                   |  18 +----
 hw/mips/mips_malta.c                    |  17 +---
 hw/pci-host/bonito.c                    |   9 +--
 hw/sh4/sh_pci.c                         |  20 +++--
 hw/sparc/sun4m.c                        |  24 +++---
 hw/sparc64/niagara.c                    |   4 +-
 hw/ssi/xilinx_spi.c                     |   9 +--
 hw/timer/sun4v-rtc.c                    |  23 ++----
 hw/core/Makefile.objs                   |   1 -
 hw/timer/trace-events                   |   6 +-
 17 files changed, 50 insertions(+), 214 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 delete mode 100644 hw/core/empty_slot.c

-- 
2.19.0
