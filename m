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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFAC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919E321670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIEISxmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919E321670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsM3-0004aD-PA
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:46:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHn-0000yU-Bu
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHm-0000PU-B9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHm-0000HM-5c
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id u78so714592wmu.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=c/H4UbLodN8W8KnJQVGCVD1bmZpUHc1MnaG+rfAIN+E=;
	b=SIEISxmMolQDrhG1dnDnbWNdtxnblqb897StG2V6efQL0AC/aXaHq1SmaisjN0OIWP
	M1boQisYwgGkWJ4471I6tLlfX/MFWcdCB+2oKEwTZSK2BpO+mUNC8AfzDFRom0DmYr6b
	QJjilEreYg4WoPOAC7UZ8NVOGaHl95M6GE+A0hgcQe9quCwlBGgJHSR7M9AotwB6lu/F
	MDYcob4hT9p7rR0mg3CoSZfYL/ATDLHBSgChDdofI07x8IYGYQGF4/8eYk3A9jVaviUS
	UEqi/kD0DKJItUXmF4voX7LtUs70zPrNsU3C0EDqGsXJ6vwZVHbE1seze8eyugHhO0zZ
	jzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=c/H4UbLodN8W8KnJQVGCVD1bmZpUHc1MnaG+rfAIN+E=;
	b=oK8IcdiLfs77NbN9Iwkdyt9lYspymjlDy1FrmIoaKLJTGmIn9k0B4Xz6w+ibTavPZt
	ptKK+8vCe+Nq31vJi0osztFLl8Ite4pS0URJu7FGpRJA42i2JbOsFz7XNi8PqZfCZ6Iz
	qnljbEf21mFOE51YRMDyhVEox5HT7gjB1hngKxcDre5LBKY4gd6mDgyga7N67cC//Zg1
	SEChDSKJnitCVR8//hys9PLQbdPji93YsZCyTI46bDR+Rd2L3C+OId+VqCORlVE42LeI
	W5ftl/PC/v5jnvtzaLuR3vMApyQho6MUzzK83jXqTKWFcSrCe0IfmYP43L39VXWdzlp1
	jNCg==
X-Gm-Message-State: APjAAAU70TDIcAO/BYHB3IDFVT9fwgnCnLIR5RyHlAWX0xuUjNH380Vo
	P7sUJ5EPrrAz3Sfx95BCTSfDV3gD
X-Google-Smtp-Source: APXvYqwoZd+xvoQjhyhn02a8H49TIhWf+B3CFeARO7asJgRwRid7PH8XHXx2ifMV8gOGzxdO0JEXEg==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr5939617wml.0.1559112125157;
	Tue, 28 May 2019 23:42:05 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:04 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:32 +0300
Message-Id: <20190529064148.19856-5-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v12 04/20] gdbstub: Implement continue (c pkt)
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 7801f2f260..99b78aa426 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1531,6 +1531,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
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
2.21.0


