Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866FC43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B252065E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GmitedwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B252065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0BM-0005Vw-Tj
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00a-0002pB-HE; Thu, 17 Sep 2020 15:55:56 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:56995 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00W-0005tE-Rt; Thu, 17 Sep 2020 15:55:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ98UFUi+u/1WK6/gfZ+IXRbWobGu7Ph1CLeMArcZlSnM+II4r2d/jiz7b8Q6hc0CF7K242JrJtd1NM51PcenuHSATcAlHoU1m7q+b/0WQAohJNYqB2oOpM3hYrd9QIPhMARSr7UVOCQTaIOZnNVJyLu7/EBbBJZu5eCl+rYcPFNSbnbZE8OZFBX/pwybiB9RBrJp1cjUuLfiT6K6hNICCwzJF0erdq2i9lSr88q41ivVj6m6jSp/Z7E7QOPx2APDPTjZUhwEHWnGRKU8WqG2ayExnNkLFZrMXikYVxaly5vpdYMlrOTRXO1sJHbECphbb2zXknt5qXl6EEo+OAdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c76Vmv40VcKAvAe8uSuDFeH8k0HGeR5tXjw6O2nUMlQ=;
 b=BRQP5XsbijvLjiO0W+8qcg9VrMbHGVjs62XgGPXWxZ8pUa1tsiL46jnpROB/H5O4i3unEO0tj6o6K6uVoKSuxeLvA7Kdm0wCSKXtTXqbZ6/Cjo4JCEPFf3uSbppQGhQM/+SStiSlvyB1owC3Y0P2fJVtTlRuC36C0njvI86fTByMiDMWfKZGrx2CLEh+BRxtZK8GWpLQVsKHXJelVkXb2axlyLW69Qc5j6AT41oAyPSkgl1hnr3XCR4475r5tLJ575KP+hO+Px9upvSV8hUhQSStxuprTMBio9846hwjtPrMXIDRiA3uOmd+CBu2mTQZa2oKxG9621wsK71a04kLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c76Vmv40VcKAvAe8uSuDFeH8k0HGeR5tXjw6O2nUMlQ=;
 b=GmitedwZbSowIMPTc6jTdO/UJ2yoWCSr9gKiu9w+y1/nWgaznkUaHcfKnp4ayqP0ROfgOBntcrW1v0XfaigTtAz0UbW5815LVuoEaCKLbOZSoQbEG4cORKekuZwYGTK+gYuqMaLDZxNGcE/nrYDhQTPlF3pOXSa0YAjYowY3C7M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5254.eurprd08.prod.outlook.com (2603:10a6:20b:d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 19:55:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 10/13] block/qcow2-bitmap: return status from
 qcow2_store_persistent_dirty_bitmaps
Date: Thu, 17 Sep 2020 22:55:16 +0300
Message-Id: <20200917195519.19589-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:44 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 794fbf4b-011c-421a-9637-08d85b43aa4d
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254B0CAFEEFF2D82E63F1CFC13E0@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:246;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac8CnPm2VqAr5BHz382bI79iUi4h2+xQcCNrtl3Miv4TOsFAC+p2u02YxPDbLlpQ5tDjeUuzWbXSqHshsGIGtxAt0yztnMaDXu+46czPLsbxfxrutSRcqlr57gMX6xqJ3BMXbimRavW1ui7dhTTNjHW1zaGVkNE+TmUU1OFxNTPb9w4YM3sb2liKDuRrT3BIjnT1R6UH/Dw7//h1k7hvmW5RDro5yDmUck2Y3AAnHQ3JHbIFs8gFurSyCp4iIVKMXJQauo+GugzpdIDdj0ReJDWf/SJHkNe9L6lzMosrXB7+yQUmlHADxSmTYqTjA1VrDA9I8NZILB0VheaTz++nDYSwygf8Awa1/HoJUXNeN/fGPP55ulL+4G9zY0aoNFId
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(6486002)(316002)(6666004)(16526019)(186003)(6916009)(8936002)(8676002)(26005)(2906002)(7416002)(52116002)(6506007)(478600001)(6512007)(4326008)(86362001)(66556008)(66476007)(36756003)(66946007)(956004)(2616005)(19627235002)(83380400001)(1076003)(5660300002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v2ehxShMY4OdBBNniNQ7oJ4QT6r8bXWUP65U4UR3d0QJczI5io22obR1eY7qQIckgcZYjooMGanKYVnwHkSkAuucNkoEnUeWVIrLX9i6QbbXAX/vdvO769nXbVDhWjBclCcdmMow5Mm5sf1uf2dDoz4/edaRRmarBBcos9iqgCDBT82ogMf3gSLubE2j57BdQi4+w8WnFNP4KUIztwpmB/U59gQEBzeC243/9eoesBpw8tOdunwjPQevzF16hz0Hc95n4p3sQLr49mu0KtB7gVhb+yGaGjnVElAJl3utYwt86pKGRw1Mj8O/ZslwfPTtV9BcHOGagpKLnvZH+yRNTxoAV+p2WORAgInfqYIwtMqevIzSjFcJ/BBXtf5HeZkblN4Y8072k0Ubyv+tVpXEdnZcittC6qUixdGfl4GnNR7kv02RTuZPlbtze+oiCf3MRVyKwSQKVPvePQKFKYOPBqPUWm9WKmcQ/R7ULIo59H6ZyLFULTRMD9zKRmSjiatzNpRcNV+uUJO+u4wJRYHgJEkzUDd4+8PRJrlCmZKJMZkRtZkT5PnNIABEI5iv6EBFBcVDGSJuGLesO9/+rHn9mYdlRSafgcWkapAFKsNecuiwssrrB4x2ly6OV43sZKO0JrioUE2ZLwsgim0ZkHDLsg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794fbf4b-011c-421a-9637-08d85b43aa4d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:45.2317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfCBzriOgL2GtHuvnKxc0lfa2O49I7UGI9kLtkbs3v9MNxyqLpZmkhqAVLrSxj5MCS6TYhFOE6/2ZRIgwDDw+DqbuagnDgMpacpCY8gntDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's better to return status together with setting errp. It makes
possible to avoid error propagation.

While being here, put ERRP_GUARD() to fix error_prepend(errp, ...)
usage inside qcow2_store_persistent_dirty_bitmaps() (see the comment
above ERRP_GUARD() definition in include/qapi/error.h)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 block/qcow2.h        |  2 +-
 block/qcow2-bitmap.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 3c64dcda33..7884a5088d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -978,7 +978,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 500175f4e8..b8ff347885 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1534,9 +1534,10 @@ out:
  * readonly to begin with, and whether we opened directly or reopened to that
  * state shouldn't matter for the state we get afterward.
  */
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp)
 {
+    ERRP_GUARD();
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
     uint32_t new_nb_bitmaps = s->nb_bitmaps;
@@ -1556,7 +1557,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                    s->bitmap_directory_size, errp);
         if (bm_list == NULL) {
-            return;
+            return false;
         }
     }
 
@@ -1671,7 +1672,7 @@ success:
     }
 
     bitmap_list_free(bm_list);
-    return;
+    return true;
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1689,16 +1690,14 @@ fail:
     }
 
     bitmap_list_free(bm_list);
+    return false;
 }
 
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
-    Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
         return -EINVAL;
     }
 
-- 
2.21.3


