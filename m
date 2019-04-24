Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D2CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3F42084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/1uvVsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3F42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJBq-0007s1-U2
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:48:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzM-0004hj-Ty
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIrz-0000P7-0H
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIry-0000Nv-Qm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id t17so13736946wrr.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zogLByT0vx2z+qQQ3qhral7Vpr8Eyy7znh0LZW+Yxhg=;
	b=e/1uvVsxtgdPOEE9ZEPvqOG1w6orTvjZruMTf15SbWCxJILlsujkKk72rua+tw+GUp
	tiYtzgGo2eOHOwvtEcz0136qMiUzs4hthRaTxkom/lrqj/2tDs2pp7+TFCrOcNVPmXZo
	PqERTFmlNxgad1SIhIbs06bd3NuHq3gH4uGCLebuh1gQqnwe/ABhHpqp/BuYvDdmeDKQ
	vSs4UjAg6oaT9XPTOV5crhLSvJlS7PMetI/FDWb7Box4YY3yoe00R9UUKYXIlxEHOauh
	iALkJzfwCFFvI0XbwXnZtElklw6LjMVigpVgR1la3WeTGNl9tTt/qm/DbR7XBX1sKZGi
	vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zogLByT0vx2z+qQQ3qhral7Vpr8Eyy7znh0LZW+Yxhg=;
	b=ZrpONrBfMICOYoR8M3X36SmZ1E+bXQZWo7UggYPxo30/yp0EEc0kTehiTv8T/no8qh
	rapnE4ZNOfeWj82bU34dDXt0+GRzb+6PRg7EhWkHpMuj3knZojvHcYqQm0i4EjunCy9z
	BggvBKduENuNzr4D/i1Q/s0AO8WTJjXYwEKI/00cx1ZKA3fvK7aZW6S2A5XG5qA8TgvU
	ji1ayPbmzFj+xPu2/Ww73Iu+OUP+vghuHefXSFpoLbvZjqzm0+QF4FBpPffbjQ9UFQzN
	v37hak1WGbiUI+Clk4LAotJEe9iXWL1zHmSvQiefTujsgic50eQnCC2CbXpIMln8P9c1
	cfiA==
X-Gm-Message-State: APjAAAVlNSwQGZ68osjJm+9ghVBbTXdH0ZxH7B3K/PpZkwLsZyNU43m0
	TyRx1oyPSpk51qcI/1UiKmFk5ZUP
X-Google-Smtp-Source: APXvYqxwIyjtVxdqZPlYm8H6a67VQ4jHZz3VnYFnLoNCCteFyq/AOOoy1/O485rNLuJFQZOi38iFgg==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr23487367wrd.284.1556116049341;
	Wed, 24 Apr 2019 07:27:29 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:28 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:26:58 +0300
Message-Id: <20190424142714.28460-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 04/20] gdbstub: Implement continue (c pkt)
 with new infra
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
Message-ID: <20190424142658.k9pm9W2I9dIyv_D9cetN6tBSijdUcHV53GeVcaYD8ZM@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 435b492b4f..a6d5acd6f0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1538,6 +1538,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+    }
+
+    gdb_ctx->s->signal = 0;
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1573,13 +1583,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         gdb_breakpoint_remove_all();
         break;
     case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static GdbCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
         }
-        s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'C':
         s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
         if (s->signal == -1)
-- 
2.20.1


