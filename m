Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE959206E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c+VLPdlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE959206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFZJ-0002jW-5a
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFYd-0002Hk-Os
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:16:39 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com
 ([40.107.5.98]:19714 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFYc-0001hk-3U
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzWw3yqNoMfhaGplz+dWFFDgLmt3QEhk26qhv6L4TBNLIDWLTluZuPmVncz3QPuN8WH3trc6RpgvK874gvU7OrlOdPoUxQS1w4BaK+v0/HT73E529iX5VEcpeyYr5+/1nQJdy/qocfqHUhbRMGOPxZ8vwjeA8tn5GIRJIaH8oZiItPBhxAmsgQwJFtIrf4bDUQ0oHjB3rqkEASEZLnKKIfjOD0D4MmVaczijjx+r3eVmvv3r06UqQamxWoFJwd0m7G6Ni8swxT4+GYpCZLQa9tpjSYGs4gk7KN2CaYbqLy97zf2yEMgpkOKNiP+fVG6lfE59R/8lKTsF+Lnd4hOvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6xPYxQNI4IMCN522QoEIVGvxzwM0GNlL0IeNi1Q8Fc=;
 b=Dd2hGoKRwe9qF029Q2tRt1Jv+gb7oVx3ROiAGbhKtwP2hzABe4k23gbWdvF7w/uPPKmNpcmBXFQD8leb2zODpJ0tfCMw7lBeJkM3y6eymWfS6zfsQ2IELKyXV/rwNe9AMKLwTe/4EFsgNT0xJ7iSrB30fKp/nTXuAlcNVi7eixrD9TBKLwEw5ZIVVbjUnGGu0q0Aa0yU6aMzrz3oZYOM3+VWbrrUAkMSfej3EyqMCQqiZxr8aB7EfaQXZOFPrJbQMMt3mOr1OJB0OZRMJo9db9fFagAbyfSmbFNDmq2r7tNlpbyxwxt37LFR81Iv4SILP8aNZIctJYZx2VcEsH8jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6xPYxQNI4IMCN522QoEIVGvxzwM0GNlL0IeNi1Q8Fc=;
 b=c+VLPdlRxSRv34dyl6LrtVVs401G51SCNk+Gkv+FlGIByyesGMBwIIRTIuU5mEey7GbLbxRaCtamJcXnSsyXobrctg194Qo26masFGM+pZXwY/LVWBXGD+RtAp9G6N/alIay0ftSQHPNik2lkn7R6ExvDZRH12vHB7DGK0pDm/8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 19:16:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 19:16:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
Date: Wed,  8 Jul 2020 22:15:39 +0300
Message-Id: <20200708191540.28455-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200708191540.28455-1-vsementsov@virtuozzo.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:208:55::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.17) by
 AM0PR04CA0123.eurprd04.prod.outlook.com (2603:10a6:208:55::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 19:15:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af41638-b39f-484b-2603-08d82373576f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40704CADC5B8F5476B8939A8C1670@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAECPv5FkgfMnjTevj92Ca6MrwrQxWo+GqOSJ05k+1Vx0noyuJjHoWClGRP5EuyPQ1Agki9oNsbycIv75TgavTzt8buuiRXeIj/qZ9DQjtHAE2xVUACt9ZXunac2fMkPb9LcArhkbIUBA0P99pd7YmNdK/z3doWxVgg03qhIJshxkDqfqaaqwmOqUAvoDttt+BJaxQsqHMxFouMrVua8R3li3wjFVSGyizqfBAK4Gaqea5W9qlYAbBE6layNHOgyTbvX4KhPUJ423RFAdZRttDUmvERKlSMsmaWEqjC64eNDMYhUCwMRSeGRAdlJaSebQwcnC0m708F7wg8GtyEV0jaFBaeckcdR3v6zzqjFFUCcxZUmd3zvQUG73MQSXG0U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(186003)(16526019)(86362001)(1076003)(6506007)(956004)(69590400007)(26005)(6666004)(6486002)(5660300002)(316002)(52116002)(66476007)(66556008)(478600001)(4326008)(66946007)(8676002)(36756003)(8936002)(6512007)(2616005)(83380400001)(2906002)(6916009)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4X3xGpOfQWwpKvrRzazDzbAGgCWSWyUDR2opsBFkprDeEPTu5kTBhBTZ9XFCV2cUXtVOZO+bQy21YvB4hikCeHfGNvgEYM5TPbeHPlSNTQAT+RxVrHbv/zpguX+7NkHuAZlzNuKAW11t/ToYsg1iJwPMS6VTGnQmuWTxUNF/kxaFdm5yPKssa+ZR0jUy1LFDJAqVQsiPVZvZ6tKiSBWe19/l0dbo+E1d8o6ok9wbSdLIdYow3nKM7tuyl1OtZxSZLIrYkdyaXv6DdYFklyjHIuURBuZZMqHb18XQ0576/Xj/Hf4Zyi2N60igV7iIlHTRoJzZwXkXb3hZL+5Iewyxme745qm+N83CNXzHN2vRwX9p3afOknz3b/e//jN5qm9OfEK7XCmDnWdHmtN3J1BVe/EhSjnZm6KLdbi5Gj8+HMptVjEgRWjfuUW73vsXJbiLThY70wSWTVf7rOfjcquz1S4Cp25RnMBM2ZIsF1jyz2g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af41638-b39f-484b-2603-08d82373576f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 19:15:56.9820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OInkp7pUmocH/xsaILuUyK8qub3RCkZlOitBlaemT2iNrLxVCZDY5MrDjRssYux9jzb14/2zELkCt2B/AeY5GP8t49rgqVcMjVX65Pji6wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.5.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:16:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, armbru@redhat.com,
 kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep-alive won't hurt, let's try to enable it even if not requested by
user.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/qemu-sockets.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b961963472..f6851376f5 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -438,7 +438,8 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
  *
  * Handle keep_alive settings. If user specified settings explicitly, fail if
  * can't set the settings. If user just enabled keep-alive, not specifying the
- * settings, try to set defaults but ignore failures.
+ * settings, try to set defaults but ignore failures. If keep-alive option is
+ * not specified, try to set it but ignore failures.
  */
 static int inet_set_keepalive(int sock, bool has_keep_alive,
                               KeepAliveField *keep_alive, Error **errp)
@@ -447,8 +448,8 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
     int val;
     bool has_settings = has_keep_alive &&  keep_alive->type == QTYPE_QDICT;
 
-    if (!has_keep_alive || (keep_alive->type == QTYPE_QBOOL &&
-                            !keep_alive->u.enabled))
+    if (has_keep_alive &&
+        keep_alive->type == QTYPE_QBOOL && !keep_alive->u.enabled)
     {
         return 0;
     }
@@ -456,8 +457,12 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
     val = 1;
     ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &val, sizeof(val));
     if (ret < 0) {
-        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
-        return -1;
+        if (has_keep_alive) {
+            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
+            return -1;
+        } else {
+            return 0;
+        }
     }
 
     val = has_settings ? keep_alive->u.settings.idle : 30;
-- 
2.21.0


