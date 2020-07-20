Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1531E2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FvYFZtDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaDI-0006d8-9Q
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCT-0005Zz-BL; Mon, 20 Jul 2020 14:07:41 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:44342 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCR-0001VM-QF; Mon, 20 Jul 2020 14:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OASEzoWfdwv3eCCQQxS/hkg8FcHhSG0N9fdBooX7xhY9UexOJofR7ewL7dElVAWGMos1VFMM76UpgOzPVgq1m/YnpB1u5rruO64ENwRRW9nShC36lXriNvGZGyg+B924s2lAoRdGLLi5kqm98Qu8o6sNpS0Umxqv5tIhx01KOtwO5V4WiNtXiGZAK3y05KYhTPmKkJQ5IyahVluLMyNZag536ASTTI339rKFsPChJShZjOxHP2rBF2/qLn1FXrd3aNpRWzuT4mLOHh5KnTFCvOdnQQwgE9byATMX77dfLrgyiYPqbcTRY2iKcORSgsx2FW4MqC3W7m82f/pNcGb4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG6cTf5Qit+1icUrpH22YVcK+nC3ckzQEiuctJkqkoI=;
 b=NrpzNISAhAvmHZMBh9E5mGA4xSoTOcR49TIVoRBm8/qny1PPkGy269vx+ZVntNigfoEz9LBHzuAhCI8uZa0Xz5CK6WWL84w8RdKGkhJqBMZw/9AOrCbi7SUjBUC47qby9jummReMsfhpOg+O8nN8cF/H/oBODzWjEuCaajhL6FRBhXQiNt4WTi6d/BabhnyNVYSvRyCHdo/vsjUo3fT2mQ6IcigIig8bs9T7wVXHa7u5lJy/22VGg7A6dr/cu/rLbX18u+KwgBVQShv7faHW+52xzQ4ITxIwsz3wk+nwiW/dzn5zo1KuOgFaRHw2w7nT2owYyiUnejgpeoRyY5vdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG6cTf5Qit+1icUrpH22YVcK+nC3ckzQEiuctJkqkoI=;
 b=FvYFZtDtD9Xg+Rjmqi3xGcN/2IhlhR8BXxoEsdqgCVghdrjY6x/cIcQy1AW/KT3vd10yg/c/UALvYEIs3rj/J6Xkw696FXCc5QX3imUuLSWk0XscXDZgFj3PFZNxo7bBDxhn89OAMZui1ldCtqW4roMTVucvfsMm8o/6yM50Kbc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:07:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:07:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] qemu-sockets: refactor inet_connect_addr
Date: Mon, 20 Jul 2020 21:07:12 +0300
Message-Id: <20200720180715.10521-2-vsementsov@virtuozzo.com>
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
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 18:07:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a346781b-fd4e-4b94-8890-08d82cd7c720
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB43423EC23A4C620E5329A681C17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ierSNRfsoy7y1Lul4p7Bbn6toQQfHHcYCIPsDuM3oLfvLSHYvMru6FILYAqVlKz/3KRra/T0tjcKfnyjAHK60QMcIwSKUC+2LXTo8YNEu+bLX/rpqcB6n8fVvsgLXw0sASmwZYamigRvUrETHiX7kAWi20mrU9/TpCRFn5fDUg0fggyoZ9Iv8Go/6Mkysu7fpqF/mKq5vGLdEN4r/sROfiil7UBcv7u6QtMuJvIstjD/7Sc946IJt/cc+UeYWzR2W8BlTsQfAnjHURX8I6/5KG0YnxfKRT5VJ/eMxPwVAEzX9VR/WCTDqe8TsUjfq0dmcSUmIvpfzPK6K5eL2CVsjAUHftUSjMOkvwAz+5Y+3nFAW8c7fJsahI+RTjUTGXum
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(86362001)(4326008)(107886003)(316002)(16526019)(83380400001)(6666004)(2616005)(956004)(6512007)(6916009)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(36756003)(6506007)(69590400007)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZMgINxDRV2aY1+cmcjCYE9QhCBiLXNcHjfSQXyPplE6T+rkFGgwmkdpKvxKjHU/OBIyir7aZhzAhpy+w45VQGRWBV8gVNyNxknYcC/02LSR1Cdo92V4xwhWeeXG3GdyX4B5qMJXk2dfYLOnV5Cidf9syDO73DNg8jl8TvNZpOHzgcmahOuqBlGPqt0mwUqS/4ZgH+zg+NyrFvk/Ca1CmqO1rAlH4Tlyw4SCTUe7U0GTIFRdQNrXZtjb9gWOZrnwuUD0xUNEFrI4qIHlHNcpK5VTCKpmxFVSezWuDk25i/sm3/bH45r5v9vrITSt8ZlXXkZpDrZtZuRfCUOJXqcaLwyis3Q8LdsevQkNpO7Tr71lOOp2EqdMsojVQNdkKraaynAcNeEoY+yeRYXrQMNcCkv5afzBFJNZxzetbdZpt7KIo20oQowYCi9srU6HXvz7ijG2ZEYgUVxovJ17cYNdyQJc2uq3t4LxoKqCMobosFgA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a346781b-fd4e-4b94-8890-08d82cd7c720
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:07:34.5275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pQK53kRQCDNeghmI2Awy3wpMX7mUTmtbZdfoyIKcBA9qfDvMSTk2bET/qe+5JPbEEAo/R4zxAoZ/rQHBQykSlq190SNQdy0FRfSNUviz3s=
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

We are going to publish inet_connect_addr to be used in separate. Let's
move keep_alive handling to it. Pass the whole InetSocketAddress
pointer, not only keep_alive, so that future external callers will not
care about internals of InetSocketAddress.

While being here, remove redundant inet_connect_addr() declaration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/qemu-sockets.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b37d288866..8ccf4088c2 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -354,9 +354,8 @@ listen_ok:
     ((rc) == -EINPROGRESS)
 #endif
 
-static int inet_connect_addr(struct addrinfo *addr, Error **errp);
-
-static int inet_connect_addr(struct addrinfo *addr, Error **errp)
+static int inet_connect_addr(InetSocketAddress *saddr,
+                             struct addrinfo *addr, Error **errp)
 {
     int sock, rc;
 
@@ -381,6 +380,18 @@ static int inet_connect_addr(struct addrinfo *addr, Error **errp)
         return -1;
     }
 
+    if (saddr->keep_alive) {
+        int val = 1;
+        int ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
+                                  &val, sizeof(val));
+
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
+            closesocket(sock);
+            return -1;
+        }
+    }
+
     return sock;
 }
 
@@ -455,7 +466,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
     for (e = res; e != NULL; e = e->ai_next) {
         error_free(local_err);
         local_err = NULL;
-        sock = inet_connect_addr(e, &local_err);
+        sock = inet_connect_addr(saddr, e, &local_err);
         if (sock >= 0) {
             break;
         }
@@ -463,23 +474,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
 
     freeaddrinfo(res);
 
-    if (sock < 0) {
-        error_propagate(errp, local_err);
-        return sock;
-    }
-
-    if (saddr->keep_alive) {
-        int val = 1;
-        int ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-                                  &val, sizeof(val));
-
-        if (ret < 0) {
-            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
-            close(sock);
-            return -1;
-        }
-    }
-
+    error_propagate(errp, local_err);
     return sock;
 }
 
-- 
2.21.0


