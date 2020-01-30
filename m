Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D41C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EE720708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfEOQI9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EE720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHr3-0005hL-6J
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcr-0005SL-AA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcq-0005PY-5b
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcq-0005NE-0C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8wxhgncUAiINMH8Y8QNRrciJqGSz80fNdmk186zzKA=;
 b=BfEOQI9kdCH2jlA5dewiKwMEDGprSIEj6Es5WY2upFoRaP8n+7DjE8Oeew48hZsqvKHtds
 /VD1PQnRuqmeRBdDTsPVp/eO510NW3MBBOpJdXrJvm/wf7mNRaLZ5MUWoWwDbnjj4Fgzjq
 rP/us9n0K/5mbcXqUXyd0Z18Y0k4Kts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-BAM3yxtHPeyKvU4-mO3_KQ-1; Thu, 30 Jan 2020 16:45:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181B118C35CC;
 Thu, 30 Jan 2020 21:45:18 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67315C1B2;
 Thu, 30 Jan 2020 21:45:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 18/21] iotests: Resolve TODOs in 041
Date: Thu, 30 Jan 2020 22:44:28 +0100
Message-Id: <20200130214431.333510-19-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BAM3yxtHPeyKvU4-mO3_KQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 20cfad1d2c..41db2c222a 100755
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
2.24.1


