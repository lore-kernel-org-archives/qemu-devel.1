Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F69C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECAB21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAxb1BrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECAB21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1o4-0001ae-Gf
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:15:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZE-0005mx-3m
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZC-0007cA-Bo
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZC-0007Zv-3F
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id w8so17870586wrl.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=V1QVJ4HRbWCoEeLavvf/S+Qb9vILZOoid3DZnX3FkwE=;
	b=oAxb1BrAE6KTFqNW4wbh1u16wJ5p4bIGaSWxJpmnpaAr2xEDfCsuFzGyILD7ktpcYG
	QahWobmPPPjDcWPIbkVTuggKxLxfQoUqib/AuHdpIIWYc4OiiVkoLTplu3KdTGfKLfQC
	F39w8VVMs/yobNdp6DwjD3Wv7TIWF5Tod55zUBMkD5jregix1EvNGVciH3+OYoYqxxAE
	4xZT/cWtY/oaw8xQ9NAUVQwBZz93sCi844q5Tj8kqIC0yyIr0M/QxvE3tsun/zHHbvmx
	c3Vm33nvx4nxP1pIoF11hrB/wzfFEHNejNeQc76lJIIFrSpftrPw94FOHask6Bs5JmrT
	M+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V1QVJ4HRbWCoEeLavvf/S+Qb9vILZOoid3DZnX3FkwE=;
	b=T5VFAg58/X/Arbjbgv8p9pD4lY0XRzSv7uGyrfuwvJgE/fJCGFbDBoCli6584CfZw0
	GlKpt+IHoyXcJO2Z8FdvI7qhPEqVs2JJT/FVdIZWq9C1U8NAMba7inPdAxv/ygLg3qNf
	pSRC5fEpS/9kYFAGP6ga3q6HAiYmklZdsz+S4IPaaMpLw5OkvRMTrtzf06gRzNrB58CC
	gZqH4orIAEPpzy1UV35RkPF4pbNwLKSPrtwV+oxKbVWNOjaBqzqxTOI3aG2mdJHbkWjV
	kFrF3I8iXWFBFoovXauQ+ADa6LvEk1VXz+AQPM9/ggO8CFmcPdGkozNNeEjAabtFHPH2
	djXg==
X-Gm-Message-State: APjAAAXCZxorf/5nFhAl2x4UkVkai7ULfQtqrLV9bA+ppBrkmPskJx4I
	v55GfEF77Sdn79EYwGkuUxD4Skjr
X-Google-Smtp-Source: APXvYqxmDuhVfySEZhkAzcIcGPpjZp5QUUl5K7yuEzEIPTAyEHCynUv9+7fiaWsFmK/HB82bqJM+hA==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr38294993wro.253.1558432816048; 
	Tue, 21 May 2019 03:00:16 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:15 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:37 +0300
Message-Id: <20190521095948.8204-10-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v10 09/20] gdbstub: Implement get register (p
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
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1c210d671a..3284b3e01d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1658,6 +1658,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1887,18 +1917,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
+        {
+            static const GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &get_reg_cmd_desc;
         }
         break;
     case 'P':
-- 
2.21.0


