Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F91C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F354A20704
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vydjqlLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F354A20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTNB-0000Gt-RC
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGF-0002wj-0w; Fri, 16 Oct 2020 13:11:23 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:3705 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGB-0007Mv-C9; Fri, 16 Oct 2020 13:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRBgv3VpwbIJiCz6LF/y6gXoh3mCp0icyHEaIBG8oUm0Z1iFdqWFW04XLLxm6PkWb9uLp6TdO0UA7kRt9hnHl4TmldlUsb8hcaEbVJT3bEu9s3FfQqLFZWnACOcyBKOfLr/dRhcwZ9vWMHqoGaKNynwqKS9VudYWFFNYUH0anROqC5fgH8/j/b+w/yhpHl1ghfIhtOvSIF784ZfrDaS6T56nKY04OG/OAeV0CxfcRu0NDdqbUAXpdcqXRA+9TiMzmDUg5Iox+WmUnQBX+u79CyQmNF0Rs+VE7GawKoK7zkCN5xWqR4lFovgQpnddDXcfOt8C1psPZJsw6JOkXINKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZeJ9aqfbnksR5A71HLwH40SP7lveldaKoOlQBbR+2c=;
 b=Ktk+sQUm48N2TI2bbVvJVZkQ+vvSDnXgNBSPHOQnv7+VdJjae0NZjoUOKCwQwk2LEWcxueEzLW8USsGFoi7IU6Dw8txvfKdMj3KikuiEketSvg9anYJQFgYYxzv0pDXW8g19DV5wCIIZKn7d6VxVkQ/QArB6Cq6VBNmyjwgDl8e+ynAMoTinOlXJ1k76VK8y5JkMWgTkpTSh+AkkKKpATOPvdBBOwXJIAUaB0LnWfpFJKshCGgpheYeT5m/kOY8pVvveH/b4uEUy6XR5SzH5kXyGQDLrL00BP/f92bLgbqxjRCrW5xu8uLZ91tb40fEuKjvqanPUECyYbwL3aoMxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZeJ9aqfbnksR5A71HLwH40SP7lveldaKoOlQBbR+2c=;
 b=vydjqlLmWlgwY33EG859lmwpDwp16kJEpaMLREiAQqX4MDc6HbgN8TmYw0IegPx52ptmFBq3MIgRKx6i6ipFjG+udjJhJioRxuds7RcgGNc1j5Uw/7DaCJh1Df6ZDD5zUvEdDE5WI8UpuhAJBm+ubTtEqU7yIKrPRd0Ybi5x9x8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:11:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 01/13] block: return status from bdrv_append and friends
Date: Fri, 16 Oct 2020 20:10:45 +0300
Message-Id: <20201016171057.6182-2-vsementsov@virtuozzo.com>
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
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de8c316-0f2d-43ad-df6f-08d871f67ba0
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB197213FD04040699DCB30651C1030@AM5PR0801MB1972.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPEVsqH2sFTEqf61xTbUeOTNhNC77YT9rkg93nc3ddNuo040e9YgueQHIBe9jUsARfjje6Hj2a6N1e+gpb6eVedkumbanr5heW01lMpq2Jy5Z3q1SKm7x3OoF1ca4tQlbjLmTqcWuZ8I4FDlJTDOQ3FPCcCc2CXtFjtIGS71GHE3WS8Y5TEulxH6slCE8EDY9JTYLsqAmZJuuuYeJRCPa/Z1boFdHRFXmEt1MvbO8Pqb9ec8ycIbSWENdoF0OxDyfV2H2GpN99nc+r3D4OcmPqB0KkRE3dIeBrVJNw59yIBLd+i7Yz7NIFtZ/QEaelvgo+hF+MT/aqMEAQ0LRBHQ0isNtXFiKwHN/iFIUL/rKoebVDzvt0Zb5TgzHhJJz1Sz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(366004)(346002)(376002)(136003)(83380400001)(8676002)(8936002)(6666004)(316002)(6486002)(36756003)(956004)(1076003)(5660300002)(6512007)(86362001)(2616005)(52116002)(34490700002)(66946007)(2906002)(66556008)(66476007)(4326008)(186003)(478600001)(7416002)(26005)(6506007)(16526019)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LqJypZDVCVv6xC7QOq2fthu4k12wwTI8oSy+t1SmugTaUKaoPvJTWg+VSrszfbZPQIDjf8lfoQB05sg425Go3PRAM/dpheUNMls/Pm+/8gU7tBtoad9LMq9IShhhdcg+B9mtwqu07M85nttnLEemnW8HyQn8o0D+IVeJDSlUUJgCL+bvMd3paK5t9BD0M+g/FvxwTWCsigocRE5vyWbI5fFaC9c5f8sLJgeh5IdERt4MT/n4tymui6xV35sH3Sr3GIxBhUqTrSVwGstTnig6lokuC9SLHWKjjzqAKO6k0ScEdACEJsw5uws0h3+Nm8I/X8y6g65LKlt26TbBh8PcIXl4KeBSVxYUVLHN+4TSQgXQoDGZC7zgKeoh/Xy9q6QrR1RGJ014H8s6Ap8Td1SLRtzrS5BWoRI2+i2PlizDEhuBfB8+Bli6065Lwm/VxM5y/DEjYljtspX0CR/SW8l2OaekZppV52w9B8s5lAihPhcfvSmNow/404PN0HimC+Oz2NFGuYvWBwXQMGO3o1rsVanziX2nGY4uzpi1GbgmvP4bl3bThC4kUSbLKsoM5iIt1AbX1JGKNBT08sfyXJa0yCASmIGUt+JqU5GSmwXI0LS37UW2fwzb3jIDsY+XZRfe1EALe7seSKA8Mktua4VnLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de8c316-0f2d-43ad-df6f-08d871f67ba0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:12.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gg3zGx2XbzlyQ19L6f1B5tw35bvq6+CkLxBZzANPUVSI+Go/mJy5R2bbtaRurgyn/XK2tPEhzuHnmc0m/qhBap9Db+MiFFtn0Sr4eOodynM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Received-SPF: pass client-ip=40.107.0.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:12
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
index 430edf79bb..b05fbff42d 100644
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
+    int ret = 0;
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
     if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
-        return;
+        return -EPERM;
     }
 
     if (backing_hd) {
@@ -2896,15 +2897,22 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
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
@@ -4554,8 +4562,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4577,6 +4585,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
             continue;
         }
         if (c->frozen) {
+            ret = -EPERM;
             error_setg(errp, "Cannot change '%s' link to '%s'",
                        c->name, from->node_name);
             goto out;
@@ -4612,6 +4621,8 @@ out:
     g_slist_free(list);
     bdrv_drained_end(from);
     bdrv_unref(from);
+
+    return ret;
 }
 
 /*
@@ -4630,20 +4641,16 @@ out:
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
@@ -4652,6 +4659,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
      * additional reference any more. */
 out:
     bdrv_unref(bs_new);
+
+    return ret;
 }
 
 static void bdrv_delete(BlockDriverState *bs)
-- 
2.21.3


