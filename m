Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FC620873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9GKjeCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FC620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM711-0001Ea-VI
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:24:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YC-0f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00085U-NA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007YJ-DK
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id k16so2003032wrn.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=t9GKjeCMehyP0OgaBi1osrSMjK4uwBNkRZnRfwW424vTdd7tjMa3fsZws4H1FJ2VDK
	AL8G6qpp7SFryQfeSlgDba6+S4069N0WOlJLZELGwO6vZUD5B2FTdVRyA3zaHfT8aakY
	HvVvlIAFY9+RxkbzLlQAagn8mpc+OYEPQzR7vwMGZapycnK6PDCU3/1euV/fx3h6jFtb
	YyWI99D8gEsoJ1Xakq06dJyxOlRk6TnoyFA1/RK0SRCxKuRauPr0HtQqPjxsQSn8p+Ox
	j6SJRc4H/3UdJfPfBY9Hs7VsfHhDAlSAKhj1g5mcLpPiDDEpCfVkiDUVtwNi65A9aXDk
	VpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EShIhnyclfVo57FnSdW5zX6W2mQ/1wfNmEis7PfWfkY=;
	b=HBKUMsL2/fIuNQ6PQ7OzAhlnnXi7RlbeKSP/yRhQFHKsjC2jnLcUYtpZp+bgAln0Ye
	vZ8DP6AJargDp3cKJChgsRC+SrOQh1dd4YivgX84fW9HXJat77Ji6B3zjsgYMLsb6i3D
	DiuK+Vv+fN7xKCnmTPkfFO+07+x5m1kiSdbux1uA8yk/2GHCbMpup1jf/+DZKCwyi2RG
	pWODXKNn4m10wnRwBHLZlE4ifTIm5gV0gD3uz+Sk7p9MRLGzIMR8xIR64+snpIKYT/ep
	EDZH+ZNHa24W6mYrzMYkJjTwIeLRAcJh8dW7LXNblS1b+f65QdGT6ryahAtTsuHLp5Of
	0szg==
X-Gm-Message-State: APjAAAUHFd+sS7d+tvzhlvgA2fbLSa/awInTQ9USYjL6D3u1XlEDT8Ws
	2jLqfTVuv/VY/ET9WjyNn3vVXrZB
X-Google-Smtp-Source: APXvYqxgrSOhA7AlF9OAMKlnjyB4gdEl2ANwG0OYBiCRptNLPMXChTn+K4jcKAXpi0cDPYDtWTVrfw==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr1669186wrj.75.1556784993176; 
	Thu, 02 May 2019 01:16:33 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:32 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:43 +0300
Message-Id: <20190502081554.5521-17-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v9 16/27] gdbstub: Implement step (s pkt) with
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081543.K9dxLhJ1sGSqeRR99UYSvmOGA8CpcTINVh_aCV3DmVA@z>

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


