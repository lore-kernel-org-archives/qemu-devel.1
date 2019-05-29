Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B882C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA95B208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB2/o5Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA95B208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsaC-0000S5-42
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:01:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHt-00014T-PF
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHs-0001gS-Nu
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHs-0001VX-HB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id t4so785334wrx.7
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8ICssjH6IZyanWlXmi8fQqHEPU1P+hXRIPq59SDpKSI=;
	b=UB2/o5Yi7r6ntVxzzE+03McbIm48XlBPtVIhl1h8MBpwGLgDDiNY2aYr9Kr4UR3Efm
	K61LncmU2ckf5BrleGFQjVs3Vzd36zRluVhOhQFOrXTBhKtbhkS0ofq9+R6lRy0zmZyg
	kR666K6vc5nWklAEfHMCseAP1Ehi/fVoOQfnTa00BkQ6s42y6m+PP4WpA71Za4aZbvF6
	FBxMVNIJxVCVJu0pEAn0XQB3deoPYa5jEe1myehLwzYHUR0sGWRoFI+K7joRfOivtqWh
	Q5ULJ8ClzXZJk2QL42HH6vod7ppcshIDNjZLPTY7vm4E5BP+Ikh+wCAQRuX8yOk/o96x
	63iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8ICssjH6IZyanWlXmi8fQqHEPU1P+hXRIPq59SDpKSI=;
	b=CbvD93T/bxr5wyUWSQLtSdaGnlEU3Tky2lBIZ90APv1aGUaE2EyC58dGtYv8p1HVw7
	zM2OGn/+U6iLdKTPdvjdZooizWoGsk2CexCa70H2ETK6D+NPdWygCDZspX0N17ZKsbiB
	13q5ZdpfpUdsQDVirAuaa0FomSdPDGXV+i/JZ8XbjOzuZwqCIk9iqGbEVmGgn1QrkLVg
	N5vJoY8om1dgry+bgqlQoVI3exhArVsfuC5MRp6E9LQI47Lp2rTxq74oQp7b84pFYACN
	uJJ4yyBk/l8qO27gNaaNUVS59TT6/Ifhsj5tUGX2FaA8I57mpL3UyrHw1bzt1gDyV8sx
	97kA==
X-Gm-Message-State: APjAAAWLsLRzLPkQdf9OMgVGbKNtX63MoFTM9TIWgKYuXEKncK7hcg9L
	LREe16Mi++Otvf36CqppI0D/RT+d
X-Google-Smtp-Source: APXvYqx62EDUHnSY2+Zb9cODZrCyQu0tdHHBGqtc7E/6bRROICPIBVC3Y5fi/+3qgi2ZR3AwowDjDA==
X-Received: by 2002:adf:8307:: with SMTP id 7mr69120734wrd.86.1559112131346;
	Tue, 28 May 2019 23:42:11 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:39 +0300
Message-Id: <20190529064148.19856-12-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v12 11/20] gdbstub: Implement read memory (m
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
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f2ea5bdd5c..3d8c2f8f42 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1727,6 +1727,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1916,22 +1940,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.21.0


