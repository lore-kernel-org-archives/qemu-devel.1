Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB00C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FDE2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ux+L8GQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FDE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Fx-0001Pc-En
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:35:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69I-0004B1-EO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM694-0002DK-HW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM68u-0000sd-IW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1794839wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ty2WlLmKhHN0xnYND6EVRTn/Wsczm2UvDdzQfmaxB4Y=;
	b=ux+L8GQgnopXTu3TP26b4++71aIr9NIckByUeOW+wTLaJ56ZSyCfX98ug48WuOCnQz
	6EUKdaN+kgRDcJVsNdKpNthGU3iMwvVUioM9AatYEVdHtaRKxLf+rdRYjtoA82G39pDr
	TpNUTL/v08hxQeA1v8pd77Byv8u2BqG9NFU9+UQonE3cdl/rAU+P0im4vSgjwTVZZsfH
	Z62ASqBQXsJDjk+zwOa//GFC+WdQsncrBDqXJv4DubGVjWsDVvPxoEUFxKyDmcG+q/43
	a2mPrWrX8Ar0QONQy1eS+V9EfHhtNP6xLUdej1/oEUgyf5il1qUfiT+wdP3p6jB1k4U9
	4wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ty2WlLmKhHN0xnYND6EVRTn/Wsczm2UvDdzQfmaxB4Y=;
	b=co6FB/8jSS8Q7fVQuXVI9VGBj2QtlY1Ee8LuFFzGd4dCSKry6GJSrX/0boIufxM1fx
	UR0DsLqse6y0PnI0hvsX31Scn1exDja3anTKpBFkmgnYFhxT7KAUWg7MQTbNG5xm7uRR
	X/6Jg1+T0r6to5Dq+jnU78lctSlGQCDr6siUjhDAVPZ/9CN0tlpeAZhEqkTah7N1ogQ5
	c+/yrE42+forAMRzFwekYrwnH7T9pkiWOWEeODmkhGLx6ux1RKI/+OqxVZbIlKRwx02D
	J/ai4G0/7QS26h/KRcnzQMYHTJ23UYKwai3vnt4D1AbjLG72iynxa7QZdGHreLsckOKH
	jqlA==
X-Gm-Message-State: APjAAAX6gjHFZtXe7b+Kp5pDXpCyX+YziCyvsGd1n9doZLpWNgkLg7u7
	L+7utHrWB/2JTIpi3xUYZTPRzIsb
X-Google-Smtp-Source: APXvYqysx6Tbo41fJ4NHVozYIuea8JDuurYREkL+KnbNiqgc9OCmp332RJy1CkYjqXgTSTRbatP7Ow==
X-Received: by 2002:adf:b645:: with SMTP id i5mr1590986wre.272.1556782060139; 
	Thu, 02 May 2019 00:27:40 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:41 +0300
Message-Id: <20190502072641.4667-28-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 27/27] gdbstub: Add support to write a MSR
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072641.-DvR-o4WMK-tGwxRoVhMtX17TkommdC9kuiCgyjdiMI@z>

gdb> maint packet Qqemu.kvm.Wrmsr:MsrIndex,Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index d5cdda190a..2d9a8e6942 100644
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


