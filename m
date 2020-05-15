Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E32EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D5420759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T4Zwm24U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D5420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZfa-0004Pa-48
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe6-0002Db-QO; Fri, 15 May 2020 08:40:58 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe5-0008VJ-Rz; Fri, 15 May 2020 08:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYKYxOeWLyv6ll0nB6pMACAzzoBYyvmJFEOFFGD7kptvcTy7xOql/WApkjDMGOOcwph+h79wk9dGiY5l4OuwctlOi94XVbnwT3cqZpQ/EsXMEXQJpUcLaKV/qxTDspI6/5J0TD5wt9FX+3i2GSwfReYizUQqSQXA8EmUkIUJD0YFqDAwPgGZqM4SXaolCxNLDacCBvKvcl4r6qCCsTScNoDKXBDLjKN3l5MPVSfx1gMClv/CVkn/4JsaTkSJKyqZOfyX+b8zYk1Dt7H2er7Y8+cCNraipwsYSu2//AztXBS3Mzpy6fCUvMiAGWkGBi6Z49UPA/2KU72h7051Ak/rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lip4dD19i4EOeKiQ0LX1sMJZbgdXQCeU57yRCNf1Zk=;
 b=H6kcWI6DMH67Rt6cyL9No7s+QwFYhL01h/j8TTcOXeMQuJ3VMgcfB/tyRicvuotBU7G5raPetW7kNUqCBT3E+XJOks9fitll1Z5uBhNSy1NyplfV1fOPTMq+lgOsfObFJZwz67wzYDAjuuVbQ9+nldh5b9ejL2wsOXRD6plPSj9XpFWBq8LlYeaElkqP+UY+O0nUYP9c9+qWE4RuH5iFqIJyXUrcP5A9ti8cjW2a+NZsjWvQ6ubLwPbxC/4XmKWgIoDc7C/qdhOdZMOsMEYI0Kj+dIdOERRrX/4RrwVid7JmhGGiXIEzUTsojVpvGvURboLxp76emgafNpV3fuhGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lip4dD19i4EOeKiQ0LX1sMJZbgdXQCeU57yRCNf1Zk=;
 b=T4Zwm24U9wTR7X5YdLgpNUMc2N8hkpz4CeveyGJyabG5cqSzf/BgRE0b0p4Np6gCPfcSJsn4M6B+cinT90QctInNnvnJZBIdaA65MODJA7laBpctAMM1IfJn3GNLmjIIYVbBIALzEfQ8bx1xFjyySTGzvKilDREFSTnJRRlg8jA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/7] migration/block-dirty-bitmap: refactor
 init_dirty_bitmap_migration
