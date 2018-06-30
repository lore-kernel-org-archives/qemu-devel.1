Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3T-0008B4-QU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3S-0001k7-RZ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 30 Jun 2018 10:13:40 +0100
Message-Id: <20180630091343.14391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] arm: add skeleton Cortex M0 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, joel@jms.id.au, qemu-arm@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, jusual@mail.ru, Subbaraya Sundeep <sundeep.lkml@gmail.com>, ilg@livius.net, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Share code between ARMv6-M and ARMv7-M [Peter]

This patch series adds a skeleton ARM Cortex M0 CPU model and an ARMv6M object
so that machine types can make use of it.

These patches cannot be merged until Julia Suvorova's Cortex M0 work is
complete, since the target/arm/ code does not implement ARMv6-M behavior
faithfully yet.

The micro:bit emulation will be the first machine type to make use of ARMv6-M.

Stefan Hajnoczi (3):
  hw/arm: extract ARM M Profile base class from ARMv7-M
  hw/arm: add ARMv6M object
  target/arm: add "cortex-m0" CPU model

 hw/arm/Makefile.objs            |   2 +
 include/hw/arm/arm-m-profile.h  |  65 +++++++++++
 include/hw/arm/arm.h            |  11 +-
 include/hw/arm/armv6m.h         |  24 ++++
 include/hw/arm/armv7m.h         |  22 +---
 hw/arm/arm-m-profile.c          | 192 ++++++++++++++++++++++++++++++++
 hw/arm/armv6m.c                 |  23 ++++
 hw/arm/armv7m.c                 | 166 ++++++---------------------
 hw/arm/mps2-tz.c                |   3 +-
 hw/arm/mps2.c                   |   4 +-
 hw/arm/msf2-soc.c               |   4 +-
 hw/arm/msf2-som.c               |   4 +-
 hw/arm/netduino2.c              |   4 +-
 hw/arm/stellaris.c              |   3 +-
 target/arm/cpu.c                |  11 ++
 default-configs/arm-softmmu.mak |   2 +
 16 files changed, 374 insertions(+), 166 deletions(-)
 create mode 100644 include/hw/arm/arm-m-profile.h
 create mode 100644 include/hw/arm/armv6m.h
 create mode 100644 hw/arm/arm-m-profile.c
 create mode 100644 hw/arm/armv6m.c

-- 
2.17.1
