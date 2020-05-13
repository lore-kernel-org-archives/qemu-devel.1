Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C542065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8FwMa94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C542065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvrv-0007Xw-4p
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpS-0003kp-3f
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:55129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpQ-0000Kz-96
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id s69so3155726pjb.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QFzU9EJ6IyuyhrhMiANrpQRCnZfFACVjoAb6ym/Zpjk=;
 b=r8FwMa94VsjeF2dEKwVrbAE75YVKx9F85MBWEmXZB73xGvmT0RaF76mesHjLbsIBL3
 h2Qix5o72Jky34NNbxRHlYhRr90yPBjZnOBZWu1yGRh54bnbQVUcNVyYE3/tmdSelvRF
 WkYPDpGNeO1PO6PLs0RxRdZ82DFXCjLDc4SkrdvXehKSs0OxEJMxwLvmb51BuDdXm5Ut
 +4PrWB3oAlgf/xUWf0WyVmDVaHGEvQdgeB18H29v+hH6PtuC1jDzTMUXJud+14tM3+Ta
 VjcCMAt+SYNw9ioWkh6K6YI0PF6noz765PZ9nMmBOuXkTz3jWhiHmRIinpWLv8ShQBrs
 RjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QFzU9EJ6IyuyhrhMiANrpQRCnZfFACVjoAb6ym/Zpjk=;
 b=JQ2CVG5YfTtizRmqcCQwtzUHwg9n+8+OwIshuKM/zEloBBkfQrKQSfKGzu5784p2Nm
 FYxiEWX7V8t8asyLRePRI+7ZcpmLG2K9YG2rTP9EplaHK/lxhhTsdPGL/O6DWN0nkWRV
 8CkNdnQHgvOOACdG6DwxmgIuh/tO0sGnce6k61eXNMkP4nMXuTS0AYR9eQ6JRKCDLrFz
 zaxf9vFudqtB6g/s1q8Jo2X2cDi4riDRHNGi9Ym1vnZgdN05UxvA3TB8IHU4zKTEx/vM
 QPEdcw6husRIVD/DL+RZ1am8WloO2tisuFIkgIFb4E6xad2rUn4ZxUdwMIG0GRiwB7YY
 XiSQ==
X-Gm-Message-State: AOAM530FhwmjwWJJsRWmKNrDpulfc+qkamW09yKZtKgsKqgTdR0UQKkG
 TI4xRXu943DpzdohDnNkKE4wPkTGFH0=
X-Google-Smtp-Source: ABdhPJxCYRyw6Q9obx4XWbdTvUYGtCwqvEm35Izbu0vZXfvrpkExpy0DaosZir01Da7z9Skj/z20Uw==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr19434pll.320.1589393398207; 
 Wed, 13 May 2020 11:09:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:09:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 2/9] Unify master_fd and apprentice_fd to comm_fd
Date: Wed, 13 May 2020 11:09:46 -0700
Message-Id: <20200513180953.20376-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
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

Any one invocation cannot be both master and apprentice.
Let's use only one variable for the file descriptor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/risu.c b/risu.c
index 79b1092..059348f 100644
--- a/risu.c
+++ b/risu.c
@@ -30,7 +30,7 @@
 
 void *memblock;
 
-int apprentice_fd, master_fd;
+static int comm_fd;
 bool trace;
 size_t signal_count;
 
@@ -50,7 +50,7 @@ sigjmp_buf jmpbuf;
 
 int read_sock(void *ptr, size_t bytes)
 {
-    return recv_data_pkt(master_fd, ptr, bytes);
+    return recv_data_pkt(comm_fd, ptr, bytes);
 }
 
 int write_trace(void *ptr, size_t bytes)
@@ -58,9 +58,9 @@ int write_trace(void *ptr, size_t bytes)
     size_t res;
 
 #ifdef HAVE_ZLIB
-    if (master_fd == STDOUT_FILENO) {
+    if (comm_fd == STDOUT_FILENO) {
 #endif
-        res = write(master_fd, ptr, bytes);
+        res = write(comm_fd, ptr, bytes);
 #ifdef HAVE_ZLIB
     } else {
         res = gzwrite(gz_trace_file, ptr, bytes);
@@ -71,14 +71,14 @@ int write_trace(void *ptr, size_t bytes)
 
 void respond_sock(int r)
 {
-    send_response_byte(master_fd, r);
+    send_response_byte(comm_fd, r);
 }
 
 /* Apprentice function */
 
 int write_sock(void *ptr, size_t bytes)
 {
-    return send_data_pkt(apprentice_fd, ptr, bytes);
+    return send_data_pkt(comm_fd, ptr, bytes);
 }
 
 int read_trace(void *ptr, size_t bytes)
@@ -86,9 +86,9 @@ int read_trace(void *ptr, size_t bytes)
     size_t res;
 
 #ifdef HAVE_ZLIB
-    if (apprentice_fd == STDIN_FILENO) {
+    if (comm_fd == STDIN_FILENO) {
 #endif
-        res = read(apprentice_fd, ptr, bytes);
+        res = read(comm_fd, ptr, bytes);
 #ifdef HAVE_ZLIB
     } else {
         res = gzread(gz_trace_file, ptr, bytes);
@@ -218,11 +218,11 @@ int master(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
-        if (trace && master_fd != STDOUT_FILENO) {
+        if (trace && comm_fd != STDOUT_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
-        close(master_fd);
+        close(comm_fd);
         if (trace) {
             fprintf(stderr, "trace complete after %zd checkpoints\n",
                     signal_count);
@@ -244,11 +244,11 @@ int apprentice(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
 #ifdef HAVE_ZLIB
-        if (trace && apprentice_fd != STDIN_FILENO) {
+        if (trace && comm_fd != STDIN_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
-        close(apprentice_fd);
+        close(comm_fd);
         fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
         return report_match_status(true);
     }
@@ -375,31 +375,31 @@ int main(int argc, char **argv)
     if (ismaster) {
         if (trace) {
             if (strcmp(trace_fn, "-") == 0) {
-                master_fd = STDOUT_FILENO;
+                comm_fd = STDOUT_FILENO;
             } else {
-                master_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
+                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
 #ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(master_fd, "wb9");
+                gz_trace_file = gzdopen(comm_fd, "wb9");
 #endif
             }
         } else {
             fprintf(stderr, "master port %d\n", port);
-            master_fd = master_connect(port);
+            comm_fd = master_connect(port);
         }
         return master();
     } else {
         if (trace) {
             if (strcmp(trace_fn, "-") == 0) {
-                apprentice_fd = STDIN_FILENO;
+                comm_fd = STDIN_FILENO;
             } else {
-                apprentice_fd = open(trace_fn, O_RDONLY);
+                comm_fd = open(trace_fn, O_RDONLY);
 #ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(apprentice_fd, "rb");
+                gz_trace_file = gzdopen(comm_fd, "rb");
 #endif
             }
         } else {
             fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-            apprentice_fd = apprentice_connect(hostname, port);
+            comm_fd = apprentice_connect(hostname, port);
         }
         return apprentice();
     }
-- 
2.20.1


