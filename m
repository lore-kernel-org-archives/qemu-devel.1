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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7365AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A9521743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZuzxbkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A9521743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1gR-00026V-5A
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:07:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z6-0005gX-Ta
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z5-0007S5-UU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z5-0007QR-Mj
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id n25so386447wmk.4
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xXa3Ieic116CoIniryuXry26xPia1X82hROPrELVOA8=;
	b=rZuzxbkhZnXv/Y5//FTd4yQTcFQYWr7ck6UDBDrbx7SOYSy81JW6NoWFyBE2HMCbRp
	U6dVHNSjZioaVhl7Su/x/pWLIKLeJUo5c0s5BhSiO281faEDyJgzAjLtgLeHAixtYCNW
	lk+o7N+c0b2Dy1kjP/yCmcr34XuYsCsk/F6jOxehp1vN/37bVnpd8MByt6eCDBbdWZ7Q
	yrBTxj9JChXV7VzxWsCm1NvKa6FaJEatQM5fHohY6DqfmOiLNtV1qLMi6OreitQFrPwi
	AJzPjc69I0iPXQLAhk2EwotiOdtzWxZM3nk4YyVG8IuVE6wXSyG+mHsvNu5KL+FLPU1h
	C8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xXa3Ieic116CoIniryuXry26xPia1X82hROPrELVOA8=;
	b=RQa5rzHniOHUuCDpYbup4AMzFVPZFezFgUG6w4ixH0N5vkMe2u44knuLdnADWb5t0y
	i9I+I7nOEiwjV3f2a0qmlSZ6BNTsNNkeC5yVI5+qKpUXaOTVw4MFDd/OFKIsiErR8K5S
	xbY1BkFFh7ITFT0Yqr3eR2dFgvPV01L6oH+9TyRi+8UAEzb5XVbmxBFfujwo8jYaaiRL
	ktBh6DLZcSObHTf7l7z+PDkL28OVQr2dxzv2aMgvZBNPXjNNvqx6sGDINdtVsE+P87Tb
	3A5aYFWVInxipQIa4TdxxtLMEGP2O4q+vUss/JWnJqrGAMRcK8vVQP9/aDsHGkNYYyZo
	5bqg==
X-Gm-Message-State: APjAAAV6d87jF36voDMOkXNTZlDi0efi35swUAzIDjSKVMIUMOvTYZaY
	mTKhJFq0hyblFlx1ZvZx/k2KyiO4
X-Google-Smtp-Source: APXvYqwOK1SoVGCt39s+E/sT68wuVtmoTu1W37VZ/vtERt5NcngN7kX8u6FtqPIz9xYNloPF3N9wXA==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr2615714wme.121.1558432810458;
	Tue, 21 May 2019 03:00:10 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:33 +0300
Message-Id: <20190521095948.8204-6-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v10 05/20] gdbstub: Implement continue with
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 698d6f558a..f74a30da03 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1527,6 +1527,25 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    /*
+     * Note: C sig;[addr] is currently unsupported and we simply
+     *       omit the addr parameter
+     */
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
@@ -1574,11 +1593,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


