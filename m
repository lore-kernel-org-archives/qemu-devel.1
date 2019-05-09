Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E4EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E40A216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD43A1RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E40A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcAm-00078U-KJ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:04:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8q-0005v9-NB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8p-00070O-FO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:38435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8p-0006zl-5B
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id 10so722985pfo.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=v+OZD7XeZ0xihN95A1VXMos8Py5FqJIr9OLxNhWl3Hc=;
	b=GD43A1RQqptsAD4M7h+0PJ7i3dQMzstimm6vFBWPzzWsjQ+CtWy/S8MjO0BaEWr4zX
	VmzRseTpQey0cOwJg1FJek2yohKzeiZl3Og1vd0H3hielCNH2+aWbyNMiaUnNPxv7Ign
	G8rkRmbGrSl1jBiLPMYKLWBw5RyoA/nYWMS7m8nIA9oTmMomoGrvKHORWvuq5ZcWUVwW
	Cuv0TwwRu8kAHOHHsRp030LteMQhJa5UmTSaRPEYKONj1Y5dPHsgdi/c+uZjWVeQ/zaC
	yb3/JT3iTMoGrJs6Mup9P4zLfAZWMahe8zkYsLTuTKJQ1isFHwBZf+9mTkrooVqATfjX
	8bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=v+OZD7XeZ0xihN95A1VXMos8Py5FqJIr9OLxNhWl3Hc=;
	b=Z+MKPZAifXEt6EFRXeY4S8MB7s7jlLBGAskmhprK+HDbC/7nf+f2imtP7gUwdK9Ary
	BFLpKGUkm9YoMkIFhkpQu4KkHiwkDscQtU7JouRK1cJGM0MhnPNxfc5mC8nbdIC/paCJ
	R4WsPeBjx7btnHcvPVPniZf1dfnAeA9gnkDsWwhPBI6CKjY6H4FdfAumQjuZS3Z1LMpr
	Q5gJ7VsLmiLCpb8snX+1iUS8fl90x+mCcB+RMVTlfwDA2mK0dl5bIpJGZHnSUZNg56Va
	zdHphDnHMFVv88e9YeaRz51BjMGGo026KwZpFWdwBMk7cm/3HEN6Mp9OI+9UHZuwnHGX
	50Zg==
X-Gm-Message-State: APjAAAV250Rf1HkJ95KPTKZFV+l4mDKJY1KAAZEY1/VgoKyJ+QjddD4E
	rQLmJel1AmJ+hoiMS2mOMZltrxe1Fms=
X-Google-Smtp-Source: APXvYqztTgiNGHcnUK+xTdQRrW4EW4cqJG1/UWfjOp5SFj4d/fHLYG9bXpcRqOAEl0UpXKIatyYxNg==
X-Received: by 2002:a63:9d8d:: with SMTP id i135mr3163483pgd.245.1557381768728;
	Wed, 08 May 2019 23:02:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.47
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:19 -0700
Message-Id: <20190509060246.4031-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: [Qemu-devel] [PATCH v2 00/27] tcg: Add CPUClass::tlb_fill
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from v1:
  * Do not unify user-only and system tlb_fill functions
    (alpha, microblaze, nios2, s390x, sparc, xtensa).
  * Split the mips patch into multiple.
  * Other random changes per review.

Patches without review:
0009-target-microblaze-Convert-to-CPUClass-tlb_fill.patch
0010-target-mips-Pass-a-valid-error-to-raise_mmu_excep.patch (new)
0011-target-mips-Tidy-control-flow-in-mips_cpu_handle_.patch (new)
0012-target-mips-Convert-to-CPUClass-tlb_fill.patch
0014-target-nios2-Convert-to-CPUClass-tlb_fill.patch
0018-target-s390x-Convert-to-CPUClass-tlb_fill.patch
0020-target-sparc-Convert-to-CPUClass-tlb_fill.patch
0024-target-xtensa-Convert-to-CPUClass-tlb_fill.patch

Blurb from v1:

There is currently a lot of confusion between foo_cpu_handle_mmu_fault
and tlb_fill.

