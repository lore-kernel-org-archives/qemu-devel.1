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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A283BC07542
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7454F2081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK0hhyXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsS7-0001hN-NV
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:52:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsI2-0001Eg-U9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsI1-0003Ag-Sx
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsI1-00034Z-NM
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id 15so681108wmg.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HQvIxbBUXHhlW/4mbYuy+l0vzsqWjiYKQE0W+h99nC0=;
	b=qK0hhyXUh+SDMxhjiIw9CmYJsi+W7Xu1t46UMcqIbtiRzgfEAIqrgjgbEEHFQEoglD
	8X7+NPOjLm6/v2Bz+eB+NlMZYCMyS231MmmOTpW+5Owq6HPN/+jAjdN1IBemKn+c5S8h
	MZbOjiLcfK7WPPP/O6/bocnazgDWMtLi5q9EX2Gdo2U6K7U+UHx+TXMdx9xphEGaccxT
	jkR+rgb8crjTc2d64YVzCLk9XAhaq77HzBSw4TExRP3gtBgjl8HmCVAWXuceKov5WHfN
	xoeTxFTpdW891BCFbFFmb7pkTRsqHdIHsUaqOq1t6VXr7NGjcM7YPC/4xcPoQcSXN49K
	DAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HQvIxbBUXHhlW/4mbYuy+l0vzsqWjiYKQE0W+h99nC0=;
	b=A4eeYgoeEJKpNbOvAJE94hubVMwg65UaU6uXmYewsROX07rkq2Hjm18x7N/zuagITn
	K9v2hWncF3EvrG8Xl+XYIgbPjoj6wbibCcw8SgTlM7JVE91vHf3iNYkNbpYkvN8N3eVZ
	beHfc7GxGr29Q6u5hEWId1eT7S86uxbRVvZPWLBj2qtJ6K8nxHTCCKqZVutL2Er0XE/P
	CwtfJ/k1dGQ4jmTYYgS5AiV7l8VLo7OSqe03oH2rNay69fcEdrZVmCCJevxHdZBF9Ncv
	XR2z+xVeK5jkFG9x9tkN9KHkTJwjyqB6UewuHDHnQCtB4BhDnu2DBI6hLQBS1cBdWBbP
	lyhw==
X-Gm-Message-State: APjAAAWVv1qmBoczMvssg1MzV8ftzLgpuLIxd12ya6xNGu8hvIyBRfnp
	+y+Hoff/57/2L0Au3W+RPsCgPsNc
X-Google-Smtp-Source: APXvYqxo3R3BXFr+2CDcXkv834nIz+OL9qYDPevKsJTHB2bDRRbqa0BZ0DQ1gNOQMEPpu1dfPLlNaA==
X-Received: by 2002:a1c:9ac2:: with SMTP id c185mr5400301wme.72.1559112135202; 
	Tue, 28 May 2019 23:42:15 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:14 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:43 +0300
Message-Id: <20190529064148.19856-16-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v12 15/20] gdbstub: Implement step (s pkt) with
 new infra
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
index ea85966b27..3fd1a1cddb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1808,6 +1808,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1940,13 +1950,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.21.0


