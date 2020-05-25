Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B09C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D39620723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCXQnJPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D39620723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBVm-0007kB-R7
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBU3-0005b6-LU; Mon, 25 May 2020 07:41:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBU1-00043M-EX; Mon, 25 May 2020 07:41:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so9216542wmj.0;
 Mon, 25 May 2020 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7nI/G3Z6Hrd/LcEj6HAvF8ip5LwLXsCC19mIjaUHNIU=;
 b=JCXQnJPyfUKYB9qg/DLDhUHnrrMMifBNIoMjN8jE65yQljDppyLW6a7bqceZpoJipe
 Tt6Y1ec4gX96h0gTqbgjtL1GD0VrIYOSEZ2ROBTC3EDBXIgt6G0HKyMjCzuAcd+PyQsP
 TWZFG9YOsVbv3KlaQO0B7x7Letz13wzF4HZ2UDCyW/PtuY4EjlGa0h7Pv7LMZX2fuZxG
 rUEwg9av0Lw+vLOUfFQ86e5ZEREV8LYqyyGpZgBJwg3oDWfHQBdIP1zg9401l2apgXvc
 Korgre+N23JNLBY7azwrv4P5lSgSp5Vnzo7XWnHNa2YwchqjQqultpCGDtG41VeE16F7
 6nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7nI/G3Z6Hrd/LcEj6HAvF8ip5LwLXsCC19mIjaUHNIU=;
 b=CB2hhJUUyfhc1FRcwIxjcYaYeZqNZN4GaSo4gcoHJ9f5udphaVGoT/vtOZFnSXek0r
 IIt416a57gPwztxCROWy6BbS+MxVxuF1YmV1az0bjq4z0+BC0BoWYsxQqqTH84NB/umu
 ys4LFIVLlq8Z654kELYN1UWzxu/dCtvPgw775pXpknw/edHRdbfZcUA1vAdASYLovPlO
 tSJxMaEuEIhOrhqArmLqbmsomd3eIc62uYGD22mEhaS1pZ9feQxP6TkPQb2RfUvN0Sh6
 Gyo8cbTPIiWcE+XCYlg4HUCve1ZBtDEeYgrzMzkCfbF0ozjkkijZ0Slyuz2JCA44G13O
 /pkA==
X-Gm-Message-State: AOAM532Wbfl9LLgZe/VVJ4NiKXrji0zJMC2oLcZNwv2fE7v3HCvw47E+
 oFY4lDAUOIjD1E1FSWhngKn4gP9v0sY=
X-Google-Smtp-Source: ABdhPJyd1yRRWh6cVIYBq8H7eCl1ZTej+fgyxBKVMCFZg0T51bPn6afHx2EqDY3XVuRpGvvykU/zrg==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr8630135wmh.25.1590406886723; 
 Mon, 25 May 2020 04:41:26 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b132sm4936159wmh.3.2020.05.25.04.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:41:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/input/pxa2xx_keypad: Replace hw_error() by
 qemu_log_mask()
Date: Mon, 25 May 2020 13:41:22 +0200
Message-Id: <20200525114123.21317-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525114123.21317-1-f4bug@amsat.org>
References: <20200525114123.21317-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask()
(missed in commit 5a0001ec7e).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/input/pxa2xx_keypad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 31862a7d16..62aa6f6b15 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
@@ -233,7 +233,9 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
         return s->kpkdi;
         break;
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -280,7 +282,9 @@ static void pxa2xx_keypad_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 }
 
-- 
2.21.3


