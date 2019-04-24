Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DB32183E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aboCPyAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DB32183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNlx-0005FE-A6
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:41:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-0003mH-2J
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk6-00040i-O6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk5-0003wj-SI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id a12so3510654wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LvIqpLQh02Z6zWGECKaQkZCTeV0B0aLuGDQwChSB8dY=;
	b=aboCPyAaUaewi9G8bFPBpevUT5AOY/u1muql7eG5cqjXaL+TQz0MMi3JqozFg685uo
	Kb4fmSXRYJKVCr0FFI+xGh0LxQQBXxUQpVzPVsEmrV9N9i4s+oULvDqXDWZRMnj8orIZ
	ckv/jzHrWDhYZGjnoys/G69XiSAWllzPog3TCVM6qf/tCq0eaybl24xTeXcs2ExzeEyt
	KYOKd8OUk+rdK1sKxAuiGh5fEBoKOjUDF4yHLGjhuuiIDPXIePnCbQrPddV0sz90NOJQ
	leZ9qMdnDiZxMRxC8tBhg4c+bsuP7gRc7SlJ0kRGS0C42wW54/SbIONuYQij166s43YD
	yfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LvIqpLQh02Z6zWGECKaQkZCTeV0B0aLuGDQwChSB8dY=;
	b=S77pgvAzPRJWdJENuBbSqLUERLWJid/RdyRjv3EU9oUNnpkFgX9hm68lxaBFBH2lFH
	Qu7/HFlf8KdTKAzEwgH+OQjTLpWVAhdYFtHxYnPDQT99DoVEdrGFNNQWsOMpipSvstvZ
	2ITRS3I3BseicUwKDR0xktUXafVP6QeIhNV5vU8s6XRK+glwq0aHzKk+lVBGnvGB7cbl
	Q/bg4AzAH8ULbwYDiJI2IR00j+/pRC12Pp4ccppbtnleQOvRwi0Qn3w03hpyXZj+Jy39
	Ri+5xanuXsaBTfBw/NxXm/WYxEE2wWYs9vUkz13cbOxq4xF1Lzw13Dx9mvIG7ekzx0Pz
	heow==
X-Gm-Message-State: APjAAAUmkYwpHgi72o8aUUr7yhwqSPnVBcbeovjElL3SgKe029bPuAzr
	7Z/viZ1pyC60SLdbbr+RhL6m1tBK
X-Google-Smtp-Source: APXvYqyBRJ06BDDhPi2WwcqQXFgMwGXEPlXIpRFwd4Dq+mYLbz27LYdCbEMweyQq/pKFVorrKZsZRw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr22068633wrv.281.1556134777960; 
	Wed, 24 Apr 2019 12:39:37 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:36 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:47 +0300
Message-Id: <20190424193859.31817-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v5 09/21] gdbstub: Implement set register (P
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
Message-ID: <20190424193847.80zBtam28JWpGOTXwE9x0Sh4VgLQ-dmZmSLroKnqc0U@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 80f2a92da6..49db09ef52 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1635,6 +1635,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1879,15 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            cmd_parser = &set_reg_cmd_desc;
+        }
         break;
     case 'Z':
         {
-- 
2.20.1


