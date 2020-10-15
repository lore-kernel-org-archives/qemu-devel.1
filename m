Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48693C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626422268
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUAKsAX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626422268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6FX-0008U1-IE
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kT6DY-0006sN-Sj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:35:04 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:45845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kT6DW-0007b9-7K
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:35:04 -0400
Received: by mail-qk1-x72e.google.com with SMTP id 188so2791163qkk.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=rvSXNjT8JPxW0VVKue71MTZay/ve70nbX8RtpH+3VLM=;
 b=TUAKsAX5bbcEMVRLunbQLBfzVSXkzeoX1AzTIDch3q7SjDT9YNGhXy14743DGYK/kr
 CI9qItD6MsmwR3UNFTNewzF8mzMqNJY5+jh3Vul+zjRAxgueNj8wTSVMXLbKVX2RVBtg
 9rwB5hmjJNya9j1qQdHV2HZAgGbTxlDtV9Q0lFXN2ARzyssNYYJ+KVZb6GCqweCdO9P/
 /bRxecQ8s/WKHKrG5QwK3XC3CBd1aM9OVCQE486du3jiFLBQf12C8E2eRrrB2/kpUBPN
 bVwLtcUu+GposDOvlQnY3488nywwwB4ygt6xeFrkFFD9t/+q2Z5cxbPlRqGwNAtZuzmZ
 6DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rvSXNjT8JPxW0VVKue71MTZay/ve70nbX8RtpH+3VLM=;
 b=MbF/QcWoiWhvce2pLleWhj214SoceiEeDWMoJSGPNDhkW5fb9rmKJHuZRmVgY6JWYs
 MDG6NCQWSknWbDkgj42vujI61tA+wD3M+6ACq82ufRznqMacqBBSqYukhfcDEXn43/Ng
 UhVttuo8KcysmuOGf2jXXdNgFxqDk/OATEKOOlFi3s7RL4KXi/JhOlA7w4fxXSeMP894
 TyF6zqOvTXQIbogJrIdXh00VL7S71bK7ZSGyVTUbjnBmWdY9zhFmBT3HO3FDTb7b9VTH
 PaTu+CfCBlq+8zX1NgfK6kSUe+iFNEdYcLu0bcW6iUfv+dyOyRigMvWEXb5nVirg0FEo
 boHA==
X-Gm-Message-State: AOAM532kdzaHgEwU5DFNW6fi0KkoxiOKQHxeK7Gd2OqVfkKI9Bp6Yxrb
 n7TjEYZ894ltl+KFXMN6eZLn1w==
X-Google-Smtp-Source: ABdhPJwF5rMRYT4ME/btnB8Q/4KZlgucHWFdM+m2Eo5Jve/I9t/L4LR7tJHLxgOURfAq28CFDQb9Eg==
X-Received: by 2002:a37:a312:: with SMTP id m18mr1875638qke.268.1602779700966; 
 Thu, 15 Oct 2020 09:35:00 -0700 (PDT)
Received: from localhost.localdomain
 (stsvon1503w-lp130-06-174-91-97-36.dsl.bell.ca. [174.91.97.36])
 by smtp.googlemail.com with ESMTPSA id s73sm1338373qke.71.2020.10.15.09.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 09:35:00 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v6 0/2] Add watchdog support for SbsaQemu
Date: Thu, 15 Oct 2020 12:34:57 -0400
Message-Id: <20201015163459.32298-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qk1-x72e.google.com
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

Changes in v6:
- removed the fdt code for wdt as it has no significance in sbsa

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c                   |  24 ++
 hw/watchdog/Kconfig                 |   4 +
 hw/watchdog/meson.build             |   1 +
 hw/watchdog/wdt_sbsa_gwdt.c         | 346 ++++++++++++++++++++++++++++
 include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
 6 files changed, 446 insertions(+)
 create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h

-- 
2.18.4


