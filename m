Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E1C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8ED206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NE0uhORG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8ED206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1Ap-0003oY-Pu
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15A-0002um-Mq; Fri, 06 Nov 2020 07:43:08 -0500
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:25254 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb158-0001NU-Hj; Fri, 06 Nov 2020 07:43:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzr0JNnDwikCC+mGSfLi9+4LnBgBaZq9lpAw7J22YGhkdyBs3pvWj0I2Yg6gKrHXoBRc7MKKIWwfmANfDqAs84RbZ5VYNTtGdNloec5TfIQP3yLRcX9vKcgRSVaM5iYwZBEQ5RG1IeO+pZzPOFuj9y1zdTF9OZSJFGf88QgkJbuEisqMxyq7pFogyZD5iRewUNEg9Ehqovg5hOSRmLlh7Tv0r29+CTtfjz6qyTV9D7VyHUwXW3sTSm41COW7iSpP33Ed0b2Aehrxmuiywmf9vxR+3+x3t7Te05wqXvCDcm50YBEw5kBGNdrPN4JlMc2eK84l7eLr7NhZ6QXgrE1+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIMV4Aw45bXg56dXuQkzHAfXD/sWC30OzvBIrIWWFc4=;
 b=C2MOoLwYprr7XtaVLdhOpraIYH3lhfoULgdqZvtkq8B8ivL0SeP33W69Q7Es07v4LrT+4Ri48pnlWDmBrfnh9tNQi1hYhBs6IS3k0v6j2ZyHNxpJAsrI0yk8oVigZsvqEe6YQoRPVe03WaXuC1BAx0DOpavpHzXVNaGSLtc3QMpQFDreHCrgGJi6cDe2O52Y7nWmGF1KKBinlAcFgU77AgdMLhh7Wo1XvEILLdd/k+e+APqbzd9ttUC4E++FEclKkZwWviM1ckHHzTvIyOtvufGgwe6JaxusDH/jA5DoufDRwmmdo1JHUYHCHJM8jgUdNbxrnFOOgpYv0QjiqqKOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIMV4Aw45bXg56dXuQkzHAfXD/sWC30OzvBIrIWWFc4=;
 b=NE0uhORGq5C0bkuFL4Ij4tbmGAFEK4mQ3Ky/MXQBhSjgosRBFi3xKfsMsP2PsozKYn9hFuykf4pUmoQoBWl1SInT/MmBmEh714/3M6/693x1b1L+POPw7Exa/ALw7qcxU4aEcbYfH7GOKh2K+ro5Ch66sSaZZV4xjv55lOQxXXE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3766.eurprd08.prod.outlook.com (2603:10a6:20b:83::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 12:42:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:42:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 4/7] block: add bdrv_refresh_perms() helper
Date: Fri,  6 Nov 2020 15:42:38 +0300
Message-Id: <20201106124241.16950-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106124241.16950-1-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:42:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b1e38f-7976-42f7-6dfb-08d882517e38
X-MS-TrafficTypeDiagnostic: AM6PR08MB3766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3766FD8EB803C46D44324F13C1ED0@AM6PR08MB3766.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBqwU+R03uVAkhts2xIhT/f5fw12qsl2udbgMmVuT9A3beK6ObY4ZvoSCajasjIEWqIvjdFuLtdwFP8wjP6dz9IbkBp7Qc76Od6nu+b8maANkdVu1J2lrlrRyjMsn714xtlCF6A641kmhD29wdQc4xqnsofCNSDnrzHSzE7DT8BS5YDteFXr+iJH03w+E9pV+qOVhIIy3JMXpkfLE4tdUTXCzmTP+ViYIoVPCp0rSzBDk8Sp+aUQMdm0D0qVOCKI3WddovroAIjdYfBM0Zq3HIFfS7SnLVR+blBNQPpr120GWTVGY+tc3u8n8tUme79rUW1OdEQCYnD/pdtgZ+wQRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(107886003)(956004)(6486002)(316002)(6506007)(4326008)(66556008)(66476007)(86362001)(1076003)(6666004)(36756003)(2906002)(52116002)(26005)(186003)(16526019)(83380400001)(66946007)(6512007)(2616005)(478600001)(8676002)(6916009)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xksnpez4D0tng/fBDJBYgazbel63hqoBGZYCRIMym87w6P/nXweeVaEa5h88e83b0FihGqgER/xh05iJwS7jIBAofVGCm9pYF4FjDlWaJnWR//wh7tsoPRyHqwlRmDwNpAgXjKHZ70Eh4kBDpocKN8QNWjkJLSrKtPD+QI8FBkNB8hqNJNZ6MEyfFlL2yKzGNiEyxDciCh4HN+IDeFL09EWVY8xTXImJ8VbxNLvRDIrmChZ35bCntuq+Q7MMdNlFKS1zzTVjtlJd9y82uI5zVwKzN0kMU0MVAD1RFMuiqQaWUBYIsVIdLq4G/Z64fGD5Yp0mcURLdDV0yYCi7Z8VBTLE+sywJxRmHzvtWwRmo0YbGGN43u7HNwyXwJqxK82Xh2RJSggLp/+gMu8lrpj0oLbc1dkOvXhIlzOWesxIPVHaeyuTgcC4ZinqUbSUBUulQoreV7OoIu9B/697KAd4r+iBwlPuRww7DHBsqwJeejHadJAjBZ7mPEOspnJGmMYvZ80bkSjsp7rUBj5vAhPcM6x/C9618M8AjyZvDv31cMWEh3bxBNfQAhTFhPXuNre1272fGWw8rpCsDy1uakt1JndL99itzg7iBOXcIA2T9hN2eSH6DmFFY6MgZqiFW7vTBW+hixShU8SlmaLJFO7WWw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b1e38f-7976-42f7-6dfb-08d882517e38
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:42:59.7023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0ioafu7mPHMfuum4MFvo6PkE1b1XYhf0EdNvSkW2s2LZqFTZ7oEMBOcm29ycEi1hF5WNOeUTYw7PcEIbKxwD3Ntv9350alsrbP/MN5teBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3766
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:59
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

