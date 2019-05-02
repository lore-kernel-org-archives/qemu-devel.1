Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E237B20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx18xIgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E237B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Rh-0004iw-4C
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:47:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AJ-00057t-Ec
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AH-00035N-AL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6A8-0000Ye-5W
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id s15so1759286wra.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=cx18xIgPOraRJ7MV0+4GVbbFdT0kB8MwxxbFPlFoTK7KJlugJyJpbdCHRl+IwGeJ4P
	h9B05YEGOvfAPcsqjA3+R1J+ucjjOdJSB0EIWQBW/e3owHr3aPBi32N15w3iSGEJ1CiC
	Isvch4rVAnEVnqnhw4QTaHR6LLENIlxQ6NFSOK2QZT9BfXTUuzZcFF7tzdWOamwBgVwJ
	aTdsbwbQHxed5OGje7USrc/KzXIobi0Eh+XS+2CHF2Y1EccQaFnwh0hdcAfYfz96hd5d
	rhWKG1tuXXLAtvSuB6aG+LDA3jdbtzS2mCML3Ff+lqi/SbADHjYBu6+Je0h5hIj4+Q/S
	qfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=c4EVQ8nGSW5F0WAz/SJ+I3o0Td5ipE4/yoTWKQQWjawU1km7wVsgpZby5ueXo63pmj
	RwTnrR0GLDS4ynguudoXwaAywrzL89F4g8ROo86r2Ud4aO6O6Rlhnzoz6vu3ZJE9WNvw
	4gYTdYzJRZDrmagudxaQms7Qk2HmDAxn4/k9fw+8B+LckFQQrR1Pur2fzEVIqzGrZYOv
	xJp7hdsoaYOvAqo9VrsBV78V4m+RUzjMl8SUHLkJj5jyHR1DjeiZpfCDTu6MoGvRBf1l
	9+xJrnAA9wnxZD9vHFU/WEWfbRm8X402uUZDB++N0gBHemrxHWH1q6mrWQiTHzwgbSa/
	MVbw==
X-Gm-Message-State: APjAAAVgBmyj1QWRadtil2EzIXiD+vW8KQtG0is1np3fpv+P1Lrje3Fl
	VYKkpiUvhLn2AQNj44TlEe5Yh2Ke
X-Google-Smtp-Source: APXvYqzpA8tS0XuMH46lwcOqQ2kMNgeJoNdC7tZdY8/Rw4P+Q4x9c7xcr0CMFSW4axekHglplY0A4g==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr1590133wrl.123.1556782034455; 
	Thu, 02 May 2019 00:27:14 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:26 +0300
Message-Id: <20190502072641.4667-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v8 12/27] gdbstub: Implement read memory (m
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072626.V4t_U_yvHZXf_4ec7DiFOLS0_F66rQBsjzHJN6jfvUA@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8dc2e1d507..daa602edc3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1710,6 +1710,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 2) {
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
@@ -1899,22 +1923,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


