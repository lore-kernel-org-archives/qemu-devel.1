Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD41C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C41206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmqiRjlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C41206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeYE-0006sH-56
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:36:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePe-0008Ew-9G
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePc-0000xj-6n
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePc-0000ve-0I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id 26so3495448wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LvIqpLQh02Z6zWGECKaQkZCTeV0B0aLuGDQwChSB8dY=;
	b=OmqiRjlHCCJkSfJZOh8YAhoFWD5SuIpAIJmuOWmq9eLdoJqcjT6zDGjnwhwPvv4yjS
	JDCnnGxKBIy7/Fp69DdMLRSPm6iMtI3nS1zBy6p6rVmhBnVK42jXPQhrDnlbfbQ6dKRC
	5EKk6UR+7QZ1bnt8NDLtjhX528QqOOoE+qedLuqtmMNCAJ3RUYKlUbkyntZp/a9p6Mzj
	nJT2Ytpvhlb3mhlQNtpNDpmGmdSYRkZzy7GBI6AK0QTmB932LN/fRJvsyOYTo975ncLR
	eOs3x0xN+29aXKD2RbJD1koL2ypk1I4qejdsq0/3kGwO0N5+tAVqHn3Oyt8l09cs1xMU
	TGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LvIqpLQh02Z6zWGECKaQkZCTeV0B0aLuGDQwChSB8dY=;
	b=HgEfbuwKIxNKYXx17bu7zArK9r26Mr2Lp3y+StWhyl8hPG9v4i9ABgbuAdJ87XZfxi
	fMMh4Am/97tU6zXgUMRlpOaGNEPxgJoEKzg0MKWy6wycGHJvoSvrN3iC87NUJcy6I+Cx
	ghSftsXE8OFjNIDbPZEbd7RZgE2VWaEFU6UF1I3hpBJVFzPuB4YMP42jnKjChMnVaeGR
	aVVJqK2pq6HHzigTc44VcTs23rVVAQVX+BtSQX1DwhUilgUyvy79YPyBP/UjGbSGOFrn
	5jSKrPSzBjdx6C5/DeYB+EtCJZIuzE7/O4ra9UizqGr4HYNp18/c3yiL5iPskZmrHVVA
	7DQQ==
X-Gm-Message-State: APjAAAW8qf/BHe2MHo/1plk7LfxPz4jsuXdBHmcATQ7DQoCJ7MBEwhIP
	0Dd8Jn/uCAgo2/qT7sUcojXNYPvV
X-Google-Smtp-Source: APXvYqzWAgqswWCPuCCzICarXAsqXoZ/onaKpudnaaGT56mreAyLH4Bf0Rgp1HozRQ07xjKgrIcAxg==
X-Received: by 2002:a05:600c:2293:: with SMTP id
	19mr3451217wmf.77.1556198856770; 
	Thu, 25 Apr 2019 06:27:36 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:34 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:24 +0300
Message-Id: <20190425132636.31636-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 09/21] gdbstub: Implement set register (P
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
Message-ID: <20190425132624.P0dHGUcXoNV36Ikn4z4MevUWz2B1MaMkKxxO1W5o4_c@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 80f2a92da6..49db09ef52 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1635,6 +1635,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1879,15 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            cmd_parser = &set_reg_cmd_desc;
+        }
         break;
     case 'Z':
         {
-- 
2.20.1


