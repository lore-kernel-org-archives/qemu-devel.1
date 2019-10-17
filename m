Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA3FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A159E2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A159E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6OB-0006I9-Tf
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL5t3-0002Ko-7i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL5t1-0003Ko-UN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL5sz-0003Iz-Bq; Thu, 17 Oct 2019 09:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9493D85540;
 Thu, 17 Oct 2019 13:32:12 +0000 (UTC)
Received: from localhost (ovpn-117-3.ams2.redhat.com [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31BF95D9D5;
 Thu, 17 Oct 2019 13:32:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/23] iotests: Let common.nbd create socket in $SOCK_DIR
Date: Thu, 17 Oct 2019 15:31:37 +0200
Message-Id: <20191017133155.5327-6-mreitz@redhat.com>
In-Reply-To: <20191017133155.5327-1-mreitz@redhat.com>
References: <20191017133155.5327-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 13:32:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In addition, drop the nbd_unix_socket assignment in 241 because it does
not really do anything.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/241        | 2 --
 tests/qemu-iotests/common.nbd | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 58b64ebf41..8dae8d39e4 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -23,8 +23,6 @@ echo "QA output created by $seq"
=20
 status=3D1 # failure is the default!
=20
-nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
-
 _cleanup()
 {
     _cleanup_test_img
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 24b01b60aa..a8cae8fe2c 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -19,7 +19,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
+nbd_unix_socket=3D"${SOCK_DIR}/qemu-nbd.sock"
 nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
 nbd_stderr_fifo=3D"${TEST_DIR}/qemu-nbd.fifo"
--=20
2.21.0


