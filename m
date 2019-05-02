Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE1CC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E983920873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Tl1moU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E983920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6If-0003rs-5H
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:38:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69R-0004I1-Mj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69L-0002QV-EF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69D-0000da-Ez
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so1752238wrr.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=d6Tl1moUDm3a0ILDdl9JL/Wjh7Gt04bZJpeAZWL+5jinMNPsbKJCjs3V0bRi0Tyt4h
	udn9sH1oV1TqTMnI65p3Ie3yk2uNIeaF88IaThARkm8L7pvSYGAZlqwr2+FS86HraXzr
	VzVV6GlKOsUI+ixbbyJj20fLEOCb24tIfJBgEwp3xcHCsr+9DciBr3V8zVm2+xSkHn9k
	I47Wa69+MoVXRNKnsTo0Btw6/JWZDfcUkO7OEHVkeYFaADLVWZMQprsFUMfo8GwGXANc
	vWoVyvC+qv/epwzGGMGR4oRDAyx4yVY3THCYaAMRuxPJfO0bULVMW7OeRi/Fyu9fnU1l
	J2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=eFZnae8qKmQDuSxPrFQdwnz+/POvMhoSRVho8Iyx5lMfU2kewT0Pv0eOSzn+dFGVO/
	ItGrXyOccRvKJDJd7yFZk3oFosf/J1k6MbnsD9Ebx6aaUhZ1GnUgtU551XesayO5yw+q
	2gwms51iyUsHPbIVls2JhQ0bOpgZWCpYvApJNC+HRWea07yMV0iNbaVmfwsdYKcV4pFf
	ZpMqu40Qs7rFO4X865i0vuAZoIVtDHELhWK7UWesRb0pAcRtWFgO6Z+cqw199agc7bF2
	St6i4CEnK2JI8k3EsdPdI7t0oSeGnzc95c8MrXPg0jIH6dat7MUYw+BXKVRAat2AJ4Nv
	imlw==
X-Gm-Message-State: APjAAAXYbPTWCtMN9jACDbM0aFvtHzvIwWRYYho3PEeyvkn1DOs3MMgs
	uiIF76/XZ2iCTNNWQ4HF0orH0Ias
X-Google-Smtp-Source: APXvYqzNzeodl/noHVTersfyFO4OFGgz/0f6chq4x8cdR8Yc5svZD5lajj5nlSAtPoiDIUXgFcJSyg==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr1605893wru.117.1556782042747; 
	Thu, 02 May 2019 00:27:22 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:30 +0300
Message-Id: <20190502072641.4667-17-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 16/27] gdbstub: Implement step (s pkt) with
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072630.lysG1_BgRXI1kTrmZUbjDuWk6s8j6xY3UaMOXTRykw0@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9fe130f30d..9b0556f8be 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1805,6 +1805,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1937,13 +1947,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


