Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077AFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E8020814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpqotN24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E8020814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqoj-0003Yg-St
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgJ-0002jN-Iw
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgI-0000SQ-Ex
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id k13so7795742wrx.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MBRcZYhsnG0Nv84sXRAp1u7ZTCa04K6nc81c5uqmkh8=;
 b=DpqotN24rCXVOXyo2V0Fq9Cz24bRd25gK2MPTyEOqAL5zEp36gi3/9Wz+ybODSigcF
 uSD3fSHl7IdTio+6e3Pi8qfImYY1CfasSttpL34RkSwgPIyDnZzbkYGld8JLurduGwnm
 z/gQLJWL+ilnfT+2Chd8V/Iml1i8BEAGg/zS76xg1JHuYnIWKg6H5n4V5EaOkz9k1DGu
 gbqbvkQeeopAm/NIyPQav91+ttk3kDmqFhItvrSj7zw44VIne2c+/Bg+t4qxJBdgfHcY
 JsiW+K4K6xVbFeXmSmxUUh4XNfC+GAjAxQCQyrEFIxDzIOb+qUBRVMlPBbUghW0iMS0q
 WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBRcZYhsnG0Nv84sXRAp1u7ZTCa04K6nc81c5uqmkh8=;
 b=UldF5Cdw8Km4+mEcgpxDDKg7YKXQAhV6gAbJ+l3AutUnnxbGjEl7Ym6SMb2p8iLpfs
 DKZwG6PE0NLsBbGz5LcmBS0/Ms8EWCb8Haj62QcmmL82JUzgPZpcWo5/0KnpRLpa1Oln
 zyvL+BPev4U3HrHxbM/sUHpRomyyTUv0MN7U0arrMAvGwG0VRmLSyWwcmb5AeT2j2eRN
 ds6jwGFz0s8vOURRk1okS0NxNyWTfwO23CrwdBXnTXObTuJ5NjPaxyeGDl7sQVFPFaF+
 HPeWBdUv/MPFwFbB6LuRHEGxHUjdec/UZ1HHZ+2N28NrCqQFx6EMzjW9LhDVzoBkb82y
 JDyQ==
X-Gm-Message-State: AOAM530aaqoJZZa3yKUuE7hGvmyr8ddgUP20LcPborlaKxkNCW1TkcNY
 e3pw0WLeyDj4uQTOof9Thw0NQ9TSGmDnlA==
X-Google-Smtp-Source: ABdhPJwuJb0bYKnH9yW153p09mgCQE0/lAvHdtDnxELC3t11Omvotu0/ab53h9FTJHaFGIbYdNoFig==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr70137wrt.411.1590088596658;
 Thu, 21 May 2020 12:16:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] hw/arm/integratorcp: Replace hw_error() by
 qemu_log_mask()
Date: Thu, 21 May 2020 20:16:01 +0100
Message-Id: <20200521191610.10941-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200518140309.5220-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 6d69010d06b..5fb54e5aa75 100644
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
2.20.1


