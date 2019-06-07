Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62385C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCED20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G81clC+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCED20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAtm-00089h-SP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047M-RG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004GA-9N
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAot-0003x4-WA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id v19so1129291wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cQ0tfgve/Y4PUSaOnIOLkGNDESD+hZVEqLt68K3UEOk=;
 b=G81clC+6/P6GAgE93dcnmL4e5LVMKsjrJrY4MBsEWmB01u7eYsJW7EtsHx8fzhVbm6
 /qUB7f3Ppwh6JuWvf1NXnEJgP8KhdFLymDEmQGH77I/NdjUf6jFgu+V293Eh9VYu5cLs
 djjxsFxqVOHZPD5OUC8RssqPsMSVpCXOlaJBQ3CecndxUQRf95F7Q8MoJ4AM3BRc9JPv
 Z7mLpwCcSXP4xfQFhjXDeHaSNdPMVlvPFRUAp76yxRz91S1dICDMYTUL2BTtFd5gQ4YI
 /lwBqTr8vZ9NNkli82z1uOwWsrnJrXkgBFgSD74Hn1zTO1EyQuf3w8zL1EjrgZxEBJft
 XvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cQ0tfgve/Y4PUSaOnIOLkGNDESD+hZVEqLt68K3UEOk=;
 b=juUy2Zncm+pNe2WuLwhtoUYNwTmKjBcOyu7gyDEDcTSHkCwm6HwMFse5CKs1ocD6uF
 UzArbuxftmnx9PF/vKCN1XY3TkimnQnMIKqJiwkavjp2wkWjG8Bc7M5z5d3LaCJziXuH
 Eqx2xfWqbh2aIXcuvmbIgPp9pTptmn5Kk1MXoVeFcUL/wNcMXb0PGSxIId+oAz5PJR0Z
 CJ0n4WmWSSh5w+f4YhsjQ3VxXGU/Df8bZNHzzOwD9uabKH0GjANqvR89fcKF9cX7UjH2
 1Fog0xTQqKo84Z6DBY9rSrnLKdGGJbbzZw08d99EpaBBOQn/igxS1ZuoKRU78htQ0CFF
 zc2w==
X-Gm-Message-State: APjAAAWis6lTZ5rZlI2J2aYg5bYVwaULAkLu2sZVLyz84W9SuVpBS0kJ
 3bfp6xYuQ6S4OkVJYZHfIN7JoQ==
X-Google-Smtp-Source: APXvYqxCVlz13wYOW5kUYe7r8GvRQScEhevm+lRlkAIevQy3Wq4ptpj8tHG0U0BD8rFt6Vm3hU8S5Q==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr2753473wmg.135.1559898354536; 
 Fri, 07 Jun 2019 02:05:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x16sm1209094wmj.4.2019.06.07.02.05.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31A421FF8F;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:01 +0100
Message-Id: <20190607090552.12434-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 02/52] qemu-io-cmds: use clock_gettime for
 benchmarking
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous use of gettimeofday() ran into undefined behaviour when
we ended up doing a div 0 for a very short operation. This is because
gettimeofday only works at the microsecond level as well as being
prone to discontinuous jumps in system time. Using clock_gettime with
CLOCK_MONOTONIC gives greater precision and alleviates some of the
potential problems with time jumping around.

We could use CLOCK_MONOTONIC_RAW to avoid being tripped up by NTP and
adjtime but that is Linux specific so I decided it would do for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 30a7d9a13b..8904733961 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -248,20 +248,21 @@ static void cvtstr(double value, char *str, size_t size)
 
 
 
