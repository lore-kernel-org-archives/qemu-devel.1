Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF062C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A15620786
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RycNVVxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A15620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSVV-0001rd-Pq
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSB-0004TB-Nc; Wed, 17 Jun 2020 03:25:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSA-0002Yo-4V; Wed, 17 Jun 2020 03:25:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so1122972wru.12;
 Wed, 17 Jun 2020 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oKgx3XGZybeg/pFq9unPz0BUDJBMmdl8/2xtj0tVVxk=;
 b=RycNVVxBa4IXNkU5fh6Qx4y3GvSNbDgS0QB+nEch9IcUB6RfgcsQCaZJ4PCzbfwAoe
 WSn51zVf64da0w1iyYLsJ7GGIRyz5pj7WrfU0LzVIDcjB9oIMdjsU8wdjC0Lr6iIVNU5
 e5h/xEoQBRfL7Spw2oEdEY9wjSNEk2Ht5A27nc5VM6Q+7XPqzwFfB/EFlKtuHYjahEXb
 uRvcVN5ui9cR67AsNcRpPEKVb3lZo4Xir7SQgSu5qHkal1z4T8Wqtf/2BxPaHY3ILEWU
 T5kRX9TYygaS3XEd2Jttti3nwt4GQwV+Mjxzp4p43UzYABvKZL/eE3L3xDlpuCQTNXl3
 Rt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oKgx3XGZybeg/pFq9unPz0BUDJBMmdl8/2xtj0tVVxk=;
 b=l5ywIf2J/lO94zuugJgA8fPxvzyIlKx950jyLoBTDaZm9ohh9KO8OSqrnxGoduK2j+
 HDM34xJznxRl816NLDUu5EainxjGDvfFTLGlqHxjseVM/t7p46yAN1Bn1o/R2JOko2G3
 XYKNCYK42oWtrjS1fVwdAvOLkrzhU/Xj19zE5CjxiHqYWy9NAUCy9oW5/og71/w/GS/B
 mC0q6+7hoTf5NCNmnQj9Vk6Ff6lIQtjksAnx06kCeMukr509NO07FIiNATQGDHID1rqG
 yf9HHYB+6KvBapSsvLrLOxt+d/iaihkERQdFRiumdqyN+oLC44PqjWh2OO6tyrcZlrGw
 qjeQ==
X-Gm-Message-State: AOAM532dec8+/piVrWViNro/31Tjpu4vy9cbCwKRfk3DJk5d0gemVdrP
 l974tafXRDiyhxjM+b19XMvaCXje
X-Google-Smtp-Source: ABdhPJz0/myoakqxeLXUPx0tBtXAy5csVAndFnX9z971EOVIhdhVNobnyzW96xsxO8YAZw7B6vaajg==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr6456674wrm.33.1592378744073;
 Wed, 17 Jun 2020 00:25:44 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/14] hw/i2c/versatile_i2c: Add definitions for register
 addresses
Date: Wed, 17 Jun 2020 09:25:27 +0200
Message-Id: <20200617072539.32686-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
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


