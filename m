Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E656CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DA6206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fel9EeF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DA6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2lB-0006OL-UU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2iB-0002C0-Nk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2i7-00084g-Ct
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id r12so17506483wrj.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fdwwwNahFXVwjejUuWZRnNtqLGJwsuxtV0zLzrE0XA4=;
 b=fel9EeF3QFTd1eW9Ypyysv6jyrqbsmHqt4673HKN14YXbp51+UBNzD9RiKspQtVGNJ
 OKBxDJkObaMb+SYJ2n7PK/Xe84cjR9uLGcZuYyZj8woek7LxbvfH0sMf6ni0ha44iOcf
 f1rBCuLXGN23vklZASQ3B0Gocyz2wHO5yo6/NAM+tfcfpGuaZnNI50PtVX19muRjmkix
 MDUe2cLHAJ14rn10GSyC0ly2gG8z1IGMTna0WXloZKJfrSWA4vmqqvGYhIGOtnTZLG2P
 1o0T+0rMCn9UDV5Q9HjRFMsICqG9bl5EgChCEDB4TvmNk6KdMLHz67viI+F6tQezSelR
 0F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fdwwwNahFXVwjejUuWZRnNtqLGJwsuxtV0zLzrE0XA4=;
 b=FWTC2c21QvxzwX6yt0esDVQUz3tiebhG0iYG8UfXUGvsyhwITXT4T7j7lv4iC3sXtH
 5p3uiO1az2fmPU5oW+JCs2lnlhU1/2oO/YA+ddRr2HhvWdABMeE9FOrHVeDJre+eJWoM
 KkNXyi4dKAq62niOTPe1LsK5GsMm5+nZh4bxRPoR3TpEUkmGqMWWwSPp0s4lWDEApEl7
 K0RtFGlNfKosVY6DlprJlzdfZYyRDSVrx5SQ0z7GduE5MPSo0oJLLF7yb7e1jpvhF5Wm
 82hZG8qGlc5Jj0Kh0aUwjYDvJKHtnyxlND3IzLj3VTbTJuXo9Mrn+bEWML1OEb2Ti5dc
 OXfQ==
X-Gm-Message-State: AOAM530KC5LQ5UPWM+/919+Z/aAh2U7fFwKwvKnVEAhZo6YxIyishsDp
 pREzMtRzamTBhYUca6JrDpdMBxKrtPgc9Q==
X-Google-Smtp-Source: ABdhPJzpjFrEiiBG/Tzd2aL1PMa9RmObQZdKRLDWWXIw8UUL0Tf17t/um35QOJs3U8nJrYxioa96fw==
X-Received: by 2002:adf:9283:: with SMTP id 3mr569259wrn.231.1594663069770;
 Mon, 13 Jul 2020 10:57:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j4sm25723721wrp.51.2020.07.13.10.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:57:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/4] docs/system: Briefly document canon-a1100 board
Date: Mon, 13 Jul 2020 18:57:43 +0100
Message-Id: <20200713175746.5936-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713175746.5936-1-peter.maydell@linaro.org>
References: <20200713175746.5936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

Add skeletal documentation of the canon-a1100 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/digic.rst  | 11 +++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 docs/system/arm/digic.rst

diff --git a/docs/system/arm/digic.rst b/docs/system/arm/digic.rst
new file mode 100644
index 00000000000..2b3520ff5e1
--- /dev/null
+++ b/docs/system/arm/digic.rst
@@ -0,0 +1,11 @@
+Canon A1100 (``canon-a1100``)
+=============================
+
+This machine is a model of the Canon PowerShot A1100 camera, which
+uses the DIGIC SoC. This model is based on reverse engineering efforts
+by the contributors to the `CHDK <http://chdk.wikia.com/>`_ and
+`Magic Lantern <http://www.magiclantern.fm/>`_ projects.
+
+The emulation is incomplete. In particular it can't be used
+to run the original camera firmware, but it can successfully run
+an experimental version of the `barebox bootloader <http://www.barebox.org/>`_.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1bd477a2936..8fa51a22817 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ undocumented; you can get a complete list by running
    arm/versatile
    arm/vexpress
    arm/aspeed
+   arm/digic
    arm/musicpal
    arm/nseries
    arm/orangepi
diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f3675..0f578040b99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -634,6 +634,7 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
 F: tests/acceptance/machine_arm_canona1100.py
+F: docs/system/arm/digic.rst
 
 Goldfish RTC
 M: Anup Patel <anup.patel@wdc.com>
-- 
2.20.1


