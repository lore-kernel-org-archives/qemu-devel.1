Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB8C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B342054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B342054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGt8-0001CP-7m
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxk-0008Mw-Ej
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxf-0000xZ-H7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxV-0000jt-1i; Tue, 18 Jun 2019 11:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C23A81F25;
 Tue, 18 Jun 2019 15:23:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC5219492;
 Tue, 18 Jun 2019 15:23:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:17 +0200
Message-Id: <20190618152318.24953-14-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 18 Jun 2019 15:23:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/14] iotests: Test failure to loosen
 restrictions
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/182     | 21 +++++++++++++++++++++
 tests/qemu-iotests/182.out |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 3a90ebfbfd..7f494eb9bb 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -152,6 +152,27 @@ success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
=20
 _cleanup_qemu
=20
+echo
+echo '=3D=3D=3D Testing failure to loosen restrictions =3D=3D=3D'
+echo
+
+_launch_qemu -drive file=3D$TEST_IMG,if=3Dnone,file.locking=3Don
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+_cleanup_test_img
+
+# When quitting qemu, it will try to drop its locks on the test image.
+# Because that file no longer exists, it will be unable to do so.
+# However, that is not fatal, so it should just move on.
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'quit'}" \
+    'return'
+
+wait=3D1 _cleanup_qemu
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index 33d41eea91..ffef23e32b 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -15,4 +15,10 @@ Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 siz=
e=3D197120 backing_file=3DTEST_D
 {"return": {}}
 {"return": {}}
 {"return": {}}
+
+=3D=3D=3D Testing failure to loosen restrictions =3D=3D=3D
+
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
--=20
2.20.1


