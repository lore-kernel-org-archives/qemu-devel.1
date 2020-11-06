Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCAC206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Va/dV1Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCAC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb18w-0000kh-H2
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15P-00038g-TD; Fri, 06 Nov 2020 07:43:23 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:31364 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15N-0001NI-4y; Fri, 06 Nov 2020 07:43:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRWzeVT5qYLIddS36w4vpESfvPPVu64uft2Yv8wYHjH6tXzXldxAsxe8IPQ4fjsNaGrssk94QCB7zKXuxljGuZElY+EccBfww54d3SDssm70rgwOx/R7AllDdGdoSUG4qqvleMp5JMpSZQ1kwVhbDiQ7QqlqbiOhIk56G7YIBz18cW0OU2o7UDGA3InSQFoQQuQcb9Kkt/HNAc8HBVv8JYARQWFqN+Ne7R/LYO7bFBLDdWB+8cdz0pv9tTJ9sRw3rwkPhpr59BMcNO1Keyx6OjUBKZXc2MLDX/s4L/SOVlEccP0N8ImAS8zjlHJdS87+hfGp5j5tMRLQ5k/TF+5jkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxe1vIKSzV3ESKRMRn6TTTcFQOlx5aQMnSwkA2FZ83I=;
 b=hVG13WZc62ofbmt0PiYiV4c7sfXeOpQtQ0RgF/l0bYjPWc/2nVUk5uaHFtZdgrFRCcm/DXWwOCyLicgTysdVhBWBmD69Z9kVaHnBox+vmrDXo0QA8xvvCvYIpCBf0nTrdfjeYQphsDGLAfsu6jOqMg7lp9+b02fipoPn7jWrjyzrWh/Eq/Uu4fKmSFDpxSTCeiA/Q6J6FPZ31BNSmxl7dRDUN8m+3a2EEtclrTats4l8Wi3Mgvmnhii0rjn9EI2nY8EtpYJF8A5HYjCUwxnwb6ZmCL5Q0LC6bI5xHyJLqlki3kUluXICsR24r6/OnmjgZuH3aRROik94my8t06oqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxe1vIKSzV3ESKRMRn6TTTcFQOlx5aQMnSwkA2FZ83I=;
 b=Va/dV1RpNyN3Y+oo46XONViKGHAbhdJdL+WAArvrwbwKfubWC9CIS1gMgeMHXN7w9wbs9duXdKj2Skw/FyivsdZX+MsZE0Z+m2DycqI4MJ2aKCH2DJV+Ja1bSLgqhy5hlJCx3L9jBR7c/3FY2uky1p9eH018L73gwaHZYzAmV1w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 12:43:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:43:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 7/7] block: drop tighten_restrictions
