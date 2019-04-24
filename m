Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD4EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29C3205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roqfOAvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29C3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNJi-000658-W8
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:12:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6H-0001zm-9k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuW-0005bv-5z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuW-0005ad-09
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so26568126wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CKLVwHkSrn/LsgdYFsOscfdE/zkLHy1COYaVSODY+HE=;
	b=roqfOAvX41neFud4UKHQ83uL08gFpGvs75Gw7bbT0T+pe9qPrB/qrwXK8UBwvgmU3K
	EZtHMv/fPgStGmCfnFg4805/gM8j85ytQDh8C+hceDbL546ev/jeuiRul8N/a80FreWf
	NmQQwXQ1mX5IsAJsKZODWIPC8qFsz2euw4Ljla2LLqOeunIEz2V5u+/dL6D9rNqbsnzA
	J+n6rM0WTei6lqsR/ycsV5CamiCHlKG+DClOFaS1sdCuf5fOOaY8fAcQN2mxHHH0Zl6G
	8IR+e7KAjdDZ6FQA06McMf4JpGHinOaejh2uAvPTkLFZUturXeMz61jR8sOOW7/jIL2A
	s6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CKLVwHkSrn/LsgdYFsOscfdE/zkLHy1COYaVSODY+HE=;
	b=drsc2Bt+BI9GFnirM5Kl1D9ytdkV0+97UwetTNrm83zx92Mnwa7XOUf3d+htERqh/T
	eE4+SHqZ/mBvfqjTpRiku/kwdeVIYWFBFiolpGjEfv36sHwz2TnL1+XpwAqmF4NW9yx1
	Bx1zoek29HIj/phVQLm6g6ynfQU4KDLWn5dc/mp7wnqWXpfD3DSEqdcBPBRXnsFeyMe/
	6rV6K171sO34uRg00epDftBq/YTYQYBMdv70S2mW+JfyJrHx+aOyTr3iFRtWInYr9YOC
	3uoJ5OTeQyuIbGIN6Kq5yD0UOlIg5XHNC6w5JO+IVey2wsJkc5qzo/p8nOwpRwT3t8+S
	OIJQ==
X-Gm-Message-State: APjAAAX4XDPKs4rVk+tkBkZu9295yjjq+uf815nDwf8+O+Awx97utBb8
	O+FiKB4jXdoqcFs3H9JP7Cd78mtr
X-Google-Smtp-Source: APXvYqzTTi9/VR+aT011L7J9ETDLk82WKbQd4mnDemYjiweEz96sEGWdiYX7bdQtULB7v5Jlr0cJDQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr4285875wro.183.1556131582531; 
	Wed, 24 Apr 2019 11:46:22 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:21 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:47 +0300
Message-Id: <20190424184600.8445-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 07/20] gdbstub: Implement insert breakpoint
 (Z pkt) with new infra
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
Message-ID: <20190424184547.RF2MZdrGPRRZJ7Aw-VfIWCMz9P85KDGRVeq200DuvLc@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index c1ec36a062..03553a1a32 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1598,6 +1598,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
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
@@ -1852,6 +1875,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &insert_bp_cmd_desc, 1);
+        }
+        break;
     case 'z':
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1


