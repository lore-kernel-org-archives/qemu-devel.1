Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFCC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F9320684
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F9320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBOT-0007Ct-6G
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuR-0000nn-M6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuO-0002qF-1h
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:39 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:59695)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuN-0002WU-M3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:35 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 7EFCB123765;
 Fri,  7 Jun 2019 18:11:23 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 84685240085;
 Fri,  7 Jun 2019 18:11:22 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 18:10:52 +0900
Message-Id: <20190607091116.49044-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.13
Subject: [Qemu-devel] [PATCH v17 00/24] Add RX archtecture support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello.
This patch series is added Renesas RX target emulation.

Changes v17.
Remove cpu class name suffix.

My git repository is bellow.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190607

Testing binaries bellow.
u-boot
Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz

starting
$ gzip -d u-boot.bin.gz
$ qemu-system-rx -bios u-boot.bin

linux and pico-root (only sash)
Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
           https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTre=
e)

starting
$ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"


Richard Henderson (11):
  target/rx: Convert to CPUClass::tlb_fill
  target/rx: Add RX to SysEmuTarget
  target/rx: Fix cpu types and names
  tests: Add rx to machine-none-test.c
  hw/rx: Honor -accel qtest
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly

Yoshinori Sato (13):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX Target hardware definition
  qemu/bitops.h: Add extract8 and extract16
  hw/registerfields.h: Add 8bit and 16bit register macros
  Add rx-softmmu
  MAINTAINERS: Add RX
  target/rx: Remove suffix in cpu class.

 configure                      |    8 +
 default-configs/rx-softmmu.mak |    3 +
 qapi/common.json               |    3 +-
 include/disas/dis-asm.h        |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   56 +
 include/hw/registerfields.h    |   32 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   94 ++
 include/hw/timer/renesas_cmt.h |   38 +
 include/hw/timer/renesas_tmr.h |   53 +
 include/qemu/bitops.h          |   38 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu.h                |  226 ++++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  340 ++++++
 hw/intc/rx_icu.c               |  376 +++++++
 hw/rx/rx-virt.c                |  105 ++
 hw/rx/rx62n.c                  |  246 ++++
 hw/timer/renesas_cmt.c         |  275 +++++
 hw/timer/renesas_tmr.c         |  455 ++++++++
 target/rx/cpu.c                |  241 ++++
 target/rx/disas.c              | 1446 ++++++++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 +++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  470 ++++++++
 target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++++=
++++++
 tests/machine-none-test.c      |    1 +
 MAINTAINERS                    |   19 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    1 +
 hw/intc/Kconfig                |    3 +
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |   14 +
 hw/rx/Makefile.objs            |    2 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 target/rx/Makefile.objs        |   12 +
 target/rx/insns.decode         |  621 ++++++++++
 42 files changed, 8011 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
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

--=20
2.11.0


