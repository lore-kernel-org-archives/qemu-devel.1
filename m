Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BEDECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F4D20818
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F4D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFRz7-0007qc-Ht
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 19:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrd-00017P-Ou
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrb-0001KP-M0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36852
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrb-0001IB-60; Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlOIB098942; Tue, 1 Oct 2019 19:47:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9utp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:26 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlPfR099017;
 Tue, 1 Oct 2019 19:47:25 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9utd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:25 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njl16006380;
 Tue, 1 Oct 2019 23:47:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04wdc.us.ibm.com with ESMTP id 2v9y57ye78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlONh47513944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB6922805A;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F4DC28058;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/97] migration/dirty-bitmaps: change bitmap enumeration
 method
Date: Tue,  1 Oct 2019 18:45:03 -0500
Message-Id: <20191001234616.7825-25-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x91NlOIB098942
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Shift from looking at every root BDS to *every* BDS. This will migrate
bitmaps that are attached to blockdev created nodes instead of just ones
attached to emulated storage devices.

Note that this will not migrate anonymous or internal-use bitmaps, as
those are defined as having no name.

This will also fix the Coverity issues Peter Maydell has been asking
about for the past several releases, as well as fixing a real bug.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Coverity =F0=9F=98=85
Reported-by: aihua liang <aliang@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190514201926.10407-1-jsnow@redhat.com
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1652490
Fixes: Coverity CID 1390625
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 592203e7cfbd1ad261178431fcf390adfe8b16df)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/block-dirty-bitmap.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index d1bb863cb6..4a896a09eb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -273,7 +273,6 @@ static int init_dirty_bitmap_migration(void)
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
-    BdrvNextIterator it;
     Error *local_err =3D NULL;
=20
     dirty_bitmap_mig_state.bulk_completed =3D false;
@@ -281,13 +280,8 @@ static int init_dirty_bitmap_migration(void)
     dirty_bitmap_mig_state.prev_bitmap =3D NULL;
     dirty_bitmap_mig_state.no_bitmaps =3D false;
=20
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        const char *drive_name =3D bdrv_get_device_or_node_name(bs);
-
-        /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
-            bs =3D backing_bs(bs);
-        }
+    for (bs =3D bdrv_next_all_states(NULL); bs; bs =3D bdrv_next_all_sta=
tes(bs)) {
+        const char *name =3D bdrv_get_device_or_node_name(bs);
=20
         for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
@@ -296,7 +290,7 @@ static int init_dirty_bitmap_migration(void)
                 continue;
             }
=20
-            if (drive_name =3D=3D NULL) {
+            if (!name || strcmp(name, "") =3D=3D 0) {
                 error_report("Found bitmap '%s' in unnamed node %p. It c=
an't "
                              "be migrated", bdrv_dirty_bitmap_name(bitma=
p), bs);
                 goto fail;
@@ -313,7 +307,7 @@ static int init_dirty_bitmap_migration(void)
=20
             dbms =3D g_new0(DirtyBitmapMigBitmapState, 1);
             dbms->bs =3D bs;
-            dbms->node_name =3D drive_name;
+            dbms->node_name =3D name;
             dbms->bitmap =3D bitmap;
             dbms->total_sectors =3D bdrv_nb_sectors(bs);
             dbms->sectors_per_chunk =3D CHUNK_SIZE * 8 *
--=20
2.17.1


