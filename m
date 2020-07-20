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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39FFC433FE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A822070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="piYvVfaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A822070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaFe-0001Bw-Tf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCV-0005cg-LB; Mon, 20 Jul 2020 14:07:43 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:44342 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCT-0001VM-RN; Mon, 20 Jul 2020 14:07:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWIGFsPTenXwOkI1rtBjIJOUO9KHi6BTnDUQwd6oOH62v9AGHsR38GQxQFj7Zwny1lhmDx8BgVr/ul5R+wKg2MFo9rhBMXV4lyDNwg/JRKwPf68JTEpvSeKhRIj4RJAnvUYQENbMFCiGcEn3wk7Z4AksVOObN71mDBPtHZLNT865pRktMD4PaMUVHZzgqWfLTF+S34CebqCmn5/NoGPRpF+YxsRow8LZtvnenJoao2jIxQ+QP7OQ81eFlTBYEDfgX0iZqYjcm0MogMYH3EKqaTjfKkLQ9qyqbM+5vm5zCi+nXzo0VKglkgS42pil80Lzuzjxo88LiXZQGps9QuQA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foWrUqcfERZ2Cs2I47EltGvGgldT8PFtErWBP/y+hzo=;
 b=DNnB7SdmVc3ruJVXZ0BtGke/ZdC7tAgThDDXNgrgIybgWL/+3aYE9MXbO4jc9mfJgSSuJzZiT34nRWVmi79qrMZJ6ipb/JkQ7L+MxZV5rjn+o0hen1RwRhCXNCSpXlusq0O42BNXpRMnnpnGT95VAIR89Tn1kP2UV48iC6x1lciML9WqQ1JgChuqF74Kq5feAorvckNXhIXUewSUyF1quqSsVjLoa1TlARxsYuM4uK8PbEocEAzTCJAeWJKmvRihkAudPzLDuC6ebwC4EEFPATwmtOixR1myKsNNPqSHAarrXnFiqyI0hq4fVHxUzcmBVUz245ufnbdILuOZX4LG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foWrUqcfERZ2Cs2I47EltGvGgldT8PFtErWBP/y+hzo=;
 b=piYvVfaV55A6gl94maZRUFH9WLQmMwOeXrsQMslzw04ICGaf3hP9OCtL+MA8L7swUzgE/7QYRfIrH3so/PjXn1fSCj5dzHpR4BNT/9KAJ/vy+ZRvcwvt/oEzHWQjMJxWZYO+GqZgF26ThrZxlvCJ4XLnKjZRhQA+UHMoY+fkNKw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:07:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:07:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/4] qemu-sockets: implement non-blocking connect interface
Date: Mon, 20 Jul 2020 21:07:13 +0300
Message-Id: <20200720180715.10521-3-vsementsov@virtuozzo.com>
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
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 18:07:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa6d474e-326a-42d0-c12b-08d82cd7c7a0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4342E876D51558B296A48BC0C17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yis8nznOXzVKTrji15rKwVNodm9TaU9UHFtfdfzCKSrGAIJTOQ+ucQdgU6J/gqebR5F2oz75+TowqZz6bGe7/jRC5nPwsOB+JIvuQPvgnj86PKurRg86TDYJxgN0yH9gdxD0ROlaGg3hj3bIX0gPhgxsnDPqI7gUokxDpXjDDRDIuuYqXSMuyRY+qYWcp+jFL4tQ4BETk9uVB3R2OV5c/vacWsK9sUjDr7u2VqA91qZN3gqacouCFontjStfHvpQtRKXw4P5IOVKgy6H8bic/T+KLN0CxeQQ5jnOx6VQuXhMVbgNfK2LUvA0JWXDORXpnqSXcqLYX2t3bcIJCWSCWz8GkFwFsfmDVdSjg6gqIZ73IOe4q5U/ddlIBmX+/e7B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(86362001)(4326008)(107886003)(316002)(16526019)(83380400001)(6666004)(2616005)(956004)(6512007)(6916009)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(36756003)(6506007)(69590400007)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dtbsWZU8Vgp5hXiMXRVGjjAcAG3YIyBxDg4Oh9Zd+OSs6LDz241VON+z21B9gF0E2GZnbZkvLipTT6XCo1/h74qRpyrXFFg+oUeAsKBaAQii6Rpe7aFZT4pGd5RJne83ZPawdamgFQx6Iqnuu2gfTUuqGCzFHsZ+gX9ricxn0H+Y2IfWv0gYrNCA1jp74uN+AVvvVceEc1gCJE1Xif4q5mX+oO+/r0gByJkEmzPm9p8cYxi0UEZF3bqvc8qHSThAq4pMrPMLLx4mXtAHQ5erkk7GDivfoFwyY3w8whxUBEUWYQUkHxWfKBvhDEKeGNIwi06NR+0hdrYNicU0H6ZlJsYvMlrZrODA2PZMDr2/oP5pifPmE+LMKDxT11pZbP/htvNXRlTEHV5QiV13WDDTzCOjsHSbRV6u+kAetzrnTWo+RYX3g0Mb68dwDJuE8HLyjq8ja70fVpbMcmxtcm5rwkHQ69ogv3OCMeqJ3M4ec/Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6d474e-326a-42d0-c12b-08d82cd7c7a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:07:35.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geIjhmv41rcIkZPkbaH90GptBXD2qmrXb8b2yx/5iflYtDex98WOUcvY24OKs+IBOBCnlA4lY9pE640Z9I3Sgtqv4VEiT4+TgBaAcA5MUrg=
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

