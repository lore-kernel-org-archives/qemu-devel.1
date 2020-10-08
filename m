Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4DC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA8620739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOlmXW8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA8620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQY1p-0006kd-Nr
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQXyx-0004I7-NS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:37:27 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQXys-0000Ui-5I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:37:27 -0400
Received: by mail-qk1-x744.google.com with SMTP id c2so7420249qkf.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=tC+strVV+B+K5HjAihiX4yitBIFB+2qfVBtZ+9OjiTQ=;
 b=NOlmXW8j1FNLs+EF0SboO9o25gLy3tiNVyH4ggxJygLBFWnZejLtJScDtDBDpXk//x
 O/BM4Jz/O5c497nBC+OhH6pEh0NxldSdUo9Y15aK5wHR1A9fmpvnb6DaXs/rrV8mFq3e
 wrAhLeuchfroKY4V/qx9JwO9A0O4rs+yR7qamn9bv5Bh/jPSPkg8T4GDFwWw0xlOQDys
 YCepBh03gMrc3IioFs7txZEEi22qWoY5e2eqIO/iaaTRl4huUrgM6qSPoen8sVDq8GUo
 bV4ZYCdpiy9v6cUUSQloGf1m371U08ldN8ugAMT2bQkxP6bi2e4pFuZ9OfGFhbvBiSBV
 3iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tC+strVV+B+K5HjAihiX4yitBIFB+2qfVBtZ+9OjiTQ=;
 b=bUtgspsbiJXfjPifRT9557NJ5M1qEiH5usRmNZKFyOd4s9iSPAGpX0wIa4sELuLdnM
 7FaCkKPkvlhzPtWlIw/ch3QCcaMDwH3mpExU5oKDlWIAFJs6c4/4TcUvNLVKhMKGMVGK
 kHC/aH9k7TpbP4aWLuUHWFHFTetL1qSV+vPpp9Yc/oSbCoVZSsS4kcyyGE5Dbc82M/A/
 Hydtq6B5Ox2WaYRVsyAsHt2t1huwR/U+ac4qycLC6txVznz1M1E1yO5ZmkI39BR8Nq2T
 TVAeKidYPxvaHA7yaO+P/3ll/fFr1wTiQ9LDeCM/SNUek0cXFChgwGhrDiCExMdXR+gK
 9HIQ==
X-Gm-Message-State: AOAM532YSjxis0IBoGLH4H/ccxkwGSK56FfYd6ktNlRmwzreaEWszPvG
 mO13Ax5pjPrUvPOis2KNV44/oQ==
X-Google-Smtp-Source: ABdhPJyyS70MkJX3lEVC4IyEMXiOCiIhrNlllL3n41AuHpDOZSjpw05/kjoClnEIsZjwsI5dHTzBSA==
X-Received: by 2002:a37:7d44:: with SMTP id y65mr1518461qkc.2.1602171440944;
 Thu, 08 Oct 2020 08:37:20 -0700 (PDT)
Received: from master.ht.home ([2607:fea8:e2a0:e950::d884])
 by smtp.googlemail.com with ESMTPSA id t186sm4170533qkf.48.2020.10.08.08.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 08:37:19 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v4 0/2] Add watchdog support for SbsaQemu
Date: Thu,  8 Oct 2020 11:37:16 -0400
Message-Id: <20201008153718.20143-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qk1-x744.google.com
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

Changes in v4:
- addressed review comments(interrupt no. added to dtb)

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c                   |  49 ++++
 hw/watchdog/Kconfig                 |   4 +
 hw/watchdog/meson.build             |   1 +
 hw/watchdog/wdt_sbsa_gwdt.c         | 346 ++++++++++++++++++++++++++++
 include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
 6 files changed, 471 insertions(+)
 create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h

-- 
2.18.4


