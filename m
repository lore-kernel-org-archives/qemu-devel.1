Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8824C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DE220C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UhQcip1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DE220C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Lf-00012k-1f
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KC-00077j-Ru; Wed, 09 Sep 2020 15:00:08 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:61422 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KA-0001PE-HY; Wed, 09 Sep 2020 15:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVRzJ+OHONJ5eEmz5mN6cTuiDvvhvnCRbJDTx+t28UGP5CC6A/TwsCjIWrm009X/ZSBEBLrmlTDw/Z70SzdtT1fMpFz5eEliiB0wPFzZCqk7lwpgvb+nh14i3EiPzP0jLILA8Sp5ix7a8k68boTJnMO0NIsHJuko0OxWMPNu6y94viAlwv7Me4PIQYRf7kBIB2sWVE3DiBu3jNMhwX0YPdj3CE8DuWFoafqwu+ds4ovs5fNhheGdUKAKIfaJUaDrO/Je3T9ENBVK3byDJgngji+uIjC7xL/yJbk1VjIDP8ABLzokSXdrlRdbCt0dtQhk3SrB3mmcJoDYATyIpN3Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gf4wp9OSntv17rUPSQmy4ig6Uk5a8Ed30bse9iICuE=;
 b=Tq8Q0cZ28iaewczhJK14uc0I2fYbuhMSyI3qKgbkOCuQUnHKai/rXND+WcxKZ4diP/bqaQ8SsX6NJIFOIE6mF2ba6GuiDQt/9PtmJvqy/n0m+NldpRv5+EqBGL+deSz2CfBWPJWJDO6zBPO8DNrQqS/By7rKx/LcK+cgSaL3yb1ju3YohZpya0iMdEGw4C32kfnSo5uJaW4c3g6UdeG1VC78hymp2dRuSRQQ9dEA5s4Zps1NkXRIZuv0toPiWVW+KhZr+I9nfyLCJ11aHx0aIItohER93mxFcNudECDYs/lunRA59DFMeRD+JqhfwX2QESyG5HXq/xwFFNHTiyeCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gf4wp9OSntv17rUPSQmy4ig6Uk5a8Ed30bse9iICuE=;
 b=UhQcip1lqSfnW3puuOBKJeVuMEChx/USEOVcvOYQyO3jZZNi2xdIwsOm4b+Snu+h8jqYqUmGfB9x7O6LykKlbSpF+NDugkb0CGTzoyxUOL4drlEGkOpuBxrAUCiOssfzAY+P76L7J6WM07W6JdAdPy4ADF8fsmeKdzRULixqjLA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 19:00:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 19:00:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 10/14] block/qcow2-bitmap: improve qcow2_load_dirty_bitmaps()
 interface
