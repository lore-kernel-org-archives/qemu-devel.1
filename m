Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055BEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B862080C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWZ2Qkib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B862080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCBO-00077Y-2i
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB51-0008BK-L0
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB50-0005tM-JO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB50-0005sG-BZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id b17so1381957wrq.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rQDbySq2CCG8eAtAG40D7sD3kPayEKRs8iIxX2EaaA8=;
 b=bWZ2QkibamH6BQ7pb0DJez2s+LOFU1h++u+GAK2JCBKNEI0foUOlCzAFXxiKm/UPaY
 DfXtliZZymioa5+BM9VpP/k9o/rFLFnHqFV+EViHKdyuPgqKfNCIAUM87SYanmMSL3hr
 8QOFamcIqPmFbCLZRV85JBxLOT69Nu37sOOUXDWggy/RuKdL3EWBDCRP3c1Ll+tfa8ci
 WKI1PDfGE9t2PvUCvcdB9wVkA0ZwOI2euZdoKtNDVM0h/9iUSSznr7MWXw2hJb6S9kRi
 oobXZCxIsQkW4ST1jvUubiXxqzJoB7P+9Iw4n5kmPCFN5h3ONBIfTXLJ80YfHAOtGnld
 F7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rQDbySq2CCG8eAtAG40D7sD3kPayEKRs8iIxX2EaaA8=;
 b=HvEPm9pIZJUVW1osOuJVxvhM78SI8Yk41ICNDmWgMOF+JfP7XKqga9jw3mmjmU74+f
 4cedh93ERKTX/HK92OYbAmVmqk1n2WXULZMxK1MNlohFKxuKm0Oy6IFRf9SMbqvuNtRp
 pkA88/jaKf0JzoH9mKNKXWrlgVUHK+u3AYUL7c9Q7jx61DcffN9HW0U7x2mLf50LqHf6
 MPHC0T/fV5O7qNS+F+O35ZBWma/NcZYb6PX29OIL1OzXtIerhKp+EFQMa+MN4y3GivYd
 Kqz5MsQM2wll2bccrYDOCy6DriCjdtBrqcfcZMs90ZdYZI8hAsHDlARS+U2PuX/sE7mB
 UkIg==
X-Gm-Message-State: APjAAAU6IZCYIADKfneZODzIbRMKIpJmeJjNTw6fS/t0zkmYGYfUmQUB
 lTT84IRUCSrQnyA+o9Yzg1jcDw==
X-Google-Smtp-Source: APXvYqx8L+fB4OabjWA8AhloysFaJTN/nxZEjM7LNGY1VmmIBy507ZrbPAi1OtjSu5cyqmGd3onWEg==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr35496275wru.184.1559899353421; 
 Fri, 07 Jun 2019 02:22:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h84sm1575073wmf.43.2019.06.07.02.22.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD1B51FFBB;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:34 +0100
Message-Id: <20190607090552.12434-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 35/52] gdbstub: Implement thread_alive (T pkt)
 with new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190529064148.19856-4-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 120e52f5d2..ad00f223f2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1507,6 +1507,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1807,17 +1831,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static const GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            cmd_parser = &thread_alive_cmd_desc;
         }
         break;
     case 'q':
-- 
2.20.1


