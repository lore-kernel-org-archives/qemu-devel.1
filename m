Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B2C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B758323D5F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBMcVcOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B758323D5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1Oz-0004aO-Pd
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:26:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW1O0-000492-V3
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW1Nx-0003TI-Dg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:25:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hW1Nt-0003C9-0V
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:25:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id s17so2245542wru.3
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W0SJ8X2eriH/6uj+RKzK10RqVpztQENWh4cWX7jYDAc=;
	b=OBMcVcOWTlFcfIZCbvsu422JxebiE/oN+Lf+leJmuWolRjayadeZiwRPe1BsH8vxqJ
	ZiWBqfacKGxiJtNwCXAcIymiQXfyByagnbAhu2VAD8YntD0OtrSrOmtvsUJstUGqcXQt
	VXa52Y1asLpzGk5JG4xTkDZF4IlLU9gmIqucDawzAkY0PuiJYPXp5LjpsI8yrYRw5y5Z
	hBBsLSZdtjf+lItxd4rhf9iGhIpqTk9rTZeLZAmnrJK2ll9ipQS6IDO3sNC1mRSLg8Ql
	W3/dV14klhYXMdtB/yogBnKN9zCr4/eD6LUd6jnpMFI0wg394gUba7sqBgKJRxrxnEsf
	0OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=W0SJ8X2eriH/6uj+RKzK10RqVpztQENWh4cWX7jYDAc=;
	b=mfHGcSSDXjwv1d7zgT/Rf8yLVcwwECN64CtAaHYUQ6b0nOZ6hGaGJV2dM1ktugFUtA
	Fpg0CCXW7dcj0ctdhs3qgVTNVwijyvPnLsg8WYcX5j1EXC6CjouuVhrseWKj/mnuDV2l
	USgy7Ug+aN7GGt/38lc+yNs//1D5RYtZVyw6YYUuyZic5x6wzXIjnd96Rk2LZo4mXgaE
	KSLviByglZ/dHNTikcrP4FTX57v8je8af/tJamzYMhlpXYrj4owNIkG837vQ5oHBSDsJ
	3cjnf+V9cL+nnvA4dBDaT3K922Y5tOEeYs6MpyOfda1mry/gjHuWRhEEdFgiXShffofb
	kTUA==
X-Gm-Message-State: APjAAAX4tG04pJ1vjtFsBb1WXfuPYlwoO17F+2FaKD4RKgr65ttASdRE
	WFraHx3b6d5Fpmot1XjLClTEsQ==
X-Google-Smtp-Source: APXvYqzo+3LwH9lTvP/CZg0ro/Mz3OsZFnbFjCM57o2PglRllOH0LF2TE5iYj2wWZmdbATMnEk3WCw==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr16004900wrw.160.1559147089687; 
	Wed, 29 May 2019 09:24:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d17sm24019029wrw.18.2019.05.29.09.24.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:24:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 215211FF87;
	Wed, 29 May 2019 17:24:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 17:24:38 +0100
Message-Id: <20190529162438.22653-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [RFC PATCH] qemu-io-cmds: use clock_gettime for
 benchmarking
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
---
 qemu-io-cmds.c | 69 +++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 30a7d9a13bf..4ace2969a9e 100644
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
+        t1.tv_nsec += 1000000000;
         t1.tv_sec--;
     }
     t1.tv_sec -= t2.tv_sec;
     return t1;
 }
 
-static double tdiv(double value, struct timeval tv)
+static double tdiv(double value, struct timespec tv)
 {
-    return value / ((double)tv.tv_sec + ((double)tv.tv_usec / 1000000.0));
+    double time = (double)tv.tv_sec + ((double)tv.tv_nsec / 1000000000.0);
+    return value / time;
 }
 
 #define HOURS(sec)      ((sec) / (60 * 60))
@@ -274,16 +275,16 @@ enum {
     VERBOSE_FIXED_TIME  = 0x2,
 };
 
