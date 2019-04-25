Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E9C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90260206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X63v34Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90260206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57503 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJejI-0007pN-O5
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:48:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePN-00083V-JL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePM-0000Zg-PL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePM-0000Yh-Jd
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so9368910wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kSEspp+nMht4rw3L2fHKWXdmIbCLDhlRtKrruE9yvWY=;
	b=X63v34YuS0aGNhzdZdQ4TsRoLLr/sJ5vidr1h6KVLDlEzNimEa29UwUsXaN8N4FPU3
	Cjry6HR982WKBpeph84G3iq5/5kV6+4fNzCLVxiPaUIa4d8S/piuJj3XHxDAwDIKXwaM
	MHtCnM5XST2PAlco48kqiQ0E/eUj7cSYoeZ+Rb3r6mNCf+FZhvpYpTQnEnKj2eaSHSGN
	zImr6e+jr4rZNsnG3jDH/BNuPBXpWziTU3g33xWNk0O6JX9Li7GvBZF6l4d5yl2q5uyv
	eiqtksmVL2M4zoHSpZdrc4KQId+CmbVVeWemZw0BIiZMOiTKXxr/JN49l9kETb3fj++S
	5+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kSEspp+nMht4rw3L2fHKWXdmIbCLDhlRtKrruE9yvWY=;
	b=GINVuhygCZDU/jji51+I1GkbRyzEzslGml2g8YNHJIOZjsL1JHZiHtdOapqgtWTGus
	Yy0dxAx14z1EgKBV9GnZox7SPewsRV7kIxNhHonuQxtCVuKkIE9A0A2Ww/8+3Sokct70
	7cLF4crCsWL4akfQHceus0hTZwOZgvyyDbBqfj6K6qtXzW4LnKXt3K5p3JQmpyos6JA5
	ciZqSnbxpMtK/GqNXE720zawzHtTYsZ+Zt+e9E80X7hSoJH61vpBRguYqYEkpafoTN93
	jDZV2KK8SAt6SEq8kc6ZiCZS78ABN91JntxT0/nQOucS2L1dE8GJU7EHlLTIVl7KSXpl
	YrWA==
X-Gm-Message-State: APjAAAVR2uDWSXxNRA7mWKZkR/trCWUw2P1FCkUxx2l19K2F1v5CAVPf
	CUEyOay1GNes3PgZ6TTWqIdn/bKL
X-Google-Smtp-Source: APXvYqyrpDqtCQP10RtKrbcjRqcf7FFYoX2cR7YERAVBTqEfI8jU4qeZTl6OlXWZ7oHI2f/M9X6Evg==
X-Received: by 2002:a1c:14:: with SMTP id 20mr3793002wma.66.1556198842040;
	Thu, 25 Apr 2019 06:27:22 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:20 +0300
Message-Id: <20190425132636.31636-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 05/21] gdbstub: Implement continue with
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
Message-ID: <20190425132620.BhmpFaUojyCwOYjT7Fm4Up6HkpTJq8jt2U9sGLoPvt0@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a38f9d4ef9..8e922a2df4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1533,6 +1533,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1580,11 +1595,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            cmd_parser = &cont_with_sig_cmd_desc;
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.20.1


