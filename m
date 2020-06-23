Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D222C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E072072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUWs34OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E072072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndR6-0000DL-F5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLD-0007GT-Cg; Tue, 23 Jun 2020 03:27:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLB-00050j-Qx; Tue, 23 Jun 2020 03:27:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id q2so16920759wrv.8;
 Tue, 23 Jun 2020 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=arYfAgFaDC5KJS56FmiGTnYDDlbQYpxebSPREc/0vlA=;
 b=bUWs34OQACaneG+Su8qwOb+t223HUDOLzFjTS+8Tpc3ZjYFsH41It1hxGXgQZXmnj2
 CwaJH4eqQSrhmlUnTOSnEpi3IVSwC5Bm2fQIa8PPwHge9TCbrYoIsPQ+t2lhSiOnKMWU
 p92NGO15/FSvFzAKcVPyKv5deF6/KxB9mowC+Bar7ysbiMs16i/d/JL6V0sTNoM4b4VB
 ttOB07spwOk7T8PW7OrUSBpJxb9CQKWTNuv+BWj5N5SUZFz8LuEWbgUkGAyKmLqGLIYC
 mUlY583d+oDh9ZNGlbjxd3fsJ3XH/12H00KsIujr8G0R+cxoxpKSmNFHqtp8vMUR/ckK
 NHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=arYfAgFaDC5KJS56FmiGTnYDDlbQYpxebSPREc/0vlA=;
 b=pKiYgmIpqaXW8HV5rlbQe8+QKxKAQCP7Xl2ymZtQbFhJLY/8ih4HM9dvFU2BUmrkGP
 BgUfvsPB7x/0P/cdPwmXfOtFOOYjkTJex2dKxCrHutoxhmm6986FyjX7je5EWCxBCIwb
 NTx3IEGIaKDLnhf+Lov47Ymrxwvc7czrtMN0efvpvS+H++sySsUX4K0FhWdu9FVlVt68
 S82qHXMMu50V4pUgzjjaETA2b4eLj3JHwE2u7CLG57Fn6M3GED6IPPzeCel2fr8IThGZ
 PT6vnyTAlSgyAZ5f9/nQFnoi1vKiW7TuVDdhshfxyHOK3DV7ghYqZKWKS4l+Bt6khf31
 1Qgg==
X-Gm-Message-State: AOAM531l3yS0OR0pdP67NY7e/8uGelCafEy6PZcrEcwy3R6iGctlpYon
 g+v14MNG4UbVetb2pmlFCP12nd6y
X-Google-Smtp-Source: ABdhPJy08Wf+U2PGBve/FoT4Fh48S7iJM9KwjMrLcxtuaSfxek0Af2E4G4AIXL7YJyF5/aUCL9fHaQ==
X-Received: by 2002:adf:e948:: with SMTP id m8mr19859432wrn.398.1592897251927; 
 Tue, 23 Jun 2020 00:27:31 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l14sm4200059wrn.18.2020.06.23.00.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/9] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
Date: Tue, 23 Jun 2020 09:27:19 +0200
Message-Id: <20200623072723.6324-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072723.6324-1-f4bug@amsat.org>
References: <20200623072723.6324-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a description field to distinguish between multiple devices.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  1 +
 hw/misc/pca9552.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index 90843b03b8..bf1a589137 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -27,6 +27,7 @@ typedef struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
+    char *description; /* For debugging purpose only */
 } PCA955xState;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 4de57dbe2e..2cc52b0205 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
@@ -317,13 +318,30 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
+static void pca955x_realize(DeviceState *dev, Error **errp)
+{
+    PCA955xState *s = PCA955X(dev);
+
+    if (!s->description) {
+        s->description = g_strdup("pca-unspecified");
+    }
+}
+
+static Property pca955x_properties[] = {
+    DEFINE_PROP_STRING("description", PCA955xState, description),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pca955x_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
     k->event = pca955x_event;
     k->recv = pca955x_recv;
     k->send = pca955x_send;
+    dc->realize = pca955x_realize;
+    device_class_set_props(dc, pca955x_properties);
 }
 
 static const TypeInfo pca955x_info = {
-- 
2.21.3


