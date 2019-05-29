Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3677C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B7721670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llp7jX5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B7721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsM2-0004YL-Rn
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:46:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHm-0000y6-NZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHl-0000HO-Kq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHl-000065-DI
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id y3so723688wmm.2
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Q93fkAMrEvzu0zyZkj4+7iBrZF/eUh2AH5ITql2fAuw=;
	b=llp7jX5jrtS228xwaO7CXpp8dgXz3frK0rn/LRAoYrnuVUsosdvEFU8vHf6DFbL8lB
	lEXUjyHt5u6J+5dw662Au04mJLshd2gNfulzSiZlBWJT5TLScvwO0iOEAOs40DZeSXGM
	q5LhY9meWm4P2lQPxCvpOVODgn46AwwMtoVaHn6WxqIzYPmyXWb0+5c4lyCGB3Nb/+z8
	mnhxTtfyufB4GKuZsqldDm9dvsblZZRlY0Ne5RwCoXx6pZTj4KudYJb1hDkx+nGdTA7t
	ojKGZ7JO9qM3VIYq0Riy+PreIFdDrMZsFuA+2dzEScEEm7eo+HYGtve3jJhwxAa8pZdB
	c3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Q93fkAMrEvzu0zyZkj4+7iBrZF/eUh2AH5ITql2fAuw=;
	b=RQ2JN6MSFUyywcJbTeU7U8VoNynNUiXOA0nxYCt4TerLAJA5ePm8hJ8BIhQptrl7NY
	PVWmWPEzFBJkbbqE+M/vS8qIZF6aCOGtIq+etDS1cAgLms1pAMZrXFNsG7JetRCH8F+G
	7VOvDAUvoRelBkGMAZ9Rlu0l/Xqo9YKI7VWEONVUVIFWYNwcTSYpg4/cN6wY7k3rENXG
	mKdTKxxS6G3edMtAMdqgLZ3hPBK8d32AuzC3fMfM8aXzJb4jVrH5OMeIUwB6vP8t13pp
	pGzPcWjMmG85xcdeRSfmzT/ZrXhYFmRx3TNsGxTNX3Tbkdvb6jP9D2q/Vyc/KC/pai6t
	QHPw==
X-Gm-Message-State: APjAAAXzTftRcMyqhUouXnQdojA9GVcA2pyuEY+583cQQ2cuPPRN8zB5
	J6/FsM79X7bYVxLUCQ3rKlmairuI
X-Google-Smtp-Source: APXvYqyD7lHuGhAPQV8e/oWvtZp59igvCuLeewguQCECWrSZdQIC5OGPCL6bAzUbEIKOsZd2FelBJw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr6043579wmi.50.1559112124271;
	Tue, 28 May 2019 23:42:04 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:03 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:31 +0300
Message-Id: <20190529064148.19856-4-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v12 03/20] gdbstub: Implement thread_alive (T
 pkt) with new infra
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1db322c15a..7801f2f260 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1507,6 +1507,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(s, "OK");
 }
 
+static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1807,17 +1831,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'T':
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-
-        if (cpu != NULL) {
-            put_packet(s, "OK");
-        } else {
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            cmd_parser = &thread_alive_cmd_desc;
         }
         break;
     case 'q':
-- 
2.21.0