-static struct timeval tsub(struct timeval t1, struct timeval t2)
+static struct timespec tsub(struct timespec t1, struct timespec t2)
 {
-    t1.tv_usec -= t2.tv_usec;
-    if (t1.tv_usec < 0) {
-        t1.tv_usec += 1000000;
+    t1.tv_nsec -= t2.tv_nsec;
+    if (t1.tv_nsec < 0) {
+        t1.tv_nsec += NANOSECONDS_PER_SECOND;
         t1.tv_sec--;
     }
     t1.tv_sec -= t2.tv_sec;
     return t1;
 }
 
-static double tdiv(double value, struct timeval tv)
+static double tdiv(double value, struct timespec tv)
 {
-    return value / ((double)tv.tv_sec + ((double)tv.tv_usec / 1000000.0));
+    double seconds = tv.tv_sec + (tv.tv_nsec / 1e9);
+    return value / seconds;
 }
 
 #define HOURS(sec)      ((sec) / (60 * 60))
@@ -274,29 +275,27 @@ enum {
     VERBOSE_FIXED_TIME  = 0x2,
 };
 
-static void timestr(struct timeval *tv, char *ts, size_t size, int format)
+static void timestr(struct timespec *tv, char *ts, size_t size, int format)
 {
-    double usec = (double)tv->tv_usec / 1000000.0;
+    double frac_sec = tv->tv_nsec / 1e9;
 
     if (format & TERSE_FIXED_TIME) {
         if (!HOURS(tv->tv_sec)) {
-            snprintf(ts, size, "%u:%02u.%02u",
-                    (unsigned int) MINUTES(tv->tv_sec),
-                    (unsigned int) SECONDS(tv->tv_sec),
-                    (unsigned int) (usec * 100));
+            snprintf(ts, size, "%u:%05.2f",
+                     (unsigned int) MINUTES(tv->tv_sec),
+                     SECONDS(tv->tv_sec) + frac_sec);
             return;
         }
         format |= VERBOSE_FIXED_TIME; /* fallback if hours needed */
     }
 
     if ((format & VERBOSE_FIXED_TIME) || tv->tv_sec) {
-        snprintf(ts, size, "%u:%02u:%02u.%02u",
+        snprintf(ts, size, "%u:%02u:%05.2f",
                 (unsigned int) HOURS(tv->tv_sec),
                 (unsigned int) MINUTES(tv->tv_sec),
-                (unsigned int) SECONDS(tv->tv_sec),
-                (unsigned int) (usec * 100));
+                 SECONDS(tv->tv_sec) + frac_sec);
     } else {
-        snprintf(ts, size, "0.%04u sec", (unsigned int) (usec * 10000));
+        snprintf(ts, size, "%05.2f sec", frac_sec);
     }
 }
 
@@ -376,7 +375,7 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
     }
 }
 
-static void print_report(const char *op, struct timeval *t, int64_t offset,
+static void print_report(const char *op, struct timespec *t, int64_t offset,
                          int64_t count, int64_t total, int cnt, bool Cflag)
 {
     char s1[64], s2[64], ts[64];
@@ -649,7 +648,7 @@ static const cmdinfo_t read_cmd = {
 
 static int read_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
     bool Pflag = false, sflag = false, lflag = false, bflag = false;
     int c, cnt, ret;
@@ -758,13 +757,13 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
 
     buf = qemu_io_alloc(blk, count, 0xab);
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t1);
     if (bflag) {
         ret = do_load_vmstate(blk, buf, offset, count, &total);
     } else {
         ret = do_pread(blk, buf, offset, count, &total);
     }
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("read failed: %s\n", strerror(-ret));
@@ -836,7 +835,7 @@ static const cmdinfo_t readv_cmd = {
 
 static int readv_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
     int c, cnt, ret;
     char *buf;
@@ -891,9 +890,9 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t1);
     ret = do_aio_readv(blk, &qiov, offset, &total);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("readv failed: %s\n", strerror(-ret));
@@ -972,7 +971,7 @@ static const cmdinfo_t write_cmd = {
 
 static int write_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
     bool Pflag = false, zflag = false, cflag = false;
     int flags = 0;
@@ -1091,7 +1090,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         buf = qemu_io_alloc(blk, count, pattern);
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t1);
     if (bflag) {
         ret = do_save_vmstate(blk, buf, offset, count, &total);
     } else if (zflag) {
@@ -1101,7 +1100,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     } else {
         ret = do_pwrite(blk, buf, offset, count, flags, &total);
     }
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("write failed: %s\n", strerror(-ret));
@@ -1160,7 +1159,7 @@ static const cmdinfo_t writev_cmd = {
 
 static int writev_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false;
     int flags = 0;
     int c, cnt, ret;
@@ -1213,9 +1212,9 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t1);
     ret = do_aio_writev(blk, &qiov, offset, flags, &total);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("writev failed: %s\n", strerror(-ret));
@@ -1250,15 +1249,15 @@ struct aio_ctx {
     bool zflag;
     BlockAcctCookie acct;
     int pattern;
-    struct timeval t1;
+    struct timespec t1;
 };
 
 static void aio_write_done(void *opaque, int ret)
 {
     struct aio_ctx *ctx = opaque;
-    struct timeval t2;
+    struct timespec t2;
 
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
 
     if (ret < 0) {
@@ -1288,9 +1287,9 @@ out:
 static void aio_read_done(void *opaque, int ret)
 {
     struct aio_ctx *ctx = opaque;
-    struct timeval t2;
+    struct timespec t2;
 
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("readv failed: %s\n", strerror(-ret));
@@ -1425,7 +1424,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&ctx->t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                      BLOCK_ACCT_READ);
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, 0, aio_read_done, ctx);
@@ -1570,7 +1569,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
             return -EINVAL;
         }
 
-        gettimeofday(&ctx->t1, NULL);
+        clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
         block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                          BLOCK_ACCT_WRITE);
 
@@ -1746,7 +1745,7 @@ static const cmdinfo_t discard_cmd = {
 
 static int discard_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false;
     int c, ret;
     int64_t offset, bytes;
@@ -1787,9 +1786,9 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t1);
     ret = blk_pdiscard(blk, offset, bytes);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
         printf("discard failed: %s\n", strerror(-ret));
-- 
2.20.1


