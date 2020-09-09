Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929AD2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SboYyKN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929AD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFno5-0000kb-GO
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnD-0007ae-GJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnA-00028C-Fi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id k15so533755pfc.12
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GoaIYOOYHhn3qujsrZEEU/6Pldvf5OIgWWOmkDFBWrc=;
 b=SboYyKN1KuD9RI/nNsKONxhouT+Gtu0OXxlHH2LQYDNcTdrKo1wMhiacZukJR+ecma
 Idn0jyB/76HjvlARVERbERx4+DoYVA9EPa8jdizBqYOA0QAKgr2YppvW7QjnBep4xSMa
 XbxnfAjCFDsXfAwapEEicJ9ykkOUHmWocZY26ABm1gn9yj7IZ2VfuzYgveGv1/oVVBHp
 HmPlcZx32DbJ5VXqXZemSZLhVCFl0A1idz5LIeU8+L89vOdtEXyxTHLXeXXuelbHhnGO
 JVKnjB6w61cMi7gJS8lf5pIrgoHF1jrVUEzHj0h898aqd6sN8zFhwMVN6c0Dd8VuHJ7M
 JYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GoaIYOOYHhn3qujsrZEEU/6Pldvf5OIgWWOmkDFBWrc=;
 b=bDfJ1R8xK6P1Q3i9Z0kj17QuaEHt+DQB7eF6V+wYqxkt5HYFbohctcIvx09VojzzGH
 nv+WSgCccMKUINyn4/vJNnk100uLQMyrDqUyAh14wDkBMPsmV4tPSIr1/VVjoMaMVRRe
 SRqzdBLnEn11EhdSu7Foij/1V4a4BUyRrwq/t4fGkebH0LwwuRgtrPAIiMiX4IGiL6fy
 nEqefxxoVwvr7HUpkSuhVkisaLDSoHlgQoWMQUEEwan5T+WZ/7I5INTNie8Zh4ozR2/4
 JyzzoMp1NlXADGpCBYVge1UdN5vo8W88ryNCulE/DTgxFYoqGdXgmQkSaH5XkxIrnrE1
 /jwQ==
X-Gm-Message-State: AOAM531D9XWObLKbAuoXWssdI+6adbL7LEz/CGbdQ2gpTcsULr+LEDkK
 ji1HBLaWlIt4PryOJIIPoqDnzUn8WlCH2A==
X-Google-Smtp-Source: ABdhPJwQcqaqo5MwAOLKkmKBE3RxtGQOyhmRUMdm+sOgY7pPa8+2DTQ7u9NNKT2U5HaW76srEWH/rA==
X-Received: by 2002:a63:e645:: with SMTP id p5mr951173pgj.276.1599610609714;
 Tue, 08 Sep 2020 17:16:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/43] tcg patch queue
Date: Tue,  8 Sep 2020 17:16:04 -0700
Message-Id: <20200909001647.532249-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch collection contains:

  * A couple of fixes for i386 host vector support.

  * Some random cleanups cherry-picked from some inactive branches.

  * A reposting (with fix) of my "better handling of constants" set:

    https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg02152.html

  * A couple patches that centralizes the set of host constraints.
    This, I believe is slightly cleaner than the current state of
    afairs, even before the ultimtate goal of pre-validating the
    contents as well.


r~


