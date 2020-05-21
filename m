Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA3E206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bcttCbiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA3E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtNv-0000lm-Ps
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLM-0003vt-F8; Thu, 21 May 2020 18:07:13 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLL-0007vC-Jn; Thu, 21 May 2020 18:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDucc2+fEsKmykredQOZHfbLOzUtn3LqWOUe/h8svWgqCoVAaj/gA1K8IAP939odaaODQFAqi6evQ+CixZ6+ZPQzzXu7cPrean5BzB2Annx2k0h67uJbVM+pf9kl/NQKqAcsDm0R5kjPINiQw1GEN0EgQTHrkwty9FVXeZiYK0s/czv7KsSt6QK9LvwG2abtFb2fUsHVOVMlZzuQjRVDq0bNUBw35xPz+ybqfR1aBue43qKoyFLN27aCMbDkX+0G6//L6HFGZrMiDShjl7iHLc49gY54CWlLkSgXxxw0KXk3UKPlrhZJd+OihSl8Y57oDY4mZ7dsGh53iZswG0te3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHP1moYfx+Izoo1zlpgDF/AE2vXuhq5vSzP8W+8q1cY=;
 b=KxRsATedAylr7THHMHf1cJCKT4jK2Q01eLcy598nmSXfqm8CCmzdyA6pT9BlzKqW19o8tH5VyKhrhd0Q7OIKB1onzGBePATx9/mjB7hGuUIEs4vUbZU5A/9/pLQ0PHjYz/DSP9NIFLySS5lzqIDA0GKshNUIVJDbvweb+9ZHPvFli5T7TLNFwmQWEL0qRMeVh4MN0OOYEa5+gGRD9PFp26+MBQEUZZkeWWRf6mD+9NG7k9Sdc9oPVQNTt8vArPFpteX/Itz0mrms1yz5fVjos9O7Ve0NwKV6VekaAw6urSRkvVTyegsdllGiN1aMMxUCuQX3H/9rZSuBCyAe9YuNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHP1moYfx+Izoo1zlpgDF/AE2vXuhq5vSzP8W+8q1cY=;
 b=bcttCbiGJzSQo+gciLMRyUIxYgdrNoexHReHu4jeo5UPfMmP4HDSeG7g222QaLv2SJPQfhoxc1pPcZh450qQDQSwgW44FHuSfAhpQWXdfAYnvDpqsc9mVxWPsxIjiwXQCypJiSgkdNrefMDwBcjC9K1qzoSK1dmIZX3TW8EepfI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/6] migration/block-dirty-bitmap: fix bitmaps pre-blockdev
 migration during mirror job
Date: Fri, 22 May 2020 01:06:45 +0300
Message-Id: <20200521220648.3255-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521220648.3255-1-vsementsov@virtuozzo.com>
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8864a877-3606-4437-b6d5-08d7fdd34b40
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55125E82BC91014E704144DBC1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKUMbWnnkTgUNV16HO9pRB42bf/2fKMa9GBlnbHCfm7XsMVrWnBkB5Q0alfxngUsRVrZr4zYbR1PiNdNLnYGAnnpwjLFLae9vneKD79eWEYcRMasSoXYzb5TjPsko71I+83iMaH4DcIo4+fhandRnWMFnCakxqX6h8GKqZV9bhBtf7vzfZeQtPhmqPDwd4lLNByMqcI/y4GdY2nFvxAMyNhwWBD8UjfcTkNxLWhIj2fMRQ/0UlpXk5Eg03uRJCVDX/B47arO4Oc4c+stFg4JJFsz3oklHY9aPqQ5LECV7QR3/318LFPwfBuTvXfSqucIbf3VfkrGKhOvFVEtk6Lc2kuaP9K/p5nBTWw3w66IlDLGABHcjhm3HFGHNARd9Ph33ZJmMvxL3eP4+AGj8DPyf4R4DhxrSRrpUob2wdZe3OJ06NEOzgQo4TtcUI492FWOR5WDQhiOG/AVFaye691BBrM0o24BHhpEYEVIgY0cIvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(966005)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4nFV8IiryvIOpLWHZ8hNn4yuzWggk80wYqiOOvLBgX26iolwLWCkmT31ZHFyXBYLDsdr1+BznrBuqB0iOTnU5WjhFlLTs26SER0n58jYYxxcusXPAMzYqcnZn9B8BG/LlOZswRO+e4OuKpLxoLmtXyFt4NMwUnC0QO8Zq/puRh/dTTkhxnjy3O+ozQGqN2+SnKAXGEe9dzMsUf6RXmbXt7icRzKX7Q2Qnbq8E0zI22L4IV+WpGv8W7zTc8tXuJpaRWckozLqb7zOMvUXgnUdct0lx6rSUH0KqcurkzdtWCojN40d3twNg95S//obbA66lydD8jETSRj38stlAdUlJLSWBP8thqC1/iNEhYe7LWUSg2ZdmfoZRvVY0Hk6nx3Wh9LkXzR1vOVcSUeSCBZRuPRCGhUb10G2YA0JCxt6YY8mmyGWkIVUFMMCLR1SolNlh+UqKoRlf4xoEgB4Lv3hPgZ83JZc7xU9dGHe7W4CIi8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8864a877-3606-4437-b6d5-08d7fdd34b40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:03.9898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PbxrgoxA3ewGEe0ITg0bsxx8o5RraXUuH+ll/VUswHS6i6bjAPZPDAoVyXHhLgksGZ7buIRFxIgZn4AGWonx8bHLqUDJ6iF0NIlUvXqpM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Important thing for bitmap migration is to select destination block
node to obtain the migrated bitmap.

