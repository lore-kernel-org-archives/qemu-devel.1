Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4BC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158EC20661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBPdFr3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158EC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyWb-0003dB-62
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySH-0006z1-Rm
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySG-0006OF-O5
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:21 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:39175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySG-0006NA-Eb
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:20 -0500
Received: by mail-pg1-x533.google.com with SMTP id 4so5474874pgd.6
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kV5Oe4FMruqN1Zb0e8r7LWJJnHaf5b2z31kzyTH4e1w=;
 b=HBPdFr3N5GxV2mr41k2sk2Bs9TNLcSF4V34ERVqRfPYy31xZDKZjKxVd6/rzFTKLGB
 X/yzbzudEhXKraDufMsNVbP8HoZKw3nZltJ1l4d4IZdAEPeElQtlT3VtZp8HXFoAuAWD
 l2fpRSQ5hlxzPr7i9wL7QUT85Z0SG/TrXdjQ1bh5pfDiRsC8HKMuNSmWCaNLwagogA3m
 ALLNm7gXD1am655BSw8xIPeFMGAoRaIyUY1lvlDvGnwmY3Fx8/tMJthhMbeA3eYKQLnb
 JoBAO/+LmoH6lBF38lTr1ij/gWbAhq5xz1aUvCycnYGkWB76qMonGoARNLWsbxJSflXs
 hOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kV5Oe4FMruqN1Zb0e8r7LWJJnHaf5b2z31kzyTH4e1w=;
 b=T2kuuNxGbT9jtwuHuYpD5y2a2HPISBnGePnzY4Wf0NOUCI4XnKkvXfGP0XexIbJT98
 2CFOvzXGF7qddvf8adwr8BiMw52/BYs/prNqAGXBMtjsNj0GbmMjGptUO97m1hfge1Ov
 VGkWRb1wbLH2GaKyaTIqQS/Hu50IEfTv98MtlpwT6jf2N/gbJ0C6tIP/Tal8KLEJCper
 6bYwmokrgl/EC74PN3D/vSiK3OyEaZ60neAi5d4YnU8FAObHipyg6CNUJoeKENaer760
 paj0GJC3FjGWEIFPxnNXWU905FWn6NU5TW2tv2/MbLLKE3+6shE2THzyeL5ng1xLwHcq
 veJw==
X-Gm-Message-State: APjAAAXVhP2ImPdkOz2kGo8ypW5g5FczQbx0tPYPNMI09uQezaSbIDau
 j53NCzT7AYzevzIeQAbd88UtK1IJYRU=
X-Google-Smtp-Source: APXvYqwoEYRXmH028Mb6as29G1z+NtWljOJ5VFIElFkFi594HCIOVkcfkIHsGMtoaI3z56zACMuDdg==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr17304016pfl.31.1580585358025; 
 Sat, 01 Feb 2020 11:29:18 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/41] target/arm: Implement ARMv8.1-VHE
Date: Sat,  1 Feb 2020 11:28:35 -0800
Message-Id: <20200201192916.31796-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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

Version 6 moves vhe_reginfo[] to file scope, and one tweak
to the vhe register access masking that Peter asked for.

All patches now have reviews.


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
 target/arm/helper.c        | 1220 +++++++++++++++++++++++++++---------
 target/arm/pauth_helper.c  |   14 +-
 target/arm/translate-a64.c |   47 +-
 target/arm/translate.c     |   74 ++-
 13 files changed, 1392 insertions(+), 681 deletions(-)

-- 
2.20.1


