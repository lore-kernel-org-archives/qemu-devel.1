Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F495C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6331206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6331206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinGk-0007TK-3b
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hinEg-0005Pq-2S
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hinEe-0003sx-8G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hinEa-0003pe-96; Wed, 03 Jul 2019 17:56:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DDA085538;
 Wed,  3 Jul 2019 21:56:10 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-117.rdu2.redhat.com [10.10.123.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5894D18249;
 Wed,  3 Jul 2019 21:56:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:55:28 -0400
Message-Id: <20190703215542.16123-5-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-1-jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 03 Jul 2019 21:56:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 04/18] qapi: add BitmapSyncMode enum
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Depending on what a user is trying to accomplish, there might be a few
bitmap cleanup actions that occur when an operation is finished that
could be useful.

I am proposing three:
- NEVER: The bitmap is never synchronized against what was copied.
- ALWAYS: The bitmap is always synchronized, even on failures.
- CONDITIONAL: The bitmap is synchronized only on success.

The existing incremental backup modes use 'conditional' semantics,
so add just that one for right now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7b23efcf13..87eba5a5d9 100644
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
+# @conditional: The bitmap is only synced when the operation is successf=
ul.
+#               This is the behavior always used for 'INCREMENTAL' backu=
ps.
+#
+# Since: 4.2
+##
+{ 'enum': 'BitmapSyncMode',
+  'data': ['conditional'] }
+
 ##
 # @MirrorCopyMode:
 #
--=20
2.21.0


