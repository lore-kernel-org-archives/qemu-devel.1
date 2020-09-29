Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB5C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B127921548
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbgeoCG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNK2m-0000k4-Nm
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kNJz6-0006nV-VW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:16 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:42296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kNJz3-0001LJ-OE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:16 -0400
Received: by mail-qt1-x832.google.com with SMTP id y11so4306574qtn.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+h69EmieUbWvODNNCpUiSWzZcoG0tS7XdI1g16MM+WE=;
 b=ZbgeoCG/qDIswEqh85pjfQIIgtqGWD0Y8F0l735YR4M1qQ0aF+HMrAzX4K9M9IONDl
 hEuhkeMXPkdovnvdAPoKSJpO8f/Xcp5aqFQgAt8Rr+bK7fSUtGOXpjKRHHvx/BnDE6um
 Zs0V3TsVx9i5FIVqfmEwqaqk0uFnwIAUQ96ymqHSxuPkBhMaq1FwJ9hd6G7wQCrsfF0+
 EYToxYKwNyyR6t+EYdN6B0/H2gflecNJqO+fezMqKaooipAi7WBE4e7jhGW95aVHV7Db
 Zdm7T+3xkbnZbBdKUioej80URhx9p68AAXPoFe/C3eoSw4Cb35jeSXDlMT3zunL0Q0VV
 hCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+h69EmieUbWvODNNCpUiSWzZcoG0tS7XdI1g16MM+WE=;
 b=bxPk3me8L54OyflEtN5VyMSNqbydOCPToXjFN24aS6Rz3S68GoOnch/UBu7mX8rdxG
 gJQesl+9xzb+qFUlWemvRmpS1sBf6U1PsRlb9AmCm5tGSEJ6Q65Uyl3Y4jmsO7vC27N3
 vOi1i1c/B6LtHLn4xIdc9VlHZZC+LkrcYclLnwXCgb2f2vVl1qfcp5G3TAPhPw1UqBdM
 TY1GA/7ZM8OK2l1yKCbJm5PgwyFkgyyhdsDGLZXpABDCjMKg8surzBiC4loDRBk29FKc
 kO1MjOichRGbWbcL4o/mTe+6w6qz2dhOj90NREfZbyX6ThRy2I9mrUT+wH/Db1utOpxr
 7eEg==
X-Gm-Message-State: AOAM5338Yt7RiewC7E7WhaY7eyYz9gnQIjZbiNmLDq1qMHndppzz7dc4
 LAw54YEFf5OQsgxsZCiby+QNYg==
X-Google-Smtp-Source: ABdhPJyhI9UDK/xKL2HdEiZWE58Zmr8DHFA9yJ63Ul0BJiLpXsTlY+5Bp6lVktzjQDmtAm0Jk929ww==
X-Received: by 2002:aed:29a6:: with SMTP id o35mr4616608qtd.123.1601402652116; 
 Tue, 29 Sep 2020 11:04:12 -0700 (PDT)
Received: from master.hitronhub.home ([2607:fea8:e2a0:e950::661])
 by smtp.googlemail.com with ESMTPSA id n7sm6600337qtf.27.2020.09.29.11.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 11:04:11 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v2 0/2] Add watchdog support for SbsaQemu
Date: Tue, 29 Sep 2020 14:04:08 -0400
Message-Id: <20200929180410.33058-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x832.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes in v2:
  - split the previous single patch into 2
  - addressed the fprintf replace review comment

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c                   |  23 ++
 hw/watchdog/Kconfig                 |   4 +
 hw/watchdog/meson.build             |   1 +
 hw/watchdog/wdt_sbsa_gwdt.c         | 344 ++++++++++++++++++++++++++++
 include/hw/watchdog/wdt_sbsa_gwdt.h |  68 ++++++
 6 files changed, 441 insertions(+)
 create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h

-- 
2.18.4


