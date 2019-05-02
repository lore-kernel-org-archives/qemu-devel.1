Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5705DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BD02075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHWAX6VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BD02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7IX-0001Dp-Ap
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:42:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tk-0003cY-Rb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008Oo-Du
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6th-0008EY-1X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so2034714wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IQ+Z9R6NydncJMKRI0TwB1Gcuq7KLY744W/ZlSezhlU=;
	b=gHWAX6VNFtWqbR/rCkEIGTs4FXbsFANrgE0ZljIZf4DSTjutF2IQsA2zA/17uDVPG+
	NA2q/6Cg5bKcv42S6eDJZ8kcgnS+W9jLOcYdazQgw4tTQhZkqWmS6Mz2X1cylDVV8pTR
	Z9SXKFkI28fHudGv4DZSy+sAvVPSv/uq7BQN1/r6/DFjRq+9FtdE1ms+VrfNE2bltqOL
	VqVMJ5ygkTFOP7dT91o/+WLuWLDmLlEHWiXRhO2bUr3j5a/YKf5fLwZXA45NHWFkqODD
	kyD/MEi0fJuJZaVJRL96/0fEQc4h4/s54ID4W6Ym9riIWRuwEFs6SNDml1VWmgwWymkh
	EI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=IQ+Z9R6NydncJMKRI0TwB1Gcuq7KLY744W/ZlSezhlU=;
	b=QC1ukT1k1DEK6NJRk00T8zLR/mSkXHw+Av1S06BS7oPA5coxWV9gOoFhsxqB+ElREu
	t9NUK6lOH+ZldFaUPlRE3jwq8kJxCoSzecjasbB+GS6eSK2KYbjOyoKVQSmL7jLm4/Qd
	y4bLNtP47/U1ZYeTxIg7bWimuAQyjdpARMHVkhYn+twlXkeyYbYEY30umZAcbgMFNqh8
	Hws4mArXzWWmi/70mv4f8QQ7r5pgy/4ghzNAqIdBf7OadSSRgiJX4Dww1iN/XriZ3fiU
	EkArblD/Itj9k9Jk4K1aJuiziuAyZ1mnGo/FTlMRHXC3SRpb4uhYCGff/4AJwYJVhoP6
	8Yew==
X-Gm-Message-State: APjAAAXXzN38hCX4/67BmvnMQXMM+a/JVyWP0U679Vk3IFwoG7TPJ1S+
	Vp4atDXT1qp22K0rKnd4diov0quU
X-Google-Smtp-Source: APXvYqytfjUxf8Z1vZ0yv0EDziDtIlPnFjJOJPPleMUewruz/fwDuSv7KxIk9ilBAF9aDVl0bCFgYA==
X-Received: by 2002:a5d:4dc1:: with SMTP id f1mr1753355wru.300.1556785010899; 
	Thu, 02 May 2019 01:16:50 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:50 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:54 +0300
Message-Id: <20190502081554.5521-28-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v9 27/27] gdbstub: Add support to write a MSR
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
Message-ID: <20190502081554.Suu-S67jQiA2Ur38KOZgCIG5jy4-WwfaFNQIW39TJjk@z>

gdb> maint packet Qqemu.kvm.Wrmsr:MsrIndex,Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index f48c3a2b5f..a434a3749e 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2145,7 +2145,8 @@ static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
              "sstepbits;sstep;PhyMemMode");
 
     if (kvm_enabled()) {
-        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";kvm.Rdmsr");
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+                ";kvm.Rdmsr;kvm.Wrmsr");
     }
 
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
@@ -2196,6 +2197,26 @@ static void handle_query_kvm_read_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_set_kvm_write_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (kvm_arch_write_msr(gdbserver_state->c_cpu, gdb_ctx->params[0].val_ul,
+                           gdb_ctx->params[1].val_ull)) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -2302,6 +2323,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+    {
+        .handler = handle_set_kvm_write_msr,
+        .cmd = "qemu.kvm.Wrmsr:",
+        .cmd_startswith = 1,
+        .schema = "l,L0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1


