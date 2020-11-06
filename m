Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF5F20679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM9uc1QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF5F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katHO-00036k-0r
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katFL-0000Q6-Js
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:21:08 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katFI-00072x-R3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:21:07 -0500
Received: by mail-pl1-x643.google.com with SMTP id k7so80980plk.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMn+eV6ctcOkwu/IoidLdGuNY7g9b5HHkqqsoBsSBjE=;
 b=BM9uc1QWhOQg+QcyJcKpHTsZuJufMmcnuzY+bBxBfZllZC7pyR6v2IJ9Z5wE7ToXAz
 GZZZUphRPOLHmvs7vNYvF+iBIyznpzn/JW/tHj8XNXY/IahJUuZIYeMtQP6IaKV0uH1t
 hkgtlLcPpn4EsSiNZ7Toaz8clsXEaHKQM9ZJwsCQAk/kREiqUuiOCHnsq48SuTYuJr/R
 PHGzVnbj5M12APzsih5L+NmFZQq+lJ8TzrkszEbFBy/EyCOYbXzWGBRmrnMpfdiyAya4
 vlQtFOffs2Sv88bR27TF6e8gkQnNm7G1yHkFbv3KI8uhVWoCZI/6H0zdI8qKVRlQuJzb
 5lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMn+eV6ctcOkwu/IoidLdGuNY7g9b5HHkqqsoBsSBjE=;
 b=JqJOt9WOpPncXCvz4Bym8Wy2w6bCFkhrlLASAlKAaeTATiZQsuIKLRK0F6C9Nbg4b0
 CmOMHZyd/8zE7R3l5KNHxT7G9AR4FRoqdTC/l1gEmPuEwAZQLeyk61atP5RJGq/Y2L1m
 hLC+UrzBQKuIfe6WcpCcxRMgKpchFw+l3hAOKa2G3tSsqBtyGV9mP+4O0KGl+9gA3vpz
 Y/62blNIWjFNpRgAuvigP655Ck87St5yBY1SA2nbMli02k1EaSCJ8iXeq05pgwbdibdV
 x4C7VvXDwFC6yElnzXnmbhaSke0FtqFCzS+GxqBtX0KTBBvnDB7+0R9ujnvMaUxXjfOe
 K1iQ==
X-Gm-Message-State: AOAM530gG4FCbTzVU/ck+DXIoAiaSuwJ2OwylYArpemtMQFUrf9nACOo
 EGWVDYeJ8JgAaTD3//T5av8=
X-Google-Smtp-Source: ABdhPJxTdX4h6OOM3eW1cQ+eVpXEI7ka2HVwrDCwTRBs/Q9HqThQvnJR8bZhFuMa5qKrNKu6hU/BaQ==
X-Received: by 2002:a17:902:bc83:b029:d6:ab18:1079 with SMTP id
 bb3-20020a170902bc83b02900d6ab181079mr140557plb.22.1604636463172; 
 Thu, 05 Nov 2020 20:21:03 -0800 (PST)
Received: from software.domain.org (111-252-196-15.dynamic-ip.hinet.net.
 [111.252.196.15])
 by smtp.gmail.com with ESMTPSA id y1sm262235pjl.12.2020.11.05.20.20.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:21:02 -0800 (PST)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH V17 2/6] hw/intc: Rework Loongson LIOINTC
Date: Fri,  6 Nov 2020 12:21:46 +0800
Message-Id: <1604636510-8347-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As suggested by Philippe Mathieu-Daudé, rework Loongson's liointc:
1, Move macro definitions to loongson_liointc.h;
2, Remove magic values and use macros instead;
3, Replace dead D() code by trace events.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 hw/intc/loongson_liointc.c         | 49 +++++++++++---------------------------
 include/hw/intc/loongson_liointc.h | 39 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 35 deletions(-)
 create mode 100644 include/hw/intc/loongson_liointc.h

diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index fbbfb57..be29e2f 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Loongson Local I/O interrupt controler.
  *
+ * Copyright (c) 2020 Huacai Chen <chenhc@lemote.com>
  * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
  *
  * This program is free software: you can redistribute it and/or modify
