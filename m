Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47AC5517A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06592087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UBmQS5Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06592087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1AU-0003Ek-QY
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15E-0002z9-Ji; Fri, 06 Nov 2020 07:43:17 -0500
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:25254 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15B-0001NU-A7; Fri, 06 Nov 2020 07:43:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5PvPf/vaJ0JoS3V4t4zIJ/m47b8NoIt/3Exd0HR8rYdqFPUufZNIE22J9OLx+2+rKDu5RW4Cjfgh0yNxHhNFtTOVObxbVTRNXwVlNrETNiXiaIXnDuD4b99KYXhWTjWBiF9j97E4BrfWiTvjJmgDy8CZyGYe7zXIU6IXWeJuA5Eeko0vrWIkzzHgVVj/9OMIJWDjiRGNr8+5IreXAhz0fx9Y2VWnPY7f1SNNsy9935si8qO52oiYsxBHdOFVE5EciqXlaZfsDnclymPwbNo9ng8aZMVTmiVLpWPBGCADnOIx/36vmbNcmklYQ+qt8uh7Dyy18wo98j+cNNA5IBKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNSWkf8COwBZWr8josgOfkOST2m24OdIoK94mJDw4eg=;
 b=k7bJm5ATDTxvl3NnALJhMRgGL6q3E2K4ar0SRgnADDo3V6Dmnkiix5R6nXdgw2RGklOYWm7ww/RSaFX3r9VHYOJoOTgAfsT5MBMqF9fs4p4hB+HWMC+EofGZ2ueK3NKN3g33lS3JcJCPHqbQVqh4sDpkafRAFT2+XbKgszGkT31iQKG1lv1wtWNbXrnw0XEsK2JB9IvQs98ar4NLDe4t0vtAhVMg8sUb/CPgw2hXmwOdhbQMESCoSb4yYsU1f7EoRCpa4g+EvubR4zpZZRMuj3tvoeqiMzHmRoqEc8uh8eUCNZmICM+146cna64P4iiJrA/TPE0u9ufB9PnkV07r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNSWkf8COwBZWr8josgOfkOST2m24OdIoK94mJDw4eg=;
 b=UBmQS5IhUTsNP+1wsnWbjK+qoVvxTNjK09X0VqRmmL952knmYe+U4IOKruDAHqEXT1GrSQnUgmBoiTvMPR6KBtJG6oQH7SAx+tqdQQbNqCzSa5i9cukeXo7UkVc/z9qJQs9Or0mgwRP1yXDJ1xQ0j6Cd9tGJauBYMhSL0lLXosg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3766.eurprd08.prod.outlook.com (2603:10a6:20b:83::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 12:43:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:43:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 5/7] block: bdrv_set_perm() drop redundant parameters.
Date: Fri,  6 Nov 2020 15:42:39 +0300
Message-Id: <20201106124241.16950-6-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0712849-26ed-4fba-d0f0-08d882517ebd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3766E2255A92711B0D76770FC1ED0@AM6PR08MB3766.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1y3KJwx6J8NrmxfbKGkPKAfbK9BwTUtilkkZnN+GyVPXAUov1vas0Z/JuD8Wrj4kGMSNUpun0+Qc24nAe/3VVEntcNOVuG1RRqIeu1r2taKh4zqnAjUHx9smUd8b7HzhvxJPIr3l/9TkRs6RVKvkYrZdigNyFKM95KoL7KsCVui7HQ+0E5oJUfbwtLgQMLv3Jj0/UQqmd1+l3jptvaOTG+aAWFTPxgHb+652s9mH2Bl8ySFrsdAeN0K84fMlzKDsxYSSGq1LwM6stWtMEkKa6FXvylwzBW8iOoX6BWq/uf3HWO9Hu9rXaaNStxteiPxj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(107886003)(956004)(6486002)(316002)(6506007)(4326008)(66556008)(66476007)(86362001)(1076003)(6666004)(36756003)(2906002)(52116002)(26005)(186003)(16526019)(83380400001)(66946007)(6512007)(2616005)(478600001)(8676002)(6916009)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zTgms+Fo41FU5wtfo2nmmFV2CTytL9+Bvmcfa+rkxHajJ6iII0IOiRdBAdLBLGjoukUAP1KM5UcjW4wslS0vFsL3dCy9uBBqRle1z13z0dtUjAmWxOt9P+eJlTRIpdWlGBa9nvjwhkj6FzmRhK4FZl9NAVDR5GJGLsn2J8yeA9edtmho56vHHWFwlIyc3wOggu9fBfDglJeSJr/C3HGd8c+yjKAUwXHKhZgmmHnxWGA9ScVIUDPILjD9ZJ0qPGAnuffCeFLT3i9AuDZh0QPFTMIae1S74iUcm9ulwG2nGkj1Y9vo5NSrlISAE1zhDxAZi5zQ2QsxNB98q63Bjr/XiO5rJB3n6UqMUlPqCpCCcw9YIqCD2/T0VM5jz4iQ9W07hkAlS6t6zkoUuzyeSF8zGjb2zo21wURPk8pzplmcHs7ktQiJQvaz6AQMBrCA3x5rzcPldlfJYX8UI/N5uobw57PagR7gxmcnwGV1ajjgJM3x/K2h7W8nW8t3X0k2V7FSSW8NBlbhJCWG7b/bstQJXTqHsMmG7WDSdUXFLn0ttaopFIcUXIuizpIF48jrBaDX7A/5Mz9IgFXlh4HNv03ivV/0fMyGOqBSmLFVk9O/0HHoq1YY9hxZICmdlIcxRPJQ6RIoxJQXBVEg4ZcGAJJx6w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0712849-26ed-4fba-d0f0-08d882517ebd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:43:00.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCnyJCQKLC1eh9W5NNSXniNbqSoLIe6VLAvfAlMKqgQlZF86LaoHqsoM6sWoZ0VbSL/19I9bb3PUWzmDZvCUO2xtTEzktikEqLufV84IBP0=
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

