Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81AFC04AA8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBDC2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjeH4BvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBDC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM74Z-0005ba-0K
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:28:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ti-0003aB-RU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008Nm-8k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007Ma-VM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id t76so1484525wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=NjeH4BvXjmor01vw3r0B7wiWYL0sx6K6aWpJuxKCnaEJ16yfOyVG9fv3XmTYyVaIgh
	3pvDp4pmtPX8F8tQX3vm1agAqaI0n+9+EISIl33LPLUGvafVIkb3L96unCY71mX6FBZq
	fNMKXvtT52dq+EXFneizBdx/ESibAYsT9aisUuAbQLNtsnUdY0Z5PonEwhXnzc4N93dG
	vFJef1oZ7Kso1fY5i0xGjcDMqegrW3aimQndJOkQwAaupWMGQOSnM/MqGb39IsV0TOM9
	u90r+lITiLOaMCjnbHkhpkd5RTzw1KEZU/n6SAD1VPZNdovWLX4mOkP+QtJHSXXr23a0
	rIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=YK/7ZPkSkv9/8IpDb9jCUjwFY/MJ6WwZapxk4Bv81PNDM9zje64EGUXJ/343oPq0CA
	lc5c6UEw4CTPtqKF2t3mE1zI8nSHRZzFkt91udFcfvhasD14KjMoaS/oJTldvs2TXRYI
	4AXTVNWwSuwYvG42c0tLGdKbdVieCPBa+4om+xi5RByDpMvcoaqj5+5Voy+WfibhNbEB
	N4bc0aylaSgrVWowRAjgFTVlUr7uzeumFxA8SgpS+ftFUduAFWreA6A4N59dYkwIed59
	A5Pd881vPYrHuOmW2eZ71pTOTFvDvcCrU4Lzt+M0mIOFulpIuesrLJPp1AUHZKAIk0mA
	ticg==
X-Gm-Message-State: APjAAAV0ANN35bZKfepfAChfF914IS/xjvxozYEHnJVtjixyRwsWmpmD
	5w1ocBASIDEtMLUeI5U6qGb664MX
X-Google-Smtp-Source: APXvYqyu4iuZEPLGHqE1sG9WNZ4ScIkIGu7pjHTZClO99Drq1x4zuCMHHkIyJVgkC15hiqq//mwm8g==
X-Received: by 2002:a1c:2090:: with SMTP id g138mr1400364wmg.117.1556784980413;
	Thu, 02 May 2019 01:16:20 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:35 +0300
Message-Id: <20190502081554.5521-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v9 08/27] gdbstub: Implement remove breakpoint
 (z pkt) with new infra
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
Message-ID: <20190502081535.oRBmPM_8cG4_JYyOceSiqiW8cna28VhE6ta9_ZLVja8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 36c7353a22..b42425b24c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1611,6 +1611,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1877,23 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &remove_bp_cmd_desc;
+        }
         break;
     case 'H':
         {
-- 
2.20.1


