Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B230C04AA8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BE520651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUAX/zF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BE520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6y5-0006mn-KX
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:21:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tJ-0003Cv-3Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tG-0007Tk-A4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6t7-0007JB-VU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so1977899wrq.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=uUAX/zF+Z8eOgAIkBfhItK/EJAQjSlCS5CaZUuB5Hsgq1PYx+izpxQv2Vqxqm0oFop
	uOG2HsAykPzXSow2Ak/HEvveYdkB4mLQx3XnRQ9w/Yt3ldcqyhSREHrS9KKjKHsINZIT
	OnYlglovt4LH6bP6yDasAxnSAbUtmPw6KRLS/+5zQkngYvOeGY/ObdU66JtQU76Q0j0m
	kW+qhBrKofeqw0p4rurA3fO+YP0lrDjQmlpBfM7m3wzfDFiaax6Aznyk4BMKEHmTwgVS
	QLC5Iwkk0C8KbGv9hJ/vBbtQ2DxyrSeoaFpBLS3ytkKIoKK25NLjR6ElBhHax0iWwzzw
	5AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=LCE6wRGgGLrWhs9MApPF5auz6NsONs9y3uwFJbscETLKBD+SW2sSFeVc5k8NaYdFe/
	wvs/h2lQWcET5Jkx5fWA7GYKz9DE3WyXIdHDUxhWcSK5HRZ0mqq119fPoVHfr+EM3Mxm
	TNBeZCdFwhcMu5jUOBu0QSC3ovYXhRp9AzdTfI6R/wWU84E+sWEiZD4VACAMwsghSQlj
	CBU3I3XY+qlwe0Py9KgqXQtE1dnAt3eSao2aoyWGizOg93AJtoVvmkeCq5IQEOoD3XJT
	qz6ZFXqXBlvNfk7NX8TSz0wLsYuir9xsbCirxyqNIncAQu1ihhbqpui+Do7ykhFtJiqr
	R0/Q==
X-Gm-Message-State: APjAAAVG/DH5A2xg1dOci/0rYSbZUUTWir7V3ytbqtEfzVBpvZcjsIGU
	TIelKt8pEi9eqK/+6bJw2kfGgLsz
X-Google-Smtp-Source: APXvYqxWnLllbSFESY6Sgm7zYgl+y/uijNyIowzI9TF/6CK54U/JoIQr2c55BdFYTLdx5Nm7lHWlXw==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr1709106wrv.121.1556784974069; 
	Thu, 02 May 2019 01:16:14 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:31 +0300
Message-Id: <20190502081554.5521-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v9 04/27] gdbstub: Implement continue (c pkt)
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081531.EAuyjCzGL3E2woiSeyCgG7dpIVMV48rNQVt_DFryiqc@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c47ef7dd9c..89f1ab6524 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1522,6 +1522,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1558,13 +1568,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


