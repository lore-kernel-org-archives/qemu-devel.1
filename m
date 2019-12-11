Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D4A20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhikW6K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D4A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if33y-0006fT-IS
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2ty-0005Qc-0w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tw-0003Gu-OR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:41 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2tw-0003Fy-Hk; Wed, 11 Dec 2019 09:23:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so24268422wru.3;
 Wed, 11 Dec 2019 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ovY/8mchaDtROHxcc8/8N5K4E3la5in6G3plOwjOIug=;
 b=rhikW6K/gbZ9isrqgty7qmQwUnbyVnmYTKz5HypEJhZK0/qTafXLXtIFuXdLvgfLtp
 RPV+FDadKho0M/WHWOitlUADP+hhRJtYNywS2S/t162KCf13MDA1JiOGzc91glbobHBv
 iXX1tInbK9TtrGRVyGkIWfrRAXC2JrrS8JOqNPaDEOl+HGjl45BLp1jjLCJmza/KvF1P
 g+fucdjqv4/DladghQF4xIl78WeUYTiGd+GDlvkV7i9H+b7FZHK+WdgjSnZygbdxKfey
 EyY8h1VPT4onzQDQPpqCIewrCQJQaKGff5qR0Fkaf1NZny4+KVUY+tXkgI7Z/basGfVk
 94BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ovY/8mchaDtROHxcc8/8N5K4E3la5in6G3plOwjOIug=;
 b=bQg4HOHGg7qzbpnU+Qw/spXjXkcb8mKppT4lxduBFgcYK/a9JjsldDtKCNFdr9UJzg
 JY5LtelHBlMtACyjR6GbvDSoIkpR2AvdnrCBjjkmO0of19wfKdbtyKfU9ZqxG+PxTwhM
 MI3H6ey0G7gjHGmTSRG07hcne/mH3dgLWzar3dr0ysqjdaq/8joUPuR+dUPLFyXo6tEK
 JV1gpUAExJBYkSJkBNFBWTwDtUR+rW8EFshHCzzCkfiVUJgqEXPQGhFD0ib5kTczB2lW
 lQTtIIoPsdvikufQcXJhQbojeOj2rore26tX7wWhFNY751GDsh2OHTLnDdpyDusCfqQ6
 yTaA==
X-Gm-Message-State: APjAAAV4UF4mEhMnj2VeCuFGn1kjUXdMuarqD4zmv2tWYvaX87WMvyHE
 m8zLUGGI9GnTJ1pcuoGy+7C57d0o
X-Google-Smtp-Source: APXvYqz/+foVIWHc/iUo+ZpM6GX9itFSn4I4d039NFmWwstofErAvka4YFP2raP6bLbipJrIIR9pPA==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr21438wrn.219.1576074219297;
 Wed, 11 Dec 2019 06:23:39 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: fix test-qga on macosx
Date: Wed, 11 Dec 2019 15:23:29 +0100
Message-Id: <1576074210-52834-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fix Unix socket connection & skip commands that are not implemented.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-qga.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index d2b2435..abeb9c9 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -17,17 +17,17 @@ typedef struct {
 
 static int connect_qga(char *path)
 {
-    int s, ret, len, i = 0;
+    int s, ret, i = 0;
     struct sockaddr_un remote;
 
     s = socket(AF_UNIX, SOCK_STREAM, 0);
     g_assert(s != -1);
 
+    memset(&remote, 0, sizeof(struct sockaddr_un));
     remote.sun_family = AF_UNIX;
     do {
-        strcpy(remote.sun_path, path);
-        len = strlen(remote.sun_path) + sizeof(remote.sun_family);
-        ret = connect(s, (struct sockaddr *)&remote, len);
+        strncpy(remote.sun_path, path, sizeof(remote.sun_path) - 1);
+        ret = connect(s, (struct sockaddr *)&remote, sizeof(struct sockaddr_un));
         if (ret == -1) {
             g_usleep(G_USEC_PER_SEC);
         }
@@ -305,6 +305,7 @@ static void test_qga_info(gconstpointer fix)
     qobject_unref(ret);
 }
 
+#if defined(__linux__)
 static void test_qga_get_vcpus(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -324,7 +325,9 @@ static void test_qga_get_vcpus(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
+#if defined(__linux__)
 static void test_qga_get_fsinfo(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -348,6 +351,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_get_memory_block_info(gconstpointer fix)
 {
@@ -394,6 +398,7 @@ static void test_qga_get_memory_blocks(gconstpointer fix)
     qobject_unref(ret);
 }
 
+#if defined(__linux__)
 static void test_qga_network_get_interfaces(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -412,6 +417,7 @@ static void test_qga_network_get_interfaces(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_file_ops(gconstpointer fix)
 {
@@ -682,7 +688,7 @@ static void test_qga_blacklist(gconstpointer data)
     qobject_unref(ret);
 
     /* check something work */
-    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
+    ret = qmp_fd(fix.fd, "{'execute': 'guest-info'}");
     qmp_assert_no_error(ret);
     qobject_unref(ret);
 
@@ -766,6 +772,7 @@ static void test_qga_config(gconstpointer data)
     g_key_file_free(kf);
 }
 
+#if defined(__linux__)
 static void test_qga_fsfreeze_status(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -781,6 +788,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_guest_exec(gconstpointer fix)
 {
@@ -976,12 +984,17 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
     g_test_add_data_func("/qga/ping", &fix, test_qga_ping);
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
+#if defined(__linux__)
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
     if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
         g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
     }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
+    g_test_add_data_func("/qga/fsfreeze-status", &fix,
+                         test_qga_fsfreeze_status);
+#endif
+
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
     g_test_add_data_func("/qga/get-memory-blocks", &fix,
@@ -993,8 +1006,6 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
-    g_test_add_data_func("/qga/fsfreeze-status", &fix,
-                         test_qga_fsfreeze_status);
 
     g_test_add_data_func("/qga/blacklist", NULL, test_qga_blacklist);
     g_test_add_data_func("/qga/config", NULL, test_qga_config);
-- 
1.8.3.1


