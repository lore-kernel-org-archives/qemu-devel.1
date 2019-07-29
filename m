Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5662070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utq7f8ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5662070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7ei-00049N-6v
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Qn-0000mq-7V
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Ql-0002Zq-Cz
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7Ql-0002X9-54; Mon, 29 Jul 2019 11:19:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id b13so28204636pfo.1;
 Mon, 29 Jul 2019 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fhT6p03C5v3J9yDVaVfplDSCrT3h2ddpuxbvCBZkjsk=;
 b=utq7f8mamy4ZSq2uBLbat1UM0eyxbZ5ft05JIMnz7csDyzPMx/9qCXMd9WjIQKZ6wC
 YtWbfbBhjpf2/Oc4mKqD5PJZeDzJlxvcR8BeSxc9uZ2zojQa8V/YYreJeIXHbh0mHvw2
 DxnzPtcfft2uMYkP+DGb1yo+QaN3IbETMw+/JOGtklvp8EyrXxhJfD5kKVg765Hx8LYZ
 FGb7d8uzNI5eyQnBSk7xRxqVkR4q/VPKT4sBwK9MMKunwbEtGa6g+e+08nfpRfSHWOnF
 bJXvgw1EChtfTXKHCv1JovOsBGmsQpiroaBnncJB7r3NQ9U9ZNH2XcEjYT7e9wwmL48z
 jlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fhT6p03C5v3J9yDVaVfplDSCrT3h2ddpuxbvCBZkjsk=;
 b=c8Oz3H4G7a6hn6yQNxDg2OMObapzuByEVcVkxuLkrC2gnbf18YifAt/HtM5QRsmgF8
 cCzjqbYHTR7lUwShW09yJe73bmIHbfuQZXlq2WyG5cm68QGaxpQHNfgHuiIZgL+JJRDW
 zYc4GO6QTX7pE9XdUIiZqRQjzK4WYVSEhv+TMm6jR77IOVwtBatl0Tq+UbtIkaP5B+lB
 0of4emXC/s7Sc7YKg7/kPFdEaOUdJdPwZiabOefYIlxMGazuIPdJC+KH9snc7YLTr5iO
 h668Amf6A5rmciAECwCppUfKQQe9+DnRMrNdsJSOWmRc5zIyWQuXenv7xrzLjfJ1DNX9
 ufrQ==
X-Gm-Message-State: APjAAAUGR/npn5IFjaTF6187qKJ8n3UqzksopRtzx3NuX/fxCTLxpmQw
 Bbdeu5fdleMJnL4DawM3z7MAU7aXTKgrFg==
X-Google-Smtp-Source: APXvYqwdvhrTuIM6cHwUrb/hz4nARwe8pn+mXqqQ0kPxiQO50c89JlJ8sdaeTjxjAC3mmnV9XLj/ZQ==
X-Received: by 2002:a62:1597:: with SMTP id 145mr35903183pfv.180.1564413557659; 
 Mon, 29 Jul 2019 08:19:17 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.19.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:19:17 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:51 +0530
Message-Id: <20190729151651.21306-16-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 15/15] tests/qemu-iotests: use AIOMODE with
 various tests
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 tests/qemu-iotests/028 |  3 ++-
 tests/qemu-iotests/058 |  2 +-
 tests/qemu-iotests/089 |  4 ++--
 tests/qemu-iotests/091 |  7 ++++---
 tests/qemu-iotests/109 |  3 ++-
 tests/qemu-iotests/147 |  5 +++--
 tests/qemu-iotests/181 | 10 +++++-----
 tests/qemu-iotests/183 |  7 ++++---
 tests/qemu-iotests/185 | 17 ++++++++++++-----
 tests/qemu-iotests/200 |  3 ++-
 tests/qemu-iotests/201 | 10 +++++-----
 11 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 01f495912f..59e7b670ed 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -108,7 +108,8 @@ echo block-backup
 echo
 
 qemu_comm_method="monitor"
-_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk
+_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=${AIOMODE},\
+id=disk
 h=$QEMU_HANDLE
 QEMU_COMM_TIMEOUT=1
 
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 8c3212a72f..38d1ed90c0 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -64,7 +64,7 @@ nbd_snapshot_img="nbd:unix:$nbd_unix_socket"
 converted_image=$TEST_IMG.converted
 
 # Use -f raw instead of -f $IMGFMT for the NBD connection
-QEMU_IO_NBD="$QEMU_IO -f raw --cache=$CACHEMODE"
+QEMU_IO_NBD="$QEMU_IO -f raw --cache=$CACHEMODE --aio=$AIOMODE"
 
 echo
 echo "== preparing image =="
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index ad029f1f09..059ad75e28 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -64,7 +64,7 @@ $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512' \
 
 $QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
 
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
          -c 'read -P 66 1024 512' "json:{
     \"driver\": \"$IMGFMT\",