In particular, foo_cpu_handle_mmu_fault was only defined for user-only,
and its only valid action was to set up the cpu for cpu_loop_exit so
that we can deliver a SIGSEGV to the guest.  And yet, we had code that
tried to return from the host SIGSEGV handler to retry the instruction.

We had, for some targets, a definition of foo_cpu_handle_mmu_fault
for softmmu.  Sometimes this was called from tlb_fill, sometimes not.

Finally, we have a use case for SVE that wants a non-faulting tlb_fill,
so while we're changing the interface, let's go ahead and include that.


r~


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

 include/exec/cpu_ldst.h         |  50 ++-------
 include/exec/exec-all.h         |   9 --
 include/qom/cpu.h               |  12 +-
 target/alpha/cpu.h              |   5 +-
 target/arm/internals.h          |  10 +-
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
 accel/tcg/cputlb.c              |  88 +++++++++++++--
 accel/tcg/user-exec.c           |  36 ++----
 target/alpha/cpu.c              |   5 +-
 target/alpha/helper.c           |  24 ++--
 target/alpha/mem_helper.c       |  16 ---
 target/arm/cpu.c                |  22 +---
 target/arm/helper.c             |  90 ++++++++-------
 target/arm/op_helper.c          |  29 +----
 target/arm/sve_helper.c         |   6 +-
 target/cris/cpu.c               |   5 +-
 target/cris/helper.c            |  61 ++++++-----
 target/cris/op_helper.c         |  28 -----
 target/hppa/cpu.c               |   5 +-
 target/hppa/mem_helper.c        |  16 ++-
 target/i386/cpu.c               |   5 +-
 target/i386/excp_helper.c       |  53 +++++----
 target/i386/mem_helper.c        |  21 ----
 target/lm32/cpu.c               |   5 +-
 target/lm32/helper.c            |   8 +-
 target/lm32/op_helper.c         |  16 ---
 target/m68k/cpu.c               |   2 +-
 target/m68k/helper.c            |  89 ++++++++-------
 target/m68k/op_helper.c         |  15 ---
 target/microblaze/cpu.c         |   5 +-
 target/microblaze/helper.c      | 101 ++++++++---------
 target/microblaze/op_helper.c   |  19 ----
 target/mips/cpu.c               |   5 +-
 target/mips/helper.c            |  81 ++++++--------
 target/mips/op_helper.c         |  15 ---
 target/moxie/cpu.c              |   5 +-
 target/moxie/helper.c           |  65 +++--------
 target/nios2/cpu.c              |   5 +-
 target/nios2/helper.c           | 166 ++++++++++++++--------------
 target/nios2/mmu.c              |  12 --
 target/openrisc/cpu.c           |   5 +-
 target/openrisc/mmu.c           |  69 ++++++------
 target/ppc/mmu_helper.c         |  16 ++-
 target/ppc/translate_init.inc.c |   5 +-
 target/ppc/user_only_helper.c   |  14 ++-
 target/riscv/cpu.c              |   5 +-
 target/riscv/cpu_helper.c       |  50 ++++-----
 target/s390x/cpu.c              |   5 +-
 target/s390x/excp_helper.c      |  67 +++++++----
 target/s390x/mem_helper.c       |  16 ---
 target/sh4/cpu.c                |   5 +-
 target/sh4/helper.c             | 189 +++++++++++++++-----------------
 target/sh4/op_helper.c          |  12 --
 target/sparc/cpu.c              |   5 +-
 target/sparc/ldst_helper.c      |  15 ---
 target/sparc/mmu_helper.c       |  78 +++++++------
 target/tilegx/cpu.c             |  10 +-
 target/tricore/cpu.c            |   1 +
 target/tricore/helper.c         |  23 ++--
 target/tricore/op_helper.c      |  26 -----
 target/unicore32/cpu.c          |   5 +-
 target/unicore32/helper.c       |  23 ----
 target/unicore32/op_helper.c    |  14 ---
 target/unicore32/softmmu.c      |  13 ++-
 target/xtensa/cpu.c             |   5 +-
 target/xtensa/helper.c          |  33 +++---
 83 files changed, 876 insertions(+), 1139 deletions(-)

-- 
2.17.1


