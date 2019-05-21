Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA83C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B52C2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgIbbfyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1bV-000717-Hj
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:02:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z5-0005dc-Nx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z4-0007Pi-OG
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z4-0007Mh-FY
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id j187so2217608wmj.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qklBCnoRnFW8d5mbXepUI9O+2lO3CfVGL56paMeE7+g=;
	b=VgIbbfyrDnIJPFd+xQe49cMh1U2jh2HqZaHCol74FI+SkaPtrx+INjJUw71Vob9iq7
	uJ2ZH5T7TqAIuM9z5Z+IDDhPXrYTPVVRvcxQql4qs7RbW3NpxjzAIMkh/pZyDSnrKoFf
	TtXK56YNUmAzi5vsPD3dca6dCCmji9v+Sxj5UZlFtoefFI9tp8PMQUL7uLYi3AhBRSyB
	DHFlLO2FuaK+yBUhItckGJL+U6c3DNZs1d+trrcWPgrNTxQ62I1eWoMD0EyO6JzKDwcE
	3xEag3qHMwhLaibiHEHxr+ayVb44XORlu/xUCJpoTiTrrzlPsxASTT23wD97pUpoKfmc
	gB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qklBCnoRnFW8d5mbXepUI9O+2lO3CfVGL56paMeE7+g=;
	b=jrBuE6YiPuvJM2caXqMtDaza0U+Otuvx0xmj+QAzPbu22GopL8A0WFvnjBDRV0zTtc
	KqZ8yAhc01Ocn+oeHS+cyZltU9Uzs365ivZhWcR7WLVwmB96VZif7zdJngk9OcjW7Ptk
	kWg7KFcV+ZpkjLJSwGVU+4uMoIzL85n83gTR8VHLDDH28Gx6DCQECcYzShieo9/+w7zC
	H9Qa6k2A0VOwIener7sNPUKcIAVLbxovtd97Z6RnqveqGyXfbRcy/EmPSq+9sXE0CT4d
	Lg6QqWHs7UVadEJj4XevHAYMTP6r6DN/sC565Ou2eofsCAd8XyXwY5PePnPANete/mMG
	u3Uw==
X-Gm-Message-State: APjAAAWBzmotBqJ95CFJI7efZQSnfjCd9KN+hTRuh8xka/M7UFQsAo1G
	KEW6+C3Ni7wnL1btFYdmFC1C4lqx
X-Google-Smtp-Source: APXvYqxUZmTUi9wVtWRd69z/nWrmGR5J+i2Zp8ofhlrgzs5R0qHcB8kWR649gnQgXIsyLWegZ2txOA==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191mr2462922wmf.99.1558432809360; 
	Tue, 21 May 2019 03:00:09 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:32 +0300
Message-Id: <20190521095948.8204-5-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v10 04/20] gdbstub: Implement continue (c pkt)
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
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b4c4bd4b08..698d6f558a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1517,6 +1517,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1553,13 +1563,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


