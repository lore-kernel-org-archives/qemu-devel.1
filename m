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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F13FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE4D21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr7yztZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE4D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1jT-0004ib-59
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:10:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZK-0005tH-24
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZI-0007kb-BI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZI-0007i5-1M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id w8so17871021wrl.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=sTjfnnpm3Bx94qjSoGjXySgN60zY4gcLRdNYCyC1oso=;
	b=Zr7yztZ9ghXv1M+ryNqIrLH47NfWgKTXlVzt82jF72uq/rWWWqIT8QVR0fqLoHr25k
	8h6YG6JsVDYOj4FsXtLj5ygZ8nn5eRmHSr8DM+t9USxYFe7MLrmy8L8opCPlR5JFvbV4
	969xLPCFhhFKbQpEhw2uMF+vGjeQM5wQt0qbYV7J3vV3cKsc713gJWtl71hM20WRwdkn
	cCmPljr7coWxxEwGOWvdUCXF/qdO2ZyllJW6qVZ76s5CqilKhBOsqSk2WhWlCAQ2+1lN
	PJop7GgV7uMV2t84GEAPI+iuF6lX7dz9W9UGd1fNpGwxXgoudjxHK5RmHE7Hw6eV+0RU
	+saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=sTjfnnpm3Bx94qjSoGjXySgN60zY4gcLRdNYCyC1oso=;
	b=HkJfa7EZbsOASevQE0vTR+KR4URpArNB1mLbLCD+0TypK67+LHNj/b99JC/mzSZVX5
	5ACTwAdYQUoe5RUuYR83mGYqP/+nTx5Dp5oa2cT5rgGiQsUeIekB5V7iGDyP/3OBkUjx
	3JjgCD+OLDXGdaiHY6ZRhE2ynTYdOyg2HW8qAJ2lgfd+EB6reniU1C2gwBfmXgYKDNH8
	FERERxZ/Ki493cr2ChKx3fWijRjr9o+TRl08xtsbW47Kh4BtEV9V1GdQefJDH4Jk+xLM
	7WZ9NdNNHxU/+sKDyZnezqoF6VWFOb9ow1DH0uDsGyh4kQ5UmWwFcGhjbD/cWPJhbEy6
	20XA==
X-Gm-Message-State: APjAAAUY3/ZYQklc87hb46k7XvbgIOFUR0QntPy7b4yxcpVtn0aO/skj
	+luoN9uiHG21KgqQR8BDwalKsQEa
X-Google-Smtp-Source: APXvYqxHnj6BpenD/6rmiGKCthTrKy2sjRsotgCJXWW5iIYlLQTqFnzHVX+bwhmPvOk5l6gppWl8+A==
X-Received: by 2002:a05:6000:43:: with SMTP id
	k3mr49099255wrx.234.1558432822124; 
	Tue, 21 May 2019 03:00:22 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:21 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:41 +0300
Message-Id: <20190521095948.8204-14-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v10 13/20] gdbstub: Implement read all
 registers (g pkt) with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1afad31b49..781f5882ac 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1760,6 +1760,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1767,7 +1782,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1926,14 +1941,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


