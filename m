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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EEC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146B822B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uF2M//Hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146B822B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaH4-0002QJ-90
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCX-0005ht-QI; Mon, 20 Jul 2020 14:07:45 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:44342 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCW-0001VM-4Z; Mon, 20 Jul 2020 14:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxO7rrApnpSCaKOU4SF91eYmhXhEn2YMImL6mLvlpcmJ9gyHYoLwC3QK+QnSlTrfYNTRFdzpJWlQhwvGqzYOX4/H4HDwwcfQ/gFAGJ2RJaF5TZOQYEGy9jBzASZoFNbWVzjDb50o+wyZFlGtOiYyY+oyA8GvfaZZp1uYBGGwIdO8ghb9ZsHQaJd84u0skorqsdKxmtiBjbtBlVaaMSOqxLkF6zrAgoLJqzppdRjCyqRI2vBZFe0XpZw7Q0Rt36HDz6O3HjeBYLg5KSoUt/MOfZrwZ9y9S9+yS7V+QLaPPAi5uBuAW6/+waRQwDfZOY6YEYfvVIoYGjm/HMoBk6eqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku4vcmlKyRcXmLJI1pdR50SPox/bIAYGdBHtI5D89uU=;
 b=RmKQzgYvvcTbzyatITI5zx6NAyoj3Rypxdo/PVZogpXc5n5WitWFdEQobH89OgqW5MGhXBN2sIDkGW0fRMETL0khVB3P3WeoKwHPqFmj63JZge4+fWuVJcyQNz3BTpUmU9u4Nb3nDEl/bEsSNb4TqoJlRRITJVHeFuNHEUuqqoC+16m87dlskU7qrd1QmOiI7pj0GhwkMQ8wewgb+oX8mcB95itHah2Gsg/6JJvbffdXL0+1UohLPtELePMifWa6v06GXM+LMXX91qfiMA2FFvODROscQqgPBiXNgZIGZrqPR8O7lKkyk0wJOCE+j0N2t8GiH0ai1AEIUvteHHXsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku4vcmlKyRcXmLJI1pdR50SPox/bIAYGdBHtI5D89uU=;
 b=uF2M//HhGlXfvz2dC8GzomXRUHns69zX6hWOpx6E+qAhnEnwhVuF9kT+v+xw8/8xWGszCtgYiHms6zt4Q/jDjRZezpSCCSMKZtxyXzgIS3QDbcy5PO95JFOKcUGtVroA5TYWESTdF1xStrAzs+R+C2KewKCd13mZhN1H6RR40FM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:07:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:07:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/4] io/channel-socket: implement non-blocking connect
Date: Mon, 20 Jul 2020 21:07:14 +0300
Message-Id: <20200720180715.10521-4-vsementsov@virtuozzo.com>
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
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 18:07:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0991bd39-3475-4fcc-a8a8-08d82cd7c81b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4342970D1589FD13AD2CD62BC17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6yrBaYe7bPOBGcud+F59UGSxi2mBocpsYnG6XpP27IAy48Z/D5eKA3vi9rrXWNSbtM+Z/j9Rprprfi5gZ2VMMzhK+xFUu+YpVRAHDbDsWN944HFGj8kN2+vl0+wb0fOmNW/oRRS4Y7/9thnMalScJN+OznUq5LdfJyKHQsnEA54W0qRvA1+Pc2wYwrLK3rVczvLB46YignUVbUL6QaLfGjSlQj3ckQR+sRKs1Bz8mDGBgqEjTjzLffaQFkz6qCc6A7O4G4dKWy4RGK57XjR5rJFTs+5Hye4iUt7ecug4Dm05Vy3buCTswLYoC2BsP0vwq0kwIRcqynUv8hQNVpc5pAVMQAIbenHbcRzM6wWnqecRQOxMCQD9A7dviQF9xrF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(86362001)(4326008)(107886003)(316002)(16526019)(83380400001)(6666004)(2616005)(956004)(6512007)(6916009)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(36756003)(6506007)(69590400007)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H8libeNGuwFa1vD+UyDi1Fmi6UQOhdTaEv8A/Ok9D4kmgEtfV8NOy1RMePyO/4KdXLvpz6XUD6rEp98wb730pedZp7LJST/4uBNUdWxllsptxOu37eqOcgW9i8MMDuxtcr7iyG1ArpKUiddjN86BN2rfQQ5qM2Bj1+TsP1dEIQAM0nx7Nf6Yv71G2jKDXaYjVcHtEJRPPCdpTopp01tz6S05mffwtgiVxU0G7oF0U6TMqW327VGhNGlOLb4pDaoUqit1Se9IOvFeudc7QaZHrbWqy37QUsHDmDf19QgKdQzedT/YwD8Dl1W88dtktDvrGbucAZzVKhJS556WrefS+Su3oblGN12hRVENorlqWz2eTR8BMPXaq5K4q5qQSzmxsWE2KKBYK3vqJrxUopEuB0w+IjR9zrlEjQRrSC9o4M33S8nuRUgHPJXRIYZKCzFIDwrmB+ezBsuU0sgw5fxXCmZhCbQKnwo6ZCs3a0qTA/Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0991bd39-3475-4fcc-a8a8-08d82cd7c81b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:07:36.1554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TM2scqnn1o1aAY1UZAGpHOQpVK+2aEmenNDldTtoCcoY5DR237Qd8/33gq0qOGv1gGGOjKR3XIKO5W0sp3w/dQzdrVhGkNNwDUeTX2BszE=
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

