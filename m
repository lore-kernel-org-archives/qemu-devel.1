Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE0C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC49218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hesPEGVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC49218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNoY-0007rO-PZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:44:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-0003qG-1U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-00041r-0N
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk6-0003l7-1f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so4174867wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kSEspp+nMht4rw3L2fHKWXdmIbCLDhlRtKrruE9yvWY=;
	b=hesPEGVgDyrdExE0KaVQMQy6SaW221OM0X+/FntKvaGs42FxodK2BLWO2/C68ygLOd
	2VkTZQ2StM3Ew7c4FHXOt9vtIq+JhBBkphLyKZd+JT7GF/XJbVgh9Ar3eUCIGM/LpvjO
	kCMkq0I4PmgVnTtSdgUUKq4iuc8FP1D/GxjIYu+6oh4M56RdgyFsYKZZObDHCTTNUNF1
	+O7i3jdEsbtRervpokaCOq5OfNfnOI22TiBUwsiz8+3XlDpuLsPoYo9MYmw2ESY6xFrj
	e5jxGq9YZ2hnClt/IiUCHJngSyHeHAOY8Eox1mDgnwNQy4X8aZQ9ecQBv3MHMibQQrqT
	R2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kSEspp+nMht4rw3L2fHKWXdmIbCLDhlRtKrruE9yvWY=;
	b=FrAMEpkqPO/cMewUzdU41zFKHtrzJ84cQ8+cHgxuQPNDKEG8sM1JsxPCu0SRcVF2Dg
	MTgHqsyzT6V4Q2dkoVlesVBFDuOapQbcYueCMvp3ZH+H/xDsLf0dS+UWIXLKfahwt732
	tnjaJWRb99sLANnecEXDiGCke3EOJOn3n1QJfKTGTkuqL43KdSNtjbT12wKnaRN91/QJ
	yxlbIJOYZl3WxwbWfRU1Qma8ksnhfHUWEXfWRcaN+OZO9NPZYA1lmUYZoACkhnIBWSDs
	voyytxwzdx/qwBqZRRWYUOVXyDRIGNhaMJIRDx4uGfdBBVR7vTpBV64oToupr0uk6Z8n
	TbmQ==
X-Gm-Message-State: APjAAAX80Dd7HZqH3m2LvsUkSY9spK8jMKGg8rnAyXIrNa4ONjLhKk8x
	F0DawZqZ0bITXB2nq/6ycpFQSMbo
X-Google-Smtp-Source: APXvYqxjVhStFs0sYGv9TXKZSIiMdryu+6p0FJHC3uAR8ZETj1I7pdjFxQappIotp95HWJIq+xUjsQ==
X-Received: by 2002:adf:e684:: with SMTP id r4mr8940600wrm.169.1556134765582; 
	Wed, 24 Apr 2019 12:39:25 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:43 +0300
Message-Id: <20190424193859.31817-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v5 05/21] gdbstub: Implement continue with
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
Message-ID: <20190424193843.UABTFb3YAxg76i1XsJeQvsgpJMpeJrqQlQf7uGtO4Ss@z>

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


