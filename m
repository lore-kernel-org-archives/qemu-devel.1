Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB0C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8AF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blR5R7JH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8AF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNBn-0006qM-JM
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:04:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6F-0001z4-BF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMub-0005jY-TY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMub-0005il-NX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id t17so14849579wrr.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=UEhluJFSFmCvgit2A05wUiVIx+WL2MDSmnEGCQHEBso=;
	b=blR5R7JH6z3h27e+FF3UcEALlW0XuqJmHRA6bkoarVmZ1FykPebjS8FO1uAIylUaLo
	ZSQSWBlTaswQ0oG7zwzkrbN8rcQ2Af/+eDS+HErwkD40QcKCWVJQp898+Qpl1n1VmyvS
	VU2Mrzce3N9ryMDKYqKDNznZPP0UyoupxkV+O5kRYPqqLMWTMTMWCodSupPtl1O/Q9ev
	mfq3RbqKxmnhdQU757/KMn9Fp5HDOn7/YMgznAy2tBh0tq1LJxDrlRT/6G2zHI7pRFkr
	4gz2U06AYGDIN/MOEbAIL37QY47jUJZ7hkeOtSU2FtssjTx8UyvYAe0p0LQoXeOU+9eK
	kq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UEhluJFSFmCvgit2A05wUiVIx+WL2MDSmnEGCQHEBso=;
	b=sBdQD9zhxJ7OzqUWv3wwAGzZFM1RT/hOIR2soyXWwVviRKeOIvRfiklWw/WqSwyxLq
	x2SfbqZQ9xUtlpfZrCp1pIVvEeQ7DSLZbBHCxd//NO3RZMmO7D2yNGhD74zTM8W/UYDM
	zyv3jScbv+B5HXrsIrnqHnrZUxhS6VyiUjY5kzkKCkRzXlKH+D7ckDTVES1X3NC/lgHz
	r/1BGjRx7JRYoLZtiBHkFEqCj4B2Gux7m+PQ7DgAwoTBJuzoxWprjFbKozvP4QPjr9pv
	cCTxmdyFCkgcN6YJaYgP3DXpwIRilLwZZSSkXzW04Izonrf5UbrFhxv8xmx1gwbobog4
	F6oQ==
X-Gm-Message-State: APjAAAWWunYAY6qJUNC+i28VlCa+370kK1ZjhCIOjLy6Gy/wKMW+k7Hs
	W4WGl52D3ngiZ7flE4AyWgH9ku6m
X-Google-Smtp-Source: APXvYqzL02SdHz79fKae2yfhxd0b7bjP4Y0GKvWCEcqCdYffxjeXqPBxH4CIlUUofB0QpoUwlwr/9Q==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr22772357wrj.16.1556131588334; 
	Wed, 24 Apr 2019 11:46:28 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:50 +0300
Message-Id: <20190424184600.8445-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 10/20] gdbstub: Implement get register (p
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
Message-ID: <20190424184550.0rU97HurZtKFIIWc5MVVj2uisUdgzmzPSEkFC94rkFY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d3d688a747..58b665d303 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1665,6 +1665,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1893,18 +1923,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &get_reg_cmd_desc, 1);
         }
         break;
     case 'P':
-- 
2.20.1


