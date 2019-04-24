Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84745C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9E921901
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Et8lnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9E921901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ0q-00063Z-7F
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:36:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIyy-0004hj-FD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIrx-0000NS-5G
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIrw-0000Mc-VQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so5377928wmd.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=sqCWStzfcMsu/tEXfh9fQdnW8vNIxC4MXrF6FZGiMas=;
	b=P1Et8lnck0wntDh1ayJdW/2NS2E0yN89+RKpnCyihUZNjMH5ZOJbIANhr9EMrWB3L5
	ti+qRqCtMigjdQY+Iis7tBCiRsKqlXFeN9rAlQy0rfEb4AL6hNn4uTxjxb1QSZKYe/+H
	EIuGwhVy1X4lD24iGMS15eEZ5oA1VileXCpxyMRAYPAP0SgfYT8YouyqFYLLudb64N1T
	vrSUrsRBlF4wAQ6s+9AXKrbKN+QruR3ykXGFah/uuITe00tBbuMmAMvCLx6kNCBm0aT5
	KTVyENeYOawt0MHo1o4JMsMUzhOfC/Bvwy6d9Ye9Y1zWIwD22bMSVwUBYhYCu/W/8jrh
	RtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=sqCWStzfcMsu/tEXfh9fQdnW8vNIxC4MXrF6FZGiMas=;
	b=W4IZ3nA10lcdpyTAeaPLQQ0Nmt7D3pxlxMq2WxNj1Xp/djiReT1KiANgR1xnL35xPS
	qk18zGpMUmsxQUzrm6KZQ18w9iq0Rl4XfISrc/fKyC/VM9paX3GQwZRn3B7be1stEA7Q
	wrAHzWvw1TIZzAeT3OTC4P+x2NHGMCGGQY747ziiraa3a0V9XCDlDnXSvL0BikTHa31T
	FxXHzSYd+f7gR/DE4+LFUhKQDACfG3yRQ2S2qH31l2f0q46VXrjiLJNYQCCOqZrEW/32
	tHamHbrjRD/SwOVo799AczuzCx/rt7cU10Z5rs+eKAMmJusJ7+Hw8mRf5PoIg1DsGhTj
	1KcQ==
X-Gm-Message-State: APjAAAVFviKhThEZCXxdTaK52sTVQyM/PjyuEMeYPwSBrz1cilmMHxcI
	EqnYLqHYFDxoY8AwslrXNfNDK/Bz
X-Google-Smtp-Source: APXvYqzK5Ff77NwLwvg1k/Vao2nfGjplriub4Ws4szTtL+ZVxf+tXg4yxyyOGvxWuDdBFZEMzUORbw==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr6590092wmb.84.1556116047221; 
	Wed, 24 Apr 2019 07:27:27 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:26 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:26:57 +0300
Message-Id: <20190424142714.28460-3-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 03/20] gdbstub: Implement thread_alive (T
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
Message-ID: <20190424142657.VInuYAoO82rTHYQxXFocQlIyYnW2tYPrbVjkLnJ0Bzk@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 34e6722a8c..435b492b4f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1514,6 +1514,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(s, "OK");
 }
 
+static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1813,17 +1837,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'T':
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-
-        if (cpu != NULL) {
-            put_packet(s, "OK");
-        } else {
-            put_packet(s, "E22");
+        {
+            static GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            process_string_cmd(s, NULL, line_buf, &thread_alive_cmd_desc, 1);
         }
         break;
     case 'q':
-- 
2.20.1


