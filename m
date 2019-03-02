Received: from eggs.gnu.org ([209.51.188.92]:49770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy4T-0003Em-CZ
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy25-0002xf-5l
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:03 -0500
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:48763)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy23-0002sy-4G
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:00 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:27 +0900
Message-Id: <20190302062138.10713-1-ysato@users.sourceforge.jp>
In-Reply-To: <20190122121413.31437-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 00/11] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Hello.
This patch series is added Renesas RX target emulation.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

Since my understanding is not enough,
I want many comments to make this a good one.

Thanks.

Changes v2
Rewrite translate. using decodetree.py

Yoshinori Sato (11):
  target/rx: TCG Translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  target/rx: miscellaneous functions
  RX62N interrupt contorol uint
  RX62N internal timer modules
  RX62N internal serial communication interface
  RX Target hardware definition
  Add rx-softmmu
  MAINTAINERS: Add RX entry.

 MAINTAINERS                    |   20 +
 arch_init.c                    |    2 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    7 +
 hw/char/Makefile.objs          |    2 +-
 hw/char/renesas_sci.c          |  288 ++++++
 hw/intc/Makefile.objs          |    1 +
 hw/intc/rx_icu.c               |  323 ++++++
 hw/rx/Makefile.objs            |    1 +
 hw/rx/rx62n.c                  |  227 ++++
 hw/rx/rxqemu.c                 |  100 ++
 hw/timer/Makefile.objs         |    2 +
 hw/timer/renesas_cmt.c         |  235 +++++
 hw/timer/renesas_tmr.c         |  412 ++++++++
 include/disas/bfd.h            |    5 +
 include/hw/char/renesas_sci.h  |   42 +
 include/hw/intc/rx_icu.h       |   49 +
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   54 +
 include/hw/timer/renesas_cmt.h |   33 +
 include/hw/timer/renesas_tmr.h |   42 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/Makefile.objs        |   11 +
 target/rx/cpu-qom.h            |   52 +
 target/rx/cpu.c                |  224 ++++
 target/rx/cpu.h                |  214 ++++
 target/rx/disas.c              | 1570 ++++++++++++++++++++++++++++
 target/rx/gdbstub.c            |  113 ++
 target/rx/helper.c             |  252 +++++
 target/rx/helper.h             |   39 +
 target/rx/insns.decode         |  336 ++++++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  602 +++++++++++
 target/rx/translate.c          | 2220 ++++++++++++++++++++++++++++++++++++++++
 34 files changed, 7531 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/rx-softmmu.mak
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
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/helper.h
 create mode 100644 target/rx/insns.decode
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c

-- 
2.11.0
