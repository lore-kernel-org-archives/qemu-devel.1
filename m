Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A306422B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxPOCAjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A306422B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBG9w-0003qL-Sz
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBG9S-0003QP-5o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:33:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBG9Q-0004r4-8W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:33:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id d10so4111303wrw.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZMtI/tGFEHR1d/kfeU7MuVTM6tT3+kuWZIcP5eHXGU=;
 b=PxPOCAjm8kPrtnj/wh0RHmG7PEFWe1aZ7+MThEznkqgCx6/61aeGaANJhhd+Q1eU4H
 56acKE/WQ1h3TztG2Mij0BOGufPtmRKnQg8e8ABhYBIZ/mON3TyzAUOUvz2G5pAlUNzx
 gSY9Cjz5YEw+YrmpnXtvdnrP0vxzwrv6H9EEqXLhYqjkH6wqKAdBpVnEAXZFWSM7Ory2
 dwCEgU90oZApdu3C4pams4oNFGk+jRwXRN2TJoMEv48VuE+NYojBGv4iZLG5F4hhEeih
 wyMO4og7fR6W2ax/yJwBO4vU2GWCTR8tJet4bsmdmjkheuRuxpn169xeDeEslbh910mH
 vQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZMtI/tGFEHR1d/kfeU7MuVTM6tT3+kuWZIcP5eHXGU=;
 b=XT0/gSUFmDK5UY84hXEjDnBFV7CJzJ290v/ulLjZpB902fcxO5Ju29OowkJUNY1XIo
 FN/+oRlYFVYUKFlAK03OVPpklZKGT5+Nc7EGVviNKbMopNAYLvyBijU6Pur8fXx2CPlk
 FG1lac7FlvDY0baF7il3du94eX3OMRXIKd8EkXYBkKEsvxiv9ORQmquldvOgHBQ3ZCsK
 uW4fHWS195tyI9MQuty2RC0GlDjFdSMq+nq19gbtEmIc9hJaA7uJ+PuV1LddxEYcNp1I
 yGBnx8wj3Bp8qWQ4eM3+ihMSogRMdh2Pi1f4Tc+3EtJq4sE0ulyn2R1k8FqV0subQWA+
 lYFw==
X-Gm-Message-State: AOAM533X3zwG21xOmaRCKqMhnJWRoXfg92NRiXXKyy4hf+2A+iICX5dN
 t6PaosAhCisHNJsH6+HRt9BMiPSH6t2qPSuN
X-Google-Smtp-Source: ABdhPJzf0mPJAFRommlIvRiDdALUrFSAYanq/MpuXzjE5+ZQJess4L5a/KFEh3RFXJoN5T1QMaf5Tg==
X-Received: by 2002:adf:c64d:: with SMTP id u13mr20679978wrg.114.1598527982089; 
 Thu, 27 Aug 2020 04:33:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm4736007wmf.3.2020.08.27.04.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 04:33:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Deprecate lm32 port
Date: Thu, 27 Aug 2020 12:32:59 +0100
Message-Id: <20200827113259.25064-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our lm32 target support. Michael Walle (former lm32 maintainer)
suggested that we do this in 2019:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
because the only public user of the architecture is the many-years-dead
milkymist project. (The Linux port to lm32 was never merged upstream.)

In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
the MAINTAINERS file, but didn't officially deprecate it. Mark it
deprecated now, with the intention of removing it from QEMU in
mid-2021 before the 6.1 release.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: 20200825172719.19422-1-peter.maydell@linaro.org
("Deprecate Unicore32 port") to avoid the obvious textual-conflict.

 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 4c52098c707..5c7fc8a3c99 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -416,6 +416,14 @@ The above, converted to the current supported format::
 linux-user mode CPUs
 --------------------
 
+``lm32`` CPUs (since 5.2.0)
+'''''''''''''''''''''''''''
+
+The ``lm32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. The only public user of this architecture
+was the milkymist project, which has been dead for years; there was
+never an upstream Linux port.
+
 ``unicore32`` CPUs (since 5.2.0)
 ''''''''''''''''''''''''''''''''
 
-- 
2.20.1