-static void timestr(struct timeval *tv, char *ts, size_t size, int format)
+static void timestr(struct timespec *tv, char *ts, size_t size, int format)
 {
-    double usec = (double)tv->tv_usec / 1000000.0;
+    double nsec = (double)tv->tv_nsec / 1000000000.0;
 
     if (format & TERSE_FIXED_TIME) {
         if (!HOURS(tv->tv_sec)) {
             snprintf(ts, size, "%u:%02u.%02u",
                     (unsigned int) MINUTES(tv->tv_sec),
                     (unsigned int) SECONDS(tv->tv_sec),
-                    (unsigned int) (usec * 100));
+                    (unsigned int) (nsec * 100000));
             return;
         }
         format |= VERBOSE_FIXED_TIME; /* fallback if hours needed */
@@ -294,9 +295,9 @@ static void timestr(struct timeval *tv, char *ts, size_t size, int format)
                 (unsigned int) HOURS(tv->tv_sec),
                 (unsigned int) MINUTES(tv->tv_sec),
                 (unsigned int) SECONDS(tv->tv_sec),
-                (unsigned int) (usec * 100));
+                (unsigned int) (nsec * 100000));
     } else {
-        snprintf(ts, size, "0.%04u sec", (unsigned int) (usec * 10000));
+        snprintf(ts, size, "0.%04u sec", (unsigned int) (nsec * 10000000));
     }
 }
 
@@ -376,7 +377,7 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
     }
 }
 
-static void print_report(const char *op, struct timeval *t, int64_t offset,
+static void print_report(const char *op, struct timespec *t, int64_t offset,
                          int64_t count, int64_t total, int cnt, bool Cflag)
 {
     char s1[64], s2[64], ts[64];
@@ -649,7 +650,7 @@ static const cmdinfo_t read_cmd = {
 
 static int read_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
     bool Pflag = false, sflag = false, lflag = false, bflag = false;
     int c, cnt, ret;
@@ -758,13 +759,13 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
 
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
@@ -836,7 +837,7 @@ static const cmdinfo_t readv_cmd = {
 
 static int readv_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
     int c, cnt, ret;
     char *buf;
@@ -891,9 +892,9 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t1);
     ret = do_aio_readv(blk, &qiov, offset, &total);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
     if (ret < 0) {
         printf("readv failed: %s\n", strerror(-ret));
@@ -972,7 +973,7 @@ static const cmdinfo_t write_cmd = {
 
 static int write_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
     bool Pflag = false, zflag = false, cflag = false;
     int flags = 0;
@@ -1091,7 +1092,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         buf = qemu_io_alloc(blk, count, pattern);
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t1);
     if (bflag) {
         ret = do_save_vmstate(blk, buf, offset, count, &total);
     } else if (zflag) {
@@ -1101,7 +1102,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     } else {
         ret = do_pwrite(blk, buf, offset, count, flags, &total);
     }
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
     if (ret < 0) {
         printf("write failed: %s\n", strerror(-ret));
@@ -1160,7 +1161,7 @@ static const cmdinfo_t writev_cmd = {
 
 static int writev_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false;
     int flags = 0;
     int c, cnt, ret;
@@ -1213,9 +1214,9 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t1);
     ret = do_aio_writev(blk, &qiov, offset, flags, &total);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
     if (ret < 0) {
         printf("writev failed: %s\n", strerror(-ret));
@@ -1250,15 +1251,15 @@ struct aio_ctx {
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
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
 
     if (ret < 0) {
@@ -1288,9 +1289,9 @@ out:
 static void aio_read_done(void *opaque, int ret)
 {
     struct aio_ctx *ctx = opaque;
-    struct timeval t2;
+    struct timespec t2;
 
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
     if (ret < 0) {
         printf("readv failed: %s\n", strerror(-ret));
@@ -1425,7 +1426,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&ctx->t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&ctx->t1);
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                      BLOCK_ACCT_READ);
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, 0, aio_read_done, ctx);
@@ -1570,7 +1571,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
             return -EINVAL;
         }
 
-        gettimeofday(&ctx->t1, NULL);
+        clock_gettime(CLOCK_MONOTONIC,&ctx->t1);
         block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                          BLOCK_ACCT_WRITE);
 
@@ -1746,7 +1747,7 @@ static const cmdinfo_t discard_cmd = {
 
 static int discard_f(BlockBackend *blk, int argc, char **argv)
 {
-    struct timeval t1, t2;
+    struct timespec t1, t2;
     bool Cflag = false, qflag = false;
     int c, ret;
     int64_t offset, bytes;
@@ -1787,9 +1788,9 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    gettimeofday(&t1, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t1);
     ret = blk_pdiscard(blk, offset, bytes);
-    gettimeofday(&t2, NULL);
+    clock_gettime(CLOCK_MONOTONIC,&t2);
 
     if (ret < 0) {
         printf("discard failed: %s\n", strerror(-ret));
-- 
2.20.1


