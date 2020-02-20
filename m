Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1215FC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67ED207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grM3mPgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67ED207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oP7-00060S-1J
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oN8-0002Vk-DL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oN7-0004mo-CD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oN7-0004md-7u
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imNKplwU1VPK3E7/RFcXyoj2wsOgHzALDXKw2ZlZRZI=;
 b=grM3mPgZGvZZWaiAyBYxYffSTZoHrQXbgaHFXVNtKeC5jn2/eF3AVJ2zQvmPOTVh8T/XjQ
 xsXBnBl8Lg5280RssFQbyQAj3PxEafZwUZYWlGRW1vsTwLVxc4Y3hug68BmuqbBjYODBVP
 nMC921hQX8WILbwytw9HUSLepO3TBtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-BCgvJZ6nPMKU8r6TehKAOA-1; Thu, 20 Feb 2020 11:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C757A18B632E;
 Thu, 20 Feb 2020 16:08:12 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 336625C1B0;
 Thu, 20 Feb 2020 16:08:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/18] iotests: Remove the superfluous 2nd check for the
 availability of quorum
Date: Thu, 20 Feb 2020 17:06:55 +0100
Message-Id: <20200220160710.533297-4-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BCgvJZ6nPMKU8r6TehKAOA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Commit d9df28e7b07 ("iotests: check whitelisted formats") added the
modern @iotests.skip_if_unsupported() to the functions in this test,
so we don't need the old explicit test here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200129141751.32652-1-thuth@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/139 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 6b1a444364..7120d3142b 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -344,9 +344,6 @@ class TestBlockdevDel(iotests.QMPTestCase):
=20
     @iotests.skip_if_unsupported(['quorum'])
     def testQuorum(self):
-        if not iotests.supports_quorum():
-            return
-
         self.addQuorum('quorum0', 'node0', 'node1')
         # We cannot remove the children of a Quorum device
         self.delBlockDriverState('node0', expect_error =3D True)
--=20
2.24.1


