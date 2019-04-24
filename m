Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD8EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D5A20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeLat+Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D5A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNtX-0003p7-Qi
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:49:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-0003qJ-2U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-00042H-3s
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk6-0003tb-NO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id j13so6165485wmh.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=14VPjA11kd7BNRAewIUYoLzDl7QlL5dAdw5dQ8aqYZo=;
	b=eeLat+PkO2gS55c0bZlrXf+TO439eeIaOYMZ4v15BA+yDqvI3aMaijDWDqV6VPCIcp
	gtUkKUC1QLAocH3NfYDs2/AV1s9y64ME29ib0TPKIWAM3tpzkBBGCxfT9wiXp4CnQWzZ
	0OVax/kgvtgLaPHMW6ybaH5GHoY4mAKTpkthqlneBfCNLCBApUZVYQV+PZ/d1iem0hUE
	QzpbWoUpc2jp725wP5aY00rbViauQUPdnFkG8IZ1E8Mf71192686sC3YF3VO07/GDKnX
	TW+/2FsPtmXc0J/NmBnOaMfSSBu3y9VIBTBtwMr8Qo2TQhurlCp+qi5SiyIcYcHPon/4
	Byxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=14VPjA11kd7BNRAewIUYoLzDl7QlL5dAdw5dQ8aqYZo=;
	b=CUQOJry5AO3uwK9ybB7QQkit+s0X8oZS09yhnZ9YhAXJ+lagjBtpc9dzWpsSq7bTpD
	43A0E210k9kIXrabh/BHZ3xgrOdThVEMRKsuz70alUbZt88FQo0MoMjaeMAsXILt5Ksq
	P+wEGJkA2ocNERzPNSEo+9XULwOxfTehnRe0jfQFcoRm2bkwfbM8o3nXHZ+fpDhiEZwS
	sVo1Re/i0LJNfAau6k9HXfzQW4Nl+pcEqaNbH867cpdDqpqd5ZtBjK8hdbdXIj35NF01
	iVHKBOAvfWCifhJLh3IZqun+ce7hWBsFImBuZ0Ep7eQxkIOQrmlUEW7TRl0OdtFNF4zE
	7KIQ==
X-Gm-Message-State: APjAAAUQeDpJ1gHUi0mFRejRecNAujIVtDrV+MMXCe1RrCBecFqDGDcf
	mdeVuma+vJaOBDYNNfxTsC/gZFyw
X-Google-Smtp-Source: APXvYqyjf9Ml2GN5hGdHAEZPgj7F/wAS74qmlBwPoHqNQMJpH5NInGhWTz63/yuIfwMY/1GYht4HTQ==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr568358wmb.58.1556134774713;
	Wed, 24 Apr 2019 12:39:34 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:33 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:46 +0300
Message-Id: <20190424193859.31817-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v5 08/21] gdbstub: Implement remove breakpoint
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424193846._Hsq_4MvaNhja2V6WLGe4ckzZ25LCS5eFrwaGz_mqPA@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8e0446d305..80f2a92da6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1612,6 +1612,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1878,23 +1901,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


