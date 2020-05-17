Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B66C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9BF20671
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ2J+UKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9BF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM7S-0005FW-8d
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM30-0006Cq-Ir
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2z-0006lH-TN
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:54 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ci21so329080pjb.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HAJ0HofmgJ04cJDE1ulmHW4lkVwdCtglKKZzdQQuFzw=;
 b=fZ2J+UKjedY6FkWQV65ZBGorTxnhcxOGVS76U7Yds3/kaY8HeGD8nowM7K4AZKbZyS
 mEnsUH0XwhVsi4xGkq/nhKQCjiDvDILy4At34nk+4q8il5SReji7q2m50ZsL1+3wuQNC
 16uoRkVolwijutNLORRWW7argk6GWQKxslS3B+gb5P3Q7UhjEWbSEPFPfhOXHgRxtMQb
 gfXBXU4Ej49/89MMhmZY6ujbH4/NkvkXRFNPl1xLAE2RVE5ncKI+suryztc94Ok3Gwhw
 3VBwVvulcvMb9hnXnzPhZVtzeQtzeeu1uaQ5y6Y88Utcv6ac6v5Nu+mQe3C4hI1aEZSj
 YWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HAJ0HofmgJ04cJDE1ulmHW4lkVwdCtglKKZzdQQuFzw=;
 b=YLObYGq5TBnoSDQSQ8yt7X4/slsqx+DAd6UnyymK4ClMd2qWMZN7RzNMI4XFNx+V86
 4I0YPlsgabbrE5JNB5lly4+8WCoS4+RZK6Koilfm0ZJFFxWO4iue4EsVvyReT6b3NHMT
 oo/BegE016VSXJSY0SkRu15NYBBSsW4lt3FHINHjmHOG5D2mgrVM+P2KBQEQsywxEdIb
 7UQjt8GAP7enbtMEDqKxsCyYmIggZwN2yWt1QcWa6ur9Az9aprsG0eqZGWbkiFtcyO34
 a5wQ/Jphy2KCp+SCVal5cab6xwplVXsxqlupknoPRsjF+Zx8MCP6oH3HkHdLTzwyaqP1
 ++1A==
X-Gm-Message-State: AOAM530ufU/iFSDndwHemUn74KW3XWV4QYn4Kb55t5xCyoN+53AXe0CW
 Q6iaSuNZ2LIuOay8aUfP0HA=
X-Google-Smtp-Source: ABdhPJx3QLeRfL+nQrTRhvi2Ey4VspVHIAINfq5uhRBxnykKSSfHru0CjCoQrwtJU1fOqK36pVZofw==
X-Received: by 2002:a17:902:a60e:: with SMTP id
 u14mr2653026plq.176.1589732512408; 
 Sun, 17 May 2020 09:21:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q25sm6553786pfh.94.2020.05.17.09.21.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:52 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 8/8] hw/arm/fsl-imx7: Connect watchdog interrupts
Date: Sun, 17 May 2020 09:21:35 -0700
Message-Id: <20200517162135.110364-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

i.MX7 supports watchdog pretimeout interupts. With this commit,
the watchdog in mcimx7d-sabre is fully operational, including
pretimeout support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Peter's Reviewed-by: tag
v2: No change

 hw/arm/fsl-imx7.c         | 11 +++++++++++
 include/hw/arm/fsl-imx7.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index d6cf7c48ce..89c3b64c06 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -447,11 +447,22 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_WDOG3_ADDR,
             FSL_IMX7_WDOG4_ADDR,
         };
+        static const int FSL_IMX7_WDOGn_IRQ[FSL_IMX7_NUM_WDTS] = {
+            FSL_IMX7_WDOG1_IRQ,
+            FSL_IMX7_WDOG2_IRQ,
+            FSL_IMX7_WDOG3_IRQ,
+            FSL_IMX7_WDOG4_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX7_WDOGn_IRQ[i]));
     }
 
     /*
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 47826da2b7..da977f9ffb 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -228,6 +228,11 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
+    FSL_IMX7_WDOG1_IRQ    = 78,
+    FSL_IMX7_WDOG2_IRQ    = 79,
+    FSL_IMX7_WDOG3_IRQ    = 10,
+    FSL_IMX7_WDOG4_IRQ    = 109,
+
     FSL_IMX7_PCI_INTA_IRQ = 125,
     FSL_IMX7_PCI_INTB_IRQ = 124,
     FSL_IMX7_PCI_INTC_IRQ = 123,
-- 
2.17.1


