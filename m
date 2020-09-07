Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9974C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7B205CB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pOwC3SLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFENl-00006J-R6
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKQ-0004hw-Kx; Mon, 07 Sep 2020 06:24:50 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com
 ([40.107.4.97]:49945 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKO-0002LE-Nv; Mon, 07 Sep 2020 06:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzwUBFVr0DHLxmpDQaSVZQaLMI29CJXD+kuqfCcZ7XCamm8MeuGIjyQkvBSMC7PPr/hz1tXxFF14LgOMsUhu9q/etJUArGWRsijvlFjcF34ZDuq+enEc5e/GgADD7ewr4DKBEXubGfWYgkKyLZvd/WY7uwZUy/nXHOl3kRweXmV1KzTHnDCFRLcB0Jg9KGxMYyaf4eiF/T2BCy35h/hH27psQfpW+D4Kg3e7vgEttflA4niZiE3aYL0nO7zKHmz0hTn1Kx1QSZwgrZIDsE2Q4rJsy0ViA+Qm4csDDwaQRGMmcfvydosrZm7bSCeSW0byECKsaZ7DkktC7q5CCU/fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h6LK50eevMYosi2nNQG+vN2FqmSAWpH4vvJtWHzFeI=;
 b=X+3ZRAL5Cj0oolN4DMWOO6zgxzZ8NKR4Pv12iK6/06ZAtZ5+jRlHgl32qnOkVBYNcvFoASaW0rHYhz5dFFW4s5Pkit32SlY17HMjiNxOm5XFJp5qOYzokjJWQCIc8cxyo0FezSQCdpoSnCPHcq2yEA2dpX+b0rY0Xvj9RIwUBkTdwzQ+XPWhmXhQBdaNMoSMYZLjdHcygWgyE/S6FPn4eBww0Ou/LM6fGwGXJ7DtYLZz+f1bdw4nnT/pvGtQ4Er7mdBvmNQ5u+MmDybKbER2+VkColVyAsdkUwHg5rcvYbqUZTtCwnXIsuHDLOUqrkCXSo986nUHR/ySNGZoo/fRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h6LK50eevMYosi2nNQG+vN2FqmSAWpH4vvJtWHzFeI=;
 b=pOwC3SLSeD1fQhKQ9vIUULmuxoo5zAUmWkrj3NUg2p7sJk0Joax9W4Zhem40nJgwa8ZKwhN93bWbuzXm5W6dShsREjWegtkZ3lnORKRK9Biczu6pAKRZzOj8lViKmakcNUQuhhmR5Vxd89kbGiVQokr/SIFO8lsVW4IFo1IIt2I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 10:24:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:24:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 1/3] block/nbd: move initial connect to coroutine
Date: Mon,  7 Sep 2020 13:24:24 +0300
Message-Id: <20200907102426.24766-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200907102426.24766-1-vsementsov@virtuozzo.com>
References: <20200907102426.24766-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.137) by
 AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 10:24:40 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.137]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825da04b-d2b4-426e-d589-08d853183af2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47229F1FEDEF7EE92C70F43DC1280@AM6PR08MB4722.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfuDCfoJ7UMBS47HjtiVnTtOTeCE84l9tFn/XECH00TNPDC+y+rKwJRNIzZRaAfBwYrCDg+SlRcmCT4N9eeZJeB5wTka/2BJ+rlpYr6wV9D44caEATONgn24zluQaIkSXwuMb7eIdkCy1WmJvs3JcDK5o/XT9zmYxXDV3wGO/zVZmWy5NaKUzQRfdOozJX7aEOO//eJRQMA+U4c7YZoO5wQq98mqwPyh7eACRNrpP/3uCWwy7ppiCmBmxleENFC65w7koqhOCtg4eIhPP3lnP+IpsI3AZVpYliP54XfZ39foDteqCwIdAqTq56rSkZopiOcdQ4OrsCyqEk8DGfm69A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(4326008)(86362001)(83380400001)(36756003)(956004)(2616005)(2906002)(6916009)(16526019)(186003)(107886003)(8676002)(8936002)(66556008)(66476007)(66946007)(5660300002)(478600001)(6486002)(1076003)(6506007)(6666004)(316002)(52116002)(26005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Gq0CykFXJSTldTbxlarnic5vbcisrvU/4VUtvbi4bB5ZgQzkxohELcwUGZu61kRhX6D4pmvVhMLCNA/ihefCY3CMi9Mv4uFl5lWD8ngo4hZQZBNRa2YWvrOFX3uISeV/sW8fm4aHRVxxqGjDg2t2q48DNR58W45UnWGUyX5IKJJ2LR1Erevps4cebLIZPbIwbT7Z1Twn5/9GQM2Zf2wfPkeFoF2tQ1PlQh/ADVX1w6i+h4Dsu7wOSFNKiM+51svT4bYfPAeHNGoc+gF9b5555jLF1po1KHBj2wK6Hf6ccKGFGtw/lBC0OEXLEbpmfZj+yxl/p+MKWNxeqqYogC/U3uHAyUEkt41Bk6eR8yoDnMjS7UCrKjiJFJ0+/DJgkLOkdoQ3GCJ2dFp1BMzeyBTd+fPgOHcMWwU9e8+6D8ojjHav5PYK+ALx3zgDTx63m5b0EynhB6zen/AkafZkCmztfSs+GujDdZherdss6yEFyXH23AL8d+2f6102gQIAgTgA4zsE0TjY9xXAxoNvuez8K/hqF2UH8I+Q2sHjp04ZkjiiaEDE9fO5yjsYBgG5dJpLZAedrMIDcLOB1aUiOyfkcttfjEU9M299LnUv7oLReeUYhj74qD3ItXkfyr8UXGlUSdcEdsX2EgBWFhiRnsV+Rg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825da04b-d2b4-426e-d589-08d853183af2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 10:24:40.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz9xUnYA05UY+V2As1vVzI4h1Yj7iDXqFwJL6zDnT6+WUiPhfyvK9K1uX1Kne7WrDs1T3/BmPIXK5/NuI9tqN5x8lrD2xxNlmESyHfYImDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Received-SPF: pass client-ip=40.107.4.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:24:42
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

