Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90611C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1447620873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PepwTe7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47397 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM77A-000851-W0
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:30:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tk-0003cX-RO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008OM-A6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tg-0007Ww-Vp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id e9so2033576wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=PepwTe7hStnTonZBcIzfB1nRJqu+OsGlAh9Ytf1s++5xl6bDau96T5sxQOkswuGF/S
	Tjexj5tqfuSfAgs5KdvxFlu8wH0Ii0MuHkJYPTpL7xY1hkkib797DP67F94wV1eUdlVc
	r4/0EhIC5MEcL6aGSzktKwkWA87JB2GWpd3TtlTzejy0xWgNsHaC96cP9nZSwXB1nPrG
	oIjtRwJ/mU6caogoh3PRCpbah+zFqZlEng1BaRu3RWhhPhPERkCZbPrEVGZnBvlFlVHV
	jbem4Y2WaBINlTS9pqWheoGYrZQJMIp1fbKVYFDHpbhqqOT1QXdPAoFoFLHMYCBMljgH
	LeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/kC4Ra5FAbXCGpLaIRgx76fPd1eNM+Za2+9T+4B8JSs=;
	b=fjOCw5xalsBYs1zLsEx0GNQKI8iBL1gVScNcBwQ+ZFcYkngJACJAloMrUiTH5TxVzV
	Lb8lXysyjnBnNMYZIEA065aKpk1ZuiKSuyqnHlqZfAFzwqA/BzTY+MTfKZWiadmMrai3
	SlWfZ3KzoTR2qfP/KJiJSCX6252LZDEjIc9uMAqYzR+9CZFxavW/v0ggsna74ywGzuxb
	oaMthnTlHgVEBXXwnKL8MECFtJeCyZtxYK7MSm3020tp13DBAhPnn9MTYhZgbdlNURVw
	LdasYFHXp3r+Z3v7uYCOyIpHdQdJMm2w/gzGM0Dkf6NSqBNiidiaAzB5mMhg4BrVPgpo
	oeTw==
X-Gm-Message-State: APjAAAXoIQ6PjChZKH7c3hM83g7LoaYnWjScKkR/jotNRqXnase/ij4p
	EdjPTT09Bj6VMzJFmIEQvS2wlHao
X-Google-Smtp-Source: APXvYqxSN3+joOhM7XNbgNiUGTOc0WTN9dG72C/4ml0YKnkNvOAyHIC2sHbykct2AQ3dfDR1JwSqDw==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr878251wrn.170.1556784990882;
	Thu, 02 May 2019 01:16:30 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:42 +0300
Message-Id: <20190502081554.5521-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v9 15/27] gdbstub: Implement file io (F pkt)
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
Message-ID: <20190502081542.69K8u51E-wTxO8FXnAGW9URd2BDvXqI6hS2iiKPN1aI@z>

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


