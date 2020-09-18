Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C88C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D9E21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiDSs/6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D9E21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLIO-0000dG-2H
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGh-0007HG-E0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:37:59 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:50841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGe-00072S-Gb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:37:58 -0400
Received: by mail-pj1-x102e.google.com with SMTP id fa1so3630623pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TabxK5GcsIsrrKGcXqH3X6F6TiDqhMqLODq3mwGAI3c=;
 b=AiDSs/6XYZxya0vWpwJc0fvIn9io3MQLOWZUwM5xixG9rkTC62H9HZoXQY9gHikqfO
 AA1GliKS1ON3ynieEtYsA4p1DRra1yH/VvSfLoDjSH2GIqop8JY3tOwPC4+smXSE8I7s
 nKusQtjzk8iuAleqSR3N/MSbEiz/r3U1V16Bf56NEGmoJ6AOQZbPfzm1BogtU0qvrLD3
 RNyUXh6OnzgFrvK8b6GhYHb+k0n/3U2UZMcYUklQi6IxPkyXX0yax0ngmwChox/1EX8r
 bFjCLOcaMZx2b56LAw6brMQLk3ZLE0nmXrr9RmnbV8zSOcFbNKiWb54eEDq8JwjNqfeX
 YPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TabxK5GcsIsrrKGcXqH3X6F6TiDqhMqLODq3mwGAI3c=;
 b=HEDVvrIN5IY7sKa7HYD6SygyvZvwjE2eSM+wo0N06uDr0n24DRJTldQkAeRLsVJ/un
 3NNOUT9B+x9Zxdzgu8gHMpr6oY4Ff8XwZAk+kRI9yMNIFAe6cM3PTgJTnU3pFD7GIkMs
 WUW6kcuOe5obLyTm4FiIcNC0gFn+neY/+hpeRK+yvBXJCtai9OpFEqn9tPjyIjhtH8sd
 PKtM3WS2wdyxIWkoiCi50Lvi//g/6qTpzlqX19ACTqsUVcBXXoNQF6f2SPU2kJG9Ydxg
 uVCmWVC7lTLNu9yYo7QLYyntACxd4IJ4Fx5LWKS/dae7XANIcE6RcgOpcCLEFXboroSh
 4LAw==
X-Gm-Message-State: AOAM530qKuDLxkM8PpE4wjuFYIQevtH2FI2QtPrwRWV2CmqhN66lxuTl
 7JobsiBP3iT6ZfWz69CH/AyZEemJwUrAow==
X-Google-Smtp-Source: ABdhPJzr1qM2pRoqHNfL2nKAgTMMpdMy2PKnvj9JFgsBLJv/hMjfKt24lJnwV6RP3zHY4kRyLvSeMg==
X-Received: by 2002:a17:90a:f83:: with SMTP id
 3mr13567625pjz.132.1600454273822; 
 Fri, 18 Sep 2020 11:37:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/81] target/arm: Implement SVE2
Date: Fri, 18 Sep 2020 11:36:30 -0700
Message-Id: <20200918183751.2787647-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first revision that has been fully tested vs ArmIE,
although only with 128-bit vectors.

Since ArmIE does not produce an SVE signal frame, I have a small
hack in RISU to pull the vector data from the FP frame.  I may try
an assembly wrapper to capture the larger vector data before it
gets clobbered by AdvSIMD usage within libc (especially memset),
but it wasn't especially urgent.


r~


