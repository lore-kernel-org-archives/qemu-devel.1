Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37813C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0196F205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh9RHnyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0196F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNLD-0007VG-Mr
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:13:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6K-0001z4-CY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuO-0005Tl-EM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuO-0005Sf-8d
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so17693653wrs.11
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MK04Gqk/QxrnoBt94M+4u4mfOZrim+/hfyCGy3IWRYE=;
	b=kh9RHnyfQtjbhdjwbsjvGI8F+3+tJsox2IsRO9ExW2zyRnEfTGzXmSaWyti6JvErIr
	aiqV99G1fRiWYadiLGDJI5iztVEuUd4i+RLyx5FA2b8K9kNcPAgu/Nnk4h0ZiudCiFx3
	hRbYp2ILR2R5ka4vO9BvOFQNZ2SsophylyFAJM2t5C04gTvAcAfkL2/A8lGTX5f4tiTe
	jE7CX6GEkqipKXM4BB79Bc08UP8AqRNIerXeCWxak1J/hNonKC6u56mMW9d/IqqQxMl2
	zz0j5tG1+ZZ4sBplq9B/hqelXzV1zYHr25O81DJ7AiAjC5glFBXpWUbcgVw1qHIDGUMD
	O6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MK04Gqk/QxrnoBt94M+4u4mfOZrim+/hfyCGy3IWRYE=;
	b=K7i5JRPapDlIQ1mvY0NQGgqhar0Nh8yAen2yuKy71RnbVj/oHjulF4hjKGE0Z/I4aA
	p2LHCM2ZxB6mX95A0G7t78Xj7Rf238ORSNq6tk52SH43UcsQl5iM/macx415VExPHuM3
	alB0NMyC+yTynoYGgMyrwnBDQb9FUVjyBgOpqkTJu65v7co3Zm9RMtU4sfQxN2V/Esrx
	+vZlTK965xmoZtLA0QTCO/FhY1641OSaWKC7MUbuMKC/rPUZbB25TsniShB8LAwfit5H
	u3ox+vd3CugAOoRp0QqDxar4ZJ0iNbNcYsGbVtzb8il3za6Hl/soEerwDMD1RZiokruq
	46Tw==
X-Gm-Message-State: APjAAAVL0le491AWEO+L3H5Xn1yLOlLMQGE0kIJKaBES133id9i6iNiL
	BV+uGxCMbU68u9X8RT/RTxKYFAn6
X-Google-Smtp-Source: APXvYqw5Qkv1dPNHxNa2C5bUbeuB4zPN92KSBwwImMwg4zkw8Gfv0Cc6htw3NdnTakq/nCoh8jVp+w==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr8709779wrl.26.1556131574782; 
	Wed, 24 Apr 2019 11:46:14 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:43 +0300
Message-Id: <20190424184600.8445-3-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 03/20] gdbstub: Implement thread_alive (T
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
Message-ID: <20190424184543.aFQErQsnsjOU_7_MM-7QQpf8QSWYyZ0xqT7UfpQTQls@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 952a6d92ef..7704edd69c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1508,6 +1508,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1807,17 +1831,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            process_string_cmd(s, NULL, line_buf, &thread_alive_cmd_desc, 1);
         }
         break;
     case 'q':
-- 
2.20.1