@@ -19,33 +20,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "qom/object.h"
-
-#define D(x)
-
-#define NUM_IRQS                32
-
-#define NUM_CORES               4
-#define NUM_IPS                 4
-#define NUM_PARENTS             (NUM_CORES * NUM_IPS)
-#define PARENT_COREx_IPy(x, y)  (NUM_IPS * x + y)
-
-#define R_MAPPER_START          0x0
-#define R_MAPPER_END            0x20
-#define R_ISR                   R_MAPPER_END
-#define R_IEN                   0x24
-#define R_IEN_SET               0x28
-#define R_IEN_CLR               0x2c
-#define R_PERCORE_ISR(x)        (0x40 + 0x8 * x)
-#define R_END                   0x64
-
-#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
-DECLARE_INSTANCE_CHECKER(struct loongson_liointc, LOONGSON_LIOINTC,
-                         TYPE_LOONGSON_LIOINTC)
+#include "hw/intc/loongson_liointc.h"
 
 struct loongson_liointc {
     SysBusDevice parent_obj;
@@ -123,14 +102,13 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
         goto out;
     }
 
-    /* Rest is 4 byte */
+    /* Rest are 4 bytes */
     if (size != 4 || (addr % 4)) {
         goto out;
     }
 
-    if (addr >= R_PERCORE_ISR(0) &&
-        addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 8;
+    if (addr >= R_START && addr < R_END) {
+        int core = (addr - R_START) / R_ISR_SIZE;
         r = p->per_core_isr[core];
         goto out;
     }
@@ -147,7 +125,8 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
     }
 
 out:
-    D(qemu_log("%s: size=%d addr=%lx val=%x\n", __func__, size, addr, r));
+    qemu_log_mask(CPU_LOG_INT, "%s: size=%d addr=%lx val=%x\n",
+                  __func__, size, addr, r);
     return r;
 }
 
@@ -158,7 +137,8 @@ liointc_write(void *opaque, hwaddr addr,
     struct loongson_liointc *p = opaque;
     uint32_t value = val64;
 
-    D(qemu_log("%s: size=%d, addr=%lx val=%x\n", __func__, size, addr, value));
+    qemu_log_mask(CPU_LOG_INT, "%s: size=%d, addr=%lx val=%x\n",
+                  __func__, size, addr, value);
 
     /* Mapper is 1 byte */
     if (size == 1 && addr < R_MAPPER_END) {
@@ -166,14 +146,13 @@ liointc_write(void *opaque, hwaddr addr,
         goto out;
     }
 
-    /* Rest is 4 byte */
+    /* Rest are 4 bytes */
     if (size != 4 || (addr % 4)) {
         goto out;
     }
 
-    if (addr >= R_PERCORE_ISR(0) &&
-        addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 8;
+    if (addr >= R_START && addr < R_END) {
+        int core = (addr - R_START) / R_ISR_SIZE;
         p->per_core_isr[core] = value;
         goto out;
     }
@@ -224,7 +203,7 @@ static void loongson_liointc_init(Object *obj)
     }
 
     memory_region_init_io(&p->mmio, obj, &pic_ops, p,
-                         "loongson.liointc", R_END);
+                         TYPE_LOONGSON_LIOINTC, R_END);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
 }
 
diff --git a/include/hw/intc/loongson_liointc.h b/include/hw/intc/loongson_liointc.h
new file mode 100644
index 0000000..e11f482
--- /dev/null
+++ b/include/hw/intc/loongson_liointc.h
@@ -0,0 +1,39 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2020 Huacai Chen <chenhc@lemote.com>
+ * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ */
+
+#ifndef LOONSGON_LIOINTC_H
+#define LOONGSON_LIOINTC_H
+
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define NUM_IRQS                32
+
+#define NUM_CORES               4
+#define NUM_IPS                 4
+#define NUM_PARENTS             (NUM_CORES * NUM_IPS)
+#define PARENT_COREx_IPy(x, y)  (NUM_IPS * x + y)
+
+#define R_MAPPER_START          0x0
+#define R_MAPPER_END            0x20
+#define R_ISR                   R_MAPPER_END
+#define R_IEN                   0x24
+#define R_IEN_SET               0x28
+#define R_IEN_CLR               0x2c
+#define R_ISR_SIZE              0x8
+#define R_START                 0x40
+#define R_END                   0x64
+
+#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
+DECLARE_INSTANCE_CHECKER(struct loongson_liointc, LOONGSON_LIOINTC,
+                         TYPE_LOONGSON_LIOINTC)
+
+#endif /* LOONGSON_LIOINTC_H */
-- 
2.7.0


