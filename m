Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C162C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0653A2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcAVlFee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0653A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04vU-0002fo-8k
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uV-0001X1-Ra
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uT-0001Kd-Sd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id k20so7511665wmi.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CeDcorImRHrJQvllkZdubqT0Hs0i7TqihlRwmo6cCrc=;
 b=JcAVlFeesalfH1cSVnSOHokObuig6NlRfXivmfzyUufldqq1d5hYLmP6Yqmr/RI5zR
 EzgB/ryqLry4KW3WSLqqvTI+9IFcbn1zvai6j7R6NJhglZyn1jJVUv1vASIxiTjrwaeb
 DPGNJckCMBSwQv8WGqshI6aq7gXYTwueuiGaVoiLJVsN5XgSdEM7+Yw+tdJRnXoRcqI2
 2GcWzbYj+t4jTyM7na69jT/T133KUZNFgJ1JXVKHzKbno5cIS6QzSpDorL6y08u0C5Ha
 P2/lEBil6u29r9MQikowe6aDRbBrGs/5EkgBLsSmYzv79eHlON6PfttiNeUVc1IFeFjf
 UunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CeDcorImRHrJQvllkZdubqT0Hs0i7TqihlRwmo6cCrc=;
 b=oWxI5/ode114oJCVRSdd8KUBriX/djGfQNE1SGKz3kAKNL4MHdopbTBwlI+e5UYecT
 AuILdI1mUeAgg7iZjhzp1xt2uDWi+dExv7WZ5smqKg0gOW37vjE3dXy+6P2ba/ex+z2W
 H5WzZDOdCBi5Z+5VVWh7PfwM88eiqKbELYYMqp6Chi8AvkjRTiHFg3tu/jqKEjHGhp8P
 6dXTAWNtR1GmeaYrHaaPSmAkSRSi+ugDSbIKgCjw1VIJ4fyz7KIK52Gy3JgCCEuxKcE4
 9T/PQvN54TaKpta4sivQNNZ3vO3vRU0WKZi41tCt1urDC6DEtJAmU3W9xZIbhpgcFYP6
 kvZA==
X-Gm-Message-State: AOAM5320U0LzQvc6McqoQtR7ELv9Uk731N6X/ll34dAJfWmrGLymRbes
 EQSmmr3BrRWnSJ90x7sTR/EkDDsfMQbYVA==
X-Google-Smtp-Source: ABdhPJxgDrgIMeN33bspvIRFmBtrD2snpEDxMLObUIvv4sfOx1ZBa8J5y7EQOIuDmGSgdichMOoIkQ==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr21017814wmh.11.1595863163510; 
 Mon, 27 Jul 2020 08:19:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] target-arm queue
Date: Mon, 27 Jul 2020 16:19:13 +0100
Message-Id: <20200727151920.19150-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

Just some bugfixes this time around.

-- PMM

The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200727

for you to fetch changes up to d4f6dda182e19afa75706936805e18397cb95f07:

  target/arm: Improve IMPDEF algorithm for IRG (2020-07-27 16:12:11 +0100)

----------------------------------------------------------------
target-arm queue:
 * ACPI: Assert that we don't run out of the preallocated memory
 * hw/misc/aspeed_sdmc: Fix incorrect memory size
 * target/arm: Always pass cacheattr in S1_ptw_translate
 * docs/system/arm/virt: Document 'mte' machine option
 * hw/arm/boot: Fix PAUTH, MTE for EL3 direct kernel boot
 * target/arm: Improve IMPDEF algorithm for IRG

----------------------------------------------------------------
Dongjiu Geng (1):
      ACPI: Assert that we don't run out of the preallocated memory

Peter Maydell (1):
      docs/system/arm/virt: Document 'mte' machine option

Philippe Mathieu-Daudé (1):
      hw/misc/aspeed_sdmc: Fix incorrect memory size

Richard Henderson (4):
      target/arm: Always pass cacheattr in S1_ptw_translate
      hw/arm/boot: Fix PAUTH for EL3 direct kernel boot
      hw/arm/boot: Fix MTE for EL3 direct kernel boot
      target/arm: Improve IMPDEF algorithm for IRG

 docs/system/arm/virt.rst |  4 ++++
 hw/acpi/ghes.c           | 12 ++++--------
 hw/arm/boot.c            |  6 ++++++
 hw/misc/aspeed_sdmc.c    |  7 ++++---
 target/arm/helper.c      | 19 ++++++-------------
 target/arm/mte_helper.c  | 37 ++++++++++++++++++++++++++++++-------
 6 files changed, 54 insertions(+), 31 deletions(-)

