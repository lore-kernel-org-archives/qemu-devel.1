Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2EC43462
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896102068F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ajM/SCcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896102068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaF4-00007N-Sl
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCa-0005nZ-AH; Mon, 20 Jul 2020 14:07:48 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:44342 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCY-0001VM-DA; Mon, 20 Jul 2020 14:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGDk0loUredwf4zG/YVrNM+RWHDvkLkW/SMaHD62D4h/ySVYcDXA2AyhtXIKmd2y4kr5GXZ1fNO7BKW37idmlENRrO+uwD1qLmLfDs6YAFoB9hwLuuEcM0RUpKJKKnD9yekslHp0uCx4OmDVs7q2ooqX7RYGduN2L4EsZrcWne2HZm8wS0iBhtzuMW+aMXoEdsEXJCMgJ2TrFWEYFoJrDX1su+CQJ8nrDzI4ZibTc7Y82Jt8u7qXKjqAhmJH2HDw8wcA6y0/SpDiCmmCnmqGKFrtuP4Wjj+chzXe8ySSuHYBWAttBmRLxz/5B1nxJ9o61FbcA5zucRvKIYkOJTFZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND61QWT6uvaBxQDp6wOnx/rSoXnc5tcaYeX+Zmz2rDs=;
 b=mjfzYqigdYalUGKmNKqcdaoY8MugQfPGrY8/AGySaQ6JgdzD7tF46KQmXAWK8w+GXGX7ZlQ7rrSki05e63IM4P1MrnHFXtGYsajaL2hM9EFYCYYupDI6s7tW6KpELpUp8WMowOcLdkmoswULxoDI3J4U1QEkgl/l0vAh9W7uh1Mnj7zIyc6FwnZ3DaYVl099PZ6hnrWMI8zIyGFCsKQtijaqg6vsX1JivDRvDYjUPfsK9Lzt2RhblH9BpOMlQD+yck+zSkh7824FW3lOdC/wvtm9Lm45KcvU/bZDHTZNyU4fsJ2/IJXHDSXWlz8xLsb4SI6DAQ8T4GX4Y8mYosZ8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND61QWT6uvaBxQDp6wOnx/rSoXnc5tcaYeX+Zmz2rDs=;
 b=ajM/SCccp0XWn6uL6MnGzaQzkA1+MUkMkJeMurFLImIVjVU1eUqcWGaBxzNs1SQGJkQLZ9g7UBQcZiXinIzgckSvxSNfaIW7TJJxOKFP9y8iZMSxNgoC3TMDTEN9xfjjZ5tnU0bgRZxneYo8E0R3lqfSQ4fhnTvD1n4vXTPGSVc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:07:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:07:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/4] block/nbd: use non-blocking connect: fix vm hang on
 connect()
