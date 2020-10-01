Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF5C4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F7F20780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpQ0iyVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F7F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO00K-0007DV-40
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsQ-0004g7-6T
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsN-0002wW-Vh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id k15so6103748wrn.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xpBepFLnB1FHTPsZP/kkbfQzJ+gSRU8kw7Rafv/zhVM=;
 b=ZpQ0iyVDyyrDEOMIXuW+3PAcD+y5ANvi0yT8CP3MbMfX70AoTXWqzpIrqWdzbfF8I7
 y/IViZex9iR1cHnSy0fm7P64ELPsoZfWhuUGzXGOKCUlhCn0yz9/w2kNVExHNwng6r+s
 sGWBfNEHFiIJxzvZvSShBX+1Iw+GXbZMpqkh78LNZEZl6tDSSfVJArnCju0IB/QBsbZQ
 O+lEmDQmomnDobb+VmuGKTFsd/hpDbqN53WzSHprL+QbkBSLjEn9oG4/AgufvEQDlE42
 AXsiSu1H1vj3C1zjpdfK7ksG/TzQ+8GKpAaXCxJLsZFNwClTge6v/WwiWceyUpPjwNJU
 Vtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xpBepFLnB1FHTPsZP/kkbfQzJ+gSRU8kw7Rafv/zhVM=;
 b=TwBE6aI9og5GqvU/FnhTwaTLVOm/0fQNac6tIiAdHjcnZJB+Qee404SJ4YOxJX3bqL
 mxFbRfztOYP1+0Chppj+0djywV73IXeJtdYsNNSGUQ+UzZvyXoIK17L9TmQR1tZwsJwc
 zvxLO4DznzQMaKWlChvncaKAkcSOeQN1JpDuldFS+N13S47f8tR8w83ei2rdRxm7mtcX
 PmLpv32v85ltxIfyndVWSmaWq34WDHHU/802MNQTi5X8yiflA287THZaK/KQhTYo80Rw
 3viCPgvmyxwO6vqIoZZF18y89hSRdFqU4cPfd3xHLhRoz8UftAW1NmFwKDyF5EGLZGu8
 OY+A==
X-Gm-Message-State: AOAM53054ab0qepBDtOcq7viEn3jYYpaeu0sqgU+St1fgtVH0bxKvw3J
 AnZm1ACzZusC9aPAKh0JAjSwvcy4LVxasUW1
X-Google-Smtp-Source: ABdhPJwOOM+Gt9CaHtH+TFklZ4l1i4YDYWhTRRCBgIfiNikFghvih3vN8nlH/u6emkIv3MYCMhJHYQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr9307564wrb.70.1601563685774;
 Thu, 01 Oct 2020 07:48:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] target-arm queue
Date: Thu,  1 Oct 2020 15:47:41 +0100
Message-Id: <20201001144759.5964-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Nothing very exciting this time around...

-- PMM

The following changes since commit 37a712a0f969ca2df7f01182409a6c4825cebfb5:

  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-01 12:23:19 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201001

for you to fetch changes up to cdfaa57dcb53ba012439765a1462247dfda8595d:

  hw/arm/raspi: Remove use of the 'version' value in the board code (2020-10-01 15:31:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * Make isar_feature_aa32_fp16_arith() handle M-profile
 * Fix SVE splice
 * Fix SVE LDR/STR
 * Remove ignore_memory_transaction_failures on the raspi2
 * raspi: Various cleanup/refactoring

----------------------------------------------------------------
Peter Maydell (5):
      target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA check
      target/arm: Move id_pfr0, id_pfr1 into ARMISARegisters
      hw/intc/armv7m_nvic: Only show ID register values for Main Extension CPUs
      target/arm: Add ID register values for Cortex-M0
      target/arm: Make isar_feature_aa32_fp16_arith() handle M-profile

Philippe Mathieu-Daudé (11):
      hw/arm/raspi: Define various blocks base addresses
      hw/arm/bcm2835: Add more unimplemented peripherals
      hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2
      hw/arm/raspi: Display the board revision in the machine description
      hw/arm/raspi: Load the firmware on the first core
      hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState
      hw/arm/raspi: Avoid using TypeInfo::class_data pointer
      hw/arm/raspi: Use more specific machine names
      hw/arm/raspi: Introduce RaspiProcessorId enum
      hw/arm/raspi: Use RaspiProcessorId to set the firmware load address
      hw/arm/raspi: Remove use of the 'version' value in the board code

Richard Henderson (2):
      target/arm: Fix sve ldr/str
      target/arm: Fix SVE splice

 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/arm/raspi_platform.h      |  51 ++++++++++--
 target/arm/cpu.h                     |  50 +++++++++--
 hw/arm/bcm2835_peripherals.c         |   2 +
 hw/arm/raspi.c                       | 155 +++++++++++++++++++----------------
 hw/intc/armv7m_nvic.c                |  46 ++++++++++-
 target/arm/cpu.c                     |  21 +++--
 target/arm/cpu64.c                   |  12 +--
 target/arm/cpu_tcg.c                 |  60 ++++++++++----
 target/arm/helper.c                  |   9 +-
 target/arm/kvm64.c                   |   4 +
 target/arm/translate-sve.c           |   6 +-
 12 files changed, 286 insertions(+), 132 deletions(-)

