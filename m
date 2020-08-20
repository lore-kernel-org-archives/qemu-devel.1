Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF08C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19173207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GC5l5Xef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19173207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pb8-00028m-8F
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUC-0000vY-KC; Thu, 20 Aug 2020 14:40:28 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUA-0003Bm-JK; Thu, 20 Aug 2020 14:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fupogDV7MP1uXD+0/Fb0byuUUFg/LxvfTHDKRZ9Jk2o7YaUSIkvxvC0kC9n/rtugn5QZcUmswCNB1fvJaX2AJA0XMU2otaZDiHA59+30ru2tbM5zWWOomjJF5Dp5o71JWXkSHmg5gg72gyocGfbLxHUY96icAnzpH0xuxJkGUZnOHsSoxr99/SvpDP/dpvR9ygvy7MS6WGFTJNZdvDFDEda49a1cpubVQijOwj8sdkrc0WWwN2or6vOJ9BYWWz0uB2eo7hfcgsk7HkFQM6pzvP32rAlGBXCrExtUkBOyAB0Jn1qMUznvJ6HETJA/Qcp4e65z2cyii0fC5oGEiEyVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JicS2MgvlUGxcQ4pTtRKtaD7bovqcjl3Q8ZlpEpR78o=;
 b=gB84tIwsBsKAEdf8LiV/ii2z/taR2j9JdYN09ar16z+qrONAQvZA0xdPl/YZwmgHogPlCjHSYTkzAq/DGbfZg0Ht4f+yKQS8vGGmAqJdOKrgJ12UqXhxVGWH/nfjHvwvXxVZBnZyvN/CzTz/BCuZ0veeUGXUSiZiNXKUgpYGhs8M4DgwW8wfGjkicyqzbfpLUrOXYqXEgEWMGQH+U74Ar4zlBxknc1V/O1hjUFqsgAtVWybJZb4KUjncT/soXeN5m9unouYTNqqPEZlxqKmD4OrkF0cwH4eAf6M6LMsVc1qV6B1PKcCBHwUb4Ha15FgAei/F79EY46kJYuK6e2D7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JicS2MgvlUGxcQ4pTtRKtaD7bovqcjl3Q8ZlpEpR78o=;
 b=GC5l5XeffbNBI+G4rKtHMuVT3JiqTc7Z9k7OXG8cRGo4wET+2qPegUF0dAe0DWt1nHoe1wQwOcvUyQE5IIzbhl7JTbHMKe6O4zDomFlJvSHguCGuo9QBCYrR2NTkXRzYim7kZbgR17pXkO1z69zOpW0k3/RHNjs5pdWtTB95bZA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 06/10] block: introduce BDRV_REQ_NO_WAIT flag
Date: Thu, 20 Aug 2020 21:39:46 +0300
Message-Id: <20200820183950.13109-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:08 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b646398b-683e-4b53-1fe0-08d8453876f9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30328CAF2D13DDA94BEE9AA7C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gZcb+IXsCPNc83V44TYWX//rVSgJWT5v5OZWOnEFYhfIV8ugRWDxk6iFT02VczWL2FdwHXIYd/yfkapbrgctUH0gjRaj5zL8Ix6eVqg+BXXk9eJobu2LIArUEQbwvtuJJ+5uQNAS7Tfqs+YsDJoeSymNONjIGT4jaXVfYAFXYNZgUUbPzqoTHrWfFYJpqJpQj1bteR/RpWT7w0j/DTAmWRIoS920gAU1HFXhttQQJm9iMEFHJE5NgiWydAAk2i7mVp+q5ggBCQbAHepUG13kEsOf7NF2Sjbn16L67GfadpEffc3kkEi8aCRCQ/0Jm4Ap9vHaXy4axU0NXVKbv4pDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: M/+vXkrmECJWKwrHqe+D0vGbhBdIMLEf62oyugK5aVBJzmVD/4vGdSI70qUtPfzD4UCIvoFsJpvxc7ghhamOUAPDHXSk+eWuAGoBLu5hTgMrvjbHXXYj4PfXEIs7nLCWTkxgKJodynDay86DhwfKroGHmC3B6df0rpCMKfPwI4OcQb4NdgpGUm8Ty7Q+VT0lK9XcvQY79fDbseBVkJiQeRoBkq0+HP9gYm2nNc6dd9KmXcZcLh8HQZbIvz7nBZF9nE6WF8KMOBIe9hC/4QoIi927DJoMqcA6Ntf12qwABHBoNC+myuIIm32MXhQt08XAOU22qFMIQ+pThuqQbfcoV9Oi5kTzXpJEI9YdBCEMAQI0ngeoGmcsNMGpqkfpP2fmEXQGPWn2sUFgGUnm3VTytnaYJYgFXtJbB2+S4gUC0yBjIRY29khzYlcn+M6+V9lPULVIEEHEU1fjhMYxxgipxBoEdIuPloG8WjpzdNKR95ShdUbNhNxvv0iqZQifLoR8km0bSBUZQhRLhEIexf+24/83kh+VfO+8dX5To0Njg94+g1L67aMagGi0/kO/simV8ohwUodXA7LwN7syoYctNgk5Zxxr7GMmVswfjz3u41mG5aeJ3/YeFQQA4fjr4DmLL7M+VL+3GSoGuSPlJ6Z5kA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b646398b-683e-4b53-1fe0-08d8453876f9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:09.1618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxHVP0gmOEi5xgD/S6QxIopfbxOzpjFGEYdwwoiofZXWRyVwgf9V2ljlAfUsgsdrehtS7kw8w6Yd/NDxijNj80F3g8wMR67B9a+hfPdeVYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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


