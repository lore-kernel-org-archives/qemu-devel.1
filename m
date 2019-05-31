Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C89C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0613269B7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpqucE0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0613269B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhqW-0000DL-73
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:45:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoW-0007GB-FM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoV-0008ML-87
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:20 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:36676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhoV-0008LV-2g
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:19 -0400
Received: by mail-oi1-x22f.google.com with SMTP id y124so7751565oiy.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JcjDx8lv6syXknEH6gXvbh3NkQrjO+4cM/hkpXquMSM=;
	b=cpqucE0dL4H6AunrKPaRzyrliVPAit0WBXvAK71v+o/iL2gmRqnAfJR3dR8Qr0qtgT
	SJhSNS+qs0519zhJPeOyY1qn5gUAKSPSTSHoXwg4ayrvsrZBEEXxTgim0Rck4c7C7EeJ
	DZoKGaO+G4e7jgZZwi7YbliQV+OGDj5PcF/E4lh/R1sztAEkJcqU5JOXJtdPsv3BOFaO
	ysVWpTZGiPc0q5e+b4UiTH68gAZ6rbHL5N80A6l3qLE4IAgfsJmVf7HC2YEFFLLn1Fsi
	kV0oripFY/0oDUQhVp+J2gZ4xtiaZHp72+TqeeQ97SUXbQUsd2t7k5hrBgnCSJxIZw+d
	UCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JcjDx8lv6syXknEH6gXvbh3NkQrjO+4cM/hkpXquMSM=;
	b=V/SMu2Me+G3xmP0pK5kAi2BtynUbQFtfZQjNOLOmzWUBF+sNkDOxjqkxG+L7bhfbey
	kRdUpPX6G1aCYPcq4k+E2yK4bqPGpCIFyFHbEmpg34QfAIBFOA3jJh/679c6j//tsOTQ
	JV3eT4tUIYIjENgto1f+BE3QHXdROpv+3zzvvJ7vaAU1Mt58Zxvl8jDYwCn8py0iAs8a
	oEea3tnNK0QY08Zk24MMAcyToMNgydGotRMnfU4oDlEVE7+ryHN8Th7XwSwrOeYbPcsM
	tqlSDGlDj5suC8gZ3GVBZ0ZJj99KAQT09CDjIlc2fHpylUSKtFrm7l+awydytEVpi5n8
	nYLg==
X-Gm-Message-State: APjAAAWzHYHJ2Gw3XQz72a6cg25uroU8lHgNpwPIK7zpkjDC3dXIMtkC
	xpLtFJl7ptSGXEDWWtsbvojLbMwZxejXkg==
X-Google-Smtp-Source: APXvYqwW+1kBP9KF7o3pgn3TCynOzhKygvot/rTwry0HOLMKMXe/tS80m3Ji5QUXCQnYCGtP4HgBaA==
X-Received: by 2002:aca:ed04:: with SMTP id l4mr5927787oih.64.1559310197521;
	Fri, 31 May 2019 06:43:17 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:42:52 -0500
Message-Id: <20190531134315.4109-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: [Qemu-devel] [PATCH v16 00/23] Add RX architecture
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The v14 patch set, from which I had prepared the pull request,
contained errors within make check-qtest-rx.  I have added 4
new patches, 12 through 15, to address those failures.  These
are placed before the enablement patch 16 so that there is no
point at which these tests both run and fail.

I have not tried to extract the changes that Sato-san made in
his v15 patch set and folded in to previous patches.

I have appended the disassembler patches that have been reviewed.

Hopefully this is the version that can be merged, so that normal
development can proceed from there.


r~


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

Yoshinori Sato (12):
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
 target/rx/cpu.h                |  227 +++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  340 +++++
 hw/intc/rx_icu.c               |  376 +++++
 hw/rx/rx-virt.c                |  105 ++
 hw/rx/rx62n.c                  |  246 ++++
 hw/timer/renesas_cmt.c         |  275 ++++
 hw/timer/renesas_tmr.c         |  455 ++++++
 target/rx/cpu.c                |  245 ++++
 target/rx/disas.c              | 1446 +++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 ++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  470 ++++++
 target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++
 tests/machine-none-test.c      |    1 +
 MAINTAINERS                    |   19 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    3 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    1 +
 hw/intc/Kconfig                |    3 +
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |   14 +
 hw/rx/Makefile.objs            |    2 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 qapi/common.json               |    3 +-
 target/rx/Makefile.objs        |   12 +
 target/rx/insns.decode         |  621 ++++++++
 42 files changed, 8016 insertions(+), 2 deletions(-)
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
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/insns.decode

-- 
2.17.1


