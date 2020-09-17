Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF916C43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE2D206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RtuYO1+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE2D206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ05s-0008PO-CN
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00P-0002h0-0l; Thu, 17 Sep 2020 15:55:45 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:28641 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00M-0005sK-L5; Thu, 17 Sep 2020 15:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHy4d1d1otutumgq0mvcYuyupuhQNjoompXqCW7rFG36O0h/yO/HcOmAIUJ3BUq/abozHxWviAHwxGI8eicZPPA2MByi6Q6y8WMtIQDdYhScRYhGmh0akcPId1+xpGzesPlKI5sNGIKrtlXa7lZw2Q3VIUSkCsBkICGwAWAeKBbSqKHnCVyE8t1o03MzIoqyQl/HTrKv0wH7S8fjud7D+yhJpyE6OVVHeFT0qMwlQO/DuHmBkLPu8U2BNneyfCPvVUlgfRrj0XSdeDKlzBrq0y0oJu0znybEHI/UJvb8QM66fFSpKXmkZ0o9G2aKkbsUqmcTT1f5tThp54yoE/omVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpkRMYlbsgreX25U7JbbBT3Jkj7PPnotGvGN44jh+uA=;
 b=nMozalnMW1ezHA7ZJQNKi2lqr15Yp2KK0zlj2jwqRhKz7y2kOr/8NsfcWIu9LkK8bL7VMcIq/XpHDhiKaIXJcjcgbPg6pYcbD+qCfHc5ZGnzDUQ3wBJDM/FVkwTG/D8PTyemNfSRNpKonAvg4G3/Zr0LmC+oAbMcnFRfMjzgXHLGuuLbgtmzLKgJcr12mBsm4JCZk9O9xOijBM4lSvNCoVp70pvrnQ2OT/aBGf7NFdDaxND+AHxQpkRecg9VOQpakwhoFPKtx9lecaOZ+O82odCAs3VMmxRMix4JHP38+cgztWJdFsMluts9xXmjPopcPtVGPoXmYI76kfVq3B4jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpkRMYlbsgreX25U7JbbBT3Jkj7PPnotGvGN44jh+uA=;
 b=RtuYO1+UK+SR+6VeXx0HtyTyJyRUIh5QPzOwjdbOB6Eg5VFd0V/Za9rfJ+CiXTHh1Vq4EOVeS8r+9c30irLk+Jf+7DTMPFqfDO+a7B2Q3RtkdzvrCvVhhE6ELD7GWp84oFdY0nf1ZxCDI/7buZe0J64BmlWZWmFB1G4dCi7aX7A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 01/13] block: return status from bdrv_append and friends
Date: Thu, 17 Sep 2020 22:55:07 +0300
Message-Id: <20200917195519.19589-2-vsementsov@virtuozzo.com>
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
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:34 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c3787eb-0793-4c93-a5d3-08d85b43a48b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303231FEDD4B0D80E66052E5C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tD6XcFCBN72a9croz6eJ9KGjF5I2R6x0ZgWMRjCI13c3cd4mEuNSC/+kPi+62kPJZX7csrIlN4A6pcKoawVSY22U28WykrENcl5yuPhJvOfvtX4IC1nbOuI3lusDCQs0L348Qr6gBYHGPE68LWdFne1dX0xpImiMavSuOc1Io0SYhBoTJla+iSAqrunXeVYNP2JW8q57ufWu7w7cWwSWfc+TlIEcxXa8EX24jZ/okP3vK1Ad5kjFB0rOxxrcW+mIjv3aLUybxDf9th0qev/szQNvZWlMLLQYSrzdqFD3JBioYctLlC3Nv/9bROeX7h5KmEDMliVf3UwooumnwwMcEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rPF3QyNm6A3L0NNLpYYlWZTzFI2i8wTxURHKIO9j2BGqwUhT9wzQvRW/hlFp3tsZSiacCNrnEl+FgwHlERwMrHzRmw3YlLIz/Lk3UKvhY34a8jZrtheiDx3uLn4DK8UCN9aLVFFXpiGBMBdtThVcnwU2rE3rz05FBdTehzYbyb3E8J4YaAmRhbF+B+xz92YPQFi98HTv/Mrk+IVYxgORRVlzCXy+X22gNM0NWAfTrw6/Ct6KthzuYJx79Cq/AnL0x0O/INJ7KprDxq4tI9btRb+KHRiFSto+OyBOcROylJEUsiMN8TlrHNsQfOla9/JM7Em1w1lCohoiG808uFYvngIkYOVivO4Eesh7G3Y/JDipEleswda471VdNFS67VgZv/YMd7dHdqPZxVGvp87juzdNF9n4wNjZfU7A+DSvV0HomaDVkpawhKZ5OaohjO/Cej3GATIiSt/2dthQJOwLD+Oz4xRtuIiGUrfxZkle8L2XeFVFFC8xOcJv/V9pmvywqEtKoih4gpc87+RfB7L7lsxRBhRz+c+lTJOGW+oxmCjqpKqKvj/G6hVv/IAxFyclCG1u86RZDQJtE4BRPFD6MAOhUKjSUrMxrKRWFgJmQ0gYiPCtKbV1BWED8O9Z7JHT7mH5RYjzR1hsBzg5CcSRkA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3787eb-0793-4c93-a5d3-08d85b43a48b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:35.6030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWqN08IcljRkjDBzOcKJhbQ1BMpCx8TOb/OnkX88yM2dhsu8IQQqCJPJxb/CYl0iNG6c1kHY/4TkbxjLx5sOsGUIVnTUs3T/BhHAe3mOEgM=
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

