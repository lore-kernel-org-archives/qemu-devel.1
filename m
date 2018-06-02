Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J6-0001H8-8W
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J5-0007Dn-9P
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  2 Jun 2018 15:14:44 +0100
Message-Id: <20180602141446.29982-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] arm: add skeleton Cortex M0 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, mail@steffen-goertz.de, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, joel@jms.id.au, Stefan Hajnoczi <stefanha@redhat.com>

This patch series adds a skeleton ARM Cortex M3 CPU model and updates the
"microbit" machine type to use it.

The Cortex M0 emulation is not complete.  This just lays the groundwork so we
can implement the missing ARMv6-M feature tests in target/arm/.

These patches cannot be merged until ARMv6-M feature tests have been fully
implemented.

Julia: it should now be possible for you to tackle the Cortex M0 emulation
tasks that have been discussed on the mailing list.

Based-on: http://github.com/stefanha/qemu/commits/microbit

Stefan Hajnoczi (2):
  target/arm: add "cortex-m0" CPU model
  arm: add ARMv6-M device container

 hw/arm/Makefile.objs            |   1 +
 hw/intc/Makefile.objs           |   2 +-
 hw/timer/Makefile.objs          |   2 +-
 include/hw/arm/arm.h            |  16 +++
 include/hw/arm/armv6m.h         |  49 ++++++++
 hw/arm/armv6m.c                 | 190 ++++++++++++++++++++++++++++++++
 hw/arm/nrf51_soc.c              |   5 +-
 target/arm/cpu.c                |  12 ++
 default-configs/arm-softmmu.mak |   2 +
 9 files changed, 274 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/arm/armv6m.h
 create mode 100644 hw/arm/armv6m.c

-- 
2.17.0
