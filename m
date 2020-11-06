Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E804C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF3F206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vsscVpwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb18m-0000XR-HW
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb157-0002ps-Sm; Fri, 06 Nov 2020 07:43:05 -0500
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:25254 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb154-0001NU-Av; Fri, 06 Nov 2020 07:43:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ0rwZHQs1/bMS9+kpmHa4gXEFG9PQMYJ+hgTB4At3acoJvRYAQCk0KhomK3azIUJEkU+JjJIGMdIzZTf6dgkVj8Oy9Zsu4wG3dC7rF273hoVE1RkM5PKNj0ApWmHZI1/3X7RK3t/AejfakN/hrgB8QDIBfuHioGVzTK5TkbTmNppLf+D2YTOGzTCC4cTv30EfFwh0wbu+DX0RJWnLwuzHaD/MpcsGMcQUj2Zul1J3jcD/tc3vXsPv1Esl5UtqfMGaUc/FLvbeHM4lCAxbYrk8dHaSImFEb/LhIpRg2r6rSskhgsK8Q+eq06J8qKupMO2WfJR/Tz1m0hD3uStAkjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5MDXk9+0O9Oa3U1ZXLzTuFl0AH/RX3PHHJ1U0w1aZM=;
 b=JwDhfqnlK6QWtb8kEzP9IKlVyBn5nsRYY+Ok3C1nL24GAo6/t0QFr3zsy6dNTnlDdPZH0qqOncT9BJccgZyzQ3mJTCIi9npGwc2UTu6AOfj2ng3lRlXqwDa52rr7pfi1ZrVcHTYvA7pI6lx++GHpt76IXwskQQZay2Sq4B9Bun2yEWieM029ivnYTVsucJFvRwYjopE806yN0kFB2Gy+D66VMjTukEwJFY9r7p+VfRVABFl/zzIcubYgRNZTsfp2g9mmYIHsYz/LGjjgq/995QblzWA9gBjuuOtp2DGqWCGI7BY5hgkyN5EiloMNydt/ddypEmEvymOzmWVyyJRbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5MDXk9+0O9Oa3U1ZXLzTuFl0AH/RX3PHHJ1U0w1aZM=;
 b=vsscVpwm3smtberCrUvTN38HnY47acY9CDFfQtBYLXCHkzNi+EK6GWmjorRPAevIt0gQAovnkUTct2xZn+LPZQohTIP6a+hWVGlTamGAXieKcO7Nl4FcKXL9t9hVHQEusIQUUzis5cw2VlQcpwSbh0P37zZEC+L2c6uqswtGWpc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3766.eurprd08.prod.outlook.com (2603:10a6:20b:83::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 12:42:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:42:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 3/7] block: make bdrv_drop_intermediate() less wrong
Date: Fri,  6 Nov 2020 15:42:37 +0300
Message-Id: <20201106124241.16950-4-vsementsov@virtuozzo.com>
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
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7166613b-dc8d-4828-6987-08d882517dc0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3766735016F2A85440E2DBEAC1ED0@AM6PR08MB3766.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNVFw72Onztazh5zEUJG4ypzHd6ydDPsru97BmIteaDmRQOkffeMN3/Ae7jfz1+Jp3DGwhKXfFH3bRzEUz3jYeyI5Wa/aIfhtu4Jn0WDP31he6fPaHUBzDB9DlzrwWQ7O7A5R6Vf0xv6UqaicerSF534nzgHKS9wdmBErhYCVAsgeX5JPzW5nCx6/7RTh5J9w/KDoGfTGmhQXaGpDbuETRh4E0hnr/N+iC3bK1uQ+Dv7isuzjiHP4uJO6fqAuxrw9dAFOc3ZF6EqH5ARKKIy0d37VL5n3x5v6eFi3nprAU+8iDvo+MWb5qAwXYppLxiM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(107886003)(956004)(6486002)(316002)(6506007)(4326008)(66556008)(66476007)(86362001)(1076003)(6666004)(36756003)(2906002)(52116002)(26005)(186003)(16526019)(83380400001)(66946007)(6512007)(2616005)(478600001)(8676002)(6916009)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Pt3MT8X1vR/XGVWRtbMeiv7gSKej2vOQ9eUOzz+2J9WQcHvn1TAZmdIoCREMpn2HrUEmnry7qxwk0HnK1vvIPDFnYAvI4XFlZYeVCpFirSQNnFJppFXOdtsD1a2icSyWu9MFEL5dvA8N1VIcXjFaz9+F7D6yzh6M9L5NN7EY2hT7fRgB4E22SHwztvJA94BeDIXuOXEKyW1UaP4XVOVNANo5nPsJa3FTiC8XjOIItbQ2eHa6qULXRSWnPvT/C09Tki9THbt+hKI652tpWyDHNlKmtISo3Dvw0qjc0lefTFGdtVlzXR8mjwJiK6p9SWlWQ4gNiJD93I5H6y6lcVZvJzev0RzboP8FAnmY6RbUKiVWg86RVwLt+MRCMpM6rAD10chuVVNcBUeKSOo14QRg2VGaFmUTTi0Zrt+NAC6iYe12t5QZ721RwiQf50VZ5UzXQMsrpSeEtF2LE0IcJTGApCoPphB673OFLJUAQNLTCIta0QwoRoc0p2XEOYRLl4fCAg7gklYYH4XHHZbLnyOi6yP2El26M3EAXyZKa9KERR79fMHALnLyi63L2w2FyM8BICs/SGlMh7RkIlyovYIQRYpj1RFOpooxdc0oTlp2pFzu5vSdDhYBP/XhdakwfGM3U5TuNJnk6w4Wn7CC/HT3uQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166613b-dc8d-4828-6987-08d882517dc0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:42:58.8371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfgiQMxeYiaPLSInI19LVzd4bo2wRbkGshzX6E1dcyKfm2P6RuR/wSx92ceqX4K28EsTwvlCLGW4gcCfIUSPCqIq7JeNoYGr3Ut+d5e5GCw=
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

