Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2B6C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345CA20652
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfx3Nuqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345CA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNsS-00031O-Bl
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:48:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkJ-0003xA-6U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkI-0004Cl-6b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkI-0004C3-0E
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id h18so6740474wml.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EG9sk85M4LsflXbUNBRhLCHZfOCHF6EVSbclOy8vwek=;
	b=tfx3NuqwR8oWHl+bhJbg+JjG5q/jApslB7GiBNkIvGYs3VpDsIJ9Vz/YPVK5e+gKq4
	PLrOpB6gRD4lEvYfaXlFNrS+1HkdFSTC2AVYe4ltiN0DKz9jIMJwv+Ko2g9GFs1oMnli
	qJdpoYXOaxt7AnM5Hi0q+TTZD7MKPmSmMcpkWZsK9hhi62E8bD4oraG5G9irI0WXEgmG
	FjfBImDN+co34QxpYXWPAwOFTWgCCvQuD9oCHPZefT87Q9Fyi4JCQo4Cjhv+bu2kDKUt
	+GiJu1UTK2q4kco2pON3tntsIl+p/rT+gUUp7DPpiTL7+D0MNhPbXifWWFSFA7jee80u
	A1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EG9sk85M4LsflXbUNBRhLCHZfOCHF6EVSbclOy8vwek=;
	b=c8vYLHVtUyw41ZSIFioR+3sxHcCoDpUPsyObDUdFolofmThjWV81J05by7epXQNI7V
	D2rRfHXy9RF23qASQ+DiW4vd87lP/YPlwiDekoHCVzkb6XiD8oQYZRmL5MOuKDwTxktF
	UoLI+OwYZ5WT5fZoPAM52Qjsv1dScMCtJFgfHZJerpOzbi6tsupKhZmVvu+pDmppFMR5
	QNYPxV/ca7CFBIVnQnFMydXntBGbCB+1fl+JfZIHxWPH96HFSmMgx/TMkIClbTC1OZV/
	2LMcdAk/n0Spo2VI2R2dAf1E6tHzaqdiGRhgxFFAn8r3AgGWiGtMnEpeotPTqDIeVNVK
	LxHw==
X-Gm-Message-State: APjAAAVoFMUz+7ves4Xs3kH4TUeEfA/SFtvjecydIzNV9TH9xIOH+isG
	8ns/Zd7LgeI4METvcQ2a85ezwoOM
X-Google-Smtp-Source: APXvYqz8QLr32i9wxwM9kexe0Ohtdgv9kDlSdF4r2NgSl/tx9L+P515U++UjBObXbacjy4BkqaBtQA==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr566187wmg.8.1556134792416;
	Wed, 24 Apr 2019 12:39:52 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:51 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:53 +0300
Message-Id: <20190424193859.31817-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 15/21] gdbstub: Implement file io (F pkt)
 with new infra
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
Message-ID: <20190424193853.U0WjDsCLpxdBBPfcXmXeBzPIYHxIfPBczT51MPCmiTk@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3a7ef5eea6..18949120be 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1773,6 +1773,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int num_syscall_params;
+    GdbCmdVariant syscall_params[3] = {};
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_params,
+                         &num_syscall_params)) {
+        return;
+    }
+
+    if (!num_syscall_params) {
+        return;
+    }
+
+    if (gdb_ctx->s->current_syscall_cb) {
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
+                                       (target_ulong)syscall_params[0].val_ull,
+                                       (target_ulong)syscall_params[1].val_ull);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (syscall_params[2].opcode == (uint8_t)'C') {
+        put_packet(gdb_ctx->s, "T02");
+        return;
+    }
+
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1914,28 +1947,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         return RS_IDLE;
     case 'F':
         {
-            target_ulong ret;
-            target_ulong err;
-
-            ret = strtoull(p, (char **)&p, 16);
-            if (*p == ',') {
-                p++;
-                err = strtoull(p, (char **)&p, 16);
-            } else {
-                err = 0;
-            }
-            if (*p == ',')
-                p++;
-            type = *p;
-            if (s->current_syscall_cb) {
-                s->current_syscall_cb(s->c_cpu, ret, err);
-                s->current_syscall_cb = NULL;
-            }
-            if (type == 'C') {
-                put_packet(s, "T02");
-            } else {
-                gdb_continue(s);
-            }
+            static const GdbCmdParseEntry file_io_cmd_desc = {
+                .handler = handle_file_io,
+                .cmd = "F",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &file_io_cmd_desc;
         }
         break;
     case 'g':
-- 
2.20.1


