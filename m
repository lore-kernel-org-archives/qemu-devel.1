Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AA92073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAsjVI3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AA92073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR1v-0006dH-8Y
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzd-0002U4-Nc; Wed, 17 Jun 2020 01:52:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzc-0004QW-7N; Wed, 17 Jun 2020 01:52:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id f185so623305wmf.3;
 Tue, 16 Jun 2020 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oKgx3XGZybeg/pFq9unPz0BUDJBMmdl8/2xtj0tVVxk=;
 b=bAsjVI3m0QiScklMYpycNK5w8FrcBA4X6t7AwQhEH6ShBtZexMCc3ZNpGpPqmpqhAb
 uHmsgcLYsRNXphhVwDsKGqjeSFqDGulJSarquc7fK7OzGJjNXYZlskOe2xwb2cPhracB
 idQEVa6a2oNAdWCkTDe4+kZjJ/iD8nFWJWS9MsttfU8mgEqe0xIDNVUIk78XHc7dUJ5w
 mzWf87NdTyKlmwcYkndumXbzwoG55ijYMKs3Qc7A/wGvJSOdAEajaULPaeVKzSXBhofg
 IN6uJyHFBX2OncgeWA2qIke9a+MPfjI25S4olQPIzHJABQ6dT2Z4p+D17Qy582xJUsrW
 uqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oKgx3XGZybeg/pFq9unPz0BUDJBMmdl8/2xtj0tVVxk=;
 b=CABvyXYTz9EGyKtso8DjQ6DPRYliKXoAbDvUyq8Os33lwtITkNRXNCj3oVuBXm7Uu6
 iPHJMFnuWlUHpc6gRGjU7slT5O6C3Cc6EQ87qgWL+WO/GBH2uUYRA1D+TtAYZMJzpAWq
 amBCxJhU/ZXCngbx6ZunfFcca4MY6i1dtr8cBMO3ZXXrtagEnn7GJlzmanyNy3maIi2X
 CqPDuhAfGAmfLpGDw+FPj12qkRpFLBwC3Dd6Xnh2Z8S6CL4vVqLqtjB6I7sq1gHhwjZF
 7Yrftim9h7JVjy7os+cjNLlJNLYtyXjkdZWxLsHRkgStdryNA/3+5gI7ldmCczcq0Zwc
 9BYQ==
X-Gm-Message-State: AOAM530zU3AIm3PB08LNjxylas9R2uoAdxEROnS1Gk65geKL80rStPIz
 MnU5QAyX8xe090NI7xn5xZqSgJwC
X-Google-Smtp-Source: ABdhPJwtYMBJaNSr9tYfqR+q04mUol3NEHI2XoitONH/PTcKbIGueWinmaz764ZQKZQrRCZLEmA4sA==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr6965418wme.41.1592373130230; 
 Tue, 16 Jun 2020 22:52:10 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/14] hw/i2c/versatile_i2c: Add definitions for register
 addresses
Date: Wed, 17 Jun 2020 07:51:53 +0200
Message-Id: <20200617055205.3576-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit definitions instead of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/versatile_i2c.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 1ac2a6f59a..040139d701 100644
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
2.21.3


