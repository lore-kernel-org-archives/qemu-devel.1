Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D41ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AD121835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AD121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6kF-0000yh-G0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL5tS-0002gq-OF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL5tR-0003Zv-A3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL5tF-0003Tk-RJ; Thu, 17 Oct 2019 09:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 157FD8980F2;
 Thu, 17 Oct 2019 13:32:29 +0000 (UTC)
Received: from localhost (ovpn-117-3.ams2.redhat.com [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD26A5D9D5;
 Thu, 17 Oct 2019 13:32:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 11/23] iotests/182: Create socket in $SOCK_DIR
Date: Thu, 17 Oct 2019 15:31:43 +0200
Message-Id: <20191017133155.5327-12-mreitz@redhat.com>
In-Reply-To: <20191017133155.5327-1-mreitz@redhat.com>
References: <20191017133155.5327-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 17 Oct 2019 13:32:29 +0000 (UTC)
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/182 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 7f494eb9bb..1ccb850055 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -31,7 +31,7 @@ _cleanup()
 {
     _cleanup_test_img
     rm -f "$TEST_IMG.overlay"
-    rm -f "$TEST_DIR/nbd.socket"
+    rm -f "$SOCK_DIR/nbd.socket"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -133,7 +133,7 @@ success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
           'addr': {
               'type': 'unix',
               'data': {
-                  'path': '$TEST_DIR/nbd.socket'
+                  'path': '$SOCK_DIR/nbd.socket'
               } } } }" \
     'return' \
     'error'
--=20
2.21.0


