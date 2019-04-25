Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04DC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DF2206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihhUK6RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DF2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeeq-00048s-TF
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:43:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePJ-0007zQ-5v
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePI-0000Th-8W
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePI-0000SK-2H
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id 10so9372350wmk.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bTkKvUXe+vJFlObggYTIw/quvUXexqXsMjWKRIC3GfM=;
	b=ihhUK6RDAZh4WQ3g4tUu3L3Tybx9rZXQNXTEmVJQEWKAK6nFJhsA/K3dyPkLqgcGng
	RCkxVjZF0YL7HvfBnuq8rsUtDpRLqtHWkoioRBJpDvtOqVSPxoq5X5YGwK4qFwXtUlfu
	X44WpfH8lNwQoYL+q9MnFaCVL4lhHpeFGjozYcENMXH2PbBo0aZOOMPAdr7/TpzP+BRY
	KGQB5RPoT1KM4YG8s9TZGCls76tzeLe8n/Aw+PJiYK56s1+Yx86WcSmsvh8Ia5nN/AEa
	JnvYEsmiZmeHJghcl+62brO12jNvILihIF/U6THmNFwxmXz/9eyvx1KDiTEH2zUchBDq
	sPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bTkKvUXe+vJFlObggYTIw/quvUXexqXsMjWKRIC3GfM=;
	b=t0PyPUCPkhTvIvmb8X3KaFDiwIRacNH+9fBLejRuDSWDpc55Y4uC0kZ1w738nKNyat
	KUD4w8zGq9LeJJVqBIqPjNLq7cAgNdrDJmziuU2MXTsSSYCIaKxPHWyWj0OtFYW24dm7
	zcP64y47hAoNLk5Uh/1YrfDG7HjD5p3RYsq7HSZqOm6MCElM9CXKs2UdI5fmy2T+8Ial
	+gLpf6w0KbrjhRJFGhdl9a96FkY3gCEzw7XwsknMekAF1mJvai0ZhSA/qHvbFLyi5VSl
	Ya8OvOqXUnMJRXgJKiw0tlzK5MnmDZ1VykZOQtlDeWgXq8fH0rSQKRKhBrsfMGanYchD
	iZwg==
X-Gm-Message-State: APjAAAUi+Wo3htx3+UnPkcklpP231bAQJ4jKVDIzYh3z9DMKWFPgsCgP
	3MPH3zFpnx8eS35eubUnrcfcuOXM
X-Google-Smtp-Source: APXvYqx54OANFaYbvbhubYcRgl8dZf9EHKn68dDldF3z8WWLWjLIKPk55DvZUzRgy2JAWzXNceN+jQ==
X-Received: by 2002:a1c:c7c9:: with SMTP id x192mr3610756wmf.151.1556198837806;
	Thu, 25 Apr 2019 06:27:17 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:15 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:19 +0300
Message-Id: <20190425132636.31636-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 04/21] gdbstub: Implement continue (c pkt)
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
Message-ID: <20190425132619.AtVBNQBZsl1iWoL24z3pt2aHISVbXDGeGncMof_cPQ8@z>

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


