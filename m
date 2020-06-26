Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2301C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721AA2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1bVqCCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721AA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof6x-0001hy-Nd
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5i-0007fU-9j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5g-0001gf-IL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id l63so4332981pge.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YHNNcwR4Sw18AvMX2rsSzQnG1qtoz/3k0D7hw9cHPjY=;
 b=y1bVqCCaeVNIYjFmzeCKq96JaB7Itf0EAhJMRLg/SMJb89IleC/c2pzhudfVZb0CPK
 k++QXvhzD2LGWPXrpt/0wThxO/4I/fPupNWPupnXDhhaDtlXicxaCHys4+fbmLEuFm4J
 upUi3Ev36dX27jlJkVZ5Qe+bayXZ4mclavea2vEFjCy5+FWyBhSNCQG3bkYbGNncX/Ua
 5YJ8Dy8Zjdw9a63ClGvo6ck7M0WWFIJuNDU1KwSQVbvpcgcNBEdWG8YFwc1CcOQjSNJt
 fmRPZJiZSnfbFmXQjXbaOqoo84287I2YWqwMdwC5eV0heNeO1CPnnURk7Y3DWDrQO+vu
 brVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YHNNcwR4Sw18AvMX2rsSzQnG1qtoz/3k0D7hw9cHPjY=;
 b=XoXKQfdTkKZ4QNfqg7dyn75oXjzKr5pHBbCyE1JYfBS9gkmrckd7vjBr2dfK3Ii3QE
 Qq8uvaVuaRgNfrOhti1Qe74m9g/mCiTcqwLxCxEOo68n4zfzPTZzvGGC3pBcC38lRrlF
 LmAcsatoy4oGvs3zI6rehIUBrCy3enhkFxxDOOXwYTYmiLgEvmLPUi7kn9Fqo5r5rpm6
 Mz/6OyhgeKw+qfOaXBpJKdQz+tIrpBx/5vcJxWdZ/v1cEhdNWhz84+42eR5viwz1IqI4
 D32ICj7Ti9h/1SHGYZvTXxvaze8jOivNACSSoHPEKI4fNUiQ6YjAP0qAe1DMgpuLzsZj
 Qz+Q==
X-Gm-Message-State: AOAM533Aedi6J8H+5MOdmMSRHdyUzeR0y6aEraZMSUGTIyTnr79iqwwR
 JHLSdPfGV3G3WprskCtJiOQmemBXAjM=
X-Google-Smtp-Source: ABdhPJzfr827we/PhvrGgTLJmovw4MzBsYjkyRp/paJFsZQkzFx3d4JyFYaJpH+LswUlGJjhspCaaw==
X-Received: by 2002:a05:6a00:1514:: with SMTP id
 q20mr837165pfu.243.1593142306652; 
 Thu, 25 Jun 2020 20:31:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/46] target/arm: Implement ARMv8.5-MemTag, system mode
Date: Thu, 25 Jun 2020 20:30:58 -0700
Message-Id: <20200626033144.790098-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 9 incorporates some review:

  * Adjust some commentary.
  * Added an assert for tbi in aarch64_tr_init_disas_context
  * Split arm,armv8.5-memtag to a new, final, patch.  We might
    just leave this one out of qemu mainline until the kernel
    patch set that requires it gets merged.


r~


Richard Henderson (46):
  target/arm: Add isar tests for mte
  target/arm: Improve masking of SCR RES0 bits
  target/arm: Add support for MTE to SCTLR_ELx
  target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
  target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
  target/arm: Add DISAS_UPDATE_NOCHAIN
  target/arm: Add MTE system registers
  target/arm: Add MTE bits to tb_flags
  target/arm: Implement the IRG instruction
  target/arm: Revise decoding for disas_add_sub_imm
  target/arm: Implement the ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for user-only
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
  target/arm: Tidy trans_LD1R_zpri
  target/arm: Add arm_tlb_bti_gp
  target/arm: Add mte helpers for sve scalar + int loads
  target/arm: Add mte helpers for sve scalar + int stores
  target/arm: Add mte helpers for sve scalar + int ff/nf loads
  target/arm: Handle TBI for sve scalar + int memory ops
  target/arm: Add mte helpers for sve scatter/gather memory ops
  target/arm: Complete TBI clearing for user-only for SVE
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  target/arm: Always pass cacheattr to get_phys_addr
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Add allocation tag storage for system mode
  target/arm: Enable MTE
  target/arm: Add arm,armv8.5-memtag to dtb

 include/hw/arm/boot.h          |    3 +
 target/arm/cpu.h               |   50 +-
 target/arm/helper-a64.h        |   16 +
 target/arm/helper-sve.h        |  488 ++++++++++++
 target/arm/helper.h            |    2 +
 target/arm/internals.h         |  153 +++-
 target/arm/translate-a64.h     |    5 +
 target/arm/translate.h         |   23 +-
 hw/arm/boot.c                  |   12 +-
 hw/arm/virt.c                  |   57 +-
 target/arm/cpu.c               |   81 +-
 target/arm/cpu64.c             |    5 +
 target/arm/helper-a64.c        |   94 +--
 target/arm/helper.c            |  423 +++++++---
 target/arm/m_helper.c          |   11 +-
 target/arm/mte_helper.c        |  906 +++++++++++++++++++++
 target/arm/op_helper.c         |   16 +
 target/arm/sve_helper.c        |  616 +++++++++++---
 target/arm/tlb_helper.c        |   13 +-
 target/arm/translate-a64.c     |  657 +++++++++++++--
 target/arm/translate-sve.c     | 1366 +++++++++++++++++++++-----------
 target/arm/translate-vfp.inc.c |    4 +-
 target/arm/translate.c         |   16 +-
 target/arm/Makefile.objs       |    1 +
 24 files changed, 4182 insertions(+), 836 deletions(-)
 create mode 100644 target/arm/mte_helper.c

-- 
2.25.1


