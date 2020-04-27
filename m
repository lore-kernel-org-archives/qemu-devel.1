Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2297CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E299920661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PmCsdLRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz7S-0002C7-Sn
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3X-0002Cc-EE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3W-0007ZP-Qm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:59 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3V-0007Ta-Af; Mon, 27 Apr 2020 04:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDPhKog+8sL1GSSabYYG12jpefLdALvhomj5vIR7cgh4Xnal90B3yzPsbDqnXKZD/Z+x8TWSkaVpMVUxEUYbubHOHooZGZ0ZyxU9Gck8xMAFUtlI4FGW+mmZNvBNPiwUHeZU9DVFOgIFih0U8/j9yC9hirSssjd1YSkJtmDi1hORKJYIrIPaertPaaBo4nfeRn0pZvf+lNYvu6Y05M2IO1LdH3KvretKwaHDqdLNy3LiRi2ddr2+AmSifcn1/DJIfgiqItJbEiaOMCluW3fFsAf9ykJHxkKtZtJFSlnzuqTeR5tn6WNaOZMlxjNeTwZYdzmGLEKbZRA7dpk6eJQ40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15AMeICMjr+njwKyQlpiK6XXqLA5ajWrYYlGp74/ug8=;
 b=h0RV+9WwAzQBYqRoFbLbEEw0nFallyvk1u/qM6hqDantoUjAujEIwtiEcFQ6XNF9FXEjXwV2Wb2u2ZohHN1XvRphN87pf5jqyxUM4xJ1Bwpb5OK5yxYg2kAhkX1yCQYW4oBUshsLHIabE2peZ1gR7/uQZezDcsTQnj8Xhv+wkp0kYKbjFJpyyrj8hwfAogTXPHw/GTeACf9+tWfgIKh6/RL8oDth5Db9GtC+R+8lc4/QG72FrjxrQQKRz2jHDlIwMYqNNqsM2882o82gDTYlnUQ5ZwqJ1OP++6ssFNBzqXZ5pn+u9l/V/B4oFjQPoj9oYt39dXdT6oiTiZ7/EtqDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15AMeICMjr+njwKyQlpiK6XXqLA5ajWrYYlGp74/ug8=;
 b=PmCsdLRfi3Z+dd1ilp9H61GljcPOK50ISz4Lkw1OM3sxWOWFF6SrmmR1DYRiYOiDUaBGGjF0nSiguCc3zLukv0rRfYFQXdOjvkg9eemGId5+PKgLr2vVhrdlNyfS7GLOOPRXpUtU/Sc6d7owIRqC6Hg72VVBpOXcOvE3GJsGXYg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 02/17] block: use int64_t as bytes type in tracked requests
