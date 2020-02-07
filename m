Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C34C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F5520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmyP4OO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F5520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04jj-0003v7-3I
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hZ-00081P-7S
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hX-00029C-KE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hX-00026n-CI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y11so2953556wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sGknWPMvKJK0HTDj8BosRIv5ksIkG2daZ/mmCdeplGE=;
 b=jmyP4OO9RZwuaXi37LoB3uC8ucc11a8q2ZbPbhKNCeolb0irKdQ6npsEE4w7bsJASl
 ZT1V8M6Lb3u137MqqGFhNz7p5947XhjJe6e3jK9/uhx25IfBZatuuUKUlyjuqSZD4j6O
 Cf9oVNosmtbruYcFbtjFTLTwUiDvIc6w/lzNk+E9qJfe0S78Jm9M+cH58EOmAsZqrS+T
 R+cPNt4e873bkLBHp6wAz6MhIFCcQUWIEkozYAQX9zm/+ubiZUsFhDRt7bV1ZCjIxd6k
 fpX1oFwLhlUCbIDvjTQcuzznszN9btwQThu698qniUPXT7siKYPJgRQtyLI2LhFCSv3D
 3eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sGknWPMvKJK0HTDj8BosRIv5ksIkG2daZ/mmCdeplGE=;
 b=gF9A2WaqaoLuFjJnrdYPHSHCpoF50C3nE0O7lYnqQ/938yF1cn46tJaJIu2UXeYIo9
 QN5ciGvyK3BZOZ8zDZMmYWpSwtnZwZSpfCaNSYgCE1TIMk+ABqEAcf1iJndS8jpyue8t
 +JUub/XBaB0sy9gqAAjvlx6nfuivaPXVakX7cjpg7+dIguzS2LRQcd4zIpuJja75UGeo
 KSWwGNvYDrhkRzHZ+lykFuB+oWeZTcnh1QTLh8FoyFuqX6SMAeKZ+uxjvVjYy0wmtqix
 Nkge+FUaV4d5CQ4X7TRMYVObbaOhNl5YD3dWIdL/wI4uIpKrFaMkUeP97Tyryb0CBq2M
 c4sg==
X-Gm-Message-State: APjAAAXT9vShbWtcuO3PyGeKD34tLfOyWL53/KN1Pm3CunbXqut7EF2a
 68RN7UY8jZS9EMdp+9Zs2pWqdyLilbc=
X-Google-Smtp-Source: APXvYqyOm+QnwUxToeIVIMycUiwX0Z1S6b83PkvhNIHU/dyvYi5cGg5gnlYh5VjMoE/yGPQjbKhnvQ==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr5287051wru.296.1581086025884; 
 Fri, 07 Feb 2020 06:33:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] target-arm queue
Date: Fri,  7 Feb 2020 14:32:55 +0000
Message-Id: <20200207143343.30322-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

The big thing here is RTH's patchset implementing ARMv8.1-VHE
emulation; otherwise just a handful of smaller fixes.

thanks
-- PMM

The following changes since commit 346ed3151f1c43e72c40cb55b392a1d4cface62c:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20200206.0' into staging (2020-02-07 11:52:15 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200207

for you to fetch changes up to af6c91b490e9b1bce7a168f8a9c848f3e60f616e:

  stellaris: delay timer_new to avoid memleaks (2020-02-07 14:04:28 +0000)

----------------------------------------------------------------
target-arm queue:
 * monitor: fix query-cpu-model-expansion crash when using machine type none
 * Support emulation of the ARMv8.1-VHE architecture feature
 * bcm2835_dma: fix bugs in TD mode handling
 * docs/arm-cpu-features: Make kvm-no-adjvtime comment clearer
 * stellaris, stm32f2xx_timer, armv7m_systick: fix minor memory leaks

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: check TGE and E2H flags for EL0 pauth traps

Liang Yan (1):
      target/arm/monitor: query-cpu-model-expansion crashed qemu when using machine type none

Pan Nengyuan (3):
      armv7m_systick: delay timer_new to avoid memleaks
      stm32f2xx_timer: delay timer_new to avoid memleaks
      stellaris: delay timer_new to avoid memleaks

Philippe Mathieu-Daudé (1):
      docs/arm-cpu-features: Make kvm-no-adjvtime comment clearer

Rene Stange (2):
      bcm2835_dma: Fix the ylen loop in TD mode
      bcm2835_dma: Re-initialize xlen in TD mode

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
 target/arm/cpu.h           |  423 ++++++----------
 target/arm/internals.h     |   73 ++-
 target/arm/translate.h     |    4 +-
 hw/arm/stellaris.c         |    7 +-
 hw/dma/bcm2835_dma.c       |    8 +-
 hw/timer/armv7m_systick.c  |    6 +
 hw/timer/stm32f2xx_timer.c |    5 +
 target/arm/cpu.c           |  162 +++++-
 target/arm/cpu64.c         |    1 +
 target/arm/debug_helper.c  |   50 +-
 target/arm/helper-a64.c    |    2 +-
 target/arm/helper.c        | 1211 ++++++++++++++++++++++++++++++++------------
 target/arm/monitor.c       |   15 +-
 target/arm/pauth_helper.c  |   14 +-
 target/arm/translate-a64.c |   47 +-
 target/arm/translate.c     |   74 +--
 docs/arm-cpu-features.rst  |    2 +-
 19 files changed, 1415 insertions(+), 692 deletions(-)

