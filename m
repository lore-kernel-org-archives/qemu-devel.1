Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4416C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D62C2223C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jF9pw3d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D62C2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Jq-0006xJ-3Z
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69P-00080u-13; Mon, 26 Oct 2020 13:19:19 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69G-0008Ou-ST; Mon, 26 Oct 2020 13:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvZyWWvGahJ/MRxYfAYJCgqcTfKQ/Sc3PAUogSjS0fuHitX5k/9edHXGH2VLsXnSkU9o01CbKT4HKWUL/DlvSdSikbDmTeb/MCvlYS889sfMJF4xZ8cYZSveNUIIBdjnReAirYGurpByvXcMsnjNUSddaYWDUl8y6gU7wyLQNqjIJ8nKIvc4STrqbSiTrXUonANw0YDTB5QfiXK7dNhemQE/eyagH8/w0VNwREXzr4++C+TWAwLIZjLDGC9Pk8qlJj487ZZ+Vb5zXpTgsh5KflKHfB/UAmJV3QN7w2xWbfUKyncWfHmnbIIN0DBQLFPXxp/CzVeOFX1IEeK3tnhJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05VfiCAIisBWwUOiiPtu1hQOg6OwuNa47Gse7SUo+gw=;
 b=Z7mU/VYUmZes0RyPbwlG63HMAX7AhbufTfEDKCKYL5ZDn0uEswcMkryj/2/KYNWjkKKMkL7t2YxHRu2JSvaLkWkerGZmq0S1zuKUlpHHAZ7A8oOY/PwiNVODGEa7qp3lvD/66kXeOqJLNnK3ZkVm9xtnUlu46tqE3QN+n8PCtQ7UkFfnyHRihZvYdldZpuBBbVJBpo4Zte7Z8MISZVrbhDO9snFiyerAg7i3DQ0xvrVxRYee34qoUJVqbN9vTHKTwxemBuACyB5wlehKaWyl5L3OaFbYakFK3Ekf3CAX8TyfWNK2dhWjnv8wq3vpNTCXe+sDx8s+kbu5lfgefPM54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05VfiCAIisBWwUOiiPtu1hQOg6OwuNa47Gse7SUo+gw=;
 b=jF9pw3d5EFoeEUgy4Vo0bfeNf71neT6N2KmP0RMZHHv/yVw5eRogZl0cefCCE14226Klv5slkIE+wO0nx+nUiGnfSkEkj5JdHkATJDJ4mB26PBwtgzcY3GgSNu90+vrU5NUajKt6H3iCH5sGkWT3SU80gNm83u+cS3Tl+bJJfCs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 22/25] block/block-copy: drop unused argument of
 block_copy()
Date: Mon, 26 Oct 2020 20:18:12 +0300
Message-Id: <20201026171815.13233-23-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17dccc14-4bcc-4467-ea08-08d879d3343b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303252DB8D594141C03104FFC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:30;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tkf1F7hB1I9623XQrHwuG72Fc+bZ750GSljDgZJkSV2N4t2Q5Ezh32g3oPEHFNNjdgm0zHKooYo2oUv/MGUTL0YwrlVHD3SdKrI+E8pcQVmdQKBhULgOSoabqSqogMiSs0kb/Oi4/tnqgPZDvkoaUn1P/r9DD2+onQLxUs2DwEGWH5xdmT0kiGLpnlVmDBgarPTGQn0aZpKRsHABDF7MnjHvha3v8dBJ1UbTs/rm0wEt22D3BTEFeRtPodJugUkFwWdO35XyUizfhlOK89OhxEwQBkPlOuHec+YCf8FZANFZmYGb0PyCPJ8TazmyQe1Uy6V8gvhnshSkVEoaApGJzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CIWxn/1v+ZUPCQdibe9PdnPiLcMuhboh7OouYc+FJPB0s2J/Nui2yxcGUANauBTgOpVAYIfy4i9Lv41Ng/GF+7xC7XqBd9+eKxu335sVRNtn7dd37obXWc0zpu5Sa5bCVY2E9f3p4uN5l7ZlEBZeoKmzU6p5a8mBF6HhBKv6vsr1ajwjcZyX1rd90bvDintde+ASZ6vCm17VU6Liyw/yKGoyolsglbaiv3lS52s+xLCBv+SI7DSNnVvOJb3YbhccHs+d1E/L7l1qcXg6gc9TzRtezygpxjEdDXLWFVVHhPb24sKJHpFfAxPoItrp74GdjAMHjwfN/c12TtW11oRoAZ5IrEz8RPTv4S5rsIXE+rlAlWGskY+aJJfw0WXFAg3BoR5XPbw1JYxpKWWikZGL4I4WvOPAywa9k3I6ESIuvORbcEDL2dfd0Gd+/CAE7cXhsVVH+3tcbMkgi27ciELaQajB9SBFRKict7D3TP69ua5YFFL12RergJ8vsomyUB2LdNteBC5iA1szsoIO2Qf3+NytidIh06u6QpUIOgRraY5XS7cxzoYy93U7WA2XebMS+KVF4xW9FMGMiJynXkew6QPdHuOPefTtKZ2K3Cme7kSC6GSjJGrjYh+m9rs3qHuGrV/uyCxW/L2tWl397TZJqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dccc14-4bcc-4467-ea08-08d879d3343b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:49.6149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1ZetEn3kYJInn72x8iXkkbqWXeqPu7yTD0J4pZI6yNeub61eGDqCi3xx8vB7nDB1t3y+kfo8SEkO9OBI7mjdMLiq1wCsdbEI2yU/gNAohg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h |  2 +-
 block/backup-top.c         |  2 +-
 block/block-copy.c         | 10 ++--------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 7b77abf70b..f731dbd573 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -35,7 +35,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
-                            bool ignore_ratelimit, bool *error_is_read);
+                            bool ignore_ratelimit);
 
 /*
  * Run block-copy in a coroutine, create corresponding BlockCopyCallState
diff --git a/block/backup-top.c b/block/backup-top.c
index 779956ddc2..6e7e7bf340 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -61,7 +61,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
     off = QEMU_ALIGN_DOWN(offset, s->cluster_size);
     end = QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
 
-    return block_copy(s->bcs, off, end - off, true, NULL);
+    return block_copy(s->bcs, off, end - off, true);
 }
 
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
diff --git a/block/block-copy.c b/block/block-copy.c
index 2ea8b28684..39ae481c8b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -723,7 +723,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 }
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
-                            bool ignore_ratelimit, bool *error_is_read)
+                            bool ignore_ratelimit)
 {
     BlockCopyCallState call_state = {
         .s = s,
@@ -733,13 +733,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
         .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
-    int ret = block_copy_common(&call_state);
-
-    if (error_is_read && ret < 0) {
-        *error_is_read = call_state.error_is_read;
-    }
-
-    return ret;
+    return block_copy_common(&call_state);
 }
 
 static void coroutine_fn block_copy_async_co_entry(void *opaque)
-- 
2.21.3


