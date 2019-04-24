Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD9C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA622084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKZEG8xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA622084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ6R-00032l-GU
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:42:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzI-0004gC-9O
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsV-000133-8d
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsT-0000yU-AN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id c1so4877209wml.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jOumf5EKIBS6pSzC09ZC4a6q0f22TQxEoJGNlEiAnhc=;
	b=lKZEG8xVKnTTuKTx3uPhEkzdc3WEYJXEmlrnJ66BhsqJDlqiJUAQRbLZPjNNoNR3EV
	aLPMXi3ArQTkvy1POIxOIsD57B0SZaHG3D4FsqJ0FZnRoMmLZlbEx58ct/W6aijNSpvZ
	jfhaOPnIT44T17ISUaYb4gMqTDsenjzJvMNOZWA+9f4eyYbd+I3a9ix5fCuVJ2IN6pbt
	R5EleHfQ1GEYFAbTXAb6rmhkDL6gKIB57uRdvskbE5wWHXPxMat5FkZ4Pkb3EAsQZMvP
	ll74mULVThBRR2IeLGkBljrU2lUEXce7XV0FF4R1gRvEB66h+WXNyU+AIOvdiXei8Dz8
	tE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jOumf5EKIBS6pSzC09ZC4a6q0f22TQxEoJGNlEiAnhc=;
	b=REabpqQtmgQuMum9yM74w96BCVASP4avb1vMz36Do+jsQ20gM2lqXxUTaLWfsEtSUG
	2oPCakqLIyj0yxJxAXb9j2EUr5xd0f/U7dnEgVjOhLUxHHj2Hf8xk7fet9Jk5WejP0XS
	h6eGCeFFY5uT4L6wAOLWGU9he8DSNCE2/8S7KKaaxHGBeu+K1OqEJ50WYzBBVEtp6mx9
	IH3x9gXRnmFTL5Ba3K76tcmcAp1aQf1KKRfdGNzdsghIbBnEkRIOD9JEdZCKLL5QdGD+
	QuWAke+ts6Y0VoQMRmLU2fVvQ6I6muSiew3a6DU/p/YtSr/jmT43p/Zb1Xxbznv1msUL
	r+PA==
X-Gm-Message-State: APjAAAWlCW3WUtIQn26o0sFPBuSSL6Eb1T12OXFlnMDTVa6/Vi6+4TNQ
	NdQ1HYvPW6nd5UG8NxSio3/CIIYi
X-Google-Smtp-Source: APXvYqyD4jmTlCiIxu3ZCszw0ExteUQK7/1amDaLEFp9rurgIkEfmvcRxhCKGX8RgES/7FAExpIyKQ==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr4418616wmi.6.1556116078839;
	Wed, 24 Apr 2019 07:27:58 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:57 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:09 +0300
Message-Id: <20190424142714.28460-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 15/20] gdbstub: Implement file io (F pkt)
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
Message-ID: <20190424142709.Vn23LrlPfPIrYOrFwLAdeAB8ktQyfofTg7TZNfAeFCU@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b3278a66c7..a71fbc800d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1788,6 +1788,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1928,28 +1961,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


