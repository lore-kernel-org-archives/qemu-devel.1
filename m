Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D65C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D2F2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BltFr66A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D2F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacSk-0005SS-5K
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRN-00031p-Eq; Mon, 18 May 2020 05:52:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRM-000178-QH; Mon, 18 May 2020 05:52:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id z72so9602943wmc.2;
 Mon, 18 May 2020 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=evhhH7dZopCrkDO4cvbqtNz/8xpqFu/oQnLDI6akZY4=;
 b=BltFr66ADNQznZZyq4/l1R0U72yNemjpeqXd0ESKvgCpvpc80ABMBsnRzCsK8JKBgh
 /zumwl9cowaht4/Mx3sHkWLlHvauWfR/A4hQfIrqBoLy2Nx+cqEogwoKpF5XkAogMV43
 r39WEkJXcO2z0lST1TY/yOum54HQlkFWV8Q/+T08mlc9LpAGRg/3kPActfPprwakVq7L
 JnfjIS8I3VDISU0xmT7vwhw/vgfjaWKwA1//GzuaVVB7UtFWabivDyc/ktt67du4gQlX
 gpjvdklz4IjTWvOFBX6B9dwKQjAww5XBXRxcF1k9VDZoasqFqmOvduzaQaZbbHQkgIe4
 OgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=evhhH7dZopCrkDO4cvbqtNz/8xpqFu/oQnLDI6akZY4=;
 b=HmFzhhphJWbN7Gi9VTOU/59Vrw7dW8oApX98vV/9066vOFCvT+dxzzjdghkLVhci7z
 ylep1Roc8l3NJzYciz9PuGjZbZYUpoxHrcG4AU6xHk2VhfZs9tJ1xjCHr41e/DkJcHmD
 SdZIZurqwObtDOdM/S1lbBmywMXvYkM5/XyKW4U8SDJ7w8vUZznhEqb7U7ARZekoecHb
 y7Pr8yeYBg9Of7I0pc9fKS2fatVbmHIzNtx0JMWyitmweLgZnImDCcNud7ntsx9N9Sy4
 RIOOF/YkilhOniINxZ4qXAh0aq0Y6ldqWw49sKs+ha+7lro4AZiDscBOCnTYdlbJIOwU
 G9gg==
X-Gm-Message-State: AOAM530nbFHVJhCVVvFgrwTgGeItpXZC2S8XEFC8SHci+zVBOJ3IRjVx
 3KmQs/4Sn8T/dHy4TwJhj3Wl9qTqdL8=
X-Google-Smtp-Source: ABdhPJwgC94yI4QFQsBvrvxU+YHPAMnxNWCzzGs32hDuo9rrI7LPahztEZfd6ykHQmlxLtMeCF3R6g==
X-Received: by 2002:a05:600c:280b:: with SMTP id
 m11mr17712702wmb.115.1589795526794; 
 Mon, 18 May 2020 02:52:06 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm5453542wra.52.2020.05.18.02.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 02:52:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/arm/integratorcp: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 11:52:00 +0200
Message-Id: <20200518095203.1013-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518095203.1013-1-f4bug@amsat.org>
References: <20200518095203.1013-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/integratorcp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 6d69010d06..5fb54e5aa7 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -20,6 +20,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
 #include "hw/hw.h"
@@ -144,8 +145,9 @@ static uint64_t integratorcm_read(void *opaque, hwaddr offset,
         /* ??? Voltage control unimplemented.  */
         return 0;
     default:
-        hw_error("integratorcm_read: Unimplemented offset 0x%x\n",
-                 (int)offset);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Unimplemented offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -252,8 +254,9 @@ static void integratorcm_write(void *opaque, hwaddr offset,
         /* ??? Voltage control unimplemented.  */
         break;
     default:
-        hw_error("integratorcm_write: Unimplemented offset 0x%x\n",
-                 (int)offset);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Unimplemented offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         break;
     }
 }
@@ -394,7 +397,8 @@ static uint64_t icp_pic_read(void *opaque, hwaddr offset,
     case 5: /* INT_SOFTCLR */
     case 11: /* FRQ_ENABLECLR */
     default:
-        printf ("icp_pic_read: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -430,7 +434,8 @@ static void icp_pic_write(void *opaque, hwaddr offset,
     case 8: /* FRQ_STATUS */
     case 9: /* FRQ_RAWSTAT */
     default:
-        printf ("icp_pic_write: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         return;
     }
     icp_pic_update(s);
@@ -504,7 +509,8 @@ static uint64_t icp_control_read(void *opaque, hwaddr offset,
     case 3: /* CP_DECODE */
         return 0x11;
     default:
-        hw_error("icp_control_read: Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -524,7 +530,8 @@ static void icp_control_write(void *opaque, hwaddr offset,
         /* Nothing interesting implemented yet.  */
         break;
     default:
-        hw_error("icp_control_write: Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 }
 
-- 
2.21.3


