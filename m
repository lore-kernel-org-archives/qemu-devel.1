Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3588C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3DF2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWJM-0004h1-SN
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWFG-000173-B9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWFD-0006VB-Ar
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:23:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWFB-0006Rd-0t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:23:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id c70so1046729pga.8
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Pw2Nr3I+/5EVRnOzDOc9YXIEf5FJ+JDG7yoiQZALAIQ=;
 b=SlqdiMjPq6FW3a0T+c6l5YQeIOJMS10k1WjcQUSbldRkQygZIdtLvXBEmr5TOCdR9l
 3cgcMQ4NYqj5SQ0Ep9UvNyfuahTbngrfdUs9qS4RTKR2RTcJHoGw2Ju9YzZTeeRNCG9H
 i2+u5teuK6jjX4iHIKOP1VAwSnqq+i98AJWCi2EZiE+29rNaFWnlexJ5ooZyErmvhSz6
 q0SHAIhZQ1RvMkiu3zDt0k51e0uXQNIuYvFt6Smk3DFpzyRIPg5C0WaauwD698NtStXP
 OTxDaWzfBSDUPrgTAgPe28FeKhgvelYMOpUCEDYfZDaiSCJZee3TdYiZerlZv+7dqS7m
 srQg==
X-Gm-Message-State: APjAAAVosBnjU+DYMLsWZDC208eBvtHkHBLGqemUDZm86aFtTT2ZabO7
 P+4DBfsHBRsu0rB9bImsrnZf9A==
X-Google-Smtp-Source: APXvYqzQfZZ4dwHMuhEdtSvhWi4F6pS6UG9Unovot9YhQRtlnZZ+GkFKKbc5iPOGImaLYhL/NWxrqQ==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id
 o14mr6784262pjq.142.1561649001369; 
 Thu, 27 Jun 2019 08:23:21 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f15sm7644455pje.17.2019.06.27.08.23.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:23:20 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:37 -0700
Message-Id: <20190627152011.18686-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL] RISC-V Patches for the 4.1 Soft Freeze, Part 2
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

merged tag 'mips-queue-jun-21-2019'
The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-sf1

for you to fetch changes up to c08a8317e31033ec76b8460a0b75cbcdaeeef481:

  hw/riscv: Load OpenSBI as the default firmware (2019-06-27 02:47:06 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.1 Soft Freeze, Part 2

This pull request contains a handful of patches that I'd like to target
for the 4.1 soft freeze.  There are a handful of new features:

* The -bios option now works sanely, including both a built-in copy of
  OpenSBI and the ability to load external versions.  Users no longer
  need to figure out how to build their own firmware.
* Support for the 1.11.0, the latest privileged specification.
* Support for reading and writing the PRCI registers.
* Better control over the ISA of the target machine.
* Support for the cpu-topology device tree node.

Additionally, there are a handful of bug fixes including:

* Load reservations are now broken by both store conditional and by
  scheduling, which fixes issues with parallel applications.
* Various fixes to the PMP implementation.
* Fixes to the 32-bit linux-user syscall ABI.
* Various fixes for instruction decodeing.
* A fix to the PCI device tree "bus-range" property.

This boots 32-bit and 64-bit OpenEmbedded.

----------------------------------------------------------------
Alistair Francis (14):
      target/riscv: Allow setting ISA extensions via CPU props
      target/riscv: Restructure deprecatd CPUs
      target/riscv: Add the privledge spec version 1.11.0
      target/riscv: Add the mcountinhibit CSR
      target/riscv: Set privledge spec 1.11.0 as default
      qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
      target/riscv: Require either I or E base extension
      target/riscv: Remove user version information
      target/riscv: Add support for disabling/enabling Counters
      hw/riscv: Split out the boot functions
      hw/riscv: Add support for loading a firmware
      hw/riscv: Extend the kernel loading support
      roms: Add OpenSBI version 0.3
      hw/riscv: Load OpenSBI as the default firmware

Atish Patra (1):
      riscv: virt: Add cpu-topology DT node.

Bin Meng (3):
      riscv: virt: Correct pci "bus-range" encoding
      riscv: sifive_u: Do not create hard-coded phandles in DT
      riscv: sifive_u: Update the plic hart config to support multicore

Dayeol Lee (1):
      target/riscv: Fix PMP range boundary address bug

Hesham Almatary (6):
      RISC-V: Only Check PMP if MMU translation succeeds
      RISC-V: Raise access fault exceptions on PMP violations
      RISC-V: Check for the effective memory privilege mode during PMP checks
      RISC-V: Check PMP during Page Table Walks
      RISC-V: Fix a PMP bug where it succeeds even if PMP entry is off
      RISC-V: Fix a PMP check with the correct access size

Jim Wilson (1):
      RISC-V: Update syscall list for 32-bit support.

Joel Sing (1):
      RISC-V: Clear load reservations on context switch and SC

Michael Clark (2):
      target/riscv: Implement riscv_cpu_unassigned_access
      disas/riscv: Disassemble reserved compressed encodings as illegal

Nathaniel Graff (1):
      sifive_prci: Read and write PRCI registers

Palmer Dabbelt (3):
      RISC-V: Fix a memory leak when realizing a sifive_e
      RISC-V: Add support for the Zifencei extension
      RISC-V: Add support for the Zicsr extension

Wladimir J. van der Laan (1):
      disas/riscv: Fix `rdinstreth` constraint

 .gitmodules                                    |   3 +
 Makefile                                       |   5 +-
 disas/riscv.c                                  |  65 ++++++++---
 hw/riscv/Makefile.objs                         |   1 +
 hw/riscv/boot.c                                | 154 +++++++++++++++++++++++++
 hw/riscv/sifive_e.c                            |  30 ++---
 hw/riscv/sifive_prci.c                         |  49 ++++++--
 hw/riscv/sifive_u.c                            |  55 +++++----
 hw/riscv/spike.c                               |  21 +---
 hw/riscv/virt.c                                |  84 ++++++--------
 include/hw/riscv/boot.h                        |  32 +++++
 include/hw/riscv/sifive_e.h                    |   2 +
 include/hw/riscv/sifive_prci.h                 |  32 +++++
 linux-user/riscv/syscall_nr.h                  |  15 ++-
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 0 -> 28848 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 0 -> 28904 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 0 -> 28904 bytes
 qemu-deprecated.texi                           |  28 +++++
 roms/Makefile                                  |  48 ++++++--
 roms/opensbi                                   |   1 +
 target/riscv/cpu.c                             | 137 ++++++++++++++++------
 target/riscv/cpu.h                             |  33 ++++--
 target/riscv/cpu_bits.h                        |   1 +
 target/riscv/cpu_helper.c                      |  55 ++++++++-
 target/riscv/csr.c                             |  30 ++++-
 target/riscv/insn_trans/trans_privileged.inc.c |   2 +-
 target/riscv/insn_trans/trans_rva.inc.c        |   8 +-
 target/riscv/insn_trans/trans_rvi.inc.c        |   4 +
 target/riscv/pmp.c                             |  17 +--
 target/riscv/pmp.h                             |   2 +-
 target/riscv/translate.c                       |   3 +
 31 files changed, 705 insertions(+), 212 deletions(-)
 create mode 100644 hw/riscv/boot.c
 create mode 100644 include/hw/riscv/boot.h
 create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
 create mode 160000 roms/opensbi