Date: Fri,  6 Nov 2020 15:42:41 +0300
Message-Id: <20201106124241.16950-8-vsementsov@virtuozzo.com>
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
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:43:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c08917-393c-41cc-317e-08d882517fb1
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841923607BBF84FFD6BCD0DC1ED0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coGENhGuwTzVlCPceVsFaUHKo/hNDZf+nbTapjrbTSz1yS0zDjUirkRXdY7oQgKKJxIInVyWmjSwMMFeRwLY1H4R4bLbgTG9DfKJShFHFQLSi/vqZimpn6GMHujc7T8a83MOnxHhKH2M6ES0p9QWCRPxFFmRymaTGkhNda9YEvER13PjT5bTbYiJxE3S1acXq8CgmYfa5sSCAJO12LOk0moOU2cVwBY5fZ6ENQ4VduSMYZ3a3Wrx1YHbPDLezeWVQcTQHWXLK2Dk+bg021rBCnQADGmThlwS/bMnI7t7mTkRp1UxUA+3pLOjoZAZbK80VZu2DGmbGcDTq0HlM0PNYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(86362001)(66476007)(66946007)(6666004)(2906002)(8936002)(8676002)(30864003)(1076003)(66556008)(5660300002)(52116002)(83380400001)(4326008)(36756003)(6486002)(2616005)(316002)(16526019)(6506007)(26005)(186003)(6512007)(478600001)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8rtlzE8/4yyr35KTrssWE7GaRu6b2A1uEhRSNz+5jatPZyNGOC4G39NfRvn/egd1X2TzfL8kGOlu6TdYxVV2QxEkrsoJpiSxM5tzqu72eAo3He81uQYh3hlV3r+RAJKPhWR+tYmxp/EUqzLcdJy26w36bTPiQdCghhZqfeqkW16rYy2RJDFnmzW2b1PgTuwWQhpbCQY0yyqM3KkwtO+QhJJKbzIy7Y6eUXqKVBsua3uBxZ2PvGdBd02V4qv+vC8JxzygubELnpluUp+pcR7w4jzOLneQm9wdl0I371cao0rhsAn2wpdk15mcypGsiXTX1EfkhTKkprSJvG9bzpVY8rEpvgHri5vnkUaAhZqgNUe64B+Xs0IKt0zfEjqmW2maK3gBhXHD0ZrnsEc5pzv6jI2e0plmVMiYMmY6YLv5hIf8cDy/rOGQLDM+3VgZ0qY60NKQVZE2E27BYadHWpwQuYrTLTsNPr0SFMVpvFSgWqomMMaRQn/gHP0oFLX0uFEXRpN9svIlnIGDIBmXCIko6N0twO9/zMTjurvN+IrWw0upgEYytUCvmIaiZS52rrXXT6RKlyWX4rx90gRTj8U08Q5PeH5t+tcTNg5JgH6AHX0oKfDvFs7f6B9Rj/2ux/SL9Y4N2zbK3D1olKyI/8h8KQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c08917-393c-41cc-317e-08d882517fb1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:43:02.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tEdCU2W3B1f7uraIxzamb1vdv0I/tJoOyYvwsFIchmwAwDk+LVCCYZVVR2CM4MSLwDedmV8CjG5Bnhqudmlv4nCxx1d4JPvLHjnG0STOqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:57
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

The only users of this thing are:
 1. bdrv_child_try_set_perm, to ignore failures on loosen restrictions
 2. assertion in bdrv_replace_child
 3. assertion in bdrv_inactivate_recurse

Assertions are not enough reason for overcomplication the permission
update system. So, look at bdrv_child_try_set_perm.

We are interested in tighten_restrictions only on failure. But on
failure this field is not reliable: we may fail in the middle of
permission update, some nodes are not touched and we don't know should
their permissions be tighten or not. So, we rely on the fact that if we
loose restrictions on some node (or BdrvChild), we'll not tighten
restriction in the whole subtree as part of this update (assertions 2
and 3 rely on this fact as well). And, if we rely on this fact anyway,
we can just check it on top, and don't pass additional pointer through
the whole recursive infrastructure.

Note also, that further patches will fix real bugs in permission update
system, so now is good time to simplify it, as a help for further
refactorings.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 88 +++++++++++----------------------------------------------
 1 file changed, 17 insertions(+), 71 deletions(-)

diff --git a/block.c b/block.c
index b44db05d14..8437d579e0 100644
--- a/block.c
+++ b/block.c
@@ -1894,8 +1894,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
 
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children,
-                                 bool *tighten_restrictions, Error **errp);
+                                 GSList *ignore_children, Error **errp);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c);
 
@@ -1968,43 +1967,18 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
  * permissions of all its parents. This involves checking whether all necessary
  * permission changes to child nodes can be performed.
  *
