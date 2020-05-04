Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B602C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BAC206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMM7CErr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BAC206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWa9-0007sr-Ib
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXt-0003NQ-VU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXt-0007S9-8n
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id x18so19872183wrq.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TyhBVROPRuzO0rWk+Br8uL9KdUxWrVxwNNY4fpfIogg=;
 b=iMM7CErrzcQJI5kDg/k4pIk3TcjArB+JXv/OksqsXoEuBScblFzt0lwZHglDZ3o/LP
 cAb31cXqwouMJWRm2vZJalE2RLtJdWXz++Xp4qoWiD9tG4zEcop78fp7vksKmOGKhxDo
 UyE/Zp2gNVbo7kS+BwPeC68bgL9HMwv6l6rabJAnhpERFw2Qu5bY7wz7jleyskLlaVhg
 EEaIlT4OZTumCRXBRmpCGsHFFCZ0/nTUpnk+vEp8vbe7fI5AJoJM0rDhPX2YUdCwBKBg
 WCfqsP/ZJTaxtBuqzqlA3uSNcn8ARR/oDOhZMsNjb80o+7RuQCyleVvohnpJvtLPjXS7
 6TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TyhBVROPRuzO0rWk+Br8uL9KdUxWrVxwNNY4fpfIogg=;
 b=CplFUVseNnKeQRc7eSNPWkA96DxvVV3gTpp0jlEBTV1icD7iTyJREdlBj7Xfr+F6a5
 s3qwDnwqqc6SBUr3yxQztSzPWLIu/kXZkm9kgh6zg/XoI6/7/QZlO3UggSrosW32EBqM
 PeZzgdjCWxTZ1fKb3ghRTGJQYR9fPhDoli+RfqtciWUehRvSDdRaul3seGpdWT/4rqOd
 +MOZvKHS4tu54yOU01yBqsQyvQ+AH3VOeNrWgxpmtnnv2H4DwhHMlfAfvHRTIhOe9EbP
 FGqNcw0uyse60t0UN4oJcqnTuTqTebGkxvso3Xc8zpWf1Uz20mAgPIwVOV6vSXwvusZv
 CusA==
X-Gm-Message-State: AGi0PuZXQmPdmZoyLbcc4DNbKvrFhuBjSOo1KeOZqWkgF1gaqTYVL4ym
 BpUjyqSlNHZTdUA4dCc1q+Y4I09U
X-Google-Smtp-Source: APiQypI6vm72sLG7ql+eMbqbz7C8x7LYmJeBq0OGpDLjiFM736DJzczI7388DZgnekTHyoSrj2dtCg==
X-Received: by 2002:adf:fac5:: with SMTP id a5mr14328474wrs.210.1588581227454; 
 Mon, 04 May 2020 01:33:47 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 2sm13048053wre.25.2020.05.04.01.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:33:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/i386: Add 'vmport.h' local header
Date: Mon,  4 May 2020 10:33:41 +0200
Message-Id: <20200504083342.24273-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504083342.24273-1-f4bug@amsat.org>
References: <20200504083342.24273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move 'vmport' related declarations in a target-specific header.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/vmport.h     | 34 ++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         |  1 +
 hw/i386/vmmouse.c    |  1 +
 hw/i386/vmport.c     |  1 +
 5 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 hw/i386/vmport.h

diff --git a/hw/i386/vmport.h b/hw/i386/vmport.h
new file mode 100644
index 0000000000..47eda7a22b
--- /dev/null
+++ b/hw/i386/vmport.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU VMPort emulation
+ *
+ * Copyright (C) 2007 Hervé Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_I386_VMPORT_H
+#define HW_I386_VMPORT_H
+
+#define TYPE_VMPORT "vmport"
+
+typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
+
+void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
+
+#endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 26e2a3d92b..de49a57506 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -130,9 +130,6 @@ typedef struct PCMachineClass {
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
 /* vmport.c */
-#define TYPE_VMPORT "vmport"
-typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
 void vmmouse_get_data(uint32_t *data);
 void vmmouse_set_data(const uint32_t *data);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 84669ddc84..f6b8431c8b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -91,6 +91,7 @@
 #include "qapi/qmp/qerror.h"
 #include "config-devices.h"
 #include "e820_memory_layout.h"
+#include "vmport.h"
 #include "fw_cfg.h"
 #include "trace.h"
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e8e62bd96b..78b36f6f5d 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -29,6 +29,7 @@
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "vmport.h"
 
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 114141c6f3..00d47e0c4c 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -26,6 +26,7 @@
 #include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
+#include "vmport.h"
 #include "trace.h"
 
 #define VMPORT_CMD_GETVERSION 0x0a
-- 
2.21.3


