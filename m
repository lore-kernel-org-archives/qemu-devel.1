Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F92E20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2LxqWcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F92E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCNM-0000uz-Tm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB57-0008Sl-HN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB56-00060X-Am
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB56-0005zW-3w
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id c66so1283495wmf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOqWwiE90nOP0TqVRDm/szto9/dNBu2y2hfwpJ0rtGA=;
 b=i2LxqWcZ7DwLaQImdxxzvQ28zftWMViFa8EQUTDemYH6FXhhiitHW6BUSTJB/DC80l
 /e6bhOy9L8nSLPXfnZJL9JTUPPTHLXbzyEBLNOArHrhSfHC+lhAf9VVH/g7C/GhAuqum
 zTWTO0kV3mcuub+w0d9b/WUR65oinfwxyUZ+LhQwPxpQJ48bjF87dD1t3p8XkrydxH23
 HpxlXpfwCHuRpROg8lKaoHTiV0VjvHZAkjIp9RPGjhiWs3RxAyIWiwouUYIk8NmNeYxQ
 F5cO5ThlzCHBrD0d+gJOkz7wgV080FaaIqCW2k7FEyCO+I8RAUC22w1d5eCA2wgqx/B8
 Sb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nOqWwiE90nOP0TqVRDm/szto9/dNBu2y2hfwpJ0rtGA=;
 b=g3+gx7sEKmhg1fGUuOlHnaP17AM4Nuo9ih9EqOvxSpstRc7H+oFi2RNbZWd7KCk7R7
 GcEM6aD/D5T6V6qG3r+SqXIQXGRVKpFZBGlgFhld0LTEyJ0XB5oZiF03tzC9tiCGrIpT
 SdKLRo1PwNW4bG/xn6OfB3YjyWACXz2KlCFoJ1dWkJha1yB4QoL1nxR3QlzrzNAS5RKb
 Cl1IfrIhpB+nH60ETELyQYh9NJ4GbFVwX3FgT79n42exFk3+r90w5d+1Z3qgwHg/yhkv
 crPnTlU0+Wy54CgwPUsJcxQbD23K+ZGkVhduYeaFPl40EPfdfdrTgV1C9+EEK77f365E
 lGFA==
X-Gm-Message-State: APjAAAXRZ6jtyf3ELtMmMsPIPjA97Mlny6C4elQ4pmCh3MkxhxeyJRNc
 f7vJL6GB5wIxbcnFUvXRhapwEQ==
X-Google-Smtp-Source: APXvYqy3osjV1AzqBhJFNAl9SCEzXrCOnllGEpCB/ZLGL/9fUWkVthbXYrlq0i7kFTED3NRR9wu8Pw==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr3064686wmf.127.1559899358974; 
 Fri, 07 Jun 2019 02:22:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a19sm1282324wmm.46.2019.06.07.02.22.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 280DC1FFCB;
 Fri,  7 Jun 2019 10:05:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:51 +0100
Message-Id: <20190607090552.12434-53-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 52/52] gdbstub: Implement qemu physical memory
 mode
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Add a new query/set which changes the memory GDB sees to physical memory
only.

gdb> maint packet qqemu.PhyMemMode
will reply the current phy_mem_mode state (1 for enabled, 0 for disabled)
gdb> maint packet Qqemu.PhyMemMode:1
Will make GDB read/write only to physical memory, set to 0 to disable

Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20190529064148.19856-21-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 12671e6e11..14a9c22f5a 100644
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
2.20.1


