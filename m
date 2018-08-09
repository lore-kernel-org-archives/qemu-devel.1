Received: from eggs.gnu.org ([2001:4830:134:3::10]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnjLq-00013g-Pu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnjLo-0005Sa-50
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42786 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fnjLn-0005RU-Tm
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:32 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 992DDAD87
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 11:43:30 +0000 (UTC)
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Thu,  9 Aug 2018 13:40:13 +0200
Message-Id: <20180809114017.16643-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] Add support for Men Chameleon Bus
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>

This series adds support for emulating FPGAs by Men Mikroelektronik
N=C3=BCrnberg and expose the FPGA itself as a bus. The IP-Cores implement=
ed
in the FPGA are represented as devices hanging off that bus. This is the
same aproach that is used in the Linux kernel as well for these devices.

The main intention for this series is to have a test-bed for Linux
Kernel patches targeting the bus and/or sub-devices of it for people
who do not have access the hardware.

Changes since v1:
* Updated License comments of the files (Peter Maydell)
* Added <public>/<private> annotations (Philippe Mathieu-Daud=C3=A9)

Johannes Thumshirn (4):
  Add MEN Chameleon Bus emulation
  Add MEN Chameleon Bus via PCI carrier
  serial-mcb: Add serial via MEN chameleon bus
  wdt_z069: Add support for MEN 16z069 Watchdog

 default-configs/pci.mak   |   1 +
 hw/Makefile.objs          |   1 +
 hw/char/Makefile.objs     |   1 +
 hw/char/serial-mcb.c      | 100 +++++++++++++++
 hw/mcb/Makefile.objs      |   2 +
 hw/mcb/mcb-pci.c          | 305 ++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/mcb/mcb.c              | 180 +++++++++++++++++++++++++++
 hw/watchdog/Makefile.objs |   1 +
 hw/watchdog/wdt_z069.c    | 215 ++++++++++++++++++++++++++++++++
 include/hw/mcb/mcb.h      | 104 ++++++++++++++++
 10 files changed, 910 insertions(+)
 create mode 100644 hw/char/serial-mcb.c
 create mode 100644 hw/mcb/Makefile.objs
 create mode 100644 hw/mcb/mcb-pci.c
 create mode 100644 hw/mcb/mcb.c
 create mode 100644 hw/watchdog/wdt_z069.c
 create mode 100644 include/hw/mcb/mcb.h

--=20
2.16.4
