Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008B62081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5RvU9tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008B62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6G9-0001Ze-6c
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:36:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69i-0004an-Av
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69Z-0002Z6-62
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69X-0000jx-D6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id b10so1276248wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ezPihTnFxff66taoqz5itPBhvGaSIP4LZ9QfcTyLtvg=;
	b=i5RvU9tbgk1ad967z9+q7Ij40js3XRgLQW+Tgd18FnpFpEDAJpqo23qz0gS8Dhog0A
	5RccKZ5ajlJstJ6aOH3Cyy0UatIFZm8ZWN0E4A4CzwfrRb+G6sm5cKrhGLR4d9aGzqjp
	6Z7SnOtX9KeZ3HNSsdBRJDr+R2ex6+K3jc2R5p/HRh8Ro5vuOpzr4mAT6jRaYoqoEK+X
	Dmy66I0Wpo7wJw1hP3Rd8c/FTbwjExqyd71OwD/Tb1K0lalOlJr3RC2JeaYm6REV8NYt
	+f+OFBxy7dTtmHgV4cikTLS8s6xwb0gifyZzKef/Qqrr85tyqn7Qyrc7lD7qkO+ALLiw
	qxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ezPihTnFxff66taoqz5itPBhvGaSIP4LZ9QfcTyLtvg=;
	b=h21UC04U0uyTQo8vqL/W3CSDn+nrWRrnGtYU/e0UWuTMhZdgRlp18Nnh+NNXnDF7fp
	iaQztzzWjOLWSXyOv6i2S3miir5kg8P4m3qTpg5wHD0kP+qQaTLdB+wK4vylEvj/qxXQ
	BHs9u4GDOYWC/gGwB+SjgcIdKKrjS8jPeq4Fmu1/qkJMEh2bfFdjaGvt3GzhIE8JkgK/
	QlmrBF7fJG3bQfPrZWXzUYzS6jwv9u/aPmggsblqRBmzD0+IUagWkm4Xu/WeyUflqc2T
	JcXfC/oBvcT+1oJpQAZtqTliZRfwOpTyKOK6BabizblNE2ryayPZUHoh5sVg0HZeLsU4
	45Kw==
X-Gm-Message-State: APjAAAVONEqVrqtCff/FsULE5AAoCWGqLReHJ1Rat8x23hb9/p1jw9S+
	2a8sZ0FBYK2vgmJRjYHBXXlVM3H0
X-Google-Smtp-Source: APXvYqxgNu0Payw2IlQOkySP0YPSh4gItlN1MIi8W8P+uIJ3WwJxabmCJ62fZ6temkrx0N/mRPhchg==
X-Received: by 2002:a1c:1a90:: with SMTP id a138mr1173501wma.81.1556782053057; 
	Thu, 02 May 2019 00:27:33 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:32 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:37 +0300
Message-Id: <20190502072641.4667-24-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v8 23/27] gdbstub: Implement qemu physical
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072637.-NCAGU8gklE_JNs4ct-90eNPwoV7ajo4IcOX-uGTcoI@z>

Add a new query/set which changes the memory GDB sees to physical memory
only.

gdb> maint packet qqemu.PhyMemMode
will reply the current phy_mem_mode state (1 for enabled, 0 for disabled)
gdb> maint packet Qqemu.PhyMemMode:1
Will make GDB read/write only to physical memory, set to 0 to disable

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 00c07d6ec0..6daf779af4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -46,11 +46,23 @@
 #define GDB_ATTACHED "1"
 #endif
 
+static int phy_memory_mode = 0;
+
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUClass *cc;
 
+    if (phy_memory_mode) {
+        if (is_write) {
+            cpu_physical_memory_write(addr, buf, len);
+        } else {
+            cpu_physical_memory_read(addr, buf, len);
+        }
+        return 0;
+    }
+
+    cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
@@ -2129,7 +2141,29 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "sstepbits;sstep");
+    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
+}
+
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
 
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
@@ -2212,6 +2246,20 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_supported,
         .cmd = "qemu.Supported",
     },
+    {
+        .handler = handle_query_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode",
+    },
+};
+
+static GdbCmdParseEntry gdb_gen_set_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_set_qemu_phy_mem_mode,
+        .cmd = "qemu.PhyMemMode:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2245,7 +2293,11 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    put_packet(gdb_ctx->s, "");
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_gen_set_table,
+                           ARRAY_SIZE(gdb_gen_set_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
 }
 
 static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1


