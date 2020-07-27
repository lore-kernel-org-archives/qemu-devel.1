Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2276C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EC12074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Onp8O/WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EC12074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08DZ-0004gc-R6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Aj-0001ew-L2; Mon, 27 Jul 2020 14:48:25 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Ah-0005W3-34; Mon, 27 Jul 2020 14:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCa8WNsZVwMCgJrLpFDUvdGqqXm9FomhexN7iquvcULYRjYHMCC1L18i/JhWSsTNVyNTh7A8A/TKooZ7ocnKN372bwOt5+78/G4bFkRNCXxLoSCcxiesvXybt8lT8D2TQyOv0SkZvEhI5mY1LaZ7QCXP+ReTYOrS/8b7EilV5bSCz513QORfRayMbDqxhAjYhofMCwZNoHWX+xI7Zw1eUU2DPuVhKFQA7ObCNqengzHN4lQI/E/7NQ72NwG2aZtLHK7oBTcpv2njfhsmNdwyciljbDJSgRNPElIR/Dp+UzTnM1cZVDu3lvHBE74VX7E8I2EA/YT/hoG7Yf23UhZGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI/pAdIr4pqc72OzUB8s7XRbHbjte5R91hAqZxcK+as=;
 b=bvH3R6A4K8ajYavG0hcPyYVJrUcqBMBDmfEAaMgjHAdjWdOS2scfLFbv3NyT+yQFix6wDVU+zD4ANLpdGx+MbaOMQwKoJ+EaVBGw47d2ooD/M+VfI9MgnaDpClvmJjV3ZdORXAkvH52B/NPOUCVXhfZenk1Ahi79qeLSE7x/yLhc2tkQSC/+wQpTp34fIWka5QxTc+QO+4gs7tv17jN1Kalo1FKasLdGbd5iSFZ2uo98lqW5/FchjAsEfNzFofEas3SNa2AMz0hK+5X5c+lLdlF1AAVrIL/32ck7rXQvxwb1Wq6vvlEnc/X1LFMtcYc+3Y3hgoQvvvFSLbO0pYra1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI/pAdIr4pqc72OzUB8s7XRbHbjte5R91hAqZxcK+as=;
 b=Onp8O/WHAhfoXkHFL+4/fWWCKv6U9P29guIuinwNI0TxaVgXZqgkw3Ngssg2s8vr8XxueDmuhGBIS9qOSPW2P2HHP8u26cAPjf+/eZGTgammkZu2Na+rVIb9L8oIPc7mw75/tp/clxP19KOkLLq8w9b1s9TaDvWYR1SnaY3Lf0U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/5] block/nbd: nbd_co_reconnect_loop(): don't sleep if
 drained
Date: Mon, 27 Jul 2020 21:47:50 +0300
Message-Id: <20200727184751.15704-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727184751.15704-1-vsementsov@virtuozzo.com>
References: <20200727184751.15704-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0701CA0033.eurprd07.prod.outlook.com
 (2603:10a6:200:42::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM4PR0701CA0033.eurprd07.prod.outlook.com (2603:10a6:200:42::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Mon, 27 Jul 2020 18:48:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3664a617-2837-40a1-5756-08d8325d9a2d
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5079912CDC2C13B0C14C94C7C1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkyhKCMHdpzKnG8da2L4KyeC+CQRhUPfH8OND/ZLO/j94LUWZUU/IvpggkY57Lu+SkYkfBhTG1Mgo6b/cyJylCIS1xZWJ5eXea/QMwsSolkhs7D9TqEcSvd/5wX73svsrJ3rclHv69G3W6xPfUDBXC6ZQhfVFssSMkSdzdkE2qzINu6Lt+Ggw8xs60YeHVyuD0IyOqsO0DJsHHajEepqpjwRG62A9DdJ9x6ZowSTJnu5am/52q03x97+6+c7PuI7YPRJr7VhFTYIdSwstaWfn690/cqTEHkAXeUhqgzHchp0tq9RYxhS1clbpR3mrVT2QrOJs4k0v6ignXFWC6EDAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(5660300002)(66946007)(36756003)(2906002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XvPPSC7Su/x2nC5Kqv3KtgzSLXkpPqXLbv2kFymVSpRxCytP3VF3ELSESCNUsjG/2gM1lyVr2AbWWcG4X5N0QlJKocbFBpFhZhvgrG2tMdicjvkt2oN1AaDSsYLyICHRlVnWn46Skb/PPltfv7+wkD6BokwmGPxyf59xurSec5ZkaATKA6v1PYwzpeIIHnV9oMO1H+Mf4uMFnwH38rCjXgwED6sNJX6y0sZYQ3COzxibglVA0bqQVpPpE039AWimDWwAdTf2hrI+Pw/xbRh0Pa6GvKng1fcH23evSLl9zui3FnmfYA++qQ4GUvioK1BwMGLZjE9/68mKt1SvprW2oC8B01V39T/Mp1OVtdFtKxwRweHZLphbqqRNaIVQdg+HwDc0zyJfuwDzYWshV2j30h4qIGvDjIXbtRQrLwW3bkqfWlG5paihHN+cyDFZXmzePT+moo2D+AYMIu67sSXwS9qpydPuzTO/niqs8CQpcb4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664a617-2837-40a1-5756-08d8325d9a2d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:07.4329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq4uBH0gV3Sc4asltchfPpZ0tapkeYF7aPM5NPybzwpyxUv1hKbMg+nFrub1nBww+z06njYkJmRUDE16yJZVXD4x+x/+L7NkdVu1fOAGldU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5079
Received-SPF: pass client-ip=40.107.2.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 14:48:05
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We try to go to wakeable sleep, so that, if drain begins it will break
the sleep. But what if nbd_client_co_drain_begin() already called and
s->drained is already true? We'll go to sleep, and drain will have to
wait for the whole timeout. Let's improve it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index dfe1408b2d..8c5df68856 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -341,8 +341,6 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
             qemu_co_queue_restart_all(&s->free_sema);
         }
 
-        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
-                                  &s->connection_co_sleep_ns_state);
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
             s->wait_drained_end = true;
@@ -354,9 +352,12 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
                 qemu_coroutine_yield();
             }
             bdrv_inc_in_flight(s->bs);
-        }
-        if (timeout < max_timeout) {
-            timeout *= 2;
+        } else {
+            qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
+                                      &s->connection_co_sleep_ns_state);
+            if (timeout < max_timeout) {
+                timeout *= 2;
+            }
         }
 
         nbd_reconnect_attempt(s);
-- 
2.21.0


