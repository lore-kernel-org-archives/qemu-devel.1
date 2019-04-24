Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1918C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9DA2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlXdNMYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9DA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJCK-0008BY-On
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:48:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzL-0004gM-CJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIs7-0000XR-Mk
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIs7-0000Ve-G9
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id t17so13737680wrr.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4wej51JV8dBZGzGZkifd8KMFqFKiLMpf+q218fNFW6A=;
	b=KlXdNMYfWBwU7pBg6wIbsnwBfS/5b+VqDP5ceLuI74mX+vb85YiQid8C379vRv9JQ9
	cfENSiHBz7/M/Jd/Eiv+ZZPkflq7cIfktNkMDT9+a34h/h6iZfIwposCx280JkwRDIQD
	tqcQAxgaTMHaTASErQp6siHkLmGHD3BKtz9mpbzkX6gsmZ9DJX2EFXBY/yMeE1L8tKBc
	5GpD93losnD8aIR5WcbZzddIGSebqGzniOm6PofXd+xcB9ngZhbSv8esfZ30p8ABIzcU
	eF9ve36vNganMCgmeBIxQwbrWHXONtSaA91QTBoGYp+u6x4qXCO30x4Yy8t6t/ndTZIp
	KDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4wej51JV8dBZGzGZkifd8KMFqFKiLMpf+q218fNFW6A=;
	b=HdsJzse9kP1ylB2HDGf/lOiSUFPR8Poi4oShHc2jNVXupxRzarv+0d3MIhYZo5yfSu
	9zhYxN/8WcSU+tAVyap10LI1kjez9mHHX0hly45tZ2LOz2aZz7Ov0aJA6NT+WPhqvSjT
	CANz8MBkt26a4QxKm1rdWlAbIrXN3GHdvGW+yxJDY6h+4C/nD5SWLqT4tnuVXSODNyIl
	REEN0nsWJJnbcGUOJWG5V/cZbf6quM4K7AHr6WFn93oHdVbyUH5lsAUipuXZuwjnKN/L
	uEEfK7in2CpWlUzh73ImJ8xKp9fQO9uOESvk5K8ma49po2oS0AXzgUonFo+GOkR6A9VE
	39Bg==
X-Gm-Message-State: APjAAAV1kmGXULsZlHsM1qHWBW0dQxzfvCMgItbe+Z/ztXF7ybOc3jAU
	LZEJ8v+zxXf+5mIhENj1NJ6AGn4Q
X-Google-Smtp-Source: APXvYqyqe8R3mQrkopp+9RqaMAEvsbdk7ERAI6r0kobolSrZDGfynXI8d9AFSihpw1zKqvf7OePmsQ==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr22773849wri.184.1556116057889;
	Wed, 24 Apr 2019 07:27:37 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:36 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:02 +0300
Message-Id: <20190424142714.28460-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 08/20] gdbstub: Implement remove breakpoint
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
Message-ID: <20190424142702.Te-hezZEKxzkyQk6-VXEGEMyLrC6wNJUTQFfyp3osYU@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 67cb140031..d0b27da518 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1627,6 +1627,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1892,23 +1915,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1);
+        }
         break;
     case 'H':
         {
-- 
2.20.1


