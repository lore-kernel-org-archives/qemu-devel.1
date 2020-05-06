Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECBC38A24
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535E9206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imxpirmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535E9206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIs0-0006Hf-Aw
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo8-0006KE-1Z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo6-0000vf-8z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id 188so2309068wmc.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XI9W7JKa2XyA3yREs7k25PgwkqTKLOYrGC7rNXuuH+4=;
 b=imxpirmX8HKyoZBurHzjZTMtIol8i8W8TSAxOQM/cqM/zvkxc+Sln0LLcHsTDC99ln
 /NIGqjJEq1VaODtquy0C2tNWyGUhZeH6zcEDTnj3d2kEkubjdtHDehoN+SiypGTvKEYZ
 H7V6N39a6hJ+aglkOEsnIbwMkbhbrAwCOXr5EJXa+rgk2pfuc2j50APbdgQckEM1KF9P
 fcMydYH5fJiPeI2N83abMF3zNxxhhWhxfOFSQ03Oevd47gjGj2sqgseBXc8UR1KsUluF
 QAMpFpBftBCSUUYrD+s2DEqOIfT71YDeVDUTsnnyYFh/Sz8lbbG94EIiJEFNkNhsAdCs
 b98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XI9W7JKa2XyA3yREs7k25PgwkqTKLOYrGC7rNXuuH+4=;
 b=Lo5K5zh344ITYDpLyGlxC2LZxlerqlQcLeC+Yg9lwMl/7qln8tu2Z/OCJfkL4XcJab
 1WLnY7NsEXAevy3FgxJoWb5fybiIrapFVDQ1pg1QCbhXncTNHF5pNYqpdsFeA0L1BVsZ
 VIXk9rL6wNi1eibyjD/h7H2Q6+NeiaxjTs9XvKcXObukuCQFr0MHoO/Pn8zgSS/Qt0RA
 QBp1wuFWgaIGVRQXJ8SIXkgnk5gyLOMtbV3cYOPzsDD4dv7wk0A6XhWNelc6hP04Hrc4
 hcXEido4Nu/phgzMy8moWe7qoENbMdRxH9YoeVpbOuw1vr/jCC6xvTLgg2zr5u8ukUgb
 BSIw==
X-Gm-Message-State: AGi0PuYv7PrByzqD0PLzNE+SS06oTeuKMNmB0wp9QsDgYBPT6HjyJKP8
 OphaYwlI8bz5GeND2Qc0p5jteA==
X-Google-Smtp-Source: APiQypLUG/6OiBZ7nOq+Uyn0EDlsPhkCqanW2lscEXsl3tQ6BYDeeboWAKFxHh0TZcNp0UWWKAqkWA==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr4299460wml.55.1588766744768;
 Wed, 06 May 2020 05:05:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n131sm2716513wmf.35.2020.05.06.05.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 945331FF99;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/14] gdbstub: eliminate gdbserver_fd global
Date: Wed,  6 May 2020 13:05:25 +0100
Message-Id: <20200506120529.18974-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't really need to track this fd beyond the initial creation of
the socket. We already know if the system has been initialised by
virtue of the gdbserver_state so lets remove it. This makes the later
re-factoring easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200430190122.4592-6-alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 171e1509509..b5381aa5204 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -398,8 +398,6 @@ static void reset_gdbserver_state(void)
 bool gdb_has_xml;
 
 #ifdef CONFIG_USER_ONLY
-/* XXX: This is not thread safe.  Do we care?  */
-static int gdbserver_fd = -1;
 
 static int get_char(void)
 {
@@ -2964,7 +2962,7 @@ void gdb_exit(CPUArchState *env, int code)
       return;
   }
 #ifdef CONFIG_USER_ONLY
-  if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+  if (gdbserver_state.fd < 0) {
       return;
   }
 #endif
@@ -3011,7 +3009,7 @@ gdb_handlesig(CPUState *cpu, int sig)
     char buf[256];
     int n;
 
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return sig;
     }
 
@@ -3060,7 +3058,7 @@ void gdb_signalled(CPUArchState *env, int sig)
 {
     char buf[4];
 
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return;
     }
 
@@ -3068,7 +3066,7 @@ void gdb_signalled(CPUArchState *env, int sig)
     put_packet(buf);
 }
 
-static bool gdb_accept(void)
+static bool gdb_accept(int gdb_fd)
 {
     struct sockaddr_in sockaddr;
     socklen_t len;
@@ -3076,7 +3074,7 @@ static bool gdb_accept(void)
 
     for(;;) {
         len = sizeof(sockaddr);
-        fd = accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
+        fd = accept(gdb_fd, (struct sockaddr *)&sockaddr, &len);
         if (fd < 0 && errno != EINTR) {
             perror("accept");
             return false;
@@ -3137,13 +3135,13 @@ static int gdbserver_open(int port)
 
 int gdbserver_start(int port)
 {
-    gdbserver_fd = gdbserver_open(port);
-    if (gdbserver_fd < 0)
+    int gdb_fd = gdbserver_open(port);
+    if (gdb_fd < 0) {
         return -1;
+    }
     /* accept connections */
-    if (!gdb_accept()) {
-        close(gdbserver_fd);
-        gdbserver_fd = -1;
+    if (!gdb_accept(gdb_fd)) {
+        close(gdb_fd);
         return -1;
     }
     return 0;
@@ -3152,7 +3150,7 @@ int gdbserver_start(int port)
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
-    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
+    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
         return;
     }
     close(gdbserver_state.fd);
-- 
2.20.1


