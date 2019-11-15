Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838EC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482892073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBvrS5tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482892073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfUQ-00023A-EL
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQD-0007Hy-KO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQC-0002v0-Cw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQC-0002u0-4j
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id z19so11300838wmk.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FvqkNjD95DMP7rRbR4+6wxS5O0FAiAqBbCxy5IHZW2U=;
 b=UBvrS5trbwfttiOHG7vjnXoSs2bp/NypEi8eDE5ZtlnEBlX1kce5ScEyciNbaJZTcS
 5aMHUjPHPRG4Dw6d6TwNIVhVAoUEt5tFzR0kzc8y+wHv24GEfteVEtC+ZVIjbKBkHhaH
 S9WJR1s6nQl+l9ubUKLitI1ETv9BiO9KWkCsIMrZsDqYhWAq0pubj5wAelMycsMUyUlI
 JiX4ejyt6WHd0Db62wkfDWqa0XIxc+3vQd4AOLd/L/ONhhsOsQLJfliYF1Ko7qW0MNg/
 SUZ7UpXWpxyMygEEpQP2763OFMDRD3QHSJtEaAdAGo3Wkixll4IstriHFIbPTnlHSkPR
 DCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FvqkNjD95DMP7rRbR4+6wxS5O0FAiAqBbCxy5IHZW2U=;
 b=DGO93A9xGw8Z+2c+uTWmEBN0YqkAQ2TO0YbWIKK0Tq1VNunHBL5oRd2U3/p0fH7mYX
 tIRma+F1uVdMEaXWYj/dXRy1BZe5I+y4F/iJyMFOGab3pWaGPyfnGg9JDY44n3XUzP48
 P7ObOpXx8fHvcotKVRr2nn6tQl3drxc4ZeyAaeOsU4LH5pwBm8IbtdPntLhqO0yFknXo
 lyMtv4ere5BonHC1sTqaLt5n3DKp2ZDDYrJVsvedsVT6jSXU1HTqGzgN/Qv+xmZUjblw
 hiDAH8T6tfNJZ+S63tedWK1j9TWscLFf6saj2pt03FwhxrM6eOhuhG5WN24EJorSPrrU
 aA7A==
X-Gm-Message-State: APjAAAXTieNauXbdIcFXrKkttrYTu6fRN/ld865KcNvMuKcUuGF6YTRJ
 2IlnPu5FEThurk4QhE5HQOPDZA==
X-Google-Smtp-Source: APXvYqyeqpJtXVifIqfBpfMaylLUOQyCuQ7MSow3FBeiZpRiLRApv9/JMexMBWDLyfPS736XWFZCWw==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr15322001wma.56.1573839010924; 
 Fri, 15 Nov 2019 09:30:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm12464309wrm.85.2019.11.15.09.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53E681FF93;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  06/11] target/arm: use gdb_get_reg helpers
Date: Fri, 15 Nov 2019 17:29:55 +0000
Message-Id: <20191115173000.21891-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index be67e2c66d6..bd821931b3d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
+    {
         /* 128 bit FP register */
-        {
-            uint64_t *q = aa64_vfp_qreg(env, reg);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
-        }
+        uint64_t *q = aa64_vfp_qreg(env, reg);
+        return gdb_get_reg128(buf, q[0], q[1]);
+    }
     case 32:
         /* FPSR */
-        stl_p(buf, vfp_get_fpsr(env));
-        return 4;
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
     case 33:
         /* FPCR */
-        stl_p(buf, vfp_get_fpcr(env));
-        return 4;
+        return gdb_get_reg32(buf,vfp_get_fpcr(env));
     default:
         return 0;
     }
-- 
2.20.1


