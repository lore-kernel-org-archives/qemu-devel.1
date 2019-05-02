Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC30C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361C120651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXLPbXbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6y7-0006ma-Ec
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:21:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-0003Uz-Aq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0007z1-CP
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tY-0007UE-EO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id w15so1391130wmc.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=WXLPbXbpa4YNKPP7Q9n6ioTQgMR4oNJvnsy9Wzv4XLTV48k3pkF2pZcBsJUYnMokLQ
	jXNEHKFhyu1a98YClKEHpLUM8FmlX71RCCXdoV7+l45XZKMuFOIsHSLJeVtj/lnkgKZW
	ZLacKRdZdsnwzU2sSlgsxIUDtpalxycQ0Eu1n+lVRhkzQuhrEj4zSmIZo0AKPoXukI9I
	5MjRLf3kNScDKdqWjEXr82bFLBQQHjlgG6HUw5uZPazbJ1HdGB5TRTKHU0n+mDGljPaU
	R1SUSWJV/NsW/yglj+QBW+h0SYB+uoFHGYp6aoNKTJBLSNFtXkBjZ4C7r/z4EE6/usuE
	mQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=JLBT8cfRotp33l2whjuz1UutwcyLoU8hWOuPuGxi6wv8s0zMaNzfhb2ZgzYqdCHIA+
	yPy4A2eycTUXjBqU4NtNvVUVWyb52FyqgXBlicFupVj0YIU7olv8Puw0xfeXS3xMamfp
	Pt/JQs6Ma4A68xGCN9LzT+1liN+8n6tmuXYeYOm6VdR64dpuw6rGK1u/ETQlwU2Djw0g
	MCWRbzX+NkvdrddUko+BUKDLRA51aRlxHCmlLSscEH99V2o2h2xwVV1D0eefduKryO1o
	tuUoI3Wyv084SbzuJqIrplJO7L1BE4E0lCdqSMY+pWbU3IgJAJoAUqh1gvefEIWxOLj5
	7EYA==
X-Gm-Message-State: APjAAAUwTZvv0HV/ne1hgNwKJnGtZXBx3KUwy4031KiKMkIF0v3SWD84
	XmD0f5zMpqFFMF9am/C3PE3Mt4Fy
X-Google-Smtp-Source: APXvYqx97FiytTJe0nSmzbK7qmFq8HKDysBHewunWB/EhHcXmPHDVia5gJLLuobhYG/1HVDuJYYMXw==
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr1260120wme.17.1556784986217; 
	Thu, 02 May 2019 01:16:26 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:39 +0300
Message-Id: <20190502081554.5521-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v9 12/27] gdbstub: Implement read memory (m
 pkt) with new infra
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
Message-ID: <20190502081539.GnboQdwV7lxvtZLj95M-iaodGobAHTART7vDXQSVCyU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8dc2e1d507..daa602edc3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1710,6 +1710,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1899,22 +1923,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.20.1


