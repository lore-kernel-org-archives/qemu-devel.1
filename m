Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7E22073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+s3qGCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7E22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTA6-00050S-TL
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzY-00070k-H2; Tue, 26 May 2020 02:23:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzX-0002Uj-ME; Tue, 26 May 2020 02:23:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so14931015wru.12;
 Mon, 25 May 2020 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtkGUe/9x5K/0wcu8anW+e68UuC/UG56c3D7rIQ17bs=;
 b=N+s3qGCKD6FJmaHREPt7Wc3sme0IhvdZYn6vjZw8o5ZiJMMbo6fd8+fiiAVTjEgVst
 UdakEIe7B6Y13/msLFz6pNHh3xALeSO8gjPnGpG4n2bBRV9oWR1xUKdbL+O3on+/wsRq
 dbCwiNwN1vCznET5GmHpl6BV6XAUuoGBEMDlal9cSmCVP/LXu4VW+F0jxV6N4IjbO4Rw
 llkq4mZy8qOSGr6LJR1fwhqG6fw4YB98ujmcoWwsO/DAVDfoE+H1uKWFg6D/jvA5fROH
 6FZScIj1aPWbYIkur97SgvRmYjl2qzCKk269FvYgRO1jAiErcgx5sDdhpW3/xnwy6Hz2
 izBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AtkGUe/9x5K/0wcu8anW+e68UuC/UG56c3D7rIQ17bs=;
 b=GlthqNqii0gXriwAHyYjQuz/VvkjPZp1vF1+wFs9gft3Ko+u7BPRicy0PSVf2BboVk
 DPhTUyHEJLWoY2BYaA7s9no1WLOBfGUpmxp7rHeSt15Kw7Lp5fu0HKMDejYE6i+8l6c/
 AC496MFR/SCa7vuEi7HZM+D6f7CoyVcMJhnW+Gq/MaHKUrvkja2As+syqPXOzO45KUYZ
 V0/ct4E6jWVDeNmqoYpZbW0H3qukokRre575hnr5o5yGJY1qBmT2VEc2BYmdl3vL9vDs
 ky3BSmHG2VcONyNiky7yvmTaHv7TOLNaVwrow3gUsOUl+HX/vGkpRaLb1RbN3ZH64Hb1
 waSQ==
X-Gm-Message-State: AOAM533TWjHJqsW4dsxmO3jH6FNWaBX/SBhWNtgQTARWWGN03LAtZhZ+
 gV6LIK2ygX91+zOTaaTZL7c=
X-Google-Smtp-Source: ABdhPJw4moBLGdha5DbkL2H4cIZFDiDAqMz6pslOU9o8FAZ9pD+PkXaL5KlyF0CuwbbI0ca7oSl6zQ==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr18168651wrq.218.1590474189691; 
 Mon, 25 May 2020 23:23:09 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 10/14] hw/display/vmware_vga: Replace printf() calls by
 qemu_log_mask(ERROR)
Date: Tue, 26 May 2020 08:22:48 +0200
Message-Id: <20200526062252.19852-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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