The recommended use of qemu error api assumes returning status together
with setting errp and avoid void functions with errp parameter. Let's
improve bdrv_append and some friends to reduce error-propagation
overhead in further patches.

Choose int return status, because bdrv_replace_node() has call to
bdrv_check_update_perm(), which reports int status, which seems correct
to propagate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h | 12 ++++++------
 block.c               | 39 ++++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 981ab5b314..a997dbf95b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -336,10 +336,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
 int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
 
 BlockDriverState *bdrv_new(void);
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp);
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp);
+int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                Error **errp);
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp);
 
 int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
@@ -351,8 +351,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BdrvChildRole child_role,
                            bool allow_none, Error **errp);
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
-                         Error **errp);
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                        Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
diff --git a/block.c b/block.c
index 9538af4884..f922c6d8f4 100644
--- a/block.c
+++ b/block.c
@@ -2869,14 +2869,15 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * Sets the bs->backing link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp)
 {
+    int ret = 0;
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
     if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
-        return;
+        return -EPERM;
     }
 
     if (backing_hd) {
@@ -2895,15 +2896,22 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
                                     bdrv_backing_role(bs), errp);
+    if (!bs->backing) {
+        ret = -EINVAL;
+        goto out;
+    }
+
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
-    if (bs->backing && update_inherits_from) {
+    if (update_inherits_from) {
         backing_hd->inherits_from = bs;
     }
 
 out:
     bdrv_refresh_limits(bs, NULL);
+
+    return ret;
 }
 
 /*
@@ -4553,8 +4561,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4576,6 +4584,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
             continue;
         }
         if (c->frozen) {
+            ret = -EPERM;
             error_setg(errp, "Cannot change '%s' link to '%s'",
                        c->name, from->node_name);
             goto out;
@@ -4611,6 +4620,8 @@ out:
     g_slist_free(list);
     bdrv_drained_end(from);
     bdrv_unref(from);
+
+    return ret;
 }
 
 /*
@@ -4629,20 +4640,16 @@ out:
  * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
  * reference of its own, it must call bdrv_ref().
  */
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp)
+int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                Error **errp)
 {
-    Error *local_err = NULL;
-
-    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    int ret = bdrv_set_backing_hd(bs_new, bs_top, errp);
+    if (ret < 0) {
         goto out;
     }
 
-    bdrv_replace_node(bs_top, bs_new, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = bdrv_replace_node(bs_top, bs_new, errp);
+    if (ret < 0) {
         bdrv_set_backing_hd(bs_new, NULL, &error_abort);
         goto out;
     }
@@ -4651,6 +4658,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
      * additional reference any more. */
 out:
     bdrv_unref(bs_new);
+
+    return ret;
 }
 
 static void bdrv_delete(BlockDriverState *bs)
-- 
2.21.3