Date: Mon, 27 Apr 2020 11:23:10 +0300
Message-Id: <20200427082325.10414-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abaec1d1-b7d2-4f15-c387-08d7ea8452db
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463CA2FA09457C46E1C842AC1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMn1OfRDxtMt3ZSJG/IjlzIXGx/igJTlLb08pIP1y4hJ6iCd0CoybY0rBQahuNrh/1KDKbdvnmkRMpslsnBjGLGUVgP3ZKMGrFbw9vg+UYeacPJG+KBi52jfplnPSoh1BeA1uvsFML3brjRa/cl/bHufeKhFDaLQG1foUylCFSVQ5sjxVy2p8AXT8DzaSdsxbDtJRn5TFPAbRESqtbtAx84bfMb0k8wA6nYv5cNkItSWRHtr9YP2yJL7h5vByqXjwJcCyoQZnUQXSXDo3f283v8tUx/4yflOYbNN8GFNP4OnNcwaEcwK2GaLUWD8tqNkUr5oOZuGApLmKy7wxfnNb1AFMSwbeiYNPIe1DyZVVXvM2cpgeg2H8Uu+was6Jz3Y/WBpR+4uFRwQv82LSPbGWuf9p4oCAy8i0+coPCi4i4M3ayMm6M2WCVcFQfkNaf5VF2dIGEz92+g4a2uLxCwflSUD65OmXnOeSfdTcI2K2wxe2GtaR+SyjFu8LeJ+U9Z2
X-MS-Exchange-AntiSpam-MessageData: lzVANwIfJzwYEObddZx2OoZCbVXRN0H6PHAHkOv/a39/LF4LNsra87l0Nete7u5xHUcMPLsU7wDyyxFrJZIRr6/9tUa8lJb4xCmPbG2oqzCdVD3hFZ3H+K0fpAK1xa4HkoxibKAZINCoQ3jJu24lntNM5aE8UrenmZHwto+AQCPDlyp8bBZ5uOvytujIOswGGTmshoCy5mbX9xsHXWglICHIb0A0i6HOe8I68XvjSuSHwjmzOOEzgRODakNaDR/dh6JsVT9soyZVi+8AQqSeKB9eYgaN63N6GhKjDzrL/6ktow5IXmB4DMs8u/aiUWinW01yRb/viSqbXQSsP6e8ypaTDoBkpk64ti7aC04Rpc352JTxVqRMM22h817UC2RZfYm65eCitcZA5QBF7f/7A6eVNUx0EwWSw3uztd3G3TyYrAkJV0FmivDcNelGo9anWnNBxi495y8CWVwMdWeBA6cKnx4M2WTEPK5bdomnDKvnc9dKhYNbT1n82uILH+hezN5MRJeRm2UYpq2QMu9YrUstSiiP7pANrm0QUiyvv6s4s12aAFOyT6KRBC+1eoJ9oC8BWvzjyb/AF+g699RB0ZB7vEOecCDmyON0Jdm4koOTOUZJAvrjLDbrDI0m65XFXV7gwUBFCHXU1ZiWUCzm1e1sEzQHKXMmgYf/W6JX+zPcZNVxBZTfZ2V/Pd77/NJ8tqR9ehYNtvowl2Y7w7GyuTielFDu9BveA2hmyWgKio3zMD4fE6JNitVHYnAA6on0lSKqSqHGq67/aGxzLCl60kwa5L48+6LmkSdXVy1TBfc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abaec1d1-b7d2-4f15-c387-08d7ea8452db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:54.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju5gmqcV7IpyotAKkbbSb0MGknoviCC9hLqpXekmGnm2pYBUtsxQ3R4D7XWrUsH2hR6YKjYsRa/kkVyRe4gc8fXn1Leir1DKRH9Oi187C1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert tracked requests now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h |  4 ++--
 block/io.c                | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..c8daba608b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
 typedef struct BdrvTrackedRequest {
     BlockDriverState *bs;
     int64_t offset;
-    uint64_t bytes;
+    int64_t bytes;
     enum BdrvTrackedRequestType type;
 
     bool serialising;
     int64_t overlap_offset;
-    uint64_t overlap_bytes;
+    int64_t overlap_bytes;
 
     QLIST_ENTRY(BdrvTrackedRequest) list;
     Coroutine *co; /* owner, used for deadlock detection */
diff --git a/block/io.c b/block/io.c
index aba67f66b9..7cbb80bd24 100644
--- a/block/io.c
+++ b/block/io.c
@@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
 static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
-                                  uint64_t bytes,
+                                  int64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
-    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
+    assert(offset >= 0 && bytes >= 0 &&
+           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
 
     *req = (BdrvTrackedRequest){
         .bs = bs,
@@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 }
 
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, uint64_t bytes)
+                                     int64_t offset, int64_t bytes)
 {
     /*        aaaa   bbbb */
     if (offset >= req->overlap_offset + req->overlap_bytes) {
@@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
     BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
-    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
-                               - overlap_offset;
+    int64_t overlap_bytes =
+            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
     bool waited;
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-- 
2.21.0


