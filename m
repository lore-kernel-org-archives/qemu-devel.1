Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220BAC352A3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E465C21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcnSBw/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E465C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izepf-0004nz-1u
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeo9-0002m7-C9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeo8-0005uh-7D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:53 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeo7-0005gJ-Ti
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t3so6559300wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=An9AHo5LTKmhihjM8FLp2ZNgkIRPopo8irVw3eLNIC0=;
 b=VcnSBw/LWQi4pvEyZrQlrvshkuHcl2n+buegSoTmSb0pcHxOgHGssK3Eovh4fGC1Di
 tcsTeaT0pU1Jvob0tPULADFQFAj9O6FihkPMuCMksH4O17ZPbuZxwSjOdzkNlXFRqtDH
 8Xee5UPo5OgaVc59jFgDJhci1L+jcHF+F7qH6rwAKOWg91esb/iJ9uTEX+q93Ad51Ol7
 HJtkPxA41NqKq+CRLFV9o1/m12H4gpP0k+4pmClioMrI+NJi1uOvrlio5hHvEQJSN/NH
 69aaCXiOxagf2RKyvokT0vrOUwglpsfoRnvjCkSBg+Gt3RGPO813gt7Nk8SMqxO9Spql
 i+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=An9AHo5LTKmhihjM8FLp2ZNgkIRPopo8irVw3eLNIC0=;
 b=eOsJ5HVFJzu4nkIXTNZAWQ8eh2SvrfAF4Q0E2BzzOk/nU9ptr5bHxvNA4uU4ma01do
 75sdEWwwKQyOSciuwRKcQygAEFtw4DONlF9dY1+XHvdGWXP6mzxlXds2kdtOkCoU6aVj
 5PL/5OAr5fPq8viPwRS2SzGJ7TsCLSTBTERhSTDbUWdAWVreeW4FDKN1DHpHwaaaD9X2
 JvQQY/TXAUjTByysQo6yJuDnxN6k1lJkQxBEnVwcmV8RX3e0BGsoORrALUWldVhNr8Y/
 Wn3b+H6rfG8xQ+sR1MhRd1ij2HttuqVz6V1ALD/1nYeP6sXaKu1EDcvUY08ATtCbhZ9q
 BvPA==
X-Gm-Message-State: APjAAAWw5GGltpgoTdA90L8bdtfjEfR1f22F3mJGRmyJJTufgdL9TUDe
 LSCOCZFEgg5wGk5ijn8PwhUUjqsTvql40g==
X-Google-Smtp-Source: APXvYqznmLoQJ+3b3kBUxrddclVeFu21KKgrhzunH5m/pl6ZNNuQivnbzAu1d7rdMSK8G4SqpJ5AGQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3159739wrn.75.1580986489457;
 Thu, 06 Feb 2020 02:54:49 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/41] target/arm: Implement ARMv8.1-VHE
Date: Thu,  6 Feb 2020 10:54:07 +0000
Message-Id: <20200206105448.4726-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 7 has one more tweak to the vhe tlb flushing
that Peter asked for.  All patches have reviews.


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
 target/arm/helper.c        | 1211 +++++++++++++++++++++++++++---------
 target/arm/pauth_helper.c  |   14 +-
 target/arm/translate-a64.c |   47 +-
 target/arm/translate.c     |   74 ++-
 13 files changed, 1383 insertions(+), 681 deletions(-)

-- 
2.20.1


