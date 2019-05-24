Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C98C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A353A20675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpVstYaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A353A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCqM-0006xd-Ok
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:14:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdd-000442-BO
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001zG-T6
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdX-0001uU-FM
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id v22so2498776wml.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wh9EpBdoOlG51mER9CpfFoTYwVIIpWsaGH6DJuJrlR8=;
	b=IpVstYaZK1HL36mbLGf9oGUIfmui1awanGFGAUmmwzUKGx/EDEgVKrWSxT3GdPJtt1
	raWUtRU3XhhHKdCLp6x2CTOlRtnQEZV/OfmTX8NaUx3XF9fMi9Sxtj45pbmTeUK5FftX
	BOMT61NXy+F9oG9qQyIQLxLpO51H9Vr+h/4D9TEeg6sEJBvYZY0QN3D54O4uPFnPBU0B
	p0ys1Bph3XQikEAvhuMDIzvwCnOMNOtVdkucEqMitBI+jF/Wpv3iicxPbKv4LrOIXWnW
	K7qRwj/+ObGTlrPsBHgayHBwL8E1bB10ZVB0uLP6iNVs0XmTl0rRrkUaR4jYnaKeifoJ
	qK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wh9EpBdoOlG51mER9CpfFoTYwVIIpWsaGH6DJuJrlR8=;
	b=o3BW2WlHpl5oYToysTd13q3mGLELZH9gLucp+TjDvfy+PKgG6zx+VSnme4o01F5tgn
	S03JKezP8MU3iVqFG+qb1hknbKnrnfQoeRX6hY2AHPYx0A6PN6pKvfPISC2oYRIBpiGD
	2ejRrH6RJeZB0vaYNrr4qm1bf1rv6TmxubiTzwsFjYhM/hvqcJEGvK5K22+HGsQJ3rkq
	GHyuOy68AWFqBGLhRwwayhgjYu37T1fn+kV5OzMJMYS0wIUn/5Zl4c3c5X1uNST0061T
	9Pp3sEWCTgYEdw+5DcH865CVDbU+LsRoqhKSxehyealNO30GW+xsukNzRmmbLjAItxW4
	bsmg==
X-Gm-Message-State: APjAAAUr6TshzlfY4gPULGZ1YZrcGAS6pVEAN5yMUr+prBArtS9AIuQL
	I3n4mEy82gszROp2ybdAtz4vILTJ
X-Google-Smtp-Source: APXvYqxWu+1OHXngz7Ir6p+lmOMY8zOBjhOsPV8RZbPKCG7KT2D+Keo+W3ivce3iG5Rfz+yVIakdmA==
X-Received: by 2002:a1c:9e92:: with SMTP id h140mr425471wme.82.1558713692750; 
	Fri, 24 May 2019 09:01:32 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:32 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:01 +0300
Message-Id: <20190524160118.31134-4-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v11 03/20] gdbstub: Implement thread_alive (T
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


