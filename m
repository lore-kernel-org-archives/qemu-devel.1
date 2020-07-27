Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E747C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C188206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wrfZfp0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C188206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0950-0008Jn-Kt
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091q-0002Dj-4a; Mon, 27 Jul 2020 15:43:18 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091m-0003fa-Rw; Mon, 27 Jul 2020 15:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYUxhiMpX9hIpi16wPGDDhy2j+cgIg89hlAUssXTzRetrmEcFjZdP/k+ZiO3QKb/xT1tByKJs4HuBAqCLfT9uzRhoTvO5zKY5/6F9zFcfWxkaVJXA35DnAlmeLR46TjZ50iOaMjHYY1o6O8U2097553bqrD4ZEjT/4dQUA7RCvtvoQV2Z+9JKv6zEfBGolTM+frJKOFPX9+DRTVbuFyPTQ1kt7yown9hcR39os3aHKWAt97zv/WMP8WS/0GrhRT2SD2SJ+GxAqRNX5IBp6XRlN5pJ7/bG3n11auQ518we2H8jKRJw4KKVdRumCsEYLrhio+YYHWS2Kr86CS4TbTnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phxw50qpVKCNupFSp+SUZm4+sy/Cji3YickqluvKk0o=;
 b=I086L2zdSAvWu9li2e2QtpsZPoFZtlxm7D+ZwUf5CmcKlqXI12BvWYEupD6pIJ52zi0ZMu+tLad0W6KefNA+w3njpLHyplVOumzd50dGpNKeY2lCrRoDYCC65NsItMECDLr/4UZky3n1abERdJ0DTkfL8HlOv3Bt8TtW5pk15oxfVZYWul8IJmWKxYPZXl0XfybIt2Q4MC4k0dTZEKRJbbuAWP7fPWPaVXtYThB3O4uvUgwaJPTt2qykdV1kfmPW6o+1JMlVqaVHshEyDI5mkwj/7bDgnqfq1tn9bOlAeZcUFSalM0shw0yU5jP8iMqX7y4IP7qTE9QvGIc0fNKkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phxw50qpVKCNupFSp+SUZm4+sy/Cji3YickqluvKk0o=;
 b=wrfZfp0M4EHiuYLAVBE7Rpc4N+tepyKkn+R3VHrZfJRExz9V+V2aoYaYhvN4Y/U3CkXYmO4eyGFweq8hj9wc7SUV24CC6PnKxac6pjPY3PxKxJwQBr1tx7HTospRq+JTYegvQvnDz2gjcNSAF961+chegLZvSMRwh6JxaAt2+OI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 13/21] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
Date: Mon, 27 Jul 2020 22:42:28 +0300
Message-Id: <20200727194236.19551-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:43:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4710d29-ea66-46a3-db36-08d83265464f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26108949573092CBEC55B6E2C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un+ZqWnkOP38rt6f9WFP/RitsEvCwMQMVoMaJp9vRkcEQhTKdKGUlzh1AxvtGks72qcmYEoFgiDhAp4ULoPHKPBClDVP4W6NMeqkNYXTt4KQur4zXJrdQ4qIaMpXuEOu8SUCwS/SWPYwcAblYAx/0DmZ1oBt6q/qzvv9QvEpb2Fnku1kEirSza7MDNL1Vg6O236aeJlLtC4DUTYxxVf2IXezcpXPnDMpFMWAASfq1fseaoXeu2G6kjWqouNLVrp56llenIsdmLLXI0UiTpJZEyJEOqGby6QxnPO3Kce6jreY+L3ZO7db9cpMYC7dcU+CGxax57pEyYlSjxuCbhoymLI8ljUN2dgBLQYIm3kEqEAyNbuEpDws6GeKg6kPZRGa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D0v6ZtAF/ScOCcp/r8PD4dMk+cI/9UnHauzM9Dam4uu1FcshPjB4iz0SspbrofSGt75MgapiPygYUboItKn9Knmu3RFYJKWAFmHPY/OdcNwWc0mq37kMcFiThw+N5ER7d2kM6kQDmFZj1GA8pKN8UU+PFphUZbzfayzU+FceLZ3p/xvtD/JCR3u6NWHPXmFPzcULfUVsPsEuL8Q5kRH2CMdSqy1RgdbFS1whn9dOpyx4jiKfiDcdJH2jmFq3zwixJW9IhmCUna0EEDgEhrDr4k1vriK9dZ0gyBQf7cbMOUvTb2VJXKMbzmo0D5GgYB9Z2+rm/LWsnvPgmy6qpP7WVNfwDd/8XayC7gGN+CJHHoBA2BWVkI1I9rQVqbpBODaE2nLUc27vdJCEqGWiSqjKRY90PMkvsFEyT7NjRsRY1Jy3fViZjxXb/pzYu7NlRuOOCR1lo5G7by5DwR1X5zOf2JdGxQkJUYnGGqXJIeXbaXI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4710d29-ea66-46a3-db36-08d83265464f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:02.7610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa1C1roEZYS1Fr/DrVZ2lvB1MYBxSYce3qxXqF4nFjmflMjecU0JMEc7uZ87j6K0izePO7e3XF8vO74igJ06t3sDUvUF6GD7P6v3QFr8qCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
postcopy, bitmap successor must be enabled, and reclaim operation will
enable the bitmap.

So, actually we need just call _reclaim_ in both if branches, and
making differences only to add an assertion seems not really good. The
logic becomes simple: on load complete we do reclaim and that's all.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 9194807b54..405a259296 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -603,6 +603,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 
     qemu_mutex_lock(&s->lock);
 
+    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
+        bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
+    }
+
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
 
@@ -612,27 +616,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         }
     }
 
-    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
-        bdrv_dirty_bitmap_lock(s->bitmap);
-        if (s->enabled_bitmaps == NULL) {
-            /* in postcopy */
-            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
-            bdrv_enable_dirty_bitmap_locked(s->bitmap);
-        } else {
-            /* target not started, successor must be empty */
-            int64_t count = bdrv_get_dirty_count(s->bitmap);
-            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
-                                                                    NULL);
-            /* bdrv_reclaim_dirty_bitmap can fail only on no successor (it
-             * must be) or on merge fail, but merge can't fail when second
-             * bitmap is empty
-             */
-            assert(ret == s->bitmap &&
-                   count == bdrv_get_dirty_count(s->bitmap));
-        }
-        bdrv_dirty_bitmap_unlock(s->bitmap);
-    }
-
     qemu_mutex_unlock(&s->lock);
 }
 
-- 
2.21.0


