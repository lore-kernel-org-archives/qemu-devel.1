Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA6C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8DA2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8DA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFuJ8-0002Tq-4I
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 01:37:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHS-0001LG-7Q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHQ-0003UX-RQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:46 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:37440)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHQ-0003Tr-FU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:44 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail02.asahi-net.or.jp (Postfix) with ESMTPA id F071735488;
	Mon, 15 Apr 2019 14:35:41 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id CDB61240082; 
	Mon, 15 Apr 2019 14:35:40 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 14:35:18 +0900
Message-Id: <20190415053531.77264-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH RFC v7 00/12] Add RX archtecture support
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
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415053518.aeAwxCsTpu7aazB5rNKe7Ka6Nl3k5WlOHUK7-KB0hYM@z>

Hello.
This patch series is added Renesas RX target emulation.

It was corrected because the correspondence to registerfield was insufficient.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

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

Changes v6.
Add FIELD_DP8 and FIELD_DP16 to hw/registerfields.h.
Fixed registerfield support in timer and serial emulation.

Yoshinori Sato (12):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  target/rx: Miscellaneous files
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serical communication interface (SCI)
  hw/rx: RX Target hardware definition
  Add rx-softmmu
  MAINTAINERS: Add RX
  hw/registerfields.h: Add 8bit and 16bit register macros.

 configure                      |    8 +
 default-configs/rx-softmmu.mak |    7 +
 include/disas/bfd.h            |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   49 +
 include/hw/registerfields.h    |   28 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   54 +
 include/hw/timer/renesas_cmt.h |   33 +
 include/hw/timer/renesas_tmr.h |   46 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu-qom.h            |   52 +
 target/rx/cpu.h                |  197 ++++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  341 ++++++
 hw/intc/rx_icu.c               |  373 ++++++
 hw/rx/rx62n.c                  |  226 ++++
 hw/rx/rxqemu.c                 |  100 ++
 hw/timer/renesas_cmt.c         |  277 +++++
 hw/timer/renesas_tmr.c         |  458 ++++++++
 target/rx/cpu.c                |  232 ++++
 target/rx/disas.c              | 1481 ++++++++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 +++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  481 ++++++++
 target/rx/translate.c          | 2433 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   19 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    2 +-
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |    2 +
 hw/rx/Makefile.objs            |    1 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 target/rx/Makefile.objs        |   11 +
 target/rx/insns.decode         |  617 ++++++++++
 39 files changed, 7929 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/rx/rxqemu.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/insns.decode

-- 
2.11.0


