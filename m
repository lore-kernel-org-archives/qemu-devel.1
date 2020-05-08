Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F3C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E17A24966
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eA5dxYvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E17A24966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4oY-00025o-9Z
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4l6-0005Us-Hu
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:17:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:45467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4l5-0002ku-CH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:17:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id w65so1061849pfc.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tLmvZ13dyq6vL3rMorwGE0qcBwEkXCJuZdJxTSPx65c=;
 b=eA5dxYvZz0AehNdBnYW0rlYbi2Qxt5uUphf+Pa+nXBCXUnr/8/sGW5MegOvagzBKNf
 siwewzJ/D4+u3PmZhdD7uQZC6kOYtn9orwA6hREY8DbgPHQUOwE0jdACHPTryrO4YnzK
 aQJLzgV1oYSn3YLP/3ka2UWT+hHf8QPsB2V6S8nyCfva1ZtN5eITLbPboJMavYvv/P7g
 PpqIx8T8I7SmvKMSMCrVdkw03kr/f3p5USms/+Wc5zsynYNMt2HREwRHyflDrgh71JxZ
 glF8BiY4QxOiSz9RMKUqIaEo7Ew7eIRa6drIKBo/r6gVdzgEfJgyRfLrOAqqrrr/zMfL
 cxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tLmvZ13dyq6vL3rMorwGE0qcBwEkXCJuZdJxTSPx65c=;
 b=sXCgCf1qN7oiL5KKrwSPCoMhzJXWB4NDMT10Yt6Ya4dIGcnA2d9JSsHoRuopl67qGn
 22yhnSgBivF6qR2DAOVFg2qbfyTmEKh1GpdjU6Bm/dgoc/D8VDeevmCt6q4voS8mkAXB
 2FFGc6U7egEdMbendyIpHI5MAAjFGHNSdTlkAD0cVFldjzdBZSQg/UWGHpcp8uH4eWqS
 TaWS4q762JO+DdWFxkY+3+q+ghbeCztHhYMiZzVxUOiKDXgRsoQsb2+vFJUvW14uiZ+D
 fOBNUy0ZcLjFePr3CrbojhywJiW9K2RqgTkIXOQ733raZaZQy2W7SVXdHg+jmBTZghg3
 yU/w==
X-Gm-Message-State: AGi0Pua3OEAHuDPQgYdKtrgXUwZkUJHvtNaDIkoj2IGXi2gYaFDC7krP
 aobxx/oSjGvFFJYWcDED+//lhLr7LJU=
X-Google-Smtp-Source: APiQypKsZG8u3y4chiOJE5Iw5O0kOHVRuvU7Wfgjd8goXcBOdEZacTcvxejTDVmOT1Fe9+KGrncsQQ==
X-Received: by 2002:a63:9d49:: with SMTP id i70mr2639852pgd.247.1588951069173; 
 Fri, 08 May 2020 08:17:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:17:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] tcg: Better handling of constants
Date: Fri,  8 May 2020 08:17:28 -0700
Message-Id: <20200508151747.6166-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