Richard Henderson (43):
  tcg: Adjust simd_desc size encoding
  tcg: Drop union from TCGArgConstraint
  tcg: Move sorted_args into TCGArgConstraint.sort_index
  tcg: Remove TCG_CT_REG
  tcg: Move some TCG_CT_* bits to TCGArgConstraint bitfields
  tcg: Remove TCGOpDef.used
  tcg/i386: Fix dupi for avx2 32-bit hosts
  tcg: Fix generation of dupi_vec for 32-bit host
  tcg/optimize: Fold dup2_vec
  tcg: Remove TCG_TARGET_HAS_cmp_vec
  tcg: Use tcg_out_dupi_vec from temp_load
  tcg: Increase tcg_out_dupi_vec immediate to int64_t
  tcg: Consolidate 3 bits into enum TCGTempKind
  tcg: Add temp_readonly
  tcg: Expand TCGTemp.val to 64-bits
  tcg: Rename struct tcg_temp_info to TempOptInfo
  tcg: Expand TempOptInfo to 64-bits
  tcg: Introduce TYPE_CONST temporaries
  tcg/optimize: Improve find_better_copy
  tcg/optimize: Adjust TempOptInfo allocation
  tcg/optimize: Use tcg_constant_internal with constant folding
  tcg: Convert tcg_gen_dupi_vec to TCG_CONST
  tcg: Use tcg_constant_i32 with icount expander
  tcg: Use tcg_constant_{i32,i64} with tcg int expanders
  tcg: Use tcg_constant_{i32,i64} with tcg plugins
  tcg: Use tcg_constant_{i32,i64,vec} with gvec expanders
  tcg/tci: Add special tci_movi_{i32,i64} opcodes
  tcg: Remove movi and dupi opcodes
  tcg: Add tcg_reg_alloc_dup2
  tcg/i386: Use tcg_constant_vec with tcg vec expanders
  tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
  tcg/ppc: Use tcg_constant_vec with tcg vec expanders
  tcg/aarch64: Use tcg_constant_vec with tcg vec expanders
  tcg: Add tcg-constr.c.inc
  tcg/i386: Convert to tcg-constr.c.inc
  tcg/aarch64: Convert to tcg-constr.c.inc
  tcg/arm: Convert to tcg-constr.c.inc
  tcg/mips: Convert to tcg-constr.c.inc
  tcg/ppc: Convert to tcg-constr.c.inc
  tcg/riscv: Convert to tcg-constr.c.inc
  tcg/s390: Convert to tcg-constr.c.inc
  tcg/sparc: Convert to tcg-constr.c.inc
  tcg/tci: Convert to tcg-constr.c.inc

 include/exec/gen-icount.h       |  25 +-
 include/tcg/tcg-gvec-desc.h     |  38 ++-
 include/tcg/tcg-op.h            |  17 +-
 include/tcg/tcg-opc.h           |  11 +-
 include/tcg/tcg.h               |  72 +++--
 tcg/aarch64/tcg-target-constr.h |  31 ++
 tcg/aarch64/tcg-target.h        |   1 -
 tcg/arm/tcg-target-constr.h     |  30 ++
 tcg/i386/tcg-target-constr.h    |  55 ++++
 tcg/i386/tcg-target.h           |   1 -
 tcg/mips/tcg-target-constr.h    |  31 ++
 tcg/ppc/tcg-target-constr.h     |  37 +++
 tcg/ppc/tcg-target.h            |   1 -
 tcg/riscv/tcg-target-constr.h   |  25 ++
 tcg/s390/tcg-target-constr.h    |  24 ++
 tcg/sparc/tcg-target-constr.h   |  27 ++
 tcg/tci/tcg-target-constr.h     |  28 ++
 accel/tcg/plugin-gen.c          |  49 ++-
 tcg/optimize.c                  | 254 ++++++++-------
 tcg/tcg-op-gvec.c               | 160 +++++-----
 tcg/tcg-op-vec.c                |  48 +--
 tcg/tcg-op.c                    | 227 +++++++------
 tcg/tcg.c                       | 549 +++++++++++++++++++++++---------
 tcg/tci.c                       |   4 +-
 tcg/aarch64/tcg-target.c.inc    | 134 +++-----
 tcg/arm/tcg-target.c.inc        | 123 +++----
 tcg/i386/tcg-target.c.inc       | 336 +++++++++----------
 tcg/mips/tcg-target.c.inc       | 118 +++----
 tcg/ppc/tcg-target.c.inc        | 254 +++++++--------
 tcg/riscv/tcg-target.c.inc      | 100 ++----
 tcg/s390/tcg-target.c.inc       | 143 ++++-----
 tcg/sparc/tcg-target.c.inc      |  97 ++----
 tcg/tcg-constr.c.inc            | 108 +++++++
 tcg/tci/tcg-target.c.inc        | 369 ++++++++-------------
 34 files changed, 1893 insertions(+), 1634 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-constr.h
 create mode 100644 tcg/arm/tcg-target-constr.h
 create mode 100644 tcg/i386/tcg-target-constr.h
 create mode 100644 tcg/mips/tcg-target-constr.h
 create mode 100644 tcg/ppc/tcg-target-constr.h
 create mode 100644 tcg/riscv/tcg-target-constr.h
 create mode 100644 tcg/s390/tcg-target-constr.h
 create mode 100644 tcg/sparc/tcg-target-constr.h
 create mode 100644 tcg/tci/tcg-target-constr.h
 create mode 100644 tcg/tcg-constr.c.inc

-- 
2.25.1


