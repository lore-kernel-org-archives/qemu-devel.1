Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F175CC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BE620815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BE620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi8j-00058G-0Y
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxW-0003GC-DY
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfm-0005jY-QH
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:04 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfm-0005jC-Ka
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:02 -0400
Received: by mail-pf1-f177.google.com with SMTP id q17so2650925pfq.8
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:mime-version
	:content-transfer-encoding:cc:from:to;
	bh=vX0WMAXoS4nloj2oli3GnHUVZ4fXaGRO3DV/kEYMTDw=;
	b=eQCabBH12WfpvL/XepEWgsRyNAWi3SjTAbYEutspG+MOneC81wUt5riXB5i7VdZMtf
	hWuUCUF8RZFIO8sHuAQH34tlMgPFDVXmnwSjXlTdzm9n4gdDEbvwFj2EpFU6v4UZ/KvD
	TXk7aTmZEHzuAvMnmRHjkfzxign/ebApGSP11lb9Mr33dZNteFjuDdum2nUO27QpBi7y
	rUDP5AbL8GxfLoWxGv8j7oCdoZ4f+X1Ab6SvdeP7qZJQyTHgl7yafqmR3vmm9xBdawxg
	dX29opRaXCi11cnkArIfZBIwGSrfUCns0LheCCIAP7AasdIB55d1g1aYv2mDlQLZ0Led
	LWWA==
X-Gm-Message-State: APjAAAXvmB38GGwsetsV+J2UeOMqv7s3HNtmonsDW8wp1K2Wvo9s/uwF
	LbGE5jIOSEtq5WXqo96PGG8VTbbgidY=
X-Google-Smtp-Source: APXvYqw0EqTnqVK+s8OhJOgwKKR7RkQkriosLVbXJMaFZ+NlBOp/MKwzhNdylvLDtbejF2JZwnJg+Q==
X-Received: by 2002:a62:5486:: with SMTP id
	i128mr29803364pfb.156.1558833000433; 
	Sat, 25 May 2019 18:10:00 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	h71sm13256473pje.11.2019.05.25.18.09.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:09:59 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:19 -0700
Message-Id: <20190526010948.3923-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.177
Subject: [Qemu-devel] [PULL] RISC-V Patches for the 4.1 Soft Freeze, Part 1
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a7b21f6762a2d6ec08106d8a7ccb11829914523f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-05-24 12:47:49 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-sf0

for you to fetch changes up to 1e0d985fa9136a563168a3da66f3d17820404ee2:

  target/riscv: Only flush TLB if SATP.ASID changes (2019-05-24 12:09:25 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.1 Soft Freeze, Part 1

This tag contains a handful of patches that I'd like to target for 4.1:

* An emulation for SiFive's GPIO device.
* A fix to disallow sfence.vma from userspace.
* Additional decodetree cleanups that should have no functional impact.
* C extension emulation fidelity fixes that were noticed as part of that
  cleanup process.
* A new "spike" target, along with the deprecation of a handful of old
  targets and CPUs.
* Some initial infastructure related to the hypervisor extension.
* An emulation fidelity fix that prevents prevents arbitrary bits in the
  SIP CSR from being set.
* A small performance improvement that avoids excessive TLB flushing
  when the ASID does not change.

This time I've used a new testing workflow: I've tested on both 32-bit
and 64-bit builds of OpenEmbedded, via the default OpenSBI-based boot
flow.

----------------------------------------------------------------
Alistair Francis (14):
      linux-user/riscv: Add the CPU type as a comment
      riscv: virt: Allow specifying a CPU via commandline
      target/riscv: Create settable CPU properties
      target/riscv: Add a base 32 and 64 bit CPU
      target/riscv: Deprecate the generic no MMU CPUs
      riscv: spike: Add a generic spike machine
      target/riscv: Mark privilege level 2 as reserved
      target/riscv: Trigger interrupt on MIP update asynchronously
      target/riscv: Improve the scause logic
      target/riscv: Add the MPV and MTL mstatus bits
      target/riscv: Allow setting mstatus virtulisation bits
      target/riscv: Add Hypervisor CSR macros
      target/riscv: Add the HSTATUS register masks
      target/riscv: Add the HGATP register masks

Fabien Chouteau (2):
      SiFive RISC-V GPIO Device
      RISC-V: fix single stepping over ret and other branching instructions

Jonathan Behrens (4):
      target/riscv: Do not allow sfence.vma from user mode
      target/riscv: Remove unused include of riscv_htif.h for virt board riscv
      target/riscv: More accurate handling of `sip` CSR
      target/riscv: Only flush TLB if SATP.ASID changes

Richard Henderson (9):
      target/riscv: Name the argument sets for all of insn32 formats
      target/riscv: Use --static-decode for decodetree
      target/riscv: Merge argument sets for insn32 and insn16
      target/riscv: Merge argument decode for RVC shifti
      target/riscv: Use pattern groups in insn16.decode
      target/riscv: Split RVC32 and RVC64 insns into separate files
      target/riscv: Split gen_arith_imm into functional and temp
      target/riscv: Remove spaces from register names
      target/riscv: Add checks for several RVC reserved operands

 Makefile.objs                                  |   1 +
 hw/riscv/Makefile.objs                         |   1 +
 hw/riscv/sifive_e.c                            |  28 +-
 hw/riscv/sifive_gpio.c                         | 388 +++++++++++++++++++++++++
 hw/riscv/spike.c                               | 106 ++++++-
 hw/riscv/trace-events                          |   7 +
 hw/riscv/virt.c                                |   4 +-
 include/hw/riscv/sifive_e.h                    |   8 +-
 include/hw/riscv/sifive_gpio.h                 |  72 +++++
 include/hw/riscv/virt.h                        |   4 +-
 linux-user/riscv/target_elf.h                  |   1 +
 qemu-deprecated.texi                           |  21 ++
 target/riscv/Makefile.objs                     |  15 +-
 target/riscv/cpu.c                             |  79 ++++-
 target/riscv/cpu.h                             |  10 +
 target/riscv/cpu_bits.h                        |  45 ++-
 target/riscv/cpu_helper.c                      |  35 ++-
 target/riscv/csr.c                             |  30 +-
 target/riscv/insn16-32.decode                  |  28 ++
 target/riscv/insn16-64.decode                  |  36 +++
 target/riscv/insn16.decode                     | 173 +++++------
 target/riscv/insn32.decode                     |  10 +-
 target/riscv/insn_trans/trans_privileged.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvc.inc.c        | 347 ----------------------
 target/riscv/insn_trans/trans_rvi.inc.c        |  26 +-
 target/riscv/op_helper.c                       |   7 +-
 target/riscv/translate.c                       |  77 ++++-
 27 files changed, 1053 insertions(+), 514 deletions(-)
 create mode 100644 hw/riscv/sifive_gpio.c
 create mode 100644 hw/riscv/trace-events
 create mode 100644 include/hw/riscv/sifive_gpio.h
 create mode 100644 target/riscv/insn16-32.decode
 create mode 100644 target/riscv/insn16-64.decode
 delete mode 100644 target/riscv/insn_trans/trans_rvc.inc.c


