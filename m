Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE17204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MxEetfk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE17204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97q0-0005Wl-VF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lr-0005Uc-GM; Fri, 21 Aug 2020 10:11:55 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:44416 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lp-0005AI-99; Fri, 21 Aug 2020 10:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX43eCVnOwF9uB0vXPHo4o//94nKpPctjwUSgL2/3l2X20yetMwXL+Lz64GnOgLcLQbYKwQkeB9UxiWedI/IpTi+BMUVI/QeZQe50nSWiJxm/BcqWTm78Z491QEpXQCKmFa9sNZicAcVElDDQ/j5jnvrWfvbzFrECjg/c0Qyxui3i3c3p8K9podM455zdwuWlDGv9tP6yKdO3pNgtcUEk6FDARniKhQCT3DxStewACgnbl6dgmI7TSaNm5mOrMv1FuewK2yy2qI6TihZ5vhzuITRkngrqIe4cMWYYNO38Inbre6YtExOR54BS5KW3tM55uSk60xu0vDlwu5PI7BX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JicS2MgvlUGxcQ4pTtRKtaD7bovqcjl3Q8ZlpEpR78o=;
 b=RtOkxljYP01x9ukbwyYwa70fUaIqQ5CTJy2gzXAdoEAeCH9gGN7C+l4fNKIfsdVQK+Z9ufW8kctDHczcCs6K4BXBhd16dRgxkM4ZsqiKfoDMoRBYPXJ/QX7Fdlce3/Av/oNcnkQGKM8mCJxo1682wg7m1MwyQVGkBC0qkNI7HQKvgSVWD5pO04nzxDcCespiZML5uwUgSI0l1ss+scGEzSpFcYzedpLrFDN5tAuOCZAY1taZry00qtLV7zuSKBnbbXY1yDsu4LsPBaeCPCOBcgvtIMQHqpWzvYn1/W5EuslUTvpSOxm5hMgr90ysY5ndUzGvq9lC460zSSIC0qCi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JicS2MgvlUGxcQ4pTtRKtaD7bovqcjl3Q8ZlpEpR78o=;
 b=MxEetfk3mLgDoq9VsK02c7xkjWFMRjF8hbMxN0cUd6bkKgWJWoED2Zs5v629TEIpasrOfM5zc+XZrTqgLJFYCjA9lVRjZ0c/I77Jo94jJPdzoDxNhnD2HmZeNfQaNuAYkp6E36G0ofT3XNghumVjRSdhkEi9tcdZLcNjqVut7jo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 06/10] block: introduce BDRV_REQ_NO_WAIT flag
Date: Fri, 21 Aug 2020 17:11:19 +0300
Message-Id: <20200821141123.28538-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:42 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4170355-a8da-4f44-a377-08d845dc217c
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253F9E08ED1FC5D49074D5FC15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe3Ib18IGO+sqZlGOPJyYZtdqcmZjg5jB5fDSDty4dfomaNWGsIH7mxE+Q0ZS8J7fboHI8OD/Wc4pmYbulD9JJRgBVrLftAU+RVUmBh6N79Tjd7TqPQsghYvZyNSOSbBOSMd8OBFoVhUrskLCVKnlKtnEKjEBUZeXErnbXiGMiqpGKq7h3HVgsAteCx742d83rrcQfHGx3ZYWAvhvl+GcN1b1PB+eFfkpqjicw2zBSofC2EThPSzjrD+cWKKQhDEDFZ8esveNa27JRAKvz/PdKZH2H5zdDGGluWhjVi9JazP1uX27RdIgl1kdw7uVo3isanMrdWauo8SCxfL0XVmbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: POhx0E3+DopZZj8ID7t3XKtBn/XNPR9ry7n9eNWsNFLPxEgtLw894dkp8jrgnoqxTXTDwW3ubSJQYr7pgcavq2rSwLxZ95rHuMFKkcpfVd6mFqnXJDXLLs4WH4czkZmiVTjomGrjXOwcXVGDBASnm7zXwcUF7Ko1pZJHtKpuDPBIYW7F1BeUJP92dPIS5U2y9IDj1F7SGTP2/u15JGzWoHshQ+VuNgpxIdsYADliN3RpOiPFTcJkQxbXEF2P13/w2W85DHIb3Aq9lZBzDzpqk72eh9Dcth4oTodp1K/Mukw4divPhYF9fiafkyQfi8tLrBcqfiylpgLRuh6ypBNzRwUoJCPFlKW/VGKridaaqhFa+GXQOy/ewR89RGJI6E4gv9TDDoC6up9m1enzbDz0/BB2+iZ1JUnJwMPvpdeAB1NhlwA2ItPyHZ56jctIS6NzKka708oUJ7zmG1nnv3Bip7uwdP7H7e19ptuBHSp95p59/TuVnN8FrVS7r/DqUYCxpu76Q5B3et5YLCOwzSwhCYaOEW9D88eILNS5qSw0SvVIBgB/rKTzLIOA1Y+QJDZAlYE+YhnRg3jWLu+/9lnBjyrKet5FU+67cOPtlRDXa8fVmXz+bbBXicfkWK04ci+GYl4IM6qL8PgfDmczF7r8yw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4170355-a8da-4f44-a377-08d845dc217c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:43.2710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U195Q83nesVK1Qff+85ialc177pbCHZWngbrrYb7DYLyAzWN9WKqJ9wUKGCrNYc4LG4qQHshLOx33RDYPqoPLYtv2Nd1GscRjlTnFKHjS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add flag to make serialising request no wait: if there are conflicting
requests, just return error immediately. It's will be used in upcoming
preallocate filter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  9 ++++++++-
 block/io.c            | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b8f4e86e8d..877fda06a4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -67,8 +67,15 @@ typedef enum {
      * written to qiov parameter which may be NULL.
      */
     BDRV_REQ_PREFETCH  = 0x200,
+
+    /*
+     * If we need to wait for other requests, just fail immediately. Used
+     * only together with BDRV_REQ_SERIALISING.
+     */
+    BDRV_REQ_NO_WAIT = 0x400,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3ff,
+    BDRV_REQ_MASK               = 0x7ff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index dd28befb08..c93b1e98a3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     assert(!(flags & ~BDRV_REQ_MASK));
+    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISING)));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
+        QEMU_LOCK_GUARD(&bs->reqs_lock);
+
+        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
+
+        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(req)) {
+            return -EBUSY;
+        }
+
+        bdrv_wait_serialising_requests_locked(req);
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.21.3


