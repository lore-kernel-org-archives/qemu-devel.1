Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8FEC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49705208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uIg+ft8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49705208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTQ5-0003r6-8X
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGQ-0003Fo-FJ; Fri, 16 Oct 2020 13:11:34 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGO-0007NG-6d; Fri, 16 Oct 2020 13:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8MyftO8gFhZyrZ8EK4eHBjLdcXMndbnUcB4Z2P4vY+Q7NObGJdonQqfBIeODh7famXhOKZpN3C1+E7FAUjMHByaYpSOaBni6tgNK8fWSFW0B7s5bofHVUQcDPdZ/+o8mVfK5M7/z5AedxwCia4hiKLgP6ig/lQ13QBYuW4W22Zjat29whvQHkz4s9etECxlbFRoqWJdH80EN4P6Lt/9JPnsO4DtLnte3S6Rs1+VOXKapRe4IIIF3w0u5jJhH3SwiBxptMn9rT7qj2JaK/1TEYFwY63WcLY7/9UpPFi6n8gIzqLmnFLlwJtE93+TUIyQCMRIdF7v9NneiPLGewq03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzwI6yjtID0+Lvy8WbOn3esTTKJbyyDELKSbFPHnepw=;
 b=nLGFngZVfdAZS1BGPK5s58mY9gYqCvTnTSXYgP2IDU6FFiIgP96hIQDFuLZedl6lK00md2TTxXFHrbBuk2PhEcr1PiM9GsfXfv8PHRwim11ZmhNGcm5yGsIJvfkR6GBVlAj1IBsBKo9Ed29VGKhB4S+m5sJbaSIjobLTRbX8mvtZztpJebLU8ZMZ7O13FzhZ7vFjSMsYp3FjVMGAol2t19SQ5RXZo/eOuvcCqKY4BbMnZgU9rRwte5XozVyXel1HJi9DnUX4b1IX1KxXLnfk3xIRkg+0ilaHRSvCkLvsT+xMbOIiyBW1iuLkFoDaXffRAwCcdbWDAVU+1r/Cy3wmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzwI6yjtID0+Lvy8WbOn3esTTKJbyyDELKSbFPHnepw=;
 b=uIg+ft8aw5jjfWCEGwAymkCUwqcsx8CIQJnJJR8uaWqwK7xcrmJAHAD26Qk0AD+NQS4i63XVCuu37i0FbJyHx+r68ldUq+8Sy/1Owj7CWoz2ixz5v2rz043Ni/NIsbsP3GnPfUNYLvmjxLUgCERpGaTH+3DPvar2chMZFi2OuqU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 08/13] block/qcow2: qcow2_get_specific_info(): drop error
 propagation
Date: Fri, 16 Oct 2020 20:10:52 +0300
Message-Id: <20201016171057.6182-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd8393a8-f290-4483-72de-08d871f68038
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495DA7962FC3A67B1D848BBC1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELXbvjnpXVv2hWeJWchXH657xqcqoeeQypZnPF40ugWc6TRjqH9+16qs1B/8wkmeQn9eZ6fvN7+t7XCqc8cB1Y78LbePncjA1ATA7Nh2AE32zwlHMJtRrBLpo/0k+0Nk6T2PvwXcRDWwDWWSqMIcaM3kNpu+GpZIKzCbCF4z7LCphv0kcrJMuUc8SxNSrr3IaIEmV7AfkdYYebKsyk0+lXcOrIwaT2zWRnL7GOlBLr3iwHAusyvfkCah0e+0UxV8YTwXqCtCo30F2s59SFSOANepeOTxEdapd2mW/ta18AJgAn2tbPb6pxOr5exQBxOaJrkBviru3glJ0NnFvnoTmu+Htj4oTLW+k6a99i7bM3+I9l/curskzOfivCFCfff2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(19627235002)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v1aMeKx40UKc2Fs8K5rsL6DjygfxBy1+XxjxqHIPV+JJ+SRbiiyZrkCOUDjkNNo/jZ2t1zR68M/nT5Kt/FkCxuVM3sgC1LNsaJT1t4zmU+L7eUus8iM6VcqvPcl9+iQEUAyRs8dz4ZNNYLGMF91PVCuulyxOXa2bbuWcfnmL0a4BLKfmAFCvKhmsSvIMQx3K1R2QjMLzeGRHcsS6zyF9hSBoXXJuwbqaX6S70wk9HEDuw+IWWeZY5RNb6RdF24DjowxodYvtVmWvkSMmlZlM9LnXnLRpIOXUReT0PiHbesde0dsQDbnxPLiXs+jatx3Yd2vNLaItRH0qG6bPiBOi87cW5xQAjbRj+HGjYoNIRYQeiy9I3n/ux8nlTjruXxIJg1BzoTa5iSsaibXsidUOrUny5bnZnAa0FYUk021h5RZTpsyca8uEOJTfQOdKvp6F2JTR8UYedHAaJixGqv87D/1uv+q4nbP+3hcLXxKQde3mbjjnBEUGjXY2r0yiXv1jhxdzwFR+15A2kqqVx6qmvBGhYkRyPnIrcxXXuphOG09/aQPfVbFIJDSdYLv9kanwqmZCPrNYNro/05EQ6Bv6Zm1OBFg3m3coDaksJ3aleQSLs6pe7Q0/LhKNgWFTx/3Ox4wfaOQzOyLS+947QVwljg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8393a8-f290-4483-72de-08d871f68038
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:20.1465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLiEOWTE9S3E2THv5psgf3o9i3V7Jeq0MaGbVikSTntEO9jkBjcLT+/WJRQ8kpJ2xEDVFBw01+yFGRsTxL+7tvBTaM1UBSOg7bNjroMztgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
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

