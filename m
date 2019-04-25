Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE8C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD6A206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLInGwCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD6A206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeV5-0004NQ-KJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:33:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePE-0007vO-W9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePE-0000Lc-2C
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePD-0000KJ-Sa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id b1so19006421wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=38LnIcypIDjektyoZrBn3/LYujk4iHNznA1yMdifAQQ=;
	b=SLInGwCHS2AJXE9JsEM6osK40eY4yqqIv5R/9G0bybLnxQIkZ7mzIPhyPOx9+9ZJ8H
	7TfsDmqn3vyQGertoQqIImFd+3pIlnR3phKEvGZgjxS+9ME+Uwjx57kjk8y05F9aKb6O
	F7bRZQ2V3ZJ9vESq9/hxB8Lag51ePbIqngkM21hIJrZocQOChKEam0cY5wmK7RPWyt+W
	PSN3D334Zjp1zgrxC/NalDZEI+P8I57SuGweLy8KyDa+RTGan2LT6N3W7Uy82wSETLrr
	BzUHNKdMRlY0j1ui0vTpYch5U7HUpKNDe5qZjuhyIewX4GVaEfhbB/m2jyJipOQ0YT4n
	tJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=38LnIcypIDjektyoZrBn3/LYujk4iHNznA1yMdifAQQ=;
	b=hTA0sj8Pnv6N0ihGFhrlhpOLSZX3PQrDNgHscZS+JKv2RBymtuzXtqJZ7Mf+hahwJW
	k3TkVlRizGvf2i7ebrjdUd+IBY1CyHVX921yObdGAEyxuCxYZLvXFk2qGAhgICT++BpU
	aeldwijthAp970anU5fXg4hYegBU0LGF8vgV1YP9Rgny3W9VNwoea16jIxXH++aeZp77
	QSlscXSiMFHJ5PA/HlEycyx/sD2K/KXR3tFGWH7JeC44mwzVMJJSHA2NVMUlddy4+HG9
	54WoXy7c92QdYhip0CFeiHkzSfnlkpFskFDvMMND9TyzPcDD4GXU9L2Xq0wsSFOgzKG1
	od4w==
X-Gm-Message-State: APjAAAUA3Q8Yu0gHTZvNHZsK0aTMN3j2euv+/VOxQoBFrWFm/pU1pEFv
	80N1sVuxCNawdRvtHsCwTmgbIZuS
X-Google-Smtp-Source: APXvYqwyMZLL2T/WD06/YLGIXQdadpi7pFh3wLTbRd7Se08BIuJYl+Wnl+EMn0bF0vgc7JIE5izwRQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr25490860wrj.249.1556198832793;
	Thu, 25 Apr 2019 06:27:12 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:18 +0300
Message-Id: <20190425132636.31636-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v6 03/21] gdbstub: Implement thread_alive (T
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
Message-ID: <20190425132618.yJsBao9CdpY7GfH--G4eZxjt35_08iw_fcwYSO7xmk4@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index fdad1ac466..29ca6be3df 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1499,6 +1499,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1799,17 +1823,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


