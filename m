Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF78FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B042C205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZmTtIlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B042C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNLl-0007zS-VK
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:14:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6E-0001zm-PM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMug-0005sT-IU
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuf-0005pG-5T
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id c5so17694714wrs.11
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1SwoKvryYx1PTxyZrw2VBC7pjubib4WcDyGhDiggCzw=;
	b=sZmTtIlUxV6jS/uCmnEc4eMfNvX9rvKQ5RLOfPgAL9AaO1e7AoQ5hGcPPX8SPE0tBW
	qpTJFYek09kpiunnB6Nr7noWuPBHNUQn7+vU7BnAiveBVzeXI6pLV4k/PzJwHWna/tZc
	GcC12fN3NkvmrVxRCXHOnXGxs4YDBr++A106BVmySOYgyzKlRMz9NfO2FrJOmcfkWKVC
	e9VWEi8X3+iBzj57PZRatFaK9FyVhH+HG9B3AbMI/hB6Q4qwegdztRp3IL24+LiLbesb
	km74vRQA4bCOvzVjph8knpcLsxS/R5pZJqWmEM++97f6jNIaNuilCujniZbJhZT0I4ag
	4dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1SwoKvryYx1PTxyZrw2VBC7pjubib4WcDyGhDiggCzw=;
	b=rWS501ri5sjKkoTx9nkLYcKLcK/TIiJ7p8Kjdkk3x5Pnb1VSbXapVjubbLxTKod7Bt
	ii6O1WQSigqxWRSHJzYQsDWAoFtVCnGdTf8XC/eQZvdyRab6xOYBl/6N9kSuXfPR3lnz
	Oe6QMPA4I3v3WN1u3WAQc3LtMkZKsK8u1Qo5CiJWfQCH+ofF8jOemSfbF3nl41EPIDc5
	gwrlMSWA57hml/um6Ot6HnQYNao1x6TMDXQRecXJLnxuA6PJ/kQpC80cpPpCKBbfi3Im
	RTmZFu6NMD9lgA99TbAB+emYbeLYq0WDX6Z4+X/N4W2qPsfGwccTsSRx14kfwZqC0Vtc
	6Byg==
X-Gm-Message-State: APjAAAW4e/CPdtR0IkYtavLJt8Oamc74sWhsuBB3LfRenaFvY2ArOK2y
	CyQ/5r0AKoNll55W0hNT/I7Zp5WM
X-Google-Smtp-Source: APXvYqwJGRyxhxgaM0KHob1TuhYkByHlGAsD7d+km0+imRUnZk8DHUbUGDwPWucgputQaDSTB5kkTQ==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr13502737wrn.61.1556131591773; 
	Wed, 24 Apr 2019 11:46:31 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:31 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:52 +0300
Message-Id: <20190424184600.8445-12-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 12/20] gdbstub: Implement read memory (m
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
Message-ID: <20190424184552.A62lBtTdS1ZilGncIiNm0YbYXUFbAipc3HZKEptlkgc@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f29042cac0..af37222034 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1720,6 +1720,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1908,22 +1932,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &read_mem_cmd_desc, 1);
         }
         break;
     case 'M':
-- 
2.20.1