- * Will set *tighten_restrictions to true if and only if new permissions have to
- * be taken or currently shared permissions are to be unshared.  Otherwise,
- * errors are not fatal as long as the caller accepts that the restrictions
- * remain tighter than they need to be.  The caller still has to abort the
- * transaction.
- * @tighten_restrictions cannot be used together with @q: When reopening, we may
- * encounter fatal errors even though no restrictions are to be tightened.  For
- * example, changing a node from RW to RO will fail if the WRITE permission is
- * to be kept.
- *
  * A call to this function must always be followed by a call to bdrv_set_perm()
  * or bdrv_abort_perm_update().
  */
 static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
                            uint64_t cumulative_perms,
                            uint64_t cumulative_shared_perms,
-                           GSList *ignore_children,
-                           bool *tighten_restrictions, Error **errp)
+                           GSList *ignore_children, Error **errp)
 {
     BlockDriver *drv = bs->drv;
     BdrvChild *c;
     int ret;
 
-    assert(!q || !tighten_restrictions);
-
-    if (tighten_restrictions) {
-        uint64_t current_perms, current_shared;
-        uint64_t added_perms, removed_shared_perms;
-
-        bdrv_get_cumulative_perm(bs, &current_perms, &current_shared);
-
-        added_perms = cumulative_perms & ~current_perms;
-        removed_shared_perms = current_shared & ~cumulative_shared_perms;
-
-        *tighten_restrictions = added_perms || removed_shared_perms;
-    }
-
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
         !bdrv_is_writable_after_reopen(bs, q))
@@ -2061,18 +2035,12 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bool child_tighten_restr;
 
         bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_children,
-                                    tighten_restrictions ? &child_tighten_restr
-                                                         : NULL,
                                     errp);
-        if (tighten_restrictions) {
-            *tighten_restrictions |= child_tighten_restr;
-        }
         if (ret < 0) {
             return ret;
         }
@@ -2195,22 +2163,18 @@ char *bdrv_perm_names(uint64_t perm)
  * set, the BdrvChild objects in this list are ignored in the calculations;
  * this allows checking permission updates for an existing reference.
  *
- * See bdrv_check_perm() for the semantics of @tighten_restrictions.
- *
  * Needs to be followed by a call to either bdrv_set_perm() or
  * bdrv_abort_perm_update(). */
 static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue *q,
                                   uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
                                   GSList *ignore_children,
