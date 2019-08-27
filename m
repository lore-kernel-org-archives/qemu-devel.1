Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFA5C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CDB2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0pd/BGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CDB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dDh-0004mB-3z
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwI-0003Mq-Ko
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwE-0003lE-GH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:17 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cw9-0003Yn-O0; Tue, 27 Aug 2019 10:59:10 -0400
Received: by mail-pl1-x641.google.com with SMTP id c2so11928467plz.13;
 Tue, 27 Aug 2019 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=79pvv71EJWG9K9pK1hUWRwhAT6GBi9ldC6TE+e9XAbQ=;
 b=e0pd/BGfQ1eB00IAwbdSEPQgxueP75F/9xn5hvQnC0p7QCHFT3nG9kF83h+jSmjDGi
 7OeyUaAkLYFkHKNCTIkuLRgARwzcDHg5LIbjOFUv22Huf9L3uvuS85aOltuYvYREcuJg
 YlTIlNC6dJsBlBAbHRxLP08NG7iwQ0BILSqzV7OVdNnPVqAwSPos9yEYky5M1CGUwp7j
 RZ6e7R42tx8IwKr/rgS62GoYzRHnTPQrlcWAN9BVqhJZCB5HEmixoA4vLOoVB/Yj2dW2
 yLeQfkF46XEQpSMhY7PZG2eTdPAWfjPDj6D8Un4VnFF6gl7JZh2dj9Xfkhfeln0koBSt
 hoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=79pvv71EJWG9K9pK1hUWRwhAT6GBi9ldC6TE+e9XAbQ=;
 b=MPKFPwXr2pLjvtk1UhhZDQkFoexUk+vRKtnfJqp6bbHw8L/YhN0U/mVHGv0lWXpae0
 tmgEuGTgyV4c41h5ClS2lmsdX0VlcYr+NQAxJKHPbni6YxX/yqF8GoTiLAIZf8ZCoaCU
 6X7pf2d3HgHyM9tuhP+tnc93qCd44b6hNgJ4BHVvc34CzOJVz1uvysika9mamv2aW+/H
 KuYfrP1+3kK7PwfaAC6l//XSEql0UIVasImiouYUEk/RdSddtLyMsqt6SwuV15ZTduBm
 sTgk0fac+ekFFi6H0DeIbRaWR4akNMTs4KLGLPqQziw49u49iw1tcgViomB/Cs9Nj9s+
 ctgQ==
X-Gm-Message-State: APjAAAUtL1znKa6GOKFs6lLnJrOLkhaObA7U0MkdDqODuYXxJ7n1JWX5
 vjUVQ4BffMey+a5d582GsJI=
X-Google-Smtp-Source: APXvYqwmDiol2JkJ0RB4lw5k+G7qGJISY91eA5+NmfAepTiCnVPPXXTHRKCNq51O8I1w3cxjdE0QWA==
X-Received: by 2002:a17:902:bb94:: with SMTP id
 m20mr24429061pls.336.1566917939370; 
 Tue, 27 Aug 2019 07:58:59 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.58
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:22 -0700
Message-Id: <1566917919-25381-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v6 13/30] riscv: Add a sifive_cpu.h to include
 both E and U cpu type defines
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

Group SiFive E and U cpu type defines into one header file.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/hw/riscv/sifive_cpu.h | 31 +++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_e.h   |  7 +------
 include/hw/riscv/sifive_u.h   |  7 +------
 3 files changed, 33 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/riscv/sifive_cpu.h

diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
new file mode 100644
index 0000000..1367996
--- /dev/null
+++ b/include/hw/riscv/sifive_cpu.h
@@ -0,0 +1,31 @@
+/*
+ * SiFive CPU types
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_SIFIVE_CPU_H
+#define HW_SIFIVE_CPU_H
+
+#if defined(TARGET_RISCV32)
+#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
+#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
+#elif defined(TARGET_RISCV64)
+#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
+#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
+#endif
+
+#endif /* HW_SIFIVE_CPU_H */
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index d175b24..e17cdfd 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,6 +19,7 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
+#include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_gpio.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
@@ -83,10 +84,4 @@ enum {
 #define SIFIVE_E_PLIC_CONTEXT_BASE 0x200000
 #define SIFIVE_E_PLIC_CONTEXT_STRIDE 0x1000
 
-#if defined(TARGET_RISCV32)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
-#elif defined(TARGET_RISCV64)
-#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
-#endif
-
 #endif
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 892f0ee..4abc621 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -20,6 +20,7 @@
 #define HW_SIFIVE_U_H
 
 #include "hw/net/cadence_gem.h"
+#include "hw/riscv/sifive_cpu.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -77,10 +78,4 @@ enum {
 #define SIFIVE_U_PLIC_CONTEXT_BASE 0x200000
 #define SIFIVE_U_PLIC_CONTEXT_STRIDE 0x1000
 
-#if defined(TARGET_RISCV32)
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
-#elif defined(TARGET_RISCV64)
-#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
-#endif
-
 #endif
-- 
2.7.4


