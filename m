Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DBFC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC37E20862
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC37E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcaXQ-00088k-6q
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcaWe-0007Oi-9M
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcaWa-0000hp-E1
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcaWY-0000dz-AQ
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 213D488318;
 Sun, 16 Jun 2019 19:09:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABB2890C5D;
 Sun, 16 Jun 2019 19:09:01 +0000 (UTC)
Date: Sun, 16 Jun 2019 21:08:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Message-ID: <20190616210857.1296de50@redhat.com>
In-Reply-To: <156069829707.13573.17978894546059848812@ce79690b2cb9>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
 <156069829707.13573.17978894546059848812@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Sun, 16 Jun 2019 19:09:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v20 00/24] Add RX archtecture support
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
 qemu-devel@nongnu.org, ysato@users.sourceforge.jp, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Jun 2019 08:18:18 -0700 (PDT)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20190616142836.10614-1-ysato@users.sourceforge.jp/
> 
> 
to fix MAINTAINERS warning, you can add new entry there at
the first patch that introduces new directory/file and get rid of 23/24 patch

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PATCH v20 00/24] Add RX archtecture support
> Type: series
> Message-id: 20190616142836.10614-1-ysato@users.sourceforge.jp
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20190616142836.10614-1-ysato@users.sourceforge.jp -> patchew/20190616142836.10614-1-ysato@users.sourceforge.jp
> Switched to a new branch 'test'
> 233b18cbe7 BootLinuxConsoleTest: Test the RX-Virt machine
> 904297282a MAINTAINERS: Add RX
> 43952adb47 Add rx-softmmu
> fb8cc7379b hw/registerfields.h: Add 8bit and 16bit register macros
> 300109d593 qemu/bitops.h: Add extract8 and extract16
> 298abac567 hw/rx: Restrict the RX62N microcontroller to the RX62N CPU core
> b836e3b146 hw/rx: Honor -accel qtest
> 781b6ec24c target/rx: Move rx_load_image to rx-virt.
> 9577f3d230 hw/rx: RX Target hardware definition
> 891f2de8d8 hw/char: RX62N serial communication interface (SCI)
> 3495206576 hw/timer: RX62N internal timer modules
> a905f500b4 hw/intc: RX62N interrupt controller (ICUa)
> ece449ed10 target/rx: Dump bytes for each insn during disassembly
> b95c9bad6b target/rx: Collect all bytes during disassembly
> 3dff5695a3 target/rx: Emit all disassembly in one prt()
> 704fec54d9 target/rx: Use prt_ldmi for XCHG_mr disassembly
> 7396e2ece1 target/rx: Replace operand with prt_ldmi in disassembler
> 60b13915e5 target/rx: Disassemble rx_index_addr into a string
> d41d01e403 target/rx: RX disassembler
> 85b88c8cd4 target/rx: simplify rx_cpu_class_by_name
> 376f2b05c3 target/rx: Follow the change of tcg.
> d86020dcdb target/rx: CPU definition
> 014cc684fa target/rx: TCG helper
> 4c5f19b6e4 target/rx: TCG translation
> 
> === OUTPUT BEGIN ===
> 1/24 Checking commit 4c5f19b6e47c (target/rx: TCG translation)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #20: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 3065 lines checked
> 
> Patch 1/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/24 Checking commit 014cc684fafc (target/rx: TCG helper)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #20: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 649 lines checked
> 
> Patch 2/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 3/24 Checking commit d86020dcdb96 (target/rx: CPU definition)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #20: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 645 lines checked
> 
> Patch 3/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/24 Checking commit 376f2b05c385 (target/rx: Follow the change of tcg.)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 121 lines checked
> 
> Patch 4/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 5/24 Checking commit 85b88c8cd4f0 (target/rx: simplify rx_cpu_class_by_name)
> 6/24 Checking commit d41d01e40305 (target/rx: RX disassembler)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #38: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 1497 lines checked
> 
> Patch 6/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 7/24 Checking commit 60b13915e559 (target/rx: Disassemble rx_index_addr into a string)
> 8/24 Checking commit 7396e2ece1ed (target/rx: Replace operand with prt_ldmi in disassembler)
> 9/24 Checking commit 704fec54d904 (target/rx: Use prt_ldmi for XCHG_mr disassembly)
> 10/24 Checking commit 3dff5695a3a3 (target/rx: Emit all disassembly in one prt())
> 11/24 Checking commit b95c9bad6bb6 (target/rx: Collect all bytes during disassembly)
> 12/24 Checking commit ece449ed1087 (target/rx: Dump bytes for each insn during disassembly)
> 13/24 Checking commit a905f500b42f (hw/intc: RX62N interrupt controller (ICUa))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #40: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 442 lines checked
> 
> Patch 13/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 14/24 Checking commit 3495206576c5 (hw/timer: RX62N internal timer modules)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #50: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 839 lines checked
> 
> Patch 14/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 15/24 Checking commit 891f2de8d83b (hw/char: RX62N serial communication interface (SCI))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #43: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 398 lines checked
> 
> Patch 15/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 16/24 Checking commit 9577f3d2304d (hw/rx: RX Target hardware definition)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #21: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 457 lines checked
> 
> Patch 16/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 17/24 Checking commit 781b6ec24c97 (target/rx: Move rx_load_image to rx-virt.)
> 18/24 Checking commit b836e3b14641 (hw/rx: Honor -accel qtest)
> 19/24 Checking commit 298abac5672b (hw/rx: Restrict the RX62N microcontroller to the RX62N CPU core)
> 20/24 Checking commit 300109d593d8 (qemu/bitops.h: Add extract8 and extract16)
> 21/24 Checking commit fb8cc7379bdd (hw/registerfields.h: Add 8bit and 16bit register macros)
> Use of uninitialized value within @rawlines in concatenation (.) or string at ./scripts/checkpatch.pl line 2467.
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #27: FILE: include/hw/registerfields.h:25:
> +#define REG8(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) };
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #31: FILE: include/hw/registerfields.h:29:
> +#define REG16(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) / 2 };
> 
> total: 2 errors, 0 warnings, 56 lines checked
> 
> Patch 21/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 22/24 Checking commit 43952adb472b (Add rx-softmmu)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #61: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 73 lines checked
> 
> Patch 22/24 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 23/24 Checking commit 904297282a7f (MAINTAINERS: Add RX)
> 24/24 Checking commit 233b18cbe7b0 (BootLinuxConsoleTest: Test the RX-Virt machine)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190616142836.10614-1-ysato@users.sourceforge.jp/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

