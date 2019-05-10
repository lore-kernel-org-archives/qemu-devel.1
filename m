Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D082521479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDZ19RST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D082521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7LN-0000Ma-UV
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JN-0007OD-Un
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JM-00088U-LW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:34686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JM-00086s-68
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id w7so3005796plz.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W4vu8agVHwvbXrsKUiOITU+gaO6bmn5JUQXLjONPufY=;
	b=qDZ19RST39rN7iPL3XmiCMPx33dTaWKcO78va4YYAcUTDl7JI0aVNAz2v25THaEUv8
	5YDPtDkwkyLWa8nSqJ169FQ3J2wi2G9cZ1LykgWGRcJEhSF9BZPJn80HLUK0tx04Tw5L
	A1S0ryo3CEyHuoQKmtyoF1XqCxLTd0Zryr33Se7XWVFud8LjzcfUd6xx0KftWbkziBed
	WhIYYT99Bcbe7N+3D/cq/k2W0BYgX0uSI+AnFjkxIctXjCOdpQF6mkzZG/CQaLqaGCiV
	uoD6gtY3BynuL1t8s9xcfJusdQvIDOrm2QjAM6KvXB1ws0fvxbJz+DRSYsBiAuI+z77S
	T4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W4vu8agVHwvbXrsKUiOITU+gaO6bmn5JUQXLjONPufY=;
	b=rjz9Sxawh5M6kCs/+2qrRsy9j5GxD+q7xP6d1OJv7cB8+rrV/H6mG2D/hrDbNT3LQ5
	hEJOKLxZ5nTQhhEj6+k6SfiCnZPP83pmJzBZvKQEYglkUFqhWNbvLdXT9OUcY839xbta
	07oYCuhf148NKErYXN5G0kLLupRZQonPwpaSEwDsDMrX0cSalUetmGcrMFttiyLryUcy
	EH9An4FxTPtHHucnlKqj4eGbWHa+f5fQbZbyTv2Padm/aLyrct0ryhNP9lY2cpOIcn30
	1GGxUXkBx3rKQWv5xJOu+d+Do0RTdiEaGgnvoHboVjLSpMXsCR6WgH1QdDuhAOarfWyV
	ZLbw==
X-Gm-Message-State: APjAAAU5nE2ObI7VgtTsOnjccgw2TZd3k3gxG/Mv7ATMqXOFNngJhYDr
	6aL9OfC2VMI5/ikysFRaVuNJBcNKsfc=
X-Google-Smtp-Source: APXvYqwtmDeY5MG0Nl/9Ye1TK0v0EYWHC30rLpG2u7xYedf3tOBtWVpblvsPP8LeSn8ketKEvtw7rw==
X-Received: by 2002:a17:902:854a:: with SMTP id
	d10mr14049128plo.8.1557501586311; 
	Fri, 10 May 2019 08:19:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:17 -0700
Message-Id: <20190510151944.22981-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PULL 00/27] tcg: Add CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190510

for you to fetch changes up to 5f32c102ec3a0db4773d0f74b398191b578c0720:

  tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 07:58:11 -0700)

----------------------------------------------------------------
Add CPUClass::tlb_fill.
Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.

