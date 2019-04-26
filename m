Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A97C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E451E206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuxftqfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E451E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39253 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJswA-0002dn-3e
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:58:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmm-0000dG-1v
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsat-0004GT-C9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsar-0004DS-Ta
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id y197so2376235wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=GuxftqfDBOC6Gh/IgmEfBv1W4NhNRan/qGK3Dw5MJKzDR69QPEUivIShut7Q7Axv5d
	LKh7QfQq9c6M60hcAgxOMxUeyjEjwAuVFqR9j6MYmF06zjoJT2KFjxHqViZmXJp/ZL01
	xP8wxFFZwHm0XjXTyMgO++xCRLbZhYdFCmaJSPeQlGOOETRqQQ/4gM53bFpeCsZOxFG4
	z2rkIs+OWj5DdwLn1nzt3xAQgo0jKiUpkaDmJwkizn2FaTzezdh7IvGXF/TWJJV/tw25
	hUUeYx/fSkksiQd32hwBEXvT/T8loySXGKbUvr4xRhcDK0LPNH93hcQLAAlg3MXTeIhu
	pUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=CMbpIzFDYj3nbA1E9aKA/K7yCB75hlD271s/rnQVKcNAMhVGFsDbcuwqsGrR4r8GMX
	QnjyfklMsA0n7mI8oG1uWIBY6qL8QMeYECzajjdcKF0SSoBkwhcFTkI0Ecm3D96/Plah
	v+ceHwtznwqvtb/7+cm6bFhd15AqpBAlniEV/EgRj0uW3nEvQTlCiQhu9zWU4aj5Cbwf
	NNLABiHbavsMEW3ZO/Oii2IOf91EaO/mfnGxsporgIRFNuNBC763DaASJ4baZB8Lh8bS
	ctz3rEqBtFfsrlQJEpVZ4BPRQveTfwyMbBX2Kf+5+OBLorzRLQM6YL54lzRzudWjN7N0
	TFFA==
X-Gm-Message-State: APjAAAXOFwAKEmJOMYhtnQbRmHbH0fZmLQoCM8R49p+B9Giu1zaxMgDH
	BaP/3RYEA7gUAF41WfSmD9omLZol
X-Google-Smtp-Source: APXvYqwifvW1CP6iF7M4v4S4Du7nNXfC0gtBqNcSoi3t0MIFYMiTlpYu6iA2UttVNjJeMUSrhdCVuA==
X-Received: by 2002:a1c:a103:: with SMTP id k3mr6221401wme.8.1556253372530;
	Thu, 25 Apr 2019 21:36:12 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:11 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:40 +0300
Message-Id: <20190426043558.6888-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v7 03/21] gdbstub: Implement thread_alive (T
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
Message-ID: <20190426043540.31WkgIVUn16aGKACPOKjtjX7sP_8h6nXiTU1RdpoIrI@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 621d689868..c47ef7dd9c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1498,6 +1498,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(s, "OK");
 }
 
+static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1798,17 +1822,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'T':
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-
-        if (cpu != NULL) {
-            put_packet(s, "OK");
-        } else {
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            cmd_parser = &thread_alive_cmd_desc;
         }
         break;
     case 'q':
-- 
2.20.1


