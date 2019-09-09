Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB759C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61952086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR/kzt4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61952086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KoZ-0004W3-QL
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i7Kne-0003iF-Bm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i7Knd-0003SB-B6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:37:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i7Knd-0003PQ-4U
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:37:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id l16so14083563wrv.12
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VxW2+zpDCMXYGl8nghL7Q9Cmw4sNkEZu5LDJSLRVWZA=;
 b=GR/kzt4YmsIG86zFvTZxZJKKJ7J9BMpxBzGC+OhRd72wwEz4Wbh6hbQdXbpROIWaHr
 dkz2uiwgPF3SE6G/tIKsTmJzsiWJRbwwP2OQJRPlZrnAJhqFTOxDNlK8fSuH6LeqXgLy
 hZPLkhPjCL7vjBab/mrHdmHxN1zJ/qP53VuB8Mg6cm+2Fa1vTNb4yIo9CXy71DOtDCe/
 1Chjx+gCeuXa7ioBt890ctlV23DlTKDrj8Ihi0ttEP6zzhxZhH6bLdH1U60b8CQzhLy1
 zqnlnsYmaQ5Sbupk8GoL2W3D2zx2WoTlteTuGKqlJreENou3rQQzgmanO3ClhKDsaE1t
 r3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VxW2+zpDCMXYGl8nghL7Q9Cmw4sNkEZu5LDJSLRVWZA=;
 b=KBWa2jQ0OqZMtv2piOFtj9kKrsMJVwAjvNXzfBCmt6iSbcYS6LOWvJndHubdj69VYl
 NbwsjrBWo/tAFnzsApuIDBX9lPeABQfa9+4hv2PPs7LyRoFVzcb/dW4iBoSIJeb8njw+
 4/QN+BjnOl6bvSd8fjT0n9C2QtXXqYfMObTPC0En2RFiu7n8cuufhPttwyxlqu+KIJqY
 K8wdeIf2Lm+ghnS03oQoFWfftWHbu2F/eJKgfxDApr1vrV5k0oBU/SpZGtjBw0OeApa+
 rp+5zN2j3EjWZJCom0GGge1MztdbtZ/UqJaef74U3NGyzbduQugMW3iqvttqNnk93HZD
 YXDw==
X-Gm-Message-State: APjAAAXOBjh8zk7CCCo8ZI1G7fgWSvZWwyrwP8wBfZkvgtJoSH1ln2er
 CQjue4ZyVawTWZDxni6ixyCVW8CZVGM=
X-Google-Smtp-Source: APXvYqxW5gnxZRT4M+DW5FohmvkgrsQDC8Z8eWUsCqoNOwqumvICWUYEUUMm/pfDRO4uApG8qg2DXw==
X-Received: by 2002:a05:6000:108e:: with SMTP id
 y14mr18886065wrw.344.1568039866718; 
 Mon, 09 Sep 2019 07:37:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id d28sm16366179wrb.95.2019.09.09.07.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 07:37:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 16:37:32 +0200
Message-Id: <20190909143732.11322-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2] test-char: fix AddressSanitizer failure
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CharSocketServerTestConfig and CharSocketClientTestConfig
objects escape after they are passed to g_test_add_data_func,
but they cease existing after the scope that defines them is
closed.  Make them static to fix this issue.

Fixes: e7b6ba4186f243f149b0d8cddc129fe681ba3912
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index f3ebdffd87..d62de1b088 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1355,6 +1355,18 @@ static void char_hotswap_test(void)
     g_free(chr_args);
 }
 
+static SocketAddress tcpaddr = {
+    .type = SOCKET_ADDRESS_TYPE_INET,
+    .u.inet.host = (char *)"127.0.0.1",
+    .u.inet.port = (char *)"0",
+};
+#ifndef WIN32
+static SocketAddress unixaddr = {
+    .type = SOCKET_ADDRESS_TYPE_UNIX,
+    .u.q_unix.path = (char *)"test-char.sock",
+};
+#endif
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -1390,26 +1402,14 @@ int main(int argc, char **argv)
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
 
-    SocketAddress tcpaddr = {
-        .type = SOCKET_ADDRESS_TYPE_INET,
-        .u.inet.host = (char *)"127.0.0.1",
-        .u.inet.port = (char *)"0",
-    };
-#ifndef WIN32
-    SocketAddress unixaddr = {
-        .type = SOCKET_ADDRESS_TYPE_UNIX,
-        .u.q_unix.path = (char *)"test-char.sock",
-    };
-#endif
-
 #define SOCKET_SERVER_TEST(name, addr)                                  \
-    CharSocketServerTestConfig server1 ## name =                        \
+    static CharSocketServerTestConfig server1 ## name =                 \
         { addr, false, false };                                         \
-    CharSocketServerTestConfig server2 ## name =                        \
+    static CharSocketServerTestConfig server2 ## name =                 \
         { addr, true, false };                                          \
-    CharSocketServerTestConfig server3 ## name =                        \
+    static CharSocketServerTestConfig server3 ## name =                 \
         { addr, false, true };                                          \
-    CharSocketServerTestConfig server4 ## name =                        \
+    static CharSocketServerTestConfig server4 ## name =                 \
         { addr, true, true };                                           \
     g_test_add_data_func("/char/socket/server/mainloop/" # name,        \
                          &server1 ##name, char_socket_server_test);     \
@@ -1421,17 +1421,17 @@ int main(int argc, char **argv)
                          &server4 ##name, char_socket_server_test)
 
 #define SOCKET_CLIENT_TEST(name, addr)                                  \
-    CharSocketClientTestConfig client1 ## name =                        \
+    static CharSocketClientTestConfig client1 ## name =                 \
         { addr, NULL, false, false };                                   \
-    CharSocketClientTestConfig client2 ## name =                        \
+    static CharSocketClientTestConfig client2 ## name =                 \
         { addr, NULL, true, false };                                    \
-    CharSocketClientTestConfig client3 ## name =                        \
+    static CharSocketClientTestConfig client3 ## name =                 \
         { addr, ",reconnect=1", false };                                \
-    CharSocketClientTestConfig client4 ## name =                        \
+    static CharSocketClientTestConfig client4 ## name =                 \
         { addr, ",reconnect=1", true };                                 \
-    CharSocketClientTestConfig client5 ## name =                        \
+    static CharSocketClientTestConfig client5 ## name =                 \
         { addr, NULL, false, true };                                    \
-    CharSocketClientTestConfig client6 ## name =                        \
+    static CharSocketClientTestConfig client6 ## name =                 \
         { addr, NULL, true, true };                                     \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
-- 
2.21.0


