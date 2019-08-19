Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E790C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB382087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+fYGM2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB382087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpNo-0003VR-Sy
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLk-00019p-DJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLj-0005w4-4H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLi-0005vU-VL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:37:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id o70so1947654pfg.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=UAuI24ypugSOADw/ZQRUxs1qwCQQ7Fi3EwXHwPu9388=;
 b=T+fYGM2c7huxQqMYjJE4FCDtBu1AjZR8/FPJa3mwgqc2uxzV6kOtA6SqJzFt0zij9W
 XKOPKbIgZMoV69o155ysDGSrU2XjesEz0IyUeuz1LGp2Y+2s+g0sHuWtQMM0CjJjbFMy
 mRCC37toz03sOpxGrq7qqsuL1+aDjEp6/iMTIc37Sr2FPwh/gnJoSLxDt7X9b1GfchuU
 uqeYTg469JA1vkgDZII5JbUKm+5j3cvEuAA8ihoSRuniD8gz5tWn5a+HU7otemnhkQEd
 gpgfnpyRd9Z9yv9lKumrUMbLfsICZiKW0dFWtJ2EGr/RwKvMmjHZ0/vs0IsATuyxVGN1
 EGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UAuI24ypugSOADw/ZQRUxs1qwCQQ7Fi3EwXHwPu9388=;
 b=J7LOR1MobfJGcIL8utWA2ncYnICNZ4IZLHujqUwNEYt9ry7+mogiUi0OvKquhgMeGZ
 a+jmH+C3LhcIu/+PTVOM/pBpu3JHAVWEGCyCptHBtMu8UJiEe8IsQXcjm2YtjEJCGlB+
 FZtSnFmYUwNkPIrTsSTIt8cEYnk7qW7aHyj5wKw9rfsxmvOndO1paC87xmpfZ6Gv3yOC
 U1+tsE0tBJCtdIuv4xK3Gxh3t8ddkq0hbnlSZUsebe3fh1InOOGcjFuJVPF0uH1sBe9C
 mznVfH/QY5TPHOkipOD9UEKyHNTOz7Q/uY3CVMnzo57uYFiA/YzjlDUJ9OvMuYk7JzaY
 /U/Q==
X-Gm-Message-State: APjAAAV6PMhdDcmfUSKDf2N/xH5F6bM03Dwzc9CDQ5qgzwJ3b0ZBQW9e
 +V+tptlP2Up25Ta3r6uVZVegOmm5oos=
X-Google-Smtp-Source: APXvYqz1PZ/J9ZaqMeNxYmPJ7XZrol5EjlOSeyELr66N4pqBMyZD1lv7NOIQF9MuJl+FRw8859qffQ==
X-Received: by 2002:a63:9e43:: with SMTP id r3mr22269709pgo.148.1566250677506; 
 Mon, 19 Aug 2019 14:37:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:47 -0700
Message-Id: <20190819213755.26175-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 00/68] target/arm: Convert aa32 base isa to
 decodetree
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This unifies the implementation of the actual instructions for
a32, t32, and t16.

This has been tested by running the debian 9 armhf installer,
which does a far amount of switching between arm and thumb modes.
I've also run Peter's ARM TFM image, and all of the existing
RISU tests that we have.  (Our RISU test cases are nowhere near
complete for 32-bit mode, but it did find 3 bugs, so not useless.)

Based-on: 20190819151743.17267-1-richard.henderson@linaro.org
"[PULL 0/3] decodetree improvements"

Changes from v1:
  * Lots of prep patches merged.
  * Lots of patches split into smaller bits.
    Which is why this patch set is larger than v1 despite the merge.
  * Do not use STREG_EXC_RET in Hyp mode (patch 3).
  * Map more UNPREDICTABLE to UNDEF in LDM/STM (patches 28-30).
  * Split gen_nop_hint (patch 59).
  * Do not move single-step check to gen_goto_tb, but do simplify
    gen_jmp by inlining gen_bx_im (patch 68).


r~


