Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0987EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7975208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFV4Wu3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7975208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60043 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYs9-0004aj-2b
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:58:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkA-0006IE-V1
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk7-00008Q-1d
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk6-00006u-SZ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id i3so2135790wml.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FxtIkdXbzo6iNDE4yzISIpBWlKoNafWnhJfmMbMyOVk=;
	b=tFV4Wu3gOK1SXwpfKHf9Q64GJQVZY2N4sQ0G1Y2Jmu+ZuSK6vjGnOGi0nYY0k56qLQ
	yo/zJJYHkh85jb+iQShglTTZMz8yzchNcwhf61pKnH16ZZJAUiWBzVQ1E0XVkC7zTbzW
	Ob6+T+pXAcKDvEGodicmrlm9Da7Kg+DdFK5gFc0dSWNfoNS+2IdPVKxOdfnFBkELYOXZ
	Q4TzfJd177gBKE8EsO9FZ2sAFSBDrhBEN+FkbsNSXa51Thc8tAIp+g9ekwSFAeWG9kKe
	GbjIp2MHKsu0MP/US0UvyaVOMan8kf/M4/x+Oterpd1drpgy61KywPCb/kKgASzEkiB/
	eyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FxtIkdXbzo6iNDE4yzISIpBWlKoNafWnhJfmMbMyOVk=;
	b=RQUeKVEf4/cgz90tOp+dcrqvjtw+5OhJ2eJWXQcc9qd+a9C3aE7wb3pBFW1Ww6C9dq
	RsXILjHJ0t57JPpCqqD4SkLj+SVXOrrECf+QhWb7BJHe4qNImVuUUtASGLssHhB2Mag5
	AsBHanpJB77n/lx5gf96JMGZqSQ+lP5OdfTazTyKkVOJPD1u6ol3JEpb45nrDDLQyhIY
	bhkVwevw5bQHtW3QFocOE9mhSp0wqfTMuSwWtlp7l68fU9KjJjJRTuNaTkRxu0KObhKU
	EnOXL0ILsp3WVNw5OkrwQrlrxuRB1MVGN6rZ/V0EA6FvMZrs9lPqkdDSGk/JKluY6ezW
	5JvQ==
X-Gm-Message-State: APjAAAUYsV9mVcWHDYR0rBK/K2dfJQcdfGmya//iK6UikIE+7dMRJOMs
	gpB8kYN3VKplwt0keuNm8jLDempjbD0=
X-Google-Smtp-Source: APXvYqweiQbb5MgSHInlGk7iv9aCuPAwuyXvK8dAYOFRonTFeepkAT+/FcARWxRLBxZ2Njy/8c1C1w==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr2633514wmi.14.1559037001479;
	Tue, 28 May 2019 02:50:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	f197sm2272921wme.39.2019.05.28.02.49.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5A4071FF99;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:35 +0100
Message-Id: <20190528094953.14898-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 10/28] target/mips: convert UHI_plog to use
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than printing directly to stdout lets use our common
semihosting code. There is one minor difference in that the output
currently defaults to stderr instead of stdout however this can be
controlled by connecting semihosting to a chardev.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

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


