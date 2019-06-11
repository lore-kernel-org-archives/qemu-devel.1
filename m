Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1DC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C4720896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C4720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafUu-0003M1-8z
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hafAj-00071Q-4H
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1haf6H-000059-85
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1haf6F-0008CL-51
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C5AB31628F0;
 Tue, 11 Jun 2019 11:37:42 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3073B60C5F;
 Tue, 11 Jun 2019 11:37:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Date: Tue, 11 Jun 2019 13:37:10 +0200
Message-Id: <20190611113731.16940-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 11:37:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v19 00/21] Add RX archtecture support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori, Richard, Igor.

This series an iteration of the previous v16 from Yoshinori with
the fixups requested by Igor here:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07260.html
and
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01547.html
plus trivial cleanups.

It is based on commit 19735c837ae2056b4651720290eda59498eca65a,
that is before the merge of pull-tcg-20190610 (CPUNegativeOffsetState)
which resulted in commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf.

Series reordered, some patches squashed.

Patches modified: 2, 3, 14, 19 (wait review from Igor)
New patch: 16 (wait review from Yoshinori)
Extra patch: 21 (meant for testing)

This branch is available here: https://gitlab.com/philmd/qemu/tree/rx-v19

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

$ git backport-diff -u rx-16 -r 19735c837ae..rx-v19
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/21:[----] [--] 'target/rx: TCG translation'
002/21:[0011] [FC] 'target/rx: TCG helper'
003/21:[0136] [FC] 'target/rx: CPU definition'
004/21:[----] [--] 'target/rx: RX disassembler'
005/21:[----] [--] 'target/rx: Disassemble rx_index_addr into a string'
006/21:[----] [--] 'target/rx: Replace operand with prt_ldmi in disassemb=
ler'
007/21:[----] [--] 'target/rx: Use prt_ldmi for XCHG_mr disassembly'
008/21:[----] [--] 'target/rx: Emit all disassembly in one prt()'
009/21:[----] [--] 'target/rx: Collect all bytes during disassembly'
010/21:[----] [--] 'target/rx: Dump bytes for each insn during disassembl=
y'
011/21:[----] [--] 'hw/intc: RX62N interrupt controller (ICUa)'
012/21:[----] [--] 'hw/timer: RX62N internal timer modules'
013/21:[----] [--] 'hw/char: RX62N serial communication interface (SCI)'
014/21:[0013] [FC] 'hw/rx: RX Target hardware definition'
015/21:[----] [-C] 'hw/rx: Honor -accel qtest'
016/21:[down] 'hw/rx: Restrict the RX62N microcontroller to the RX62N CPU=
 core'
017/21:[----] [--] 'qemu/bitops.h: Add extract8 and extract16'
018/21:[----] [--] 'hw/registerfields.h: Add 8bit and 16bit register macr=
os'
019/21:[0005] [FC] 'Add rx-softmmu'
020/21:[----] [--] 'MAINTAINERS: Add RX'
021/21:[down] 'BootLinuxConsoleTest: Test the RX-Virt machine'

Thanks,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  hw/rx: Restrict the RX62N microcontroller to the RX62N CPU core
  hw/registerfields.h: Add 8bit and 16bit register macros
  BootLinuxConsoleTest: Test the RX-Virt machine

Richard Henderson (7):
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly
  hw/rx: Honor -accel qtest

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
 hw/rx/rx62n.c                          |  246 +++
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
 include/hw/rx/rx62n.h                  |   91 +
 include/hw/timer/renesas_cmt.h         |   38 +
 include/hw/timer/renesas_tmr.h         |   53 +
 include/qemu/bitops.h                  |   38 +
 include/sysemu/arch_init.h             |    1 +
 qapi/common.json                       |    3 +-
 target/rx/Makefile.objs                |   12 +
 target/rx/cpu-qom.h                    |   42 +
 target/rx/cpu.c                        |  252 +++
 target/rx/cpu.h                        |  201 ++
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
 45 files changed, 8096 insertions(+), 2 deletions(-)
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

--=20
2.20.1