----------------------------------------------------------------
Richard Henderson (27):
      tcg: Add CPUClass::tlb_fill
      target/alpha: Convert to CPUClass::tlb_fill
      target/arm: Convert to CPUClass::tlb_fill
      target/cris: Convert to CPUClass::tlb_fill
      target/hppa: Convert to CPUClass::tlb_fill
      target/i386: Convert to CPUClass::tlb_fill
      target/lm32: Convert to CPUClass::tlb_fill
      target/m68k: Convert to CPUClass::tlb_fill
      target/microblaze: Convert to CPUClass::tlb_fill
      target/mips: Pass a valid error to raise_mmu_exception for user-only
      target/mips: Tidy control flow in mips_cpu_handle_mmu_fault
      target/mips: Convert to CPUClass::tlb_fill
      target/moxie: Convert to CPUClass::tlb_fill
      target/nios2: Convert to CPUClass::tlb_fill
      target/openrisc: Convert to CPUClass::tlb_fill
      target/ppc: Convert to CPUClass::tlb_fill
      target/riscv: Convert to CPUClass::tlb_fill
      target/s390x: Convert to CPUClass::tlb_fill
      target/sh4: Convert to CPUClass::tlb_fill
      target/sparc: Convert to CPUClass::tlb_fill
      target/tilegx: Convert to CPUClass::tlb_fill
      target/tricore: Convert to CPUClass::tlb_fill
      target/unicore32: Convert to CPUClass::tlb_fill
      target/xtensa: Convert to CPUClass::tlb_fill
      tcg: Use CPUClass::tlb_fill in cputlb.c
      tcg: Remove CPUClass::handle_mmu_fault
      tcg: Use tlb_fill probe from tlb_vaddr_to_host

 include/exec/cpu_ldst.h         |  50 +++--------
 include/exec/exec-all.h         |   9 --
 include/qom/cpu.h               |  12 ++-
 target/alpha/cpu.h              |   5 +-
 target/arm/internals.h          |  10 ++-
 target/cris/cpu.h               |   5 +-
 target/hppa/cpu.h               |   8 +-
 target/i386/cpu.h               |   5 +-
 target/lm32/cpu.h               |   5 +-
 target/m68k/cpu.h               |   5 +-
 target/microblaze/cpu.h         |   5 +-
 target/mips/internal.h          |   5 +-
 target/moxie/cpu.h              |   5 +-
 target/nios2/cpu.h              |   5 +-
 target/openrisc/cpu.h           |   5 +-
 target/ppc/cpu.h                |   7 +-
 target/riscv/cpu.h              |   5 +-
 target/s390x/internal.h         |   5 +-
 target/sh4/cpu.h                |   5 +-
 target/sparc/cpu.h              |   5 +-
 target/tricore/cpu.h            |   6 +-
 target/unicore32/cpu.h          |   5 +-
 target/xtensa/cpu.h             |   5 +-
 accel/tcg/cputlb.c              |  88 +++++++++++++++++--
 accel/tcg/user-exec.c           |  36 ++------
 target/alpha/cpu.c              |   5 +-
 target/alpha/helper.c           |  24 +++--
 target/alpha/mem_helper.c       |  16 ----
 target/arm/cpu.c                |  22 +----
 target/arm/helper.c             |  90 +++++++++++--------
 target/arm/op_helper.c          |  29 +-----
 target/arm/sve_helper.c         |   6 +-
 target/cris/cpu.c               |   5 +-
 target/cris/helper.c            |  61 ++++++-------
 target/cris/op_helper.c         |  28 ------
 target/hppa/cpu.c               |   5 +-
 target/hppa/mem_helper.c        |  16 ++--
 target/i386/cpu.c               |   5 +-
 target/i386/excp_helper.c       |  53 ++++++-----
 target/i386/mem_helper.c        |  21 -----
 target/lm32/cpu.c               |   5 +-
 target/lm32/helper.c            |   8 +-
 target/lm32/op_helper.c         |  16 ----
 target/m68k/cpu.c               |   2 +-
 target/m68k/helper.c            |  89 +++++++++----------
 target/m68k/op_helper.c         |  15 ----
 target/microblaze/cpu.c         |   5 +-
 target/microblaze/helper.c      | 101 ++++++++++-----------
 target/microblaze/op_helper.c   |  19 ----
 target/mips/cpu.c               |   5 +-
 target/mips/helper.c            |  81 ++++++++---------
 target/mips/op_helper.c         |  15 ----
 target/moxie/cpu.c              |   5 +-
 target/moxie/helper.c           |  65 +++-----------
 target/nios2/cpu.c              |   5 +-
 target/nios2/helper.c           | 170 +++++++++++++++++-------------------
 target/nios2/mmu.c              |  12 ---
 target/openrisc/cpu.c           |   5 +-
 target/openrisc/mmu.c           |  69 +++++++--------
 target/ppc/mmu_helper.c         |  16 ++--
 target/ppc/translate_init.inc.c |   5 +-
 target/ppc/user_only_helper.c   |  14 +--
 target/riscv/cpu.c              |   5 +-
 target/riscv/cpu_helper.c       |  50 +++++------
 target/s390x/cpu.c              |   5 +-
 target/s390x/excp_helper.c      |  67 +++++++++-----
 target/s390x/mem_helper.c       |  16 ----
 target/sh4/cpu.c                |   5 +-
 target/sh4/helper.c             | 189 +++++++++++++++++++---------------------
 target/sh4/op_helper.c          |  12 ---
 target/sparc/cpu.c              |   5 +-
 target/sparc/ldst_helper.c      |  15 ----
 target/sparc/mmu_helper.c       |  58 +++++++-----
 target/tilegx/cpu.c             |  10 ++-
 target/tricore/cpu.c            |   1 +
 target/tricore/helper.c         |  23 +++--
 target/tricore/op_helper.c      |  26 ------
 target/unicore32/cpu.c          |   5 +-
 target/unicore32/helper.c       |  23 -----
 target/unicore32/op_helper.c    |  14 ---
 target/unicore32/softmmu.c      |  13 ++-
 target/xtensa/cpu.c             |   5 +-
 target/xtensa/helper.c          |  33 ++++---
 83 files changed, 868 insertions(+), 1131 deletions(-)

