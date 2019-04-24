Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5FB2175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqiXgw0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5FB2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNJJ-0005dg-8T
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:12:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6E-0001z4-Af
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMug-0005sH-Hq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuf-0005ll-4S
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id a12so3312849wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=M+yhf0GRNa4d/DQXAVVJ7qTGXubOanaL8giDXjKc0rA=;
	b=qqiXgw0JjPiPCh+d0fvaUjEhv2doUaoNMz0sguWiaNaT2WSTCNx9EmY87UYAEkTisz
	+IxFunAjRV27qv02sDU+t3LggY/k7bQezcFmdewi0V7CakAtRjDtVI24t2G8JiNW35+k
	cun42pS6PvO/FyA23NEUir0hFaFgrTYGjap68PfsFY5XgkfCtZ0YXoe1Gzw6PWfL51ql
	V8Pit7+2UBhj4leQJ80dIVLZvZkaUU7ORcrJ5w/y69Q1qneVBwVcYZ5eeRw43YAYheRk
	avkQEcsm/CAmt5kHWg0pEA38oz12PsrBHTQyGyKZUcm1x0M5cWNZSVLonpxrnSli9A52
	RFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=M+yhf0GRNa4d/DQXAVVJ7qTGXubOanaL8giDXjKc0rA=;
	b=tU89ecVVyT3i/J/cO6GMTswpbIuXDE913wK0wyAi5AflkEosEJ6H4tHrl/XGexSz+/
	jtOnwD/ZmWu7Aj6f4O90nCXTBSca6HYNDBYdshH+XNm7pWyMTBVgFWeg5CWH0roQV+Hv
	CgkkpCbo/iqW8+jy6v83UhL0Psn+HmWhKHsarC2nTutyldFPosUHFLbolCVcJ9rvUh4F
	+j0De/tCwFd/n/tYJoePHa0OCowhjkJqpq2AO0q4401nbE7WZ/d2YJrzoa6E6su3nQKP
	7vNsxJEOYiBUwU7zfaYgGptSWeHLgOhe9T2ZtBOlMQx9VHMaIvLtxF6N6QJo+qBf3dS5
	70jQ==
X-Gm-Message-State: APjAAAXMd5PyL8d1uaDdWMQXQnhGFPwTZH49zziYa56gxHIeYL7DNsDA
	l8voaRVJFGAQNYZtv3WbmdjG5SY2
X-Google-Smtp-Source: APXvYqwkI4UBMUJRsoQmi8gSLysEFsPFHsp93mzhQ8ohLgKUOY7kJ2Hf1nKOPQ6yF94WbkMRvAXflg==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr11601859wrq.22.1556131590205; 
	Wed, 24 Apr 2019 11:46:30 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:29 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:51 +0300
Message-Id: <20190424184600.8445-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 11/20] gdbstub: Implement write memory (M
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424184551.tIcSN1K-Kf_88N_kDoTHPg52DXsMQMTnXVUcTZIGhUI@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 58b665d303..f29042cac0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1695,6 +1695,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* hextomem() reads 2*len bytes */
+    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+             gdb_ctx->params[1].val_ull);
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, true)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1902,24 +1927,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'M':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (*p == ':')
-            p++;
-
-        /* hextomem() reads 2*len bytes */
-        if (len > strlen(p) / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-        hextomem(mem_buf, p, len);
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
-                                   true) != 0) {
-            put_packet(s, "E14");
-        } else {
-            put_packet(s, "OK");
+        {
+            static GdbCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_mem,
+                .cmd = "M",
+                .cmd_startswith = 1,
+                .schema = "L,L:s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &write_mem_cmd_desc, 1);
         }
         break;
     case 'p':
-- 
2.20.1


