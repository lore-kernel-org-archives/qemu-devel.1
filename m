Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93343206E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iCC1BGKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93343206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFap-0003bI-R2
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFYf-0002Iv-QA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:16:41 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com
 ([40.107.5.98]:19714 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFYe-0001hk-1b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK7H2R4Un5JQQc5BCd9w2B7w535EvKoY3xA4Dw6QI0TNxqyvkJUN8uFuDAlIjk+DkDRK84lwOxhzTXZbwx0PKN0zWACeTCMbR6g7r5Jls8iJHRAzsXh/7BKhAhOPyyW0NoBhuNb4QY6iAtC+rUPu7qlW+tXQQ5bkov5xB2oXAfRKs7ehpHdTEVWlgeKh1Vv0EmNwfg3vOlCDS/7Sb+wGpas1FDCdQeEYXlC96364wAuujE8YgZ3Lx289JPIZGuLlfaoyXnEX1Reu/3bqnQee/y544BAWZDZz9xTLzOWmMkvnhW9xpRDRCwzKAhrVDiZCSoX9gX+fM8HeqZ06hn0l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRnYapanj2hvIF536VTHpHcFXNca4qFgv1jGKv0/7bY=;
 b=nu+TgXxW+9A1pRuuio1Yvkn6Ux91MhMWEgitg3v2gAJ7vQ09bVQykkqtGBwVlrL3xyZHsEnstke6Y1JFAFyIfZEFz7j0xOVhkG6Ul6tK1G6YhR0onFhXIclFveB+L8S+Yk55VTrbYmTmzztCzZNy0wroZP109toIHcW4CQddMmsPaMUUql+6nrSml0Aw1k6VcdCaT/lgHTEeQroGLVErsP96Rfs8mXeKsj1flU+Z7wK4ywd9V2S2D1Sv9P8fPwsxvFHRdXZnERn1dnSUFx/9QO7BXwVVTeub2AFJmkSyJq0JLKtavGu5L67fipsjvKoZ+i6Fsi3mpapaYUgnN1kqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRnYapanj2hvIF536VTHpHcFXNca4qFgv1jGKv0/7bY=;
 b=iCC1BGKa9nQKU/7ji4qao8j0klcurKAPcvO4l71isitpVfqGPRbJcsDvCkGwjE801pvXUpqraIhBfvbq2LG+aZ1jHbPL/SvdkmSsXXtmmEQq2Vx0EVi2P0fJ0WGqmt/fJnJenj+wW/vCd/2ICDv8MtVFrOF+jTFhMoeNQOb+F+U=
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
Subject: [PATCH 1/2] sockets: keep-alive settings
Date: Wed,  8 Jul 2020 22:15:38 +0300
Message-Id: <20200708191540.28455-2-vsementsov@virtuozzo.com>
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
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 19:15:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43810b1-62a2-4844-41a8-08d823735705
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4070928A9DE425BEBBC7EC16C1670@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv4UZVI5r92eixjZllFpvt4+aDiVE0KSK1PSSd08jCvdKHHg6xnyC0/GMTROcNz5vNZCWKoVMtTvbjzc5SbQIDYKqszGeFl+H+lLdFPiHYZJVtgKde32P0H6n5aULKKn02QtutxM1gQ3jqsqVllgd+3scGDslsCj2c35t4mfZRXkEDYXQKxkeNCuvuTb3PCw1cqXZX8a9/xy4hUIoak1HvLpsSCABxzybzn/n7EAgw3urcUTfWKM1HgB+cIFCqf8dcK6fiZjM6I4honbkjArrFZpEgsueTuuOlK78AdNsKhOFXPURQ3dW/xKtv+E0viwwVYiIqeBigk8Ny+Hs97OQ2SVSSnNZMeKiscfe9fZToFG4FAJvprQXDwZlLR1wCT7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(186003)(16526019)(86362001)(1076003)(6506007)(956004)(69590400007)(26005)(6666004)(6486002)(5660300002)(316002)(52116002)(66476007)(66556008)(478600001)(4326008)(66946007)(8676002)(36756003)(8936002)(6512007)(2616005)(83380400001)(2906002)(6916009)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dV+FuJE8QMHluEiuvN+cTEtHNX05kV3F8oVG2zjmI0GG77SLKFGrZ31UwGrDwWqhOc3Qr+nETzxuZhEpC7YWIojPkiYEpqX9E5Ab0hcsvR2p2B/ni+cHnx+ArDBDJGDK/NDqfQlumbFp10lPaGM5XS4Mn83fDDev7BElKw59bFi2Vg/LdR5L3kdrIxK87AvpzbkgIUvN+cv1arH2CX0EoWR4hMeRVpC2CwPJ520tlAtdheWnIkxakGCEW9QgCHyNI1S9Sf2CGVqEOzuHtPrCp9lhhJvkBelSFkQKZK1ZnqFWg5ZgwdrhgiscaCRTGXKk96tkYtY7XOAAClVase5d5Ph0OVVOGpfYF4J6MJthFDo4UqAgqjBP3Gq2zgyK0ePxfxei4+CyW1UwecJ0gqIo4H7I0lcdTr0MJSnqtc6X9q/G+SMyaBEx754B8FlLritTcMhv8lKqYKtPB8PKBLMdOGePYFbdy7OCpeDq9Qks21I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43810b1-62a2-4844-41a8-08d823735705
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 19:15:56.2860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMEdCZwRgHCanOJQcrt62UqdRs8GhtJiXbUQePQfDi/KlNTV2Rw0NZDTmmVJlF+jveHxVKerNUme9YzSBYStz8ko6gwdVjH1fujS0wCf70Q=
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

Introduce keep-alive settings (TCP_KEEPCNT, TCP_KEEPIDLE,
TCP_KEEPINTVL) and chose some defaults.

The linux default of 2 hours for /proc/tcp_keepalive_time
(corresponding to TCP_KEEPIDLE) makes keep-alive option almost
superfluous. Let's add a possibility to set the options by hand
and specify some defaults resulting in smaller total time to terminate
idle connection.

Do not document the default values in QAPI as they may be altered in
future (careful user will use explicit values).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Suggested default numbers are RFC, any better suggestion is welcome.
I just looked at /etc/libvirt/qemu.conf in my system and take values of
keepalive_interval and keepalive_count.
The only thing I'm sure in is that 2 hours is too long.

 qapi/sockets.json   | 33 +++++++++++++++++++-
 util/qemu-sockets.c | 76 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index cbd6ef35d0..73ff66a5d5 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -37,6 +37,37 @@
     'host': 'str',
     'port': 'str' } }
 