Date: Mon, 20 Jul 2020 21:07:15 +0300
Message-Id: <20200720180715.10521-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200720180715.10521-1-vsementsov@virtuozzo.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 AM0PR06CA0130.eurprd06.prod.outlook.com (2603:10a6:208:ab::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 18:07:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b3459a-404d-4791-3be6-08d82cd7c898
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB43424D12CF61A423CA23FC74C17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EsTH+/XjzkfnJapG4mgj0D4vk6M9UegY480oG4Cek4jjo3ocs5bfnhjB2rd7GAXqbIuHHSncjJZNE1Q7Z6U2TASBxdgpO3aCCHqEg4FDOkhA1xdGZrWs0eCWzvGi5weB33K1KAmtMMV9BednkG1e9A0TW3DlHc8Z7IGbtamiXmQldbYXzB0ACwI4LXnIIeYpvD4M35lnEWxOh6ayq1ff4D2C5w1k/hiZ2Gb73rRJdmjy/jxz53YL3fNQq10DAtkuuRTn6yJ6Au/L4UIvVDveY828pwa+VtdZh0L9QGn5ag4+id3qmcg/AXDXgiLVmqyueFi69o3DY+64KFwthxKbXuL37tiexBpepHVqB//Vf6PrvIhO3DxMfetu9GkqSYO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(86362001)(4326008)(107886003)(316002)(16526019)(83380400001)(6666004)(2616005)(956004)(6512007)(6916009)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(36756003)(6506007)(69590400007)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eEFhRD+j34TmYwVeHy+S4xMKoUZ/P5CODiOXZF9sMUALK4hq56Shl+6Y/I4BCOdTLCRO+/ImEM4fJNs1PYyvBRwG/rWSEaCcD0tnHjxm72tauQTw3tAS9QIQBtz3u2+v3rCXkU+hiQD1Zdco51LlqRopoio9g/AE7yUMwOeC/bUhG8CcDumHfYuj+kvVPwrD4qHk+AGEfMy7b3BxBcls6B3NjbDB7uOeLVLSSQckb0fGYJksGkubjnbCVMcYaz8fmSTWjAOoy84VZEbxkbtRUo11EHpEwqtuY9AkgTtoFneJJ7ci55KfKltuHEvGUaEB6EOszHnuxk/QZuFMMw6h4EnhaqwDl055w2RRuHcLy+BObKZDtosxSDCJkyGCHBcnhLpMCma3oLnjzciaI/B01ZnJW3OqgwdiTXincHCGLymJnMgMZs3Rn1NtRQZaQES58CN/oiyLYd1BnYC7qYTBQ4w5y6U79Kl9z47xkRezjdU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b3459a-404d-4791-3be6-08d82cd7c898
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:07:36.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj6SNexE2wo9sKjiREPK2H0Q4j5YOgak0DgC4hG+YtTwRMWkwZoCnUrajEHE8tkfEfDfgkd5qpZVfuAyW8/siSdFJbJIdi/e7GQ/3t+M9E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.3.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 14:07:34
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
 qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This make nbd connection_co to yield during reconnects, so that
reconnect doesn't hang up the main thread. This is very important in
case of unavailable nbd server host: connect() call may take a long
time, blocking the main thread (and due to reconnect, it will hang
again and again with small gaps of working time during pauses between
connection attempts).

How to reproduce the bug:

1. Create an image on node1:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server on node1:
   qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

  ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
    file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
    -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std

4. Access the vm through vnc (or some other way?), and check that NBD
   drive works:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

   - the command should succeed.

5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:

5.1 Kill NBD server on node1

5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
    again. The command should fail and a lot of error messages about
    failing disk may appear as well.

    Now NBD client driver in Qemu tries to reconnect.
    Still, VM works well.

6. Make node1 unavailable on NBD port, so connect() from node2 will
   last for a long time:

   On node1 (Note, that 10809 is just a default NBD port):

   sudo iptables -A INPUT -p tcp --dport 10809 -j DROP

   After some time the guest hangs, and you may check in gdb that Qemu
   hangs in connect() call, issued from the main thread. This is the
   BUG.

7. Don't forget to drop iptables rule from your node1:

   sudo iptables -D INPUT -p tcp --dport 10809 -j DROP

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d9cde30457..931eadbe6f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1421,16 +1421,19 @@ static void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+static QIOChannelSocket *nbd_establish_connection(BlockDriverState *bs,
+                                                  SocketAddress *saddr,
                                                   Error **errp)
 {
     ERRP_GUARD();
     QIOChannelSocket *sioc;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
 
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
 
-    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
+    qio_channel_socket_connect_non_blocking_sync(sioc, saddr, errp);
     if (*errp) {
         object_unref(OBJECT(sioc));
         return NULL;
@@ -1451,7 +1454,7 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    QIOChannelSocket *sioc = nbd_establish_connection(s->saddr, errp);
+    QIOChannelSocket *sioc = nbd_establish_connection(bs, s->saddr, errp);
 
     if (!sioc) {
         return -ECONNREFUSED;
@@ -1461,8 +1464,6 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
 
     /* NBD handshake */
     trace_nbd_client_connect(s->export);
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
 
     s->info.request_sizes = true;
     s->info.structured_reply = true;
-- 
2.21.0


