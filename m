Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C933BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9339E20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0XjVxfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9339E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNoS-0007mO-SA
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:44:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-0003qI-1r
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk7-00041j-W0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk5-0003qW-VD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id z6so168402wmi.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BRVpNhgZ5WsnuwctywQjKEVF66tNSOqIEVrbKsmJ4bY=;
	b=r0XjVxfYsmw3f0Gl/ixHs5CYZpN4aUPYe/bA/yf6b2/S11BG+6tPSjC0n1m9fmvAz6
	zUazPT/5cZTQB2ou294hpsTHBukitANM/2W1wjcjiprr6yyAgkHjPKD6PTGUpimpHX4k
	ZPCsDOvd7ZYQPgFTKNXyN1qjs27xsqrnmnod1LGlexuoCVLEFlsY9uFyCJ93/nZIwHFo
	LqT/NlpPXBXCgyxSRhin1AB0QH4Ru33sNybOjKwClcNl8cRvGFhiWk8exgiYqRbGgk+q
	VZKv7t0wMTjunclYmL2bJhK57ceR9VM4A1B+wl28OltM5M2PCP9TUYZSguxaf+cmOrsH
	uHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BRVpNhgZ5WsnuwctywQjKEVF66tNSOqIEVrbKsmJ4bY=;
	b=sz45Q2u2e5At6XASUojNkefrsSRi9nkYdhU6Of2TvkxLfrft93BnXlkFwma7H/uoOB
	vOwmhanlqg2oBgZprhFWoXxktID49s6DDuBqdtOh9ZEaNCH3pmxbEL11hxoytLat7IIF
	SePtQpVjKXdvxBvaOdAryO8XWbiDoIgopFTsyy2XZnSgIXnecABqhj5P7m6W0414tgsp
	sF8iNB8I56g3kWOzZKaMmuIbaUD3NR6M+dBJ2LmUC3MUIQNogl2/+d/1HRaUYouUwzbS
	VUKmipfeliXm1t07qktj+t5CsTh3JqlTfCvlN6WSPKSxHekSfg8vgq9t9pVHOz7mMwtx
	m6RQ==
X-Gm-Message-State: APjAAAU9nygEJep8DFoxiOx47g5/Y+Hz5YGG00zlReHmq5myBsf677iu
	UNwKLYdSxyBDp6q8gOeDOq+hpbge
X-Google-Smtp-Source: APXvYqwzO3k4HVoBJXh2eK3qY7Kq2xQ1LppLWFxbkF++gylMjXNwaV8WSRLiXUcHJYvFK1tS4vJuhw==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr565163wmg.8.1556134771454;
	Wed, 24 Apr 2019 12:39:31 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:29 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:45 +0300
Message-Id: <20190424193859.31817-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5 07/21] gdbstub: Implement insert breakpoint
 (Z pkt) with new infra
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
Message-ID: <20190424193845.wMDhoLfOszZMlSjkBZcHUrh_cbrxMBa-wkOqjHsGv0k@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 83757def9b..8e0446d305 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1589,6 +1589,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1844,6 +1867,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static const GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &insert_bp_cmd_desc;
+        }
+        break;
     case 'z':
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1


