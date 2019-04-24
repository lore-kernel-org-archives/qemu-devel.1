Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F2C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB912183E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVYPvXLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB912183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNlr-0005AN-IP
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:41:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk5-0003l3-Ub
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk3-0003xX-Ro
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNjs-0003jM-6S
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id f14so26187290wrj.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bTkKvUXe+vJFlObggYTIw/quvUXexqXsMjWKRIC3GfM=;
	b=gVYPvXLJjxAp/kxxNAd0djJamELOt6/vYy+FOJkWAfukgWeYiU/EUnTB6YaFueHdsH
	bJcbe+jbjRMHuiTrEC5xucXKGhB7qpDsUWTN1Bowuzz5Nvqm/zkDG9IccBgnXrTlH6bv
	nQnpE+a0Ao22AlLYG9MTlM+KVEEX8chvbuaEC5SpVkmFCP13umP6yX4AWQNDxSj1KJwg
	HQ3yGU2oUG8e48EbyyPC78FAGhzhGhXcXsqTRKCfdbFLGu16ASEEmRJY7f0sFsCwUCFO
	0WmETT04T+PsNu/Ub9lDIgKK+9ePiBBXDFpqut9Sl0Fy60EoVlF6+8mC8Ve7+2jdji1l
	tlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bTkKvUXe+vJFlObggYTIw/quvUXexqXsMjWKRIC3GfM=;
	b=HdYvteAqt9oB327OsTJ50yKG7Zxf593wPHjZk3EmCN56Wkx2r98aypcCLX5z0LR8gG
	EVlxWXVm8aCHnDmAftor7f2MYCResWHyJFkLG4GfqNjQjQ+a61YzF6ErFBGtLL7pXlaC
	PBQe+a2ke3TrPfgfoatC86/UhHZMecrXu3sQs819XScP+BfHGOlBp/lhHbafr55rnmQw
	eC5rXaG/tSYo/wvXojakZ3Bcae+2CkB7UMAF9tz+iDlLIJt5bSM8O+hBuNt7tdT5BBNe
	rHpx8C1jENeGkxSEaiex4CwDiFVVAqf2iwWH2MlWCp995SPBeCmJ8KisH5lRdXzxwv5O
	x6wA==
X-Gm-Message-State: APjAAAWSWIY1V78k8+Yv9nOAHcO8EvsM193J+/0tPIEgtac8tw5SoU9u
	gnVKngsi2F8NB7OtFCyNtNlW5Vw7
X-Google-Smtp-Source: APXvYqzsvmi7om8WmdWYyxoxgb9zVf2UXGpjR6bYEmFIkmf0tLgr8bEZ4y1zkLMjqXDr6mIgiag+hA==
X-Received: by 2002:adf:9364:: with SMTP id 91mr2371575wro.56.1556134763203;
	Wed, 24 Apr 2019 12:39:23 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:42 +0300
Message-Id: <20190424193859.31817-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v5 04/21] gdbstub: Implement continue (c pkt)
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
Message-ID: <20190424193842.pq0PSTu5F415aGSp0qPywRXdYw8l5Yg9wVsVeoWFjxU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 29ca6be3df..a38f9d4ef9 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1523,6 +1523,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1559,13 +1569,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         gdb_breakpoint_remove_all();
         break;
     case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &continue_cmd_desc;
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


