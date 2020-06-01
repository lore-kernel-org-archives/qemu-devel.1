Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E81C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9342073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fj6UlBx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9342073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp3G-0007FE-1F
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouX-0004z9-C5; Mon, 01 Jun 2020 14:11:45 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouW-00027N-8f; Mon, 01 Jun 2020 14:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfHboGmhLqzKoczWKLksxaej9PyU8ZdvQVhJpIy0a/QpfdpsIcfbaKdNUsNgFyyjPTEjqAVT64VCiSwq5l+Jz3+OgG8JTPKmmjK9vr4+QWpSLD0D1HQyxsgGhAhlIENOKCIF8AJ8rmm0NQiBCzpO6BHpwcfGIoepzmOurxaYR9oDlIu9saftl+umwhb9dqw7ETOYTb2EmA3PuqtyYWcvMseXQDytvHAUhuCRI0pwW2TQUGgh62KMVmN+wcvobujgdWckcmI/fMoRYoJflRF/QfAKlxmvNCNvMKRoji/dtf+eo0JnzLtdB75xF6Y2iGJWm1xDMa+tHcOB7iohftu4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbWcWBodNTDqeMIQ+YBmYo2fU7QxMBZqhNvrfjzyMSA=;
 b=b5embH5l/A9N79L8NUQIwmOSj2AjK740tfJAhgzsuhFguN9Nte1lTu/VCftKIZI37FZEAx4S9ZTChMeMx3L197aavovBNi/O1vg8QW5pyl61XFPJJaSsNaEQAvrc7Rtm0100pRbW3bs3IF1eM6mGfj6JXD4BV+v8kKabQIRA7u9o9vCkdRf1qSF88iTueu4M8S+gYXKd+36o0si0TycOzXAwCsgXpStqlfx0qqd0ePnIGrgSz8Q23t5Zp+mm9fpSy7HZejcnoAPwM5Ly61tDVKaQz3BDSucND6xqOCHgyMAZ34OQJHr+LjCsvxQG3UvCM6hgU++fxq8fQKpDKX3m2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbWcWBodNTDqeMIQ+YBmYo2fU7QxMBZqhNvrfjzyMSA=;
 b=fj6UlBx7fbpS/2VMCqWH4kZv0WQfEXi5I/toMAX3KrxtaG166TdyOqX8fANe/zE/2191LLWCaOvjQYw/He2DnB180RbDdC3C3mjYaRrvScHvD9hmmN4HoEdxAY+oxEBcDWOmnwRTxNQepk23rdfPNwxUoMXAfN9dHw45bMdj1lY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 06/20] block/block-copy: add max_chunk and max_workers
 parameters
Date: Mon,  1 Jun 2020 21:11:04 +0300
Message-Id: <20200601181118.579-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45762ee3-8c0d-409c-ac6c-08d806573922
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53175094FDBE8B09C2B0207BC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:20;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AXyk0Sf10ncue1a1+sTcz3Oea3YIBpWakJmliCo6LGsVBem+CYEf7rb3nP5oHZ4YZG5frHX796bYdC0L5+4RzRCR+90L8IoEzPD5JL7/H/Ijc2yhpnIhRl+aBMOVgQi1SJN8k+Py8ryiYwHv3PwTDR24B3AIZ07kGyAx7o/T+s7LIXSwmEsU9vudGElCD3NDomAPjwwMxVIyc9RTpccTWcFvdMDhH73I1l0Db8a2B99eSrgyhIs/1qVGRe07fRS74YzfNFTadtt67KL2Es3G3wwyfp3d5G0bBJj2LJDHnOTr83bIDB+dRWTGcZ83QfXIb60/00g6D90uGwFFUJLGnY+JKdufo0Po9U+jC/Hzm9Gc0IS8rMrVbbVDtx3ggLu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Lz/bSZuqgGoLRwNI4gT0K5bn5ZUIWrmqYtXKjoqRasMuvcJo8q0ZaqCz/wIBflaSssj16APWjZD+a7yWjxTHBJiaJViG/M5YB3MRMMnwdMgUme5ZroV8fgI74slkH9gkm909OGIii3FbVcLROaGxTozWBb4p95R2mjXJuJ7J3BSEwRJ8P2nVJdH9P5ZyHX+VpHVb0WdDAOmvKq7j5VP+ZrTzUiJEe66Re6NlcJIvFmFy0vRZd7z7ndU8AVqLLYxpK+oQvKadyIj5QLE432RJVIYyafNezdeDa7hckTu0/BOHbwxdP7iXgYZS2HBoDpBHpxInOmacp047baStXmkFDsOV9qmCyu6UumbNicoaLSZ9DvZBABIebaz40mxsl2m/PqmMnPDErqaTuIWJndMLfS4Vt67mNbmm5hC8huUSAKGjkFlZmEHM3RifeVgiJGk5F3ZjkS0dk3ysbLIB3SoOw1RnzIf/82HeS8AxL7ZLEUk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45762ee3-8c0d-409c-ac6c-08d806573922
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:36.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iUEST8dVetaSsyORvbbREW4PU0/4MeOnxXjoO//ARsDOUlBSMdyGVW8k7nSTVXnc0rbJzjMs71KlTGt9sPfvKvsMWNYnUjY35skudyHR3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They will be used for backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  5 +++++
 block/block-copy.c         | 10 ++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index ada0d99566..600984c733 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -47,6 +47,11 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
 /*
  * Run block-copy in a coroutine, return state pointer. If finished early
  * returns NULL (@cb is called anyway).
+ *
+ * @max_workers means maximum of parallel coroutines to execute sub-requests,
+ * must be > 0.
+ *
+ * @max_chunk means maximum length for one IO operation. Zero means unlimited.
  */
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
diff --git a/block/block-copy.c b/block/block-copy.c
index a0477d90f3..4114d1fd25 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -34,6 +34,8 @@ typedef struct BlockCopyCallState {
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    int max_workers;
+    int64_t max_chunk;
     BlockCopyAsyncCallbackFunc cb;
 
     /* State */
@@ -144,10 +146,11 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes)
 {
     BlockCopyTask *task;
+    int64_t max_chunk = MIN_NON_ZERO(s->copy_size, call_state->max_chunk);
 
     if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
                                            offset, offset + bytes,
-                                           s->copy_size, &offset, &bytes))
+                                           max_chunk, &offset, &bytes))
     {
         return NULL;
     }
@@ -616,7 +619,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         bytes = end - offset;
 
         if (!aio && bytes) {
-            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+            aio = aio_task_pool_new(call_state->max_workers);
         }
 
         ret = block_copy_task_run(aio, task);
@@ -695,6 +698,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
         .s = s,
         .offset = start,
         .bytes = bytes,
+        .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
     int ret = block_copy_common(&call_state);
@@ -726,6 +730,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .offset = offset,
         .bytes = bytes,
         .cb = cb,
+        .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
+        .max_chunk = max_chunk,
     };
 
     qemu_coroutine_enter(co);
-- 
2.21.0