-                                  bool *tighten_restrictions,
                                   Error **errp)
 {
     BdrvChild *c;
     uint64_t cumulative_perms = new_used_perm;
     uint64_t cumulative_shared_perms = new_shared_perm;
 
-    assert(!q || !tighten_restrictions);
 
     /* There is no reason why anyone couldn't tolerate write_unchanged */
     assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
@@ -2224,10 +2188,6 @@ static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue *q,
             char *user = bdrv_child_user_desc(c);
             char *perm_names = bdrv_perm_names(new_used_perm & ~c->shared_perm);
 
-            if (tighten_restrictions) {
-                *tighten_restrictions = true;
-            }
-
             error_setg(errp, "Conflicts with use by %s as '%s', which does not "
                              "allow '%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->bs));
@@ -2240,10 +2200,6 @@ static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue *q,
             char *user = bdrv_child_user_desc(c);
             char *perm_names = bdrv_perm_names(c->perm & ~new_shared_perm);
 
-            if (tighten_restrictions) {
-                *tighten_restrictions = true;
-            }
-
             error_setg(errp, "Conflicts with use by %s as '%s', which uses "
                              "'%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->bs));
@@ -2257,21 +2213,19 @@ static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue *q,
     }
 
     return bdrv_check_perm(bs, q, cumulative_perms, cumulative_shared_perms,
-                           ignore_children, tighten_restrictions, errp);
+                           ignore_children, errp);
 }
 
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children,
-                                 bool *tighten_restrictions, Error **errp)
+                                 GSList *ignore_children, Error **errp)
 {
     int ret;
 
     ignore_children = g_slist_prepend(g_slist_copy(ignore_children), c);
-    ret = bdrv_check_update_perm(c->bs, q, perm, shared, ignore_children,
-                                 tighten_restrictions, errp);
+    ret = bdrv_check_update_perm(c->bs, q, perm, shared, ignore_children, errp);
     g_slist_free(ignore_children);
 
     if (ret < 0) {
@@ -2312,14 +2266,13 @@ static void bdrv_child_abort_perm_update(BdrvChild *c)
     bdrv_abort_perm_update(c->bs);
 }
 
-static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
-                              Error **errp)
+static int bdrv_refresh_perms(BlockDriverState *bs, Error **errp)
 {
     int ret;
     uint64_t perm, shared_perm;
 
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
+    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(bs);
         return ret;
@@ -2334,13 +2287,12 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 {
     Error *local_err = NULL;
     int ret;
-    bool tighten_restrictions;
 
-    ret = bdrv_child_check_perm(c, NULL, perm, shared, NULL,
-                                &tighten_restrictions, &local_err);
+    ret = bdrv_child_check_perm(c, NULL, perm, shared, NULL, &local_err);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
-        if (tighten_restrictions) {
+        if ((perm & ~c->perm) || (c->shared_perm & ~shared)) {
+            /* tighten permissions */
             error_propagate(errp, local_err);
         } else {
             /*
@@ -2642,15 +2594,12 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
     }
 
     if (old_bs) {
-        bool tighten_restrictions;
-
         /*
          * Update permissions for old node. We're just taking a parent away, so
          * we're loosening restrictions. Errors of permission update are not
          * fatal in this case, ignore them.
          */
-        bdrv_refresh_perms(old_bs, &tighten_restrictions, NULL);
-        assert(tighten_restrictions == false);
+        bdrv_refresh_perms(old_bs, NULL);
 
         /* When the parent requiring a non-default AioContext is removed, the
          * node moves back to the main AioContext */
@@ -2680,8 +2629,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     Error *local_err = NULL;
     int ret;
 
-    ret = bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NULL, NULL,
-                                 errp);
+    ret = bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NULL, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(child_bs);
         bdrv_unref(child_bs);
@@ -3813,7 +3761,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state = &bs_entry->state;
         ret = bdrv_check_perm(state->bs, bs_queue, state->perm,
-                              state->shared_perm, NULL, NULL, errp);
+                              state->shared_perm, NULL, errp);
         if (ret < 0) {
             goto cleanup_perm;
         }
@@ -3825,7 +3773,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
                             bs_queue, state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret = bdrv_check_update_perm(state->new_backing_bs, NULL,
-                                         nperm, nshared, NULL, NULL, errp);
+                                         nperm, nshared, NULL, errp);
             if (ret < 0) {
                 goto cleanup_perm;
             }
@@ -4615,7 +4563,7 @@ static void bdrv_replace_node_common(BlockDriverState *from,
 
     /* Check whether the required permissions can be granted on @to, ignoring
      * all BdrvChild in @list so that they can't block themselves. */
-    ret = bdrv_check_update_perm(to, NULL, perm, shared, list, NULL, errp);
+    ret = bdrv_check_update_perm(to, NULL, perm, shared, list, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(to);
         goto out;
@@ -5795,7 +5743,7 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
      */
     if (bs->open_flags & BDRV_O_INACTIVE) {
         bs->open_flags &= ~BDRV_O_INACTIVE;
-        ret = bdrv_refresh_perms(bs, NULL, errp);
+        ret = bdrv_refresh_perms(bs, errp);
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             return ret;
@@ -5874,7 +5822,6 @@ static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
 static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
-    bool tighten_restrictions;
     int ret;
 
     if (!bs->drv) {
@@ -5913,8 +5860,7 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs)
      * We only tried to loosen restrictions, so errors are not fatal, ignore
      * them.
      */
-    bdrv_refresh_perms(bs, &tighten_restrictions, NULL);
-    assert(tighten_restrictions == false);
+    bdrv_refresh_perms(bs, NULL);
 
     /* Recursively inactivate children */
     QLIST_FOREACH(child, &bs->children, next) {
-- 
2.21.3


