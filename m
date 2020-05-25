Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C25520723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoDYlOF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C25520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBHI-0007Ai-IW
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD9-0000pL-6O; Mon, 25 May 2020 07:24:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD7-0000ph-O9; Mon, 25 May 2020 07:24:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so6237285wml.1;
 Mon, 25 May 2020 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtkGUe/9x5K/0wcu8anW+e68UuC/UG56c3D7rIQ17bs=;
 b=WoDYlOF4Vut3kAg2QPZ3t6Q16/GDLrxNzAIT4yon1DZbMM5sorZCVYCf1Mbtip/6YC
 88eTGYWNmikdhTA8tOna45+Y65LAuwxmWNLwhV2v2jXcMFYKaRhi5+EayyHMW1IegpeD
 TblYogHW548L0B7OR+EOcamCj4l4hpHvmQHs1f5W3ambEk9P83+qMYGA6DL8ybWkEyE2
 MnOJoe/tgumgs3fADGPZUXHTRJtZrGua52W6XWb2CUhTcYCYQzB+FMDIfqyXfSRz5hFR
 OeLbzucRyYZ74oTlRsA1MUoSwabT6x4gMNApqJ1BAg2jZQdWfRYIVSUWXsbWSM71myuB
 rZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AtkGUe/9x5K/0wcu8anW+e68UuC/UG56c3D7rIQ17bs=;
 b=CE/G5H/oSpdRrlu1QbrNlB1P9CLhroNqyMGgo5eXeaDsF2I2BYXJXU1mURbzh9JERr
 nrmgv6BqAbZu38Cs0ey0f5ReEC4fTaqUYqdrSPhOBaOV0xdQtpSXRa22PCm2UOe8zn8h
 f1pRtvlS9J1Ueg6mO5vkz8BUSCT8DcI6bsI+k2IYcov3hLO+yG55nSRPzPrbeixFVTLP
 lsHe7Pdzj2+cSM+BMLXKEbA/sE+BGOeMlZK4PbqRcdhBx+c0mXAWV288wLk5TrP3JTkk
 wqb4LoPEWocPJqDqUsyfi+w5lhJSA2HnKGqTX12SSDBLwQCXM61V50XLtjpok//5CUDn
 cEbQ==
X-Gm-Message-State: AOAM5313hvTavSDl4BHkt7F2I+IY2Q2xNmoiruF3gtF03pJ//HT3169x
 6AlQ6JZ9M1mx+eFUnCLKZKQJcX075xU=
X-Google-Smtp-Source: ABdhPJyTx/mIOlVA3Hql6G26B83/GdHKQlncap6NgdbfZcDkgz1IUGy+3p4Z9oSL+qsZFY9cP8UNdA==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr890147wme.14.1590405839854;
 Mon, 25 May 2020 04:23:59 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h196sm10715635wme.22.2020.05.25.04.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:23:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/display/vmware_vga: Replace printf() calls by
 qemu_log_mask(ERROR)
Date: Mon, 25 May 2020 13:23:53 +0200
Message-Id: <20200525112354.10445-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525112354.10445-1-f4bug@amsat.org>
References: <20200525112354.10445-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid flooding stdio by converting printf() calls to
qemu_log_mask(GUEST_ERROR), which are disabled by default.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/vmware_vga.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 58ea82e3e5..5c0fc49d9d 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "hw/loader.h"
 #include "trace.h"
 #include "ui/vnc.h"
@@ -953,7 +954,8 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
             ret = s->scratch[s->index - SVGA_SCRATCH_BASE];
             break;
         }
-        printf("%s: Bad register %02x\n", __func__, s->index);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad register %02x\n", __func__, s->index);
         ret = 0;
         break;
     }
@@ -1002,7 +1004,8 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
             s->new_width = value;
             s->invalidated = 1;
         } else {
-            printf("%s: Bad width: %i\n", __func__, value);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bad width: %i\n", __func__, value);
         }
         break;
 
@@ -1011,13 +1014,15 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
             s->new_height = value;
             s->invalidated = 1;
         } else {
-            printf("%s: Bad height: %i\n", __func__, value);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bad height: %i\n", __func__, value);
         }
         break;
 
     case SVGA_REG_BITS_PER_PIXEL:
         if (value != 32) {
-            printf("%s: Bad bits per pixel: %i bits\n", __func__, value);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bad bits per pixel: %i bits\n", __func__, value);
             s->config = 0;
             s->invalidated = 1;
         }
@@ -1082,7 +1087,8 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
             s->scratch[s->index - SVGA_SCRATCH_BASE] = value;
             break;
         }
-        printf("%s: Bad register %02x\n", __func__, s->index);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad register %02x\n", __func__, s->index);
     }
 }
 
-- 
2.21.3


