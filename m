Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA85C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409D2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUiX-0002Ww-2S
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUdf-0005Af-N7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUdb-0006nn-VF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUdY-0006jD-3v; Fri, 05 Jul 2019 16:16:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF329C049598;
 Fri,  5 Jul 2019 20:16:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEAAE86432;
 Fri,  5 Jul 2019 20:16:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:17 -0400
Message-Id: <20190705201631.26266-5-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 20:16:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 04/18] qapi: add BitmapSyncMode enum
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Depending on what a user is trying to accomplish, there might be a few
bitmap cleanup actions that occur when an operation is finished that
could be useful.

I am proposing three:
- NEVER: The bitmap is never synchronized against what was copied.
- ALWAYS: The bitmap is always synchronized, even on failures.
- ON-SUCCESS: The bitmap is synchronized only on success.

The existing incremental backup modes use 'on-success' semantics,
so add just that one for right now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0af3866015..0c853d00bd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1134,6 +1134,20 @@
 { 'enum': 'MirrorSyncMode',
   'data': ['top', 'full', 'none', 'incremental'] }
=20
+##
+# @BitmapSyncMode:
+#
+# An enumeration of possible behaviors for the synchronization of a bitm=
ap
+# when used for data copy operations.
+#
+# @on-success: The bitmap is only synced when the operation is successfu=
l.
+#              This is the behavior always used for 'INCREMENTAL' backup=
s.
+#
+# Since: 4.2
+##
+{ 'enum': 'BitmapSyncMode',
+  'data': ['on-success'] }
+
 ##
 # @MirrorCopyMode:
 #
--=20
2.21.0


