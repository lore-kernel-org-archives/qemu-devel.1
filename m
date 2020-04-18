Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA9C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14122054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rU5SQprz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14122054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqD9-0005rw-PY
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBc-00044p-5n
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBa-0004fh-MS
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:52348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBa-0004ZU-Fs
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:18 -0400
Received: by mail-pj1-x1032.google.com with SMTP id ng8so2556291pjb.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2vmmnayxk0bB8XhoZGEq2w1GX5HnWJzWT2Vs31GFtOg=;
 b=rU5SQprzZo/qzMxMmfFTprtnh4ezGzyJrhCnm0x2zpGNTssxptHO32mUFremq+Bf4f
 EtCbur343APSojjnqahLKT0qSnZpNYuuszXhYAJw7xZWbAiBDE89RMwnMBVKJoAM+3Of
 JXMgeni/5a+T/zZx2nZL2u/UoPZGbLakFwRBIIJO6+pHQQMuCqWjnssXoK7BLjZjPbBf
 TItT6koZfHmgoPDXxU1dU2S6vXtm1dgx3S1gVkStOw+/1WhTaDnCpHq1y4yt85gsWNcv
 5gjDpQk0ht7VO+NL6sm5U40VGOVRtgL8rzMnYl57G3vzBaSBAudOR2BqOSMlAn7wZ6Qj
 8iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2vmmnayxk0bB8XhoZGEq2w1GX5HnWJzWT2Vs31GFtOg=;
 b=czOC10+qEI0rDaKMr/9N/+3lnHNcmGWFQ45k8Vcu2GEsCGCnrXkjOZB+E76XtwRX8B
 KOlEl5Onf1xj63KyJmY/75VzSyQ1PfnwmgB7noCLkeRScoqyyRF0/xwA1EgtYobVRBjZ
 bDed4nhipHyXw6BWEhJ2InEB6zoNtqxk91jAaAEuyUem7xJEDTWtlSEoykt9V5mun8GT
 E4w+bMtg4bHeMtfkPvHNFnd4l2ifLDhr0S5HN384nbwXdgWueS+3Am5xYTNdWAsUtXUv
 WKZ0gnuF+St4nshE5aLAi/PtzNuItTx4qcKAo5QZdJ2HPQaWDuPWHSUVPC/9003H+1lM
 FFIQ==
X-Gm-Message-State: AGi0PubxWUGGyaNPJH+F1EToAL1n26FJEUCf84p6GHiNCOzrJTXxW5uk
 9ZzsH9DEIE8DrR+CecNDL4lxo7Jwggc=
X-Google-Smtp-Source: APiQypJibG8zuMPi0z+EZVMjIGnNrA6IN1aP71rIqH1AccfRWNjp1pSAsm5M9yHtN9BWWFCRQRZS7Q==
X-Received: by 2002:a17:90a:68cb:: with SMTP id
 q11mr11576692pjj.15.1587226756838; 
 Sat, 18 Apr 2020 09:19:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] tcg: Better handling of constants
Date: Sat, 18 Apr 2020 09:18:58 -0700
Message-Id: <20200418161914.4387-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1032
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This promotes constants to full-fledged temporaries, which are then
hashed so we have only a single copy across the TB.  If an opcode
requires forcing one into a register, then we will only do this
once -- at least until the register is killed, e.g. by a function call.

While this is probably an modest improvement for integer code, it is
significant for SVE vector code.  In particular, where a generator function
loads a constant for the operation, and then the generator function is
called N times for the N x 128-bit vector.  Previously we'd be loading
up the same constant N times and now we do so only once.

The existing tcg_const_{type}() functions are unchanged, allocating
a new temporary and initializing it.  The constant propagation pass
of the optimizer will generally remove the temporary when it turns
out not to be modified further.

This adds new tcg_constant_{type}() functions which produce a read-only
temporary containing the constant which need not be freed.  I have
updated the generic expanders to take advantage of this, but have not
touched the target front ends.

This also, in the end, allows the complete removal of the tcg opcodes
that create a constant: INDEX_op_movi_{i32,i64} and INDEX_op_dupi_vec.
Loading of constants into hard registers is completely controlled by
the register allocator.


r~


Richard Henderson (16):
  tcg: Add temp_readonly
  tcg: Introduce TYPE_CONST temporaries
  tcg: Use tcg_constant_i32 with icount expander
  tcg: Use tcg_constant_{i32,i64} with tcg int expanders
  tcg: Use tcg_constant_{i32,vec} with tcg vec expanders
  tcg: Use tcg_constant_{i32,i64} with tcg plugins
  tcg: Rename struct tcg_temp_info to TempOptInfo
  tcg/optimize: Adjust TempOptInfo allocation
  tcg/optimize: Use tcg_constant_internal with constant folding
  tcg/tci: Add special tci_movi_{i32,i64} opcodes
  tcg: Remove movi and dupi opcodes
  tcg: Use tcg_out_dupi_vec from temp_load
  tcg: Increase tcg_out_dupi_vec immediate to int64_t
  tcg: Add tcg_reg_alloc_dup2
  tcg/i386: Use tcg_constant_vec with tcg vec expanders
  tcg: Remove tcg_gen_dup{8,16,32,64}i_vec

 include/exec/gen-icount.h    |  25 ++--
 include/tcg/tcg-op.h         |  17 +--
 include/tcg/tcg-opc.h        |  11 +-
 include/tcg/tcg.h            |  30 +++++
 accel/tcg/plugin-gen.c       |  49 ++++---
 tcg/aarch64/tcg-target.inc.c |  12 +-
 tcg/arm/tcg-target.inc.c     |   1 -
 tcg/i386/tcg-target.inc.c    | 110 +++++++++-------
 tcg/mips/tcg-target.inc.c    |   2 -
 tcg/optimize.c               | 204 ++++++++++++++---------------
 tcg/ppc/tcg-target.inc.c     |  24 ++--
 tcg/riscv/tcg-target.inc.c   |   2 -
 tcg/s390/tcg-target.inc.c    |   2 -
 tcg/sparc/tcg-target.inc.c   |   2 -
 tcg/tcg-op-vec.c             |  83 ++++++------
 tcg/tcg-op.c                 | 216 ++++++++++++++----------------
 tcg/tcg.c                    | 246 +++++++++++++++++++++++++++++------
 tcg/tci.c                    |   4 +-
 tcg/tci/tcg-target.inc.c     |   6 +-
 19 files changed, 602 insertions(+), 444 deletions(-)

-- 
2.20.1


