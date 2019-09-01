Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B3DC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 12:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055142190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055142190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4OYR-0002U6-5w
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 08:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i4OQ7-0003MC-5X
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i4OQ5-0004Qm-Gn
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:53:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:52468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i4OQ5-0004Mw-9w; Sun, 01 Sep 2019 07:53:21 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i4OQ2-0000CW-BC; Sun, 01 Sep 2019 14:53:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Sun,  1 Sep 2019 14:53:05 +0300
Message-Id: <1567338786-586124-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567338786-586124-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1567338786-586124-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 5/6] iotests: extended timeout under Valgrind
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the iotests run longer under the Valgrind, the QEMU_COMM_TIMEOUT is
to be increased in the test cases 028, 183 and 192 when running under
the Valgrind.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/028 | 6 +++++-
 tests/qemu-iotests/183 | 9 ++++++++-
 tests/qemu-iotests/192 | 6 +++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 01f4959..71301ec 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -110,7 +110,11 @@ echo
 qemu_comm_method="monitor"
 _launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk
 h=$QEMU_HANDLE
-QEMU_COMM_TIMEOUT=1
+if [ "${VALGRIND_QEMU}" == "y" ]; then
+    QEMU_COMM_TIMEOUT=7
+else
+    QEMU_COMM_TIMEOUT=1
+fi
 
 # Silence output since it contains the disk image path and QEMU's readline
 # character echoing makes it very hard to filter the output. Plus, there
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index fbe5a99..04fb344 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -94,8 +94,15 @@ if echo "$reply" | grep "compiled without old-style" > /dev/null; then
     _notrun "migrate -b support not compiled in"
 fi
 
-QEMU_COMM_TIMEOUT=0.1 qemu_cmd_repeat=50 silent=yes \
+timeout_comm=$QEMU_COMM_TIMEOUT
+if [ "${VALGRIND_QEMU}" == "y" ]; then
+    QEMU_COMM_TIMEOUT=4
+else
+    QEMU_COMM_TIMEOUT=0.1
+fi
+qemu_cmd_repeat=50 silent=yes \
     _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" '"status": "completed"'
+QEMU_COMM_TIMEOUT=$timeout_comm
 _send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
 
 echo
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 6193257..0344322 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -60,7 +60,11 @@ fi
 qemu_comm_method="monitor"
 _launch_qemu -drive $DRIVE_ARG -incoming defer
 h=$QEMU_HANDLE
-QEMU_COMM_TIMEOUT=1
+if [ "${VALGRIND_QEMU}" == "y" ]; then
+    QEMU_COMM_TIMEOUT=7
+else
+    QEMU_COMM_TIMEOUT=1
+fi
 
 _send_qemu_cmd $h "nbd_server_start unix:$TEST_DIR/nbd" "(qemu)"
 _send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
-- 
1.8.3.1


