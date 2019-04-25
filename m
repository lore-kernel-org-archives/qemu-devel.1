Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF6C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B13206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4b4bzI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B13206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeuA-0001su-C3
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:59:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePo-0008Rw-VL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePn-0001Ek-QX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePn-0001B3-KH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id c1so9273123wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FfGjSJV+pgCWpgIFev/Vk6a07sEAiskpgdyLpP9ye7A=;
	b=X4b4bzI88Xbp3B/xRkT6eotobR2V/sv5QoKORyzfikh3V2SXXNu8hckVOlf5BYv30L
	viRNebOL/BJtAetZ8Mc5l0K1Kfp3vjyHzObBgSWZBdJUhmHaUaiU6JIC/lR9hRBYkGZM
	oaDDp8jL9/JdEKY08e+7zKkSFIDY498fPKAaNhrSEI33YmQQwNcN+U0efajrQ1Ulc8k7
	h3PhH0IKDIdv8n6LOowHapK/krWT1vbJ4syMncrXrb5DkP5/5h7LyZLCe3KAwPUlF0pI
	kCuBrlxp+x6p7WQYeFGKClFWjrntw1Ieyavo760c++4ow+L8WrzK1XwJh1RDHfrWn7Vh
	bYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FfGjSJV+pgCWpgIFev/Vk6a07sEAiskpgdyLpP9ye7A=;
	b=WJmQhqr+iNTChUQo66YSloAgLFPXjt/3QjRu5T0J8IQu1aHttLQb/oWZWq9GIJepGf
	RA6+uTeVLKcnlnZymvg7myUmKEq4A59B+Y4R7nKS/hIxJky73Orpp0+VJtXdXn0yL4tG
	SNzf2+wqZbI/Wdv+fmEA9xfdyr7/PEHR1d/bWpp93LZ74+LPNBs9EDuaeJZkdWrXV64r
	TcqHv431c8ozIArrZB9gfTlbKQ5MzuY8BIS4YrGxM8R8bKIs0MbclVTSPcqc9p8GxZQz
	EMoMfTRRFHSITFtnVRgdr18i1pWR5AbFD3B370NVG/2cPtbhX+7YQGcSew7DgzXM5VOg
	1X8w==
X-Gm-Message-State: APjAAAX/BvqwmQUmgkq9O2+JsClJPR+szrRu1RH1QEbyBCa8iZzjG2cv
	TZGb+6Cuo/IQhNVlkbmGgRd4n0f/
X-Google-Smtp-Source: APXvYqwmLXPFZN2OBBMfYI/3ihKawAiaedlrlvDTnHlKXXESlzl3WfGN7bLCsK2fUN0t5dbLSWk0Kw==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr3518858wmi.77.1556198869198;
	Thu, 25 Apr 2019 06:27:49 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:47 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:27 +0300
Message-Id: <20190425132636.31636-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 12/21] gdbstub: Implement read memory (m
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
Message-ID: <20190425132627.MvlWGUx-Xr3tgguY4AJEPY9BB2KP_BcD5NNxGq3QK8o@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4522c93fa2..5b60c1369c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1711,6 +1711,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1900,22 +1924,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


