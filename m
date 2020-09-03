Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44206C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3AB2098B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C1hUcTuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3AB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuZk-00047J-60
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuWA-0007p0-SH; Thu, 03 Sep 2020 15:03:30 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:10118 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW9-0006yx-5T; Thu, 03 Sep 2020 15:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRG01iO5F95+iZZWt+8BstfbUkuAo/C5h5es9Ps/GpswVtVsYTYDyJvDOHzK4h4Sn13EJN5iFIkdiLoHomGdxeIuDV6r4xV78NsgE0DoUxXriOjJl1BeMvs/wIGmYoBvIU4afLtafZF0vnPG3RxbbPTskmJNPJUAcq5UvhwdF8lV2Bx/sXGqx6x2AGcBorxQ3r+et584+SO+xMfci99ZTS8YGvVPKOWFOcS3rcaMR3ec8Kay1iIYvxgF6mc1KywFQz+HeE7xsuOzyQJyb1JxZ/3nboVdThQg7fPhkxSc2CHvVFHmF5aLFXz3n1d6FKPQ5hjB1USjWekeuyIFifyzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6pvx1aaSoLV5qvxaoZWYYwNZIkFsWb1Ubnytv3nw9Y=;
 b=K+jqnjvFnbrTcfgI+otg3bBINDjNEwgd59x12PDZdlZbILIl/5/XGfAY3FeXo+dV1A+xrq/EmqUafPh2uUwM+zXgJs1pyGGv4jGWwIDm49jCtDgqmoWjxNneu2HJB5GU4NkQXtnysqTteueY+d5lOcxyVzidTd6MoYBq2Wqiu7VmVkTEhObky06sS8a/3dAQAUVxHhdUo12b8RPQ+bJRqc/uiSU9I/xN1oumKCk/oMm6PFR+uj8TLFlvPbEuR/pI1a/A0yImPEzjoXzP55DutB6eeBY4FpE+vmPEU7pGnJEiMLdDgAbQA/2Z5va/QBIrhjkxUvSm+yJKgv++xejs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6pvx1aaSoLV5qvxaoZWYYwNZIkFsWb1Ubnytv3nw9Y=;
 b=C1hUcTuIFwkWQNjAfnP2aCA3006/8skmBU39052keOaNfzv1K1Evr8cOizrLhAwG3zeLZf9awXEP56vS+EieeWe4i0Mv6E7LOpQt8HlJpks5tbNPpop6JvEJ+VskngnpP8b5NQQUDUZoVNjzzhvMijhY61A0QkYP7Y0UR3Givvg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 19:03:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 19:03:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 3/4] block/nbd: fix reconnect-delay
Date: Thu,  3 Sep 2020 22:03:00 +0300
Message-Id: <20200903190301.367620-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200903190301.367620-1-vsementsov@virtuozzo.com>
References: <20200903190301.367620-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 19:03:17 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f2e9fb-64ea-49fd-e63e-08d8503c0491
X-MS-TrafficTypeDiagnostic: AM6PR08MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31590FBB1209D7DF44BAB85DC12C0@AM6PR08MB3159.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XHm3UWb9ApjmM5Pag9/dcjk2i+6eP2e8jNyJ4QGE1lqUWGgLSzPbtAtj+1LDqhfB6trkIpIuRbjYOGi1hjjYW5c0OH4sV4kSHhkWztkKi2AJp2ZiaoxuOVZKk5ZjQ6bQq/O0P8BU2uxINoc4Tb6Omg9DPagdyu6WcpczW9wO564JIFgXC7agPTydZ5cG0wpPVVIvb9LxQf4qsztNmo5vQqjqDPrjiLNku3F+SGnA6wcw7Lz8ifCYQZObirj6+vQCv2gluQtYeY4a4ZI5awUlIWEkiHlEZDG0/5RAK0/mEKtL0X+SOvAFl/EIHAOxDqScnUOXrmwR7coDkctVpOouA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(186003)(6916009)(8936002)(2616005)(6486002)(66476007)(8676002)(2906002)(956004)(66556008)(66946007)(478600001)(107886003)(86362001)(1076003)(316002)(26005)(36756003)(4326008)(52116002)(5660300002)(83380400001)(6666004)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kKr4+2vmBxXlbUmqyAfzxYjxhvJkl+HGmPu7GVGK9+ihO+ZTQSUf50DmVDEo8+wEM/gAHvQWAUJZeSvxVlsk3d4LAJgCuT58SDY0CTEF97LAnlQsypUd4CSGWRxOlVQ4ZGjdoZwqctFQnFCRZP8kv0s7jkSjbgg0RZbsl5cwS3W4NhVvp78Bvg3ab5JzlEgtNqvgtqbn2+Kj+huUNxUEJqR4aV9duKKEiBZQN9icniVAeMI2drXe+0XjtsQQ+OMOgIDSpbEYIetzk1XHsq85uXQmPHyMr1wL4JxgeUl61BL9KFilP/tn9zRMQ1MDD9lS/rG18fqwtAxGBpS2W6QfV3bD/4x2iHHxQZWm9p4FOhFJaMTf6X8NwajQxPOpXE3w6mdphD8XcM/sO7TezecJNA1NrPXKfGwekLwuv5TvtSuRZ5wfuhyzDQVE5LtSLRH3pdSD8fzyVeC9JEntfzwSsYYHsl7obNgmXdoxZFbg6ZFpiZr84NvFBQE7vh3yXaWoRwnDtxj2BNUmHZYOCKafcGm6L/Jha+YVijeu3GvU2ox63KDjaAIKnMlZaOV4KOgM7y7go8iIZ/Kjuv3xYBLSu9N5tghbQ2vX3MhCp/jAICQ6ZN3QAAtmhI+EyX+RTwcgR1DTHO0zQRoufTcBoAg+BA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f2e9fb-64ea-49fd-e63e-08d8503c0491
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:03:17.9090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73b1BihgIQC/EPREcfARtSKOiTU7e6QhrVsQg+wGFY8t9X2UWx6hm3w6UqqXJ5WBVuMg4IGp8GEGTlXZI+5yV+/S/kIza0fYbsdvWGaVtEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3159
Received-SPF: pass client-ip=40.107.2.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 15:03:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

