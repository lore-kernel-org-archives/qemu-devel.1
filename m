Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB8C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F29206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLKvgcbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F29206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJt4I-0002Av-Me
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:06:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmm-0000dE-1d
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsax-0004Ma-3v
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsav-0004Fx-6v
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so2376291wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=HLKvgcbYz5oBPXP2GpJ5HgTkUYRiZAg/mFOG7RjmjJcSr+ZHJCK7Bw4ohI57lQPO9N
	bPGcPJO0L0O/Fzd39NMxWQTvT954J0z6NjZrOjrX+EQOyIAHmNS4oj4m7yBlsuW1Mh8b
	G47styCjvpgzioz8hNLhS7qqZhJQRCgwJ5M5Q90dZz7DkeAk90OmXNmbz3/SeZkKcyIx
	33ckdLYbmHoGUnieYXPylSgJw4AvbMbF1EoWEhkyOhz/+0kLhumDhKG6Iegyfc1q1Dar
	0l03EuLJtfbzUES5P42U+vAlkpfv+TasV4tEuqxImDI8FOTZn6WFz/Unzss8b+pYSeIp
	8tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=BYC4orNQ9lph/jhLdFGs4J0QgXzHT+SmWqY8wlQS0g6KfSoAEx13eP3kYRmYGkuatS
	sNmK2LF4QBoFknFzdkJtddeg0j/Q1VJjqFl2tvVA1DSdPBndO5wLAf8D2ubxvKNmZ4vB
	iA/iLBiyJQ8TLcqBLeJoodCSYT8cGPNSKC5v00bX459eAXfyTUtJl5q2mKuL0Rz5IxjG
	NV8JtXRv6OUf6mrWPXBOfUcPDbOiCLpQ4qOA8Di4eyG0THH4y5aXGGPpsCyIret0Tiu1
	nL9ZsZ1+A8ItNWKqsPjaDvrJQg5kvmZHsapN8bCNDzbjUKHQc3y42Uye7IwIJETcSlZ8
	BhkQ==
X-Gm-Message-State: APjAAAUEQ6nZP0KWbWE439429fFSrW2uYB/veoOtj9CE++gehVL3TMfd
	CyMdKN8PucnQSeY7p8/tde7ECBqb
X-Google-Smtp-Source: APXvYqz8m2Sr6cGpDFTo6ikiMamPTXHa/khDgLP5rjt9APzij6a3FmxuNdU9CQ+0kLgH3VASc7joQA==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr5815868wmc.79.1556253374335; 
	Thu, 25 Apr 2019 21:36:14 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:41 +0300
Message-Id: <20190426043558.6888-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v7 04/21] gdbstub: Implement continue (c pkt)
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
Message-ID: <20190426043541.UwIEVGsb9rIfcM5DvJovRFQAG43TqPo0jRDJ3NkyW-U@z>

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


