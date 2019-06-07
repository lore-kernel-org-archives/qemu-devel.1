Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FFC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69AF20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFPY1x1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69AF20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZB4I-0006wy-TV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp8-0004CI-79
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp5-0004jg-Oz
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAp5-0004Yu-Hq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id z23so1125808wma.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AyGciPWCZWMMprrVh/RGj7LAohHD1vSZk+l1Mlrp9Kw=;
 b=tFPY1x1JxMmCh30bEtwkP31PhjjlT9UsOl3sHffiKTuVf5HfuE69++inwzaWs7YRa8
 DV7Xp1O9gsC6rLNtb4a2wF69pt4BN/s8gTMzQngKksgt96hSdwEtVu8iFwhY6cxD5aw6
 lifuuYZWMzWE6s3LmMM5mRYRQiagPM4SSahkNz/eA6LFdahB2L1dCRqk5/hEOCBtpyYG
 X/neHW5OBgtFwiH5TM/l+qVhR0bSzAZE9TORLBo7ahqavIMWJ3NQ6nlorBEew+r+lhRf
 qY5ozHcids5OWSVXHXjKy6XFXBSe1TNlrToEHRHTyawhaolBE8rVu2RDWC3IqIHtGRmt
 ReSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AyGciPWCZWMMprrVh/RGj7LAohHD1vSZk+l1Mlrp9Kw=;
 b=JJ9fh3x8AprmxW5dsnhhfKc9vyT7/ml+giBGj07Ez9Qkx1/TwPuhvj6dhg2nw0zynx
 DsSDTu+M8UbfMRMzcnM2Yl+o+8AFFgFurLXrjbuT1ggtuqAgVqoY0uJb6HKULcdLZUVN
 MIP7fbplBLNqjrOq2QjGhtVd2HOke/m4F0xDpj4M1WlE9LbpHxS9AlHfXWai/ZHZFy3z
 oHhN24kmVq0mSAZSmS8lE9lHMu/Cl+oUmUiy9JTOVXLmtwy+xfyl/doQRHmPHCNpUm0F
 DDLaUkZYBLcff6K2pNzj0l6CxIxe9P4rkKPqCQ1f/zhMEP1YsIWEcY25fglHK799093s
 +21g==
X-Gm-Message-State: APjAAAUsXwSTssSg4zI8Jha2Ycx4m7Se3yyb4aCHVUuOWVQD+HWgGItS
 WnUp2QoH/wdEt1gxwHIHhH5RFA==
X-Google-Smtp-Source: APXvYqxHgEEzKukA3R0DJLpsenDZ+Iah1aYkZaf7Kjnkn/LtZ+xzdR/8H1bjDP4Qe1/d+5/gkZY0YA==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr3118884wme.51.1559898363552; 
 Fri, 07 Jun 2019 02:06:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b2sm1549046wrp.72.2019.06.07.02.05.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:06:01 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFF0B1FFBC;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:35 +0100
Message-Id: <20190607090552.12434-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 36/52] gdbstub: Implement continue (c pkt) with
 new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190529064148.19856-5-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index ad00f223f2..c3089a6b5a 100644
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
2.20.1


