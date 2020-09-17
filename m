Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E0FC43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445E12065E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K/5RERBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445E12065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0BG-0005Jr-EN
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00j-0002z2-23; Thu, 17 Sep 2020 15:56:05 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:28641 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00g-0005sK-Sc; Thu, 17 Sep 2020 15:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avOWFdWNSipvF1Mp3mn46HaAqAg+5jPPgtIaKOQuLocBXX9+YkX6Gf/7IkR0fMjwKr6ruqcf9MrYv+u3jV5dG+TeOr+UKcmv98K8MR0KHFoxkE5jhccexrQ9vfy1BLbpyNJlkzSdfq2jt/9+p9bSDJJ9Rz/LqbM5tWpiREkVEol4SX9Wi2zbptAngUl2eAlpXfeofiEvLGY77vCxWwwBrAD/jtIrINStSTq/dW0mi7fR0NPK3C9XPXc5OtRx9ex97TCmjLGN5rWNgL/iLMPNpEg4J+tBxt7w0CTsP/LVMJ/3rUBZ3D9PL8lrgr9rPDIWpzeVd4KwKQrNZ71z3hkqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sGQyejwDkt5GNIPtwdKduLg8T8npulMbDbSYQx+n4w=;
 b=fZpMUzD5xOep1gVtPhqHxHw49VUKIL2NDJ7iJSwmzYH5/nHux5hSxUmHfWKCrMWbfmXxKzRerrBsNRWSowiOcbqRX79MDMyRIgDlLHTZNCM6Ip6XmUNtdtMRrqB0H2/nkL1z80WUwocG5T9jfqvF2ct1k0zGj7hIBDH3+2qvoFT4LVf1ZVJTUxdr38qD57VYT6+42KFVo7kRyJjMdkO+8uTt+lvUB3Y0SvfbzRuqMR07Twh1ObQXPh4IMqnpKyrGA4CIdKhVystviLxUMpSfmLC69IrPO50RHG2ciObSNeMUbFvUMzsmPfksbQPg/Zz5yN4a2G7r8Q7pJv+y+uBYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sGQyejwDkt5GNIPtwdKduLg8T8npulMbDbSYQx+n4w=;
 b=K/5RERBaZDdVF30W7M6jJ2n3nCSf5gHyaCl9EtZwVmYpDoucb7L4F/TJ6lSQWjQ9hurDLHiPPlmZq+jqSL4rNwm+DEhN1oV6QvCTTEE9TtsV1thoMqcfV4ENk4mot5eAUMlkhq3dTM7EIYOqqV5I12+qU+8Nfn6TL3hNGC0/F+8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 08/13] block/qcow2: qcow2_get_specific_info(): drop error
 propagation
Date: Thu, 17 Sep 2020 22:55:14 +0300
Message-Id: <20200917195519.19589-9-vsementsov@virtuozzo.com>
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
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:42 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365ec200-8e7b-4c59-aa01-08d85b43a8ff
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303278061E255E2F5880C9A2C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eVshozvxHBMhiC9MN+mUQRsf5glw1RkPGLVZk6+BpnHc4TXXexm/79AHgvEvDEddM76aVvgQ0kLbSgkhkl2NJpwbxhtzW5Om36yYV7D8TIxOIfjiJzzrlfygg4Uo+lEuMSUd/7dbwGrS/wJ45yNkqz5M2PXq6IvF9int2gEN/XgKtHfI7+70dZKlmRgIMpyY8EC2m+DGdQK5MxX/J3t53oxc7vaYv0bTBwLqtzatdr6gd0AAtuEcupDYR+Udrab93T8MKEukHrHBC+ZEknXt2IQlVIoAdBpW7nzd+uTifRbnN5oLqK8ntYgcSxsYK5sldYhhk4zibjbboceV9SMDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(19627235002)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4G1eCOHiZ1XF5jm9FLxjhcSsxTQqIuyKHQdotQwznNhs0Xu7qRDDV/Q1jxOrBy2SklvAWCtKowIp6p8SfSwkqxbCFB4ROsEQYWEGC5W/egCqnIpbzdAoONCW84YhXiSjcxO9KG8idhx24dlS+HbhPfrwADebyCxOjOwgsmEyakWzQtIo2FTN01vFc8+MjRgIw7I1eauOhB7/BWCTIH+jrHa+o5fLi2A/6k4MfljryKpTiMk5+RDT5Kc1qYXS9issv/qczwfopKXOJL50EzqGXaJBfyclVpWoKpy6rWKfAp9/mjj4vgQJ+NWLxhFcQWbgM7l3WontsWk7m21kMFrzvGSvmPPKzvFE3IRJLy0HwEZTwPdSSZzUfIsjUXZ6d0xwRSYKit+us78LcKEPUAPXJfG9nn7jrm1VYpV8w12YaD86DcFz7DtYdohWOzWM4mFkNmTZaO0aODXpPK+Z9aC6KACYaA5hubfvKaPfokgHd7qdsy/XU7VRygHDdMcDFJFJYRqu6IuYO5wzrDsJ0PG00UiaXPi0bFWImF/gLOh7+QNHqJ1LbBI5BBjUahsZ2I3JfW0YQz/8NILDZTdW/RwjrNbV96S1Ah2e7qfHXToDTxKjmrO8cFtBuV/5f/0TUhsIFdRq9vonWZhgtgtm9x2REQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365ec200-8e7b-4c59-aa01-08d85b43a8ff
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:43.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRAXNjtpYgEAQqSxf2r0J4E8UHR7MiurKwzBxWlAohUmBKgNnahAI/RNs3je3gLhzbcLfyNM22/8eoNeGF3TQpJ63+TePjybxJuzwprdQnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:40
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
---
 block/qcow2.h        |  4 ++--
 block/qcow2-bitmap.c | 27 +++++++++++++--------------
 block/qcow2.c        | 10 +++-------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index b71e444fca..6eac088f1c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -973,8 +973,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
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
index d7a31a8ddc..4f6138f544 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1093,30 +1093,29 @@ static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
 /*
  * qcow2_get_bitmap_info_list()
  * Returns a list of QCOW2 bitmap details.
- * In case of no bitmaps, the function returns NULL and
- * the @errp parameter is not set.
- * When bitmap information can not be obtained, the function returns
- * NULL and the @errp parameter is set.
+ * On success return true with bm_list set (probably to NULL, if no bitmaps),
+ * on failure return false with errp set.
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
@@ -1124,13 +1123,13 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
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


