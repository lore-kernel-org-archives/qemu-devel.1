Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A48C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E381A20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irxp139Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E381A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM77I-0008A8-4G
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:30:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YP-6G
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00085x-O9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007ot-F5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so1376514wmb.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DkxdB1SSP3ygac21G5Sl2UZoz/G9CYkw1Wrg+VlI4Ww=;
	b=Irxp139ZMKljG8THkEBhszOYzo3QX5Z7Y75xFX6M6UqhpBw04QkKvd6jKr8qEn4fpD
	Ochl4S5GDn1rA3mCphbXAETmJ64sCerkERiZKl71tTGnwTxwvIPfQ33LUjjP9wObzJVa
	gKsCvzj6r0jils+fbcUTPGgRb8CE2P+jAikp9U6j1Nv7/98FCBpbaC405cIbaOgpbApz
	Yukn70e1zx7vNUhDDKNiExUx3eMISHGmnDBFpHFtudP7ENVQJkFeRrb836YUUvTOjr9L
	J8LDR9Wx0Qhd0viY+qJck4DpnPMT9lWyfduFIQGVtS5zh6EYmBWGzwEop9sGEc3NFg+U
	+wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DkxdB1SSP3ygac21G5Sl2UZoz/G9CYkw1Wrg+VlI4Ww=;
	b=eJo0SyX/hD+zXe27a+FW384bpmhNjfXfK74Yln+g9N9pvlzWQ/c3FdlXhyqLHkwOSB
	t/qduYKZ027677lQqYDhIl7uUysKgMfRKyI4+MxY7621ODk7Olq4EycSkinhDxuqHysZ
	voptm9iKmFle+V1fKmSsTsi6fGtix4nZRli3N8efZ22n4v2o7789qnGNcRbQWcfXKR2f
	tAzGFxSu4jc9CFMewhDJetOTwwPPzZdBafaXDMJ0MVINy1Wzp0EwEtYygAnNCz9Q+s5Q
	JGKxCKEC9yn+ZSUaLzGgDiMoBbqHBnMi6TLcSKQhIIccsMFl6vciKzhuOi56BnERPRpd
	Wf+Q==
X-Gm-Message-State: APjAAAVpXPkXIefnl6f5y2xAwIhUrBvSEc1q6AZGWvVOZASa7Ea22qCj
	xZcU/vDKSXYz7d0xdRmYm6SXuJup
X-Google-Smtp-Source: APXvYqww2nVnlKoSjNaZp0o8YMmbUNXoDxJroOI04BLexpfBg+24La05NLr35TpssCL0A365sUVC+Q==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr1344235wmc.12.1556785003232; 
	Thu, 02 May 2019 01:16:43 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:42 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:50 +0300
Message-Id: <20190502081554.5521-24-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v9 23/27] gdbstub: Implement qemu physical
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081550.3CpG8PHbxBUJFreoiAjb-o5xxgxTaleMHdNsBIFCIo4@z>

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
index 00c07d6ec0..88ff6224e6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -46,11 +46,23 @@
 #define GDB_ATTACHED "1"
 #endif
 
+static int phy_memory_mode;
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


