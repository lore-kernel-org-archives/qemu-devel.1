Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A10C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1E424900
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiERlVxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1E424900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSM3k-0007Rf-7L
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSM2W-00065G-P2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:16:36 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:41446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSM2V-0000Ah-1h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:16:36 -0400
Received: by mail-qk1-x743.google.com with SMTP id b69so100497qkg.8
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=hre4F+plBD5IZZTCSQVqpoMkNAABnjkZeqwM/SAcEeE=;
 b=HiERlVxaRhCt2x5ForrpP+fhpHNqOqaVkHF7l3R8/Aj0UqsgG3RHxIukz5cXV4ekDd
 nb301uMy64A4V0HNEFJELDhb9G+AkA+SAKWiRlhrQ7AyeDxZ8K9chfRfIJEhHoYIuKpN
 TP1o+RSFJGSUsRNZnmrb5KOGcAADKpl336O6DYlJ25j/KdEwLcjaytJRLVXYqC3gu2MV
 jHapnSHsKnTjok1fgbRUhN83YAvBFWyvnkTtDjB6rhhfldPLEiLmp1vhFUeDz6qx3IvK
 6GF+POqnOpokWTBbJhjbcdUKJ7gFVzZ4Dspbv8Ad7sBNEtQp1Mfn8e1+j9t5N/EDr4BM
 XmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hre4F+plBD5IZZTCSQVqpoMkNAABnjkZeqwM/SAcEeE=;
 b=jf7wYibazMgmHe4MGFz21I7/sTfm9C72hzTalfaM6MzANq6aEm5xZ6W59SbKUqE7bV
 JL0at8xCZMBDWfz6rLyqxORAx6C2bsySMzsxTMx88jVsCYGFOJ4kHhok9MPoRXo0pzqF
 /yJa2sZG/eckuANbGnubNPWp8N4bPjSrCd7twHlluIQnBe3oji+Dzuj68sVR/stIuadO
 eKdB0LwhH7hCxEXnzWQYU8jB72EqPib52fUq+l+c/ccr/mxVMN+dEoD0hlpZJxUEbXTr
 htzjzfUyIuvql5XbwPHH4VE4tTi+A1LoIrbmL36SJ69u+frnm+gMBzIV5e580ZVC+Iv5
 nf5Q==
X-Gm-Message-State: AOAM530ljBfsDI7nNDktxxq0f7dW9EdnQSrzBjdCdA8VVJ+Zr0OReIZZ
 qeL1rEW2Nm4L6j0dTtWylATIAw==
X-Google-Smtp-Source: ABdhPJyU16gz8Ln5Ajl4wicfBkCCBNByHxCgrdUcCMZdhcwHzm/depWVCWfpu1H6ioZE/it6E/cIqQ==
X-Received: by 2002:a37:393:: with SMTP id 141mr367809qkd.427.1602602193620;
 Tue, 13 Oct 2020 08:16:33 -0700 (PDT)
Received: from master.ht.home ([2607:fea8:e2a0:e950::5917])
 by smtp.googlemail.com with ESMTPSA id g20sm55604qtq.51.2020.10.13.08.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 08:16:32 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v5 0/2] Add watchdog support for SbsaQemu
Date: Tue, 13 Oct 2020 11:16:29 -0400
Message-Id: <20201013151631.30678-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds watchdog timer support for SbsaQemu platform.

The watchdog timer has been implemented first based on the generic
watchdog timer specifications from ARM BSA v0.9 and then used 
in the SbsaQemu reference platform

Changes in v5:
- updated irq number of gwdt in sbsa-ref since the same
  is being used by SMMU as per latest master merge
- addressed review comments

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c                   |  50 ++++
 hw/watchdog/Kconfig                 |   4 +
 hw/watchdog/meson.build             |   1 +
 hw/watchdog/wdt_sbsa_gwdt.c         | 346 ++++++++++++++++++++++++++++
 include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
 6 files changed, 472 insertions(+)
 create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h

-- 
2.18.4


