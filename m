Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7570CC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4615F2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SLUIXeHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4615F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Es-0006Go-Jd
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Ag-0001ba-Fk; Mon, 27 Jul 2020 14:48:22 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Ad-0005W3-Na; Mon, 27 Jul 2020 14:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1TaIMlNtpGkdFCQ/jY46wZBoTiBmxUz74njFyRA/uV+6c2VxEibKZ2LoljzdkF/o2sktmzCqc9qTxE8ER37NRhYIECZQ4AJHvuAex0/0knPAct8DgjnHwuEflNR6VYZyTQFFv9raK3zSKdtd5KeDAzfz6qwuy1wgRKpNfqYBkxhEKZkvnC/3enCArjBNjJAfQZFGpYj33oJO7+gNycwBsOVyjdnyoRdVGr4DJSz2yVJd7PmFMXmOPu+4dBx9eNpKksqCRiO6u8GFhFnyL6B4R0EzCF9trF6pQsWzOd0fp6Zlrpr9PbFCZIOo3oLlGNaWd4u2r3GPmQKPdFmJGmU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSuopigKmBe/zkgeoEdZpygOjcGfEfEnYtMxnrBHRxY=;
 b=GpnzJB/XaDerIzlh9PPT1rxXBP+H6qOXJ/u0Nmg7+v+lxItW5zRM2NbL34kyKnmvTTwguHzmbDymLzndydKDsPlYJJZUL0YZ6aI6ASsCt8OWEWhdd0mK8El6WBKhkwv6ec8wjqXIt3FoevqFoKaJQKwUJ93lbHzCzCnyqsynb1ZeNDNGPYCg6t7t+Qt6LGCFoOZOSkQzfz3tRU/BU9CEKv6eaFlQRrGXWi/lQ9WC3oxVZVjLRwJgE5KRzqSVl5iFZ+9BR6Ca+P6SGqjXyvVo53rBtos51crdiVzqB7yYInxOEGye/nvFz4sKss5KPS+f8KTuUnhCQgrued+7uNS7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSuopigKmBe/zkgeoEdZpygOjcGfEfEnYtMxnrBHRxY=;
 b=SLUIXeHk+NjjlkJjGgkrAWIiDC0fAyz4PC3xlr0HJ/kWubysO9VJ6oHCIQVWZfPmfgZWnG3xBB3ddU0+yDn4R9VPeRJN0UqsFleyNAXLhfn3pfGLFqjsOh/VpcPxQwJoboq86Fs9S+LYTVwrbhiLK/T4hsMW3GN4CclV86nEu2Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/5] block/nbd: on shutdown terminate connection attempt
Date: Mon, 27 Jul 2020 21:47:49 +0300
Message-Id: <20200727184751.15704-4-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43634348-8642-4685-6373-08d8325d99c2
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50790170F34D3088DDF32323C1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6wT9i9rjcgYzHyIiFcLaY3EfJO1ll9xwzR4PkrRCKfQOnncIRNxedyDOIpzdb0KlKQrr/xA84wUj6+rwDXC3FcrjW3xq/T6yh1/5loyWDRnV45NRC5IwKAq/JeFCjI6EI3rarB535hdoV17dT797pEePjyOUt5Q0LJJtNklwTYBPv13gAxO07jmyqAjeSk6P2jS6GzvYcWF0k9ZBKlCAb4XBF8/aci7I3f+kZx1IwYig3Eb4oV+M7U3VGmdEPQ/CAR0GnNTDK69gzKhINCgqkt2lFcb0utSKpfvRAJEasxAwS0KfwWvJtRYuSrHzcEb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(5660300002)(66946007)(36756003)(2906002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1//8SslSRYtrLKOu+GUCLthkxY7VeqM3CP6Fyf7XBKlVNurr+VeTdoLnyTT/IeX/gbNm+SajhAWCR9YoXEVWAB8q7TWuWzRQFuvVpahKMU+xwhNO2/h+ha0IiWUSPv3Lvzyb3yi1PXcfMHjaSQ1SLHHpso1AxDMgTEwoTzikTu/xYX4ijgu63aSiHudMKmGIaJsJlieyZKtXaPlX3rP0rir+ZX6GenA2riFwb7NbvlZhQK78Emarg8dM49/GBqay5PSjCCc9L3GFrvh2UcKLkkBZJlRqlcPPQljOlP6Nn56wrhvIbl6G/fepFa5XCsBy9OcpFP33UM6oAUeBGVwU/IC78/g/AaAox3GQEAes2zkUJrg13TeVGHFWS83v+XX5rKuEi4eJoBjQ4XaSoWPItavs0zIaVTQItg4YtXLvjD+BFJwarvCboESNJF2OA3svgYhCW6d6+WO44l3YWEnBJaptiImaKhGBnPBcKhFMCF5yJUykYacXuFpKm0CR1+aX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43634348-8642-4685-6373-08d8325d99c2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:06.7051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ6vmGd6a8qoyl4Y+7gt5ngbpNFLw0PPfP68h+LUeQUvfjozT7yHUtuEzX1EVlGj1w1i2CWA8YFaMu96kB1SzfUOUtq/Sckl1FkGp1JEK/8=
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

On shutdown nbd driver may be in a connecting state. We should shutdown
it as well, otherwise we may hang in
nbd_teardown_connection, waiting for conneciton_co to finish in
BDRV_POLL_WHILE(bs, s->connection_co) loop if remote server is down.

How to reproduce the dead lock:

1. Create nbd-fault-injector.conf with the following contents:

[inject-error "mega1"]
event=data
io=readwrite
when=before

2. In one terminal run nbd-fault-injector in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
done

3. In another terminal run qemu-io in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./qemu-io -c 'read 0 512' nbd://127.0.0.1:10000;
done

After some time, qemu-io will hang. Note, that this hang may be
triggered by another bug, so the whole case is fixed only together with
commit "block/nbd: allow drain during reconnect attempt".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 6d19f3c660..dfe1408b2d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -209,11 +209,15 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
-    if (s->state == NBD_CLIENT_CONNECTED) {
+    if (s->ioc) {
         /* finish any pending coroutines */
-        assert(s->ioc);
         qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    } else if (s->sioc) {
+        /* abort negotiation */
+        qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BOTH,
+                             NULL);
     }
+
     s->state = NBD_CLIENT_QUIT;
     if (s->connection_co) {
         if (s->connection_co_sleep_ns_state) {
@@ -1459,6 +1463,9 @@ static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
     int ret;
 
     trace_nbd_client_handshake(s->export);
+
+    s->sioc = sioc;
+
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
 
@@ -1473,6 +1480,7 @@ static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
     g_free(s->info.name);
     if (ret < 0) {
         object_unref(OBJECT(sioc));
+        s->sioc = NULL;
         return ret;
     }
     if (s->x_dirty_bitmap && !s->info.base_allocation) {
@@ -1498,8 +1506,6 @@ static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
         }
     }
 
-    s->sioc = sioc;
-
     if (!s->ioc) {
         s->ioc = QIO_CHANNEL(sioc);
         object_ref(OBJECT(s->ioc));
@@ -1520,6 +1526,7 @@ static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
         nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
 
         object_unref(OBJECT(sioc));
+        s->sioc = NULL;
 
         return ret;
     }
-- 
2.21.0


