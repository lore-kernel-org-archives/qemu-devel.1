Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A41C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E96020873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQviOb+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E96020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Pd-0002kz-92
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:45:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69y-0004nl-Vx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69o-0002le-Rf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69i-0000Wg-Az
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id b10so1274932wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7xWdg5J6VC6HFdEkoiuvTsAB/KgJAJp/2excD9374G8=;
	b=dQviOb+SCs5MNGX57Qf4qTqLp91xrJAzjlGahjovPhrZCLy094ZyU0aVpaHj2ldxpX
	GfDuDxRRQFjXHFlI7REqyyvNDKY8kfIl7v+SOxTNsgQZET6APgGTXWiHiF6cv+OMkrxq
	6VUCeeUEH0waRBjQU+tFHD7RNTzxyM6UyhAEYa+Lv/WfqOJAGfQdD1MrLTDx/yQ9Ol6H
	4D9N3s0mfZFFWx93F5+R97MRMrcmpJw2jWrr7FDhDCzeweG8KOpTlbtKOmSC6vVIt8K0
	2/jTWt/kTIGTs8hWMhdMojbk0Or8rKfYLFBnUhMVsaOpC0zzvco6u3GISo+CfjGudL9c
	0Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7xWdg5J6VC6HFdEkoiuvTsAB/KgJAJp/2excD9374G8=;
	b=p+FH3A5eaBf8y8dYd6edf4PsXKB7bT0sk9d3kFtQy2MlyO8WMN8v6vq16LjRcwJfD1
	Oqp2Wgv3vShGAN++lxuL0J8Obb92slbFHqOEBUpRTyayUl/v67hc1JPcTNVvVDKbPyNs
	VODd46Ejsn8r0c/9/1SZgxGvIp2cftZyEqqP3kRtBXRdstKNag+pJPB7eZwCESsyyzhG
	njFp44pGpkTOEJ+Dgmg9lK4VP3BpQd2bw3oSqB8BQ/L15mCQ4FBSfk+gmSIzjuaz/+W4
	wnjZDjkJH9Iq8tajz+BxdcGDBxeeYaqexnpgDBPkHCY+sqqvSMlqk6J5VyRoIqgb8LBl
	CiIg==
X-Gm-Message-State: APjAAAVrpGV5sB718cEc00u9Sf8DpNtLKOm1Ja4rgNtenBhU3PteiiA0
	4OaKqP+53Q5hJ0Sfs18kn0YpRxhq
X-Google-Smtp-Source: APXvYqyN/k3ocepivdLQFjmB17xcclQKa67sESmX57WNLxzgotCOJUDPxee36+sPM0tHUBp44cnJ9Q==
X-Received: by 2002:a1c:d181:: with SMTP id i123mr1228978wmg.33.1556782033095; 
	Thu, 02 May 2019 00:27:13 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:12 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:25 +0300
Message-Id: <20190502072641.4667-12-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v8 11/27] gdbstub: Implement write memory (M
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072625.LbFxTj0zlXLgk1TRGd6tnuahDfiQWhO5C3tAZjLNtZ4@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e9a3d0c2bc..8dc2e1d507 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1685,6 +1685,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* hextomem() reads 2*len bytes */
+    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+             gdb_ctx->params[1].val_ull);
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, true)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1893,24 +1918,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'M':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (*p == ':')
-            p++;
-
-        /* hextomem() reads 2*len bytes */
-        if (len > strlen(p) / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-        hextomem(mem_buf, p, len);
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
-                                   true) != 0) {
-            put_packet(s, "E14");
-        } else {
-            put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_mem,
+                .cmd = "M",
+                .cmd_startswith = 1,
+                .schema = "L,L:s0"
+            };
+            cmd_parser = &write_mem_cmd_desc;
         }
         break;
     case 'p':
-- 
2.20.1


