Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AA720857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDP8OxwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AA720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Iz-000234-KU
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzV5-0007Bm-PA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:09 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:36828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzUz-0005vN-6M
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:07 -0400
Received: by mail-qt1-x82f.google.com with SMTP id c5so1306026qtw.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=x3HzKkx6lPNCdrtmHwZ5BJWLYIYYeagcYSVMA3RXMcA=;
 b=wDP8OxwNIeAXUJuWCP7EsiXcZhCe7nIFfLx1apvyceO7UdZ9QJlA0an/XyQkNsYCgP
 bIG3yKvi44wCMUBhSlXkn7O2eqMxtDLZHKCxc554Ms29KxEYyV98OOZWyrq8InTVNIqE
 oY2p3+cBiHJQf7ftWfmvYPExppQf9VIwolkOJht+n0Agwkx+tPDV3CU/wTOplXmGroZB
 mFxlCkwS95QhaxwFmyaS/VE4ZMr1QTtxAC6vj/+UxndrzGxds9ngLJN7KFhqGNqn1CIV
 5Bv+RSG2y1I9jg89gRVfx35/US/kpfCibc3R4d/VI54awyNdC2S8EadKGU5I08Mlzokw
 i0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=x3HzKkx6lPNCdrtmHwZ5BJWLYIYYeagcYSVMA3RXMcA=;
 b=ak0VTnqURY0K7CEvg+zm3wBCS7XhxbgIUH+yl3ncwt73j4F+quKtVSYQOXZxiCsDiQ
 5RigAZY54PB2ULk57vizp1eOrKRpsxeKgx3IUqSZtolpBI1+bK5Yw8Z8d2XB2SeaGJt6
 C08jY3r7c28lFcMODr+D4val9jdGSZrqb8AB9t0+mm3ht41Rqni6ns6dSqZ02O17n5JM
 OSGU70mlLr6RITHL5fvre8wKayXkhFKWr7aF5cOqgIt979714Ixs41eigR4XdTqLM3vC
 /saC55rHDtdSq2MN0xmqQUvFnqNxUnJHwWVqKIM88pXEt4ETKEv/wvmQMtXc/ZGll/Js
 CDPw==
X-Gm-Message-State: AOAM531U751eV/cw3Ee10BLYQWSRZuGNoaVo2yTmJnQXWqCRAE/ZooDd
 BrVNsAV4M+PNegp1efnzgrMe1g==
X-Google-Smtp-Source: ABdhPJxRL403S4Td7Xw9LbU8vwo3LFw/0B6PcF1Mzgmd2YcmGokntnad7Yjev9F63UBATsHe/BpJRA==
X-Received: by 2002:ac8:64d:: with SMTP id e13mr2914214qth.23.1603468859525;
 Fri, 23 Oct 2020 09:00:59 -0700 (PDT)
Received: from localhost.localdomain
 (stsvon1503w-lp130-06-174-91-97-36.dsl.bell.ca. [174.91.97.36])
 by smtp.googlemail.com with ESMTPSA id k16sm1144957qtu.45.2020.10.23.09.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 09:00:58 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v7 0/2] Add watchdog support for SbsaQemu
Date: Fri, 23 Oct 2020 12:00:55 -0400
Message-Id: <20201023160057.21543-1-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x82f.google.com
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
watchdog timer specifications from ARM SBSA v6.0 and then used 
in the SbsaQemu reference platform

Changes in v7:
- review comments addressed

Shashi Mallela (2):
  hw/watchdog: Implement SBSA watchdog device
  hw/arm/sbsa-ref: add SBSA watchdog device

 hw/arm/Kconfig                  |   1 +
 hw/arm/sbsa-ref.c               |  23 +++
 hw/watchdog/Kconfig             |   3 +
 hw/watchdog/meson.build         |   1 +
 hw/watchdog/sbsa_gwdt.c         | 304 ++++++++++++++++++++++++++++++++
 include/hw/watchdog/sbsa_gwdt.h |  79 +++++++++
 6 files changed, 411 insertions(+)
 create mode 100644 hw/watchdog/sbsa_gwdt.c
 create mode 100644 include/hw/watchdog/sbsa_gwdt.h

-- 
2.18.4


