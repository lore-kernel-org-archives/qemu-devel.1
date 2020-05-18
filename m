Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D89207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5I658dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D89207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagNM-0005hR-5j
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jagMQ-00047D-Af; Mon, 18 May 2020 10:03:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jagMP-00018w-FK; Mon, 18 May 2020 10:03:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id u188so10572623wmu.1;
 Mon, 18 May 2020 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=evhhH7dZopCrkDO4cvbqtNz/8xpqFu/oQnLDI6akZY4=;
 b=c5I658dFWf1VZZuazd4Kj7w50u2EWUkexys7LVKJz/4e9PWYc7o/3YHfSterxEtqKv
 mzmub8+2u9jz67AlDVD3oFFpzsMProfzUjy+GgjxyBAh4yE0Qz2IxrFHql09LbgQYop1
 buYYt/byehj13JRAODn4zh1JwAFICDAL898QHmR2qdxMUwTKnkgefmpb/FFviptln4d/
 eeEmCtVx7bmxafl9DkzMJyH9P02tOTd+dkvJuzXx3Y1sOvtNKdCUXTWKKsgnWoInSKSe
 qEucls1v8jV00GG3e4olhDFs1ODhFCtMaWIIIQBAjxNrAXz4YMtSv0bQXPJH4s8iYLOb
 pSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=evhhH7dZopCrkDO4cvbqtNz/8xpqFu/oQnLDI6akZY4=;
 b=C8DgrLZEsf7DyN8A1FBM7E4yB91+bTTT+di64y2fR6phw8A25Xl+RiNaIQHEDvyqeQ
 x2MsO0JUjW5jcl2FUakbECA0zuTsOJKSUkYWoaVfPQZJQYMAv118F8LRjEYqizjvFKu0
 C7SaW0AXOQFm9f9vPtwlAjjVKZYuzo9+jieS6Abm2/NT2pqFx9JDgtwTqIqiYj2O5Xeq
 hDdxQaWlFVU7XzlCoNKvOs+9eYorPhWpTI7uyjTHD75S1+kDVzu0ehjw0XWHuNtk464o
 PUcrm2rLiSd5JegLIsC0O0ylCUbCN4U+EPBphMfWYsF7YTZm0kyQgRDLP9L+hbkeyOcu
 hgbQ==
X-Gm-Message-State: AOAM530Eqq2d7NFOzYP5VU55IXGWYpnBQ7J414gQ83On5XxUGWtnm2YQ
 BLa6IbQGfIoKglK+daBVISEEP1rNdTQ=
X-Google-Smtp-Source: ABdhPJyTTkvW4v/gaD04reToEP32Uo2nhozCh2vwY0/Eor44Lqn8G0w0tEWlT3O+f3AAO8m7GIxnWA==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr20273588wmg.127.1589810594949; 
 Mon, 18 May 2020 07:03:14 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s67sm16611946wmf.3.2020.05.18.07.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:03:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/arm/integratorcp: Replace hw_error() by
 qemu_log_mask()
Date: Mon, 18 May 2020 16:03:06 +0200
Message-Id: <20200518140309.5220-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518140309.5220-1-f4bug@amsat.org>
References: <20200518140309.5220-1-f4bug@amsat.org>
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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


