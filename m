Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25457C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B0820658
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4FnqgBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B0820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxEu-0008IB-3b
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC0-0003VV-IA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxBy-0006YF-BU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:19 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:54658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxBy-0006UU-48
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:18 -0500
Received: by mail-pj1-x102e.google.com with SMTP id dw13so497319pjb.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oixdmiGNiYR4A87wyzZ9gvtOTzjdyaM42/ZisE5MzRg=;
 b=t4FnqgBtCn05kJh1sp5fhFEzlVTC8keFzloD3JnrunNcVEF4fGVX66qtdQb4NBorYj
 Ik9HGAzezwQ6qipPrXN02YuEB8yLrpaTD/4Z+dq7+M8/L7PjOhAmD4QHPHm9ukHDjEoK
 2NK3sjL6lB3+5YF6Di2eD4kqRahXWkrPEGoo7jCcm3q6VD9vCzl3/umE8MOAzKypdOEX
 5FvYMIByRTN9JG+o2pyDyD6oFbbLJz4YEpkYAS7RUz+zN4BG9OEHeZWE7tYklnfv3Fa0
 kNEFa/O7wk3bcxTOiT78aAWe/l2eX6RAthMCneiVpGgWIc8FNzjTll3pPuLRZgvvnT+L
 YiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oixdmiGNiYR4A87wyzZ9gvtOTzjdyaM42/ZisE5MzRg=;
 b=Qv2C97ixlXcrZJ4aYmMfBGxW1IHvXNWQM6Okc+/apbpPXd27KNu+lj1AEnl61WC34i
 RqnADPlUsKfo5gYXPzrnJKh0djB/7A28sFuWm67EiK4W77Kuq/NyVH7xjnoIoh63HvLP
 x8LAfbrYnFle9mqPpDrlAY0l39UnztKiR1zmnlMw55syf2SNdTszBjH1fEMIHUL5dQhO
 Ymo94UEttQt1N071Lhiry+VkzObaiohj5w9e9VMzqfABM/x83nbGjWs+fkjLdF+W3DQc
 vbUeP6NcEU8/EdjaJ8Fy1XluRFatWWZv3orbiehdpUeZ1iy9ZsdvwgJOU0m3fZRtFwqx
 nKDA==
X-Gm-Message-State: APjAAAVdqUGBE/jY0e8biYuGYaysb9yWKnjETUtuTJw06gatTSt/wBBu
 v/AVEQeDHSj4lxZ3jwDV5Cykaoyr6bw=
X-Google-Smtp-Source: APXvYqwLhAEW3VKIiKMJyAuFgruskVvM1QASOlGGMPfAA79vdIlXcml4E93qBKHMIglYTU5TRtWy9g==
X-Received: by 2002:a17:90a:109:: with SMTP id b9mr2506626pjb.77.1580342176237; 
 Wed, 29 Jan 2020 15:56:16 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/41] target/arm: Implement ARMv8.1-VHE
Date: Wed, 29 Jan 2020 15:55:33 -0800
Message-Id: <20200129235614.29829-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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

Version 5 applies the feedback given vs version 4, back in December.
There was quite a bit (thanks) and I believe I've gotten it all.

FWIW, the patches without review are:
   0028-target-arm-Add-VHE-system-register-redirection-an.patch
   0030-target-arm-Flush-tlb-for-ASID-changes-in-EL2-0-tr.patch
   0031-target-arm-Flush-tlbs-for-E2-0-translation-regime.patch


r~


Alex Bennée (1):
  target/arm: check TGE and E2H flags for EL0 pauth traps

Richard Henderson (40):
  target/arm: Define isar_feature_aa64_vh
  target/arm: Enable HCR_E2H for VHE
  target/arm: Add CONTEXTIDR_EL2
  target/arm: Add TTBR1_EL2
  target/arm: Update CNTVCT_EL0 for VHE
  target/arm: Split out vae1_tlbmask
  target/arm: Split out alle1_tlbmask
  target/arm: Simplify tlb_force_broadcast alternatives
  target/arm: Rename ARMMMUIdx*_S12NSE* to ARMMMUIdx*_E10_*
  target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
  target/arm: Rename ARMMMUIdx_S1NSE* to ARMMMUIdx_Stage1_E*
  target/arm: Rename ARMMMUIdx_S1SE[01] to ARMMMUIdx_SE10_[01]
  target/arm: Rename ARMMMUIdx*_S1E3 to ARMMMUIdx*_SE3
  target/arm: Rename ARMMMUIdx_S1E2 to ARMMMUIdx_E2
  target/arm: Recover 4 bits from TBFLAGs
  target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
  target/arm: Rearrange ARMMMUIdxBit
  target/arm: Tidy ARMMMUIdx m-profile definitions
  target/arm: Reorganize ARMMMUIdx
  target/arm: Add regime_has_2_ranges
  target/arm: Update arm_mmu_idx for VHE
  target/arm: Update arm_sctlr for VHE
  target/arm: Update aa64_zva_access for EL2
  target/arm: Update ctr_el0_access for EL2
  target/arm: Add the hypervisor virtual counter
  target/arm: Update timer access for VHE
  target/arm: Update define_one_arm_cp_reg_with_opaque for VHE
  target/arm: Add VHE system register redirection and aliasing
  target/arm: Add VHE timer register redirection and aliasing
  target/arm: Flush tlb for ASID changes in EL2&0 translation regime
  target/arm: Flush tlbs for E2&0 translation regime
  target/arm: Update arm_phys_excp_target_el for TGE
  target/arm: Update {fp,sve}_exception_el for VHE
  target/arm: Update get_a64_user_mem_index for VHE
  target/arm: Update arm_cpu_do_interrupt_aarch64 for VHE
  target/arm: Enable ARMv8.1-VHE in -cpu max
  target/arm: Move arm_excp_unmasked to cpu.c
  target/arm: Pass more cpu state to arm_excp_unmasked
  target/arm: Use bool for unmasked in arm_excp_unmasked
  target/arm: Raise only one interrupt in arm_cpu_exec_interrupt

 target/arm/cpu-param.h     |    2 +-
 target/arm/cpu-qom.h       |    1 +
 target/arm/cpu.h           |  423 +++++--------
 target/arm/internals.h     |   73 ++-
 target/arm/translate.h     |    4 +-
 target/arm/cpu.c           |  162 ++++-
 target/arm/cpu64.c         |    1 +
 target/arm/debug_helper.c  |   50 +-
 target/arm/helper-a64.c    |    2 +-
 target/arm/helper.c        | 1230 +++++++++++++++++++++++++++---------
 target/arm/pauth_helper.c  |   14 +-
 target/arm/translate-a64.c |   47 +-
 target/arm/translate.c     |   74 ++-
 13 files changed, 1402 insertions(+), 681 deletions(-)

-- 
2.20.1


