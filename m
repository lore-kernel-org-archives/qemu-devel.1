Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D6D2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP0nKMDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby08-00058j-T6
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwc-0002xl-VZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwb-0007tY-DZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:37587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwb-0007rc-5a
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id bb5so1006896plb.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=14Zi+T80Ovu7e06dTigMpOq1+RGJ8peMNyK4ZNWD+o8=;
 b=hP0nKMDa2a3E3Y/ErNBBQ2WMCwKZxfBRYSWUdILyVhjNBbiPzhJ6jQz1Ae+uHAknBN
 EVj52mUCkgWOKOdYY6YyTmflOSUDmZrsI+YSoUFIRnI62tTR5E4CIz6UAPaKFemQSH5i
 evUlWeQn1jkksZjc6BN2FYjAvPG9/4+Nan7fs7YzB4Jd1wk8T18pXfwUkKWzI+Fj0qO8
 FU2RkptK9Onfg1ZUt1hbCM3tSNliob1Xl4JVpOjCSqDghFJXT2k5aqr9npy3/U6vyZsa
 N7ufdM5aq3WgQ2SnZ0feaxisvYz0XPgWU7WVcEd8dS6T0l+6IQcda8r7uf12JWaTMYHA
 JXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=14Zi+T80Ovu7e06dTigMpOq1+RGJ8peMNyK4ZNWD+o8=;
 b=sv6ICWgcY3R0SduTfv693TttcLKsa6ncXY7iMDGTTTya15X6CcD35Kc4vMIj/TbEaZ
 MvKTMAhhc4DUCo630ZYV7t3qtVIqTfjIppsQWA597UkRXHmZCIzOS9H9WRZdsmfT35CJ
 g3vH8snYH6M3KWcALmSwgr9bKHSXotNnc9Puo3KBCLyeXtiwENF4c3TkFhfhpxGGgsNO
 lbZ6uiEevi66FQFMYsF2tcLqeWDRfvK7Yg/ufQ2dPnUMuwjXk3ZzYossR+cyO/CaAbEc
 N+q41woGWheIA6N2y2uGawyvAaIjcgk3bK4PwQ3T3bteBZVz3REF2qQBLQ0+14zg5OMv
 mIzQ==
X-Gm-Message-State: APjAAAWDPY+dTP9WPmwvcs//qWy/r5j3zN9bKt8gWpFddlYmALt5bpU6
 N9q9nZ9nftB8wIVq6Q7y6PUxWkqQReQ=
X-Google-Smtp-Source: APXvYqyZleJeUC9YxB+2ftJOwgNkQA1Y5GP0HeWLo4IWRo7ld0g+1yfclQIBYP5JF9GWqlQw7qVyhg==
X-Received: by 2002:a17:90a:c68f:: with SMTP id
 n15mr2982694pjt.20.1575340179241; 
 Mon, 02 Dec 2019 18:29:39 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/40] target/arm: Implement ARMv8.1-VHE
Date: Mon,  2 Dec 2019 18:28:57 -0800
Message-Id: <20191203022937.1474-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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

Version 3 was posted back in August.  Though quite a lot has changed
and perhaps there's no use in comparing.  I haven't done a list.

Against master, it is the first version that can actually boot a
nested kernel under kvm, so that's certainly a change for the better.

It's not even particularly slow.  With both outer and nested kernel
using a minimal busybox initrd, the outer kernel boots in 4.0 seconds
and the nested kernel boots in 6.7 seconds.


r~


Alex Bennée (1):
  target/arm: check TGE and E2H flags for EL0 pauth traps

Richard Henderson (39):
  target/arm: Define isar_feature_aa64_vh
  target/arm: Enable HCR_E2H for VHE
  target/arm: Add CONTEXTIDR_EL2
  target/arm: Add TTBR1_EL2
  target/arm: Update CNTVCT_EL0 for VHE
  target/arm: Split out vae1_tlbmask, vmalle1_tlbmask
  target/arm: Simplify tlb_force_broadcast alternatives
  target/arm: Rename ARMMMUIdx*_S12NSE* to ARMMMUIdx*_E10_*
  target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
  target/arm: Rename ARMMMUIdx_S1NSE* to ARMMMUIdx_Stage1_E*
  target/arm: Rename ARMMMUIdx_S1SE* to ARMMMUIdx_SE*
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
 target/arm/cpu.h           |  434 +++++--------
 target/arm/internals.h     |   71 ++-
 target/arm/translate.h     |    4 +-
 target/arm/cpu.c           |  161 ++++-
 target/arm/cpu64.c         |    1 +
 target/arm/debug_helper.c  |   50 +-
 target/arm/helper-a64.c    |    2 +-
 target/arm/helper.c        | 1219 +++++++++++++++++++++++++++---------
 target/arm/pauth_helper.c  |   14 +-
 target/arm/translate-a64.c |   47 +-
 target/arm/translate.c     |   73 ++-
 13 files changed, 1397 insertions(+), 682 deletions(-)

-- 
2.17.1


