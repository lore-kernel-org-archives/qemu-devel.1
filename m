Received: from eggs.gnu.org ([209.51.188.92]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRV-0006eM-NU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRT-0004K7-Hv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:45 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:54414)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRT-00042g-7q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:43 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 21 Jan 2019 22:15:51 +0900
Message-Id: <20190121131602.55003-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC 00/11] Add Renesas RX archtecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Hello.
This patch series is added Renesas RX target emulation.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

Since my understanding is not enough,
I want many comments to make this a good one.

Thanks.

Yoshinori Sato (11):
  TCG translation
  RX CPU definition
  TCG helper functions
  Target miscellaneous functions.
  RX disassembler
  RX62N interrupt contoller.
  RX62N internal timer unit.
  RX62N internal  serical communication interface.
  RX Target hardware definition.
  Add rx-softmmu.
  MAINTAINERS: Add RX entry.

 MAINTAINERS                    |   20 +
 arch_init.c                    |    2 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    7 +
 disas/Makefile.objs            |    1 +
 disas/rx.c                     | 1277 +++++++++++++++++
 hw/char/Makefile.objs          |    2 +-
 hw/char/renesas_sci.c          |  279 ++++
 hw/intc/Makefile.objs          |    1 +
 hw/intc/rx_icu.c               |  313 +++++
 hw/rx/Makefile.objs            |    1 +
 hw/rx/rx62n.c                  |  233 ++++
 hw/rx/rxqemu.c                 |  106 ++
 hw/timer/Makefile.objs         |    2 +
 hw/timer/renesas_cmt.c         |  226 +++
 hw/timer/renesas_tmr.c         |  401 ++++++
 include/disas/bfd.h            |    5 +
 include/hw/char/renesas_sci.h  |   42 +
 include/hw/intc/rx_icu.h       |   49 +
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   45 +
 include/hw/timer/renesas_cmt.h |   33 +
 include/hw/timer/renesas_tmr.h |   42 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/Makefile.objs        |    2 +
 target/rx/cpu-qom.h            |   54 +
 target/rx/cpu.c                |  226 +++
 target/rx/cpu.h                |  212 +++
 target/rx/gdbstub.c            |  114 ++
 target/rx/helper.c             |  143 ++
 target/rx/helper.h             |   22 +
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  548 ++++++++
 target/rx/translate.c          | 3003 ++++++++++++++++++++++++++++++++++++++++
 34 files changed, 7464 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 disas/rx.c
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/rx/rxqemu.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/helper.h
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c

-- 
2.11.0
