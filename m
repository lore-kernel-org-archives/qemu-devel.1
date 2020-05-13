Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A723AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F052065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kymvCFFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F052065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvvD-0005RS-Kw
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpY-0003pP-DW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpW-0000MT-De
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id x13so85235pfn.11
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AMQUtdh7GLtHPDRn6Oq7V+4ssQorJyRBdGwREFAHbh4=;
 b=kymvCFFhFOFLhJ4hFYNOMm3/3e3hmC5maCZsO3r0Usp++7HlaZ0iBISGndlnh243l7
 bQvFecuDz3lGzcbpy7jbrFeJ+ZSmUZPrRZn20e7IllcuwVL4ZR8L24Vvn8J2fpTQQmAk
 U5eI5Oq/eYBKYSSHcGNy2GuQwkwxNb79kDU9B6zqy1S6fPhOgeRBJerOnAfg457cVctI
 ZiNB8SmXDFWFcQIuZMtfsCFQtb6x7oBmp8VPB1YoaqWw5Bj+oonN0FMiDogUOPCYkURM
 nytDtGjk4yblUJ2f/dSSlnigS5S0Bl0X1EN+37tAxWH2EhBG2T+bwEJWLLALWcBPGn7f
 osVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AMQUtdh7GLtHPDRn6Oq7V+4ssQorJyRBdGwREFAHbh4=;
 b=jESNxP/QkAJKdqRfrIOPGq0/PDMluxR/hECnlRQGRg8re1dm1ghN45Hna78gBlJ4Ki
 8v9s4nyVvbtYiFioJI4VJ3B5QAsCl95HDHHsTFlAmrTVZQDV3yhZppKqaSmZthq5YBpa
 X9LM/jqxBCPp0bL6ihKHEyKDN01SUPyou6dJ8afUAFYZiNB+5mfrnrME5SUQrvtwAK5i
 03ZcPr7YyY7mZiwNynD9FAZHeltcbOxhkljuKHApODRE0vyoUiwCZ3MsgampSw8ffMK8
 sAMxOJ5+3rAh+bF+WL7yFdJihj473oLP1E2JmirFWbrVY6NfY5YzqRXK+LBgHyGUGBTg
 2WTQ==
X-Gm-Message-State: AOAM531qsTN+Vh9F092AqFShItGfS31fPcYfLoWbn65It+Y5cz2MA2uO
 XFXIycM5/ZfIWjxnoBwBP5MjCyYTGzs=
X-Google-Smtp-Source: ABdhPJxPsUq4BV0znn8LSy5Q8X5IvJNNg9vZ8Vr8iGOiak2Wx6Mk7ExopK6xiFHsTWWq7fbYS140Qg==
X-Received: by 2002:a62:144b:: with SMTP id 72mr516753pfu.246.1589393402119;
 Wed, 13 May 2020 11:10:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:10:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 5/9] Use EXIT_FAILURE, EXIT_SUCCESS
Date: Wed, 13 May 2020 11:09:49 -0700
Message-Id: <20200513180953.20376-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


