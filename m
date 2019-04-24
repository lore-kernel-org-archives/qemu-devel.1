Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E6AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7188D20835
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPzdbWp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7188D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNEF-0000lJ-JO
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:06:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6H-0001z4-GH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuU-0005Yv-Cf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuU-0005YE-6b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id c12so20396483wrt.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+b03fXO6Y0tzO3kbLlDT+FXOGaqTSJg2jxTDufy5egA=;
	b=FPzdbWp+0FZYR161DDTtUSAAzpabJoRyLJZHhjKAouBN+gSuIW1DfZDm5ZzkLEtMF6
	hhoPXd9VO1SaAj0+XVU2cUK5jcAP6yhqtYnoOajn1ArCRhPjK0lL6xu3PfCFmcr2+I/o
	PDZpwK6WDBjC2H1ZsvWG0ct7nQClYkqBkobOJ0PtFVEH6orZhyb3akXJCrZo1wVXfMVE
	yAFJh5bpJlAOvfq6eqW8EthrhMRUSguOgxWL6q5KnDgVJlb7wzrtDWbSuech/KCfYlzM
	z3VEfeU0CLy1durjhsiMh0Nxa3jwhAOWbP7DCE+1KY5h8KudYhnL1y1vTVEjevQNIzdp
	1ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+b03fXO6Y0tzO3kbLlDT+FXOGaqTSJg2jxTDufy5egA=;
	b=U2YDhRs/hAkMzd0F1HB+0KlU98XzJAXqOzD2N3KU44D091aOXnQs3+NYe9G23NZu5s
	/H/G4LAzdXaoLObM0KPzHlHa61pVlWDuCA+oBjDoVjDiYD+9Cr0cyh0acWOVfnjvPei2
	bkoSiM5BoeXVpc5hEcp6DLx/IYV8fuzYKle39DzQdgADnVmUf3hG7Swu5lAewX8OhzB5
	IHr63f+jMhTkQCECxoxBKn+o7iwTYKhpxzj9VRE7FUhMRb+6D+udH7DrX1oVCm9CrEC9
	g3BOwq2nc8VnwUSSr1TbV3x2ndmKhqTQxhMErCglYmS43D7lkEFIvvAk3t5bQsUVTjL0
	kMyA==
X-Gm-Message-State: APjAAAVROVqxt1q8/vE11R6/gD+VOkz0ooQ7bF/TaD+iZcb31wZ/rDTm
	ukjFEWicWYV6tj5qN77yCrep1S2T
X-Google-Smtp-Source: APXvYqyeqQJHO/hfZJsARaz7gQT2qnemeaJaePEWhzwKXK75i+qzJTlfH2dqB5b9ZN3YLK/MQKrquw==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr22651003wrv.163.1556131580603;
	Wed, 24 Apr 2019 11:46:20 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:46 +0300
Message-Id: <20190424184600.8445-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 06/20] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190424184546.RP0cLdf_OI1zw1glt05Q4cbkY4ih0vtyqqkEKzLWBng@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 79 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index edcb7bfd17..c1ec36a062 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1557,6 +1557,47 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+                      gdb_ctx->params[1].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    switch (gdb_ctx->params[0].opcode) {
+    case 'c':
+        gdb_ctx->s->c_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    case 'g':
+        gdb_ctx->s->g_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    default:
+        put_packet(gdb_ctx->s, "E22");
+        break;
+    }
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1570,7 +1611,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1832,35 +1872,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "E22");
         break;
     case 'H':
-        type = *p++;
-
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-
-        if (thread_kind != GDB_ONE_THREAD) {
-            put_packet(s, "OK");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-        if (cpu == NULL) {
-            put_packet(s, "E22");
-            break;
-        }
-        switch (type) {
-        case 'c':
-            s->c_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        case 'g':
-            s->g_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        default:
-             put_packet(s, "E22");
-             break;
+        {
+            static GdbCmdParseEntry set_thread_cmd_desc = {
+                .handler = handle_set_thread,
+                .cmd = "H",
+                .cmd_startswith = 1,
+                .schema = "o.t0"
+            };
+            process_string_cmd(s, NULL, line_buf, &set_thread_cmd_desc, 1);
         }
         break;
     case 'T':
-- 
2.20.1


