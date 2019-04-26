Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4ADC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F048206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNzEwa2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F048206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsoN-0002E9-OB
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:50:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsma-0000dG-DV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbO-0004pp-1H
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbN-0004ph-Rg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id h11so2331908wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=HNzEwa2Nxqpej16GQ5d2qNjgFjBlQH0uqqIPgcirFaL34jxlcAFZ/bLLU/zT3LDq4u
	JuYTXWUGL8yTCXyTPLD9WnFyRxSCEgEL2K7w23ZkzwhJ9YdL/n++xMLWoTIr209QVdol
	3W2F6jg+7iL45iSxs+4SBW2FoH8D2IdXW5i5awh1P3RcX9Q527ccXw5dlB52gWIGZy/M
	pyauS1V7RDC3hCum1SenQb9UI9c/ga5eP9RFF1sVR/XGCZlhgOqY49fDktQfYdcWDlpb
	yjTWR5Cv1ie+udoGodF3VWdef7dPd7isa1d7T7jpA6XOx/jbLIrheP2PCn+V9VcsJniq
	ZVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=CkfHkmLdS5bAJrW2yiqXi3bxc0gNq7DK7IbKF4bn6+T9Cp5IOTiIpBE8tSMQZko4sE
	7AKP6frMMWvX+l7UMMMYtdJSGtI2LCOk00t99Ig0Qh3GZhSTPK6VsON6eOM/9P5TJTwp
	TxcSW2xtFAGlqCxtTZ1OfnupNFFJ2Gh/0H8WWY9IOdjIevkyhNMvCAV5KyFrdR/RAGws
	CKmegzDQZlvWgiGXFJ0jcP3iAYbHfr23Xo32OaurZggChwVveQhNQGkO5GBdPRRyirly
	pyqKm81i4pleoXcP1wo1fJDkMb7RIiLcnhf0fV1XVDIunUqii+9oBDgG7WOhCA3zT2/b
	yTNA==
X-Gm-Message-State: APjAAAWtqwHS9qEAhprhR4S4MxUHFD1041QRoJsz8+r2i9cxZPke15pA
	okuLpQuSZPVamDNrGwx6sPeYrXSz
X-Google-Smtp-Source: APXvYqwBLp/t7BAGM6ZRRHdjlu3iJYxA4T1kyxdub4rArJXGfgUbmy5XS7EH4JHyaFaOv8AmHls8Tg==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr5959439wmz.103.1556253404373;
	Thu, 25 Apr 2019 21:36:44 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:43 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:53 +0300
Message-Id: <20190426043558.6888-17-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v7 16/21] gdbstub: Implement step (s pkt) with
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043553.xTYRN_ZTiZT81Li1iDWIplwhb-Gotaf93Kfu5fNp9JY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9fe130f30d..9b0556f8be 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1805,6 +1805,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1937,13 +1947,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1


