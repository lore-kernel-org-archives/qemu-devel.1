Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB972C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858C020727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4Vw1Mu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858C020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbbS-0008Oo-FX
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaA-00078t-7W
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZba9-0005kz-0o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZba8-0005kO-Qs
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:44 -0500
Received: by mail-wm1-x342.google.com with SMTP id g206so3393114wme.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Er5f9rC8C8GOvtgbGPLP84tJvHsrIKrKDE2TS/iWzsk=;
 b=l4Vw1Mu7s5FmEufBZTSgO2m0KdYjVROitAgPcLcUO19ujTQtQqRc5NGrl/Yl7KNKZd
 T9LKB+cU5A9g1+af80BZtPTPz+/x3r+LYt7CoGNWolzQMS/KrZiZ2cBXCK2AUNuQjr7m
 iCkH5P/IGVD7TPd5DqbPaRM9ZJ/T5wP3ukXMj+AJ2SlqU0TiRzxJbH7XmWFF/EhfAmsB
 ee57Fd5YAH9pe1xGqscJ6yOs//cMNUFr92+XCr16ecct99xyd2LbMdx3eY4pMPaqFIq8
 dWWnfZwXw5xAPVvtdDnVsZbi432pz0dmZN797UIt0CV/wa4VgMk48CnfC4gvcJG4VPzA
 1WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Er5f9rC8C8GOvtgbGPLP84tJvHsrIKrKDE2TS/iWzsk=;
 b=BsEQlxWPGSaVtN4giRmFy+PJ/N0jth4nDHWIcWAAtwyoGKwv2x8UGET7NyG0xyQLu2
 FaX+ARx3bRmRdDx9Oa/yCUxpDrAHnP+B9VUHpUchw1f5LrgGGKB5shg6nngRlB/F9P9H
 UA5Y1peiCr3jsOeHLVgKstsA0wAQi5OlXky+1+Q3igLMtuf+vLBueQB3ta8eAjVG1cAM
 TH3gSsGni2gWxynaLlyymirSsNUxKdi0xYVRUmY5VSkSR+yRrYZp7p/xLlqoIZzKuSP+
 oje98y/Ueiv8Y/wupX6b47CHheRQXe8FKJMXOO3F1x2rbWu2CKHL0dXlHymXP6oB66ju
 amHA==
X-Gm-Message-State: APjAAAVysibkUcAYLnjoU+lKAyY61nwKu2tj6FKTqpDcTt3VXPN0W2W9
 /Of/A0xpI4+KmYwRD+icaBGCsyRHEj4=
X-Google-Smtp-Source: APXvYqz5wSSeUsoOdGmQmfpLpuwrHBEIqwb38Hwd8nSaM80vIY3fnX1qDixh6aRknK0+zRTt9T3Z6w==
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr4268611wme.22.1574777563506; 
 Tue, 26 Nov 2019 06:12:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i127sm3364581wma.35.2019.11.26.06.12.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 06:12:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] target/arm: Fix handling of cortex-m FTYPE flag in EXCRET
Date: Tue, 26 Nov 2019 14:12:36 +0000
Message-Id: <20191126141239.8219-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126141239.8219-1-peter.maydell@linaro.org>
References: <20191126141239.8219-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Jean-Hugues Deschênes <Jean-Hugues.Deschenes@ossiaco.com>

According to the PushStack() pseudocode in the armv7m RM,
bit 4 of the LR should be set to NOT(CONTROL.PFCA) when
an FPU is present. Current implementation is doing it for
armv8, but not for armv7. This patch makes the existing
logic applicable to both code paths.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@ossiaco.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/m_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 4a48b792520..76de317e6af 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2233,19 +2233,18 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         if (env->v7m.secure) {
             lr |= R_V7M_EXCRET_S_MASK;
         }
-        if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
-            lr |= R_V7M_EXCRET_FTYPE_MASK;
-        }
     } else {
         lr = R_V7M_EXCRET_RES1_MASK |
             R_V7M_EXCRET_S_MASK |
             R_V7M_EXCRET_DCRS_MASK |
-            R_V7M_EXCRET_FTYPE_MASK |
             R_V7M_EXCRET_ES_MASK;
         if (env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK) {
             lr |= R_V7M_EXCRET_SPSEL_MASK;
         }
     }
+    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
+        lr |= R_V7M_EXCRET_FTYPE_MASK;
+    }
     if (!arm_v7m_is_handler_mode(env)) {
         lr |= R_V7M_EXCRET_MODE_MASK;
     }
-- 
2.20.1


