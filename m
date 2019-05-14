Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA682085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDPRcD4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA682085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZro-0003YX-Hd
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:01:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjs-0004pZ-7K
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjr-0006Mf-49
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjq-0006Ke-TG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id d12so19775965wrm.8
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/LCsl9Du5Zb3JNBgOo6lbNCwiqPK/NFNHlF5WOB9yB0=;
	b=YDPRcD4TwCfdkuQSRZLeMT9Sr9bRTKQZSSJ2O7XBGrHXcItE5Dx5rpRmM/+KPbg8DT
	bLXx7ZJqb2CbMTPlriruH/MCzUIP9A5HntnKc/oxpREb4rwtTsuAPnBojlK5kh0Lro5a
	8OYnZffrNOBSh/fr4sACpQNW5jVEuV0UDQe0bBcj9UUBiT93I0J6UDB7nt+dVW1sl77T
	WFhxQ5/77K3kb2IwLtj/vh20/cwP36kQ3qa2FlhCY3cxepF7s3dPd78rp5Jr5unM/E8A
	0tz4npDuHpVSpBkz/UT8eRL2QGbIbUrTrcDtfpqpAvUNsu3zvCNW3cn4i6X5vQCDmbtx
	/gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/LCsl9Du5Zb3JNBgOo6lbNCwiqPK/NFNHlF5WOB9yB0=;
	b=B5ZGN+9nubC4xZagEku+G1k9AvX5m1VM0kapepC68UEH9vdv44wV7FNkQARpWNvbQ7
	6/ohILstA1BUxgITcHne5RrK2HGUHQ6eXhbZETJ3zl98j6xwQd6sLJiQLn0ibSaGo1/y
	ehGgcp7LJIMYkq4uAAO8g+UvoyO2tKwRor3DcHU4jqZD08FmjkOKvWgpQ+ePDxQ6htzv
	ZHawmyt67ifpMi6ha50R1O1AO7KihOKP0YiIbv+k5P0B/xwAaP/k7Ko6Kprtqe1bQlDp
	6DRA0V13uDbpLOf5VlgljMOt69JyesQHQBtQ6LUId9yRIymhmQW+2UzqsdYkh6nb8N3J
	POmg==
X-Gm-Message-State: APjAAAVTM0nPboQNsXKWXNgaX7v14bOjVC2enY2OTRT4xtiQFXKl8nW/
	3z0h46halO1NiWNleEPyzZMK7zJMS6c=
X-Google-Smtp-Source: APXvYqzAykb8ticQn2EAU5voWaABgy754IDQf+PQ6AXO9cf1a6fgqRaGsut4zUBn7fn+hl2Ya8h/5w==
X-Received: by 2002:a5d:4988:: with SMTP id r8mr11283170wrq.57.1557849189770; 
	Tue, 14 May 2019 08:53:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c9sm12598826wrv.62.2019.05.14.08.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E24A31FF87;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:53:00 +0100
Message-Id: <20190514155301.16123-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [RFC PATCH 10/11] target/mips: convert UHI_plog to use
 common semihosting code
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than printing directly to stdout lets use our common
semihosting code. There is one minor difference in that the output
currently defaults to stderr instead of stdout however this can be
controlled by connecting semihosting to a chardev.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/mips-semi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index eac8374fb34..35bdfd7c77e 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/softmmu-semi.h"
 #include "hw/semihosting/semihost.h"
+#include "hw/semihosting/console.h"
 
 typedef enum UHIOp {
     UHI_exit = 1,
@@ -329,13 +330,12 @@ void helper_do_semihosting(CPUMIPSState *env)
         p2 = strstr(p, "%d");
         if (p2) {
             int char_num = p2 - p;
-            char *buf = g_malloc(char_num + 1);
-            strncpy(buf, p, char_num);
-            buf[char_num] = '\0';
-            gpr[2] = printf("%s%d%s", buf, (int)gpr[5], p2 + 2);
-            g_free(buf);
+            GString *s = g_string_new_len(p, char_num);
+            g_string_append_printf(s, "%d%s", (int)gpr[5], p2 + 2);
+            gpr[2] = qemu_semihosting_log_out(s->str, s->len);
+            g_string_free(s, true);
         } else {
-            gpr[2] = printf("%s", p);
+            gpr[2] = qemu_semihosting_log_out(p, strlen(p));
         }
         FREE_TARGET_STRING(p, gpr[4]);
         break;
-- 
2.20.1


