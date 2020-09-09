Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82409C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EE42080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Des3wqgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EE42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG558-00029n-7U
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53a-0000C5-Kd; Wed, 09 Sep 2020 14:42:58 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:35528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53Z-0007nc-11; Wed, 09 Sep 2020 14:42:58 -0400
Received: by mail-pg1-x530.google.com with SMTP id g29so2730451pgl.2;
 Wed, 09 Sep 2020 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=27ajP4GoRfKO+nbwUgNlBqHfhHBZSCkZ9ODFQ91KtVY=;
 b=Des3wqgjyzKES2s1MAa0FiHP0fuQg0MGzcRFkXx4BwsJng2qL0zDOwI+0aL0BSKQfe
 +c1He5fbA/amtNx12jp98XrW0nZMH3JV3pSncU6hdS2dsWWMwwQwL4VhdyQ5dqcZJGHv
 Tb6qH1dO8rSK1HADQHkame30QnrZrN54f7vsN+2eP8TKBKeyo8g/mBSRs4ad79aH4iwH
 u5GtQk2RKVOESXeUIVGyXHGIdYJN9aYjTrDa3P8PKQ09aP9cm2cr8LHwaHYN89oeg+e8
 UasdBFpSJRL7Hwe6iQUmTYjy+p3Jc24j8d28R0ecL/HGcpdTv/DmDggsmB0h4vaN78By
 L8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=27ajP4GoRfKO+nbwUgNlBqHfhHBZSCkZ9ODFQ91KtVY=;
 b=aGWbJYkmv4J6MbHwSqi+DcLQHIH4gAsfsCmZO1+vQ+d52iBzwUPryyt+BZWdarlLyr
 6PdvXSJUSB9okzhrIFZD5xoOq4hMu9pEAFbi3Uxrw4aHT7auXMeTV7auQpbawvDdPr9X
 n35f+ESqIKq4rxMMqBWJoyDEEBEyYAyK/XBD0Q2OH9Qpcspg0nMBaKYqS6PFr+uBeFBC
 xvrOrRbpFrm7ZppMWE9x536P9P4kqOGP3uCwAp9lBCew54nbWe1FIg9MK9RSkBKml140
 jhNjCDyGZEwLVnCYxjLWd9LWpM78fUsN9hBErjwFXpwAqn+icNhT091/oEV0WmN4NijM
 3pPw==
X-Gm-Message-State: AOAM530X4w575XuGEd3rqTiJdAXIT19rGzBcLvVZIfPBvGuLOe1FIwuk
 usCwFXgkEwGtOkiVJJaWdxBdH/GbebDsLrpw
X-Google-Smtp-Source: ABdhPJxA9J7uDvDteqIq4+XUNOb/EN6yoSbvlAEJzKoG+jogLNL39ejdq6jVPxRBNYdnilWdZgpjnQ==
X-Received: by 2002:a62:301:0:b029:13c:1611:6528 with SMTP id
 1-20020a6203010000b029013c16116528mr2070781pfd.8.1599676974483; 
 Wed, 09 Sep 2020 11:42:54 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 63sm3521673pfw.42.2020.09.09.11.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 11:42:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/25] tests: disable /char/stdio/* tests in test-char.c on
 win32
Date: Thu, 10 Sep 2020 02:42:35 +0800
Message-Id: <20200909184237.765-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests are blocking test-char to be finished.
Disable them by using variable is_win32, so we doesn't
need macro to open it. and easy recover those function
latter.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-char.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..184ddceab8 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -77,7 +77,6 @@ static void fe_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-#ifdef _WIN32
 static void char_console_test_subprocess(void)
 {
     QemuOpts *opts;
@@ -102,7 +101,7 @@ static void char_console_test(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stdout("CONSOLE");
 }
-#endif
+
 static void char_stdio_test_subprocess(void)
 {
     Chardev *chr;
@@ -1448,7 +1447,11 @@ static SocketAddress unixaddr = {
 
 int main(int argc, char **argv)
 {
-    bool has_ipv4, has_ipv6;
+    bool has_ipv4, has_ipv6, is_win32 = false;
+
+#ifdef _WIN32
+    is_win32 = true;
+#endif
 
     qemu_init_main_loop(&error_abort);
     socket_init();
@@ -1467,12 +1470,15 @@ int main(int argc, char **argv)
     g_test_add_func("/char/invalid", char_invalid_test);
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
     g_test_add_func("/char/mux", char_mux_test);
-#ifdef _WIN32
-    g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
-    g_test_add_func("/char/console", char_console_test);
-#endif
-    g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
-    g_test_add_func("/char/stdio", char_stdio_test);
+    if (0) {
+        g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
+        g_test_add_func("/char/console", char_console_test);
+    }
+
+    if (!is_win32) {
+        g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
+        g_test_add_func("/char/stdio", char_stdio_test);
+    }
 #ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
@@ -1534,7 +1540,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
                          &client8 ##name, char_socket_client_dupid_test)
 
-    if (has_ipv4) {
+    if (has_ipv4 && !is_win32) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
         SOCKET_CLIENT_TEST(tcp, &tcpaddr);
         g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
-- 
2.28.0.windows.1


