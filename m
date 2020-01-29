Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70955C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A9D2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3ML3q+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A9D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwoBF-0002ac-9D
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwoAU-0001lR-Cr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwoAR-0000Zp-K4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:18:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwoAO-0000WC-Hr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580307482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b5OvjvshUIegmZmM9OfyYXWIxt7yN+xveGdRhPLhqLA=;
 b=W3ML3q+PVRO4zTC7VggaMGNJTbH1DIdESLM2oTaDvVF7NwxzmPM/F+PI5moQ28dg/u/iRB
 78Zg+Rxilbh3ln0qtHtcLuIXsbDmE58YFVFVK93aViwoCquptq/PP2NWIgBqZU8QW0ZFmA
 6QrNTZk1Ejb9UMn17wnVwvatVLseo9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-p6HOODClNGq-hrrJohrSFQ-1; Wed, 29 Jan 2020 09:17:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2A58010E1;
 Wed, 29 Jan 2020 14:17:57 +0000 (UTC)
Received: from thuth.com (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85791393;
 Wed, 29 Jan 2020 14:17:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] iotests: Remove the superfluous 2nd check for the
 availability of quorum
Date: Wed, 29 Jan 2020 15:17:51 +0100
Message-Id: <20200129141751.32652-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: p6HOODClNGq-hrrJohrSFQ-1
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit d9df28e7b07 ("iotests: check whitelisted formats") added the
modern @iotests.skip_if_unsupported() to the functions in this test,
so we don't need the old explicit test here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/139 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cbb5a76530..2f075888ba 100755
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
2.18.1


