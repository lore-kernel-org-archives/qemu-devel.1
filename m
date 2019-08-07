Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68936C32754
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A13E22BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvkrT86a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A13E22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37735 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGf9-0002mf-EY
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdg-0000tI-Ke
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGda-0007zd-Ix
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGda-0007zQ-D2; Wed, 07 Aug 2019 03:45:34 -0400
Received: by mail-pl1-x641.google.com with SMTP id b7so39533936pls.6;
 Wed, 07 Aug 2019 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=nQ7UK1OKdebQtMPrsxLYHhQvl+uZqfEzMCrn6Fn3aRs=;
 b=fvkrT86aKLCi637bZxch4mA0FiY3iGkyn5bogmAP5xLRv7NQKq+waoeBeuYDVCdUUQ
 5U0YVPEwVa1cHeRyi5Eee4MDFqVWkxIUyPl6MrW6hOU+JY5rrkKF20vBIkgZFZObtu9T
 HieJA3+ZL2wddqlhZFdRf+vvX1Wdfg3/PCjh25LupC7cxWNCKurxa8aRdAv9FQYicOyZ
 zwYHrihQRoHkgTvbcBszDaWfK8QTWQEDYFupFNPdqDG2WC1rr9dGGUh58fNisa7+18o4
 z2RWCigaLuT1VDIfruHQ6Ean3JojiKIJnIeC8tmP4QQRTxp4Qm54+u6JKwqxEefnEtR1
 DE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=nQ7UK1OKdebQtMPrsxLYHhQvl+uZqfEzMCrn6Fn3aRs=;
 b=NhLNFfJ7WcRkLFVTN93IKQt9t4K4ClbRKUyxkrqeY6pdtHxmAMQVdsJS2HtKQNDInJ
 bWqYI83sSIgn86je8O2Ns6FmOZPvkBZkzdkoNNFa9zs9lRlqqv3Ba13yHJlMu49iUUA3
 ukxWEkyUgLfCUFuhFr/QQb98lbRXOzu3v7kTZufuc58zd7rN8Bf0hkfZbzmewMV88skn
 fePRYKwNUvoaYiMutO9MaqEZKgfaVQxWZaeVBaxRmMn5uW86NKfHJU7B+p5kH8+fbCoV
 bM3TjriCHfHNP6VTjjzT9oF18RHhy7gDQU1AQm9lVIHGiTiP55pRxCqzirL745W2C2tq
 2I0g==
X-Gm-Message-State: APjAAAWynFlQG2EhK9M6WgvmCrO6PC80otOCYIOOGo4CECQrewFiLAQr
 9sGMx4PdxF9LF9HWX72AQ4k=
X-Google-Smtp-Source: APXvYqzcFdDt9ASY+OKSmoqE0CHmxCu9w6Fz5QOpEHtXEAQOKxalBQ8r07tAdn10y8+62Wtgp7N9Vw==
X-Received: by 2002:a63:1908:: with SMTP id z8mr6375517pgl.433.1565163933582; 
 Wed, 07 Aug 2019 00:45:33 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.32
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:44:59 -0700
Message-Id: <1565163924-18621-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 03/28] riscv: Add a sifive_cpu.h to include
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
---

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


