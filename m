Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AFFC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9B2207FF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9B2207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFo0T-00066w-Ru
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 19:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFnyo-0005D9-BK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFnyn-00060N-1D
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFnyk-0005xb-6D; Wed, 02 Oct 2019 19:24:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DF92307D92E;
 Wed,  2 Oct 2019 23:24:17 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9898760BE0;
 Wed,  2 Oct 2019 23:24:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] dirty-bitmaps: remove deprecated autoload parameter
Date: Wed,  2 Oct 2019 19:24:11 -0400
Message-Id: <20191002232411.29968-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 02 Oct 2019 23:24:17 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This parameter has been deprecated since 2.12.0 and is eligible for
removal. Remove this parameter as it is actually completely ignored;
let's not give false hope.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
V2: Change 2.12.0 -> 4.2.0 in removed section.
    Adjust phrasing to match.

 qemu-deprecated.texi | 20 +++++++++++++++-----
 qapi/block-core.json |  6 +-----
 blockdev.c           |  6 ------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 01245e0b1c..7239e0959d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -149,11 +149,6 @@ QEMU 4.1 has three options, please migrate to one of=
 these three:
=20
 @section QEMU Machine Protocol (QMP) commands
=20
-@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-
-"autoload" parameter is now ignored. All bitmaps are automatically loade=
d
-from qcow2 images.
-
 @subsection query-block result field dirty-bitmaps[i].status (since 4.0)
=20
 The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
@@ -356,3 +351,18 @@ existing CPU models.  Management software that needs=
 runnability
 guarantees must resolve the CPU model aliases using te
 ``alias-of'' field returned by the ``query-cpu-definitions'' QMP
 command.
+
+
+@node Recently removed features
+@appendix Recently removed features
+
+What follows is a record of recently removed, formerly deprecated
+features that serves as a record for users who have encountered
+trouble after a recent upgrade.
+
+@section QEMU Machine Protocol (QMP) commands
+
+@subsection block-dirty-bitmap-add "autoload" parameter (since 4.2.0)
+
+The "autoload" parameter has been ignored since 2.12.0. All bitmaps
+are automatically loaded from qcow2 images.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..e4975ece4a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1987,10 +1987,6 @@
 #              Qcow2 disks support persistent bitmaps. Default is false =
for
 #              block-dirty-bitmap-add. (Since: 2.10)
 #
-# @autoload: ignored and deprecated since 2.12.
-#            Currently, all dirty tracking bitmaps are loaded from Qcow2=
 on
-#            open.
-#
 # @disabled: the bitmap is created in the disabled state, which means th=
at
 #            it will not track drive changes. The bitmap may be enabled =
with
 #            block-dirty-bitmap-enable. Default is false. (Since: 4.0)
@@ -1999,7 +1995,7 @@
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bo=
ol' } }
+            '*persistent': 'bool', '*disabled': 'bool' } }
=20
 ##
 # @BlockDirtyBitmapMergeSource:
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..93804da840 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1966,7 +1966,6 @@ static void block_dirty_bitmap_add_prepare(BlkActio=
nState *common,
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granular=
ity,
                                action->has_persistent, action->persisten=
t,
-                               action->has_autoload, action->autoload,
                                action->has_disabled, action->disabled,
                                &local_err);
=20
@@ -2858,7 +2857,6 @@ out:
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granulari=
ty,
                                 bool has_persistent, bool persistent,
-                                bool has_autoload, bool autoload,
                                 bool has_disabled, bool disabled,
                                 Error **errp)
 {
@@ -2890,10 +2888,6 @@ void qmp_block_dirty_bitmap_add(const char *node, =
const char *name,
         persistent =3D false;
     }
=20
-    if (has_autoload) {
-        warn_report("Autoload option is deprecated and its value is igno=
red");
-    }
-
     if (!has_disabled) {
         disabled =3D false;
     }
--=20
2.21.0


