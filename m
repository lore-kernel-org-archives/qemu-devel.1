Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC22C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FFF21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj+pdJph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FFF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsgT-0005gT-7g
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:07:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHw-00017U-HB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHv-00029Z-Dy
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHv-000248-7i
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so727835wmb.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=nfvTF304j4FxQ92xKihWDltBNWAJ9aSBkHnyPnGx2bw=;
	b=Oj+pdJphteXnj3D+MI3kpRepureN0Ee/gdJI+Uz27t+Z4Wl3ARqJamy0ZMgj6i2M5V
	Y4xSBxqvu3094RHoz9dPjMWsnaaZNQAUQ35M7kH46y+UdgcJKNG3nmGDOPtd/7Q2pJTK
	NXU5O1X3FfFPGyFfGZzVIao42rWKCFE8QA+fW253BPYvxCKFXCYjJq/EVUyQk0m1089D
	R+m6YniFeRVWqngcLH8d//zl5dKqax6ryvubTSbtY/TmWkw+wnMgvarGjCUjvV80e6eV
	eSy3/Wi2pGcDht9GxTvOt/uiePKKURB7KUxceSZBkCmZqdvJRj7DLg7RZn5CoXh3beQ5
	b6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=nfvTF304j4FxQ92xKihWDltBNWAJ9aSBkHnyPnGx2bw=;
	b=XryzrUL7Cv4GfgRNec96r/XBNP1aLtFTywbJzA+y6rliSPp8HB/I7CHa+pWMG2Dzwa
	tN1k8/pZUJVCEKOkuyk30mFhhK422Nys/DK4xcQfdWjirlA8wlleJ7B5b5pacT1V4Ia7
	tS3A4Us91q1Bkn9IFZncwyFmFoM2M4z5r/s2HWR+40UIw0gipX/er+YFJa0X1EN8MjAi
	K533ZNQpzFPePhpRz7P7m6k3opeFzhYM7kxB5fcPENwS4CPVB4u/OsGa5LdxDF53371b
	PAhqD0nG9M7/CHFGK6MmRzJrQbnUGIFxPOEhoyAX4G1s09gu/kqntITqQZiB/tG30Zqf
	P/rA==
X-Gm-Message-State: APjAAAVmIbWhIKJN0/3PZ+ZdRZDrIPYEIb7oGpVUFchs4jCBQ4oKsFKL
	GsH1ig1IWUm8siqmtCoHR5IuQVUy
X-Google-Smtp-Source: APXvYqzJo5qyD3pJI/OpgECmuXJzvC+R8pnsSB/va1VBFoxF0lJQVXgWkAxhPuvJvPDcWQTBlpAPdA==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr5940068wml.0.1559112134236;
	Tue, 28 May 2019 23:42:14 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:42 +0300
Message-Id: <20190529064148.19856-15-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v12 14/20] gdbstub: Implement file io (F pkt)
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8a401e6527..ea85966b27 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1789,6 +1789,25 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params >= 2 && gdb_ctx->s->current_syscall_cb) {
+        target_ulong ret, err;
+
+        ret = (target_ulong)gdb_ctx->params[0].val_ull;
+        err = (target_ulong)gdb_ctx->params[1].val_ull;
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (gdb_ctx->num_params >= 3 && gdb_ctx->params[2].opcode == (uint8_t)'C') {
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
@@ -1930,28 +1949,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+                .schema = "L,L,o0"
+            };
+            cmd_parser = &file_io_cmd_desc;
         }
         break;
     case 'g':
-- 
2.21.0


