Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B95207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sggDIA9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B95207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasRy-0005F3-VB
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasON-0005Et-1D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOL-0002Pb-Tt
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id t7so5040845plr.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gkn7wByXSMaAlsqr+FZUsAQqZ3Lrn4UK0Nd8TGF1NTg=;
 b=sggDIA9IMV1zv1XtEA6/+qvXi1YvJ7QzN5COet5oXvFn27dy4R6Ub0Zf8jG7D8gP0N
 opUD9EMRwkcRPzeEIe5nehvseUqPXncfftGT4pYMSDl0X8iOQDXcy9dhWyW91EjFFHOx
 OmrhG+qATc2UcOZo1oEa2E1D+7tT2gZSrJjqE5ePJEREuFl6skf0kzl9iI2b+efSC2TP
 EfrUleSH9U2BPNk382v4Wqan2wO8fZ+ygQ2UjZyXL/C4GfAiKHq/gnyRfdQ+eckphnIL
 0axRsXcnxMwQh6Ks+QcamFM86U7xl4MxKHAT8AFIpSbOgCvucprmIccjmdeyRbPj5je9
 2yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gkn7wByXSMaAlsqr+FZUsAQqZ3Lrn4UK0Nd8TGF1NTg=;
 b=tgkN4b0zEPmnh2I0XtOK5rkXhbE5UVW5e83PkZlMqpWKURZyx609ODuTE/n1spRvH+
 ZKMlzKajCxGbtwAwB1RSnFlt+MmS+h9XB+rjubKvvZxWOvlECnHnFTS5l0Ub1NmL7sTh
 LwvJXiOnLBwXAVKZBTuuh369kmCZ3iznE5bCJ8A70TWssoMy8ARDCr/cE0YnJO6/3+ts
 NJ9sbWYq9qCp08EcOBfRgIfl9bnQDZEcGKkLGd16TEPC+DkoZIWHvIFUOUA6L5qcaiaI
 IH6a0ZnaEcA6bOh4bz0myoFsdcKEhRvUvQ19l2Y4jgGxj5KtGENjPZq8V2oTx4Frw+rX
 6xHA==
X-Gm-Message-State: AOAM532XQFxYNlrE0Bm57UD84lO1Wbl6pouOnbz7CRVBwiRSFhwnCWff
 lMHf06wNS2mJR1m9poxNkIRD27Mc32U=
X-Google-Smtp-Source: ABdhPJzy/67A1vClM8I2qWp+Jvy9ORFiryWK2YP4rUc/aNQC6UyFIVPE3uBo6SP0DkDnrG6VcrNg3Q==
X-Received: by 2002:a17:90a:8a08:: with SMTP id
 w8mr2705121pjn.53.1589856844037; 
 Mon, 18 May 2020 19:54:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 05/17] Use EXIT_FAILURE, EXIT_SUCCESS
