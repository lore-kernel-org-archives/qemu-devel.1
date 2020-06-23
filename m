Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2598C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDFB2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4vb/QF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDFB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnokU-0005oW-TY
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojB-00039r-VY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:47058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnoj8-0005U4-UQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id n2so9523962pld.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5g+LfVWBF+3Lekw1EiZ6vk0vC87Y80r54VLd03wJ0CQ=;
 b=O4vb/QF6Z8AKNIq16OGaYOQW9y4vJSge6ZjNtaJNWKh1eSQAadWK2iLG8VEkU0OFeA
 owkTcCPey56/TnbUWZ3+1Gv9CHEcsbULMEdCXAJ2FIOPN4FZs+pP9ntSGoXqlaIYcde3
 jfJuQ8kBsDideJBmGhRJxdTh++aDgXyypRN8y1yhDvy8xjUBF3RQQGctmg/PqUm2LzS6
 KDxbGxFg6mY23RELGwMRstBSpWRBlRdEu+w1nw4knPkB4krbAcnkfQVLx/htp+ZhjeAl
 4/bcT1KD4qxvglcd0oim7lyiGTdjK8BjcoMQGy6WqFerJME2GKaUuB6KdPveYEQZqgJD
 L5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5g+LfVWBF+3Lekw1EiZ6vk0vC87Y80r54VLd03wJ0CQ=;
 b=TPkxG4mr4JzkKGYac/ORON4Dst+BUrrJHoxWdxCbB62MyLirWIE7XXdP+JEnKAW47j
 ZVzlyRz3o4oPaVt3907DcfNAj+GqdMWD8s7jcc2xppe7q51jub5bHvrh9cgcEi4oSgOG
 1/6Q/HjAdb0+ki3EtQPL7jxdfSl0SEhAw0sKint91h0qM6AYV5jrtHnasTcmJ/Vp8nxG
 pnE7xxldc8g1vlsdoMBeXdvP2IJBYqR8LAFX6Om54RZPz41epzctLZJ2ARKmLPAYUCWp
 R1zschsW4dgwklVrRefFNHtAfLYbtq0+KjDgXqkMHOhRuJ3FBDZfGh2ahkbNavsh+/lj
 5UEA==
X-Gm-Message-State: AOAM530R6GvNHTWDwAT4Ujn712hwwYCeS6zM1iAC7c8LWhbjMuObDm0V
 ANUCFtGIzIaqp3/diVkrGuFfwam1/DA=
X-Google-Smtp-Source: ABdhPJxMoYMYFn8YcDJ7xqeyBqN9bg9ZmH5H32d/1T8KlvTaQNNOktAZCynNDifvQPnNyIXt0/Xp2g==
X-Received: by 2002:a17:90a:f282:: with SMTP id
 fs2mr2356994pjb.132.1592941020803; 
 Tue, 23 Jun 2020 12:37:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:36:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/45] target/arm: Implement ARMv8.5-MemTag, system mode
Date: Tue, 23 Jun 2020 12:36:13 -0700
Message-Id: <20200623193658.623279-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Version 8 incorporates quite a bit of review (thanks, PMM):

 * Include HCR_DCT in the HCR_EL2 update.
 * Use a separate decode function for ADDG/SUBG.
 * Use the system arm_cpu_do_unaligned_access for user-only as well.
 * Fix alignment for LDG.
 * Fix no-fault for mte_probe1.
 * Rearrage how tagged pages are recorded.

and perhaps most visibly, for those tracking the kernel patches:

 * Add arm,armv8.5-memtag to the dtb.


r~


In need of review:
0010-target-arm-Revise-decoding-for-disas_add_sub_imm.patch
0011-target-arm-Implement-the-ADDG-SUBG-instructions.patch
0014-target-arm-Define-arm_cpu_do_unaligned_access-for.patch
0015-target-arm-Implement-LDG-STG-ST2G-instructions.patch
0025-target-arm-Implement-helper_mte_check1.patch
0028-target-arm-Use-mte_checkN-for-sve-unpredicated-lo.patch
0029-target-arm-Use-mte_checkN-for-sve-unpredicated-st.patch
0030-target-arm-Use-mte_check1-for-sve-LD1R.patch
0031-target-arm-Tidy-trans_LD1R_zpri.patch
0032-target-arm-Add-arm_tlb_bti_gp.patch
0033-target-arm-Add-mte-helpers-for-sve-scalar-int-loa.patch
0034-target-arm-Add-mte-helpers-for-sve-scalar-int-sto.patch
0035-target-arm-Add-mte-helpers-for-sve-scalar-int-ff-.patch
0036-target-arm-Handle-TBI-for-sve-scalar-int-memory-o.patch
0037-target-arm-Add-mte-helpers-for-sve-scatter-gather.patch
0038-target-arm-Complete-TBI-clearing-for-user-only-fo.patch
0041-target-arm-Always-pass-cacheattr-to-get_phys_addr.patch
0042-target-arm-Cache-the-Tagged-bit-for-a-page-in-Mem.patch
0043-target-arm-Create-tagged-ram-when-MTE-is-enabled.patch
0044-target-arm-Add-allocation-tag-storage-for-system-.patch
0045-target-arm-Enable-MTE.patch


Richard Henderson (45):
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
 target/arm/cpu.c               |   77 +-
 target/arm/cpu64.c             |    1 +
 target/arm/helper-a64.c        |   94 +--
 target/arm/helper.c            |  423 +++++++---
 target/arm/m_helper.c          |   11 +-
 target/arm/mte_helper.c        |  901 +++++++++++++++++++++
 target/arm/op_helper.c         |   16 +
 target/arm/sve_helper.c        |  616 +++++++++++---
 target/arm/tlb_helper.c        |   13 +-
 target/arm/translate-a64.c     |  652 +++++++++++++--
 target/arm/translate-sve.c     | 1366 +++++++++++++++++++++-----------
 target/arm/translate-vfp.inc.c |    2 +-
 target/arm/translate.c         |   16 +-
 target/arm/Makefile.objs       |    1 +
 24 files changed, 4164 insertions(+), 834 deletions(-)
 create mode 100644 target/arm/mte_helper.c

-- 
2.25.1


