Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E468E2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeKIMm9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E468E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxaL-0003mJ-50
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWO-0002F3-4N
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWN-00056N-A6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:51 -0400
Received: by mail-pl1-x644.google.com with SMTP id u22so3800078plq.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CpTMXKHcoiytZRid5gwjf0q94Tx9HJK5chSS8lZYa0c=;
 b=GeKIMm9LF31aLach7PhMa4JuTyVQ84YVnwA6UrIdpVF4hJCo3uo8D2tmNJG/AG6YNq
 2QxTq8MfklRNjSYR8+Z4KwqbHTcBDi4dQOBJ9LLfs4m7kwai/Kpn4FaQtx0xJZkj73L7
 hVFJKdkPE5d5nxtYIWauEHlhKhlU9UCN4efgC97wrWI0W5iZTdlLJK1q0pb6aMYjsAxU
 wqW3fBGpuJFohfytqvhxS4wjqDhNN+Ytb2DwzwrhHVrvQ46y2RYHSW0LGumBsyySz/t+
 Q9MsLO+Q1VLj90bUlYqGoqFFP8N1IFotq7etyfQod3OAavYuB9Kf66AncMwfRRlD/9kn
 9Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CpTMXKHcoiytZRid5gwjf0q94Tx9HJK5chSS8lZYa0c=;
 b=UdOUX4K50eusC1sLJsy5MM7SlGbYJV7xYS/pjfzvBq7wFIhU0SqoMg7ghLxqeulb3w
 cs/MF/wO+snqsJCjN3gAhevTu+/ZW1/ElS/sDNk7xz457p593sqtfxtdiuPdwEkVU32A
 3VZ6X8oy7lkqZdxqWZVoeAl6F4rBokNn0cSqAf24M0TFzeSIXbRfQXNIZ9Il87/hXnyL
 /gnw3RePT4TIWAq2z3TwMpHk6pps4xBD+s5jWusGwtMUt4hXWFhvv21Qxqo71dDXU9qK
 5FNa7TGOtOPJxGuduWK2YxSz3UdBqAp3/mofuOCG87evOYSzJD0MP0tPFbp8A2o8T61T
 z5Gg==
X-Gm-Message-State: AOAM5311f6m0a1pzW5BkBH3aVrjw/aPo1VBwl36R0edRL30Db8zWAmqc
 7EN48WzbJerul/jK1O5hO1GbEaN7RD4=
X-Google-Smtp-Source: ABdhPJwsbKoL+88FMbr6lfFWByB3LmPWOZYOdCjkk5sbpWMkc6VjV1b8oDRrN1nsYNnx0nGm/160Sg==
X-Received: by 2002:a17:90a:fc8b:: with SMTP id
 ci11mr1786607pjb.40.1590114889697; 
 Thu, 21 May 2020 19:34:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/25] Make some risu.c symbols static
Date: Thu, 21 May 2020 19:34:21 -0700
Message-Id: <20200522023440.26261-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are unused in other translation units.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/risu.c b/risu.c
index 26dc116..ab17c71 100644
--- a/risu.c
+++ b/risu.c
@@ -31,18 +31,18 @@
 void *memblock;
 
 static int comm_fd;
-bool trace;
-size_t signal_count;
+static bool trace;
+static size_t signal_count;
 
 #ifdef HAVE_ZLIB
 #include <zlib.h>
-gzFile gz_trace_file;
+static gzFile gz_trace_file;
 #define TRACE_TYPE "compressed"
 #else
 #define TRACE_TYPE "uncompressed"
 #endif
 
-sigjmp_buf jmpbuf;
+static sigjmp_buf jmpbuf;
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 
@@ -113,7 +113,7 @@ void respond_trace(int r)
     }
 }
 
-void master_sigill(int sig, siginfo_t *si, void *uc)
+static void master_sigill(int sig, siginfo_t *si, void *uc)
 {
     int r;
     signal_count++;
@@ -135,7 +135,7 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
     }
 }
 
-void apprentice_sigill(int sig, siginfo_t *si, void *uc)
+static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
     int r;
     signal_count++;
@@ -180,9 +180,9 @@ static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
 typedef void entrypoint_fn(void);
 
 uintptr_t image_start_address;
-entrypoint_fn *image_start;
+static entrypoint_fn *image_start;
 
-void load_image(const char *imgfile)
+static void load_image(const char *imgfile)
 {
     /* Load image file into memory as executable */
     struct stat st;
@@ -214,7 +214,7 @@ void load_image(const char *imgfile)
     image_start_address = (uintptr_t) addr;
 }
 
-int master(void)
+static int master(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
@@ -240,7 +240,7 @@ int master(void)
     return EXIT_FAILURE;
 }
 
-int apprentice(void)
+static int apprentice(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
@@ -261,9 +261,9 @@ int apprentice(void)
     return EXIT_FAILURE;
 }
 
-int ismaster;
+static int ismaster;
 
-void usage(void)
+static void usage(void)
 {
     fprintf(stderr,
             "Usage: risu [--master] [--host <ip>] [--port <port>] <image file>"
-- 
2.20.1