We are going to implement non-blocking connect in io/channel-socket.

non-blocking connect includes three phases:

    1. connect() call
    2. wait until socket is ready
    3. check result

io/channel-socket has wait-on-socket API (qio_channel_yield(),
qio_channel_wait()), so it's a good place for [2].

Still, the whole thing is not simple, because socket connect in case of
inet socket includes several connect() calls, as SocketAddress may be
parsed into a list of inet addresses. And after each non-blocking
connect() upper layer should have a possibility to wait on the socket.

We may try to implement a kind of abstract list or iterator for
"sub" addresses of SocketAddress, but all this appears to be too
complex and not worth doing (as actually, only inet sockets has such a
"multiple" SocketAddress).

So, let's instead make public API for inet sockets themselves, to be
handled in separate in upper layer, if it needs non-blocking connect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/sockets.h |  6 ++++++
 util/qemu-sockets.c    | 45 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 7d1f813576..7389d6be55 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -34,6 +34,12 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
 int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
+int inet_connect_addr(InetSocketAddress *saddr, struct addrinfo *addr,
+                      bool blocking, bool *in_progress, Error **errp);
+struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
+                                          Error **errp);
+
+int socket_check(int fd, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8ccf4088c2..a02d00f342 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -354,11 +354,17 @@ listen_ok:
     ((rc) == -EINPROGRESS)
 #endif
 
-static int inet_connect_addr(InetSocketAddress *saddr,
-                             struct addrinfo *addr, Error **errp)
+int inet_connect_addr(InetSocketAddress *saddr, struct addrinfo *addr,
+                      bool blocking, bool *in_progress, Error **errp)
 {
     int sock, rc;
 
+    assert(blocking == !in_progress);
+
+    if (in_progress) {
+        *in_progress = false;
+    }
+
     sock = qemu_socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
     if (sock < 0) {
         error_setg_errno(errp, errno, "Failed to create socket");
@@ -366,6 +372,10 @@ static int inet_connect_addr(InetSocketAddress *saddr,
     }
     socket_set_fast_reuse(sock);
 
+    if (!blocking) {
+        qemu_set_nonblock(sock);
+    }
+
     /* connect to peer */
     do {
         rc = 0;
@@ -374,6 +384,13 @@ static int inet_connect_addr(InetSocketAddress *saddr,
         }
     } while (rc == -EINTR);
 
+    if (!blocking && rc == -EINPROGRESS) {
+        if (in_progress) {
+            *in_progress = true;
+        }
+        return sock;
+    }
+
     if (rc < 0) {
         error_setg_errno(errp, errno, "Failed to connect socket");
         closesocket(sock);
@@ -395,8 +412,26 @@ static int inet_connect_addr(InetSocketAddress *saddr,
     return sock;
 }
 
-static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
-                                                 Error **errp)
+int socket_check(int fd, Error **errp)
+{
+    int optval;
+    socklen_t optlen = sizeof(optval);
+    if (qemu_getsockopt(fd, SOL_SOCKET, SO_ERROR, &optval, &optlen) < 0) {
+        error_setg_errno(errp, errno, "Unable to check connection");
+        return -1;
+    }
+
+    if (optval != 0) {
+        error_setg_errno(errp, errno, "Connection failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+
+struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
+                                          Error **errp)
 {
     struct addrinfo ai, *res;
     int rc;
@@ -466,7 +501,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
     for (e = res; e != NULL; e = e->ai_next) {
         error_free(local_err);
         local_err = NULL;
-        sock = inet_connect_addr(saddr, e, &local_err);
+        sock = inet_connect_addr(saddr, e, true, NULL, &local_err);
         if (sock >= 0) {
             break;
         }
-- 
2.21.0


