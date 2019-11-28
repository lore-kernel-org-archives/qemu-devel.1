Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD398C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916A421781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq5bJ/2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916A421781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRKm-0004PE-EJ
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPpO-0005h1-8d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPkT-0006Wc-2V
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaPjw-0004uS-R1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id z19so12823187wmk.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cHVkaylNoydLTY4nbj39jRtqYAY0ZylLt+xXhgtOIDo=;
 b=aq5bJ/2tZo0aALMDdwz2F9WXwqSRrwAxd+JPToJf42+vwWV/v7XiEDIuau/L+SpIIx
 R8N2zkgVL+IRJtg2xe96v6YPXIVIoenjIJL/MGDKBBr7k0kRRSSm9kk+5O/HnQL9Gsfm
 ICcnJhEiWbbVCvRnsuxUf+Ga3c/F1NH/EXovxm5YmM5R3Cd+Zvus2+b5dTmmJJpJI5HR
 EZXKy5v6bZnPQTv6uL1eJ0ZQnWMrk5P/PWa7LVW6Iil+DoSEztDPqjQFmQPJwtAEvrAN
 Tga8AruCWC0r/RxZ5SHeNHrUFM2c/JPciRNaest/7P4GBnOJ8hTaD+S/+2eAQy3+tBtg
 B/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cHVkaylNoydLTY4nbj39jRtqYAY0ZylLt+xXhgtOIDo=;
 b=qgXXkRegy4V+oU/n7sgB0fkft+qgQnJhh1WbWK+1RMYUjWN3fplHl+/Cy/mKsYJwHD
 w4jqml+Q7oVL/ccnR07WDkZ3PINZsCnwp1CiqYGjVFGYopv4Pax/zD4aYeGFpgHy5luG
 Wtd4/vLuuZnObdkyErMMPpD+T0IOUxqhYKJf8jMXeJtyfYceO09/ZRercWjJccSnq0NH
 sQWy2TQqKRwVVNFsrIAnYG+eEVP51rH4XozX0sbbI2d922QX88l3E5fDTF1nkM/eL9bZ
 FRQooW7u/PT3mpCACg6NiB461fAHqqM+HBylBhT5dooaupIpLo2mqXVkV1rtoFnGuGF8
 klvw==
X-Gm-Message-State: APjAAAX05fGGi5o1DMM3mVSigSWeK22sXcDF11YX1bBAvFzQfJtuvIgG
 1Xb8HYUBvcH+6+BcUXYrHx1n8A==
X-Google-Smtp-Source: APXvYqxgva5Fbsr15ZBZx/gLGLlrh0LNutneNJiwPoII/GI6nQzPk5fBOOo5bTq3WBNimIDU1oEBww==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr11456859wmc.55.1574970365731; 
 Thu, 28 Nov 2019 11:46:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm24335043wrs.55.2019.11.28.11.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 11:46:04 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D84A1FF8C;
 Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] linux-user: convert target_mprotect debug to tracepoint
Date: Thu, 28 Nov 2019 19:45:59 +0000
Message-Id: <20191128194603.24818-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128194603.24818-1-alex.bennee@linaro.org>
References: <20191128194603.24818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a pain to re-compile when you need to debug and tracepoints are
a fairly low impact way to instrument QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c       | 17 +++++++++--------
 linux-user/trace-events |  3 +++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 46a6e3a761a..66868762519 100644
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
@@ -66,13 +66,14 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     abi_ulong end, host_start, host_end, addr;
     int prot1, ret;
 
-#ifdef DEBUG_MMAP
-    printf("mprotect: start=0x" TARGET_ABI_FMT_lx
-           "len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
-           prot & PROT_READ ? 'r' : '-',
-           prot & PROT_WRITE ? 'w' : '-',
-           prot & PROT_EXEC ? 'x' : '-');
-#endif
+    if (TRACE_TARGET_MPROTECT_ENABLED) {
+        char prot_str[4];
+        prot_str[0] = prot & PROT_READ ? 'r' : '-';
+        prot_str[1] = prot & PROT_WRITE ? 'w' : '-';
+        prot_str[2] = prot & PROT_EXEC ? 'x' : '-';
+        prot_str[3] = 0;
+        trace_target_mprotect(start, len, prot_str);
+    }
 
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -TARGET_EINVAL;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 6df234bbb67..41d72e61abb 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -11,3 +11,6 @@ user_handle_signal(void *env, int target_sig) "env=%p signal %d"
 user_host_signal(void *env, int host_sig, int target_sig) "env=%p signal %d (target %d("
 user_queue_signal(void *env, int target_sig) "env=%p signal %d"
 user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr 0x%"PRIx64 " current psw.addr 0x%"PRIx64
+
+# mmap.c
+target_mprotect(uint64_t start, uint64_t len, char *flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s"
-- 
2.20.1


