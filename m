Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF19C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C3122B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIrMUgcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C3122B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVTU-000648-15
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLT-0002aR-EQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLR-0007Jr-M7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z15so17720268wrl.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/CYzeU7y3oLD60p/I26mnIKvepekcuC7eHDRGOCqlio=;
 b=jIrMUgcNk/3xzZpc8wqn+AZC2FIbCRomhHHdr4yY2EtVWwVvyB672+aYe9apaaAYIr
 XS3fbPiErib3cN5Vq2+GEDsAXhxmW4vWOnsX3/Zc0HwaFxBZYgLZcxeXvrWoSfO5+9DC
 wSq5pUkY0KGaW1OzGzFqp/i9y3St2LXzfGuV8jv2ESjanxAT+Ecv0dlE4MPo0V9rYCAu
 oZIM++7v8SYtKKfKPXCOwdBlUqu4Zzvo5nbEGBo4PoY6b1h80gTI0fIICs3XFjIEVGXc
 /HqTPoIsgVA1zlICzLSSCZuKEBDtwa3n9Ldb49BKAPrL3aZDGixLmgOtxwjS/XVJLB+M
 g4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/CYzeU7y3oLD60p/I26mnIKvepekcuC7eHDRGOCqlio=;
 b=uHoyW+5J5g//f8V4SOzHzLtyQYfK8L0+Np/AYmU4j3359oDtojC4OXFVhaxjjsZeqr
 X2CD0BorSPS/0hb38fAuezCdKy/U86jGY7XmuqYvnj9NOFS7ib4u/nejq+qqOEnzSr9j
 8hPbwgi4owW7fHHhQHslexqCKsCCRF1UOK2YtvrnLpLDL899q392ygZitVJor/uqfun7
 yvA3MKYUNnGKNOZCzB5HwIXlLKLrQ0sX6orPq+tWZbzJhCXP4RnqtFyM0ulWwXdWqE+U
 oDWK6JIaJNyTRrsgh9FTd5TQMrMw0Q5XpzC5yz6RHub4yxJzzVAHilWV34+hPVyHBEqg
 K7Cw==
X-Gm-Message-State: AOAM533Sx3kelFIE7J+nBZ0I6PDNw9iOAg9ao6sBoIxzd8DATTxjbEk8
 BXdm6vFvJjRdkZpVcDsL1hyReFy0gVYWbA==
X-Google-Smtp-Source: ABdhPJy7lGoUnHHS2gXv+AkKpWXHvNySYYZv9RfLzYHfAn9DdJbo8JlgRQ5e89sowBCCse15BABidg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr22004601wrq.1.1595249795937; 
 Mon, 20 Jul 2020 05:56:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] docs/system: Briefly document collie board
Date: Mon, 20 Jul 2020 13:56:19 +0100
Message-Id: <20200720125621.13460-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Add skeletal documentation of the collie board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200713175746.5936-3-peter.maydell@linaro.org
---
 docs/system/arm/collie.rst | 16 ++++++++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 18 insertions(+)
 create mode 100644 docs/system/arm/collie.rst

diff --git a/docs/system/arm/collie.rst b/docs/system/arm/collie.rst
new file mode 100644
index 00000000000..5cc67b6d1b5
--- /dev/null
+++ b/docs/system/arm/collie.rst
@@ -0,0 +1,16 @@
+Sharp Zaurus SL-5500 (``collie``)
+=================================
+
+This machine is a model of the Sharp Zaurus SL-5500, which was
+a 1990s PDA based on the StrongARM SA1110.
+
+Implemented devices:
+
+ * NOR flash
+ * Interrupt controller
+ * Timer
+ * RTC
+ * GPIO
+ * Peripheral Pin Controller (PPC)
+ * UARTs
+ * Synchronous Serial Ports (SSP)
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 8fa51a22817..376c18f0b17 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -88,6 +88,7 @@ undocumented; you can get a complete list by running
    arm/orangepi
    arm/palm
    arm/xscale
+   arm/collie
    arm/sx1
    arm/stellaris
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed36dcf736..6973b68975b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -847,6 +847,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/collie.c
 F: hw/arm/strongarm*
+F: docs/system/arm/collie.rst
 
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


