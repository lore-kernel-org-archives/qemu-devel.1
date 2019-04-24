Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA262084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoPTXwd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA262084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ6n-0003LI-Ci
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:42:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzK-0004hj-O6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsL-0000oe-Bn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsE-0000fU-Ci
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so2199602wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/q2YxP46nWW9AurWHkjvr/gtc+/2KwPsNaB4cdndJHQ=;
	b=JoPTXwd1WwqEPYqxJXyMMQJIgMvlvGUH+iTswjG7xnHa4P8bQPxF96pxTVY9Kdm/lc
	HSFBcEp8Apr72VCXmmela82XSGOEDFAvGiPHTCqQbUa1RVFnjgZdVaRrMDqt9YU8bE3f
	gI58Hc6NEN3ZL/d9OPllHhs63MtaKxlo93XGZHwAISGNdYaTDnML5luqPqFEvkOMNdQ4
	pLDqh8/Gn1f+E2WtrvE+Vwj+hI0ma04xdr3XW6HW0kILDBh7C/pgweTEql8w9vToxRb+
	2hP8hPKCarf/wGNA2jYPpZuE7Wd23AAUPSGFNDNytrV5JL15uBROLBSxim4GEkdg5TJO
	LNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/q2YxP46nWW9AurWHkjvr/gtc+/2KwPsNaB4cdndJHQ=;
	b=o7tmBoPBzWFmRbzyEhoZPFzdGEksHUa07PTEhodLfVCouycCpy0t7CXKYh8FCy7dlX
	r1GOB1HWVt+QHcHD7VbzktBEp32BTZIK7N+ry2prC8RcVS5zOGWZ6ImZGyJaLgZ90ueL
	NJoDdzuYYWsQTY9mDM6OPh+x6/r8h1nwbCNs9Rg6hGGbn2283eHLhBUdBfB2VWqosyW4
	68gCvhT4Y398V3ZY0O/odzZSH2Lchn+2fadRPCWMgzekIApd8jg9LOY/ahCCKxzC/yFm
	bGTXizPWFtafgFR+sEMjelY0Y7K/IjZo5iW1E3eHi4uAFW+4ieN30NdaUxaSMgmMXVY1
	hBqA==
X-Gm-Message-State: APjAAAW4Dzun2wc1P9uAYlnlUmzgTG8wTY9jXumyRT4wPOpQ1lVofA/X
	OnNpB6Gx3iOaHqOrgiPzgVlN9lVW
X-Google-Smtp-Source: APXvYqxxxpX3ul8ZIWhoXlZt1WRXtyNdVxDhfUZxN06/FGqA6CudX72qoDpJxK9DOsQfdqBVBZKu5w==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr20641013wri.220.1556116062668; 
	Wed, 24 Apr 2019 07:27:42 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:41 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:04 +0300
Message-Id: <20190424142714.28460-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 10/20] gdbstub: Implement get register (p
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
Message-ID: <20190424142704.DKmm4478XAQBXDAGmViD2yOsFoN2twq8TrqncfG9zfk@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 674370a60a..ca91cb6740 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1671,6 +1671,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1899,18 +1929,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &get_reg_cmd_desc, 1);
         }
         break;
     case 'P':
-- 
2.20.1


