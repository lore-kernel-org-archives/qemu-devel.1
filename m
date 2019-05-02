Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8E8C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A114B20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwBI31t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Ku-0005vX-QI
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6A7-0004vw-2x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69x-0002rT-Vm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69n-0000d5-4s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id b67so5964444wmg.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=RwBI31t8OFRejI4t3acuDizKCkuymMwmCLrD1hF+TRwAPURb4qNgFmMR4VDWisk6x2
	Wmwa7u5QfPpIdfVA7ilPAkkgoEYrp0Vp1Eu0mn7OoQu6RW+IXiTCLRlw+6kQVbtEIMIU
	OW8JDPsppTaX+gj1RsvIIT25pIvdiJEI+2YjOHyih8x7DGp/9aqpeAUPQv/0lwK+a9ON
	GBhstTKYAEEXnsqmEefr97tr0t03F1CUF26uewlGY9Itbv4QZc7yAy90ygL+ibwaUncu
	fGM3M0svH5PXbv7prB2bsal3317to9TfQWPm4fbnLW6T618S+Pv68CxSLxuxdddRzi0d
	cntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=sHu68MmbpbmDy5zc0UKUOjGvG9DkGhWdn0wtnN1m9Fv9+aTVUfCnMeK1ctcyyltOcI
	PC/h2QerMqA30FSdoFyxI1T5gHMwtXs32hbqENPiv6VvD4lAcKSDMCRniDDdlZ2QdK+x
	FgWbUGrpeKmD7xUC4C9lg5vBdOpUB+E4T4Z3Qyu5DwqBItPdyqnn9bQBVD5tjsgPgSDj
	iWYbtejvnr445Bpb+5R0N4x9Ic4seOaHeiuHHBexCwbInFdz1HyvNcoaSJ3lpO3Rhf/i
	LWiTNHEu9MEpOdn0mZyqyw5nD6JmRmimrBhOqZxgDjoQbgndH4cRVhLsjzAcKopCoxRQ
	KGhg==
X-Gm-Message-State: APjAAAWCbEElklqVxhYeWf1nEiYgAEtjZoOPzX0V+PnwJ+orqH/JrCHY
	k+0XOO0ic4eirJDq9BI1NgzWsPGy
X-Google-Smtp-Source: APXvYqwVtHKT50ty821HkFxqeDRM5NeSyszIczH5wIZ7gKCbx6uBE0FppFIxAIroT0uPlIp/QWPGWw==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr1150958wmh.138.1556782041127; 
	Thu, 02 May 2019 00:27:21 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:20 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:29 +0300
Message-Id: <20190502072641.4667-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v8 15/27] gdbstub: Implement file io (F pkt)
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072629.0_l0HOSxm6eFgWWXDN4YsyBpLPDgXJ_B0INlCv32F1o@z>

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


