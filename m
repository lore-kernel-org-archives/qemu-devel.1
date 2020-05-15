Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E97C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1161A2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DJrGsh8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1161A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZfm-0004t3-8E
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe9-0002JC-Lk; Fri, 15 May 2020 08:41:01 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe8-0008VJ-NB; Fri, 15 May 2020 08:41:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG5rfqtWFwh+zLMNNPhW2dyWQmAX7mvNKAbdXqWAC8n0GM+yxyC/yNDuMdTb6xYfAWNIc+9e0PWKMNualHmIN0tOgsEbO81RJE3IcZE4EcpUHpYHePwzmX7A47NdUrgm0oAB1pQzRDPfjigOlWovovjLZZU4W0rvWKAmgjN2tio3vUpDQEzjyl4P8vum3tyK0/TKznW0PMzPKvBbW5rTBgwGFyUepCDe4u3LE5Ni1d14wQg2ykOCrH2MfVCtzBX2LJ5GuhPhmYudqpmsATL4SlJDXtsny5N6iMPgRNlEDFgbe0Wkl34NWzZA/UHIlfNJiBV9R6pi1DPKzPv+EDE8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmc/XpWgSeGM+jz+wZTMIXDkI4JbzA56RY4ag+n3NG8=;
 b=DZoLJTWkHuMj68EZG5rnMlUPu4icSpIXxzYkZ2hb0AH8+F+9ueCKX+AA1Ul5F3rJkBjD0NiWKBXGZlHC/i/tOPmzCe0eDPaKWpvwK1+xvE1DnlwJ833SvWRxG8Jg7w5TsANeebVyQcTNOpfbiLOPgZu7v808RxSmZQ0Onmb2N0VVGAGD5ZLRp+5MgMUxWooDGsZSN1vY/7CwkDeDbQtl8O68RNEGYg41SsqH+qu0qYD+d/+iue1FM9nrsfdweP/D1IikasK/CwcmUTDkSjtSKgnY6VgNsY/TxU0Vx1UdqzFH1XRrmw87ihKuOYvTSmFLFQHYaQDPzJd3vlKbdG6+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmc/XpWgSeGM+jz+wZTMIXDkI4JbzA56RY4ag+n3NG8=;
 b=DJrGsh8S9l96Dm+HkFjqFbkoOGgMA7SxuSZF267x52DKqzBa4mh2dy9SsLmjW2ZNN3N8ALy2mNsLX/RGJtRPv19J3eKOsEjHFtL0dSlwDtFzOidpTDBacwZc+fNkKoDHF+w8tSSdnEOh7zIQRM5U0uhCVa9dIotoV3s2hmod/Ok=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/7] migration/block-dirty-bitmap: fix bitmaps pre-blockdev
 migration during mirror job
Date: Fri, 15 May 2020 15:40:21 +0300
Message-Id: <20200515124024.3491-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a8ec2d-ce50-4bff-dc42-08d7f8cd35fb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53819899C9C3C55FE49A89DEC1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWq/8mbXRXBnfV5qVB/GtWeL7sm+jlqcnwdo10rTCyqtdbIjrGAqoEy2yatUR2h+cZhnrfCaowzEp1VT2lth/WHjITLpWQrK+SLnMpEbrckEAhQwpsZRfMlYVC/Lja4tZDPhPiOYFLjp3tK2JR7xo1sUPwAFyNxd3dXe+XelguIqy5gVmsYOB26ozqbCFQIetKInvlggvVCQs7RSo06tiQeNBVFK3skMS0Xz7daccJ7VlEuUpD2Tcc4uKyXJd50XkOYECHfjKPrnqeTMau/xltv3l+uVaOnuVHBXO4+sZM65dhKthugEtWjvZu7E8iUQza5e/wGeTFTiKy6p50dHs87U7hv8OVFhI3Q7HWEKpsvWs4zWiz8y3B+8scic9esRySsPhvAhhHFc4Z6z6vDm35K/pukGExYEjgs7FbKm6i4vn+iByf/sImMVTVpgOhswO8b/9sJw0tyTbnMjnYk0SjRIWLz5eOg//jq+JRH5j4Qg8pGsxjXlHfv/4VnPgUrWDB/E3Gf/QN6CHrcR9PJcBzXKDrYhB4dkkLRmcqHUH061P9mZPO8kdAqDCxmy3Q4i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(966005)(6512007)(4326008)(316002)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: is1iqEDcgcdldWI/OKNWrGtI6YJOEf/tVSvQYpPbwulnf8Ts+TKslUBES/LrSSltCzNLjx2HxlrblQqH+ojnKLCPH7PH1Hr+I4ZnvRyGR1wXW9JRbc1QpPoAKO3KCOfXAuZOcyIWo5H9y0hOollqTCyYFqyf1x0TgxOksEH0BHzRtBka2ZWsYZ+68gJZTMvfwZmkAOfniiX+OGGnGIv0fKjVIsXZjgVnvkaLKTxG6PgfPMKZcdncJ7N0KMwk4Pbk1HWfSwd5KpWa84Z42OOVgY7Cy8nVY1ILnThYJsAPMcGpvQV2x4VLgyD6+5tWKBJKYphucbCUfP3b7HMEdLR+2ZapdntjF2excQr4yAFW092r1pU42eiMIaxRLuZ2+apTo+7VcpBMko+R35MrDkg8s9QZr0V8BWKSieeT0D9bbevLUtoY3Ss5D9sOa/+Op8eQwwfDHwgHUlUCkKn+wIKedO65FGEGyg1Tf+CkoEgrMBw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a8ec2d-ce50-4bff-dc42-08d7f8cd35fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:55.5290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8TQsqBNgbNz6UUQLFo1IquRzoX+vm2YZ++5xGFszKRbcsnVcbI5y3EnU6nYvpntpZUgZNTpjioMsyf9CBLihlZMudVQas8kvjT0rfNFKXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
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
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
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
blk, and bitmaps are migrated by node-names. And this just don't work
with auto-generated node names

Let's fix it by allowing use blk-name even if some implicit filters are
inserted.

Note2: we, of course, can't skip filters and use blk name to migrate
bitmaps in filtered node by blk name for this blk if these filters have
named bitmaps which should be migrated.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7e93718086..5d3a7d2b07 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -319,14 +319,48 @@ static int init_dirty_bitmap_migration(void)
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
+            bs = bs->backing->bs ?: bs->file->bs;
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
@@ -340,9 +374,12 @@ static int init_dirty_bitmap_migration(void)
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


