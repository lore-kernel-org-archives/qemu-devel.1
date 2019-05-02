Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F3FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DB92081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDqjqAFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DB92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6B9-0005Xi-Bk
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:30:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69Q-0004HE-Oe
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69I-0002PW-FF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM696-0000UJ-NR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id o4so1817840wra.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6OoH0VZvs5cN/77prjtAmvXUSegJODVLc//0yGYVjjY=;
	b=tDqjqAFXwJr68BnN19CzUaiRGs+6eVQxZeg0KU+JCTUutI7KNF+2Po56qQ4H9PaT4I
	qaANfnbhBz29d2axuBxmHzWgy7IHBVLU/ntm71NN5mT1bSgs+UuhFXgquuJLx57pywn0
	5lXZ3E+s4vBilgYWc3wMnqxBn1VzRoQXNbk8qouC97/NFkNbHMsAlH1qLlNiuDZPLMYI
	WPUq5bs34+gWBt1lrr91CIt9FWa4atYFB8ORrbrIAd2RQm2eqxUczlRWqWt3fYkcrQLc
	HJcdGAc3hQ8iSYF8otUffX75xaZ0K35tzlrQPVUDhVom7arZCF7Ywkpsk27V53za7wb1
	0XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6OoH0VZvs5cN/77prjtAmvXUSegJODVLc//0yGYVjjY=;
	b=bS4i/mDzfC3PQ2xeCIIKNMGLdKTIk6aCyg2QBSsBsVabGTpna3/IH2IaFDZsoNPsae
	VWwxs6d4CYbK7nKn8RD39xewYaKfod6OXdQbVpfVjsHReGLdRK94JiX7DyMFYxrA+Au8
	nIRacsGy5at/DtdL7fB1jHqZY/0wJaCNZ3Fp9+25oImG8RiLNjwXIRfMN3GKtnC6vkYI
	v08MfEuyEbY5GcxUXcIH32kIhHGO6sqHCxPXep4DUA7OJBNPw6+oWzA11NZVYZVNsqnt
	2b9o1itA2AjsHMVK4GG7tL3pmjL0Dnp2IIqUzvcx9SaMB/w0DVo9xyU6AZK/ysAdgHLn
	wi5Q==
X-Gm-Message-State: APjAAAU1T035m5uEtUgyDLHYYohpsBiQh7jCsRSgKVK9qsKehVyLSIg0
	4VTZEgGm9asaWqKmHQSEtw/iRFnI
X-Google-Smtp-Source: APXvYqxeEzx0VgqKgI2eb/SAxHFPVixrRbRUb1ej8qQsEqqt1nDyayPkx4Ou2ZHiquVv/H2FTLNHCg==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr1599290wrv.131.1556782029808; 
	Thu, 02 May 2019 00:27:09 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:23 +0300
Message-Id: <20190502072641.4667-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v8 09/27] gdbstub: Implement set register (P
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
Message-ID: <20190502072623.rE8u3rHWaIzY0y_MX4UTuEpSWocfdc1PjLfMgAw-kF8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b42425b24c..10e3f12a68 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1634,6 +1634,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1878,15 +1899,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