reconnect-delay has a design flaw: we handle it in the same loop where
we do connection attempt. So, reconnect-delay may be exceeded by
unpredictable time of connection attempt.

Let's instead use separate timer.

How to reproduce the bug:

1. Create an image on node1:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server on node1:
   qemu-nbd xx

3. On node2 start qemu-io:

./build/qemu-io --image-opts \
driver=nbd,server.type=inet,server.host=192.168.100.5,server.port=10809,reconnect-delay=15

4. Type 'read 0 512' in qemu-io interface to check that connection
   works

Be careful: you should make steps 5-7 in a short time, less than 15
seconds.

5. Kill nbd server on node1

6. Run 'read 0 512' in qemu-io interface again, to be sure that nbd
client goes to reconnect loop.

7. On node1 run the following command

   sudo iptables -A INPUT -p tcp --dport 10809 -j DROP

This will make the connect() call of qemu-io at node2 take a long time.

And you'll see that read command in qemu-io will hang for a long time,
more than 15 seconds specified by reconnect-delay parameter. It's the
bug.

8. Don't forget to drop iptables rule on node1:

   sudo iptables -D INPUT -p tcp --dport 10809 -j DROP

Important note: Step [5] is necessary to reproduce _this_ bug. If we
miss step [5], the read command (step 6) will hang for a long time and
this commit doesn't help, because there will be not long connect() to
unreachable host, but long sendmsg() to unreachable host, which should
be fixed by enabling and adjusting keep-alive on the socket, which is a
thing for further patch set.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index a495ad7ddf..caae0e6d31 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -122,6 +122,8 @@ typedef struct BDRVNBDState {
     Error *connect_err;
     bool wait_in_flight;
 
+    QEMUTimer *reconnect_delay_timer;
+
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
@@ -188,10 +190,49 @@ static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
     }
 }
 
+static void reconnect_delay_timer_del(BDRVNBDState *s)
+{
+    if (s->reconnect_delay_timer) {
+        timer_del(s->reconnect_delay_timer);
+        timer_free(s->reconnect_delay_timer);
+        s->reconnect_delay_timer = NULL;
+    }
+}
+
+static void reconnect_delay_timer_cb(void *opaque)
+{
+    BDRVNBDState *s = opaque;
+
+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        while (qemu_co_enter_next(&s->free_sema, NULL)) {
+            /* Resume all queued requests */
+        }
+    }
+
+    reconnect_delay_timer_del(s);
+}
+
+static void reconnect_delay_timer_init(BDRVNBDState *s, uint64_t expire_time_ns)
+{
+    if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
+        return;
+    }
+
+    assert(!s->reconnect_delay_timer);
+    s->reconnect_delay_timer = aio_timer_new(bdrv_get_aio_context(s->bs),
+                                             QEMU_CLOCK_REALTIME,
+                                             SCALE_NS,
+                                             reconnect_delay_timer_cb, s);
+    timer_mod(s->reconnect_delay_timer, expire_time_ns);
+}
+
 static void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
+    /* Timer is deleted in nbd_client_co_drain_begin() */
+    assert(!s->reconnect_delay_timer);
     qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
 }
 
@@ -243,6 +284,8 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
 
     nbd_co_establish_connection_cancel(bs, false);
 
+    reconnect_delay_timer_del(s);
+
     if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
         s->state = NBD_CLIENT_CONNECTING_NOWAIT;
         qemu_co_queue_restart_all(&s->free_sema);
@@ -593,21 +636,17 @@ out:
 
 static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 {
-    uint64_t start_time_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint64_t delay_ns = s->reconnect_delay * NANOSECONDS_PER_SECOND;
     uint64_t timeout = 1 * NANOSECONDS_PER_SECOND;
     uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;
 
+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        reconnect_delay_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                                   s->reconnect_delay * NANOSECONDS_PER_SECOND);
+    }
+
     nbd_reconnect_attempt(s);
 
     while (nbd_client_connecting(s)) {
-        if (s->state == NBD_CLIENT_CONNECTING_WAIT &&
-            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay_ns)
-        {
-            s->state = NBD_CLIENT_CONNECTING_NOWAIT;
-            qemu_co_queue_restart_all(&s->free_sema);
-        }
-
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
             s->wait_drained_end = true;
@@ -629,6 +668,8 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 
         nbd_reconnect_attempt(s);
     }
+
+    reconnect_delay_timer_del(s);
 }
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
-- 
2.18.0


