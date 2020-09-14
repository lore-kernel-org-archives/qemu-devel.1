Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3109FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EE22074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDaIheu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHp8s-0003dy-Ia
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp84-0001zc-1T
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp82-0007W6-90
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id z9so203443wmk.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4Wx6PXj8KizxtYio9NXwuWyl3mh6LdgyhmTm+qqDWJY=;
 b=kDaIheu4LRUn52/HnkZnU4n3j2Z/Kt6RoC1D2NuqX7k26d+l94WgUuvZ1FzolA4j4Z
 Qvhva/G6gOpALj3XuHAHwa6OMgSCs9H3ddCN6XGQXhtm6bt7l+WcEGKjfyuK9B0IgQ1n
 eXAj9AaTq2lHTfA6vRAC0l/Lbi00ek+y2eSCgaZ/h40H0qmV4v06bC9ggPHeWapJJUID
 j4XgU3oHT2keMRkHjTrbm70g63EKNigOlVndYKKXiQ9aqNiYH6MXnqQaRxO9VOHEuiPU
 PQCQlZCgcYr8pBKQR8CgLFSswdgDTFRkCrg52xh9QtKvPLckxVHqg8ST1ja84uSC8aQ+
 KE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Wx6PXj8KizxtYio9NXwuWyl3mh6LdgyhmTm+qqDWJY=;
 b=QTVidSGaRlIMjYUcg+EFW1Gbf32mhKsU+avqd6kS7yHcANbf/N0YaITmDG18H8MmTn
 376I42YBkg4eQGxZgtX8BCIYmgtvu3fjKQOVR2q0smvZY4PugdziNFjgtJP9LdHDLoZ7
 seuKCcvC7yVh9nlB9TI2eqbLfR709v34w3pkgT/onDMvFwuXeMT+D8VTE5D1EfTlDXER
 Gr3PC9YNnMJ3QaWwMJ0QMsoIqrCaVOoaCkaFL9L+w0A3lHo4jxiLIh8OyEgFUiyjieHI
 yJbaho3vvJ/YbNYgP7XHjZfZzkQuKbW9Le2RYaVEqrKvRU8jwA8Wnsf898X7VQu25+c5
 8j8w==
X-Gm-Message-State: AOAM531vtPsYjz5lE7Ja3l9itGxhf2AuDnNIg+PA/EvaWyPgHT8fHzH+
 C0PaSMsh5Zpm5WzX7DTbjqWZSELXjt8aWJ3T
X-Google-Smtp-Source: ABdhPJyehNcBLPGgCyYpMR4GoGavZQak00JCr9ZyHGo23s1Uor61Lx0iDYVf7mvCCo65MVHhe/i4mQ==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr10308402wmd.2.1600092404606; 
 Mon, 14 Sep 2020 07:06:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/36] hw/misc/a9scu: Do not allow invalid CPU count
Date: Mon, 14 Sep 2020 15:06:06 +0100
Message-Id: <20200914140641.21369-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per the datasheet (DDI0407 r2p0):

  "The SCU connects one to four Cortex-A9 processors to
   the memory system through the AXI interfaces."

Change the instance_init() handler to a device_realize()
one so we can verify the property is in range, and return
an error to the caller if not.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200901144100.116742-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/a9scu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 324371a1c00..915f127761e 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -12,8 +12,11 @@
 #include "hw/misc/a9scu.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 
+#define A9_SCU_CPU_MAX  4
+
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
                             unsigned size)
 {
@@ -105,12 +108,17 @@ static void a9_scu_reset(DeviceState *dev)
     s->control = 0;
 }
 
-static void a9_scu_init(Object *obj)
+static void a9_scu_realize(DeviceState *dev, Error **errp)
 {
-    A9SCUState *s = A9_SCU(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    A9SCUState *s = A9_SCU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_io(&s->iomem, obj, &a9_scu_ops, s,
+    if (!s->num_cpu || s->num_cpu > A9_SCU_CPU_MAX) {
+        error_setg(errp, "Illegal CPU count: %u", s->num_cpu);
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &a9_scu_ops, s,
                           "a9-scu", 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -138,13 +146,13 @@ static void a9_scu_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a9_scu_properties);
     dc->vmsd = &vmstate_a9_scu;
     dc->reset = a9_scu_reset;
+    dc->realize = a9_scu_realize;
 }
 
 static const TypeInfo a9_scu_info = {
     .name          = TYPE_A9_SCU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(A9SCUState),
-    .instance_init = a9_scu_init,
     .class_init    = a9_scu_class_init,
 };
 
-- 
2.20.1