We are going to implement reconnect-on-open. Let's reuse existing
reconnect loop. For this, do initial connect in connection coroutine.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 94 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 4548046cd7..16f039b7dc 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -57,6 +57,7 @@ typedef struct {
 } NBDClientRequest;
 
 typedef enum NBDClientState {
+    NBD_CLIENT_OPENING,
     NBD_CLIENT_CONNECTING_WAIT,
     NBD_CLIENT_CONNECTING_NOWAIT,
     NBD_CLIENT_CONNECTED,
@@ -113,6 +114,7 @@ typedef struct BDRVNBDState {
     CoQueue free_sema;
     Coroutine *connection_co;
     Coroutine *teardown_co;
+    Coroutine *open_co;
     QemuCoSleepState *connection_co_sleep_ns_state;
     bool drained;
     bool wait_drained_end;
@@ -140,8 +142,6 @@ typedef struct BDRVNBDState {
     NBDConnectThread *connect_thread;
 } BDRVNBDState;
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp);
 static QIOChannelSocket *nbd_co_establish_connection(BlockDriverState *bs,
                                                      Error **errp);
 static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
@@ -338,7 +338,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 static bool nbd_client_connecting(BDRVNBDState *s)
 {
     return s->state == NBD_CLIENT_CONNECTING_WAIT ||
-        s->state == NBD_CLIENT_CONNECTING_NOWAIT;
+        s->state == NBD_CLIENT_CONNECTING_NOWAIT ||
+        s->state == NBD_CLIENT_OPENING;
 }
 
 static bool nbd_client_connecting_wait(BDRVNBDState *s)
@@ -638,6 +639,7 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 {
     uint64_t timeout = 1 * NANOSECONDS_PER_SECOND;
     uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;
+    bool initial_connect = s->state == NBD_CLIENT_OPENING;
 
     if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
         reconnect_delay_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
@@ -646,6 +648,25 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 
     nbd_reconnect_attempt(s);
 
+    if (initial_connect) {
+        if (s->state == NBD_CLIENT_CONNECTED) {
+            /* All good. Just kick nbd_open() to successfully return */
+            if (s->open_co) {
+                aio_co_wake(s->open_co);
+                s->open_co = NULL;
+            }
+            aio_wait_kick();
+            return;
+        } else {
+            /*
+             * Failed. Currently, reconnect on open is not allowed, so quit.
+             * nbd_open() will be kicked in the end of nbd_connection_entry()
+             */
+            s->state = NBD_CLIENT_QUIT;
+            return;
+        }
+    }
+
     while (nbd_client_connecting(s)) {
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
@@ -758,6 +779,11 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         s->ioc = NULL;
     }
 
+    if (s->open_co) {
+        aio_co_wake(s->open_co);
+        s->open_co = NULL;
+    }
+
     if (s->teardown_co) {
         aio_co_wake(s->teardown_co);
     }
@@ -1746,26 +1772,6 @@ static void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
-{
-    ERRP_GUARD();
-    QIOChannelSocket *sioc;
-
-    sioc = qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
-
-    qio_channel_socket_connect_sync(sioc, saddr, errp);
-    if (*errp) {
-        object_unref(OBJECT(sioc));
-        return NULL;
-    }
-
-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
-
-    return sioc;
-}
-
 /* nbd_client_handshake takes ownership on sioc. On failure it is unref'ed. */
 static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
                                 Error **errp)
@@ -2229,7 +2235,6 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     int ret;
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    QIOChannelSocket *sioc;
 
     ret = nbd_process_options(bs, options, errp);
     if (ret < 0) {
@@ -2239,23 +2244,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     s->bs = bs;
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);
-
-    /*
-     * establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    sioc = nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
-        return -ECONNREFUSED;
-    }
-
-    ret = nbd_client_handshake(bs, sioc, errp);
-    if (ret < 0) {
-        nbd_clear_bdrvstate(s);
-        return ret;
-    }
-    /* successfully connected */
-    s->state = NBD_CLIENT_CONNECTED;
+    s->state = NBD_CLIENT_OPENING;
 
     nbd_init_connect_thread(s);
 
@@ -2263,6 +2252,29 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
 
+    if (qemu_in_coroutine()) {
+        s->open_co = qemu_coroutine_self();
+        qemu_coroutine_yield();
+    } else {
+        BDRV_POLL_WHILE(bs, s->state == NBD_CLIENT_OPENING);
+    }
+
+    if (s->state != NBD_CLIENT_CONNECTED && s->connect_status < 0) {
+        /*
+         * It's possible that state != NBD_CLIENT_CONNECTED, but connect_status
+         * is 0. This means that initial connecting succeed, but failed later
+         * (during BDRV_POLL_WHILE). It's a rare case, but it happen in iotest
+         * 83. Let's don't care and just report success in this case: it not
+         * much differs from the case when connection failed immediately after
+         * succeeded open.
+         */
+        assert(s->connect_err);
+        error_propagate(errp, s->connect_err);
+        s->connect_err = NULL;
+        nbd_clear_bdrvstate(s);
+        return s->connect_status;
+    }
+
     return 0;
 }
 
-- 
2.21.3