First, permission update loop tries to do iterations transactionally,
but the whole update is not transactional: nobody roll-back successful
loop iterations when some iteration fails.

Second, in the iteration we have nested permission update:
c->klass->update_filename may point to bdrv_child_cb_update_filename()
which calls bdrv_backing_update_filename(), which may do node reopen to
RW.

Permission update system is not prepared to nested updates, at least it
has intermediate permission-update state stored in BdrvChild
structures: has_backup_perm, backup_perm and backup_shared_perm.

So, let's first do bdrv_replace_node_common() (which is more
transactional than open-coded update in bdrv_drop_intermediate()) and
then call update_filename() in separate. We still do not rollback
changes in case of update_filename() failure but it's not much worse
than pre-patch behavior.

Note that bdrv_replace_node_common() does check for frozen children,
so corresponding check is dropped in bdrv_drop_intermediate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 11c862d691..77a3f8f1e2 100644
--- a/block.c
+++ b/block.c
@@ -4910,9 +4910,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 {
     BlockDriverState *explicit_top = top;
     bool update_inherits_from;
-    BdrvChild *c, *next;
+    BdrvChild *c;
     Error *local_err = NULL;
     int ret = -EIO;
+    g_autoptr(GSList) updated_children = NULL;
+    GSList *p;
 
     bdrv_ref(top);
     bdrv_subtree_drained_begin(top);
@@ -4926,14 +4928,6 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         goto exit;
     }
 
-    /* This function changes all links that point to top and makes
-     * them point to base. Check that none of them is frozen. */
-    QLIST_FOREACH(c, &top->parents, next_parent) {
-        if (c->frozen) {
-            goto exit;
-        }
-    }
-
     /* If 'base' recursively inherits from 'top' then we should set
      * base->inherits_from to top->inherits_from after 'top' and all
      * other intermediate nodes have been dropped.
@@ -4950,36 +4944,36 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         backing_file_str = base->filename;
     }
 
-    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
-        /* Check whether we are allowed to switch c from top to base */
-        GSList *ignore_children = g_slist_prepend(NULL, c);
-        ret = bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
-                                     ignore_children, NULL, &local_err);
-        g_slist_free(ignore_children);
-        if (ret < 0) {
-            error_report_err(local_err);
-            goto exit;
-        }
+    QLIST_FOREACH(c, &top->parents, next_parent) {
+        updated_children = g_slist_prepend(updated_children, c);
+    }
+
+    bdrv_replace_node_common(top, base, false, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto exit;
+    }
+
+    for (p = updated_children; p; p = p->next) {
+        c = p->data;
 
-        /* If so, update the backing file path in the image file */
         if (c->klass->update_filename) {
             ret = c->klass->update_filename(c, base, backing_file_str,
                                             &local_err);
             if (ret < 0) {
-                bdrv_abort_perm_update(base);
+                /*
+                 * TODO: Actually, we want to rollback all previous iterations
+                 * of this loop, and (which is almost impossible) previous
+                 * bdrv_replace_node()...
+                 *
+                 * Note, that c->klass->update_filename may lead to permission
+                 * update, so it's a bad idea to call it inside permission
+                 * update transaction of bdrv_replace_node.
+                 */
                 error_report_err(local_err);
                 goto exit;
             }
         }
-
-        /*
-         * Do the actual switch in the in-memory graph.
-         * Completes bdrv_check_update_perm() transaction internally.
-         * c->frozen is false, we have checked that above.
-         */
-        bdrv_ref(base);
-        bdrv_replace_child(c, base);
-        bdrv_unref(top);
     }
 
     if (update_inherits_from) {
-- 
2.21.3


