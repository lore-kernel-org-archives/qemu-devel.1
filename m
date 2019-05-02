Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3122075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVE+MA8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3122075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47535 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7FJ-0006n3-BW
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YR-7K
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00087a-WB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-000814-O4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so1477857wmf.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=V970oHIFnq0Kvqk/KuBLurpV9POQpj8H67OjZYl9GKE=;
	b=JVE+MA8uHJmdGb0pXW0ZWcTkiPz76nlcXxZIt9B+wQJeN34fekZRHrB43J6t3ylSeE
	pl02kidL0wG8+1LjihpdMv02f+lxBXcw9VljMWUnASITh3bnGsKdN6KX0jH13c3XSWyF
	lultsoYIQV5LWtZDmiVYMa5n2QAIWJwF2z6PBp5hD9j4/NHWGXGPTHrSxmvXJSqEZpH8
	Soy84b5RL5v5EgdnK8pYENjnG8dg9vURT4Q/D0h6R/MJ9UEuo5m2pmVf8COvFpG5zwRG
	w5mkSNN8Fc2tSKKtV0zdLfbrhXFjclG3daDnrJUMIfdds5n8p8yVmEiFdWOW4fN79cKb
	vcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V970oHIFnq0Kvqk/KuBLurpV9POQpj8H67OjZYl9GKE=;
	b=E2yTDhGt6PtWGbC3Vn+/BSpkQ7fSYqOwK73GksZWv0zHqr0h8PvIqtMR4dc0bL2CAA
	TcqmXsXzLBXoZz+FPT70TKkCyfT9GHl7HG5feUQNzt3NIb7czLs8tooF7UeHXhEXFUUH
	EBEUsAFbRFDx9lTX5jYb8djpJusTkmwNRIQvxS9NjIFwZf+mLInPQa08rMpmghlUsDFa
	iGIhnf66YzK02RzSvJgZmgmZjLnM8CG6JlcpDCTqJeeeGmRPnQDD30msMuaS+Rrt6U+f
	a8MipxuNCh49vmWm+TyzN4w1c0F1wU4PusGLaM2nS7NFKSh7f2gJptv85wHF3EshmnWf
	ZVow==
X-Gm-Message-State: APjAAAWL5t1xaazwpsNhh9QUdFaiIOZBYtYJM/dcyiylse951Ze1w3nq
	ao1njnugbNeQQKbzbRS0yyA9H4Ya
X-Google-Smtp-Source: APXvYqy90wpaXB9zz/QH11hiJ4+j4LK3wJ8/RuPYRKEjsGL8vnxtEwz6bQj6vU/REiXLUU3kYzof6A==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr1318197wmb.110.1556785007725; 
	Thu, 02 May 2019 01:16:47 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:47 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:53 +0300
Message-Id: <20190502081554.5521-27-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v9 26/27] gdbstub: Add support to read a MSR
 for KVM target
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
Message-ID: <20190502081553.LIVRtL7apMXKydlgOHA9qjR1M-gE1v_UyI7zxa9xZX8@z>

gdb> maint packet qqemu.kvm.Rdmsr:MsrIndex

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index 34da10260d..f48c3a2b5f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2141,7 +2141,14 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "sstepbits;sstep;PhyMemMode");
+
+    if (kvm_enabled()) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";kvm.Rdmsr");
+    }
+
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
 static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
@@ -2166,6 +2173,29 @@ static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_query_kvm_read_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    uint64_t msr_val;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (kvm_arch_read_msr(gdbserver_state->c_cpu, gdb_ctx->params[0].val_ul,
+                          &msr_val)) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%" PRIx64, msr_val);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -2250,6 +2280,12 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode",
     },
+    {
+        .handler = handle_query_kvm_read_msr,
+        .cmd = "qemu.kvm.Rdmsr:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static GdbCmdParseEntry gdb_gen_set_table[] = {
-- 
2.20.1


