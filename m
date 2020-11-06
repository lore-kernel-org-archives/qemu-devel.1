Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A3C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9841A20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5VlqOcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9841A20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasT4-0006Br-Ih
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRN-0004Mw-Qt
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:29 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRJ-0006to-8Y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:29 -0500
Received: by mail-pf1-x429.google.com with SMTP id z3so30906pfb.10
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dkPQWma2Mypff5ie8s38chap8PGgRqouLTX75a1GMRU=;
 b=n5VlqOcCsPnYcXHcwoiRa79PKxClnYgW522NHFl5Pr096XCBMP2EdRCz/i/TczJZdg
 EQYLLmb7xnOd8P9JkOPuWWanqTPFKP8oNf9Ef1tZ/mhf/gHqY4NU3/qlnorFBEza1+Pc
 sgep/5zwypJyiT6Wg3sO3EIST9HGMj76z/JYVmZTUyCURtClqm7MPLbK7WWFmPV7oD9L
 Ig9QQk9r+O33yzsXdUn3ggWcFk0nKt36KzDAR1t81YiQhdanYBnnzQIpNO9nXxPVtcmE
 gfTLfI2N+/FYL9oNXTtZ5fYzWVgwbgDD+8ETbt1GG9Y4F3NqelHOXCJrGS/vxMuEXyLj
 Ks4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dkPQWma2Mypff5ie8s38chap8PGgRqouLTX75a1GMRU=;
 b=rUBpnnTUZ2KqG2KRiMBBVnlYx5CKGqob52vA9U6la/srULEAFNx44aoI5x+lDKBGd3
 TI36dYE0wxfpxUXEzpsJWL/0eaqVxU1HpnAYmX4X8bg7JZz+gM6eB2Ho3PfrfZXQXyb7
 sPd8Hb+1BddD8AXYtBQ1Xy5ZmZ2BBmozSppCqo3FIb3aCT78g4oDtOvKXmKu62QVbgnE
 blWINWhsOzmGf+9GBOfRE7H69P3SvTcpQ4u5af18QPHUhwAcmwf0SdyU3zBtVU1HTVTN
 14huBRwUe2xBLQaeXhy886rKb+qZXE2LtVIbmqWq+dPd2wQsA0VXJqM7vbIKC9JQxamz
 iPWg==
X-Gm-Message-State: AOAM532o9QnHM2wQdN0hy8uXY6ui2sIW45zyKXpd09U8mYefnvZpHw+/
 +jjhD//aAW3+Q2+xD81ft/UoSrU+FNnKuA==
X-Google-Smtp-Source: ABdhPJzQ7SW2IRxr7a9lWBEX5oBxbk5j3fYOMCuLMXv/yWfziQIs/4smbHAEElVvQd3xt0bEMfWm6Q==
X-Received: by 2002:a17:90a:6c96:: with SMTP id
 y22mr136198pjj.63.1604633363110; 
 Thu, 05 Nov 2020 19:29:23 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/41] Mirror map JIT memory for TCG
Date: Thu,  5 Nov 2020 19:28:40 -0800
Message-Id: <20201106032921.600200-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is my take on Joelle's patch set:
https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg07837.html

Changes for v3:
  * Even more patches -- all tcg backends converted.
  * Fixups for darwin/ios merged (Joelle).
  * Feature renamed to splitwx (Paolo).


r~