Don't use error propagation in qcow2_get_specific_info(). For this
refactor qcow2_get_bitmap_info_list, its current interface is rather
weird.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h        |  4 ++--
 block/qcow2-bitmap.c | 28 ++++++++++++++--------------
 block/qcow2.c        | 10 +++-------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 125ea9679b..024901a6ca 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -976,8 +976,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
-Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
-                                                Error **errp);
+bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d7a31a8ddc..55cd52ab96 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1093,30 +1093,30 @@ static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
 /*
  * qcow2_get_bitmap_info_list()
  * Returns a list of QCOW2 bitmap details.
- * In case of no bitmaps, the function returns NULL and
- * the @errp parameter is not set.
- * When bitmap information can not be obtained, the function returns
- * NULL and the @errp parameter is set.
+ * On success return true with info_list set (note, that if there are no
+ * bitmaps, info_list is set to NULL).
+ * On failure return false with errp set.
  */
-Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
-                                                Error **errp)
+bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                Qcow2BitmapInfoList **info_list, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
-    Qcow2BitmapInfoList *list = NULL;
-    Qcow2BitmapInfoList **plist = &list;
 
     if (s->nb_bitmaps == 0) {
-        return NULL;
+        *info_list = NULL;
+        return true;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
-    if (bm_list == NULL) {
-        return NULL;
+    if (!bm_list) {
+        return false;
     }
 
+    *info_list = NULL;
+
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         Qcow2BitmapInfo *info = g_new0(Qcow2BitmapInfo, 1);
         Qcow2BitmapInfoList *obj = g_new0(Qcow2BitmapInfoList, 1);
@@ -1124,13 +1124,13 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
         info->name = g_strdup(bm->name);
         info->flags = get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS);
         obj->value = info;
-        *plist = obj;
-        plist = &obj->next;
+        *info_list = obj;
+        info_list = &obj->next;
     }
 
     bitmap_list_free(bm_list);
 
-    return list;
+    return true;
 }
 
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
diff --git a/block/qcow2.c b/block/qcow2.c
index 41a29072e6..8c89c98978 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5038,12 +5038,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info = NULL;
-    Error *local_err = NULL;
 
     if (s->crypto != NULL) {
-        encrypt_info = qcrypto_block_get_info(s->crypto, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        encrypt_info = qcrypto_block_get_info(s->crypto, errp);
+        if (!encrypt_info) {
             return NULL;
         }
     }
@@ -5060,9 +5058,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
         };
     } else if (s->qcow_version == 3) {
         Qcow2BitmapInfoList *bitmaps;
-        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!qcow2_get_bitmap_info_list(bs, &bitmaps, errp)) {
             qapi_free_ImageInfoSpecific(spec_info);
             qapi_free_QCryptoBlockInfo(encrypt_info);
             return NULL;
-- 
2.21.3


