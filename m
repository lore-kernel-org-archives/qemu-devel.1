Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F20C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6FC2339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7u21qfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6FC2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BpG-0007sN-Be
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMd-0000vI-Qr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMc-0003ae-A3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMc-0003Zo-2O
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so9393876pgi.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HFt+SNoHxnXsKubH38yPgmAkrGKo2nrflpCUOr6pM2U=;
 b=a7u21qfKLWizLCq3qD8HlqRhSDNytMzhWCE9NsNeup9DXGQaRyDPudu82tBfqx/M7n
 frWGulfU/tDDg7ruBuIyeLNYg2/f+yclzFl2YhdsUAkvc57eJ5uAYYboVqDw4nMeVSPV
 XfdLYE1z1EMbyWrGzmlOP78cjTOeyBBVWt0fJ0OEGaPyypMCThmAQs8YKOJdo7UoSM7z
 OC0iwBkVHYLYoje/z4MZygAIovsJ2byolM6GD0O+r1c3PmZQKySyq6JeqpPi6iW/8Aot
 gy1PpoDfwN6FRLA+OlegFJmRrAgr0YwJ6CZK7xf0m4hfj51wFL/bCKieOY8KMotw8X+u
 9Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HFt+SNoHxnXsKubH38yPgmAkrGKo2nrflpCUOr6pM2U=;
 b=MM/FS0HiYkZDppSYnyBEKCKYAYN8t2nkLkP6QzLwrakGKy7RCrBEE2J4KB+bBMEfpI
 8mEKo+AiL84IffHjh/qqn0eGOjSYUVxZeik1xXalWb+lhN90bpq6QwKoPOQLbBW6XaJA
 6cta9o8/t2xfZ55d0h2L2mAG1o/CIn6IDwtmA4u1VIgHt6LnWJM0q/otaYzR7+mj8oVh
 sz7q1kFmAHMcTrxVsWSdUFLSdhHX/Fcd0X/6hou+CY0uX8etyAlWnyvjam16rXKlp2V+
 +72koHUT/B1RvRqPWIcjZpHKfokDTTBtdWtmhQtotA4VdwVGQrd9sHlZEe1a2v84YU0K
 tZ5Q==
X-Gm-Message-State: APjAAAXW6kvkju1doqdFEaizZoIqc/wIpphF6dZSevVw4mw05TDwhqd6
 m3ZLO+oC39KcVG3K2245oENVx1OfDj8=
X-Google-Smtp-Source: APXvYqwYOli+FIM5fjmh9RzbkcSMBJsGbro1SHnFxZc8M0K0d5jNxcXtBbrX9zJ26X7DpNG6dck0jw==
X-Received: by 2002:a17:90a:ba96:: with SMTP id
 t22mr53409pjr.104.1567526940324; 
 Tue, 03 Sep 2019 09:09:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:22 -0700
Message-Id: <20190903160858.5296-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 00/36] tcg patch queue
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fec105c2abda8567ec15230429c41429b5ee307c:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-03 14:03:15 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190903

for you to fetch changes up to c25c283df0f08582df29f1d5d7be1516b851532d:

  tcg: Factor out probe_write() logic into probe_access() (2019-09-03 08:34:18 -0700)

----------------------------------------------------------------
Allow page table bit to swap endianness.
Reorganize watchpoints out of i/o path.
Return host address from probe_write / probe_access.

----------------------------------------------------------------
David Hildenbrand (11):
      exec: Factor out core logic of check_watchpoint()
      tcg: Check for watchpoints in probe_write()
      s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in probe_write_access()
      s390x/tcg: Fix length calculation in probe_write_access()
      tcg: Factor out CONFIG_USER_ONLY probe_write() from s390x code
      tcg: Enforce single page access in probe_write()
      mips/tcg: Call probe_write() for CONFIG_USER_ONLY as well
      hppa/tcg: Call probe_write() also for CONFIG_USER_ONLY
      s390x/tcg: Pass a size to probe_write() in do_csst()
      tcg: Make probe_write() return a pointer to the host page
      tcg: Factor out probe_write() logic into probe_access()

Richard Henderson (6):
      exec: Move user-only watchpoint stubs inline
      cputlb: Fold TLB_RECHECK into TLB_INVALID_MASK
      exec: Factor out cpu_watchpoint_address_matches
      cputlb: Fix size operand for tlb_fill on unaligned store
      cputlb: Remove double-alignment in store_helper
      cputlb: Handle watchpoints via TLB_WATCHPOINT