Richard Henderson (41):
  tcg: Enhance flush_icache_range with separate data pointer
  tcg: Move tcg prologue pointer out of TCGContext
  tcg: Move tcg epilogue pointer out of TCGContext
  tcg: Add in_code_gen_buffer
  tcg: Introduce tcg_splitwx_to_{rx,rw}
  tcg: Adjust TCGLabel for const
  tcg: Adjust tcg_out_call for const
  tcg: Adjust tcg_out_label for const
  tcg: Adjust tcg_register_jit for const
  tcg: Adjust tb_target_set_jmp_target for split-wx
  tcg: Make DisasContextBase.tb const
  tcg: Make tb arg to synchronize_from_tb const
  tcg: Use Error with alloc_code_gen_buffer
  tcg: Add --accel tcg,split-wx property
  accel/tcg: Support split-wx for linux with memfd
  accel/tcg: Support split-wx for darwin/iOS with vm_remap
  tcg: Return the TB pointer from the rx region from exit_tb
  tcg/i386: Support split-wx code generation
  tcg/aarch64: Use B not BL for tcg_out_goto_long
  tcg/aarch64: Implement flush_idcache_range manually
  tcg/aarch64: Support split-wx code generation
  disas: Push const down through host disasassembly
  tcg/tci: Push const down through bytecode reading
  tcg: Introduce tcg_tbrel_diff
  tcg/ppc: Use tcg_tbrel_diff
  tcg/ppc: Use tcg_out_mem_long to reset TCG_REG_TB
  tcg/ppc: Support split-wx code generation
  tcg/sparc: Use tcg_tbrel_diff
  tcg/sparc: Support split-wx code generation
  tcg/s390: Use tcg_tbrel_diff
  tcg/s390: Support split-wx code generation
  tcg/riscv: Fix branch range checks
  tcg/riscv: Remove branch-over-branch fallback
  tcg/riscv: Support split-wx code generation
  accel/tcg: Add mips support to alloc_code_gen_buffer_splitwx_memfd
  tcg/mips: Do not assert on relocation overflow
  tcg/mips: Support split-wx code generation
  tcg/arm: Support split-wx code generation
  tcg: Remove TCG_TARGET_SUPPORT_MIRROR
  tcg: Constify tcg_code_gen_epilogue
  tcg: Constify TCGLabelQemuLdst.raddr

 accel/tcg/tcg-runtime.h      |   2 +-
 include/disas/dis-asm.h      |   4 +-
 include/disas/disas.h        |   2 +-
 include/exec/exec-all.h      |   2 +-
 include/exec/gen-icount.h    |   4 +-
 include/exec/log.h           |   2 +-
 include/exec/translator.h    |   2 +-
 include/hw/core/cpu.h        |   3 +-
 include/sysemu/tcg.h         |   3 +-
 include/tcg/tcg-op.h         |   2 +-
 include/tcg/tcg.h            |  56 +++++--
 tcg/aarch64/tcg-target.h     |   8 +-
 tcg/arm/tcg-target.h         |  10 +-
 tcg/i386/tcg-target.h        |   9 +-
 tcg/mips/tcg-target.h        |  10 +-
 tcg/ppc/tcg-target.h         |   4 +-
 tcg/riscv/tcg-target.h       |  10 +-
 tcg/s390/tcg-target.h        |  11 +-
 tcg/sparc/tcg-target.h       |  10 +-
 tcg/tci/tcg-target.h         |  11 +-
 accel/tcg/cpu-exec.c         |  41 +++--
 accel/tcg/tcg-all.c          |  26 ++-
 accel/tcg/tcg-runtime.c      |   4 +-
 accel/tcg/translate-all.c    | 307 +++++++++++++++++++++++++++--------
 accel/tcg/translator.c       |   4 +-
 bsd-user/main.c              |   2 +-
 disas.c                      |   2 +-
 disas/capstone.c             |   2 +-
 linux-user/main.c            |   2 +-
 softmmu/physmem.c            |   9 +-
 target/arm/cpu.c             |   3 +-
 target/arm/translate-a64.c   |   2 +-
 target/avr/cpu.c             |   3 +-
 target/hppa/cpu.c            |   3 +-
 target/i386/cpu.c            |   3 +-
 target/microblaze/cpu.c      |   3 +-
 target/mips/cpu.c            |   3 +-
 target/riscv/cpu.c           |   3 +-
 target/rx/cpu.c              |   3 +-
 target/sh4/cpu.c             |   3 +-
 target/sparc/cpu.c           |   3 +-
 target/tricore/cpu.c         |   2 +-
 tcg/tcg-op.c                 |  15 +-
 tcg/tcg.c                    |  86 ++++++++--
 tcg/tci.c                    |  60 ++++---
 accel/tcg/trace-events       |   2 +-
 tcg/aarch64/tcg-target.c.inc | 139 ++++++++++++----
 tcg/arm/tcg-target.c.inc     |  41 ++---
 tcg/i386/tcg-target.c.inc    |  36 ++--
 tcg/mips/tcg-target.c.inc    |  97 +++++------
 tcg/ppc/tcg-target.c.inc     | 105 ++++++------
 tcg/riscv/tcg-target.c.inc   | 125 +++++---------
 tcg/s390/tcg-target.c.inc    |  91 +++++------
 tcg/sparc/tcg-target.c.inc   |  58 +++----
 tcg/tcg-ldst.c.inc           |   2 +-
 tcg/tcg-pool.c.inc           |   6 +-
 tcg/tci/tcg-target.c.inc     |   2 +-
 57 files changed, 917 insertions(+), 546 deletions(-)

-- 
2.25.1


