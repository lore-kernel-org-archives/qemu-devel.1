Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432E42175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjPbgX/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNIc-0004qa-CY
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:11:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6J-0002Db-A6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuQ-0005Vl-Ox
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuQ-0005Uw-JI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id t17so26522679wrw.13
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=v2Jk8AZf6CSgcMOABMStz0N0NK0P/gFBS8PVkAB1BsY=;
	b=bjPbgX/Z3AfsN1esR43cy+zEoxoKYG4EtxjDHGqVN6Qyq89D0sKRiSbKCPxl+mPRA2
	Fhyghx0EnBydyXW+rTe8nd+BIjEbHxJ8QwNqn7pg0x2b3xh3DV7Rv64lZY5I0ZVID70X
	cmW/n4aqslQA13s7PiOOo0FdPlO8zUjpwoxXVLKGNgkpiwdau7GJJEFjLXtH/m8lITX/
	yfsEO/9zBexVbtQn/62KnV5LtNRse2zVqdlqNsJm7/idaHjzGY+ddyQX6rtu4tzKTYWo
	Wzprd0w4YYG+4XPlz+7GeZlgKpaugCtFiWZkuCv92DN1ioAFryxOwBg0VRrT2iLm9dxh
	EAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=v2Jk8AZf6CSgcMOABMStz0N0NK0P/gFBS8PVkAB1BsY=;
	b=fmvXfj0uNHbp0wly/axBCf8X0hE1Al0ezKhWNd0JvAJyaR5TRaCR7r3svaC8fKFZ19
	C7zrw2XR2BrIrAnAHDWxebANYmgLKtHgQbCgrDUKyjZcm4JLn2aWNzKbwv4pLLJw8R72
	R/JSER84VMj4pepcEJyAMKdfQyFxiK2UUPACz4LH081J180XPx5nkDmWgc/Oq+TNjr76
	lZuq0UrgzBiN/ml0SMl/BaodSkeTyTaJQ1jb72abbuQ7SbaEhXC24lE7zQgw3LPui4l6
	5N9DFEVxk25PPIyCE4PI8xFpPOOLg9VIdukzUKkRAhteRqjHYI5oRn3VwA/LXq8TFoB2
	xJGg==
X-Gm-Message-State: APjAAAU6oUM7hNP7pT82TGb/ADlrcl8YM+qxTdkzSeZCkQSrcj8YwHn5
	q9xt9cSDE0MsDyvfx5R20V3UB2u/
X-Google-Smtp-Source: APXvYqz52nEBbEopz1Yxij4SWzRyynFwQMDi4pGZ8Pp2XN93oeuH+WtoE4BmckRq72jBVTiGc2sbPQ==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr14072992wrg.215.1556131576928;
	Wed, 24 Apr 2019 11:46:16 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:15 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:44 +0300
Message-Id: <20190424184600.8445-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 04/20] gdbstub: Implement continue (c pkt)
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
Message-ID: <20190424184544.4HZp9KuCGvJq1LWXvUMdT3JpMUsBh2ATi3seM9q7kk0@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 7704edd69c..47b1e7e7a4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1532,6 +1532,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1567,13 +1577,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