Richard Henderson (63):
  target/arm: Fix sve_uzp_p vs odd vector lengths
  target/arm: Fix sve_zip_p vs odd vector lengths
  target/arm: Fix sve_punpk_p vs odd vector lengths
  target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
  target/arm: Implement SVE2 Integer Multiply - Unpredicated
  target/arm: Implement SVE2 integer pairwise add and accumulate long
  target/arm: Implement SVE2 integer unary operations (predicated)
  target/arm: Split out saturating/rounding shifts from neon
  target/arm: Implement SVE2 saturating/rounding bitwise shift left
    (predicated)
  target/arm: Implement SVE2 integer halving add/subtract (predicated)
  target/arm: Implement SVE2 integer pairwise arithmetic
  target/arm: Implement SVE2 saturating add/subtract (predicated)
  target/arm: Implement SVE2 integer add/subtract long
  target/arm: Implement SVE2 integer add/subtract interleaved long
  target/arm: Implement SVE2 integer add/subtract wide
  target/arm: Implement SVE2 integer multiply long
  target/arm: Implement PMULLB and PMULLT
  target/arm: Implement SVE2 bitwise shift left long
  target/arm: Implement SVE2 bitwise exclusive-or interleaved
  target/arm: Implement SVE2 bitwise permute
  target/arm: Implement SVE2 complex integer add
  target/arm: Implement SVE2 integer absolute difference and accumulate
    long
  target/arm: Implement SVE2 integer add/subtract long with carry
  target/arm: Implement SVE2 bitwise shift right and accumulate
  target/arm: Implement SVE2 bitwise shift and insert
  target/arm: Implement SVE2 integer absolute difference and accumulate
  target/arm: Implement SVE2 saturating extract narrow
  target/arm: Implement SVE2 SHRN, RSHRN
  target/arm: Implement SVE2 SQSHRUN, SQRSHRUN
  target/arm: Implement SVE2 UQSHRN, UQRSHRN
  target/arm: Implement SVE2 SQSHRN, SQRSHRN
  target/arm: Implement SVE2 WHILEGT, WHILEGE, WHILEHI, WHILEHS
  target/arm: Implement SVE2 WHILERW, WHILEWR
  target/arm: Implement SVE2 bitwise ternary operations
  target/arm: Implement SVE2 saturating multiply-add long
  target/arm: Implement SVE2 saturating multiply-add high
  target/arm: Implement SVE2 integer multiply-add long
  target/arm: Implement SVE2 complex integer multiply-add
  target/arm: Implement SVE2 XAR
  target/arm: Pass separate addend to {U,S}DOT helpers
  target/arm: Pass separate addend to FCMLA helpers
  target/arm: Split out formats for 2 vectors + 1 index
  target/arm: Split out formats for 3 vectors + 1 index
  target/arm: Implement SVE2 integer multiply (indexed)
  target/arm: Implement SVE2 integer multiply-add (indexed)
  target/arm: Implement SVE2 saturating multiply-add high (indexed)
  target/arm: Implement SVE2 saturating multiply-add (indexed)
  target/arm: Implement SVE2 integer multiply long (indexed)
  target/arm: Implement SVE2 saturating multiply (indexed)
  target/arm: Implement SVE2 signed saturating doubling multiply high
  target/arm: Implement SVE2 saturating multiply high (indexed)
  target/arm: Implement SVE2 multiply-add long (indexed)
  target/arm: Implement SVE2 complex integer multiply-add (indexed)
  target/arm: Implement SVE mixed sign dot product (indexed)
  target/arm: Implement SVE mixed sign dot product
  target/arm: Implement SVE2 crypto unary operations
  target/arm: Implement SVE2 crypto destructive binary operations
  target/arm: Implement SVE2 crypto constructive binary operations
  target/arm: Share table of sve load functions
  target/arm: Implement SVE2 LD1RO
  target/arm: Implement 128-bit ZIP, UZP, TRN
  target/arm: Implement SVE2 complex integer dot product
  target/arm: Enable SVE2 and some extensions

Stephen Long (18):
  target/arm: Implement SVE2 floating-point pairwise
  target/arm: Implement SVE2 MATCH, NMATCH
  target/arm: Implement SVE2 ADDHNB, ADDHNT
  target/arm: Implement SVE2 RADDHNB, RADDHNT
  target/arm: Implement SVE2 SUBHNB, SUBHNT
  target/arm: Implement SVE2 RSUBHNB, RSUBHNT
  target/arm: Implement SVE2 HISTCNT, HISTSEG
  target/arm: Implement SVE2 scatter store insns
  target/arm: Implement SVE2 gather load insns
  target/arm: Implement SVE2 FMMLA
  target/arm: Implement SVE2 SPLICE, EXT
  target/arm: Implement SVE2 TBL, TBX
  target/arm: Implement SVE2 FCVTNT
  target/arm: Implement SVE2 FCVTLT
  target/arm: Implement SVE2 FCVTXNT, FCVTX
  target/arm: Implement SVE2 FLOGB
  target/arm: Implement SVE2 bitwise shift immediate
  target/arm: Implement SVE2 fp multiply-add long

 target/arm/cpu.h                |   56 +
 target/arm/helper-sve.h         |  722 ++++++-
 target/arm/helper.h             |  104 +-
 target/arm/translate-a64.h      |    3 +
 target/arm/vec_internal.h       |  143 ++
 target/arm/sve.decode           |  568 +++++-
 target/arm/cpu64.c              |   11 +
 target/arm/helper.c             |    3 +-
 target/arm/kvm64.c              |   11 +
 target/arm/neon_helper.c        |  507 +----
 target/arm/sve_helper.c         | 2175 +++++++++++++++++++--
 target/arm/translate-a64.c      |   67 +-
 target/arm/translate-sve.c      | 3152 +++++++++++++++++++++++++++++--
 target/arm/vec_helper.c         |  767 +++++++-
 target/arm/translate-neon.c.inc |   20 +-
 15 files changed, 7443 insertions(+), 866 deletions(-)

-- 
2.25.1


