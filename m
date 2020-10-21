Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBE8C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E46D2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ulti7Xy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E46D2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFpC-0007Gw-G8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaJ-0005pD-6H; Wed, 21 Oct 2020 10:59:27 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaH-00086M-Ad; Wed, 21 Oct 2020 10:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boJZ6yjjWJD/BEo1z+goyjFdX4dF5uAlmBawPYB/WmQU99v+zTX+Ik79YzeoOUKHggD+RTjfWpx0QReCwHoqkOGNuMqCbY9+8FdZf1HmBZzbCjKiyZurcrxoKsm7pBHxjtqFxmgISAgFtJtPEiXzWNOYluU8DFNW8ZJZW0pCjrzor45s3i+5SXaesWjfsJPkmNQdAo/xAHJl6k6FkthfOrKoiX0bwEkzliSAzLIwXcDG/PLBq8XBhgETrGNu4Ptt/qWrDRwlyKBfHJKhbGQ6cEdzuVwLTedMQCFaHaaUgzQXOuOrwPcOXLOHbsy7LuBesQK5nqQIz1WeAMIwzphrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WXMohePJA/Q4N4eZzbyc/6FDPwjFlN7LE+ifLcBsMs=;
 b=MlSFrE1Af9Zs+Y3mPl6rDWDamME5pEFaFbrl/EVZZkp32Uz3oUntXW5ezZTQBKJVEuXSMcHLdQm3nzXuuSNb7B2my/bPyTVeeGZ2E1a4y74oYlte83xS27K8f4mkYXkY5mtVwgOpWahC+c2TAnr3BPl4w6fo02+hfzMQmHt4nvg/Io5lCTrNa1YJQ5PWoM4X8vXSrUVpMvhlBaYXVaoZsbs/zFZ6cjXwkVkqdcWgaZqtX8msMLZ0YCDpwkuXkx6K4yL3w2y1rsbv8XLLGgW2jjXWIrJATq7/O8QseotPM9eWwHg3De6x6J/9CuQ+3iHYLb9e8+uNyElytzg8OmiKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WXMohePJA/Q4N4eZzbyc/6FDPwjFlN7LE+ifLcBsMs=;
 b=ulti7Xy8M6Dx493k6RRjg7nKKTy9OjWItO7GGMY58YRcbK81xt45tWdKqvJ5YKgA0d59cg3NP5mjpIxI/Qc2Yl1EklBVDAlySfZmd2+3Wdzkqy0JM33DoMSj6ZJWM/fAxec97tUBS3sx+D/ZDNN6PRCXFbrnWrRzztLU9p7bkMo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 06/21] block: introduce BDRV_REQ_NO_WAIT flag
Date: Wed, 21 Oct 2020 17:58:44 +0300
Message-Id: <20201021145859.11201-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c015f124-b5ee-49fc-36c5-08d875d1e266
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44725142DE39F7AB2ABCF21CC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts2D4mkCxuQ5dlqTSdQ5oabvC0p/KPXM6XMZr9+xxWz9eQR1GZrUEiYWyN1U1rjHLECpSxVAiyWsuNxSotMRXuZO63ab+9UFHk1N9Xe9Vy9wj32v2pT4G366M6iSlsxhYAXQRktgFh/VDJVrZbR5+maWO8KdQepecFYSzF7ovdfW1MfWYR6EuXcQV0KqWucKCtDEj/0yUgwDGK2LgKhmY8zQpxxZTazQSGTeJE7/peN/0CDF0LwmzMNLaldYfr+caJ9CQWtR74FMJwF0LBILi8BOqsu7+9mje3NcBupz+dJAkJMSmu28y5ua4FdE9ow8XDekL1mzcGLLO1qdGUWXvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KToEKnNmuIfNiZS/JQQPnxmkoG8a+Gm1mlTZUq6dxxk32WEG6Mgnv2/pu8mFy0bSIBwKqKlVjstV9xYW8LMqbWSaKY6vretBFwz0Ck8j+xkAdhy65ZdvGBRUDALRZ9ppUHz3Ccn4Q7JaLXCjQ/Ezx3q7uW8ryMtLyQqQScwbk0enE67McHWKQRsygiEDLSsJFyk2YqH2+PteyuBjeraiNHMMx5X0GIQTDCWxAq2tMVXKbllYYDyT3cGXlG8Oak18/7dZaeH1pFpGXLaMewbthPcBPdd+etOWdhUnmR7QOQPwHZ6fgxc4QiRbykHwpoY2S1XMsc+hXl+QygxVRx19llOwRxMdOevuO7/P4r1eqlSi5NCEQHB4MJsasp+E3gHFOrfjj1e5SAq9+zJfyM1YOVZuYJz5rbJmfgGMKpG1A8PvmBCbGBrA9DPDLBgf3Nm0b65elQkxw1/gZQrOD8gUpG2qYQeXh9Yl8IAXQ1xNwZcpzcSaBu9hERjDeexT0/r5YQ4UN5p/J5ehTBUzyTe2aLa3+iD+Dd8qie/ABQcuo0cRlDuD/f3082+FfVLvOc2RF0m9jpSXoRSMIZBwbgwuPo9yZljfSE6qhNljMMq8c3Md8Egcry+p1/8drvcfoSPdAgYOQt2ixbj4FViahW8DUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c015f124-b5ee-49fc-36c5-08d875d1e266
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:18.1163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFa4knuO80ZD/cGuhvTc2H/fiLCz1VaWh3UHnelmGJH+A5MXuwXjzsjQUF0oKAnComx5M2SvOfdhj6SBgqzEV4yNYpKbT8T1wtKSxzy63bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add flag to make serialising request no wait: if there are conflicting
requests, just return error immediately. It's will be used in upcoming
preallocate filter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  9 ++++++++-
 block/io.c            | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f9ca42fd4b..8a37f9fb01 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -77,8 +77,15 @@ typedef enum {
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
index 24ff8d804b..504b656f87 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1815,9 +1815,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
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


