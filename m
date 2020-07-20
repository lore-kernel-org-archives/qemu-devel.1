Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE4C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3305F2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t0HalUaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRh2-0000U6-7w
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfJ-0007Nb-61; Mon, 20 Jul 2020 05:00:53 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:22905 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfH-00076G-Bi; Mon, 20 Jul 2020 05:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR1mZlZ3EoVwhl3LlsBLR5AaIBpJw6gMPGV3F3L6qmFz9i8L7ffSSzWknWihqarEjk4+odjn8zUPnsJH5D+/gks7JZjkGaK7pJAXHJMRAeLSm9L1A8WWRlI4jYXXOzRNo7ZRU6MPqRe0bF84aeZ4StHTUNFW0Kr0qQEp+NGTXaxXVqhaJwj9nWRDtJffMELC19TsGtt7PzI8rmN2cYxdeVu+TIy+lGE6IJOqJuGjvEg5y/YGMafcRoh32DX20AaDMzX3Ojjj5zAm47gD89M6oK1mh230fepiYJSqBYuXgWusrfj1d8XwwaLB8JvDKpESxzPj5ml1F25tb7b0BCOTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okPr8s04mfuJdKu/DUImIAeFNbR5KFkCEiBrp/rXWa8=;
 b=EmA2djRRYtsPSkKpVnVgqt8n9dUjnTJe8mXnv/xJ3WkhHVLWJmm+i6ALcKAXiEEdKn71mfR73r8pG19OPNBqj9ff8XznZYmD/gIenFOG+e8gz3tyxpqGkCnhLNgpzyf1/pscXp1PNNJnADsGomko1H09I8fOMPJQfTQ3l9JbWq1XoDTEUrjCiQm1x6HCtHj5sF4Shu+A7m2QO1cFNq7xVdV0Te+QWQEK+O1iPnAAH+rmTSYxqWdf0HwwRDO10Muk6XWDd3D6Owrv9jjbn2Wl+NBwKj1Nenvj6cOdicwokVaUNW6ovjq4T62+b6et/ma/KLa1r+lB4+121MLMXjBJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okPr8s04mfuJdKu/DUImIAeFNbR5KFkCEiBrp/rXWa8=;
 b=t0HalUaFT1wv3I+qIWJ7OQBgJlwW06zedMUJRq9D9K4rFUJQEJ2TU+hzQRRa5+X3qQpVeIGZOzzV5jBhWPR86sCUDgGNUwRNC1DD9UBikoxkFiiCJ2CZDMOGIw4YAHIY5EHkuy+2isNEmCFqY0e5NwC/9nk9RK2It/kDGqe24wc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:00:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:00:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] block/nbd: on shutdown terminate connection attempt
Date: Mon, 20 Jul 2020 12:00:23 +0300
Message-Id: <20200720090024.18186-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200720090024.18186-1-vsementsov@virtuozzo.com>
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.179) by
 AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 09:00:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b52143-ea8e-447e-2a11-08d82c8b6221
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376784595241F9DEFDA24ABEC17B0@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqdO52kFpOAK0Bbnn5X6EZojTM0pLPixw11wTfOzfQIgkhXIVm4S2r5VvgmwAO0R0Zg0nm8dKFTefS3U106ZhSxomUGmASNa9htkxfahcoT1FthHgP4V3S/IdrVxNV6bqrlyQgQZvRvO2PUkrVdXVOolbDCmi3uNP8a0b+sN95Z6Ss3NVjRL4xnPyO0QmUyfmwGSqnjZ2NSy+fpMEyikmP5aN/paBPhFTbEnqsvqg6BP1qOUXQ/vaaEl4l4BoxjVgdTSEY3q1Re8DLhp07Z1kPzgc3shLi0ppyRXzmBVZ8tIWd9xYlM05gE0WpIAVrY7aXI7BMJNPtQQoBLsXdghYKEBh1BcRS1VXRf6gsu2Z79wQgOGmc52LfyXh2r8Afr5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(366004)(376002)(346002)(396003)(136003)(316002)(52116002)(107886003)(83380400001)(186003)(16526019)(4326008)(956004)(2616005)(1076003)(69590400007)(8676002)(66946007)(66476007)(66556008)(6486002)(26005)(6916009)(36756003)(478600001)(2906002)(8936002)(6666004)(6512007)(86362001)(6506007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r87+wKkAMK5vZe0bPSVPNcKqWI8sL80jWQNveUpJK7dLgI4LNtgykhAlUy2sZR2Ypa415Cbpdmr3D4KoN5raBub/vssMvcrRUNt/XK8jNTLfNDMYmRFIG8k2Wy+Aq0VQONIrBqnvGOles17jZMU0CaHkZa324mKgG13Aib/g4ncPuAbq5SnWXht3nLE7kSQMSGObUP8B8sEgbqcUrngGIVZ53k6DhN48fXAKqrjoypf0Prt+nDhBS05mQSUve3H9HqINitiWNl2t6KqVh1ThJIWtYLHTHmQuPyaRG+8xsQ+6EUheAmUT5tdSeTRF+CO4vfFvQQcYSl2R1+TGKXKcCGC9j1kbrL3t8ImVxwu7pN1XkmRdPooRXTLjH5zs4dQKus9sdwwirwJ67IcooIxkp6pK5wr6C0KBLcuIjj1NGUehFdvuATXEtxS3lctmZOrsiy+HG7SBJZ9O5Y36TlengEXcnrm0L9sec6cr5uY8ZIk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b52143-ea8e-447e-2a11-08d82c8b6221
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:00:43.2845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2NnbONugke4GktB49sBBgnmdVnQf1FCaiuaXRxpAo09sLwXLh1tkGrvc4RTw1dUKrP6wqKWNGjsWOeZ3QalBSdyr5S0o6Whz2HtlgBlXco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.8.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:00:42
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
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
    ./qemu-io -c 'read 0 512' nbd+tcp://127.0.0.1:10000;
done

After some time, qemu-io will hang. Note, that this hang may be
triggered by another bug, so the whole case is fixed only together with
commit "block/nbd: allow drain during reconnect attempt".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 49254f1c3c..42146a26f7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -206,11 +206,15 @@ static void nbd_teardown_connection(BlockDriverState *bs)
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
@@ -1452,6 +1456,8 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
         return -ECONNREFUSED;
     }
 
+    s->sioc = sioc;
+
     /* NBD handshake */
     trace_nbd_client_connect(s->export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
@@ -1468,6 +1474,7 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
     g_free(s->info.name);
     if (ret < 0) {
         object_unref(OBJECT(sioc));
+        s->sioc = NULL;
         return ret;
     }
     if (s->x_dirty_bitmap && !s->info.base_allocation) {
@@ -1493,8 +1500,6 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
         }
     }
 
-    s->sioc = sioc;
-
     if (!s->ioc) {
         s->ioc = QIO_CHANNEL(sioc);
         object_ref(OBJECT(s->ioc));
@@ -1515,6 +1520,7 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
         nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
 
         object_unref(OBJECT(sioc));
+        s->sioc = NULL;
 
         return ret;
     }
-- 
2.21.0


