Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE53C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6575D21901
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+IsWB5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6575D21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ4A-0000YJ-5q
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:40:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzH-0004gM-WF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsa-00017p-BP
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsX-00012Z-Ta
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so16587826wrs.11
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oNvYdC4tqKz4oI8z9errxHpODrCC+7dQMBIQxEmmSxE=;
	b=u+IsWB5bpHkYCUt5c37HEw1GdTJ6frytUzM7iubbRm3Vq2iuMCRuvwlrwvz+EcrxrZ
	0TC+OF5TSEikjjrwNeZfgdNO+wcx2IGGM9pmY8Gt1SLxPQFE0HDnjvC8s21clxSwmUl9
	5Uqx28l0ioA2niMzowbm3Pn4vh/xU6nOVn8zkYw+vsi3AOVyIkpocD/lBvm4nM9Ri36z
	ehCm4d997n5scIe3RN8PJAXiRfiwhy4eqAMAP0ZcI3Y+Dh32Ps3gf1efobQfryQUSKmd
	U/YEXQaO6wYkKK6hsFQnLPXEqwNigI/438ZZQz3F65lPeReq+Xob2KpglVqXy2I7SG3M
	koyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oNvYdC4tqKz4oI8z9errxHpODrCC+7dQMBIQxEmmSxE=;
	b=b1LpQ2uasX43OzkyEK2si0AZDtbTDWEcx1MXbWDMBnFQw22n7CcxdiWdOd/HRyHuXm
	AjKP1OLmZo5G4z9GCWMtNP1g7J6QPAiJJMSj5D0lWX5sq52B391o2+y+juuK95oHB7A8
	xvNukV7p4tobiYnMvEG39yJ+4TK5tol4IRO5/OyO/SJyMbPkx7qSWwQ6P/HhjIBR9SXU
	k1PsyRAz248zl9wzEC+yhhQR1AIaQpmpPP3x08gydDbtyBteJDjYvtts2arqeRf/3Fx8
	rJ3JjyrL13tzoTz2ka4wQEkaOeYARUGICMqzDUFYaG920QbXRMGDp7K/35GRh2Kmy3+D
	jiKA==
X-Gm-Message-State: APjAAAWah2thpDarb0AtxkkY9vQBTk8JtAw1FtHmHFrYi4itWqn0hjMV
	sfLZbl7SZwMYdFE5pLtx/BtUqnn5
X-Google-Smtp-Source: APXvYqxF/PbkZOKfHCsblyCSfd+E0YgGBquzwxrV7rWewsEKS2HrI5yPRViahNCiIBRF/kvbhqwSdw==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr22567523wrj.66.1556116082024; 
	Wed, 24 Apr 2019 07:28:02 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:28:00 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:10 +0300
Message-Id: <20190424142714.28460-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 16/20] gdbstub: Implement step (s pkt) with
 new infra
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
Message-ID: <20190424142710.oiF-OUJ0pIUOrRKFnRegvYHNJmXGZyfLI33bGBgMIjE@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a71fbc800d..273216beb6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1821,6 +1821,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1952,13 +1962,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &step_cmd_desc, 1);
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1


