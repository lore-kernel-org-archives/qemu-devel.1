Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A52C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631A92075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kjykitm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631A92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08C2-0002cz-LN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08AW-0001U8-Bd; Mon, 27 Jul 2020 14:48:12 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08AU-0005W3-Ex; Mon, 27 Jul 2020 14:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmpEhlhwQbOuycbqVlQ5ckA/n1igS1aJEh5Aam5dgv19t6jUnqreF6k8lf5+20gMEOz2DKDah39cXBhrbTE2KCr3YOSVn0lgL3tVUk9Td5IlGTBO2JCkiZ1YgzxaHAKFkazuMdkQeqglxfzgn13/9bnIuUbX/HDN2fDsAUr4Vt0N0Ldrqw/Baz+BYF2/MDbT/X6xxiBPluAQpdKA1xsSLxHd5R39cdLREtmhZhdAqW98C+lxMq24zlNskzXgTlyvgu43MJMNc+YOxLXS2RA7Yb3AabhqdtgXb3aQsalXwjfmvEPlzLNPlWdMTyU2LGdicbRhT8BoqV+p2lGyFGtzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34ArUQMOw9JaUmdCueDG1WE4vk43cb6+JiGkOLRBktM=;
 b=bzeoi+XdGsqHcOf5c4EC0KPoIfAxRc8Ee+Ftr7aJF+VdrU62BhdQ0Ad2oOhQSIfrX9X4Ii3nnn68JLZH0OsHOUeFqFb0g8vZyg/xiFT58qKU8O3iXja5pVlgjsKmla4c7yxnZpiTHEcTCv7HEnoXMChrh8Dffu6dfHvKyikR0ufVPNNfSNSmdVs+zXCj+LEzKzlUoHCMnETbu5EMZt66eZlx2nDVb6A6dbkmS0LOxjDPX3FdhzQxCL54nJrlfqYjQCBrJn5FJEUtCUgOs14FFPxStGrfrNI9L4CuBmm7O0TpFfAXNGUQd9ebyIND6kkGtcmLsN+lAGvBtjIO3l8Pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34ArUQMOw9JaUmdCueDG1WE4vk43cb6+JiGkOLRBktM=;
 b=Kjykitm0Fd2hw3qvDsQXR97HM9zz22osTd4asDWjSI/KBrnzz5MiWFZCwjZG1hicywlVy+VvVk7TTqEyCFM0XmQl3rXqep5RyQEc5ZbqkoI+ZIxCzwL2K7uieHxlpHgWO+9/GnpEr+3cXa2c06cg/fbIzPvZajw9Q/Cu9IlfIzU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/5] block/nbd: split nbd_establish_connection out of
 nbd_client_connect