@@ -111,7 +111,7 @@ $QEMU_IO -c 'write -P 42 0x38000 512' "$TEST_IMG" | _filter_qemu_io
 
 # The "image.filename" part tests whether "a": { "b": "c" } and "a.b": "c" do
 # the same (which they should).
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE  \
      -c 'read -P 42 0x38000 512' "json:{
     \"driver\": \"$IMGFMT\",
     \"file\": {
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index d62ef18a02..78741d3fe7 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -60,14 +60,15 @@ echo === Starting QEMU VM1 ===
 echo
 
 qemu_comm_method="monitor"
-_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk
+_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=${AIOMODE},\
+             id=disk
 h1=$QEMU_HANDLE
 
 echo
 echo === Starting QEMU VM2 ===
 echo
-_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk \
-             -incoming "exec: cat '${MIG_FIFO}'"
+_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=${AIOMODE},\
+             id=disk -incoming "exec: cat '${MIG_FIFO}'"
 h2=$QEMU_HANDLE
 
 echo
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 9897ceb6cd..451709689a 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -52,7 +52,8 @@ run_qemu()
     local qmp_format="$3"
     local qmp_event="$4"
 
-    _launch_qemu -drive file="${source_img}",format=raw,cache=${CACHEMODE},id=src
+    _launch_qemu -drive file="${source_img}",format=raw,cache=${CACHEMODE},\
+                 aio=${AIOMODE},id=src
     _send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "return"
 
     _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 2d84fddb01..632973b23c 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -24,7 +24,7 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_early_pipe
+from iotests import cachemode, aiomode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_early_pipe
 
 NBD_PORT_START      = 32768
 NBD_PORT_END        = NBD_PORT_START + 1024
@@ -134,7 +134,8 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.server.add_drive_raw('if=none,id=nbd-export,' +
                                   'file=%s,' % test_img +
                                   'format=%s,' % imgfmt +
-                                  'cache=%s' % cachemode)
+                                  'cache=%s' % cachemode +
+                                  'aio=%s' % aiomode)
         self.server.launch()
 
     def tearDown(self):
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e317e63422..547c1b47b0 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -58,21 +58,21 @@ qemu_comm_method="monitor"
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk
 fi
 src=$QEMU_HANDLE
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
-        -incoming "unix:${MIG_SOCKET}"
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,\
+        id=disk -incoming "unix:${MIG_SOCKET}"
 fi
 dest=$QEMU_HANDLE
 
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index fbe5a99beb..b16db9466d 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -56,13 +56,14 @@ echo
 qemu_comm_method="qmp"
 
 _launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,\
+    driver=$IMGFMT,id=disk
 src=$QEMU_HANDLE
 _send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
 
 _launch_qemu \
-    -drive file="${TEST_IMG}.dest",cache=$CACHEMODE,driver=$IMGFMT,id=disk \
-    -incoming "unix:${MIG_SOCKET}"
+    -drive file="${TEST_IMG}.dest",cache=$CACHEMODE,aio=$AIOMODE,\
+    driver=$IMGFMT,id=disk -incoming "unix:${MIG_SOCKET}"
 dest=$QEMU_HANDLE
 _send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
 
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 454ff600cc..1c74a0ef5a 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -54,7 +54,8 @@ echo
 qemu_comm_method="qmp"
 
 _launch_qemu \
-    -drive file="${TEST_IMG}.base",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    -drive file="${TEST_IMG}.base",cache=$CACHEMODE,aio=$AIOMODE,\
+    driver=$IMGFMT,id=disk
 h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 
@@ -125,7 +126,8 @@ echo === Start active commit job and exit qemu ===
 echo
 
 _launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,\
+    id=disk
 h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 
@@ -147,7 +149,8 @@ echo === Start mirror job and exit qemu ===
 echo
 
 _launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,\
+    id=disk
 h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 
@@ -172,7 +175,9 @@ echo === Start backup job and exit qemu ===
 echo
 
 _launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    _launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,\
+    id=disk
 h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 
@@ -196,7 +201,9 @@ echo === Start streaming job and exit qemu ===
 echo
 
 _launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+    _launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,\
+    id=disk
 h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 72d431f251..b554dd947b 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -66,7 +66,8 @@ echo === Starting QEMU VM ===
 echo
 qemu_comm_method="qmp"
 _launch_qemu -object iothread,id=iothread0 $virtio_scsi \
-             -drive file="${TEST_IMG}",media=disk,if=none,cache=$CACHEMODE,id=drive_sysdisk,format=$IMGFMT \
+             -drive file="${TEST_IMG}",media=disk,if=none,cache=$CACHEMODE,\
+             aio=$AIOMODE,id=drive_sysdisk,format=$IMGFMT \
              -device scsi-hd,drive=drive_sysdisk,bus=scsi0.0,id=sysdisk,bootindex=0
 h1=$QEMU_HANDLE
 
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index 7abf740fe4..48837c4f30 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -58,21 +58,21 @@ qemu_comm_method="monitor"
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk
 fi
 src=$QEMU_HANDLE
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
-        -incoming "unix:${MIG_SOCKET}"
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,\
+        id=disk -incoming "unix:${MIG_SOCKET}"
 fi
 dest=$QEMU_HANDLE
 
-- 
2.21.0


