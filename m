Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA1C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE49204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o4/2g1gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE49204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZPH-00039p-Fu
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO1-00019U-0L; Fri, 14 Aug 2020 09:04:45 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNz-0006by-2z; Fri, 14 Aug 2020 09:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWQX8kLQp0tFmjXs2n5zTEYf+ZeokPJC97+9myLnyyr12V6v50IsYkTx9ypDryXbFXXsYIO+GWMZiWDcHtY1o97YLs7dBBF1MOaXTQB5jIUdScHS5bngWkMjxwL493rva2vqgvqKbp6Ne3TqpuNb4z6N0Wv8XLhoi3GGjKP3KBf4XKjVu1kMzLheDBAF52ZJHwXqRl80TjEsPbrjz7aUj2UwFJPH0C+6nZJ1btgorkx9arhw1GBfr/c5BVi2dUejq/4dxej275ThWPNekUp6ShjYLWDsygHNnf9X86Cja/Vg+3H0n/Km5/Dx4ZrPc1IbQyzN6mcVU8l5S5wQFwBXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1jc8KGMcACArTVUP8rR2GuyCLG8sJUmHxyF3/a85Sc=;
 b=DnUh5y2RivORe8ME4NqY8NO7KUzkA/DnLIEaVuCcesmW7Tskndv+pUz1BVcwiR6MX4xIOnTKowKYJtkiuKbgzN2ryjfXy3XGll6mJuuB/LYyd1iyNlGkBagcrjLtHhmG4RV5ZlOfmgHzfM7WIMF8su1p0CTdfzbvaFaHWd81P1iDWRZRYxl9gj0FqHBux3ZoYfr4peZpNeJt/hZFmtq4w0uRWiT5bDvn1Pc7N9Mh00yMBGXDTMbGWKPpXHVXvnX+1QHac1vx7p7bsxRBDSOB5nbm0BPdOyXL8EDYffk/PKzyOV2RybkDzh6tab3Ap6qUaA7cp6zcDtJDreD7LWg8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1jc8KGMcACArTVUP8rR2GuyCLG8sJUmHxyF3/a85Sc=;
 b=o4/2g1guFbVJTvVt3A3fzgbgrJ/SNbUZNbToZ0IrVW4SFwNgxXi4Zuhth30fXUglvNKfpvMS/2q3kucr/HtJtp94KTbbmo23tRIiPHJxYQUCGi/q6nhnhijq76HqU3u7+si/RP1xv/qM/aEwZ88MYrXSXGpCAjCUA5OR9bGI5lw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/9] block: introduce BDRV_REQ_NO_WAIT flag
Date: Fri, 14 Aug 2020 16:03:45 +0300
Message-Id: <20200814130348.20625-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:24 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cbd8e6-7d58-413b-168b-08d84052920c
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29818F4F398C9F1F707D7EB4C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AqCIdHSINtwgBNhti9wU+BBjDJsz3WVKPVfyvOiDqCv6uA6KjrU3RC/lMiFtSTATbZA5kwtLnVfQ9Kpdn6B3ZLn4Su1aWEPcPHbDQ+AI4Br4aLXm4MVQNrsOoIYQ28JDgv7mzDfSacnSYdi861DVLPzmOhTjRHRV/isxC4V8ahKHoNDircHvzmo37L1Wsor+tlCqWeHeIGLaBK+u2lKbSUmawPR3kcjz7iwepaNFk/5hkROqewNKvgGfAviO1xdzrxSXvKhe3xVzAWVaVyMWrJxghOM8/Ah+SF7/H/5iiM+ljrp1B8KOo5jhx+JdEIUzhgh1rBBdL1jWK2KL0dvpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Jbxl1YAJs3unazLINKJi65Ifq1sdqQrWSvmyFsR8Ot92c5yyJTGIeQTkRSgY4guLmgc4szUZOHk6Xgd9H55qvBaY7nU8odOCMW7MSDCyeFJYVWCzaeF20Wqiof0/oODajjXPxLqAGEXilIhHtdudOEk1y0aWBzQt4NUPR8Dk/u/YXDRft4XTSqg4TJNsjFGYCRLlWSbXqcBv4mQK4KtPwR9Mis+QTIKkjFGu6UbZw0W+fPc0HUnP2aapp4IyQEyX5V1wC23xYS789f47FtYMyKf9p3dfHXrEDle29+X68x3MiibUeCyAXeoqPOFn9jveLrK3eQDAsPMzALquOVTrK7UOLzlkeouiE37HslrSPbipl3MydlLuhtmnPiqEsCZrQzX9CRJmMHuqGCpIe52Utwrx3SrAyaG10eZG9ZiFb7Qwoeu2gmoQ/FYsZqQCDKejsILaVUdaQuCsiR2KeG5weMtphzZwZEn7bHiK1saMHLhU/RuiWHrerBjm4Rpa28soEXhoirgiY6GydeO9VJnYnb78UJzDhHYOVbDvIWQjsT2yV1GK3ulSiAKEVhtTkQXc7+DnBC2SG57CqbL+AO4jBh3oNM4ibXJa/fS1nBG8T9l/DucwN/P8wBIdvS7naOkXWSyB/tI6stHTXnTeJozTfQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cbd8e6-7d58-413b-168b-08d84052920c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:25.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meGnfx0eERpHOCOAYeVBxcR6F+/jRguVj8DbTl2SgNKeJKmGmGURaiG0X49nTcJoRK+oHYMuf5bayTGkG4q5TXgWneZcoKiQ8m1l4NJP7oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:28
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
2.21.3


