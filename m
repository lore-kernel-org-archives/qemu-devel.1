Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407FE206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jCMWQitd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407FE206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytS4-0001lR-Hm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJH-0001xu-G1; Fri, 24 Jul 2020 04:44:07 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJF-0008OD-GS; Fri, 24 Jul 2020 04:44:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrkesoRMep4Vg7zdLRhH+iHjnZQ2BoD+SaVbINoFXUvj+48Tn2V+kz6plEG+cz0PHptGnEMwIbH7QBJGbUfhtvSzj1If69DzGsaXsCTbcZ1rT+WWGdV20w8NPfIULCagR59UoexTWamru4sdnpgp1kwV6/LmH+wf3wqZDvkEqobRkPpA1cR5WCRmuvrJYMIVm5HP0Zd/ujsvDthpDZOqOVysOP0qzDjYux+FCwx9YKhvVQ7srpREoSAXBY8XlIGCcSeb+gxMEZjFPe0TbHljvDMgkFnEdQazXQkqdQib8vstpil3n722AO4Qru/peFtgmP7VVvHr8s0dZ7tRfqXF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpZlL9SNYbh4wZnahRYVWrpY+UrJdNndt2i/TkLC5+E=;
 b=dF4PXmSFh3fRUB/7tkWq0KSALHZq0jUV2jwueOMF/0f18OHNR6khNH9eEpgYAYjUWuOEBbOMle+Qr7vD1+ZjFg0HObmt7N+R2SuVfeNs22MFiIizDJjX+MEdB+8GCa/22kkDYv6cum5UURurV2qZZV+3JRjoeoFgdrv++DHpr8+BiN3q4LtNwkPsWK4CDo945osZ5dXyVcEaTcNrnX9pZHbpT7Gcmz8rnrvmRf1kUHZK5mSECNj2sl4/9e8kECRCHG40RcD5BRTOfBlet5l9nNuvTxYK25uNYlF7bUq1ihlbb5qkjxCNI5eSax1SIfhIzbHJszJiOoAv3t4bX1DSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpZlL9SNYbh4wZnahRYVWrpY+UrJdNndt2i/TkLC5+E=;
 b=jCMWQitdWvFI2IJNzbS8Fd6Hs1gCUoYnNkCWgRdTXJLb6Qr0dzRMrTyz1tYv0icpYRlfQAZHoW8fk0NhILCSH+TBMQdO8Hx+bTTKgL44cVHM8OmCJ/nNAh4L49hbkQlvRg4Hf5i8QmjL/MKg4y69k+HQAxTc6kh7czGFwInIZMk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/21] migration/block-dirty-bitmap: rename finish_lock to
 just lock
Date: Fri, 24 Jul 2020 11:43:18 +0300
Message-Id: <20200724084327.15665-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddc9e70-10e0-4c92-8a9a-08d82fadb25f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB453449F74D0D8D12E56C73B5C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGVVp6MZifiEMdFce7MVyQD99VxKBzFIxWE083IT/2ff6Qo5bJiV1wYK8ZpXHB0BLI5aORXvbs1abFJVLaPjp5mFnDLxgO2Jymn6WpKpl/LnlE+YWvuRgT7Hroa/mv4nTCe+gMI+SpD9mhQ49QyLx7/M21hSXv3j4QT4AXiOr2314SXj1JvrMbSaA7e+3NHgUb+YpMo3+GyvBe6E6CtkIKlGk+6BTypKrqTIZ0V9KXRnt/RsOEm8zWdfQlPbP7X5rOJMslbEJlcl8G3dsXB7l74K0HXksUOlFRhz2Cq9r+Tj0pWBoHZdyeyY1Ksv3+OquIrlLxEPtEkqgFgjPxpkrvP4ZY3Rb30r7PyXO0EZLroSOxCwta9UQh4xV13bNU4MVbRAMck2hLfhsR+CoUtJZIeXmdaa3hLsR5QNfAt52xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hx1TkB0vHmrhyxyYJA3sq7dC1Wr0zEVTvPPaud/DREN01cZWntcJUVo8+w1zXd01hi54nwr50eF2i29RILMzKNQX+eg+CrF1kRBtS4Uh4j+Yj0nrtfQ4Cuaf4MsWkMlwSGwY+33b0ngclWziAHHb0q2WlnfUja5wzR3NdfOOHL1o3VrCc0OKSIxPrHPF3fhFQCzrtHS/GKJPDGHKWkvF++oH38zIErXf7mXAvXyBFVmUFK+RrEGUkF7hKOBHcnrSAW1ZeYiwQni2Tfdq5WQpKtsXwQOsfy1FHz6aBJD5eDIFdSW0S4Y+8O1PtJDz6/1tz33DNmfsLdG54BM4/uB7wDmiapgDC5OoJfYIchUj9WOUODrHsDt8Tany7Z2uflRmNdjPcFcpmXshaemtP4F+RFy6tPCwDxiYzP0+VQ58msvMHOXAJ6hmZetSNVdXd4DChgu6HnM+v+Qc6RLxXrNjQf4tOPkw+pwUJu6FkLhdRgQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc9e70-10e0-4c92-8a9a-08d82fadb25f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:54.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK+o9uAvR3f5d7W3kdSM2xp6hIer2S7YpY1TzSfZOHHY+DHQICyLC4lztvQFwRXW1lv+auemAe9TRdDU6dnrguLd4PGOWtRgDjTYvqNX45w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

finish_lock is bad name, as lock used not only on process end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 9b39e7aa2b..9194807b54 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -143,7 +143,7 @@ typedef struct DBMLoadState {
     BdrvDirtyBitmap *bitmap;
 
     GSList *enabled_bitmaps;
-    QemuMutex finish_lock;
+    QemuMutex lock; /* protect enabled_bitmaps */
 } DBMLoadState;
 
 typedef struct DBMState {
@@ -575,7 +575,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     DBMLoadState *s = &dbm_state.load;
     GSList *item;
 
-    qemu_mutex_lock(&s->finish_lock);
+    qemu_mutex_lock(&s->lock);
 
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
@@ -592,7 +592,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     g_slist_free(s->enabled_bitmaps);
     s->enabled_bitmaps = NULL;
 
-    qemu_mutex_unlock(&s->finish_lock);
+    qemu_mutex_unlock(&s->lock);
 }
 
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
@@ -601,7 +601,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&s->finish_lock);
+    qemu_mutex_lock(&s->lock);
 
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
@@ -633,7 +633,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         bdrv_dirty_bitmap_unlock(s->bitmap);
     }
 
-    qemu_mutex_unlock(&s->finish_lock);
+    qemu_mutex_unlock(&s->lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
@@ -815,7 +815,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
-    qemu_mutex_init(&dbm_state.load.finish_lock);
+    qemu_mutex_init(&dbm_state.load.lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
-- 
2.21.0