Tony Nguyen (19):
      tcg: TCGMemOp is now accelerator independent MemOp
      memory: Introduce size_memop
      target/mips: Access MemoryRegion with MemOp
      hw/s390x: Access MemoryRegion with MemOp
      hw/intc/armv7m_nic: Access MemoryRegion with MemOp
      hw/virtio: Access MemoryRegion with MemOp
      hw/vfio: Access MemoryRegion with MemOp
      exec: Access MemoryRegion with MemOp
      cputlb: Access MemoryRegion with MemOp
      memory: Access MemoryRegion with MemOp
      hw/s390x: Hard code size with MO_{8|16|32|64}
      target/mips: Hard code size with MO_{8|16|32|64}
      exec: Hard code size with MO_{8|16|32|64}
      memory: Access MemoryRegion with endianness
      cputlb: Replace size and endian operands for MemOp
      memory: Single byte swap along the I/O path
      cputlb: Byte swap memory transaction attribute
      target/sparc: Add TLB entry with attributes
      target/sparc: sun4u Invert Endian TTE bit

 include/exec/cpu-all.h                  |   8 +-
 include/exec/exec-all.h                 |  10 +-
 include/exec/memattrs.h                 |   2 +
 include/exec/memop.h                    | 134 +++++++++++
 include/exec/memory.h                   |  12 +-
 include/hw/core/cpu.h                   |  37 +++
 target/arm/translate-a64.h              |   2 +-
 target/arm/translate.h                  |   2 +-
 target/sparc/cpu.h                      |   2 +
 tcg/tcg-op.h                            |  80 +++---
 tcg/tcg.h                               | 101 +-------
 trace/mem-internal.h                    |   4 +-
 trace/mem.h                             |   4 +-
 accel/tcg/cputlb.c                      | 414 ++++++++++++++++++--------------
 accel/tcg/user-exec.c                   |  32 +++
 exec.c                                  | 177 +++-----------
 hw/intc/armv7m_nvic.c                   |  13 +-
 hw/s390x/s390-pci-inst.c                |  11 +-
 hw/vfio/pci-quirks.c                    |   7 +-
 hw/virtio/virtio-pci.c                  |  15 +-
 memory.c                                |  58 +++--
 memory_ldst.inc.c                       |  81 ++-----
 target/alpha/translate.c                |   2 +-
 target/arm/translate-a64.c              |  48 ++--
 target/arm/translate-sve.c              |   2 +-
 target/arm/translate.c                  |  32 +--
 target/hppa/op_helper.c                 |   2 -
 target/hppa/translate.c                 |  14 +-
 target/i386/translate.c                 | 132 +++++-----
 target/m68k/translate.c                 |   2 +-
 target/microblaze/translate.c           |   4 +-
 target/mips/op_helper.c                 |  13 +-
 target/mips/translate.c                 |   8 +-
 target/openrisc/translate.c             |   4 +-
 target/ppc/translate.c                  |  12 +-
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-
 target/s390x/mem_helper.c               |  13 +-
 target/s390x/translate.c                |   6 +-
 target/s390x/translate_vx.inc.c         |  10 +-
 target/sparc/mmu_helper.c               |  40 +--
 target/sparc/translate.c                |  14 +-
 target/tilegx/translate.c               |  10 +-
 target/tricore/translate.c              |   8 +-
 tcg/aarch64/tcg-target.inc.c            |  26 +-
 tcg/arm/tcg-target.inc.c                |  26 +-
 tcg/i386/tcg-target.inc.c               |  24 +-
 tcg/mips/tcg-target.inc.c               |  16 +-
 tcg/optimize.c                          |   2 +-
 tcg/ppc/tcg-target.inc.c                |  12 +-
 tcg/riscv/tcg-target.inc.c              |  20 +-
 tcg/s390/tcg-target.inc.c               |  14 +-
 tcg/sparc/tcg-target.inc.c              |   6 +-
 tcg/tcg-op.c                            |  38 +--
 tcg/tcg.c                               |   2 +-
 MAINTAINERS                             |   1 +
 tcg/README                              |   2 +-
 57 files changed, 918 insertions(+), 865 deletions(-)
 create mode 100644 include/exec/memop.h

