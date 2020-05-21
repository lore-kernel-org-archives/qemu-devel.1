Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B672C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600BD206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FWV0QOAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600BD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtMW-0005xd-JS
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLK-0003t1-4s; Thu, 21 May 2020 18:07:10 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLJ-0007vC-7o; Thu, 21 May 2020 18:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyvRcgXSfYllDkRkpmu+P0JEZKe92+UKJgV3vE8qNNvYzrZnmUdEBq9HJf+70WLApE5wSRJ5e1hbfKa/mE0ZiXelcI6UubfgKn5hJDScz+6MyHG85w8xdOrxLBCTrYCLADxa3xbH71tV1gZhHSbxE4Nsys+JOFis8xWSYNsj8BD3w/FKchO5hxLYJ0SDKU0DnGS6WG2Gc1Iq45xk4Sjd50H32hGrbXXxB4tlZ5wKxpDTB9RrY6c7cUXdpxX82CnNSWj1ZlgP22D9ZLOa7RdwbHmDiPM4tbHBTnB8I9vV42n1WGun5pfTTBPY9+kGGQMYmSWfC9cdF4cVtviVCfSQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVYcnaT6dR52w62/tGifxQOIl8agZQNiTMO0y90ZWQI=;
 b=OmElxXHGdHJYjvooe+P8e4GeIWCBpAN86rnk5TdZpsEkLn05Vxti4h37+vUrlJuASANBVmkbqFKdjdn3McVVxHrZjPpHj4Mf5oyuLtmThYC009DnUgBwZg9pbHED4WDsRRFR/Kru76OMGOtBBSHip8lBFoI6yAobye98Qb7AmdE5FKCdtfOrZ3c4SrJ/sWZtcdLzh9r28mHzzEkgO7m4AwiZBohNLe3g+PtDUigw3fBdMtO83DIvskQ1orvbmdMim87FgOf3u+Rg6jtp2Bhud/EJnUhvZ+5Ph4n+9ymfgQ983YUrjPlyVRbJDuJ3ZuNUZTItzRm6BZ8FbaJUiBqCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVYcnaT6dR52w62/tGifxQOIl8agZQNiTMO0y90ZWQI=;
 b=FWV0QOATjn3suJ6Ah3MTJHKyOEQwe5R1OBI0bbQpTvSGyisQY0U9YQ2ZLnR97I1ooEGr32igsFBSEOiCVXvczk5NA4dxb9jkj3M8aziMTgbDiRDnfnowB3K1W9Y3FB68fQ9bWidpCr/xzycIwkKrvLc7QgECztaA4zffw38lKBY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/6] block/dirty-bitmap: add bdrv_has_named_bitmaps helper
Date: Fri, 22 May 2020 01:06:44 +0300
Message-Id: <20200521220648.3255-3-vsementsov@virtuozzo.com>
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
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:02 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a3878a-59f2-49f5-c7bd-08d7fdd34aaf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512075EA03A6D8DAE24167BC1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:18;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3m0+zP5f+vMPk7XMXtv44jxANYE4XHWi3WmfRmF44byzUA7Hzd9Z0ZXoTFW0Yxw06rwsw0LTrG6/NIkTixg9ol9rpcDAh5vVk5GgoiNH/D1QHC20j2I0MWfQ5olI8oYElq4ic2B+jH/WA5pRYKbcqJdCK7XYFr3EVM+9nXVsnswMLwppFmWeIPhBJhpDRhruX1E/jSIhB4yXv5ikDpBGjSJMgABN1AwP7BuBlgEMHv02oK09OsaZIQFlzVHnoFG+bw90uytU4KP781xa4C+lIiisD9EwErl8TtkYfh64gtgeWOFtatpZFgcDG5BSaaoUnbrUfX9TlkN7rfXhED2I74NTfdr6T7eoXxImn0e7V6OoCbU4cJmXfqeAy1iHZctDYuUUyGpR8JSMrOoK4rLEQnSZEVoHBDd0xPzeFFmc++A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AgVk5susrOoKjdVzQY0n7a19OKzr/gY706WPnujjLMHOivW/TUx4PjiadbzoM8BSys8/DMlqgHIWhXhDrgu7asOa+KTHmZRyeuRsnKgDwiiLzulz1Yo7z8u/8AfOZiFlvOS1HkVb1L9XoGyFYttYgcxtR+2+dgUCVn4Q0uz7OhSQ47JHerh1pvlN1AMhZxwbTsijF2WL89IvtbyufdlBlJUfRfk1XSkSYNcRlKbT3GOEDsVK/UZwueQpBFKb6LHWT+HD0yuMTV5d/xa6AG4LEafvAA/2iWT9em5iE4+DphaSNknf4eYXqRqpubEnXZgIEm0eT86KaPk3Ae+BkvDL+sMjWRNnoWtNfvrgB5sBzEXUVQfdEIKhG/6hQSmR6eAefaPdJh/R3OEpimIaML13+BCVnQ8/FgjX5DxXSz78rV8+drnCDKrJj0LXMJd/oZEhafQx673Ksq8wBICK6vTrVkryFxDBGXGt/1ztc8iinVc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a3878a-59f2-49f5-c7bd-08d7fdd34aaf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:03.0429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY/o+kjyr1sHsuFKXSNdZ9WdGJ9TyejYkdkvfx1GO/LGusA9dii40dmU+F1z7DdDQWh9pdZcJrdMyvNfIPjUttqcJmxpl7yJ9WWoz53F4MA=
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
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be used for bitmap migration in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/dirty-bitmap.h |  1 +
 block/dirty-bitmap.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 5a8d52e4de..36e8da4fc2 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -95,6 +95,7 @@ int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
+bool bdrv_has_named_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index f9bfc77985..c01319b188 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -818,6 +818,19 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
     return false;
 }
 
+bool bdrv_has_named_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bdrv_dirty_bitmap_name(bm)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool persistent)
 {
-- 
2.21.0


