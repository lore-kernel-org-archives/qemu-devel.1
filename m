Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E58222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JK8dcoWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E58222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtfD-0007Dx-Hu
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWf-0003s7-92
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWe-00018X-0P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWd-00013X-ON
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id g17so5523689wro.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=92sA2vbfB/cZD8466MabdWOfrm8v8VCFN2q7tL8ddlM=;
 b=JK8dcoWiDUSE8AbuT1VALJD6l/4fKv23JilB72zO83jaR3QDJUprvr7DKHmC7575Hn
 3flvoJiI3WJGLr0MmE9aiw6y7q3X/ChYU3fWlid0FP14piFy4LS7s0fNKv7/jI94zTLB
 5iqHpEgSRkqh+ZyHna4HtCbB+svihH8QCGnr5g8j1/5b/sK+9i7RYhfC9f4iXFzxjpop
 XQtD9u7Wk7DPa6lK5K4ltHLsbdx/0a0EZfssg9jj6lWNf0E14/NV/ZfxkuIJi+zfS3Y8
 gMpi5h0HmVqnD7tB2IKa4LnfOfXPBAfIFwo2eOgc74gsy4GOwh+KejtK4DH+AzibwUZx
 t0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=92sA2vbfB/cZD8466MabdWOfrm8v8VCFN2q7tL8ddlM=;
 b=fZh8Cv8bqxt+1Ah7onCsF0rnuvpVeO7E5ogXG3SwkBXR/NWDjcefZA0GAopqC0l1x+
 a0A5BfgHYytFIVqOvX/Pe/AhxlR06101kkoY79W5xCxYtaV+ZmeTqhWf8qBBpoG8d+ik
 jg2tDNTLHdy7xd7xtRzDNFsXBMlcmrXZ6YYSOH+zIVQgJWV81tyRGwxutgG5LteYjDy8
 RZHnQyE3C+VNEsgsrhZbzq43f8vcR0hFvDmeBewNpT7LLx0sjiUsUFTRNthmxtBD8R1u
 VhfZ5q1g8G0Uk07RUxYIdsvfJilmmvpVjn1EE4S1wys83FkY6Wjydqp5UamTsq90QS0p
 JWyg==
X-Gm-Message-State: APjAAAWTQuDcahEepBOPtmIfGVDalRsbsQIKYYM8j7pOm5yMjDHODbwR
 /GI9+qO/xS2PynhAaTFJi0/OeA==
X-Google-Smtp-Source: APXvYqytyj738ws9rm9kj3OTKYLOPPxVn0GFtnsecy8kkoQbBkWY7Voom4ac/9+y67NG/R5Pa6eivg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr8920179wrv.120.1576753162550; 
 Thu, 19 Dec 2019 02:59:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm5699879wmj.40.2019.12.19.02.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A574E1FFAE;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 23/25] linux-user: convert target_munmap debug to a tracepoint
Date: Thu, 19 Dec 2019 10:49:32 +0000
Message-Id: <20191219104934.866-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
last remanents of the #ifdef hackery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191205122518.10010-6-alex.bennee@linaro.org>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 3d90fa459ca..8685f02e7e9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,8 +21,6 @@
 #include "exec/log.h"
 #include "qemu.h"
 
-//#define DEBUG_MMAP
-
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
@@ -597,11 +595,8 @@ int target_munmap(abi_ulong start, abi_ulong len)
     abi_ulong end, real_start, real_end, addr;
     int prot, ret;
 
-#ifdef DEBUG_MMAP
-    printf("munmap: start=0x" TARGET_ABI_FMT_lx " len=0x"
-           TARGET_ABI_FMT_lx "\n",
-           start, len);
-#endif
+    trace_target_munmap(start, len);
+
     if (start & ~TARGET_PAGE_MASK)
         return -TARGET_EINVAL;
     len = TARGET_PAGE_ALIGN(len);
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 6d6aeef7b52..f6de1b8befc 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -16,3 +16,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
 target_mmap(uint64_t start, uint64_t len, int pflags, int mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x flags=0x%x fd=%d offset=0x%"PRIx64
 target_mmap_complete(uint64_t retaddr) "retaddr=0x%"PRIx64
+target_munmap(uint64_t start, uint64_t len) "start=0x%"PRIx64" len=0x%"PRIx64
-- 
2.20.1


