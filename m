Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC967C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C7520829
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C7520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQql-0006bc-TJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jjQoJ-00042m-Hq; Thu, 11 Jun 2020 13:16:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36384 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jjQoF-0001g1-Pt; Thu, 11 Jun 2020 13:16:15 -0400
Received: from [192.168.15.81] (helo=iris.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jjQo9-0000E7-RL; Thu, 11 Jun 2020 20:16:05 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] iotests: fix 172 test
Date: Thu, 11 Jun 2020 20:16:08 +0300
Message-Id: <20200611171608.22052-3-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611171608.22052-1-den@openvz.org>
References: <20200611171608.22052-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 13:11:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Default discard granularity is set to -2 now.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: John Snow <jsnow@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Fam Zheng <fam@euphon.net>
---
 tests/qemu-iotests/172.out | 106 ++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 7abbe82427..fb6d3efe7b 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -28,7 +28,7 @@ Testing:
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -58,7 +58,7 @@ Testing: -fda TEST_DIR/t.qcow2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -85,7 +85,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -96,7 +96,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -123,7 +123,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -134,7 +134,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -164,7 +164,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -191,7 +191,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -202,7 +202,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -229,7 +229,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -240,7 +240,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -270,7 +270,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -297,7 +297,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -324,7 +324,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -335,7 +335,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -365,7 +365,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -392,7 +392,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -419,7 +419,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -430,7 +430,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -460,7 +460,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -471,7 +471,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -498,7 +498,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -509,7 +509,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -536,7 +536,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -563,7 +563,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -593,7 +593,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -604,7 +604,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -631,7 +631,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -642,7 +642,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -669,7 +669,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -680,7 +680,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -707,7 +707,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -718,7 +718,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -754,7 +754,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -765,7 +765,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -792,7 +792,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -803,7 +803,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -836,7 +836,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -847,7 +847,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -874,7 +874,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -885,7 +885,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -912,7 +912,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -923,7 +923,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -950,7 +950,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -961,7 +961,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1003,7 +1003,7 @@ Testing: -device floppy
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1030,7 +1030,7 @@ Testing: -device floppy,drive-type=120
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1057,7 +1057,7 @@ Testing: -device floppy,drive-type=144
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1084,7 +1084,7 @@ Testing: -device floppy,drive-type=288
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1114,7 +1114,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1141,7 +1141,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1171,7 +1171,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1198,7 +1198,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 physical_block_size = 512 (0x200)
                 min_io_size = 0 (0x0)
                 opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                discard_granularity = 4294967294 (0xfffffffe)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
-- 
2.17.1


