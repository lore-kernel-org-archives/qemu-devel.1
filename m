Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA6C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CE820652
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZtw/Uat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CE820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNqU-00018H-KU
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:46:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-0003qK-2M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-00041x-0W
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk6-0003zY-1Q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so4175588wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2X/EqHRQzIkKd3q6L4ImeXDT9TueqP/ctRgcXeSvAEY=;
	b=PZtw/UatKCjN1sX4PnkBcP32pcmuqU/YdugfYgs36H5VZw3h2rl2slOkZT6zVhXJSo
	crxytPqwpY8jJFKsSjXb/euIRT1ra/FSF75bzcbZCfqCmjZ+u36yttyn5kytR8VFcovu
	IpVDGBBTm+mdoWynwwPpxXHxPHbX9CtG9Q12k6y9L9Sdnqx/BzXR0JYIZZDpguqxB5rh
	bbpUqTnc/R6UQkFhdVKcgQvXTNe7ToIQnBuj+xawr1XIWDqCY+eIKaRJUdV65mSjMYHV
	xdTRgqBURtEiUFd5cIQapZ00vmWnJE/LdrfRCd0LpnJlLG9wGzPq4CccqaNAqUggzEGy
	ojOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2X/EqHRQzIkKd3q6L4ImeXDT9TueqP/ctRgcXeSvAEY=;
	b=TrbRQ1GWB6LeknAZ6L3S8cqhrTnu8uip78Yz5GdtfTIieF5rWS30wAAdOZwxuipCBK
	YVSp2LqbZIC/BfcCw7Oj1f24VtQxQ5dwik7rmZczZpwCoMYuIrvCdsSXaZwqN2cpBQ8W
	v6RhnZZZh6Q7+BNuHzAclWNCpxgUnXJ9pts8Vv9WyZrEuq+6U6wFMlUIWxA8U5z+b1tk
	bkpI5xBRvbjkusVxUENNYHiPYj7biSPxBez9Ei9Z1R2vA1uaYGkkXEWzxZoOn1SsW5ll
	N/MXaQ9TDuw13F3NUpnFGmuY6lni8Ba78K8itr2baz0ORlS63v9vGovnoUMPXKASV1vk
	qELg==
X-Gm-Message-State: APjAAAWczqPUxL9DzoY9an/U5/VhI/IY5pjrCdBNBSIQcWoC8BKEMXjr
	lMDyQbTODFKPSSC30T5bR8t7kg7i
X-Google-Smtp-Source: APXvYqza+ZOPwVaTQN1lIdilVxV3N7NRi4jt8rEGNiq8mbJxmsmGEqofVYIeqBJGE586EV1ZIxFRLQ==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr1066357wrs.269.1556134780058; 
	Wed, 24 Apr 2019 12:39:40 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:48 +0300
Message-Id: <20190424193859.31817-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v5 10/21] gdbstub: Implement get register (p
 pkt) with new infra
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424193848.sYzpTyuua84ADhjFmVRjuaAlCsPYtJLkljUA_AfeFNY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 49db09ef52..c439b8e796 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1656,6 +1656,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1885,18 +1915,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
+        {
+            static const GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &get_reg_cmd_desc;
         }
         break;
     case 'P':
-- 
2.20.1


