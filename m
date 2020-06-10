Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9FC206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZRDDM+u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9FC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiznf-0001OG-PO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTN-0000Dv-Pg; Wed, 10 Jun 2020 08:04:49 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTM-0004Tg-OF; Wed, 10 Jun 2020 08:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyTDMR8fUNgSvNFvpaqTCEnTyKeQOTvAM1BLOfU8X+JSmDNbqCb4KlqOdATvSUQ2uBkmgJSAzHYpSNrrrduKl1uGaoFSwTKmUXdMPIyF2HsbNu5XjwXqRJuVPCyL1WZY2/oX5ADWzBbkd6J5Gj8fiYLumsZLYxK2XA5xdI7MYAE7K8KXwagjBSU17U/NnQ0RcHdCD1RkvSLp+od0dhfYukzfjf7upa+WIPmUG640Zd9ZLC+GcK9ZSxkgxVzqRoV9Rw3SryI/PCztvRYrt1wS9jX+KU9ZcFyO/vsjDmOHC9bf1uWvKX38Pd7fx1THeo2Cgy80Op92i5DKMoW2vDBv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q9d54FZjb417yM02fOyDiLLgZABuN7g6rPIzbizeDI=;
 b=Eowjw8JeJiVp405iB0Acq9zE0SnO8ZutTD0Rf6UvdASlRP9xwOSArsb3jWI824DHZoE16E9s6HPpGgCaalzVwAKt1X9r+AxbkO9dpsyK/30ENZil9bWiFG+0ivLshThcbCViudUWKDTvI9YO0sUXNF9Cem/pbnNemseNiAITMWtQeH4QeHZNWUmK7ZCL2CEz06j/vZJgbDCJigf89ZVGmqz1mFtF8YAgZnHWRj7f9YYsutz5vL4VDsUCKbf7T/2gXYUbJYmL0lLCDzAzERunZnyBg9VZbH5iyq6SZs7UVVNo7KOiVgp+8jkh1VxVbKrCKFRPJohx20MsiExSwgMKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q9d54FZjb417yM02fOyDiLLgZABuN7g6rPIzbizeDI=;
 b=ZRDDM+u8ChI+WW8UinbLnswXcfrK/uaAoCa+aW0t0yz2x6SkcrvyNO+kyzUxrjI/7m1PyoSzyRiRZmXJmnweqnjxbrQVyZrcwCo/0S3JPDgt1J6061DHtE3nVuP5GKBjpODQim0LWyThIkaBhB3sZGVHGmpTYCG56HIjPyCwD8c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Wed, 10 Jun 2020 15:04:23 +0300
Message-Id: <20200610120426.12826-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dedf50b-7ae9-4ce4-5bc7-08d80d3675ee
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495720BEB589AE9CC3FC4EEC1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77ZnhGlmAZnv7mVxFG5BDVRFe/mhVwQqWsuAKuBZun6kfQDLcUnqN1IL62rmnE3++bRC8J7R4ktsciLdSJ5Wu0eufGy+kwiECyLdCFwJ+vBk5jy88lvoaHcGj8tn7twH9Z7WwSBmC5gGOC7piOmoYwmox/C+HPYQljV2Xag+xtqqPajnPUYyWVOcZe5XsgDRfRpPR7PQy5OmHSlGxZeBVLmcLXD3ju1RYe0YtZxYoVlY4HyUAf/OlHvuLAc0EyAWkEzqKFH2cd2TdJZ1yAsXPQmj6l67brVlCOYM9qMRYfnVcyvNB9G2M7WO20U1BzYmyyZaB9VmFSqfZk1cn2u04A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(83380400001)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dtxPuogAhFaGmpYqwDfAf+eGfaBHG9HrgeTq3we3xHrAwzUJ2cngRdVOJPzcqQIWCpY+WFgmfSKkd06VZmE1WrggVMqwEhOK8m8Zlj7rAYM/j0k3n7U57nzwu2N3Lww6xDVBHTBlsoiQGkhQbQfTLn3L3BxQ9aK5jdbsou+17MTHukZOs+AY1XwQE37maytUL6cT+CqnmCR0+sRjirVtQXWlLl+FSZBRaA+eboW8gaZzASNO6+E9tkqgTocMwOBxSwrGkLe8jFvRTeLdRbD1A3NY/R5MprtHESsEfftZ4Co/qitUhMDHEqb/8uN7fyH9m7QALxSjuMIFFROqyy2yCf1d4lwNn3OEcNPneOXtbfDCVmGpgFVRZEU4iw3EEwhbh/6L4m7JciWlBDL12EXfItyWRQNRwWQ0VEWzBYpvJpMAJYgC3lokhlAD+zB/wL5nfUibA5dTcv0LwFsjXnsSVYGpxP21vgNn8BDBL/wYQxoOXO6wAPxKhm0e9vB31Lyt
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dedf50b-7ae9-4ce4-5bc7-08d80d3675ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:43.2986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMCJQ0ZBUyP3GeLQCzMyVuiovvWUgnIOl5ZVnuB3SokbaDiHje12PGSRUPuUYsyKm5XLc38kaC97LXeRRWlCXNUKEGEA1Wk2Z6UODH2wrQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above, let's support include_base parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h |  2 ++
 block/io.c         | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index f69179f5ef..1cb3128b94 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -41,6 +41,7 @@ bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -50,6 +51,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
 int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
+                               bool include_base,
                                bool want_zero,
                                int64_t offset,
                                int64_t bytes,
diff --git a/block/io.c b/block/io.c
index f2a89d9417..c3ef387f7e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2357,6 +2357,7 @@ early_out:
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -2368,8 +2369,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    assert(include_base || bs != base);
+    for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2408,6 +2409,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
 
         /* [offset, pnum] unallocated on this layer, which could be only
          * the first part of [offset, bytes].  */
+
+        if (p == base) {
+            break;
+        }
+
         assert(*pnum <= bytes);
         bytes = *pnum;
         first = false;
@@ -2420,7 +2426,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2437,7 +2443,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
-- 
2.21.0


