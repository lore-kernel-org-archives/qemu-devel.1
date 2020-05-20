Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B392C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E2F20823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NfAUO7Yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E2F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKDg-0003RB-8F
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCg-0000r1-3o; Wed, 20 May 2020 04:35:54 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCf-0005RQ-3c; Wed, 20 May 2020 04:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKNOeNkuAKtGAPU40a3THsCJNSR6Miyy6eapgToJc8X+bnpDUjOTgNUx3WDu9Wk9LnwFEz4vnwe1xf4VIuRY6sk/gRTOnOnCgiIRwopTNJxnQ13bpNjRiF9nQjx5gMZVAM2xfRlb1cwdotNQmBXsDoN3OWIaY1GDgXyqVcDfmrpHMLtGg9q/ryor9GpR2HAUHGZL0o/h4EwH7mz/chqxcIW88bY0uZwuuH67dOfMSEf2aTAOXlBoHJvpQpQi+HIBwSXfL8u5sWa1oPeJE4aO4s+pYKPdALP+Q/yUT8UJ9LsQE7MvWhxb7PWNyHpOs4WINV+by79hzESPkFAuBTPcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9gzINp7bqZ5NqBQUDAf0iYtbS3M04Xmq9DZDuxjk9Q=;
 b=TH5rSIIOE2d9mq1FWTVdsZPEPqi8NLjPwljySD6MVR85zrlYrBKeZihU0CA9pySwzxlOWTWtFnAAjqwnIn3rCGJONJBCd4r5l6XlSI1sy5f5KUjdOr2F6kX7bgT8mCndtxF1I16pTw6rI6bshI4ga+kEvGRqXcZqmBsSnTSUkIpqRsNY9f6cnPZM4k2MlbjtrjT9YMuo2jjjUv3EEHT29/HcJrPgsHfdG8JF/trpEEO+ZpqWa1yLbM6U1OK+iyHuy+pFh3J0CLBD29ZypdbaEF23iquChLjeudTJ6+sw65hwrC/YBw/dU7TaIDfdc0Bc6HEgGy8G/xggL95bAqskBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9gzINp7bqZ5NqBQUDAf0iYtbS3M04Xmq9DZDuxjk9Q=;
 b=NfAUO7YdhgHT/U2oe18ADjJ2r2KMfQn2+IxgDQv11UPVjpKqmUhpsW/9k0diPbAoR6lmLtJx/+wHwt/Mj6GaB/QF9qhSqUNkn29PvWrnHpAVrA3jgemaM2z9WYeJnM791I5+wnskgXfAa2gMuwHl1EJK70fNc6VBpDwRbNE/omU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/5] block/io: fix bdrv_is_allocated_above
Date: Wed, 20 May 2020 11:35:19 +0300
Message-Id: <20200520083520.25793-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200520083520.25793-1-vsementsov@virtuozzo.com>
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e96f360-c347-4c72-0a08-08d7fc98ca5e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54482672EB2B9CBE348F88E6C1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qCQtYaKJ/+LGFSzdbbG/OiUpz4326f/r8qzLWmEVDzo+9gzUZLDzBHDKzsXUViIwe061pAB6xAoF/hoq9qdKFivOFM62SQjuKkvTfGJP6S5/SoSb7g4peUoqfM9oz1WlXQU/2d5JdW/DgbAldDRDiWSjeH1X4V3yvdxMluUlqpGCEQwQk3Q67cgNI/cJnzR5D7ny8xvCcjIzmGUEEkPLlSfvHoP6mHFyW/ggw8vnEYKygjKVoT9HdGZGTGnre/dWYJPs10JUES4zDKGu4I4YySJgfxfJQDz6dmVuxo5aBsWnrJAi0k35fcI/maLVc1yNIJ6d8tmp4KZJGxoNd96MuKG+AfzWnfIH+ErbnlbRH7M5B+MhuuK3jC8+DI/3dQV1NI8BkVUJmJlam0JOTcuH5wa8Y4bC7FRarZW4fncyvGJ/ZuhpLbISmnyUiFXaqqmDNQ8mTIg9vb9zcr7PUYOZBmKlXaLoghje7bxbju6128FnvrZLHDwuDirnqXu7Kbw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: edy8vfA2W47xUly9bnsrBQ+TPGKdXiZkqkwv61oermkFtgO3a1mafde7x1mKcS7Wz75NX6LH3MdD8S/tfYB2GK7KL+1Xw6ZUqN21UV0a58YWkuAJfCBzWcwfHK8sRFtEZokx4gnldMz8nz+ex96lPjxj9Rk3VKdRn5CUwXkXBSr+K/knzONxP5H/IRfyQyqQYROrEhjT9H/tTVQeS7BZpk6eigxstKwHgBG3x0KAPVMQ35FTOhgo0P1g5xpEE1kvCWkZkJZXqwoNKRcrmPHxr6GBzloXABbUPqWXTmH/D57lD40erFV8uz48vl3QSg0HmpxVW1+JJySGxzm+C1cslLmQuNxHvLclAdINyjEW8wHp4lgLanmapD4Wxk7sQhKw2O73qjzmdNhhsiXJzCp+unssu8DS5xVo/ptSApD6CJX7o4MOcaS5mXkDrxjYsR/L/ubURtlvMpMV/9QDclxaDMTWYgX3pYOvtM2CLQ783gG1cOIc9Fmq1wIRDzCwYdTI
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e96f360-c347-4c72-0a08-08d7fc98ca5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:45.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH+kc9c2kfvPASovBHhLx7xUcixXBsckWjPnt+uugTxKYgd15ZhyDhvyQo3JXmgdlzfWNBQdsdnDvfw5JkEsrKphFkI6VQk1/evxBlIpQNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_is_allocated_above wrongly handles short backing files: it reports
after-EOF space as UNALLOCATED which is wrong, as on read the data is
generated on the level of short backing file (if all overlays has
unallocated area at that place).

Reusing bdrv_common_block_status_above fixes the issue and unifies code
path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6f90b322f4..e952f3d9a5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2611,52 +2611,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * at 'offset + *pnum' may return the same allocation status (in other
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
- *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
                             bool include_base, int64_t offset,
                             int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *intermediate;
-    int ret;
-    int64_t n = bytes;
-
-    assert(base || !include_base);
-
-    intermediate = top;
-    while (include_base || intermediate != base) {
-        int64_t pnum_inter;
-        int64_t size_inter;
-
-        assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret) {
-            *pnum = pnum_inter;
-            return 1;
-        }
-
-        size_inter = bdrv_getlength(intermediate);
-        if (size_inter < 0) {
-            return size_inter;
-        }
-        if (n > pnum_inter &&
-            (intermediate == top || offset + pnum_inter < size_inter)) {
-            n = pnum_inter;
-        }
-
-        if (intermediate == base) {
-            break;
-        }
-
-        intermediate = backing_bs(intermediate);
+    int ret = bdrv_common_block_status_above(top, base, include_base, false,
+                                             offset, bytes, pnum, NULL, NULL);
+    if (ret < 0) {
+        return ret;
     }
 
-    *pnum = n;
-    return 0;
+    return !!(ret & BDRV_BLOCK_ALLOCATED);
 }
 
 typedef struct BdrvVmstateCo {
-- 
2.21.0


