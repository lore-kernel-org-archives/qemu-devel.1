Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CDC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A15206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVzqPDvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A15206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j32w9-0001zh-RU
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v0-0008UU-Fd
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uz-0004Ix-Cv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:58 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uz-0004IO-5j; Sat, 15 Feb 2020 14:15:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so14951006wru.3;
 Sat, 15 Feb 2020 11:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i66d8bTofo8A1vTFZIP/v8pdqf575/6M5yHqFaN2D1Y=;
 b=DVzqPDvEMgxD4sqlWzOEkOo5vTAVTPi4eNO3RVn7lo46y7UkpcxQAPjtgYqWXW9KU1
 cUs1NXiN8ntwY0zgpdB1J/g6w1UlM2ARTWXtVoaOpFC9XaeCNZfYuBq/AXLtKv4zx2C5
 DuJg1p6Hm8ZtGOiNSRY1NqKBlQojqt8Z/VzuL0G+JCy0ESgMkjY0UbxQPIB3EE0eVNQm
 oeTaMn/L4kRMvKCNPIS9RNEXHFrlmxz1Cvmp/zJXDNXqgW9PnjII2srOA+xhqL7eriOT
 7k7XKM2M+zStTiE4uNI5dnPuhCkV+7AVYjqTAUmjq3iHNZoPDb8GRzMphp6tDeAjo4nA
 xsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i66d8bTofo8A1vTFZIP/v8pdqf575/6M5yHqFaN2D1Y=;
 b=fQpfRYHfN9MUGd+QyFswZVSMUZNV1s7FmDPvJn53aS4x6eELbqimv4oS66e7gQG57V
 pvpJhkSWB4jXqXpTVOtZRKs8DTUUXSYq94E1JyzeheEEKEH7lc1lpfJljsMjkNPAvbXF
 EHD9pVxizeghneAlyKqrjaA/do4HM3xA29RWIbq69ky8WcQdnPPivXKLA7D7DoawRe5S
 yGXFTBc5/Q8mLwqSb+mfew10r6MHivr0L8Jv+3njhWMI9mUdksa5CvbBQmLokr6fX4z8
 BNDPyCQziod7rMzP4A9WyZL+qlKlwPlKYlQrGxctBFHc9c1I8Lm2mAhW1cdF9okoYNJJ
 hOXg==
X-Gm-Message-State: APjAAAWsHlMu5L9L1a3Vx0ZPe5n59uMIPj25gGCWjqYcgPkfJeJuGzkB
 ZUEWfS2x0kqHb0LQaJdLANDQ+xU8eLg=
X-Google-Smtp-Source: APXvYqytZlWM6/Cb80eXdwPBy4l2NaBTACS/3gW/fV3fuvwnRZ3WrScQASl3axb7QNPKR/i19qGNLg==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr11767963wru.170.1581794155953; 
 Sat, 15 Feb 2020 11:15:55 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/12] hw/arm/bcm2836: Introduce BCM283XClass::core_count
Date: Sat, 15 Feb 2020 20:15:38 +0100
Message-Id: <20200215191543.3235-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2835 has only one core. Introduce the core_count field to
be able to use values different than BCM283X_NCPUS (4).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 683d04d6ea..3b95ad11e9 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -21,6 +21,7 @@ typedef struct BCM283XClass {
     DeviceClass parent_class;
     /*< public >*/
     const char *cpu_type;
+    int core_count;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
     int clusterid;
@@ -37,7 +38,7 @@ static void bcm2836_init(Object *obj)
     BCM283XClass *bc = BCM283X_GET_CLASS(obj);
     int n;
 
-    for (n = 0; n < BCM283X_NCPUS; n++) {
+    for (n = 0; n < bc->core_count; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 sizeof(s->cpu[n].core), bc->cpu_type,
                                 &error_abort, NULL);
@@ -107,7 +108,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 
-    for (n = 0; n < BCM283X_NCPUS; n++) {
+    for (n = 0; n < bc->core_count; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
         s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
@@ -173,6 +174,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     BCM283XClass *bc = BCM283X_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    bc->core_count = BCM283X_NCPUS;
     bc->peri_base = 0x3f000000;
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
@@ -187,6 +189,7 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     BCM283XClass *bc = BCM283X_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    bc->core_count = BCM283X_NCPUS;
     bc->peri_base = 0x3f000000;
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
-- 
2.21.1


