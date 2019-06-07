Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F4C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C372089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C372089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIJz-0003Q4-72
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZH00-0003Tv-BE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGwP-0000qb-Lc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGwG-0000bk-71
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE18C3007403;
 Fri,  7 Jun 2019 15:37:32 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 035E17D64C;
 Fri,  7 Jun 2019 15:37:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:36:56 +0200
Message-Id: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 07 Jun 2019 15:37:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 00/29] Add RX archtecture support
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori, Richard, Igor.

This series an iteration of the previous v17 from Yoshinori with
the fixups requested by Igor here:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07260.html
and
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01547.html
plus trivial cleanups.

We have:

$ qemu-system-rx -cpu help
rx62n

(qemu) info qom-tree
/machine (rx-virt-machine)
  /peripheral (container)
  /mcu (rx62n)
    /sci[0] (renesas-sci)
      /renesas-sci[0] (qemu:memory-region)
    /icu (rx-icu)
      ...
    /cpu (rx62n-rx-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
    ...

If Igor aggrees with the fixup patches, Richard, can you squash
them and send a pull request?  (without the last patch, which is
expected to go via Eduardo's tree, but since it is helpful for
testing this series, I included it).

Thanks,

Phil.

Philippe Mathieu-Daud=C3=A9 (8):
  !fixup target/rx: CPU definition
  !fixup target/rx: CPU definition
  !fixup hw/rx: RX Target hardware definition
  hw/registerfields.h: Add 8bit and 16bit register macros
  target/rx: Restrict access to extable[]
  hw/rx: Restrict the RX62N microcontroller to the RX62N CPU core
  hw/rx: Fix comments
  BootLinuxConsoleTest: Test the RX-Virt machine

Richard Henderson (10):
  target/rx: Convert to CPUClass::tlb_fill
  target/rx: Add RX to SysEmuTarget
  tests: Add rx to machine-none-test.c
  hw/rx: Honor -accel qtest
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly

Yoshinori Sato (11):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX Target hardware definition
  qemu/bitops.h: Add extract8 and extract16
  Add rx-softmmu
  MAINTAINERS: Add RX

 MAINTAINERS                            |   19 +
 arch_init.c                            |    2 +
 configure                              |    8 +
 default-configs/rx-softmmu.mak         |    3 +
 hw/Kconfig                             |    1 +
 hw/char/Kconfig                        |    3 +
 hw/char/Makefile.objs                  |    1 +
 hw/char/renesas_sci.c                  |  340 ++++
 hw/intc/Kconfig                        |    3 +
 hw/intc/Makefile.objs                  |    1 +
 hw/intc/rx_icu.c                       |  376 ++++
 hw/rx/Kconfig                          |   14 +
 hw/rx/Makefile.objs                    |    2 +
 hw/rx/rx-virt.c                        |  113 ++
 hw/rx/rx62n.c                          |  247 +++
 hw/timer/Kconfig                       |    6 +
 hw/timer/Makefile.objs                 |    3 +
 hw/timer/renesas_cmt.c                 |  275 +++
 hw/timer/renesas_tmr.c                 |  455 +++++
 include/disas/dis-asm.h                |    5 +
 include/exec/poison.h                  |    1 +
 include/hw/char/renesas_sci.h          |   45 +
 include/hw/intc/rx_icu.h               |   56 +
 include/hw/registerfields.h            |   32 +-
 include/hw/rx/rx.h                     |    7 +
 include/hw/rx/rx62n.h                  |   94 +
 include/hw/timer/renesas_cmt.h         |   38 +
 include/hw/timer/renesas_tmr.h         |   53 +
 include/qemu/bitops.h                  |   38 +
 include/sysemu/arch_init.h             |    1 +
 qapi/common.json                       |    3 +-
 target/rx/Makefile.objs                |   12 +
 target/rx/cpu.c                        |  252 +++
 target/rx/cpu.h                        |  227 +++
 target/rx/disas.c                      | 1446 ++++++++++++++
 target/rx/gdbstub.c                    |  112 ++
 target/rx/helper.c                     |  148 ++
 target/rx/helper.h                     |   31 +
 target/rx/insns.decode                 |  621 ++++++
 target/rx/monitor.c                    |   38 +
 target/rx/op_helper.c                  |  470 +++++
 target/rx/translate.c                  | 2432 ++++++++++++++++++++++++
 tests/acceptance/boot_linux_console.py |   51 +
 tests/machine-none-test.c              |    1 +
 44 files changed, 8084 insertions(+), 2 deletions(-)
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

--=20
2.20.1


