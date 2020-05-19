Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38342C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088E3207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArXsA2Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088E3207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasPP-00070y-4g
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasON-0005HG-QE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:07 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:39353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOM-0002Q0-V2
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:07 -0400
Received: by mail-pj1-x1031.google.com with SMTP id n15so714445pjt.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g+TVWgWDZ8IS/kHh58SBa/DlK1/0pDXOV4De7Fp0uPY=;
 b=ArXsA2Rao8ftzq6X3V6uaru9KibGQ2RCqIoi28zZccff4i0Ejkl8CdGXSZALFz7BYf
 frn1rg2yv/zJIJUCHp9C/HP+N6ntKqClWMD+BJHi+wb+FuSXjomtdNTT4Ic0JHSkaQ8r
 v2hIvirLQG/VyflOa0OeDKsGKgs+yvn+l/ITkqFHwsCoR1Y8vMbehAwhkEeGrY0NURae
 amwyz/YUFIxIVePbIsntFNAp2wvzJpePeUv3pxgNR6BmNLQQ0nJZN9csxBhMT/h+lq6G
 NxrRY7uLvb/TWzuYFs72OT3e6FKrLMV09wN9ebgXahrQj6zVIemvkV5BJLCNQL/C8KKV
 Q5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g+TVWgWDZ8IS/kHh58SBa/DlK1/0pDXOV4De7Fp0uPY=;
 b=rD3tlXUslys9HdxvyM3uPCsMz6Y+asEXqlKkmS40FhSFHanyjwlInCzQvojcR3X43V
 9hcvXaMq+qEN+JrMO3p7jOpKeqgvZP5I8MJryFVEWF3nYhjcJzJPOOLvhOjrdpTK/4D8
 WGbBXYQ9sgCIDWqx0TUwfab3pMO4cb14LbcAJBMjiZJABnk4fDioRn5MPEoREtVGQ0mr
 Zr9epIElTbxKVdSSoEI0mI9wJz8U43N/EXomI0xB0B2PQ0MdQap+4IHhtxtB9wFMiCYB
 zXwTlZYYOHpknwz50sKk2reujugWMGQyG/l09XQ0HSm5DANEDGY8+SWoeM/bv/ZWWMt+
 VOBw==
X-Gm-Message-State: AOAM532rUqvb0pexDT8cm0j6m1a15fMiwPoP9y6MzoudZJhgH3mAe2w3
 /8iJspeIYkz71jN1nVLYqHt4tjxNu9M=
X-Google-Smtp-Source: ABdhPJxWzUgUjoy2U41UXlbYRi8H6wlxxrRyjq7oWyd2mw/AkwBz+yabHZ4P7gX5eAzQLMCDnssm7g==
X-Received: by 2002:a17:90a:246d:: with SMTP id
 h100mr2435084pje.21.1589856845228; 
 Mon, 18 May 2020 19:54:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 06/17] Make some risu.c symbols static
Date: Mon, 18 May 2020 19:53:44 -0700
Message-Id: <20200519025355.4420-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are unused in other translation units.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/risu.c b/risu.c
index 979341c..24ada8f 100644
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