Date: Wed,  9 Sep 2020 21:59:26 +0300
Message-Id: <20200909185930.26524-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 19:00:00 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc078539-b22a-40fb-c764-08d854f28e06
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4070F25FA37DD64C69DD3262C1260@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpS4OI5i/PdoOnfojiEMFqmKTQixUB3n+ahDvzhX2tgWGuBhjV+kC1KH9pUzb8YsZKaqyy22lq/DSsvcCHNQ6GX+AOUJg1pHYS9GQ1+jTEtAyglwu6dFVlXe8QAM0mz5Wv8YT17ir+Z7jml8R1F3/SdQFup9NQTroWlc60QU81XX/r98pQMpUcf56Avwah7ew+9kXrMbo625hPoaUKXZc8cr7vz+d5shkJyfjNzMilI1GpjIvQQM9+zBADQIpyaCitnKz3mwLWIpmVscXrw3ZBDnzPmI3VgIzdgOzGnA5tBM44HHjWowpXedlzKzw7DBzwbtbsIFcu7W1TOnP6JL4eJ5mtCfP8AYfJ4KVAPs6wKeU+wBfCn9NLHt3kKqNwuL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(26005)(316002)(8936002)(19627235002)(8676002)(16526019)(186003)(478600001)(5660300002)(6506007)(7416002)(6512007)(83380400001)(6666004)(4326008)(36756003)(52116002)(2906002)(6486002)(66556008)(66476007)(956004)(6916009)(2616005)(86362001)(1076003)(66946007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xJd8bLpEoM9NqKheW87kRKznXjszXPH6BKpwq/XyhvaYA3CnIXkaZkja74XLipxtXcBXrYXvAd6scqWed4ga7QUdslRBWG4img03vZhWsFdJ4DUsk7r6I6VHOO6rAME62OxYqD0nCzyY3DhukUsGUmfmjtLhztLsPEZvotrnjqIZh3iHQl8eR64Ch61t5xUA5oeNEHFLZvKdB7SGWzj+J6jPtR8gL2c7bSGXpJhgPPN4RBd9xFAg6AR+LfLVlExcKl1Y+CxsHinjTCzH6WbcOoRt7WytC/QQygufNjmBhGqF39UkQrgcQqtU51ENpi0DR76+mTEG7K1TkBuFW2gS2opqQWi1Mf8jAGdJLXBtyMY9274aZIq3rM/ARAxfuwyt9TqRBT0p9Azu85AwAtl3Aw7IPxdDdgaQupbYLNfsoVkV7gg1Q2ssZGAw3Pz5wgT09bAHlpoDlJb4kZP0FDpRb/Tmr5mBXAlNmvmehp45dSVDrfozHS0LQAO11ZXOyvu3KG83SM2e4GozoRV858UvMhhQhvppjJTMJLBZDuBzERFKAY5ScVwELlxH9uJJlS3Y23QO7SnTOJyuSt5Sf7f5brli4NGLZKAueid+DKJ6mYO/FOmh2RcdcAOxjLYoYxhYYXuPL5FHAg21EY7ZXOwE3g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc078539-b22a-40fb-c764-08d854f28e06
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:00:01.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5kESQTEPz/6xDFCSYgvnpUhxQLM1iCDRc3FibWQBrEKmqEsPiBW4M8VO4+s9I5thwlFBFxzqGHqeKalAVZeoBr5JDsgdfRBqgEWBIcpvqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.0.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 15:00:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's recommended for bool functions with errp to return true on success
and false on failure. Non-standard interfaces don't help to understand
the code. The change is also needed to reduce error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h        |  3 ++-
 block/qcow2-bitmap.c | 22 +++++++++-------------
 block/qcow2.c        |  6 ++----
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ac6a2d3e2a..e7e662533b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -966,7 +966,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
-bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
+                              Error **errp);
 bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 9b14c0791f..f58923fce3 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -959,30 +959,24 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
-/* qcow2_load_dirty_bitmaps()
- * Return value is a hint for caller: true means that the Qcow2 header was
- * updated. (false doesn't mean that the header should be updated by the
- * caller, it just means that updating was not needed or the image cannot be
- * written to).
- * On failure the function returns false.
- */
-bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+/* Return true on success, false on failure. */
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
+                              Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
     GSList *created_dirty_bitmaps = NULL;
-    bool header_updated = false;
     bool needs_update = false;
 
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
-        return false;
+        return true;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
-    if (bm_list == NULL) {
+    if (!bm_list) {
         return false;
     }
 
@@ -1033,7 +1027,9 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             error_setg_errno(errp, -ret, "Can't update bitmap directory");
             goto fail;
         }
-        header_updated = true;
+        if (header_updated) {
+            *header_updated = true;
+        }
     }
 
     if (!can_write(bs)) {
@@ -1044,7 +1040,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     g_slist_free(created_dirty_bitmaps);
     bitmap_list_free(bm_list);
 
-    return header_updated;
+    return true;
 
 fail:
     g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index eb7c82120c..c2cd9434cc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1297,7 +1297,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     unsigned int len, i;
     int ret = 0;
     QCowHeader header;
-    Error *local_err = NULL;
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
@@ -1786,9 +1785,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
         /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
-        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
+        bool header_updated;
+        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
             ret = -EINVAL;
             goto fail;
         }
-- 
2.21.3


