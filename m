Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC8C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCEB20862
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCEB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBi5-0006Gv-IW
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:13:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3Sv-0000do-4T
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3St-0006Kh-Hy
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:33 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:56137)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQ3St-0006Hu-8u
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:25:31 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 0C43B41CCB;
	Mon, 13 May 2019 14:25:27 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 4F190240085; 
	Mon, 13 May 2019 14:25:26 +0900 (JST)
From: Yoshinori Sato <yo-satoh@sios.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:25:06 +0900
Message-Id: <20190513052518.6274-1-yo-satoh@sios.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
X-Mailman-Approved-At: Mon, 13 May 2019 10:11:53 -0400
Subject: [Qemu-devel] [PATCH v11 00/12] Add RX archtecture support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <yo-satoh@sios.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello.
This patch series is added Renesas RX target emulation.

Fixed build errors and cleaned up the code.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190513

Testing binaries bellow.
u-boot
Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz

starting
$ gzip -d u-boot.bin.gz
$ qemu-system-rx -bios u-boot.bin

linux and pico-root (only sash)
Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
           https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)

starting
$ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"

Changes for v10.
- Fix build error for 32bit system.
- Use "object_initialize_child" in create device instance.
- Remove unused headers.
- Avoid some magic number.
- Clean up Kconfig symbols.

Yoshinori Sato (12):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX Target hardware definition
  hw/registerfields.h: Add 8bit and 16bit register macros.
  qemu/bitops.h: Add extract8 and extract16
  Add rx-softmmu
  MAINTAINERS: Add RX

 MAINTAINERS                    |   19 +
 arch_init.c                    |    2 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    3 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    1 +
 hw/char/renesas_sci.c          |  340 ++++++
 hw/intc/Kconfig                |    3 +
 hw/intc/Makefile.objs          |    1 +
 hw/intc/rx_icu.c               |  376 +++++++
 hw/rx/Kconfig                  |   14 +
 hw/rx/Makefile.objs            |    2 +
 hw/rx/rx-virt.c                |  105 ++
 hw/rx/rx62n.c                  |  238 ++++
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 hw/timer/renesas_cmt.c         |  275 +++++
 hw/timer/renesas_tmr.c         |  455 ++++++++
 include/disas/dis-asm.h        |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   57 +
 include/hw/registerfields.h    |   32 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   94 ++
 include/hw/timer/renesas_cmt.h |   38 +
 include/hw/timer/renesas_tmr.h |   50 +
 include/qemu/bitops.h          |   38 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/Makefile.objs        |   12 +
 target/rx/cpu.c                |  222 ++++
 target/rx/cpu.h                |  227 ++++
 target/rx/disas.c              | 1480 ++++++++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 +++
 target/rx/helper.h             |   31 +
 target/rx/insns.decode         |  621 ++++++++++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  481 ++++++++
 target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++++++++++
 40 files changed, 8025 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/Makefile.objs
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