Date: Mon, 18 May 2020 19:53:43 -0700
Message-Id: <20200519025355.4420-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Some of the time we exit via the return value from main.
This can make it easier to tell what it is we're returning.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 comms.c                | 26 +++++++++++++-------------
 risu.c                 | 22 +++++++++++-----------
 risu_reginfo_aarch64.c |  4 ++--
 risu_reginfo_i386.c    |  2 +-
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/comms.c b/comms.c
index 6946fd9..861e845 100644
--- a/comms.c
+++ b/comms.c
@@ -31,7 +31,7 @@ int apprentice_connect(const char *hostname, int port)
     sock = socket(PF_INET, SOCK_STREAM, 0);
     if (sock < 0) {
         perror("socket");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     struct hostent *hostinfo;
     sa.sin_family = AF_INET;
@@ -39,12 +39,12 @@ int apprentice_connect(const char *hostname, int port)
     hostinfo = gethostbyname(hostname);
     if (!hostinfo) {
         fprintf(stderr, "Unknown host %s\n", hostname);
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     sa.sin_addr = *(struct in_addr *) hostinfo->h_addr;
     if (connect(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
         perror("connect");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     return sock;
 }
@@ -56,13 +56,13 @@ int master_connect(int port)
     sock = socket(PF_INET, SOCK_STREAM, 0);
     if (sock < 0) {
         perror("socket");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     int sora = 1;
     if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &sora, sizeof(sora)) !=
         0) {
         perror("setsockopt(SO_REUSEADDR)");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 
     sa.sin_family = AF_INET;
@@ -70,11 +70,11 @@ int master_connect(int port)
     sa.sin_addr.s_addr = htonl(INADDR_ANY);
     if (bind(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
         perror("bind");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     if (listen(sock, 1) < 0) {
         perror("listen");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     /* Just block until we get a connection */
     fprintf(stderr, "master: waiting for connection on port %d...\n",
@@ -84,7 +84,7 @@ int master_connect(int port)
     int nsock = accept(sock, (struct sockaddr *) &csa, &csasz);
     if (nsock < 0) {
         perror("accept");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     /* We're done with the server socket now */
     close(sock);
@@ -104,7 +104,7 @@ static void recv_bytes(int sock, void *pkt, int pktlen)
                 continue;
             }
             perror("read failed");
-            exit(1);
+            exit(EXIT_FAILURE);
         }
         pktlen -= i;
         p += i;
@@ -127,7 +127,7 @@ static void recv_and_discard_bytes(int sock, int pktlen)
                 continue;
             }
             perror("read failed");
-            exit(1);
+            exit(EXIT_FAILURE);
         }
         pktlen -= i;
     }
@@ -186,12 +186,12 @@ int send_data_pkt(int sock, void *pkt, int pktlen)
 
     if (safe_writev(sock, iov, 2) == -1) {
         perror("writev failed");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 
     if (read(sock, &resp, 1) != 1) {
         perror("read failed");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     return resp;
 }
@@ -217,6 +217,6 @@ void send_response_byte(int sock, int resp)
     unsigned char r = resp;
     if (write(sock, &r, 1) != 1) {
         perror("write failed");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 }
diff --git a/risu.c b/risu.c
index f404d8f..979341c 100644
--- a/risu.c
+++ b/risu.c
@@ -153,13 +153,13 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc)
         return;
     case 1:
         /* end of test */
-        exit(0);
+        exit(EXIT_SUCCESS);
     default:
         /* mismatch */
         if (trace) {
             siglongjmp(jmpbuf, 1);
         }
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 }
 
@@ -173,7 +173,7 @@ static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
     sigemptyset(&sa.sa_mask);
     if (sigaction(SIGILL, &sa, 0) != 0) {
         perror("sigaction");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 }
 
@@ -190,11 +190,11 @@ void load_image(const char *imgfile)
     int fd = open(imgfile, O_RDONLY);
     if (fd < 0) {
         fprintf(stderr, "failed to open image file %s\n", imgfile);
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     if (fstat(fd, &st) != 0) {
         perror("fstat");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     size_t len = st.st_size;
     void *addr;
@@ -207,7 +207,7 @@ void load_image(const char *imgfile)
              0);
     if (!addr) {
         perror("mmap");
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     close(fd);
     image_start = addr;
@@ -226,7 +226,7 @@ int master(void)
         if (trace) {
             fprintf(stderr, "trace complete after %zd checkpoints\n",
                     signal_count);
-            return 0;
+            return EXIT_SUCCESS;
         } else {
             return report_match_status(false);
         }
@@ -237,7 +237,7 @@ int master(void)
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
-    exit(1);
+    return EXIT_FAILURE;
 }
 
 int apprentice(void)
@@ -258,7 +258,7 @@ int apprentice(void)
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
-    exit(1);
+    return EXIT_FAILURE;
 }
 
 int ismaster;
@@ -355,7 +355,7 @@ int main(int argc, char **argv)
             break;
         case '?':
             usage();
-            exit(1);
+            return EXIT_FAILURE;
         default:
             assert(c >= FIRST_ARCH_OPT);
             process_arch_opt(c, optarg);
@@ -382,7 +382,7 @@ int main(int argc, char **argv)
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
         usage();
-        exit(1);
+        return EXIT_FAILURE;
     }
 
     load_image(imgfile);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 00d1c8b..028c690 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -51,7 +51,7 @@ void process_arch_opt(int opt, const char *arg)
 
     if (test_sve <= 0 || test_sve > SVE_VQ_MAX) {
         fprintf(stderr, "Invalid value for VQ (1-%d)\n", SVE_VQ_MAX);
-        exit(1);
+        exit(EXIT_FAILURE);
     }
     want = sve_vl_from_vq(test_sve);
     got = prctl(PR_SVE_SET_VL, want);
@@ -62,7 +62,7 @@ void process_arch_opt(int opt, const char *arg)
             fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
                     test_sve, (int)sve_vq_from_vl(got));
         }
-        exit(1);
+        exit(EXIT_FAILURE);
     }
 #else
     abort();
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 194e0ad..60fc239 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -69,7 +69,7 @@ void process_arch_opt(int opt, const char *arg)
             fprintf(stderr,
                     "Unable to parse '%s' in '%s' into an xfeatures integer mask\n",
                     endptr, arg);
-            exit(1);
+            exit(EXIT_FAILURE);
         }
     }
 }
-- 
2.20.1


