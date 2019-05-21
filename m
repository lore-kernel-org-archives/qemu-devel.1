Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDED021773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uj377cmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDED021773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1pB-0002bV-0q
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:16:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZT-000607-45
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZR-0007wm-PF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZR-0007vV-Hx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id 15so2208026wmg.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3B88NpQFOs8DC+2595MWdyNpg+oQZ5roeXs0f+YNp/4=;
	b=uj377cmovNC3MowTVujPc6sQKKALoIIxOMeue2auAJvlqoV8yonCzPxqLQlRpPTN0C
	ITNCsb3L5QqafH0Ie3OSIgKphCZx084dzi2Mzb+VlyIwVrryz0b9gsb5PwaHaTPGodzz
	KX5AiksawrPKSp1n933M9WdXM4Y5dVsLKnIRPy7zQCwQ3zKQ7vn17yk8jgCG5rfw/BrA
	fQOgbVtv1rdsX+iG6XZoChoEfUZ2/Lo4bijcPrACAEUjL8j6iv/ZMBXHTcb2m4xp1GBM
	QEOONFdcKZC6HpNaMnLvd31pq/Vt6T0wHULL0yy7OrecSeBXub5Z8vY7KvR2WM/Joyl9
	vZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3B88NpQFOs8DC+2595MWdyNpg+oQZ5roeXs0f+YNp/4=;
	b=JdRBYqlRouy+KNpZ3hr49j1lnPp2CXb1XzSbxT+epBu3Plw72H6Nl/D0GpIvaOUalT
	pjxPxCWsvalfvc7M2CWQ54nbokESPMNuyBQdnPhqOgkMZqYesR67nwEPTdjIT7YUpa7B
	iW90I6NnwHTUtNEOtB0lI4L+MZg87+gPZUl8HBtD4ZreGQex+B21v+0A+L6cEp0QsmWw
	Tv7MLdqALo1Oy6zHmNEmMMgygnATV7XklRXMWmQMGeh6FH/TA5TFARSo4c4Yw5gauqja
	c9tjtGyBrkTiwUb4FPwmuDKbI5cTjTnoxwSqgwIiVCUFvIjHJnFZVwlC1VP2pVdxmnxG
	9b3A==
X-Gm-Message-State: APjAAAWGHPNCms3/41PvIWx+bUi1TuGd3TnIB2ONHLmqKEauogBwWrjL
	CcSp7ULg5yAKU6ZfN3QKl41KGXcX
X-Google-Smtp-Source: APXvYqwBMYC2cUwd/ype5NAqAB60UJEFVmeDNqJ1rfi6dcHCugODJZ9tyy3V2ahfBeOYwfbejMFOaw==
X-Received: by 2002:a1c:4486:: with SMTP id r128mr2862041wma.90.1558432832464; 
	Tue, 21 May 2019 03:00:32 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:32 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:48 +0300
Message-Id: <20190521095948.8204-21-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v10 20/20] gdbstub: Implement qemu physical
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
index 9dd934a079..c9269319d8 100644
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
@@ -2118,8 +2134,36 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
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
@@ -2201,6 +2245,12 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
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
@@ -2211,6 +2261,14 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
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


