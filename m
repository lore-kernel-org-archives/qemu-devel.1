Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066EFC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED3B20651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8/EocMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED3B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6yB-0006sc-Te
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:21:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YB-0B
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00082k-BW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6ta-0007Ju-8E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id o4so2022997wra.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=x82aHJMzl8f+PCXWhu2ZX9N8tzch1kuJG+XquT6URF0=;
	b=j8/EocMQSN+YsSPCgf0Jxc2age1N+MN2UfPqQJJQdcZGcYi+kGlSXtekV0qyeps2WT
	6ZvRLWBjN7oEsLHKZBlbNqYISG4rqkH5a9mOfvmeSC5RCV+UyeXAfmOdf/0Xvyxf3WoA
	pWK0eDDukQMVIE/yaJKDDrdzBKKjSugkH6epUi0hITfAQIv5V/9shaqKaQITI4ixOzbd
	7DLlD2/6z5fo3D/B9+wX7bFjHsMVdy2Sz/2VEXH9hwCl3GSa7CyemLQbxuIjSo3bPOFu
	OOnylwm8aAw6LgcoAcWoC1vGP3GdUKLj7QXv2ci2zu6iI8gSYP0YTcIeqSXnLMU7FqQB
	eKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=x82aHJMzl8f+PCXWhu2ZX9N8tzch1kuJG+XquT6URF0=;
	b=R5GcpqAqAlkE3ci8iAw7j0Qi4eQ9DNouL92doEMEhaSRhMVrbGlgZAFxRoY6SRcXRk
	TDSFgyZS7oVlzxW71rbBu70V/LOL7yJLx+qU5S0+CNe23FF7x/Ec0fYOmvDac4GTP9Mc
	O9xAOM+ubougHWsuZL52JWFzfa4pCo7ygeH4gaYh1R3tNAQ08P/vBXipUhBn6ZxnuEZN
	3KVMjFAyZTKyER0TodwIvC99dMOuFKbMaMUdh+OQK95MCSFUR40IctimbAY08nyKtnB1
	CuyMpYUDEkpWq4mbO3XnrgLtMZTe97GdPo3SZuxDQ5eLh8SNKSI0KKBFiUf7YqcjAypX
	cC7Q==
X-Gm-Message-State: APjAAAUYxYFtBQ/ndwpiOSqXmA5rJhliz2BWo6+GRL31zoe3ZF0KBCH0
	m/znMPYxteQN6kM7m/KI9vjssU9F
X-Google-Smtp-Source: APXvYqxRS7sDRJ4yxgPWS2XIChyKLpTupJZtmYzffTXMyBjnrVlXZjHz2IMHhKPrVTYmaP4cwfLM9w==
X-Received: by 2002:adf:ce0b:: with SMTP id p11mr1616830wrn.196.1556784975880; 
	Thu, 02 May 2019 01:16:15 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:15 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:32 +0300
Message-Id: <20190502081554.5521-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v9 05/27] gdbstub: Implement continue with
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081532.39PCYWW_kaCmZIDHBpCtxrX6DhjMaGxVpahCkTTbPeE@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 89f1ab6524..469aaeb875 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1532,6 +1532,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1579,11 +1594,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


