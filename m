Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F4C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C61206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1fCA0Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C61206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsyO-0004x3-8u
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:00:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmc-0000dG-BY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbL-0004oQ-R5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbL-0004nU-Kc
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id o25so1976540wmf.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=V1fCA0Bw1g4Dz9vUtQafDvpP7JuDbXhFc3NII9oIvvMmtcoYEBKuE+KmkGBVAVHuoo
	Zyls/3mCeWTTPOIhdz1HvqJni7ogQu3Pfhv24zapUH+4tjcSR1aFvQoCzafWqquxmozo
	CgPtN6qpgAzMiziNQZh9IVHPgB19HbRrga6V1/d6galA9Yi9PrDbc1fOYaRe4BNQtAk6
	0eedBz6qGs6y820AQFxeJkmYHM5Q/jJzn7qdcH1Foe91hDNbJXIz7gShjarvIaZgFH72
	/5ppw7PUdx2xh/977GnZscytTC+9R7XcBr/ChKWW6uyk1MA2a+fFNKIYFwAXPefd/a/U
	7TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=NabG8ykqLev5ccwiUBGE8NUXAf7F0u74NU56mhcDSl9GcsU7HDZrTxxm9iqYjjUx0q
	3K+ItY4FDmFNGMrCkmfzzSv2B1Q9StvpQvuQ5o14bJzKnfmb8TtvUkWWSusRzORTWox6
	Q7v8NtLdhDkjbf3IPl6mNy3q4ulBnZeetts2wox7B+qEUzeFsMe7bxlfv1L7MOY4AoRl
	os1oQQEwYzijkfBri0d/tcW3x+MxV9deHNXzK3BoVIr271P9TaO47TSZs+9OewAYE+wh
	jujUgluQvZWQNO9qz2sMs9lrNFlcoFoN65/+bf+N0jTJJZtoWDorRsDZprs8w/+Udu5x
	GKhA==
X-Gm-Message-State: APjAAAUD+irlWSkq6tAGrto1ihNN7R7Gek+Pw4ChU4sHNvW+swh2WIuq
	66+YG/vLinUaqTbYfjWpzEo+FGoH
X-Google-Smtp-Source: APXvYqyVKwdmOpdMPQCkcOfjIZ7TmSxXjCL+f/4OkwfFvPQ9OEPqA1pfBEs9uSMSvzp8Rw20ZkkfHA==
X-Received: by 2002:a1c:a00a:: with SMTP id j10mr6071987wme.15.1556253401965; 
	Thu, 25 Apr 2019 21:36:41 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:40 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:52 +0300
Message-Id: <20190426043558.6888-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v7 15/21] gdbstub: Implement file io (F pkt)
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043552.DZZT1ihxXdf5AnnBxJcqZNgCCj0ltp316hYHjrFY8dU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3478ac778d..9fe130f30d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1772,6 +1772,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1913,28 +1946,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


