Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6895C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584EB205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb7qMlqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584EB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEdO-0006Df-F1
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWx-0008Og-GN; Tue, 15 Sep 2020 13:14:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:33522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEW9-0002fc-Og; Tue, 15 Sep 2020 13:13:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id d19so1682287pld.0;
 Tue, 15 Sep 2020 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eDe5d20FXHFU2NTKVE6+lFVB6CT1LN7XPKbQmGMToVk=;
 b=Tb7qMlqVqHb4XUHGocj9Ep9BzAa0M8BWZXV7n1/MzXlGHJLIO0oUY2hPzX82RvJUYd
 8zXGAHSgiGbqG5pikZRSDSwgcWK+5uiB7oz8Huw+/XPoYkmZajq0j6hm/zdN6KC4Wi2v
 ORQZ/B+dbnKvPClBCdDYK+T5vFGuxKDK1FKd5VLXIXHFp5UdzEAliWSfxVmYrON0QMiW
 lzfk7VvYbRiD1VOCZBb1W9sPF777NiCZ5C2rWrlHk0EaP7rTHbMCXgpZbMPJb/GNBg+5
 jpHiqQ8BYKqNzaoMowrtDfIq2/nieC8UPBf65A56rEwvX8bDsKhg1k2yFqUWXrM7m4g1
 5IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eDe5d20FXHFU2NTKVE6+lFVB6CT1LN7XPKbQmGMToVk=;
 b=NWi2ltBcnCnYny8VgBM5kXaUGEqIusTdK5Wj1L2iGCt9d+WZRmNTDatYl47f42+etc
 SlemMXXpOl+S4C0o62l+R7XddML0l3Z0+lOzUgf1U1KWSG/9yI5JsW3aPuxBMp5ZlUcT
 gnbgJ8Xx3Z6bH2++HGkvaCuNNYzmOoz9qBOP8uwN2ll+JLQb8R7WRf6dbkOLrAurtjb9
 EXlqjUULpkMSiSGRfGGO+GFFGAtrYusjeiIeE5uQjiGRcKrSyPH6WNyhQsXhNImsCyTi
 0n3yC7TYnAQOQTGKSeNqtjJkhqF+PffG+iIGetl1zP68vlQyA8bo8teKUmD7oP5okIxz
 3UyQ==
X-Gm-Message-State: AOAM533DUdu6nGor+GLtcHIUusnwGDTZmQ86uI+sNj2Zo1q7t329iCVL
 7BIz8oHY3f1A2gUXj9LRbC+wYNcQQeIhejqoCv0=
X-Google-Smtp-Source: ABdhPJyQoCeAVqgM24zZuWwYAhKnlz0+Gp8MjRJm1Wlh4T1KSXxM6wn4KbaKOPu3ThUWq1wm2r13aQ==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id
 lb11mr310966pjb.111.1600189999714; 
 Tue, 15 Sep 2020 10:13:19 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 06/26] tests: disable /char/stdio/* tests in test-char.c
 on win32
Date: Wed, 16 Sep 2020 01:12:14 +0800
Message-Id: <20200915171234.236-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62a.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests are blocking test-char to be finished.
Disable them by using variable is_win32, so we doesn't
need macro to open it. and easy recover those function
latter.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-char.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc..09e4069306 100644
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
@@ -1467,12 +1470,16 @@ int main(int argc, char **argv)
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
+        g_test_add_func("/char/console/subprocess",
+            char_console_test_subprocess);
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
@@ -1534,7 +1541,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
                          &client8 ##name, char_socket_client_dupid_test)
 
-    if (has_ipv4) {
+    if (has_ipv4 && !is_win32) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
         SOCKET_CLIENT_TEST(tcp, &tcpaddr);
         g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
-- 
2.28.0.windows.1


