Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D18C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B262077C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8OFhFWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B262077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNyN-0007JY-F5
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:54:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkG-0003vP-Ru
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkF-0004BQ-VC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkF-0004B4-On
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id b1so15440854wru.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3i2BqbPIZu3pJ1q7oaT6KMUZ5ADbICItlHWHixBftQQ=;
	b=u8OFhFWm6uYyTjr4rYrFv5i8YcMjEfHDL72cjZC/fIQE41vm4OcP7rGDMys8DNEFQW
	oyGEFj/8zmxepKnOJcX577betrUg1RM7O05QXDYMUFmtY2xNBbdcYL9dhgbBTfMKJPoz
	a+lNC40CICLQjXaBk1abZjGurUrmTUmAMkt7m/NUqhVucMf3UaDR9polNKnY/Php951g
	5D8GKo/7tLOPw6fS+enmHvvW8Uj7ibo5vaeb2RoKH8Xfv8d2vQgBGYav8FWcIyG7kwC8
	phi5DHWcMewSD89DZDp0jPTvntaigphwInGQaUNtRNtzW3uNMhRDJWlnLWipuAhlk1P3
	BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3i2BqbPIZu3pJ1q7oaT6KMUZ5ADbICItlHWHixBftQQ=;
	b=RPCoVCW6w0ySwGvu741H9p/4Q4U8sbRHJd5D/dTtkquCJll9T6+zV5xbNEGfgLTTvJ
	izaUDkaTFA/hjvWY6FWnCFuYmKEZgnBC8e+NArh4u2B4CB2AHRjSwY2T4OVCWWSRdrkk
	1vZFnOPxbQdbOK9jEPjL9j614rs8nVvBeKGTmlgJsSNSKesgbtn6X+3VIogsRmONrcP/
	oUaWZnrr0zZnIP3F5cQYR7s3X11IjuoMA80B0nCzVR19qsZZQS/GuPrAn/hWW6xMgtSJ
	1/tLEllTwaft7D2jULBFsOAFr82ksR9cHr0QPxbqIMeZsFlQgHfL4fUcEVL09bPmKUIF
	A53Q==
X-Gm-Message-State: APjAAAVFim7evtH0BOVxOvxIhEYtFAfIbXBfv4K0mW0hRzZgQTexRvUB
	HHQhiS+Cf1YzuefJqIierA+uTdrH
X-Google-Smtp-Source: APXvYqxhVt0TDvVf5bNDkRnSzsc5ulISIvwhIRSBHfBPyuwa3/aBnA7UFqVf4tGxfqynyWCiLbYyFA==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr8394607wrv.318.1556134790004; 
	Wed, 24 Apr 2019 12:39:50 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:48 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:52 +0300
Message-Id: <20190424193859.31817-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v5 14/21] gdbstub: Implement read all registers
 (g pkt) with new infra
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424193852.B0xBAQI2qAWbydUjzTDX3XACfQIWuPFVdYmM8fkCfTk@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index acf0e75908..3a7ef5eea6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1758,6 +1758,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1765,7 +1780,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1924,14 +1939,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static const GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &read_all_regs_cmd_desc;
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1


