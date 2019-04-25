Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBDC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E802206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO2wIQPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E802206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJehG-0006ED-9F
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:45:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePj-0008K9-D0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePi-00014H-DS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePi-00011e-61
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id c6so24654912wrm.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2X/EqHRQzIkKd3q6L4ImeXDT9TueqP/ctRgcXeSvAEY=;
	b=aO2wIQPXxnh/Ff0BIeVEDE90jpMWwbUR4eocHkhW1WCHmemJjBVW+u9qB4k/rp95qf
	lm2c6Qsb3UWU6ZcocG4WzYTEaZ3dHp7W0pJyi2uYo8vZYC2Yw3gXKGUdarfN5KGF3vn3
	aFdUpqS3Ia02oLeD7FaJByWdhjs8P9PJ7pkJYr1jdbIEI4mBG7SIEqsqPJlVwYkg/d5D
	Rgjpn4wYctsKRE+TmIRD9VDRhPrFHj52cLS24SXpf24Ely8zMfb9b0QUnKySNihNFFFZ
	DZ9kOlk4M3I2HhzHy9/IMPLxqosKQd3Zm5dYTr7aE3CUKWU2yUPrhxBfceqlwSGFJymG
	is4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2X/EqHRQzIkKd3q6L4ImeXDT9TueqP/ctRgcXeSvAEY=;
	b=EB+47gF9LAc9om3p9KqiLOvj2UAh7JqDUfkL6TN5elEdP4K+YJG2yBiblPzSMQfY74
	ToQRfEy9O4igHkafEtL/eNyI6mZWDOvFf3cM3zkKQQ5lgaoJloSgkSXkxNt66ndrDjuk
	I/s3LK5lkKUgPcN+YDFe2p8xMSj/MXZCiUYy7jvMUjKbxwtrz2t+nlYDvAwvP6n+s4nS
	VUFlzvIQSXTIlHyBMguPIvRYuEdi3XCVJkCNGnQ22Sz+6fjbF8TCQhyM/ERww6TG16my
	PuLSZhFUltlxbRgeyr+kaJu034po/DXD8ClBtFRrsqenQr8nCY9QMxCy0i9BcyPFim3q
	THaw==
X-Gm-Message-State: APjAAAWJjAR7plzOi4iumf8oQhE+aovbGlLt76poe2yy8F0pE+kqFvu9
	Gkrm5nmxLa7JcWFKlPL6L4A/z64k
X-Google-Smtp-Source: APXvYqyHzVQXPQfCrwPWS6zc8OavzndOsUZWguxCsdo9jrCawdwmb8HV7HR5gmjBvHeUksUtjuxB0A==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr24871185wro.176.1556198860894; 
	Thu, 25 Apr 2019 06:27:40 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:38 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:25 +0300
Message-Id: <20190425132636.31636-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v6 10/21] gdbstub: Implement get register (p
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
Message-ID: <20190425132625.xAKbDcH1oBuUTIrRYW0TDL-9vcsP027w9MW-XVozp3A@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 49db09ef52..c439b8e796 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1656,6 +1656,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1885,18 +1915,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