Date: Fri, 15 May 2020 15:40:19 +0300
Message-Id: <20200515124024.3491-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f75b569d-4be8-4bfe-a463-08d7f8cd3420
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53810D9E00DA5F4B7C4BCF50C1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKfIYxvdmBhvscV+AMVf0P2T8wr711hUwmcWXc8n85Fq+kOE0Ai8O80yFPsHL7ChFrML8q/L7K4NUGcOQG+LjZjAlDWgGIsv+SeQ4fGIJlg4uq+GXB45BrydhVJrJoKMlFFGdgfT3s2fHqtZWWEJSzRhvALxe6GLn9g8UgY96KMWYOlDxi58hh/GiBZW9xM+Gp8qlqcqwLTUX8DHfX9w5PNGUyWBNvlYmj9cpfxIrH67dsO9/etqXwOA9+meGk5ztldPKXDWo8WFZDDhgbVQZf9tJLqJqugtk2TrPxqt42YNfgtjHqZ+/S3yte50eFBnXxViXmx+TOcPh7+DlnBbezlvlLflEsIpEmlLDo+nUVYCC9wk48UP4D2paPp4nNjXqhjbqcOlmyzDH/+lg/6Kjujyvf3xEd7gYpCiht9ANrVgQQ5xOJeTUM+FR2caf2Ve8p5203rHFkpswoTBOMOhOpxa1LfwtQ0AZBUq3IQxJjm4fHwDQoBsaNyV9yB//p5M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vtHkac0bidE7jkbZpqIhOSouwJZ7M9Lc1j8Sbw0Mu8IiATkhp2JV2nePCXN3ml9+kFXwm/o62jMlSonh3yXiG4Kv0GZYAm3eUQDTWcu4tvPLuvlj1sbNupjapEGrLaMT3zS9dTJmKR+92KnF4gc30QO5xuQFoFdXTqQeof/DUzcSlfZH/8lUessoe1uj0dTUFtZ1jhOGUDStjCel3xILRBkcvUq3XSRdET9DPzYv/S/Zv//vhBQQkacvVQKuyufBaL6uBqCVr1tw/jf9s2pqDC12SaKo/oLoDaewKBepkAO+gPBpkMyUM5mTQV3khL/WvC3V75Ayk9WSiaZAx40Amp/LQIX548bOLhfx/VrOWoUh7rcoCTNlE8300gmQ3MPQN6tmCSjz1+h+Ya5Z6ln1HzEEHRP50Jjo1/BfjM+cyLAXjavMExV9BBgc56pCJPmsRbtmAhd3vq21Z9CJfhv2aQRWsCPapmlRRXpPfWXyty8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b569d-4be8-4bfe-a463-08d7f8cd3420
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:52.4176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1clq4Ii7Qyw335WgmHyG/WmPVEazqq2wqNIy83EtrOYkKzl3svHDEBYCdjD44Td7jiD5E7nZ/X0grvCK/mllIDsc+EURrSAGJ1W6diC0xKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out handling one bs, it is needed for the following commit, which
will handle BlockBackends separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 89 +++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface61..7e93718086 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -268,57 +268,66 @@ static void dirty_bitmap_mig_cleanup(void)
 }
 
 /* Called with iothread lock taken. */
-static int init_dirty_bitmap_migration(void)
+static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 {
-    BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
-    dirty_bitmap_mig_state.bulk_completed = false;
-    dirty_bitmap_mig_state.prev_bs = NULL;
-    dirty_bitmap_mig_state.prev_bitmap = NULL;
-    dirty_bitmap_mig_state.no_bitmaps = false;
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (!bdrv_dirty_bitmap_name(bitmap)) {
+            continue;
+        }
 
-    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        const char *name = bdrv_get_device_or_node_name(bs);
+        if (!bs_name || strcmp(bs_name, "") == 0) {
+            error_report("Found bitmap '%s' in unnamed node %p. It can't "
+                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
+            return -1;
+        }
 
-        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
-            if (!bdrv_dirty_bitmap_name(bitmap)) {
-                continue;
-            }
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
 
-            if (!name || strcmp(name, "") == 0) {
-                error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                             "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-                goto fail;
-            }
+        bdrv_ref(bs);
+        bdrv_dirty_bitmap_set_busy(bitmap, true);
+
+        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms->bs = bs;
+        dbms->node_name = bs_name;
+        dbms->bitmap = bitmap;
+        dbms->total_sectors = bdrv_nb_sectors(bs);
+        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
+            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+        if (bdrv_dirty_bitmap_enabled(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+        }
+        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
+        }
 
-            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT,
-                                        &local_err)) {
-                error_report_err(local_err);
-                goto fail;
-            }
+        QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
+                             dbms, entry);
+    }
 
-            bdrv_ref(bs);
-            bdrv_dirty_bitmap_set_busy(bitmap, true);
-
-            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
-            dbms->bs = bs;
-            dbms->node_name = name;
-            dbms->bitmap = bitmap;
-            dbms->total_sectors = bdrv_nb_sectors(bs);
-            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
-                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
-            if (bdrv_dirty_bitmap_enabled(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
-            }
-            if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
-            }
+    return 0;
+}
+
+/* Called with iothread lock taken. */
+static int init_dirty_bitmap_migration(void)
+{
+    BlockDriverState *bs;
+    DirtyBitmapMigBitmapState *dbms;
+
+    dirty_bitmap_mig_state.bulk_completed = false;
+    dirty_bitmap_mig_state.prev_bs = NULL;
+    dirty_bitmap_mig_state.prev_bitmap = NULL;
+    dirty_bitmap_mig_state.no_bitmaps = false;
 
-            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
-                                 dbms, entry);
+    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
+        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+            goto fail;
         }
     }
 
-- 
2.21.0


