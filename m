Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FACC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8A021019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHcGHSBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8A021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl1P-0002zj-88
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:32:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvK-0005ua-08
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0001K2-Ns
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv4-0000w9-C9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id 15so5186358wmg.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=82m0nfi4dm1nYK1jjOZA1RHXA6lw0YusU8h2ijo5ck8=;
	b=iHcGHSBqgqA03l7DRF5mjuOailwePJ57lDnjFJ+ptwz/w3bH7QNwot5Qglu74EeDl+
	4oOAKE+StzTeBR1TS8WfuefzaxfaypReMbgoYOmZ7E7NNqXk+MM6Mjeb9LWE4DKOBuBH
	p9B+wD7poJczrLxz7IC9NIRjmmUAnFTIHTEjuvOjZsDp+J6dq+NvOMW2Jn7QrL51giv5
	dEON2ZzgkJb2+6eoRqK92BJYoQOlgM6hjO13C9lCFOuaOLMedamiJcfG+LL7HAwC/r95
	Th8ql8jwfQyGpHdAoDpiQoRIWd3cnIObbGC8tjp4mOpq+yNsB6ryHhZ6pS7dkadHyoGQ
	zVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=82m0nfi4dm1nYK1jjOZA1RHXA6lw0YusU8h2ijo5ck8=;
	b=HZbLGWLpa81Tc+o91WiaMblpKlSd6iGzVdTzWg2Cs3MBSo2J7tOzNPZPtotzY2mkej
	XZz+vqy/QWXhbb9wdVDvgqHoftpDM4PpYdCnqkkV0PyyvtFL+cOoP3vwEZ+OyR5DB2qA
	hZ0TzgwVIxDtGTAwU3rWtNMVhjBYE8u7YzyTQIxk3yhDTpA5+qPWvXO0NLpEZ93Dd57P
	saMrxTFI7jGLUQuiTaIwsDdKegn0h9NIwe4nEhkLZDpW6xEF2jZIIDqG+Bbaiy7j9Ivk
	LnsTXvpyxus6Ku7i+mYEgozbo/03ptmHzo/6ADV1MNNX1DBuG2vLnhZGHjO39n/xHQfq
	SNew==
X-Gm-Message-State: APjAAAUClqe5/EJNpqi9oJNvolgzplhq/YfNHNNYv8fi1pwfvUGXHNne
	eiv0alggLBE3VhRswqGHTzw8IA==
X-Google-Smtp-Source: APXvYqx35LU/zP1QtJhbIxsUx5Y67LWWB6npiuQIm602P8To0vD9uhP8rQerO2v5k/+qkq7GTkfN0w==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr11196258wml.108.1558607139479; 
	Thu, 23 May 2019 03:25:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b206sm10396597wmd.28.2019.05.23.03.25.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5D0D51FF99;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:14 +0100
Message-Id: <20190523102532.10486-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 10/28] target/mips: convert UHI_plog to use
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
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than printing directly to stdout lets use our common
semihosting code. There is one minor difference in that the output
currently defaults to stderr instead of stdout however this can be
controlled by connecting semihosting to a chardev.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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


