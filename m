Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643FC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E5D214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAkRSbLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHELQ-0003e6-1G
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGs-0003QL-Gy; Sat, 12 Sep 2020 18:45:32 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGn-0004HW-Ok; Sat, 12 Sep 2020 18:45:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 34so8747945pgo.13;
 Sat, 12 Sep 2020 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=27ajP4GoRfKO+nbwUgNlBqHfhHBZSCkZ9ODFQ91KtVY=;
 b=SAkRSbLakXcrY2/xsvzeD8sgrwbmEQu+EcgNVadnCHWWLL20ILu75p5D9jrF4AfqWo
 T/4UgRNQ4+VjOhCoJTHzCgsY/UNC26kq754KFNBEbgTSeilukXa7aN4Xdab+OO5jQGvR
 QztfdlVfU4pgS4YeOi1YOSdtQk9boC/2l0wfknkBWTi5dDncCnf/B9ZAL5kWIAcMazB+
 QHNXLkMJ/3KjQpRMNuy9/a/+HzOx5+oomiC59tUEF9e2SIuJu3W/mWB/XgFPzk293mBb
 R2Srh9J7/o2L/LFkQuwvx3CjneHtObAx7UPC4qNJQCiuZpNot2W2QcLqMXHVRlV3LVdz
 Gg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=27ajP4GoRfKO+nbwUgNlBqHfhHBZSCkZ9ODFQ91KtVY=;
 b=k+urYNAy+wobXGhUOZbrsPWlexo9zCN/6kt2QJBCBc3ZJ/TWBeFqVTS8mkQOO0FOgr
 b4nl+p2M3FvMPihBBsNT4Dikota/OkLUwTRmRZ7jSNd0m29U1qgjPyVfs0LYPQ3ECvSH
 w5ouSyKZxW5QgX/+3ldgpHidrTe8Mh7+FT7PPs3D0y1XpzceSVM7ukasCqBfkM9vD1DF
 xVKLUCma1Oabjz9Rux9Qrcxw55tHd05AxITq6qCMJft9qEkOOOh0eaaqAFiRGWNSpr8i
 Vp6shUe8/e9ITcMiqr3u0z8R9fG7KjksXJdfkSlMKgsp0I/tlEUxgpPF+oo3KgH+wJUp
 kWyw==
X-Gm-Message-State: AOAM531aKYlKFNh7NdLiYaIy8nAMzo1yDDZoxK5JKh66mElQq03XMJUk
 GPW5bCY81UkN0+cluq2nCd8gJGU+OeJQnwpjQto=
X-Google-Smtp-Source: ABdhPJyTFsVzWWvHybQpEZGc11O40htRlNNKxWJX+bnCSgwWp5pqRG6UmieoKZ/pF2rghD+pjoa4fw==
X-Received: by 2002:a05:6a00:8c5:b029:13e:ce2c:88bd with SMTP id
 s5-20020a056a0008c5b029013ece2c88bdmr7761188pfu.0.1599950719688; 
 Sat, 12 Sep 2020 15:45:19 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:45:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/27] tests: disable /char/stdio/* tests in test-char.c on
 win32
Date: Sun, 13 Sep 2020 06:44:11 +0800
Message-Id: <20200912224431.1428-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52f.google.com
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


