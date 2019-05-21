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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21DC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8202173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbwk7DxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8202173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1f9-0001CS-Vz
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:06:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZI-0005rF-2i
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZG-0007hB-4c
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZE-0007d7-4Z
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so17800829wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=E6Aj38nujfg7uAklKeVMuJbgjPP11bdHJyXK/OOB26o=;
	b=Vbwk7DxEuELDnfexJV3Wpuwy8W4+3mykVAhGDD6XR/zzlrFsGqAh2umr/4LHBBtVOt
	B8zeRfGrwMAxrnwknBbrhFptptr4mbk+FO/tHvZRazOKlev496P/YMWiJe8wcOVK65Ys
	dSImT08GJYoe9zL3Cy55Pb9QfI777G/DbRLh8432Pn1OVAHNzlXj6bcq8PMh4JjR5Z5K
	4BWhvpMdqVWcCo1dtBz7HQrskCgHaLu1ewkWxVzxNO8oiFR4RacwXTLHIK2pTmjimTQO
	+RcYUEsa2b6R6YyRXWem1D+B+Igh/jytN5pIY0itLm8tJ4yBVQITl8eDlsY6uUygv931
	rLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=E6Aj38nujfg7uAklKeVMuJbgjPP11bdHJyXK/OOB26o=;
	b=CkuSOf5p7QaP3m7uRbTnQTTrxi1aZ+AhRjZ05X5/CDvavmaiVTL9CmT++sDa51QbUg
	09HxF+6cqMWqVhucQLHVK1/2LnsAtr5whtak2oVb9v14L9KifaWa349gBboOtMqVk5SI
	avchiGOiVmV8uzpmA6Aim8qIw36gBBZLn1c6E9OKJd6usBzqpzdgmFDrqA8O5FQDHDPd
	dYzkVoFdm7yoBP0noE4pzWSmq2jYXuIax36FZPy78maWsgpIEieuPhGqJ/+LirDhhX/J
	kngBr5Osjk+vKZgLwzIIBFvPBvTw6EcPTjLDeYRm+WZkA5GNX9LKagnCldlfeUDfcEXI
	9xPw==
X-Gm-Message-State: APjAAAUF3iDKW3ROyR/c9aPiqNH+RxDdulkIqvsxpWyK4EJCVVcaEsHb
	j/dTGlSoqPjs0kpCiQwWo9+ZFaR/
X-Google-Smtp-Source: APXvYqyiAhO19qoAnllyVpQ4BkeeCNryV5NNlvDhii62DmHaMykIlDHRkImXtjH9ax1PTEJDxqJLVg==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr5134678wrt.218.1558432818758; 
	Tue, 21 May 2019 03:00:18 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:39 +0300
Message-Id: <20190521095948.8204-12-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 11/20] gdbstub: Implement read memory (m
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c798d93e22..c957b0d8a7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1713,6 +1713,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params != 2) {
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
@@ -1902,22 +1926,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


