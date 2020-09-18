Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F42921D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VPJyFTMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F42921D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL8W-0007gH-KT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzg-0007K4-AF; Fri, 18 Sep 2020 14:20:30 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKza-0004bq-Ex; Fri, 18 Sep 2020 14:20:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9y834d9sRTFtrVjvsR7ntSVOLLV6z9baCGNBo2xQ4UcjqUy/+5q2ZPWM0yA/cJq2/HcC6A+0t9ZyStmziMO2513517y+i1IHXmOIMvog9L6Z9TloXJekr9mS0O5eWIQasK1QWiSUP0FeZOamaR/aLWet3/gfZuUb+KDYmBm+mLX8RW5Vy0PLhe1nbmFPafuwcqdpb8NyYEYtzOJ92sGZhL9myqsYaF8hcpoOAM+Alw9TU3vzkAkduvObTmswst3oVeQsJv7/QZD0OZamB6StVLzUcECNUioOTUPDnhL99XCQi5XTVdOC+Pgl7jcJtFzanAAsjC1OcF3RLmE0fX65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm93Qi+T6AU08KMubEm5erSARbQOXxuOvU6zNpSByg0=;
 b=YriIfsd4SAvkDE3z/31ZTajfZnZr3ClTVU4toJ1/ZYxEOK892pjZqI3oUmQk5ARyCPDOqN/9LJG+gXf56eJipB5Le0MWkF8ab43nmFtxrv3xBoS7uJ7TQNCJXx2bYNxF8/dbWIB/LxjLE93c75821j24h656JozH6nq3iX60xIrGaCXFOTs30H4qCFeRdGRQmlpLN8KtTOw37XDMfbDn2Dsiqpacz2zRnWl8JX4C9basxWx1sSY2HZ5q/20kkEzQP1qEDUcqvSMrCWULFyc0AO4LTOGvgDUqvj7yHn9cO3SDXtcT2MnPJcMKOmx2wjuwBYvY1wRqjU9aUW9PdRq5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm93Qi+T6AU08KMubEm5erSARbQOXxuOvU6zNpSByg0=;
 b=VPJyFTMcCCFtxr2JwkPNazgZ3r6k1X8IBkUBNfJLUkJMa9vl+6vmZhRAZ4L9JgxipD9+22D+7uxiYRKnBPqyiMJl/byeK40/hmpBUCsdynmkoqIYC+Zgkv2Ny74SCPhPtnnY85bYaRe9DX1bpBV3vSt3JKRUzMzKKbWbhpnws50=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 04/15] block/io: bdrv_wait_serialising_requests_locked:
 drop extra bs arg
Date: Fri, 18 Sep 2020 21:19:40 +0300
Message-Id: <20200918181951.21752-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:07 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5b83bb-3b37-4005-9760-08d85bff7900
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905175DCFBC68C189D62702C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPVWzPDiXlx+lKOXqrMmPJOSh1oR0Ld52/C7mRu1co4DzKX/qPcFQ/rfIz14vGeTx/XmuTFgBrss6fhof/mwu2uVb7kkz9GxLGF0SY/ywra4SO7EgY/fbL6kS8RhQqpUhDm3iMFW+k8qnCQFdIL09aU1H+5/77Uj+jAsHwslX3tnF7O1LuTI9481mNfXzmpHLclmBb6AAVu14waj+vGa4PPyITog1SCPg02IWxpwyQQi0Wdism6m4OcPbjnsaCD+ffoYHEbXeAdHnEOMODGtET9Z6aGOnH6yuqdJNPrexbmmHSJrX/L9y85ndo1nWHakKq81un9xEIEtizWlayqnU4v3g5b0SVmD71zI+0FF23TIjpZpz4e6ZJB1a5qXRfG2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(45080400002)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: W/p/3OGzB5Z77RL64DeiluoN+Upao0gLPohMTBC6CZO88ZIVo5fllpbIu8qCJIgFIpMDMMk6MFoDMC8HXG2u+lxIfjQ+OZ2pcGo/aLtaph0wqYpJMjmwzPzViD1MBvxajbIb/8nY9iQ8dnAxJe8zAbE8N3gt/88g/bCdLZNU1fJ+yxNjkGcQ22yiOfpU7QYk+47u+SdolmsQT+VDw1PL6K3TdBejayRly67gr8vvQgnYpZkCY4A5HepqkyxUcZG6l7jFNHFn1tFH3KkipjKkZFdq2syzffJkl2BqmG4To8f0KasRtNLoHMoE3ODnuRJ+Cgj0kioB17WFgKDJJfTcMj44uRS943yiDtF5xORK4jpgT0MCcILqcj8AGqRFgtoVbamxs/1yBnBzuI6hKKFFdg03nkQxjYgCBxiG+3Kl2L0DE+YD9qdBJvNeE6BZnlJ9RlN/NdTtbpUQedzIeDdO1OFBbSA1aQwbnt1WRniN1cxmlpXS/vR9W4ysdLGGKGlThgFGDNhwwiOh+I2gLgfHEbJ7rYa5gxvp6B1llCYYXhBgem3CBNjeW3PKOcncLJfhY9H5as7SvsSJcpsX4FXx/ZtoY38lDSId1Gr/f4cG4MX5NAxx6vBufjzW5aobz2v22/Rpw962l/IQ6xo3axhiaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5b83bb-3b37-4005-9760-08d85bff7900
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:08.3081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9/qbE6ARO/kWfqssdQF5jCYU2zlDo+/2KhhXtyERvQW6tyty5u2VwaQ5H086vrG/vSRDglVBn9fU7NRSJQd9xWbcza1VabX/VENzGVCUXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bs is linked in req, so no needs to pass it separately. Most of
tracked-requests API doesn't have bs argument. Actually, after this
patch only tracked_request_begin has it, but it's for purpose.

While being here, also add a comment about what "_locked" is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index c58fd36091..ab9ef7fd1a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -761,16 +761,16 @@ bdrv_find_conflicting_request(BdrvTrackedRequest *self)
     return NULL;
 }
 
+/* Called with self->bs->reqs_lock held */
 static bool coroutine_fn
-bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
-                                      BdrvTrackedRequest *self)
+bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
 {
     BdrvTrackedRequest *req;
     bool waited = false;
 
     while ((req = bdrv_find_conflicting_request(self))) {
         self->waiting_for = req;
-        qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+        qemu_co_queue_wait(&req->wait_queue, &self->bs->reqs_lock);
         self->waiting_for = NULL;
         waited = true;
     }
@@ -794,7 +794,7 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    waited = bdrv_wait_serialising_requests_locked(req);
     qemu_co_mutex_unlock(&bs->reqs_lock);
     return waited;
 }
@@ -876,7 +876,7 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    waited = bdrv_wait_serialising_requests_locked(self);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
-- 
2.21.3


