Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC80C4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A2B20B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIDyGRGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A2B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQLtj-0007Mg-N0
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 22:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQLse-0005wd-W2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:42:09 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQLsd-0006tV-94
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:42:08 -0400
Received: by mail-qk1-x741.google.com with SMTP id 188so5421772qkk.12
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 19:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=EPZV1pH/RlzArv33v2pbw5bERsSaihTm+0cS0Fv9mss=;
 b=jIDyGRGc8Ww7OG9lojJ/VhjYPal30Bb/S53tb3Mzkcc7Q3+Ug2danEVGilAapVXiqV
 AZ3tAJKCGEKYkWNO/CfbNWMiDj0wvib1Zld9zjtyM/odIMMS3P8Sdio5kNo1wzR39hLp
 YWaKtZoTYFbzrjve5SWwQp6Z56crQY8d0WiFvwq0CfdJjgNzp9axH4hGq4wyrkvZXKNb
 +IP5wZZ9p5gj1HNYaEgzkAgWCa9pLnjnyOXCH2hYcgUEQGZmgKXUGn6fuqCDftJgnbcn
 xPzRrIL5XlDb2YrnBGymTxOMuwYhnUmlBFw6pSA9daSHJ7S3cEc6OJci3nGLCO9Rgo7l
 3+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EPZV1pH/RlzArv33v2pbw5bERsSaihTm+0cS0Fv9mss=;
 b=JzrHizd0Dxr20lBq6OtURgzuDmDBW/DW3YA1nI1tcNWtCY1EJ6QyteYtczs2m4cb1W
 2ILcpsL5jgWEM9PobCpWhcMiy76fN3o8KMbgNz7SIPMIENFsmNXu8Ve0xj8znLkUAoei
 fFCVQmBQjHYLuiJbGFCcDNOynPY8UNIXmOeRb9a4oBYpywCrahNVt/T6tG7BaiNsJM4X
 UxeKTgVYOvPSY4k2PjHEbqNSZfPXncrX95MwVwHi85sipm0OVZuCfF25OFVa8QPv/FHw
 TxUikCbBNqqocEMXD/BmA6qUcic6fctxYkKd9fiv/X5Qb4T7k7oZe2szFyq4hqZf/NU9
 ch9A==
X-Gm-Message-State: AOAM533JXBFRfsw3vcEH6SwzGPfddWwSKSKDON/lwOuQv/I8C0rkxd2J
 WWxbck6bn3Fn1xYENcSihke7Sg==
X-Google-Smtp-Source: ABdhPJx+YzqjpUjn9xi5LHWjTAC4rjdYhBl6mTJ1bWWeGhoFEzJwJSqaiZXDhUDikuV1qL/0CywUmw==
X-Received: by 2002:a37:aa42:: with SMTP id t63mr6084433qke.478.1602124925791; 
 Wed, 07 Oct 2020 19:42:05 -0700 (PDT)
Received: from master.ht.home ([2607:fea8:e2a0:e950::d884])
 by smtp.googlemail.com with ESMTPSA id m3sm3005031qkh.10.2020.10.07.19.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 19:42:05 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v3 0/2] Add watchdog support for SbsaQemu
Date: Wed,  7 Oct 2020 22:42:01 -0400
Message-Id: <20201008024203.112303-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qk1-x741.google.com
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

Changes in v3:
  - overall functionality has been tested (using edk2)
  - included dtb creation required for virt platform 

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c                   |  44 ++++
 hw/watchdog/Kconfig                 |   4 +
 hw/watchdog/meson.build             |   1 +
 hw/watchdog/wdt_sbsa_gwdt.c         | 345 ++++++++++++++++++++++++++++
 include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
 6 files changed, 465 insertions(+)
 create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h

-- 
2.18.4