Make separate function for common pattern.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 60 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 77a3f8f1e2..fc7633307f 100644
--- a/block.c
+++ b/block.c
@@ -2321,6 +2321,23 @@ static void bdrv_child_abort_perm_update(BdrvChild *c)
     bdrv_abort_perm_update(c->bs);
 }
 
+static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
+                              Error **errp)
+{
+    int ret;
+    uint64_t perm, shared_perm;
+
+    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
+    if (ret < 0) {
+        bdrv_abort_perm_update(bs);
+        return ret;
+    }
+    bdrv_set_perm(bs, perm, shared_perm);
+
+    return 0;
+}
+
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
                             Error **errp)
 {
@@ -2636,22 +2653,15 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
     }
 
     if (old_bs) {
-        /* Update permissions for old node. This is guaranteed to succeed
-         * because we're just taking a parent away, so we're loosening
-         * restrictions. */
         bool tighten_restrictions;
-        int ret;
 
-        bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        ret = bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
-                              &tighten_restrictions, NULL);
+        /*
+         * Update permissions for old node. We're just taking a parent away, so
+         * we're loosening restrictions. Errors of permission update are not
+         * fatal in this case, ignore them.
+         */
+        bdrv_refresh_perms(old_bs, &tighten_restrictions, NULL);
         assert(tighten_restrictions == false);
-        if (ret < 0) {
-            /* We only tried to loosen restrictions, so errors are not fatal */
-            bdrv_abort_perm_update(old_bs);
-        } else {
-            bdrv_set_perm(old_bs, perm, shared_perm);
-        }
 
         /* When the parent requiring a non-default AioContext is removed, the
          * node moves back to the main AioContext */
@@ -5760,7 +5770,6 @@ void bdrv_init_with_whitelist(void)
 int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
-    uint64_t perm, shared_perm;
     Error *local_err = NULL;
     int ret;
     BdrvDirtyBitmap *bm;
@@ -5792,14 +5801,11 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
      */
     if (bs->open_flags & BDRV_O_INACTIVE) {
         bs->open_flags &= ~BDRV_O_INACTIVE;
-        bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
+        ret = bdrv_refresh_perms(bs, NULL, errp);
         if (ret < 0) {
-            bdrv_abort_perm_update(bs);
             bs->open_flags |= BDRV_O_INACTIVE;
             return ret;
         }
-        bdrv_set_perm(bs, perm, shared_perm);
 
         if (bs->drv->bdrv_co_invalidate_cache) {
             bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
@@ -5875,7 +5881,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
     bool tighten_restrictions;
-    uint64_t perm, shared_perm;
     int ret;
 
     if (!bs->drv) {
@@ -5909,18 +5914,13 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs)
 
     bs->open_flags |= BDRV_O_INACTIVE;
 
-    /* Update permissions, they may differ for inactive nodes */
-    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
-                          &tighten_restrictions, NULL);
+    /*
+     * Update permissions, they may differ for inactive nodes.
+     * We only tried to loosen restrictions, so errors are not fatal, ignore
+     * them.
+     */
+    bdrv_refresh_perms(bs, &tighten_restrictions, NULL);
     assert(tighten_restrictions == false);
-    if (ret < 0) {
-        /* We only tried to loosen restrictions, so errors are not fatal */
-        bdrv_abort_perm_update(bs);
-    } else {
-        bdrv_set_perm(bs, perm, shared_perm);
-    }
-
 
     /* Recursively inactivate children */
     QLIST_FOREACH(child, &bs->children, next) {
-- 
2.21.3