Date: Mon, 27 Jul 2020 21:47:47 +0300
Message-Id: <20200727184751.15704-2-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 18:48:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a5c407-92ad-459d-c97c-08d8325d98ec
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5079C81B8B364CB868432989C1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7b4bw5REkGVoRRzfSr8Kqbkchr9HpHOh3SwsRfhsRWaPQJTHeVa2aSM8sz6si4zI97MCk+ktXsiqrbVb8yzDcf7UwTpzyLB9rGPTd0hblXU0n6qS9RHjxSVI8r4m0DyMZDu+PfwRn9okQ0a9WgcJXpgLC+0xmOyrCHLLy52uEaiX6oZfNM7ush2onea0Xu4inNKBReiejN3/MPDHlQ4L2PpXNQK1tleDjMooFtTRGCpJWv1Kd6u8kx1Br9c/BFrMLB/WtUD4DuSBUwpBkeD9MwbVhOHP8ASpAJbndfQqqOtHnawbdawJcvxY7KcyENtP2hnWHtZEgEiSTr6tfKSXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(5660300002)(66946007)(36756003)(2906002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I1JtSWwGfyJI9njv0V0AB2w48cUH9HGyobkcpZW1c5geObBOFNtOIBe2Yrp+qtfjOygFBUcGw3W3WSb9C9H8/aOq2QmVfDemziJnYrBfdPv+iOMv/TJ/kgKqIRwsm6K27E7lhorVtS0aNFcFFro21vVTtzz7G8KG2vtQY4YFwlrCT8tijOG8+1bHFNOEDBJolB7fobwioZFlA7siR2i6w5RDtW+w6vv0oVkbN6MhTc3SKIpA1XH0RMUqExpxV5Fx13v/C+OMBZZSyQlCx51sXtG/YcCii6aPZsCLAviVpFr/85gRzl7jMM8kgewFgGOfX8tpEN0rXCq3SH3kFhcRg3NaB7EHbhrmtOjjqd3f7kZqkWxPcb+9FnDu1UouRZ5bb5q8siaYnkJPgK5mRBTp8q9C70LeHiv3XSFv2UktQHYMUbJzwF8R1b1mTZM+nbomMeBMNwoo2HrSfNojQ+af7ZfeWsNtIXi3zr+O6VyjIci3kxODGrV5eDW2zgQcoW1g
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5c407-92ad-459d-c97c-08d8325d98ec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:05.3022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTsX02+xy2wgv0ZgJoEOeQLx+bxed8XKB1qHo2HCBBAjCV9wDSmY6Ksi95M0cn1t9MgcxN7McQQrMGgQDiDC5kbE+k2V+wtTJ5633e/hxNY=
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

We are going to implement non-blocking version of
nbd_establish_connection, which for a while will be used only for
nbd_reconnect_attempt, not for nbd_open, so we need to call it
separately.

Refactor nbd_reconnect_attempt in a way which makes next commit
simpler.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c        | 60 +++++++++++++++++++++++++++-------------------
 block/trace-events |  4 ++--
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 65a4f56924..2ec6623c18 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -93,7 +93,10 @@ typedef struct BDRVNBDState {
     char *x_dirty_bitmap;
 } BDRVNBDState;
 
-static int nbd_client_connect(BlockDriverState *bs, Error **errp);
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+                                                  Error **errp);
+static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
+                                Error **errp);
 
 static void nbd_clear_bdrvstate(BDRVNBDState *s)
 {
@@ -241,7 +244,9 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)
 
 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 {
+    int ret;
     Error *local_err = NULL;
+    QIOChannelSocket *sioc;
 
     if (!nbd_client_connecting(s)) {
         return;
@@ -280,19 +285,25 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         s->ioc = NULL;
     }
 
-    s->connect_status = nbd_client_connect(s->bs, &local_err);
+    sioc = nbd_establish_connection(s->saddr, &local_err);
+    if (!sioc) {
+        ret = -ECONNREFUSED;
+        goto out;
+    }
+
+    ret = nbd_client_handshake(s->bs, sioc, &local_err);
+
+out:
+    s->connect_status = ret;
     error_free(s->connect_err);
     s->connect_err = NULL;
     error_propagate(&s->connect_err, local_err);
 
-    if (s->connect_status < 0) {
-        /* failed attempt */
-        return;
+    if (ret >= 0) {
+        /* successfully connected */
+        s->state = NBD_CLIENT_CONNECTED;
+        qemu_co_queue_restart_all(&s->free_sema);
     }
-
-    /* successfully connected */
-    s->state = NBD_CLIENT_CONNECTED;
-    qemu_co_queue_restart_all(&s->free_sema);
 }
 
 static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
@@ -1425,24 +1436,15 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     return sioc;
 }
 
-static int nbd_client_connect(BlockDriverState *bs, Error **errp)
+/* nbd_client_handshake takes ownership on sioc. On failure it is unref'ed. */
+static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
+                                Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
 
-    /*
-     * establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    QIOChannelSocket *sioc = nbd_establish_connection(s->saddr, errp);
-
-    if (!sioc) {
-        return -ECONNREFUSED;
-    }
-
-    /* NBD handshake */
-    trace_nbd_client_connect(s->export);
+    trace_nbd_client_handshake(s->export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
 
@@ -1489,7 +1491,7 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
         object_ref(OBJECT(s->ioc));
     }
 
-    trace_nbd_client_connect_success(s->export);
+    trace_nbd_client_handshake_success(s->export);
 
     return 0;
 
@@ -1894,6 +1896,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     int ret;
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    QIOChannelSocket *sioc;
 
     ret = nbd_process_options(bs, options, errp);
     if (ret < 0) {
@@ -1904,7 +1907,16 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);
 
-    ret = nbd_client_connect(bs, errp);
+    /*
+     * establish TCP connection, return error if it fails
+     * TODO: Configurable retry-until-timeout behaviour.
+     */
+    sioc = nbd_establish_connection(s->saddr, errp);
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
+    ret = nbd_client_handshake(bs, sioc, errp);
     if (ret < 0) {
         nbd_clear_bdrvstate(s);
         return ret;
diff --git a/block/trace-events b/block/trace-events
index d3533ca896..9158335061 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -168,8 +168,8 @@ nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
-nbd_client_connect(const char *export_name) "export '%s'"
-nbd_client_connect_success(const char *export_name) "export '%s'"
+nbd_client_handshake(const char *export_name) "export '%s'"
+nbd_client_handshake_success(const char *export_name) "export '%s'"
 
 # ssh.c
 ssh_restart_coroutine(void *co) "co=%p"
-- 
2.21.0


