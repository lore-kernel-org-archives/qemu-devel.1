Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EADBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE82B22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S88fHOt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE82B22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFQA-0004pl-0q
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNn-0001lq-FU; Sun, 18 Oct 2020 16:34:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNl-0000yz-Ss; Sun, 18 Oct 2020 16:34:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so9154316wrq.2;
 Sun, 18 Oct 2020 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QcjhrFqjAYV+Q6plgNPayGWcmQofCNspcYhj6aIa8BM=;
 b=S88fHOt4fYPvKKEH0xh2S14khv8CZREiBDQPhGjwnuTTVinBOHQ51NeCHg5RPOOvfG
 0pevdhh7TcViZiHr/cvt13uSjrr4NPuYtYrFHEiHmcwcsN7BksRlm0gpJpQ04EgRYvTL
 Pf3FC30Ll1STlF5D1COoMzQcuWg7rZ4FrD+7cMU0LmoNcLWyuoNrvCYzTzt4222McDwU
 Pj03gq84PPRq6+1wS8Zqk31ZePLYNdbs2bXQypzc/uyL14WsbwiSnlnCvs3k/9FX1Cd7
 XNNOiWUQZ74lMk0lPjpys3T5t0dnGhKP6Cfz1PA+e2qjzQDn7anHdIwtyDPlK5nOJJdg
 iPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QcjhrFqjAYV+Q6plgNPayGWcmQofCNspcYhj6aIa8BM=;
 b=dWvkiuT8DI5rAiBl1ZtfCsBEx3KK5zSj4gfhWEdK71QhitSGH5BC3W+IZTi9fhdbto
 sBPABxy3hjdAUddF+hubSY+IdCM9G0xSb8Iz/xf0rJBSQbwTh8kzQitK5zWvKHJoLdT9
 uUtolyICxdZmseNoe41qzC9iMD/eRAKeDYNaXJqasmlSmEbhGH2PIrEIvixmPJbvieC/
 HifKdxTVH/ogb/SWE6LSljC2kZzqzDDO51hTGTdW2DiNs7XVjVLhekw5N1IomV2c3D2s
 Fq6rixWrZxPaa7/plYYBBP2HmVFdDU0Lro8CLvvSDhCS2kI+l7tUQSyyEjmEpSF7iWSL
 0qQQ==
X-Gm-Message-State: AOAM533GFFSexN3oGtWbHBjTcPsxCRmUYDNhp/PtHFWabV1B7gIblB5G
 AGhMeKK1NwrMjX0/PxKSt+Av/W5OMuQ=
X-Google-Smtp-Source: ABdhPJyMxOLmcmB6MgHjtw4hORwQBemfFcIetNda0xBwwM8Lmg5GkLkFvVwmmWJc1EuRJyIixrqq9g==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr15593621wrn.94.1603053260138; 
 Sun, 18 Oct 2020 13:34:20 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id v189sm14080474wmg.14.2020.10.18.13.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:34:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] hw/arm/bcm2836: Only provide "enabled-cpus" property
 to multicore SoCs
Date: Sun, 18 Oct 2020 22:33:53 +0200
Message-Id: <20201018203358.1530378-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018203358.1530378-1-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It makes no sense to set enabled-cpus=0 on single core SoCs.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index c5d46a8e805..fcb2c9c3e73 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -34,6 +34,9 @@ typedef struct BCM283XClass {
 #define BCM283X_GET_CLASS(obj) \
     OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
 
+static Property bcm2836_enabled_cores_property =
+    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
+
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
@@ -44,6 +47,10 @@ static void bcm2836_init(Object *obj)
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 bc->cpu_type);
     }
+    if (bc->core_count > 1) {
+        qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
+        qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
+    }
 
     object_initialize_child(obj, "control", &s->control, TYPE_BCM2836_CONTROL);
 
@@ -130,12 +137,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property bcm2836_props[] = {
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
-                       BCM283X_NCPUS),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -155,7 +156,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 
 #ifdef TARGET_AARCH64
@@ -170,7 +170,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 #endif
 
-- 
2.26.2


