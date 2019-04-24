Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032E4C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1E4205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAOnH07Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1E4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNM6-0008G0-Th
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:14:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6I-0001z4-Up
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuS-0005XY-Dd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuS-0005Wv-6o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so26567905wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=neNtOgJjSERZhKri3cFMATtFZ1OMKf5FbCq0FcQMwkI=;
	b=TAOnH07Z+cvsTorTNSBoMjKMKHuBqad3OJP2NetmFpD0ayCIFvNP7cs9lrXGSteqxs
	s3kEBmxrjn8/uIEY992oZfNWiyZ/8e1++6Te5gM3fbX9Vi3nlTIL3alQRudtga9Lf+Co
	3Ad0ASgLL72m8JDX9ZrBVIk00GOgvxVeKMwy7YLKSNqiNFdP8ASH38dPjRZgolhPRFkf
	idv0HSmShCnlD1H+1PbC87vxE3gGXFi09iW2HKOCVvD4zSRDHG2YVrpWXkOzcn28JJWE
	p/du2UPhdJ+Pf9i0vtSimckfkraFl1kRbpU3vYviBLE5Iq22eUVadm3emt9HmUlnBEUK
	Jjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=neNtOgJjSERZhKri3cFMATtFZ1OMKf5FbCq0FcQMwkI=;
	b=tUHieMe0SxN3iUsN1wkcqSOG3onHU2h1r4hGd6keYuE8AZhjqgh+l8y+UnMOXRaZOX
	yJUiPYcSv4CltBXkvsEmSVqRLhpHW7ZR4nJugFO18+snVMYv2rtiX4MXvvYfgdltPUqA
	T3VxdNo/Su/fQltWxkAyw0Vkas4IlQk9kVECRfAWADFLE5rUehcLsXCPndFsiLF84Mrq
	XRtHmzLnJAj155/ZNpuAgFUyQx3S7Iakv5IpUfNErqpYb8Z01+seAOFGzPfLMcUmj3FU
	8Ye6VB56YKj94Q86OuBCYbroabFOJpnLUR8/DTmDdUEbc9eJccbirPBO7m1k/NcRBkXu
	B8oA==
X-Gm-Message-State: APjAAAWPFMo19pXW1Lub4C8pXP7iz6ZcKUZpAwcLkILSCNcX5qMugnNz
	kb9aboOrQL/Cqvt/aNaX1S0+mLBt
X-Google-Smtp-Source: APXvYqz6L0ouZLaQzt4/TZpujOvuJs8Z63hDyw46NLFhZoH3xPhzHlMTi+9oN+ZhyWYqXQBVy6Vh3A==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr22294109wrn.43.1556131578858; 
	Wed, 24 Apr 2019 11:46:18 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:45 +0300
Message-Id: <20190424184600.8445-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 05/20] gdbstub: Implement continue with
 signal (C pkt) with new infra
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
Message-ID: <20190424184545.FhSdewFs6zdzk4ANvDKpcjBsZD4_JML09FC0vuhwenU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 47b1e7e7a4..edcb7bfd17 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1542,6 +1542,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
+
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1588,11 +1603,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            process_string_cmd(s, NULL, line_buf, &cont_with_sig_cmd_desc, 1);
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.20.1


