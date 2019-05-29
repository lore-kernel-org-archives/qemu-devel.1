Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580D9C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2390C21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm04gVdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2390C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsot-0004iM-9i
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:16:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsI2-0001EL-J3
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsI1-00037l-GJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsI1-0002zc-9H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so682539wma.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KoGMDinYQHodOIbKXwJ/At0fSWyzS9xNAHk1qWOol/Y=;
	b=Xm04gVdb6d47qroLNMeVkNI3fzQAhUYv3GAleOVr//GuhCF7RwVNwpfHzJtLo7+9op
	iNbqp+bdOLyinH/twZOq1A8Alv951lX0B2ROv0tWwKQ7I8Lsg5uK4e+X+1eZJC879Hi6
	SWrSvEmuZN31YAlA4PiLKT4M3AGZWxsxeg5PsYxjMhpZ05HMQDbUNl35RBCAwUPihmad
	MGpGsdwds1EwXVMECwIs8v9rG0wXbFxDA9AXvX8dHT6zIHQTP4c/c7WdXCewlV3ASqnq
	IEN097XZK3usrdDgBCLFWMzx7HXPfJJpS+PJh2WjKuiwh0Byclk6EZ7b2YIEFewJCyhi
	rO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KoGMDinYQHodOIbKXwJ/At0fSWyzS9xNAHk1qWOol/Y=;
	b=cIdeL68JLbGoAt3VTgALe+nXlzPcbuObAlPfBdX2CODGwovlR1nqNDsCUF00KjRy0u
	bsMxW9YQb+NNlwlm0Nwcf2kOnfqf307ojwZwZ34yziAmIaQDafT7Fx1DbJQh1Pp1XxiZ
	xSLJ2Xhx189WN0R7/OECz8fZl64sdhIShCy2aDQdsk5BctuHVq3QVeDoy3hyQgx3Ogom
	w5wrt74Ele32KTfe+0TrQqOOjIctbU6QcVNjBLmLOAWCo4IY3qKHOM96at+UmdwVp7qW
	fo8tbkg6QCuOBeCjNPkXHSESF8aDRxsv581pbf64C6PfsDXlBUGOqeRV/irLkzeCDk5o
	xvJw==
X-Gm-Message-State: APjAAAXupC4DvyeGuYOst3k5tPf7b7BTD/gOybsB88xKdG/zPQmY/awb
	PFHT7ySGQoiBaJU+gFrM87+CJG5P
X-Google-Smtp-Source: APXvYqwZvV0+sTiIKaaghXnlHiQ4iINiV5otlgQKdKCj6+lrmCvyeiJps+nRnEPSifXSBVCgmYJPPw==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr5794829wma.27.1559112140264; 
	Tue, 28 May 2019 23:42:20 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:48 +0300
Message-Id: <20190529064148.19856-21-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v12 20/20] gdbstub: Implement qemu physical
 memory mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new query/set which changes the memory GDB sees to physical memory
only.

gdb> maint packet qqemu.PhyMemMode
will reply the current phy_mem_mode state (1 for enabled, 0 for disabled)
gdb> maint packet Qqemu.PhyMemMode:1
Will make GDB read/write only to physical memory, set to 0 to disable

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a0ff0017f6..d46e21bf70 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -46,11 +46,27 @@
 #define GDB_ATTACHED "1"
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static int phy_memory_mode;
+#endif
+
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUClass *cc;
 
+#ifndef CONFIG_USER_ONLY
+    if (phy_memory_mode) {
+        if (is_write) {
+            cpu_physical_memory_write(addr, buf, len);
+        } else {
+            cpu_physical_memory_read(addr, buf, len);
+        }
+        return 0;
+    }
+#endif
+
+    cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
@@ -2132,8 +2148,36 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "sstepbits;sstep");
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "sstepbits;sstep");
+#ifndef CONFIG_USER_ONLY
+    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";PhyMemMode");
+#endif
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+#ifndef CONFIG_USER_ONLY
+static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
+                                           void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memory_mode);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (!gdb_ctx->params[0].val_ul) {
+        phy_memory_mode = 0;
+    } else {
+        phy_memory_mode = 1;
+    }
+    put_packet(gdb_ctx->s, "OK");
 }
+#endif
 
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
@@ -2215,6 +2259,12 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_supported,
         .cmd = "qemu.Supported",
     },
+#ifndef CONFIG_USER_ONLY
+    {
+        .handler = handle_query_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode",
+    },
+#endif
 };
 
 static GdbCmdParseEntry gdb_gen_set_table[] = {
@@ -2225,6 +2275,14 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+#ifndef CONFIG_USER_ONLY
+    {
+        .handler = handle_set_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+#endif
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.21.0


