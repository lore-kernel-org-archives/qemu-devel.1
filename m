Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9064DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC95206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5aYj2li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC95206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhck-00089D-EG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHB-0003K3-Sp
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHA-0003LV-25
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id q5so7773626wru.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uHtXjv+DNeh42TRXwhtc/t5t5RE6Yero04gixho+blI=;
 b=D5aYj2liYVTMkUUGmFHa9RHDRqjeW/gJUoGiI2dXQaZaM6KR78m3HPnnBk0ZJo01HE
 vyu5yF/LV8pcbkSh8qfuf0dKaA6XHN1tfwTo5jJjUc5Sv2lxwNEcO0CBTcyeP/z/8q05
 8NVVu2pbZoV7pPJLCUzfc9VxXC7bCpnHmxvqG027MJQHBdIfrAiXo64J0KeVT6ImOBGv
 1v31YYnhd1YhSIWrjPUC6P7LlVcsOCdk3IKL/OMCt2BJ6PCO2huSgDH4fGr8zYSCQrQa
 pTdkCq4zMib+5X5rVozBfnisXPiUj2rLt/ReR70dMi/AG/THeEU7ZQZP5QkNluoIi3Kx
 +KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uHtXjv+DNeh42TRXwhtc/t5t5RE6Yero04gixho+blI=;
 b=uRXfvKURXex9Cx5sfcwy1ncixqvE+A4a8DY4VEh+cSzkotvREbDvMs8ai9sdAABFjk
 zTbiRtimn3lQ+WFh5cWE4+6TEBTgRo0P2X5rueKDdmmXV8OkXM/XhTJZnYoV4n240A6c
 +pqnb0vIEx6s9URecMbg74j/ugEbDxTAdQAAZR36/FMqH5qAWq1/U+sDnc24xasqYrzF
 qrXs1QFKIDZ8fSkFQp3NSpKaXiyhHpgFvMNWbqNbVaUOqEHArnjUIGSR/h2dxi2ciA0M
 8zrAl6b7QKPH1dhZg0fxHL5HnkAFFQLgc0NqixTuXmlL6AcDZDa3KWchua/uwm+r1jVd
 r+wA==
X-Gm-Message-State: AOAM530HLQwxQYtCR10frm3XShtg6/MLM6FC2aBDTIl/S8b8XXuPXK/P
 VjbZwBF3HUxKmt0Txa5SMNU0JKmo/icTzg==
X-Google-Smtp-Source: ABdhPJyl69uk8JV4Qfl7i+Hbu47NJpl4kgU5QmkZ05DsW5r9+K5Atp6HRdY7zHyBuDjojZ/g5+xMfw==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr13050892wrq.263.1592912378495; 
 Tue, 23 Jun 2020 04:39:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/42] hw/i2c/versatile_i2c: Add definitions for register
 addresses
Date: Tue, 23 Jun 2020 12:38:49 +0100
Message-Id: <20200623113904.28805-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/versatile_i2c.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 1ac2a6f59a0..040139d701b 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/bitbang_i2c.h"
+#include "hw/registerfields.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
@@ -40,14 +41,19 @@ typedef struct VersatileI2CState {
     int in;
 } VersatileI2CState;
 
+REG32(CONTROL_GET, 0)
+REG32(CONTROL_SET, 0)
+REG32(CONTROL_CLR, 4)
+
 static uint64_t versatile_i2c_read(void *opaque, hwaddr offset,
                                    unsigned size)
 {
     VersatileI2CState *s = (VersatileI2CState *)opaque;
 
-    if (offset == 0) {
+    switch (offset) {
+    case A_CONTROL_SET:
         return (s->out & 1) | (s->in << 1);
-    } else {
+    default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%x\n", __func__, (int)offset);
         return -1;
@@ -60,10 +66,10 @@ static void versatile_i2c_write(void *opaque, hwaddr offset,
     VersatileI2CState *s = (VersatileI2CState *)opaque;
 
     switch (offset) {
-    case 0:
+    case A_CONTROL_SET:
         s->out |= value & 3;
         break;
-    case 4:
+    case A_CONTROL_CLR:
         s->out &= ~value;
         break;
     default:
-- 
2.20.1


