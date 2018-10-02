Received: from eggs.gnu.org ([2001:4830:134:3::10]:42827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAm-0003O1-Jk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAh-0007I7-GZ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAh-0007Ht-9P
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x12-v6so3808154wru.8
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:09 +0200
Message-Id: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/12] another SysBusDevice::init to
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

since v1:
- let the empty_slot
- sh4_pci and bonito use DeviceState::realize instead of PCIDevice::realize
- reword niagara-iob commit message

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00220.html
- convert few devices to DeviceState::realize,
- kill the empty_slot device,
- remove unuseful class_init() code [RFC, do we want to keep this?]
- few other minor fixes catched while editing

Regards,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03605.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00001.html

001/12:[----] [--] 'trace-events: Fix copy/paste typo'
002/12:[----] [--] 'hw/timer/sun4v-rtc: Convert from DPRINTF() macro to trace events'
003/12:[----] [--] 'hw/timer/sun4v-rtc: Use DeviceState::realize rather than SysBusDevice::init'
004/12:[----] [--] 'hw/ssi/xilinx_spi: Use DeviceState::realize rather than SysBusDevice::init'
005/12:[0006] [FC] 'hw/sh4/sh_pci: Use DeviceState::realize rather than SysBusDevice::init'
006/12:[0006] [FC] 'hw/pci-host/bonito: Use DeviceState::realize rather than SysBusDevice::init'
007/12:[----] [--] 'hw/mips/gt64xxx_pci: Convert gt64120_reset() function into Device reset method'
008/12:[----] [--] 'hw/mips/gt64xxx_pci: Mark as bridge device'
009/12:[----] [--] 'hw/sparc64/niagara: Model the I/O Bridge with the 'unimplemented_device''
010/12:[----] [--] 'hw/alpha/typhoon: Remove unuseful code'
011/12:[----] [--] 'hw/hppa/dino: Remove unuseful code'
012/12:[----] [--] 'hw/mips/malta: Remove unuseful code'

Philippe Mathieu-Daudé (12):
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
  hw/sparc64/niagara: Model the I/O Bridge with the
    'unimplemented_device'
  hw/alpha/typhoon: Remove unuseful code
  hw/hppa/dino: Remove unuseful code
  hw/mips/malta: Remove unuseful code

 default-configs/sparc64-softmmu.mak |  1 -
 hw/alpha/typhoon.c                  | 13 -------------
 hw/hppa/dino.c                      |  7 -------
 hw/mips/gt64xxx_pci.c               | 18 ++++--------------
 hw/mips/mips_malta.c                | 13 -------------
 hw/pci-host/bonito.c                |  9 +++------
 hw/sh4/sh_pci.c                     | 20 +++++++++-----------
 hw/sparc64/niagara.c                |  4 ++--
 hw/ssi/xilinx_spi.c                 |  9 +++------
 hw/timer/sun4v-rtc.c                | 23 ++++++++---------------
 hw/timer/trace-events               |  6 +++++-
 11 files changed, 34 insertions(+), 89 deletions(-)

-- 
2.19.0