Utilize new socket API to make a non-blocking connect for inet sockets.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/io/channel-socket.h | 14 +++++++
 io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 777ff5954e..82e868bc02 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
                                     SocketAddress *addr,
                                     Error **errp);
 
+/**
+ * qio_channel_socket_connect_non_blocking_sync:
+ * @ioc: the socket channel object
+ * @addr: the address to connect to
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Attempt to connect to the address @addr using non-blocking mode of
+ * the socket. Function is synchronous, but being called from
+ * coroutine context will yield during connect operation.
+ */
+int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
+                                                 SocketAddress *addr,
+                                                 Error **errp);
+
 /**
  * qio_channel_socket_connect_async:
  * @ioc: the socket channel object
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e1b4667087..076de7578a 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/module.h"
+#include "qemu/sockets.h"
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
 #include "trace.h"
@@ -29,6 +30,8 @@
 
 #define SOCKET_MAX_FDS 16
 
+static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
     return 0;
 }
 
+static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
+        InetSocketAddress *addr, Error **errp)
+{
+    Error *local_err = NULL;
+    struct addrinfo *infos, *info;
+    int sock = -1;
+
+    infos = inet_parse_connect_saddr(addr, errp);
+    if (!infos) {
+        return -1;
+    }
+
+    for (info = infos; info != NULL; info = info->ai_next) {
+        bool in_progress;
+
+        error_free(local_err);
+        local_err = NULL;
+
+        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
+        if (sock < 0) {
+            continue;
+        }
+
+        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
+            close(sock);
+            continue;
+        }
+
+        if (in_progress) {
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
+            } else {
+                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
+            }
+            if (socket_check(sock, &local_err) < 0) {
+                qio_channel_socket_close(QIO_CHANNEL(ioc), NULL);
+                continue;
+            }
+        }
+
+        break;
+    }
+
+    freeaddrinfo(infos);
+
+    error_propagate(errp, local_err);
+    return sock;
+}
+
+int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
+                                                 SocketAddress *addr,
+                                                 Error **errp)
+{
+    if (addr->type == SOCKET_ADDRESS_TYPE_INET) {
+        return qio_channel_inet_connect_non_blocking_sync(ioc, &addr->u.inet,
+                                                          errp);
+    } else {
+        /*
+         * TODO: implement non-blocking connect for other socket types.
+         * For now just use blocking connect, and then make socket non-blocking
+         * for consistancy.
+         */
+        int ret = qio_channel_socket_connect_sync(ioc, addr, errp);
+
+        if (ret < 0) {
+            return ret;
+        }
+
+        return qio_channel_set_blocking(QIO_CHANNEL(ioc), false, errp);
+    }
+}
 
 static void qio_channel_socket_connect_worker(QIOTask *task,
                                               gpointer opaque)
-- 
2.21.0


