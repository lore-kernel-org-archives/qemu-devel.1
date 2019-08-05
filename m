Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17AB20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7THoYgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AB20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufXP-0008RY-Ux
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPv-0000nb-LG
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPu-00037O-3U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPr-00030h-TC; Mon, 05 Aug 2019 12:00:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so33750648pgc.1;
 Mon, 05 Aug 2019 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=n7pF8fB0WXPiBzqIF3GALSuGpVHl36mKtNGP2o/KXGU=;
 b=h7THoYgSVwVWU7zA+jpMbz3AN1oFtQTsO3UL9foqnyROiNEYDbq0z0E5xLfylQeo/a
 VfbL1lYla9sSu2glVPzIHFraWsft48R4DzHRb260CZB/Ra99mzWxaUr6pfznA9Ejqiku
 aFG6iB5UVpAMENeGH8WiN5pJrfnwFQkt+fqUroN0AFJiCVqjw8YISsFvFxFvyjsVM5O8
 ESEQ3ZegbAaINj2zuNQ1T3txHINppVcuZSuIi9j5UdGu6ciPTIYYxWNAIJnCPExsqnfb
 9fM9t/IX+oB1a8diLPneOWrdHFGwcO4pqKXFrdXVpx2Nd/3+zIiOTITm+2C8+Mkajwb/
 sRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=n7pF8fB0WXPiBzqIF3GALSuGpVHl36mKtNGP2o/KXGU=;
 b=IddXyHrxmv/S9diQQ+CEJrr+BLxOlw8jvlw8mp+frEDYxXJN9ri65zXtOpNT5bAY/k
 JVtCdtJQ2OrEN4J68dG8GiAJb47J53P0zYeKoWcLbqr2Kl1fUESD/qCmhip7MkfuDf9/
 RJdfjcihpMh3bw4s4drLseipMyGsqAjnSVGkEYfGLpGxMPLL9yRm2kJw0omUSMlsltwO
 ZTPKHcqLyWpQuhzk1XHkUlasMdKfwil5+plVy8AFagjWKVE8SA5NkYi3RMRc0UEIHa4G
 R3uIBVMAWjI/7L9W/IxMrFSD+J2kjks7h0rgXRRgAZxTtYuIsXS+qGdl/xElCN/a29Lg
 F50A==
X-Gm-Message-State: APjAAAXghA4BHbMzW+qmNNN7U6/RX3qeIHGdRGwmEEznPqt2gO8rQJ7Y
 f11dG1QwHHwBn00rj3t9Ubk=
X-Google-Smtp-Source: APXvYqysT/Jopi8/rGV2wkOLuqFk9Iluz8/mY9rf+JCzxeNBYdGjtFHBBpM8ku7hRcb9AmcQLbCgqg==
X-Received: by 2002:a62:ae01:: with SMTP id q1mr71952955pff.219.1565020853139; 
 Mon, 05 Aug 2019 09:00:53 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.52
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:18 -0700
Message-Id: <1565020823-24223-24-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 23/28] riscv: sifive: Move
 sifive_mmio_emulate() to a common place
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

sifive_mmio_emulate() is currently only used in the sifive_e machine
codes. It can be helpful for other machines as well.

Change it to an inline routine and move it to sifive_cpu.h, so that
other machines like sifive_u can use it.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_e.c           |  8 --------
 include/hw/riscv/sifive_cpu.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2d67670..7e0fe7b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -74,14 +74,6 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
-                             uintptr_t offset, uintptr_t length)
-{
-    MemoryRegion *mock_mmio = g_new(MemoryRegion, 1);
-    memory_region_init_ram(mock_mmio, NULL, name, length, &error_fatal);
-    memory_region_add_subregion(parent, offset, mock_mmio);
-}
-
 static void riscv_sifive_e_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
index 1367996..897b8f8 100644
--- a/include/hw/riscv/sifive_cpu.h
+++ b/include/hw/riscv/sifive_cpu.h
@@ -1,5 +1,5 @@
 /*
- * SiFive CPU types
+ * SiFive CPU types and common utilities
  *
  * Copyright (c) 2017 SiFive, Inc.
  * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
@@ -28,4 +28,12 @@
 #define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
 #endif
 
+static inline void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
+                                       uintptr_t offset, uintptr_t length)
+{
+    MemoryRegion *mock_mmio = g_new(MemoryRegion, 1);
+    memory_region_init_ram(mock_mmio, NULL, name, length, &error_fatal);
+    memory_region_add_subregion(parent, offset, mock_mmio);
+}
+
 #endif /* HW_SIFIVE_CPU_H */
-- 
2.7.4