+##
+# @KeepAliveSettings:
+#
+# @idle: The time (in seconds) the connection needs to remain idle
+#        before TCP starts sending keepalive probes (sets TCP_KEEPIDLE).
+# @interval: The time (in seconds) between individual keepalive probes
+#            (sets TCP_KEEPINTVL).
+# @count: The maximum number of keepalive probes TCP should send before
+#         dropping the connection (sets TCP_KEEPCNT).
+#
+# Since: 5.2
+##
+{ 'struct': 'KeepAliveSettings',
+  'data': {
+    'idle': 'int',
+    'interval': 'int',
+    'count': 'int' } }
+
+##
+# @KeepAliveField:
+#
+# @enabled: If true, enable keep-alive with some default settings
+# @settings: Enable keep-alive and use explicit settings
+#
+# Since: 5.2
+##
+{ 'alternate': 'KeepAliveField',
+  'data': {
+    'enabled': 'bool',
+    'settings': 'KeepAliveSettings' } }
+
 ##
 # @InetSocketAddress:
 #
@@ -65,7 +96,7 @@
     '*to': 'uint16',
     '*ipv4': 'bool',
     '*ipv6': 'bool',
-    '*keep-alive': 'bool' } }
+    '*keep-alive': 'KeepAliveField' } }
 
 ##
 # @UnixSocketAddress:
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b37d288866..b961963472 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -433,6 +433,57 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
     return res;
 }
 
+/*
+ * inet_set_keepalive
+ *
+ * Handle keep_alive settings. If user specified settings explicitly, fail if
+ * can't set the settings. If user just enabled keep-alive, not specifying the
+ * settings, try to set defaults but ignore failures.
+ */
+static int inet_set_keepalive(int sock, bool has_keep_alive,
+                              KeepAliveField *keep_alive, Error **errp)
+{
+    int ret;
+    int val;
+    bool has_settings = has_keep_alive &&  keep_alive->type == QTYPE_QDICT;
+
+    if (!has_keep_alive || (keep_alive->type == QTYPE_QBOOL &&
+                            !keep_alive->u.enabled))
+    {
+        return 0;
+    }
+
+    val = 1;
+    ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &val, sizeof(val));
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
+        return -1;
+    }
+
+    val = has_settings ? keep_alive->u.settings.idle : 30;
+    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &val, sizeof(val));
+    if (has_settings && ret < 0) {
+        error_setg_errno(errp, errno, "Unable to set TCP_KEEPIDLE");
+        return -1;
+    }
+
+    val = has_settings ? keep_alive->u.settings.interval : 30;
+    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPINTVL, &val, sizeof(val));
+    if (has_settings && ret < 0) {
+        error_setg_errno(errp, errno, "Unable to set TCP_KEEPINTVL");
+        return -1;
+    }
+
+    val = has_settings ? keep_alive->u.settings.count : 20;
+    ret = qemu_setsockopt(sock, IPPROTO_TCP, TCP_KEEPCNT, &val, sizeof(val));
+    if (has_settings && ret < 0) {
+        error_setg_errno(errp, errno, "Unable to set TCP_KEEPCNT");
+        return -1;
+    }
+
+    return 0;
+}
+
 /**
  * Create a socket and connect it to an address.
  *
@@ -468,16 +519,11 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
         return sock;
     }
 
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
+    if (inet_set_keepalive(sock, saddr->has_keep_alive, saddr->keep_alive,
+                           errp) < 0)
+    {
+        close(sock);
+        return -1;
     }
 
     return sock;
@@ -677,12 +723,20 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
     }
     begin = strstr(optstr, ",keep-alive");
     if (begin) {
+        bool val;
+
         if (inet_parse_flag("keep-alive", begin + strlen(",keep-alive"),
-                            &addr->keep_alive, errp) < 0)
+                            &val, errp) < 0)
         {
             return -1;
         }
+
         addr->has_keep_alive = true;
+        addr->keep_alive = g_new(KeepAliveField, 1);
+        *addr->keep_alive = (KeepAliveField) {
+            .type = QTYPE_QBOOL,
+            .u.enabled = val
+        };
     }
     return 0;
 }
-- 
2.21.0