We should never set permissions other than cumulative permissions of
parents. During bdrv_reopen_multiple() we _check_ for synthetic
permissions but when we do _set_ the graph is already updated.
Add an assertion to bdrv_reopen_multiple(), other cases are more
obvious.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index fc7633307f..b61d20252f 100644
--- a/block.c
+++ b/block.c
@@ -2106,9 +2106,9 @@ static void bdrv_abort_perm_update(BlockDriverState *bs)
     }
 }
 
-static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
-                          uint64_t cumulative_shared_perms)
+static void bdrv_set_perm(BlockDriverState *bs)
 {
+    uint64_t cumulative_perms, cumulative_shared_perms;
     BlockDriver *drv = bs->drv;
     BdrvChild *c;
 
@@ -2116,6 +2116,8 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
         return;
     }
 
+    bdrv_get_cumulative_perm(bs, &cumulative_perms, &cumulative_shared_perms);
+
     /* Update this node */
     if (drv->bdrv_set_perm) {
         drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
@@ -2298,16 +2300,12 @@ static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
 
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
 {
-    uint64_t cumulative_perms, cumulative_shared_perms;
-
     c->has_backup_perm = false;
 
     c->perm = perm;
     c->shared_perm = shared;
 
-    bdrv_get_cumulative_perm(c->bs, &cumulative_perms,
-                             &cumulative_shared_perms);
-    bdrv_set_perm(c->bs, cumulative_perms, cumulative_shared_perms);
+    bdrv_set_perm(c->bs);
 }
 
 static void bdrv_child_abort_perm_update(BdrvChild *c)
@@ -2333,7 +2331,7 @@ static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
         bdrv_abort_perm_update(bs);
         return ret;
     }
-    bdrv_set_perm(bs, perm, shared_perm);
+    bdrv_set_perm(bs);
 
     return 0;
 }
@@ -2634,7 +2632,6 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
-    uint64_t perm, shared_perm;
 
     /* Asserts that child->frozen == false */
     bdrv_replace_child_noperm(child, new_bs);
@@ -2648,8 +2645,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
      * restrictions.
      */
     if (new_bs) {
-        bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
-        bdrv_set_perm(new_bs, perm, shared_perm);
+        bdrv_set_perm(new_bs);
     }
 
     if (old_bs) {
@@ -3867,7 +3863,13 @@ cleanup_perm:
         }
 
         if (ret == 0) {
-            bdrv_set_perm(state->bs, state->perm, state->shared_perm);
+            uint64_t perm, shared;
+
+            bdrv_get_cumulative_perm(state->bs, &perm, &shared);
+            assert(perm == state->perm);
+            assert(shared == state->shared_perm);
+
+            bdrv_set_perm(state->bs);
         } else {
             bdrv_abort_perm_update(state->bs);
             if (state->replace_backing_bs && state->new_backing_bs) {
@@ -4637,8 +4639,7 @@ static void bdrv_replace_node_common(BlockDriverState *from,
         bdrv_unref(from);
     }
 
-    bdrv_get_cumulative_perm(to, &perm, &shared);
-    bdrv_set_perm(to, perm, shared);
+    bdrv_set_perm(to);
 
 out:
     g_slist_free(list);
-- 
2.21.3


