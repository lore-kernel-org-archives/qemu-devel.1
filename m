Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C47EC4742C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610D22072C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C6SF8XhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610D22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYq7s-0002ov-9a
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 08:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6P-0001SL-Gj; Sat, 31 Oct 2020 08:35:25 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:47840 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6N-0000Bb-OI; Sat, 31 Oct 2020 08:35:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHzfJPuNDMaEmfaKgGX80xRYKUFsFdqTW7KJHVCgTQiPvZu55suhwGqHiMgzQEedFwixKSHkCjaVkY8igRwf5aTW/YmR8oiWT8dy5pP9oWbVSpSmHvghGoRIGqeX7Pjj5cs0kuBG6N+rmxKc7Ik/MZexrcXWdeqw8MZajcWF6CKORwAj7KtEn8MVYrctF86WvhmR+42SXdFi47LootlucKQ6gngqC52hQcrAZZt8kcboh7VWFbv9LSi2cmy56ih8CNDCwp0fi3nuVRArcAjtTTuq9yqIUX/vZ/mxEcjE6jdLzxKAgtDez64zvRj7MwOa6ZTtlneY7+D15d8V7rjX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcJJOEbqu4yHarlC96vOfIQCdQa3o4nLmn3cJ1c2fTY=;
 b=dQ882wHHHzS/Npp9HUv7vNzCgQQkubHXaz4PXeJAOr3DzkUe5PRJIJWrkutkeSpXUvBjx1ng5ElJPA/0c8wKASBVrUJRU0J8avJ07YV6ad4/Odw1K79qYPX22vMDhui62sGe4reX4hevNos/rp95u8n4mUHQTGhkkUXwIEzpE/MouSLcLn42H7b3U4CuwMyFQi8CA/Vr86FxY4BgS3YdG06trVT7XC+sxhHDGDddhlUZyaCer4lfiI3JuwtznJfSeuVEzu+ryQn+7PKwWrKCtWKqmXPfQdBQIfd942NFVXA5HEYwNOLejMyCJDoA1C8qJhMEiW7x6docZ82Gr2X3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcJJOEbqu4yHarlC96vOfIQCdQa3o4nLmn3cJ1c2fTY=;
 b=C6SF8XhE8GNdEHspx4x4DxDw4LAjTtFKDMXIb1tjPx5PTLtfAE68H+nix1qvdA8rss55Q0K/fZUfL7RrPp4nhqYg8MSbCsE+nB7LopOF3sYDk+CiPtlnmzQiNwYqceIK1U+EDB3ZuKbGUIP+3JXN6zVwTyJtVvnhaICDKICbikc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6152.eurprd08.prod.outlook.com (2603:10a6:20b:298::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 12:35:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.029; Sat, 31 Oct 2020
 12:35:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH 1/2] block: make bdrv_drop_intermediate() less wrong
Date: Sat, 31 Oct 2020 15:35:01 +0300
Message-Id: <20201031123502.4558-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201031123502.4558-1-vsementsov@virtuozzo.com>
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.113]
X-ClientProxiedBy: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.113) by
 AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 31 Oct 2020 12:35:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77de99d-f9de-4d31-af54-08d87d996ae0
X-MS-TrafficTypeDiagnostic: AS8PR08MB6152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61523F346CC23210A4791E54C1120@AS8PR08MB6152.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Jw16qklhiy4cNzwADjeug9YE0F4IOP2bhh/Wvhq7sg2fcklbsvXEZr4Q/HJlF+w2nl3qXMe5mPWqmm37LF7G9Gp93QMOnEWKm040H/ssYyp87Xk2yYRrL+aHoBDBzNBhPimVVsAGKtOX6wRZ+F99P+13CTBsmkSE6G6RzIaEwa396PQ++0nJ9iuzb+Yzle8w5RqnbQStrO+YSwsFlmofLUW5uD5Iu4ebNx3MBLUsJe+znoZch8K/lXrA2RpGxPDrCUdsUpZTqGe9y9vuu6tgU7tAPAVc3NpAlzD3kCAk8wurqp80JvqcHQ1EZVjcITpadG6jPcefKO70rdtkj4RtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(6506007)(8936002)(5660300002)(8676002)(36756003)(1076003)(107886003)(83380400001)(86362001)(66556008)(6666004)(2616005)(66476007)(956004)(2906002)(16526019)(52116002)(316002)(6916009)(4326008)(66946007)(6486002)(186003)(478600001)(26005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MULczuqhi8gF8bhQ3Q2bkaM4IiOJtMtnACue9sBw/K1uvCzis0pCfmHV/Yzyib0SsYagrWPrm99DlUrr6z5ltKyeRWKaE1On6JKxU5ENp3BVr/yo/uJPklahgfxnAz94yzLO2qukhXYc/FATQc/gQHAXTWaLzHD2Zdib5a7UN9Ct1QskRFrPqLEOz/VM4OYr/7liy451lIGIM2QnQenonRydQ7cXngQuUmm/pMDTg/QlzuAb+bXFZC43uxOL7NHqZ7ihCrbp3IMjZOMeJRmL03LY9pCrBX+CYfVqPsESYqEPJUutWXmVyKxxM3n9X3w8CCb9ho0YiGrQMn94ffQytkrN3spH/V8UWVYFTgbl3sFLIER/ocz6PSQKqJOTTAFFKCKNj973QzBPBl4pPE9OoQGsrv9XJ373/gekUnLL6JTpk3BXs2W/5dMYSbPgfB/MElGyIAc1JtJNLRpLa7Ui7F5259GNJOeqZozHLxsgh9qPuDhvv5DoxIFfOTp6zLWqWRb9Vx42RsKGCFVspJvexdwpR4xHnkPbpGNiSc9qbPolEZPs17gWRLkjxTjGoTZ+dZrcTHSCNbzGIzasV7p/bX6tV/Grsft7B1T4HKPIvfBYV+/QndGymXITBDjA+cm66szRWISL4NC0DMxiR2SqVA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77de99d-f9de-4d31-af54-08d87d996ae0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 12:35:15.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUTV9OJj3Ey0FSaGOiTTh4+QzB9LJGLb1AmSAM58+p0xgpo/mTHDxF/g1E37hEvDYeAybgF6VV+CPOO8qJCAIK1bA4WVrAlrhz0tPhjj5g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6152
Received-SPF: pass client-ip=40.107.13.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 08:35:15
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

So, let's first do bdrv_replace_node() (which is more transactional
than open-coded update in bdrv_drop_intermediate()) and then call
update_filename() in separate. We still do not rollback changes in case
of update_filename() failure but it's not much worse than pre-patch
behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/block.c b/block.c
index 9538af4884..bd9f4e534b 100644
--- a/block.c
+++ b/block.c
@@ -4958,36 +4958,30 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
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
+    bdrv_replace_node(top, base, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto exit;
+    }
 
-        /* If so, update the backing file path in the image file */
+    QLIST_FOREACH_SAFE(c, &base->parents, next_parent, next) {
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


