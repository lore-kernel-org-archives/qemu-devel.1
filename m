Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE122072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UECV6iqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE122072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bPe-0004jL-GY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFn-0007jO-JJ; Mon, 17 Aug 2020 05:16:31 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
 ([40.107.14.127]:35534 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFf-000882-0L; Mon, 17 Aug 2020 05:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaH1oIr199P6DF1L8BZLfqTDzmQgZbGJx16aCHILOb4ShSZeA1cfgN69UsSxK0l9r6IB2tmkKXd9r/pTcleY0ZVUylCgKCEoy07u480uel4VNH3biLjZTSZVkCaLR/Uz77SOKpzxUpPLlMDCGvdenlvz891lrdrlm3vihDLrf6svEhx7yV6Y/FnIMfufPTg0q421HR8/2w3x8XQno50FcOoxHEkPI76tkcf1r5dtIZ6A0HmisrsrYtWnEjYRu7ZfrU/hb/AHt0wGOFtpiVhrmB3xr4SvU/DnR+Wuw17tvU+ok4Rnb0SI4FeGJzw1RaxggsPj1wy2O59pGMIhoDKcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STsNsYSp4m/2BFKyBhY32OikkKbUUWixHdJcLYaK7rc=;
 b=ZW+CcB4j/Fn+QUS1pj9x/aWuJRxAqkOniTgS7DCwuVnBiqBXDj7diFngN4aKCCzgVSW0QX+xjvgOsGacR7azXEJP184e8TyTbNrlAE/JocVamxvDheKoQOwJR3ENw8TGT0H4XfnS7TVTBdyyE0Z3EvpkCOuCXK18wIqm6EHgGjgHDetdNF9RV2oeOksNPKAc2YQFvMfP38mjumxlvKDtseKlwPB5Ts5pC4YSgr1a26nMUAuiZ0gaCsSwM2826pkd6D3Fb9dFoIBiI693gtaTEUaVAX6nhCuNH/nlzyG8LhDjYxDyPc35vgW80JOwFDcxOw0M/IcsZkgD5TXHEyEihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STsNsYSp4m/2BFKyBhY32OikkKbUUWixHdJcLYaK7rc=;
 b=UECV6iqbK65GxTQ0csuJbklIjrtPmxszkY+8UqQGLWPBQJ+YsQ2jPmAee92vsvGeqdOvkNjQYX6ldkWbC8G15fcePdN+9bYllfDJS4Msg1GpQYR+yYGHau3QY4n70sGkF6pkU2R9yl7H7ACZ7mkAHSW8/xITqspGxvclWqwB2Fk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/12] block: introduce BDRV_REQ_NO_WAIT flag
Date: Mon, 17 Aug 2020 12:15:47 +0300
Message-Id: <20200817091553.283155-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:07 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ad6977-a334-434c-b9d6-08d8428e2d17
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852143AE18C69670917FC89C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0E6YDVLjY36xGn3I9YMylH2Ruo62D210Ycc92W3WD4Fb2X7G7evbVALx/xXs9BbYX0WlLByEZnov4OEFH57QSV5CWgMdNBEsDYyttXKJBEWqqggSdGj3zflmB7XWAhZBjdSHW5BdxZuxblc9/D+ilFQyincUcdSjX0A49Ywe2A0FkvbSqALRRLYV17BVybZaNh7DrCQ4ZDOaxSP9rj80hayuToDbGveFxWKk7Fo/+DnTOpCsQv7g8vJ6KibgMSb57mXt+yIIcDm0RUGBMKmcQsVBb+tmI5l2e1ioV/rAqtbo8nVrlcax4XlVy49hstwcpEoBj4O1sScG3ospUCR5WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WoN6jBL3cs4GIGJqXooN86pw5rcMJm4jUiQMaGAwWdtW7MjRjM5EOh/5DVFgoQER1u6IQqAN9WzQoN0KfHSz8PlABhrgp05LHrUJfU1PTSJiv62s+mY49xk40eL5FMWs3tDMeTpUrF1sIWvJimTryCMEXFf42wdARa5zpq8cYOaqLqW45G9HVnxLE/GuBOSRxd22FM3HYhRw5QywXaY/fercFqXB6c81khUpYat5NSPJf+yGP2fHbtHSomRX0L1xT4Dq0fWaN0Pzu/A9h08X1r+D1ZOOeZGNNq8hPRJ7AC4MGQvE4bs1FHcbZPXnywZtbC+gS8/Ztcs5AgcRs7nHMpKm09mtQXg6l88CD6R9IQO/4wtMS1W9BAXqYIvkjKR1W3qsrrPAHM+qFZnDpgHntEWQQ/kczDQag3gWIW5TuLS088P60e18IRZIm2JpRZJyKEPeSBELYwz81YKnlFP7zpE5Y6kogcahUWjNP7gcKyPO4l724TOvnhH/2fJyGs5+T0CETVNrHprLVVzR7HmJtQLoFLTn0cdnzqQVCYMckSlXFJJX/kqhuoPgMVObUVsGheYGgy8onNRCncDBqn2+OXpZDvD80JOF6XEaYAnZsiSYhF1bi94vv9ChxgX/pLDo/wuYIlx6TXmaI6zrXRheSA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ad6977-a334-434c-b9d6-08d8428e2d17
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:08.3817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqkLyVYh3l5VE4MLjJbpD7F4ygHkBoY7yiQe5wxEgDW215WTL7t59e9A4QXtA4ZZR3Ezk9t4AtqGyf450DprCdINms1f1V25kdFyMRirtvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:17
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add flag to make serialising request no wait: if there are conflicting
requests, just return error immediately. It's will be used in upcoming
preallocate filter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  9 ++++++++-
 block/io.c            | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 96b1b9cf5f..fc6d44d302 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1911,9 +1911,20 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     assert(!(flags & ~BDRV_REQ_MASK));
+    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISING)));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
+        qemu_co_mutex_lock(&bs->reqs_lock);
+
+        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
+
+        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(req)) {
+            return -EBUSY;
+        }
+
+        bdrv_wait_serialising_requests_locked(req);
+
+        qemu_co_mutex_unlock(&bs->reqs_lock);
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.18.0


