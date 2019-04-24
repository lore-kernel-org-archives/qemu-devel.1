Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A41C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCF320652
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6Wu3MfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCF320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNnn-0007Ac-1n
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:43:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk3-0003k3-S0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNjw-0003q6-6r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNjn-0003gR-4u
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so6717313wmc.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=38LnIcypIDjektyoZrBn3/LYujk4iHNznA1yMdifAQQ=;
	b=s6Wu3MfBOmOKkulllTgcODgWpCK04ZsIUKFuDw1Izx/9j6sSt43e6MXcsALMRqIPjA
	bgiTOqgPnyISLgzGAogGKQbjaC0XumjOlbCY2z8aJkmfbA3vnJn36XyxBl+YIS8cugyJ
	2wp3HvgsMyF0KfNXNN8fO1+YS3ZuV0YJNAAXtE8GwfnSf09WH0CB5D7EYkbo/x34Yfyq
	M4GuPag5J0omdAdVNJqs3KD0Y6zytLe4fPz8IlpCdl/lXKwzzrfp9EVvKf1O5NsArdmG
	d1cSsFpqXKBD/dsgWPE4kw4nVTKD2h/rWU2sdsr6d3lvw0w2ZkRsyIihyYhvjkwT7KrS
	NHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=38LnIcypIDjektyoZrBn3/LYujk4iHNznA1yMdifAQQ=;
	b=QReegDOZFCqIEty+En79Iu3FAbt1Ze4/h2rufRm73YzDBYsorSAJgAOSOQQ2FNHUPf
	SbGh8pjsqlqTrRHtC/na+jPKE0BQdxEr3kFzapYy8PL/Mssm9FAEp0JrhGN/wX5MnQwo
	GFDtA6xq0cvxp7D4NN36kpKpuXgbY20oo8aYBUd5HbatO+o42cgci6DNb2A5OrTS5T1o
	JzXB3qo2UaeB5y4PqpHs5vguqrtVNK8z0LkM9O4/WwZrbJWYyqcNbqWbDJMF1N6OGdK/
	Cd76b+/jBxG4HPSmb9QhGLc66NBrIj3fKAnStkE+A6VC+yaXp46VehiXRfy84faGgU0t
	Xyvw==
X-Gm-Message-State: APjAAAXNw2iooI2vFfvmy7QPyyhFd2kzpKhEQ8JYeHp6TzEJA+QeDkpo
	vD6syGaDDxpoQCsZdikg+mhd2fKR
X-Google-Smtp-Source: APXvYqxgNdieUOWWp2y7kTLdLETpxilLIvTt4vXwuGc9A7EYDilnJd08SrR6pQ5SDBIqkcjRZp3A+g==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr543428wml.110.1556134760771;
	Wed, 24 Apr 2019 12:39:20 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:41 +0300
Message-Id: <20190424193859.31817-3-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v5 03/21] gdbstub: Implement thread_alive (T
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
Message-ID: <20190424193841.RUzllqZhTESxOc_6RFr3roiq5D-OE2X0SBgN5CvfNH4@z>

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