Prepatch, on source we use bdrv_get_device_or_node_name() to identify
the node, and on target we do bdrv_lookup_bs.
bdrv_get_device_or_node_name() returns blk name only for direct
children of blk. So, bitmaps of direct children of blks are migrated by
blk name and others - by node name.

Old libvirt is unprepared to bitmap migration by node-name,
node-names are mostly auto-generated. So actually only migration by blk
name works for it.

Newer libvirt will use new interface (which will be added soon) to
specify node-mapping for bitmaps migration explicitly. Still, let's
improve the current behavior a bit.

Now, consider classic libvirt migrations assisted by mirror block job:
mirror block job inserts filter, so our source is not a direct child of
blk, and bitmaps are migrated by node-names. And this just doesn't work
with auto-generated node names.

Let's fix it by using blk-name even if some implicit filters are
inserted.

Note2: we, of course, can't skip filters and use blk name to migrate
bitmaps in filtered node by blk name for this blk if these filters have
named bitmaps which should be migrated.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 45 +++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7e93718086..04a5525fd1 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -319,14 +319,54 @@ static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
     DirtyBitmapMigBitmapState *dbms;
+    GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
+    BlockBackend *blk;
 
     dirty_bitmap_mig_state.bulk_completed = false;
     dirty_bitmap_mig_state.prev_bs = NULL;
     dirty_bitmap_mig_state.prev_bitmap = NULL;
     dirty_bitmap_mig_state.no_bitmaps = false;
 
+    /*
+     * Use blockdevice name for direct (or filtered) children of named block
+     * backends.
+     */
+    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+        const char *name = blk_name(blk);
+
+        if (!name || strcmp(name, "") == 0) {
+            continue;
+        }
+
+        bs = blk_bs(blk);
+
+        /* Skip filters without bitmaos */
+        while (bs && bs->drv && bs->drv->is_filter &&
+               !bdrv_has_named_bitmaps(bs))
+        {
+            if (bs->backing) {
+                bs = bs->backing->bs;
+            } else if (bs->file) {
+                bs = bs->file->bs;
+            } else {
+                bs = NULL;
+            }
+        }
+
+        if (bs && bs->drv && !bs->drv->is_filter) {
+            if (add_bitmaps_to_list(bs, name)) {
+                goto fail;
+            }
+            g_hash_table_add(handled_by_blk, bs);
+        }
+    }
+
     for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+        if (g_hash_table_contains(handled_by_blk, bs)) {
+            continue;
+        }
+
+        if (add_bitmaps_to_list(bs, bdrv_get_node_name(bs))) {
             goto fail;
         }
     }
@@ -340,9 +380,12 @@ static int init_dirty_bitmap_migration(void)
         dirty_bitmap_mig_state.no_bitmaps = true;
     }
 
+    g_hash_table_destroy(handled_by_blk);
+
     return 0;
 
 fail:
+    g_hash_table_destroy(handled_by_blk);
     dirty_bitmap_mig_cleanup();
 
     return -1;
-- 
2.21.0


