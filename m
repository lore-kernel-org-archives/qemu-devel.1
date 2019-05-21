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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85164C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D742173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="higoBbmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D742173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1f6-00017t-Me
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:06:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z4-0005aw-2n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z3-0007LS-06
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z2-0007KY-Q5
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id d9so4894488wrx.0
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wCPlNOOjuBj+Z7/fbZOhYxVCeolCa7FpcLlxWgYcW2g=;
	b=higoBbmHXlVx/oWfq92/jaRyfYiJAH7jlRIrLfbnsbLr8s9CcewhWZd3vQwR2ddTY+
	NRWpuhkyVS6fm5hBL4FM/t83rX+2Yb40sZn3f/IBIWvdRdo2CqQb6ofjQlz9TPP5E2d3
	QIE1TfQvczd8G1gg5j5w8Sy93bPu/1hns+oL2vZDQnPu5BGHg951ElCdbdSBtcBjnxnV
	rzoZhkyrMzWsSQPLzMW8XZBdAY4RGxqwxZC2gNkElW77nTofy+nfxYwBTHUe+n/3e2wZ
	KCSdgNHAJ7nkhPrS/qeq3Rpsdta59Tn8gFc9LI5iHlXpNumyndKREYzllgxaplDHivgE
	qS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wCPlNOOjuBj+Z7/fbZOhYxVCeolCa7FpcLlxWgYcW2g=;
	b=j85WSquWhdYeWOf8Q/KO8tYCMTpXR/sgyUGfF5oMlhpzOnU06vVlq7K0otmir+SQDi
	k9CVVGaDPNs4rdLJV/BEmTTFqmBaXLrQemmdSq9x/DtKCNT0XCIXAtlKiW0oFOn7lXxh
	I3ZDcIUJbB9Mmd/duyP6TPsrh+3BZSQ39Pn2imbh4x7ip7m1ldbBhdBZKsPM1YPgO40k
	GC5FgsPKnnN0OKgK4p1l7Ao9z0TSdyR+nGwG0iK83Wgao1nxwu7yH1/wMkmkb7JhYp1c
	emmIja43c6wXLGGSCRQOtjlaMNSLYNjak+WxXneIXPIWrlL2KMJtRwaUKsxnkMt47YIO
	WcTA==
X-Gm-Message-State: APjAAAVLoFOFqt+5vFmmc9gLMIVASfgQvLn6xuPMI3xXaXBvq0a9qwba
	Fl9MUGAJ6CySmty/flMrv9tZsVMl
X-Google-Smtp-Source: APXvYqxdnamLLFUAM9E3yEif5e0AKN1O52c6Pi5/4qrLR6rNrVWRKqvPOOa3DazwSm46Izks9XCijg==
X-Received: by 2002:adf:f408:: with SMTP id g8mr21159821wro.264.1558432807727; 
	Tue, 21 May 2019 03:00:07 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:07 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:31 +0300
Message-Id: <20190521095948.8204-4-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v10 03/20] gdbstub: Implement thread_alive (T
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
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 307366b250..b4c4bd4b08 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1493,6 +1493,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1793,17 +1817,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


