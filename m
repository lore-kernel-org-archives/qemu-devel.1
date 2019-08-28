Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D37C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B429214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSZxPhVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B429214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33J9-0005tZ-AD
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fd-0002vd-J1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fc-00083T-3y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:38750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fb-00082q-Tt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id o70so391440pfg.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s9P79p8xzPBZXs21e7DuKNHBq2BT565iMYq602qI4uw=;
 b=rSZxPhVIhE5L+RcsaqHafjyR15yPAtyZleMvpvOBsJeZ+JXGlTjpWSdHG5ZLrSSTEo
 PGvsQnqVFXC8wj7aOP/3S1EiUO3Ysn2yJn+KNscLfexOFRP7r8UNrZtKaqLYNvJK7tWG
 FKhTEUnTPFB6wYNPXKBKc42AGOb60ZKGnENr5lpiBveAaDPJlRIz92DXRdTa7UpD/A2i
 y7N4fAZFXYRs9kCv69P7WVPcxwENz7wPALG7lL50c1YT4fm+HypsSM1zhjCrUIz/TsTg
 mcpvSbRlV5izbAVCcKMK+quM/V6jC0jffyvV18Um9hRSVj719jW++KQm947OwnPM4GV6
 hv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s9P79p8xzPBZXs21e7DuKNHBq2BT565iMYq602qI4uw=;
 b=tgoRxQFH3+jB5ak8h/2QxdytCWECmy9lBw4srOpLZoRpVzu7hKEbAG5tXvTAW1fPYm
 VLB54+sz2oXvYlzN6zvJph0qk6fmiXM7QBncl3irokoCwSSCUuZ9QdTZ1Eku1PHYMBgr
 KIgCe4bUqQDS2zmVX4iS1mW38EG5613oJM2lasdOzEHpDhPcWypWNq7at6v0iHq337OK
 S2D+6zmYTgSgAtPvpgXI6hHoAtkEYE1dapHb/svZFxGBi6tcJaqBbMjJSnkaFl74dFW5
 uQIgQZyifwcvpskJo8kHItgDan1uABvVrk5HmqkQ26QsHdS6ADLzZ4IZqHew1cqrdnHJ
 3jIA==
X-Gm-Message-State: APjAAAXLp+hcnuiprYO71q8aOV4TWx5dZch/rQLnA1+ifGSXOjzm36ZV
 sGvXg4gT8XiTVBE+W8G8//F/z2lSc3w=
X-Google-Smtp-Source: APXvYqzdE2GkU3EUPVb99uVvD0dCnrU+kdPuj64/cTrdK4nqK+Oke2LFEBJZzTpYkoDldl23RFqAOg==
X-Received: by 2002:a62:1858:: with SMTP id 85mr6647818pfy.120.1567019098356; 
 Wed, 28 Aug 2019 12:04:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:04:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:47 -0700
Message-Id: <20190828190456.30315-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [PATCH v3 00/69] target/arm: Convert aa32 base isa to
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

There are a number of changes from v2, mostly from review feedback.
I think that I've annotated them all via "v3:" tags after the commit,
but I may have missed some.

The patches without Reviewed-by are:

0019-target-arm-Convert-T32-ADDW-SUBW.patch
0022-target-arm-Diagnose-UNPREDICTABLE-ldrex-strex-cas.patch
0035-target-arm-Convert-Clear-Exclusive-Barriers.patch
0057-target-arm-Convert-T16-Change-processor-state.patch


r~


Richard Henderson (69):
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
  target/arm: Diagnose UNPREDICTABLE ldrex/strex cases
  target/arm: Convert USAD8, USADA8, SBFX, UBFX, BFC, BFI, UDF
  target/arm: Convert Parallel addition and subtraction
  target/arm: Convert packing, unpacking, saturation, and reversal
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

 target/arm/translate.c       | 7166 +++++++++++++++-------------------
 target/arm/Makefile.objs     |   24 +
 target/arm/a32-uncond.decode |   74 +
 target/arm/a32.decode        |  534 +++
 target/arm/t16.decode        |  281 ++
 target/arm/t32.decode        |  631 +++
 6 files changed, 4641 insertions(+), 4069 deletions(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t16.decode
 create mode 100644 target/arm/t32.decode

-- 
2.17.1


