Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF6C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4190720739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSAMq6kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4190720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWtF-0005j9-5U
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrv-0004B1-0H
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrr-0005xm-JL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id e17so6816846wru.12
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zuko7xYsx+AobCsIhmP+yoqpYry9yrG9L5exR0uadzA=;
 b=JSAMq6khaTK0XC+AX7k5W0R5fN5n7Dp1hpKCdiw71aOFuyQ5Eq5sh3k7KaevUhJeTi
 5DHYwpVLQGknG7km4/g3+Jp6xYd7e1YmZT6O8h6ZyPGfDpKPMJggLpIYsdvj+/5N08tN
 AQT0jfp8KlEoZX4UwKwRrTFm9Qrw8nv74f7yDLMJugzowVCctqhHpRo3GwltePgKiJFz
 P+GszsBFZm69ZoyR9xSB/wzf+ftKxHsrV6nT0KkHVpOZTAJVjOuE+Zg9HQHOFOeIeHNY
 xghG8KpL1kh/0joKPVDPnCxEnSE8zjOWx+V24OXre12SxD4SusSjRp6q2GTYmd6BsSBH
 iQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zuko7xYsx+AobCsIhmP+yoqpYry9yrG9L5exR0uadzA=;
 b=lMShrFvpspVqwgvviDPodeyLtL1jZV/+rP23KTvsbYLhtlJjoVo58LjLc2QLF4EoH4
 1kslJpzSnrSa7zW8/WmlYCuBAIFcq447GS7OkxMm7dq7EtPprLN8BatvxpwZcuqYJCWg
 jfuKjvbccf4H0bQmAwMACe1DZylyjiWUcZbI4Mtd+NklwqZVC0vkpA4dPX9T7uxyAgQV
 ETFUQvb/SkP2Z1U81upNPzCkNgubYtP5DDWC1oZdlE6TonWBfVHAIPZdn4kYZ1m3BYOV
 o1GMPZHvigM9ZdJtFnqJmqg6vMCPDvOlgYewfJdRhBuR2TuteVQ5eCeuJH+/swBOyqb8
 sEsQ==
X-Gm-Message-State: AOAM533kC7xETJaRZTDfOL1jGcFqDF+NyZHEThJjk1CKE+gjMQi3Msi1
 xGzg7reLeCiNPXZDdTByn07Y2UJ1FSoxWCQi
X-Google-Smtp-Source: ABdhPJzmQ5NuTZksAECuBhC6bvnuUDth18ttY2ablRFYPHVvDyJshle0cTuSHOhsYZ5kPP2UOGFyIg==
X-Received: by 2002:a5d:618a:: with SMTP id j10mr2034065wru.155.1602167160132; 
 Thu, 08 Oct 2020 07:26:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:25:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Thu,  8 Oct 2020 15:25:45 +0100
Message-Id: <20201008142557.9845-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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


The following changes since commit 6eeea6725a70e6fcb5abba0764496bdab07ddfb3:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-10-06' into staging (2020-10-06 21:13:34 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201008

for you to fetch changes up to ba118c26e16a97e6ff6de8184057d3420ce16a23:

  target/arm: Make '-cpu max' have a 48-bit PA (2020-10-08 15:24:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
 * hw/arm/fsl-imx25: Fix a typo
 * hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
 * hw/arm/sbsa-ref : allocate IRQs for SMMUv3
 * hw/char/bcm2835_aux: Allow less than 32-bit accesses
 * hw/arm/virt: Implement kvm-steal-time
 * target/arm: Make '-cpu max' have a 48-bit PA

----------------------------------------------------------------
Andrew Jones (6):
      linux headers: sync to 5.9-rc7
      target/arm/kvm: Make uncalled stubs explicitly unreachable
      hw/arm/virt: Move post cpu realize check into its own function
      hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
      tests/qtest: Restore aarch64 arm-cpu-features test
      hw/arm/virt: Implement kvm-steal-time

Graeme Gregory (2):
      hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
      hw/arm/sbsa-ref : allocate IRQs for SMMUv3

Peter Maydell (1):
      target/arm: Make '-cpu max' have a 48-bit PA

Philippe Mathieu-Daudé (3):
      hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
      hw/arm/fsl-imx25: Fix a typo
      hw/char/bcm2835_aux: Allow less than 32-bit accesses

 docs/system/arm/cpu-features.rst |  11 ++++
 include/hw/arm/fsl-imx25.h       |   2 +-
 include/hw/arm/virt.h            |   5 ++
 linux-headers/linux/kvm.h        |   6 ++-
 target/arm/cpu.h                 |   4 ++
 target/arm/kvm_arm.h             |  94 ++++++++++++++++++++++++++-------
 hw/arm/sbsa-ref.c                |   3 +-
 hw/arm/virt.c                    | 110 ++++++++++++++++++++++++++++-----------
 hw/char/bcm2835_aux.c            |   4 +-
 hw/ssi/npcm7xx_fiu.c             |  12 ++---
 target/arm/cpu.c                 |   8 +++
 target/arm/cpu64.c               |   4 ++
 target/arm/kvm.c                 |  16 ++++++
 target/arm/kvm64.c               |  64 +++++++++++++++++++++--
 target/arm/monitor.c             |   2 +-
 tests/qtest/arm-cpu-features.c   |  25 +++++++--
 hw/ssi/trace-events              |   2 +-
 tests/qtest/meson.build          |   3 +-
 18 files changed, 303 insertions(+), 72 deletions(-)

