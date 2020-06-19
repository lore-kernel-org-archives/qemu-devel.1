Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF23C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76493217D8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmAI8Co2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76493217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmINa-00068C-Ou
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMO-000445-7y; Fri, 19 Jun 2020 10:51:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMG-0003g0-Gc; Fri, 19 Jun 2020 10:51:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id x6so9934445wrm.13;
 Fri, 19 Jun 2020 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wgoNLzG3Ol7QUrQ8g37Gepx90Z5CEvbQwQpJANTL2T8=;
 b=pmAI8Co2QxWxmKECSS9W26vsaeTcf+n55WABZ4+RWvJz2xnYuoep2Bk/9e3Y6baP86
 8KyeqcHsQM1/zoLo0dQO8GlB2z9CtVv04nSj2dIFzO1JxGPEpfcIRFAXija9iad2Pkjn
 kVSo/rCDig+jT0K1jHzY+sLvJ07QAKp+bXfYes+hKNsREmIjqAN01VmdKC19UkSNodsa
 Z/O8Dq4q9C+646o3SKDV2c1pm34SuKwK2b0VS6ImcioDtZ9McvMwQEOv9NJ+YxO6dWWO
 9eYAreeWE91FrdZcCsrQHAElSif/q+RqyD9hSzjRZEohc4fmVR5NlcejulIUpwRMPOcC
 Icaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wgoNLzG3Ol7QUrQ8g37Gepx90Z5CEvbQwQpJANTL2T8=;
 b=S11Dhsgcd4c3nPpC1rwUSSvYwtxEG/JivU/2rq9KuDoqRBVaHfKEYQsn/habAHNTF3
 Z9odM91zrIhLnkMEZlxrHTDqYq8ZKFaFm5zcYyH4NErwQYb2QhNI3jXWSG2PL16t/cnz
 8LbuLhRFd0Yf3fgZy9ltwXwCKj8qJRzrnVNF3k5Hv+o/58wXzvalZkb5BYsnzF/rl1dc
 SFLsLjThZBb6IVDAma2jBO0WzsKwZ1WJzI2YMYLM41ITAqG8AK/20bV4MtTFlSDamSAd
 r0Wu6hvyDO4WQT2TSd64ySALnZLNi6om7Jm1n5wQ0KA0AIwVTQcQYAvDji82wfl9txh+
 hbqA==
X-Gm-Message-State: AOAM530DKmOz5DSCeLHBYtM6cypSJjRMtJm7lsAQ+vLjTDtvtBp9JiLH
 T2tMwI9hH/FmHmGvVDu8xsPnzprf
X-Google-Smtp-Source: ABdhPJxyV344rnv7Lr69+btk2PUIWQDs0WssAlM/yxiHfCRigKvK8sQhNu0Dk/aoMuuQ1vfSofbtXQ==
X-Received: by 2002:adf:e587:: with SMTP id l7mr4556399wrm.352.1592578266239; 
 Fri, 19 Jun 2020 07:51:06 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id e12sm7512548wro.52.2020.06.19.07.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 07:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] hw/misc/pca9552: Add a PCA955X_LED_MAX definition
Date: Fri, 19 Jun 2020 16:50:59 +0200
Message-Id: <20200619145101.1637-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200619145101.1637-1-f4bug@amsat.org>
References: <20200619145101.1637-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current code models the PCA9552, but there are comments
saying the code could be easily adapted for the rest of the
PCA955x family.
Since we assume we have at most 16 LEDs (for the PCA9552),
add a definition and check the instance doesn't use more than
this number. This makes the code a bit safer in case other
PCA955x devices are added.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pca9552.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index e015ef0e5d..00fa91b7f4 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -18,6 +18,8 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 
+#define PCA955X_LED_MAX 16
+
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
@@ -303,6 +305,17 @@ static void pca9552_initfn(Object *obj)
     }
 }
 
+static void pca9552_realize(DeviceState *dev, Error **errp)
+{
+    PCA9552State *s = PCA9552(dev);
+
+    if (s->nr_leds > PCA955X_LED_MAX) {
+        error_setg(errp, "%s invalid led count %u (max: %u)",
+                   __func__, s->nr_leds, PCA955X_LED_MAX);
+        return;
+    }
+}
+
 static void pca9552_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -311,6 +324,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
     k->event = pca9552_event;
     k->recv = pca9552_recv;
     k->send = pca9552_send;
+    dc->realize = pca9552_realize;
     dc->reset = pca9552_reset;
     dc->vmsd = &pca9552_vmstate;
 }
-- 
2.21.3


