Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD3C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396A320835
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs0RlYxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396A320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNGZ-00031S-CM
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:09:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6C-0001zm-Ly
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuo-0005zX-Ge
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMum-0005wr-Il
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id v14so6525029wmf.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zYJbcOVNvpPyrvRX9su4r5yz5i0Elz7yc6R5fA8SZ74=;
	b=Vs0RlYxsWW4Bsu2DKTNJoNl7zKnNqE9CU6WAFjQ0ixaZ0rXt/eAOXub6SoNJuFrLMU
	SskBBucnr7fKhKs+RM6BdzXEfcP6fa4iroRxnvtt8BN/45j8kZ5yU59OZM/+aV0S9InM
	lWQ4bfQxAGNokFGA4xbPgNtETKQFZ04jRqbX4vwQZqJwKadG0R+p1vaixZxoj2HWCHyg
	hnmlFk7uP8oXgkwjRexdVJRduMPfLy/JDac1/zcdvDcyGkTDvnUIwRqb7dSlrEYBXQiW
	mfFAn9+MqsA+L1SQ54Bki7oxOkffQWuXz+QtF40KtP+uB2uDXZz6lhrSTLVhsTZ2xnMf
	8Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zYJbcOVNvpPyrvRX9su4r5yz5i0Elz7yc6R5fA8SZ74=;
	b=T67TaEfrWM6zIWM7VIYD89djfNe9VLiZCGHFGxVJq0wyIaSQ9lfVH0HLqX98FbfttG
	cp8B68gnNjFA3Ci4HXWahFt6C1KGAly89kNiwZ2uCz0p07cNF212R+jvWIjzl48pd0Ma
	Pw3ElxK63HqCUi7w3zqUCTMpmtkqQSGagtQC4gaUonU6P+i+1hggr03To9zhwTyM3grM
	SltYvm4NdADi4H2Ezs9jsr9h6xUJLlx4pyXk/jM1nhcsDBA6RqRgUITVoqhHg31FC4do
	NRO9VHZCjdu8wsG6cOxUQ2m0KGCvFug6yrqpZrKjxQykeSfFo0YhSAw31Tno6FlOAjlc
	hHpQ==
X-Gm-Message-State: APjAAAVbsDiBRjr1zulw8wcqphLW0OlWirBmWwA0sNIZLzZWz8m85MRE
	VHonZY5ytsRnboTME3ZpJwcTf10o
X-Google-Smtp-Source: APXvYqzpjG7uTAmIKlo6BVvlCbflfzigSlbqlfmntYC4tt6sLr2EYl07osfuqo64/HYSvPZEIVdg6Q==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr389248wmh.134.1556131597495;
	Wed, 24 Apr 2019 11:46:37 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:36 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:55 +0300
Message-Id: <20190424184600.8445-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 15/20] gdbstub: Implement file io (F pkt)
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
Message-ID: <20190424184555.73W5qJHS3GiEKSTfhXufe3aTWGBB1eLOiSdpyKtuoUw@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b9ac9401ed..772bcd2e1f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1782,6 +1782,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1922,28 +1955,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry file_io_cmd_desc = {
+                .handler = handle_file_io,
+                .cmd = "F",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &file_io_cmd_desc, 1);
         }
         break;
     case 'g':
-- 
2.20.1


