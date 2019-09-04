Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48FBC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774322077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYx5AP0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774322077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b2N-0006Nn-Th
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azg-000425-Pi
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azf-00020d-AX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azf-000207-2S
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id y10so4121386pll.7
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6+bARj0jxuSpEQCKbgiTd1HkSisnTmkoCrkjCZxZc64=;
 b=dYx5AP0DBQ98WOSga05aw4Wt8hg0u+kLBwAXV/7C4W3FMsoO8/vbOHVYmjASivruf6
 hZKMBAeYBufKdkScBnM0oqn6hFFKYWB45kxBAX5hdJSPIsoZxIkUAEfnRRqrFlqZtjMQ
 6O8wD51P+TYY0QEkevXNjLWIpU2dx4+1mi+2t224uUDSlaWzHpSSpqECZoD/ZkUKxP2t
 psO3Geyn36A1DQm9r+JYB0ny2BohXgNWx02gEdU/53JpR4uLCLsx1vpMeD4+P/953ncr
 WicGqUg2pzdDbDgb5+fSqJ0TWky6yt82klHDHjt7BAWZazfAx+ghL/T/WkQZD4DvQIDk
 omcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6+bARj0jxuSpEQCKbgiTd1HkSisnTmkoCrkjCZxZc64=;
 b=G9UTmmUglny720hVhDLRbi5SOoOiInxhN3fgmESmil1Pw4T2IhBwNeSMekGdPsIayv
 EEHKx05/Qi9QPFBRcLl/s1XHU7+sJZtJ9EL8OdWbw3qvRpcSxF9jEP+rUFiqcX2Jlamn
 nHynwPgmxi6SLtjmyoJLSGhsdKkGjodePzgoZkvKgybN/QiGInUdWE5QCM3nub3Kygsf
 hdqc0024wJaabLMv4LZW+Pe0VH1RlfEXugLUye7rDrnYgccYlNCnVA0JdpAuqwfk+kP9
 blb8VsL02XclGGjmab7eY2kp+gOp9EPJtAgvO8UaohtcNg2Vz0bPjx6W29J71uVFGYkK
 RlPQ==
X-Gm-Message-State: APjAAAWHJKch4g8+SJjKiPJjmhGIxAlcr8i8X7p+PKwr8T6TQTsEzeip
 Oe166GfsOVS6gx/GtG4sUGxkw5mI8PI=
X-Google-Smtp-Source: APXvYqzxKDztwRodkPKRd1iAx4rfSlfhGiMnxXAOkH24RqcK7jCv0v5zFHtYKK4TVfejp4Z1PVTv5w==
X-Received: by 2002:a17:902:8492:: with SMTP id
 c18mr43208305plo.279.1567625461658; 
 Wed, 04 Sep 2019 12:31:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:50 -0700
Message-Id: <20190904193059.26202-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 00/69] target/arm: Convert aa32 base isa to
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

The changes from v3 are minimal, mostly rebase conflicts.  There
is one change for checkpatch warnings, in patch 34 in trans_RFE.

There is one outstanding checkpatch warning, but it's in a minimal
change to some existing code that is removed before the end of the
patch set.

All patches have reviews now.


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

 target/arm/translate.c       | 7179 +++++++++++++++-------------------
 target/arm/Makefile.objs     |   24 +
 target/arm/a32-uncond.decode |   74 +
 target/arm/a32.decode        |  534 +++
 target/arm/t16.decode        |  281 ++
 target/arm/t32.decode        |  631 +++
 6 files changed, 4638 insertions(+), 4085 deletions(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t16.decode
 create mode 100644 target/arm/t32.decode

-- 
2.17.1


