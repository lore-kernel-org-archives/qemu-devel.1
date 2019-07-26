Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD9C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9B720693
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt8tMQpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4NF-0003rS-Ht
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4MY-0001kt-S5
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4MW-00077I-EW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4MW-00073i-3E
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id k189so6067585pgk.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=qFigwqxkZ9qhX2+b3zlDbnkq417ogpiBOSL/2AuGB2I=;
 b=kt8tMQpvJp0uFngsozpYNhdh3fTIKNepILssaQNkoXQLS3q0KjkeYrssTOvCbaQMCE
 Hw1JnSbkjEV962kZEjM5rhc1C0XDfbUJT1zAP0F7iveSAzQgm/ClT5/xJikRnpbAFQCK
 iRzjhfcTJW2/zkNRHvaPdEUS+ge3oQcfIMq/ioTr+UGcW0fVVENDdN9eUOwJ29uso26X
 +fe5TwpvnvXVysPh9UMzdVIHsgioVjdFJ9KM+GDtXLVA0pB9XswmxqrOX3NnqlsrinOO
 aPbLX7BSZfyGu7VcVVV6WMrgNtWapPzB5PO5h0LHLhJkZpC3cTvGz9+zoRlIn4tzIPsp
 nIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qFigwqxkZ9qhX2+b3zlDbnkq417ogpiBOSL/2AuGB2I=;
 b=HL+F4kVfOwiRHiyvV5Mx2WfoI7+UfLfWX58VEL2dJ7u1pNHIZVmUdVRakOisyO1PjT
 r7/BNV01BHVtSjZKO/w5jPm2MJIjbhjiFjvi+iClzUzdCvuwuG/Ve0z1tjltaI9qdIDA
 xT9EE0HqOJR2b+NyxtIv/3bO3VhD7m1SAzMeILv3rmVL4V8PCQnv5HLkYAHz8fFf1Wfr
 0Vb1BtfDig5x3fmIS1h7iPg/Iiyq3kRJYeK3VPywpD9QIYIQGzEFBa0L9LryvWAyOxKr
 sQ8D9buD/8UennsUrS8RZiB5v3zUDl1FMU4ZuUCfhhqAyHnLOUZYktjRGztFIPAVopTl
 lBhw==
X-Gm-Message-State: APjAAAXcII6tTI17aD83zjo7ebPmmvTMkb02MSy0SBy82wqMzawGrVcl
 DgqFI04TzFlPa5beE3WvZHGBIvFsR0M=
X-Google-Smtp-Source: APXvYqyObypCgcQjsd1hBq+pm5P3Sg7v/dw9PGIDfKy5D6OTFroaNBaRa24r3v7ORNR6jrKDPl9EJA==
X-Received: by 2002:a65:5082:: with SMTP id r2mr66447352pgp.170.1564163434091; 
 Fri, 26 Jul 2019 10:50:34 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:25 -0700
Message-Id: <20190726175032.6769-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 00/67] target/arm: Convert aa32 base isa to
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This unifies the implementation of the actual instructions
for a32, t32, and t16.  In order to make this happen, we
need several preliminary cleanups.  Most importantly to how
we handle the architectural representation of PC.

I attempt to convert single groups of instructions at once,
as they are grouped in the sections of the encoding sections
of the manual.

This has been tested by running the debian 9 armhf installer,
which does a far amount of switching between arm and thumb modes.
I've also run Peter's ARM TFM image, and all of the existing
RISU tests that we have.  (Our RISU test cases are nowhere near
complete for 32-bit mode, but it did find 3 bugs, so not useless.)

What's left is converting NEON and iwmmxt, then we could start
merging some of the decoders and tidying the top-level interface
further.

We will need to convert NEON in order to have a good chance at
finishing the ARMv8.2-FHP extension.


r~


Richard Henderson (67):
  decodetree: Allow !function with no input bits
  target/arm: Remove offset argument to gen_exception_insn
  target/arm: Remove offset argument to gen_exception_bkpt_insn
  target/arm: Remove offset argument to gen_exception_internal_insn
  target/arm: Use the saved value of the insn address
  target/arm: Introduce pc_read
  target/arm: Introduce add_reg_for_lit
  target/arm: Use store_reg_from_load in thumb2 code
  target/arm: Fold a pc load into load_reg
  target/arm: Move test for AL into arm_skip_unless
  target/arm: Add stubs for aa32 decodetree
  target/arm: Introduce gen_illegal_op
  target/arm: Convert Data Processing (reg, reg-shifted-reg, imm)
  target/arm: Convert multiply and multiply accumulate
  target/arm: Convert Saturating addition and subtraction
  target/arm: Convert Halfword multiply and multiply accumulate
  target/arm: Convert MSR (immediate) and hints
  target/arm: Convert MRS/MSR (banked, register)
  target/arm: Convert Cyclic Redundancy Check
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
  target/arm: Convert T16, push and pop
  target/arm: Convert T16, Conditional branches, Supervisor call
  target/arm: Convert T16, Miscellaneous 16-bit instructions
  target/arm: Convert T16, shift immediate
  target/arm: Convert T16, load (literal)
  target/arm: Convert T16, Unconditional branch
  target/arm: Convert T16, long branches
  target/arm: Clean up disas_thumb_insn
  target/arm: Move singlestep check from gen_jmp to gen_goto_tb
  target/arm: Merge gen_bx_im into trans_BLX_i

 target/arm/helper.h               |    1 -
 target/arm/translate.h            |   10 +
 target/arm/op_helper.c            |   15 -
 target/arm/translate-vfp.inc.c    |   41 +-
 target/arm/translate.c            | 7142 ++++++++++++-----------------
 scripts/decodetree.py             |    5 +-
 target/arm/Makefile.objs          |   24 +
 target/arm/a32-uncond.decode      |   74 +
 target/arm/a32.decode             |  534 +++
 target/arm/t16.decode             |  279 ++
 target/arm/t32.decode             |  629 +++
 tests/decode/succ_function.decode |    2 +
 12 files changed, 4559 insertions(+), 4197 deletions(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t16.decode
 create mode 100644 target/arm/t32.decode
 create mode 100644 tests/decode/succ_function.decode

-- 
2.17.1


