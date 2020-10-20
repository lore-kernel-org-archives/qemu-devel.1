Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD76C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBA222265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DTJ5vXHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBA222265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrNp-0007eY-Ck
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIg-0001Ij-Uj; Tue, 20 Oct 2020 09:03:38 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIe-0005aC-Rm; Tue, 20 Oct 2020 09:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnIzVp41FHj8W7L4jCEEAgFK5y4McZT7pOFHzx0JAoR1Zqr4RVAUbO7QN7+QTOExb7HKywL+P6Ps1H3L53IJTq0mLKDhT/XkwWFNlAf9KHXCNCYZqkvRLBj4fmeIcN83h2UKGa7ys6LxepgoUSGud2CRJZp7Hn0SjUQ0X1iAWgQfloMNxHRbBM+ixpRDeTmv7U9ctdUNYZoDOZ0TOznUCyl85wF9yFnM7uY8z1CPuDa4NERtxrg+owJJVk9nYy6trs+62PEwjeBaqK9VPK2Qg+K/5Fobnf7RmFvtIwarKCaF+t7uc/rZTG+35na+oTwcJqZMbXBcMUQBVDwE5mSTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08mGRPpwpe1C7I1yJw49EwaOZauF1xlSB+2f+cz1T8U=;
 b=j8V/od1Pyr4pisp2P1IPIFESHjcI/dimf/XtbctT2aTgRyWhlqA32yoa9h9I5rFO65fp+GnPKPAFEEoAKWHVfoYBveTLi1xYCMbSL5I+fH/wo75cgOrFw3fCSeVn6zoLlTnQPjxLPj/i6jMOl5UBiGXRfTgsK3yySaCAZ8VqyaBqWVn3SiJL2BbGnWVcdtZ/dILh6ATdZpwrNQuEEoJ1ptFZlIrOHWxFAT+qWL1Q0hfKuyrN5hwQJpfmhU8i1f5LwrNgzh5FcV/cPtJM9T9IXwtR2cSB5VCRsVTgak0f5r9ZVaTdejnuAcf2e24m8+Ahy+lZH97LDmFKARKDjMGVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08mGRPpwpe1C7I1yJw49EwaOZauF1xlSB+2f+cz1T8U=;
 b=DTJ5vXHwiWpyLfwAEmpz0o9Lp+EBqN+Z/frpAyMNmKT4+pxLYrVsgy7a/iPqt3WRWCOJ3HPmCrCiXu7RaIX00mv3XgQ0rwXCJpdPoQ5lK1smRYPVIPG0raOvEiOcxKHPPXL5E4h/LjtseIgpPNZF6PZQfk3v7MtSswvLtiSn/wo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v4 01/14] block: return status from bdrv_append and friends
Date: Tue, 20 Oct 2020 16:02:58 +0300
Message-Id: <20201020130311.14311-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c00eaf2-a2a8-44aa-6803-08d874f8888e
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168E6554946CD83B34E8C40C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e26KGImCiHy+VZRFNdL+9o+dJs9ZBoih3hkcP3fdfmHT60V3xBse5XDld+4ikkR4ABoam9I3H8eENgqsCMGGth1YYbX/PsCVEwAk/4YQCtOeXEQzfmPOzAK3aZY3kWIE92qeq/+MbUHAvVfIUw4E/2T3mfNV42dJBaqHszeaBI4F+BALqR1payHBWhWpFphLr4Yeg98spmY3U7HgkwlQkyyWV9PaUktzxI/ge+u/ecAOim7w42Gc82SgQYeKTd5uZDFY2E6PIJ2Qjm2pTOtfWzoSmtZpK0mKBpDjFThSi3xiDkNtbRmHkWCY0B06WgHmsojhLuLKH3s9DkVnYHl/9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L8Fm42TIFroLQvOfmoi//WMi3pZkzKkcGGzYPJOm8reVF0HdHV84a2Xr/AV50nYs7kFj6wm1IXAAyPibEcZc/2hdsUSHVH1V2mHOsaRbzhSCRfdw5d8DMoxcdHhS2V8aOlVQFsqzQUn5KqvSUXjtPvmotonlWL/yGFtL482iSa28rqRF4CcET3/wiJfRY+NaskeqAO2IZEgdivIIfwQ7x4Ozq7AbVoJMc/OtdWjiaKksNtBEMdhu2De44s5t6qbaTJvH2pYkErajShesis9ojy9XMYE9Oyx7ZKdRGSyb5co+uSQcnNmBQOR41CyB0h6udStSDtqKTe9Nwlu1GwutWa992Q9fXIccAJkOsQCWMmKii+jjuQcvhGaei58l2/WYi3nPyOLbBWmHNR7P7JX9V6I8DnQLxYWGKRAKrrlLNm9x0x7HGidnmowHnFaHssGAm767i7AQ+4OWhXkMLs1oZjDK+lvDKcsCndhrBnBtPWe0JTXwNUuBKnZVDmbczOnn+A+bwsJQ6aF5St531FQmkBUukP2Iu/FJ824oFIZ7Q11daOm199bx60PdYnhgQBTWbo5hgsSv5MPR5EtrkaQ0IAQtKEkc5T77xszoxkM8ny1eN4XJGelnT/8Y6NDEj0Fsj0Y6ziu8FTOsHNAXIu8tkw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c00eaf2-a2a8-44aa-6803-08d874f8888e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:26.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UoYZIDMKMQukZJpadZjRzLJ49BxsYeu9BkGPA5ew0k9bpko+sR4qM54sNCjxACsXdwsAAUWUunwBFR/zqqVtaGPW5vHKBLoGgHCJHYnglA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.21.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:34
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
---
 include/block/block.h | 12 +++++-----
 block.c               | 51 ++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index d16c401cb4..afb29cdbe4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -346,10 +346,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
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
@@ -361,8 +361,8 @@ BdrvChild *bdrv_open_child(const char *filename,
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
index 430edf79bb..31c55faae0 100644
--- a/block.c
+++ b/block.c
@@ -2870,14 +2870,15 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * Sets the bs->backing link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp)
 {
+    int ret;
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
     if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
-        return;
+        return -EPERM;
     }
 
     if (backing_hd) {
@@ -2896,15 +2897,24 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
                                     bdrv_backing_role(bs), errp);
+    if (!bs->backing) {
+        ret = -EPERM;
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
 
+    ret = 0;
+
 out:
     bdrv_refresh_limits(bs, NULL);
+
+    return ret;
 }
 
 /*
@@ -4554,8 +4564,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4577,6 +4587,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
             continue;
         }
         if (c->frozen) {
+            ret = -EPERM;
             error_setg(errp, "Cannot change '%s' link to '%s'",
                        c->name, from->node_name);
             goto out;
@@ -4608,10 +4619,14 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
     bdrv_get_cumulative_perm(to, &perm, &shared);
     bdrv_set_perm(to, perm, shared);
 
+    ret = 0;
+
 out:
     g_slist_free(list);
     bdrv_drained_end(from);
     bdrv_unref(from);
+
+    return ret;
 }
 
 /*
@@ -4630,28 +4645,30 @@ out:
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
 
-    /* bs_new is now referenced by its new parents, we don't need the
-     * additional reference any more. */
+    ret = 0;
+
 out:
+    /*
+     * bs_new is now referenced by its new parents, we don't need the
+     * additional reference any more.
+     */
     bdrv_unref(bs_new);
+
+    return ret;
 }
 
 static void bdrv_delete(BlockDriverState *bs)
-- 
2.21.3