Richard Henderson (68):
  target/arm: Use store_reg_from_load in thumb2 code
  target/arm: Add stubs for aa32 decodetree
  target/arm: Convert Data Processing (register)
  target/arm: Convert Data Processing (reg-shifted-reg)
  target/arm: Convert Data Processing (immediate)
  target/arm: Convert multiply and multiply accumulate
  target/arm: Simplify UMAAL
  target/arm: Convert Saturating addition and subtraction
  target/arm: Convert Halfword multiply and multiply accumulate
  target/arm: Simplify op_smlaxxx for SMLAL*
  target/arm: Simplify op_smlawx for SMLAW*
  target/arm: Convert MSR (immediate) and hints
  target/arm: Convert MRS/MSR (banked, register)
  target/arm: Convert Cyclic Redundancy Check
  target/arm: Convert BX, BXJ, BLX (register)
  target/arm: Convert CLZ
  target/arm: Convert ERET
  target/arm: Convert the rest of A32 Miscelaneous instructions
  target/arm: Convert T32 ADDW/SUBW
  target/arm: Convert load/store (register, immediate, literal)
  target/arm: Convert Synchronization primitives
  target/arm: Convert USAD8, USADA8, SBFX, UBFX, BFC, BFI, UDF
  target/arm: Convert Parallel addition and subtraction
  target/arm: Convert Packing, unpacking, saturation, and reversal
  target/arm: Convert Signed multiply, signed and unsigned divide
  target/arm: Convert MOVW, MOVT
  target/arm: Convert LDM, STM
  target/arm: Diagnose writeback register in list for LDM for v7
  target/arm: Diagnose too few registers in list for LDM/STM
  target/arm: Diagnose base == pc for LDM/STM
  target/arm: Convert B, BL, BLX (immediate)
  target/arm: Convert SVC
  target/arm: Convert RFE and SRS
  target/arm: Convert Clear-Exclusive, Barriers
  target/arm: Convert CPS (privileged)
  target/arm: Convert SETEND
  target/arm: Convert PLI, PLD, PLDW
  target/arm: Convert Unallocated memory hint
  target/arm: Convert Table Branch
  target/arm: Convert SG
  target/arm: Convert TT
  target/arm: Simplify disas_thumb2_insn
  target/arm: Simplify disas_arm_insn
  target/arm: Add skeleton for T16 decodetree
  target/arm: Convert T16 data-processing (two low regs)
  target/arm: Convert T16 load/store (register offset)
  target/arm: Convert T16 load/store (immediate offset)
  target/arm: Convert T16 add pc/sp (immediate)
  target/arm: Convert T16 load/store multiple
  target/arm: Convert T16 add/sub (3 low, 2 low and imm)
  target/arm: Convert T16 one low register and immediate
  target/arm: Convert T16 branch and exchange
  target/arm: Convert T16 add, compare, move (two high registers)
  target/arm: Convert T16 adjust sp (immediate)
  target/arm: Convert T16, extract
  target/arm: Convert T16, Change processor state
  target/arm: Convert T16, Reverse bytes
  target/arm: Convert T16, nop hints
  target/arm: Split gen_nop_hint
  target/arm: Convert T16, push and pop
  target/arm: Convert T16, Conditional branches, Supervisor call
  target/arm: Convert T16, Miscellaneous 16-bit instructions
  target/arm: Convert T16, shift immediate
  target/arm: Convert T16, load (literal)
  target/arm: Convert T16, Unconditional branch
  target/arm: Convert T16, long branches
  target/arm: Clean up disas_thumb_insn
  target/arm: Inline gen_bx_im into callers

 target/arm/translate.c       | 7068 ++++++++++++++--------------------
 target/arm/Makefile.objs     |   24 +
 target/arm/a32-uncond.decode |   74 +
 target/arm/a32.decode        |  534 +++
 target/arm/t16.decode        |  279 ++
 target/arm/t32.decode        |  629 +++
 6 files changed, 4536 insertions(+), 4072 deletions(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t16.decode
 create mode 100644 target/arm/t32.decode

-- 
2.17.1


