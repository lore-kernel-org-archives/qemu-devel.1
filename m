Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15A024650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnEnwskn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15A024650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtal-0000j2-Hz
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWb-0003lR-M1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWa-0000nH-81
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWZ-0000iG-Vn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id p17so5154272wma.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KM2z5lJatvSo38TN3JEp2tBoGC1lMW5rj5gagTwUU00=;
 b=ZnEnwskn0ws31+evRZJXKY5mZ+iCjYMuIC0PeZtrjOoUapF2ygtXdzTuGgLhYuK/q2
 Q1TlPaTKrcKAvIOP+1T2ch+lmZv/IQ8DNkrFgSdpJdoox9XzdzWgvv4X1iLiDj2doQ3S
 lXUS8q3HqT1dIUxRVw1xEcA3tzJJLvzCRPrrziRxg7cdWJfoWymJYKmBbcn2UnZ2i27c
 dnm+A9DKaF4MmZOEYw9yHg9fcxgG+48qtPYsGkehYrnOmefbAk3oNwpUXXUrnIbFyFDj
 NfUw0Eaqe+vQKALBBGzZXfUsNCp19Kz4uyFztRvp9BwnW8mi+OttvSmTpYqQmdFGSpHT
 uyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KM2z5lJatvSo38TN3JEp2tBoGC1lMW5rj5gagTwUU00=;
 b=GmS7mUeY3yFw4LtOLfrGkBKjZbFxbwjAdR3Xn4PUYok9/oauG/uFCX1MpqI7nRpcm7
 7PlGfIxlOhhItnb2bVhcp+O2tEnZAKHfuQFkUIEY0WlfTNiOvCcA2xPPx4YLeuuH8uew
 B7WgV/cFJGbn4ZyMgSwCRuj6Et+7r0s9l5RkvtXstFU+DPIEHUvS1NWn+WDB+rWv6wwZ
 zpJPwMB9qAB6Sigz1H9xhYTNUIU6pYb7jUrw8frKQDj8XTrhsYzHr4nw3qL22obLhsU0
 ekdPugOnKaVYDNT7yifztrZZWQRtPX/8VvPOn1uMQwPUNG2fQdH0V8dJS6TpnaAW7rSa
 HS/A==
X-Gm-Message-State: APjAAAXzGvwIGHDmMkSHqJgB3Gf9YOL6TwtAYjxh37HwUVD8t6yFFF2i
 K9uzdQE0CVEBegCH+cE2jXGS1g==
X-Google-Smtp-Source: APXvYqyLc4LLS65QuaEHBxTf7DS/v/BOWe06+DOgtv0dsL3400f/yp5FQ89iOv8ORTWV9xLB0/4cRQ==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr3304548wmh.44.1576753158797; 
 Thu, 19 Dec 2019 02:59:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g7sm6091078wrq.21.2019.12.19.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45D501FFA9;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/25] linux-user: convert target_mprotect debug to tracepoint
Date: Thu, 19 Dec 2019 10:49:28 +0000
Message-Id: <20191219104934.866-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a pain to re-compile when you need to debug and tracepoints are
a fairly low impact way to instrument QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191205122518.10010-2-alex.bennee@linaro.org>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 46a6e3a761a..26a83e74069 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-
+#include "trace.h"
 #include "qemu.h"
 
 //#define DEBUG_MMAP
@@ -66,13 +66,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     abi_ulong end, host_start, host_end, addr;
     int prot1, ret;
 
-#ifdef DEBUG_MMAP
-    printf("mprotect: start=0x" TARGET_ABI_FMT_lx
-           "len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
-           prot & PROT_READ ? 'r' : '-',
-           prot & PROT_WRITE ? 'w' : '-',
-           prot & PROT_EXEC ? 'x' : '-');
-#endif
+    trace_target_mprotect(start, len, prot);
 
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -TARGET_EINVAL;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 6df234bbb67..8419243de4e 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -11,3 +11,6 @@ user_handle_signal(void *env, int target_sig) "env=%p signal %d"
 user_host_signal(void *env, int host_sig, int target_sig) "env=%p signal %d (target %d("
 user_queue_signal(void *env, int target_sig) "env=%p signal %d"
 user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr 0x%"PRIx64 " current psw.addr 0x%"PRIx64
+
+# mmap.c
+target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
-- 
2.20.1


