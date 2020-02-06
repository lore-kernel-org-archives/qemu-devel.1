Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B0C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D5A217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D5A217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgkk-0003fa-S1
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgct-00020D-Ec
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgcs-000789-9R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgck-0006Yv-9s; Thu, 06 Feb 2020 07:51:14 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MS43X-1j7Cbb1EHT-00TXYy; Thu, 06 Feb 2020 13:50:48 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] qemu-img: Place the '-i aio' option in alphabetical order
Date: Thu,  6 Feb 2020 13:50:24 +0100
Message-Id: <20200206125027.1926263-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q5OgFELXy/F3+zstPUpHYoG35Pm5W5bnOHshrxWXGZ4a2RaL3pC
 NPW7PkhCN8+/WkTOaXrMprme3CT2UsKRhPdf/WuINSmVq9DBvPHalTefsE1uVfJ4ByiN4fI
 r4FAMtCKYhFM7AE1jyiVs+4TKcpaRS3oM1daT2Z2kS7fBVyw+3/ZF1ZHV31+DnuL8wb/PO8
 /XdlYmcKygbPlS3si7Pvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3aSZZVnYeE=:YBruHn1BiN+LGwbdJjWmCn
 4yKQka6fPnW1B9nIIYUdxfIH1JWilidqGsbDInT9rcGF7gqMX8bkpZXbYWGDBs8RngvPq6IqK
 E0yJFb+UKBWtZg3Y7CVOoYXGjq0P5/1w/NwMrTpwDy6xQL3lOEv+DXQNsgC2lPvGY/+NXWNfI
 2Vrxdkq0l0ySp52HYu8RtJku04th7rk2cJwC84dHWAQOrqqWkVggRUccHoPqGwMc5GjjLtfDe
 QvC21FkTGEAUdqyHdy1TlVrM3C6wm0HjxkSwwqRIlMcDxJJZ+5yAiyKYxbIATTlyyqXXMM+82
 rA6zcDAHQ2FZP50MzhGisq59uhbYqBKQP/bDoTXSjVR0DONeqWZXEWWFbF8pRdH2NlJ2bYv2P
 HIEtGPRwpVZQrMcchdY6g55/bjzfejyXWDh91KGb0yw3PZF1nUSvuXaZ8twhcvXo7xmgUIan3
 cGK/h1vAhoNSYCOvQBylA4FeH5WJintnjdb6ZZHDWb1qyPnpx2msg9gTqrMsUiwO8xpnd/tc6
 O4w0VEMy/kszb0qdPls2IFc//UizX4ryzMSnC3DSyhF4EFFVPWCxZDGqi6s7/H2JSiI3A6crU
 KmKlWsT+byuSwqBCwEWgNobR97LqUXtqAL0c1cEaBIa6OJYuXrpGuBQej1RcISd9yk2Ox01O0
 ec/eAfpo2oxHVBv4B9/RQQ4S9kz6HEkYzHJwOnf48Bd7i1XQoELV5vP51p9+VkXReYFDLLQQC
 syLLXo9Ic37uSExoxAYZaeYBAjjSClwwqRpqPKB37zweTrDM+vQeDudJ8zOjUi+8Ahy0Kc9IW
 WkNT477Dyul2y3e3cM4Neaq7/FsV0fRk7ofx7n+Wo5Zq7ZABg6z2GgOESyzdPR/Ns8OuXKB
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

The '-i AIO' option was accidentally placed after '-n' and '-t'. Move it
after '--flush-interval'.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200205163008.204493-1-jusual@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/interop/qemu-img.rst | 8 ++++----
 qemu-img-cmds.hx          | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index fa27e5c7b453..42e4451db4a2 100644
--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -247,7 +247,7 @@ Command description:
   Amends the image format specific *OPTIONS* for the image file
   *FILENAME*. Not all file formats support this operation.
 
-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-n] [-i AIO] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 
   Run a simple sequential I/O benchmark on the specified image. If ``-w`` is
   specified, a write test is performed, otherwise a read test is performed.
@@ -264,13 +264,13 @@ Command description:
   ``--no-drain`` is specified, a flush is issued without draining the request
   queue first.
 
+  if ``-i`` is specified, *AIO* option can be used to specify different
+  AIO backends: ``threads``, ``native`` or ``io_uring``.
+
   If ``-n`` is specified, the native AIO backend is used if possible. On
   Linux, this option only works if ``-t none`` or ``-t directsync`` is
   specified as well.
 
-  if ``-i`` is specified, *AIO* option can be used to specify different
-  AIO backends: ``threads``, ``native`` or ``io_uring``.
-
   For write tests, by default a buffer filled with zeros is written. This can be
   overridden with a pattern byte specified by *PATTERN*.
 
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3fd836ca9090..d7fbc6b1f483 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -16,9 +16,9 @@ SRST
 ERST
 
 DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
+    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-i aio] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 SRST
-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-i AIO] [-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 ERST
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
-- 
2.24.1


