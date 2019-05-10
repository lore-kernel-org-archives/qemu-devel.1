Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED14C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED912217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbRUT0he"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED912217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAhV-0000ro-4e
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 14:56:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfS-0007tN-8j
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfM-0005ga-3L
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:50 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hPAfL-0005bc-Ko
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:43 -0400
Received: by mail-pg1-x52f.google.com with SMTP id a3so3433564pgb.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=sm/vFWJ2/zn2MDsb8Ww+k6vI3sYGZF9sJp17u5ObOjU=;
	b=gbRUT0heXxbg4nl3/0N/cwwAyp/KcdnDpKDKHVmtoVD24H1SA3RDHZU0o1cT8eYhAd
	iF/fT3WDyJiYFdHQAF+9NvKUtcosQgDmE+Ch137k5UGXiJ5aVsOOVFSwYegQjOum2B3N
	Tfpmfv+hesXD295+AAQR66fHaHLPnVTVklSg2zsQyO6lJlHv3bNiXz37Z0JqGsIZRxMw
	bud7Zt77k3eJGvuyS1DjBw/KKLbZMKKyBI5em3Cy5XUoKloG9K2gaKVOvOBatp/sXfBt
	rDYp7Z3xRTl2O9Phjiu5/oprpwbIqIh4Pt6UUeNtjveTCtQGlvL2XsM5WQbPVynXqi2V
	DYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=sm/vFWJ2/zn2MDsb8Ww+k6vI3sYGZF9sJp17u5ObOjU=;
	b=laIsqiMZeUmABkRGI7TpTgBTqRAB5oNMpSWlUmh2IALzISrs+ichfGTXfDqTb0mwWb
	hzDhVfrKLB18WPDajzHl68ggrCqsvNiYierB9SvxFt5Moh9q+XO51M5NjWs6CPG1WvXf
	7GfvVytc3uCkP6OH5UDr7e7x0Iep8wsHvZO01qfjlaAJ0Y032H1BG1JS1dmSsY8mlkCH
	Q4K3CpaaNgwj1APuh/E1UBtpZJTHhCHj+VgHfdOzA2PDp/d+zbMhUudDbPcUT0Nonfpq
	PlFwn8mE0MIiqBc7pI0sNuegKwJ6CoAjgBwhcHyb8ck798u0hO49qf8tUCwJhNE/XbQi
	JZCQ==
X-Gm-Message-State: APjAAAXdYnIyZCbcTYxZy5020cDEnYkoiQJtEiO9OXe/EZa/JoAl/n3u
	LNiysbdXuJKFShPeOlGk+1MW+ulxt2s=
X-Google-Smtp-Source: APXvYqwczwjVG5SPgknKO+4Hf4iOOmuH17S/rAEO5j26d/b6TzUK+4hKCHNNytNke27dB2rr+ZzxXA==
X-Received: by 2002:aa7:8a53:: with SMTP id n19mr16322015pfa.11.1557514481039; 
	Fri, 10 May 2019 11:54:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	q20sm12733146pfi.166.2019.05.10.11.54.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 11:54:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 11:54:31 -0700
Message-Id: <20190510185438.29533-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PULL v2 00/27] tcg: Add CPUClass::tlb_fill
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

Changes in v2:

  * Fix --disable-tcg compilation for x86 and s390x.
    I adjusted every target/ that used any CONFIG_TCG in cpu.c.
    but then afterward I see that only x86 and s390x have had
    their Makefiles adjusted to make --disable-tcg actually work.

  * Fix Werror for 64-bit on 32-bit.

Only re-posting changed patches.


r~


The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190510

for you to fetch changes up to 4811e9095c0491bc6f5450e5012c9c4796b9e59d:

  tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 11:12:50 -0700)

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

