Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F354C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE4220663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpwZ1wHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHz9-0005Nf-E5
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy7-0003HW-4t
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy4-0003Tv-MC
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id z64so432730pfb.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PzrD96dOtD3NK1lLspXRiLRSKjspuQFil7VkeAR8vEY=;
 b=LpwZ1wHmMMyHeQuYGskrwbuGrTgDRCSUlwVE1NrYcEo6QGFE9bLw3ALS3Wm70SVVbD
 hLwTQcqTWMd7xM4Atk5Rgs4JRUof/iLLhNJOvTfMo7r2WzOYah+iJS6ABXcOaPnsCvK8
 RjlPhFqKnn6HJN+Zi6GlLHGlo5MuFUGYV5iLzG0mCIGNd9eR0MPvFDGIa6rCGL8qvbY3
 slye8rDOup3CJtyvY+7z1Xqb72oTC0XqHWsXQHm//e+m1JMBmWjEOQ3fCYX9T4l2hW22
 KTkEO54PLGFv3Z7iUPVHB3tgxuAbiBU67hzVK1lzaNRvpL5mPgSXwrwb8nUcpnAeVrZ2
 kpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PzrD96dOtD3NK1lLspXRiLRSKjspuQFil7VkeAR8vEY=;
 b=bsgtayXn1e7PFG88StapBiL+2HnXO+lbeNZ1PQc8d2mQ1ZpuZrp2XELQ8k/9P8eWQg
 FgP8QeppAwT7SxPeRR1/96oLH6cXg5qcdUhDUrWfceTv93DJezauu0i9dAwt1/HPI4Oj
 G/nN96zAROivuhVKxfOYsc9sAPFuSpO6/x00O3xI2LVnq+8EaMdSqrlN6IpiLzt3H0+n
 IDNcDCVG7UHQmOBNWXf6CTOEQJZhyqD4BJr4iKJGnM7YLqDrkD8aMx7nGDshyKT+lT0W
 QSh3tL+nDGmjy3FHyMEnBWjRW3vk7ck2q0zagVo58vmad95qAWPODWPY9WBAIMa7yo/Q
 Regg==
X-Gm-Message-State: AOAM533zB5ty1updPWViOQcWStpbWUb7P6p/IQCvXwNhC3Ta6TDXmAgZ
 v0whoJc9OLA2Qxj3zG5Xm1ZFUk8+mHk=
X-Google-Smtp-Source: ABdhPJwVgbAcHyQvP7i4vhIxYRCHrhC62RuoEF/vbQYOoDdzi4rpEVPJjK7HBcM+cPJmZu+J9qtQzQ==
X-Received: by 2002:a17:90b:23cb:: with SMTP id
 md11mr2383208pjb.108.1591146798833; 
 Tue, 02 Jun 2020 18:13:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/42] target/arm: Implement ARMv8.5-MemTag, system mode
Date: Tue,  2 Jun 2020 18:12:35 -0700
Message-Id: <20200603011317.473934-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 6 was back in March:
https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg03790.html

Version 7 is a rebase on master, which now contains all prereqs.
In addition, two bugs fixed, pointed out by users of the branch.

I've done light testing against

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/mte-v4

I still have not implemented the arm,armv8.5-memtag OF property
expected by that branch, so I have been disabling it.


r~


diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b297a37c1b13..b5f18e63f8d1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -155,6 +155,7 @@ s64 mte_ftr_filter
                return ID_AA64PFR1_MTE_NI;
        }
 
+#if 0
        /* check the DT "memory" nodes for MTE support */
        for_each_node_by_type(np, "memory") {
                memory_checked = true;
@@ -167,6 +168,7 @@ s64 mte_ftr_filter
                mte_capable = false;
                return ID_AA64PFR1_MTE_NI;
        }
+#endif
 
        return val;
 }


Richard Henderson (42):
  target/arm: Add isar tests for mte
  target/arm: Improve masking of SCR RES0 bits
  target/arm: Add support for MTE to SCTLR_ELx
  target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
  target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
  target/arm: Add DISAS_UPDATE_NOCHAIN
  target/arm: Add MTE system registers
  target/arm: Add MTE bits to tb_flags
  target/arm: Implement the IRG instruction
  target/arm: Implement the ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for user-only
  target/arm: Add helper_probe_access
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Restrict the values of DCZID.BS under TCG
  target/arm: Simplify DC_ZVA
  target/arm: Implement the LDGM, STGM, STZGM instructions
  target/arm: Implement the access tag cache flushes
  target/arm: Move regime_el to internals.h
  target/arm: Move regime_tcr to internals.h
  target/arm: Add gen_mte_check1
  target/arm: Add gen_mte_checkN
  target/arm: Implement helper_mte_check1
  target/arm: Implement helper_mte_checkN
  target/arm: Add helper_mte_check_zva
  target/arm: Use mte_checkN for sve unpredicated loads
  target/arm: Use mte_checkN for sve unpredicated stores
  target/arm: Use mte_check1 for sve LD1R
  target/arm: Add mte helpers for sve scalar + int loads
  target/arm: Add mte helpers for sve scalar + int stores
  target/arm: Add mte helpers for sve scalar + int ff/nf loads
  target/arm: Handle TBI for sve scalar + int memory ops
  target/arm: Add mte helpers for sve scatter/gather memory ops
  target/arm: Complete TBI clearing for user-only for SVE
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  target/arm: Enable MTE
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Add allocation tag storage for system mode

 target/arm/cpu.h               |   36 +-
 target/arm/helper-a64.h        |   16 +
 target/arm/helper-sve.h        |  491 +++++++++++
 target/arm/helper.h            |    2 +
 target/arm/internals.h         |  148 ++++
 target/arm/translate-a64.h     |    5 +
 target/arm/translate.h         |   23 +-
 hw/arm/virt.c                  |   52 ++
 linux-user/aarch64/cpu_loop.c  |    7 +
 linux-user/arm/cpu_loop.c      |    7 +
 target/arm/cpu.c               |   77 +-
 target/arm/cpu64.c             |    1 +
 target/arm/helper-a64.c        |   94 +--
 target/arm/helper.c            |  350 ++++++--
 target/arm/mte_helper.c        |  897 ++++++++++++++++++++
 target/arm/op_helper.c         |   16 +
 target/arm/sve_helper.c        |  746 ++++++++++++++---
 target/arm/tlb_helper.c        |   41 +-
 target/arm/translate-a64.c     |  607 ++++++++++++--
 target/arm/translate-sve.c     | 1421 ++++++++++++++++++++------------
 target/arm/translate-vfp.inc.c |    2 +-
 target/arm/translate.c         |   16 +-
 target/arm/Makefile.objs       |    1 +
 23 files changed, 4206 insertions(+), 850 deletions(-)
 create mode 100644 target/arm/mte_helper.c

-- 
2.25.1


