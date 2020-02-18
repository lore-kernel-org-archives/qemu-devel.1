Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA1AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD68208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvLDYmlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD68208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43m4-0003Gs-3d
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43YI-0008V4-Rn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43YH-0001nO-T0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43YH-0001n1-Q3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=buv+CkgXGh07bWj+N6uzrygKjHvNyVEuyPAQPdQFV+A=;
 b=LvLDYmltwIcWSclQOCvaTDdBKVDhDZwKxMCQGHLotAqDQF7VYx3SPOoj5ft8senQwpcO6c
 Kew/Ufs7s6oKAQufYQNekcJ1D5WMmm0M+vTynvlomkOhDU4I4M+DXLRd8bZ8QlA0EEt+Mq
 XZbPp8IFDcczv3mhC0XXe4otyKIjHHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ETP0tFnTOKSRQJJX0pRrpw-1; Tue, 18 Feb 2020 09:08:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23A918FE861;
 Tue, 18 Feb 2020 14:08:35 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE8138B549;
 Tue, 18 Feb 2020 14:08:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/36] iotests: Resolve TODOs in 041
Date: Tue, 18 Feb 2020 15:07:19 +0100
Message-Id: <20200218140722.23876-34-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ETP0tFnTOKSRQJJX0pRrpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-17-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 7b2cf5c2f8..084da6baf3 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -909,8 +909,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
         self.complete_and_wait(drive=3D"job0")
         self.assert_has_block_node("repair0", quorum_repair_img)
-        # TODO: a better test requiring some QEMU infrastructure will be a=
dded
-        #       to check that this file is really driven by quorum
+        self.vm.assert_block_path('quorum0', '/children.1', 'repair0')
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_=
img),
                         'target image does not match source after mirrorin=
g')
@@ -1031,8 +1030,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
         self.complete_and_wait('job0')
         self.assert_has_block_node("repair0", quorum_repair_img)
-        # TODO: a better test requiring some QEMU infrastructure will be a=
dded
-        #       to check that this file is really driven by quorum
+        self.vm.assert_block_path('quorum0', '/children.1', 'repair0')
=20
 # Test mirroring with a source that does not have any parents (not even a
 # BlockBackend)
--=20
2.20.1


