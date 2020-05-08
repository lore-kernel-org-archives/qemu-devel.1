Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C369324953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJoubZIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C369324953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7ik-00087n-Oz
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hW-0006YC-C0
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:22 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:42497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hU-0004vf-GP
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:21 -0400
Received: by mail-pg1-x531.google.com with SMTP id n11so1227266pgl.9
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=He1E3wpQCl9jPTfjN7MBWAwPVAbruYVbszesB5MhDtw=;
 b=IJoubZIS/saWfxZhu2SpWZxsjr+WyR1xNQpbsmt3hHzFd5UcN3R6LKkOxCl33yoG8L
 01PuIz0Zodf0U/ZVWjFtFcUOFqymsWqU/sKEDvwVWWYeScmPm925nQlv97LjKhBGGpTI
 Qhr6wGRc767oFEHdwNKUUBAeaWLqhUG+qJkg+3+KoOYZyYL6BasFG+HJgIG5aXYARrPj
 8yNgcmtijZKhnX+F58fP6HgvKkqZI9AxurmMKEPRAy19K43lljUuP5+w5HSfMGybFjjg
 HTBqD3JQ89zGvAacfEGwaVk22t8DH+Q7kPE97YftqFNp8lBVBIC6jf/8zlscTCAu7HMx
 PqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=He1E3wpQCl9jPTfjN7MBWAwPVAbruYVbszesB5MhDtw=;
 b=YKol0tPvUtJSNRja9mylL/k4LmnX6iY7fPe347taeP72nPFRZ/qauaaFLruDF6o7RK
 jcLVaxITuHIP1UASdVCRa9E45nJHp1FSfZCfi0+NdDuvjL0vHC9qiHd0b/bdYBqENQov
 zqEA5yEcDfYvI7LQdW6zR32pn1DTtnPumgSjfMRnGm3E9DsrsuH9MQVclBAWaY1hNXjH
 Ht1aLUa1Ew2Gll2wHz38TXX1tynlSCZIGTIsdA7dWKmS1oVNlEwyESLkzoQSpHVUWI00
 Ez+aKRmry62jdsB5oHuOgGG/fS5ZT0G5FxVyaaldTZMerMaOA5UaLsAwthdh3p7QRHHL
 sdVw==
X-Gm-Message-State: AGi0PuZLsCNEXfAUZtSOTvxZcv+NbUYPu29YdzT2GUMEx2GKuKMgvW7d
 plSYwNEfD6MaxfuPCqvuTdbOigZbVnU=
X-Google-Smtp-Source: APiQypKLa75pBdqdvb72YtRN2YmLXUuSJoN5G5VCbUz8/teXy9DfUnDF29VrX83JiIOGWXIFMLkZhw==
X-Received: by 2002:aa7:8d93:: with SMTP id i19mr4321010pfr.112.1588962378182; 
 Fri, 08 May 2020 11:26:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/19] tcg: Better handling of constants
Date: Fri,  8 May 2020 11:25:57 -0700
Message-Id: <20200508182616.18318-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V4 adds the r-b against v2 that I forgot to go back and add.

Re patch 17, Alex asked if I could ifdef tcg_reg_alloc_dup2
instead of assert within it.  Answer: No, not without adding
still more ifdefs to compensate.  In the end I prefer the assert.

V3 fixes the target/sparc regression during register allocation.

V1 blurb:

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


Richard Henderson (19):
  tcg: Consolidate 3 bits into enum TCGTempKind
  tcg: Add temp_readonly
  tcg: Introduce TYPE_CONST temporaries
  tcg: Use tcg_constant_i32 with icount expander
  tcg: Use tcg_constant_{i32,i64} with tcg int expanders
  tcg: Use tcg_constant_{i32,vec} with tcg vec expanders
  tcg: Use tcg_constant_{i32,i64,vec} with tcg gvec expanders
  tcg: Use tcg_constant_{i32,i64} with tcg plugins
  tcg: Rename struct tcg_temp_info to TempOptInfo
  tcg/optimize: Improve find_better_copy
  tcg/optimize: Adjust TempOptInfo allocation
  tcg/optimize: Use tcg_constant_internal with constant folding
  tcg/tci: Add special tci_movi_{i32,i64} opcodes
  tcg: Remove movi and dupi opcodes
  tcg: Use tcg_out_dupi_vec from temp_load
  tcg: Increase tcg_out_dupi_vec immediate to int64_t
  tcg: Add tcg_reg_alloc_dup2
  tcg/i386: Use tcg_constant_vec with tcg vec expanders
  tcg: Remove tcg_gen_dup{8,16,32,64}i_vec

 include/exec/gen-icount.h    |  25 +--
 include/tcg/tcg-op.h         |  17 +-
 include/tcg/tcg-opc.h        |  11 +-
 include/tcg/tcg.h            |  50 ++++-
 accel/tcg/plugin-gen.c       |  49 ++---
 tcg/aarch64/tcg-target.inc.c |  12 +-
 tcg/arm/tcg-target.inc.c     |   1 -
 tcg/i386/tcg-target.inc.c    | 110 ++++++----
 tcg/mips/tcg-target.inc.c    |   2 -
 tcg/optimize.c               | 204 +++++++++---------
 tcg/ppc/tcg-target.inc.c     |  24 +--
 tcg/riscv/tcg-target.inc.c   |   2 -
 tcg/s390/tcg-target.inc.c    |   2 -
 tcg/sparc/tcg-target.inc.c   |   2 -
 tcg/tcg-op-gvec.c            | 125 +++++------
 tcg/tcg-op-vec.c             |  83 ++++----
 tcg/tcg-op.c                 | 216 +++++++++----------
 tcg/tcg.c                    | 397 ++++++++++++++++++++++++++---------
 tcg/tci.c                    |   4 +-
 tcg/tci/tcg-target.inc.c     |   6 +-
 20 files changed, 751 insertions(+), 591 deletions(-)

-- 
2.20.1


