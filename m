Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E256C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB6A20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pig4dPrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB6A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSgY-0000qf-15
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:45:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYq-0002kh-8y
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYp-0003Py-9e
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:36 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYp-0003P3-3o
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:35 -0400
Received: by mail-pf1-x442.google.com with SMTP id b76so6171269pfb.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qYhnP8CmUyN8DJK4QlR57fQbe3qhOBTecaegSn//V4c=;
	b=Pig4dPrhh0IQm2puL4y7L1z5VCzEWx8rAXfTzOzVG954/QZK7RpTsJZy4z1bW2BNJS
	9v3NoT/3b/QSvihL1POvzSZRt4gq2lg2io6GZq/U2AEs8N8kExJuGYMNvsuBHsrfUOD7
	3Fzr5mz/qoklKqDJChWhpBRxx8gp0NwT8J7SpMUTo9scUeFs7t7wLf4v5AV1HbvuWGT7
	1K+GKhj63Z20E7QZ54UdZp5dalZt3qFXAKCA+G4O5E/7aFeU2UrXngO1pcqH/hbsU1Ik
	5GFfjOim4KUAgj14hfzp6dH799w/9EeGfavRjwLKoq+GMOxj+Dg9JdIlmXwon58A3vML
	e8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qYhnP8CmUyN8DJK4QlR57fQbe3qhOBTecaegSn//V4c=;
	b=m6M2EXQh0/KffIsSKekup6+dXnG/ftK8S2wS+7t1VmFhV0fFTOvKOJLilpmA8Hb/xZ
	k7jltatGDXTL28yHap8JE9Rb7nptJ2Ewy0WBgxz6pJblUBcynxhEbgNysoD7nqY4NiF/
	xMiHJwnXhi1KRJscI87W1EgWlQo4pExHA6pTbr28GftR5wfX8z7O39uW7pfhWginv7tJ
	bML9RSf4dYZcQ3o0nkMo+xOq3BDErMWHU+Qbm3rpd3pBlFykHFGNzlbiE/bC9B0f2Der
	hwhcFFhktcgEaOZIRXf0VwWP6VV8SHZBdegxZk16SN5ry67/Ywh8yLzCRrtgNrwuyoib
	mKKQ==
X-Gm-Message-State: APjAAAUi3OEbEAf+BzUYIZIZov/AdYdnh04IK7rZUYZvjlRCaKKSWdJu
	A4eQUbdIOGcsKXls48QEN4diPATPamw=
X-Google-Smtp-Source: APXvYqw+ALPcUrxjj6nEWahdpZU8jwelqI//CcT5EMGcBGVVlMmjAJZCLJm+LczsBjxbnnAm3Acsfg==
X-Received: by 2002:a63:374b:: with SMTP id g11mr15571441pgn.421.1558298253819;
	Sun, 19 May 2019 13:37:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:16 -0700
Message-Id: <20190519203726.20729-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 04/74] linux-user: Tidy do_openat loop over
 fakes
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleaner to use ARRAY_SIZE to loop over elements instead of
using a sentinel within the data structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-file.inc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 961eed13ae..30f8e35cdd 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -235,7 +235,6 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
         int (*fill)(void *cpu_env, int fd);
         int (*cmp)(const char *s1, const char *s2);
     };
-    const struct fake_open *fake_open;
     static const struct fake_open fakes[] = {
         { "maps", open_self_maps, is_proc_myself },
         { "stat", open_self_stat, is_proc_myself },
@@ -244,12 +243,12 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-        { NULL, NULL, NULL }
     };
 
     char *pathname = lock_user_string(target_path);
     int flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
     abi_long ret;
+    size_t i;
 
     if (!pathname) {
         return -TARGET_EFAULT;
@@ -263,17 +262,16 @@ static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
         goto done;
     }
 
-    for (fake_open = fakes; fake_open->filename; fake_open++) {
-        if (fake_open->cmp(pathname, fake_open->filename)) {
-            break;
-        }
-    }
-
-    if (fake_open->filename) {
+    for (i = 0; i < ARRAY_SIZE(fakes); ++i) {
+        const struct fake_open *fake_open = &fakes[i];
         const char *tmpdir;
         char filename[PATH_MAX];
         int fd;
 
+        if (!fake_open->cmp(pathname, fake_open->filename)) {
+            continue;
+        }
+
         /* create temporary file to map stat to */
         tmpdir = getenv("TMPDIR");
         if (!tmpdir) {
-- 
2.17.1


