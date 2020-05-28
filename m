Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2434920776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NKckHtlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2434920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFad-0000Jc-8t
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZP-0006hH-Ve; Thu, 28 May 2020 06:15:27 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:28150 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZP-0005Od-33; Thu, 28 May 2020 06:15:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbWSrWJDvVZsQeEa85oGjjav3ALZQfG6C0KlPucF5Zz2WCoq/vGnk8n8TZSt1P5JWqgxkMlmqZn3p06mQqg2HKuXviJwT0zB8onVekh2QDeXYJD0TetuPJOe9KHbmC6qFqe/iMRufztHILzXnmbXnAwQctmu5smxSAXYFvD6zLDiQ41mfurBhv0M4BplF9MtY6fS3FNpuzBER762oJjB9RSEdRPSuM369bXqJWQKpKeDHNi2D9RQLsBiUG15n/Htf+D+isBtYqnVpjj29Bx3irAwBE4mUhWfheZTRJcOoqCdAHWeFk/XWGF1w0fgtfBd4ehEceZeLsL+ocugsq/kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsfrPTFUw6C2RcwbnLdwtiYOh92ZxU4NY/N6T1ANsxM=;
 b=mCk2rlgnWfIQ8Ifs/3e1PcNG18Or8i1FSiSyi8Nk/uRk2P4OPWUkH0g29153Oz4c7mvcinYUQHvtRZrvLVU8iuLYD5UaDS0wcZVPc51ipBtAFmnFOinNildZtWEoZR0yRl+D1Z4uWbKaLmnuDBRd8F1+AhbKjQ7wEB0QMvaKz1Y05ZZji0IMjs1F+70xYFuFfY6FXB1X8oOKrPdsZQuZwDDaqwvr/SKcV4jx+hGYVAfHTSJBU3kTmgdT/VTi389JjUf7N32Zsckno3fCAlAWnR1SrZHNC9D6PEpqs2Y7rZpqVR4lkiStUOMrTradXWDLsCoVZNNuP8db3FYcku5e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsfrPTFUw6C2RcwbnLdwtiYOh92ZxU4NY/N6T1ANsxM=;
 b=NKckHtlHcvxA8Qvx69vXjJ9YxPZFCGdWskH0IBTHMkW8apiNGzb66bEjeK3PMBlmuYsHZZ5Gsl3gnHbLdZSNMerWnXEFgElPoASGgEeE0rf8B1ymAYxbC/B5dfVl1Pj1jQ5GPmW/DTE3xR32C9OWuJdfxCn/RTADN0TuJXuv0+Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 10:15:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 10:15:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 4/5] block/io: fix bdrv_is_allocated_above
Date: Thu, 28 May 2020 13:15:06 +0300
Message-Id: <20200528101507.151161-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528101507.151161-1-vsementsov@virtuozzo.com>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.178) by
 AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 10:15:17 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f218a02-d0a5-463a-44f2-08d802f0053e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317DC7232B957908F525097C18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2/8pQwo+cUIzeqfs0fYEbd6LvOCkt3sv9j7Z/Gm9Ze+k7ezcN036bZyQO+BAJ6257k7ulUzBqUOO1e5i4fTMC8i1kHs7kdpTRoq0KKm05PATUyhr2+WD1GVDmgBUv1k5MQ/buvAce2glKtCVukU2RDaJ3aY8wWiThhs6+l9JZvyJpWC0euJ11XySEbB6EKLz2TfXVn7cX2GCLc26nnEb6QNZZ81Ab082qnUyKfBm0x3eIkLfjsRW63k72juvKWR6v33OjjPCUSsHHFvQiqKuu3xL0ba4prvPt6GIzuS/8KHUXYvfdFzsH5itIYA6xrsM9oB9CAZXpkwyjBlZZc+Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(1076003)(26005)(6486002)(5660300002)(8936002)(6916009)(52116002)(6506007)(478600001)(83380400001)(16526019)(186003)(4326008)(2616005)(6666004)(66946007)(36756003)(107886003)(6512007)(8676002)(66476007)(956004)(316002)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FIAtBvOLQGNyhYaISgZRCcA3XJyfcfsP7GsI+uwC+3pbihsymVJ58FSwsXZsA63MFzql72/m9cRS0HXifh2pL7Ro7OenXTIjh6vKuTEgGKUKEWgSdojA4qp+9HcX7xhDpoLwYbjbjqD0XQqRGbqW+fYZF4Pa0cr8SFA5S4kXpyPtyKqDPjARovqikWH7oJWDO3nZi6+5BRouSuKWg90nJskL/SANeV6ZNwqYQPOHQrRX0SX2zSDMTBoj4fVNe/w5/KPv8vLuWwHrlygUpqmD+RathpYiuEY/U+Bj8tVSQMiVsyN5xboHHeYzPWvzY1Qpb3uhodDApAnidJQMk2m+wSlNWhFoG3pxlvD4RkKCtVT0itV6cO/25LZy3NreLhaV4IBu+UPiY4Lhb4YUtWvsqftIvxp4qIB8ZN9lF5Dw+UBKG6Vp92HCtGY241MVAMXGP7ReITB4Mhe8HDTmvyyvN5qDYDgM0uxc58JZLiEvG7M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f218a02-d0a5-463a-44f2-08d802f0053e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:15:17.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y16raU9Kr1e5sEMus9V8v3JoY4NOOSUjgmE4o5RhOwbKXI4RTbGp5I5m97cYejPWHh3762ol09bcvqjUQ8ujZAHz27LYj/7D1n4eF+5iDKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.14.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:15:22
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.18.0


