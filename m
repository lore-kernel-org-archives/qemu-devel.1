Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EEDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405CA20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zu+C/YMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405CA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSr0-0003yi-Fk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpy-0002mM-9y; Thu, 25 Jun 2020 10:26:46 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com
 ([40.107.6.138]:2563 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpw-00061d-Jy; Thu, 25 Jun 2020 10:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM6zha6hz6NsEFjpw1TuOG3Tarbl1EeH+0t3BsO27XIzdorOfLNKi6XMxvy3v7JGx/eLHB3hikuw3dJr5offe6dr249Db3gjbZApMy7jmQH4gkD7zIBBuvxPMgfRY4WOEQ+xnASB0kb26TMoQVW620+GFU2dhFxHfdWU1Zbo8AvynwZijWCSNJ5Q/NOgUzizim/AZzFhPSO82k5D6D5gY0smyDmuHSMzHsy9vPjmHtmvpsFf5kg6kSqhis0yIQkRw78SkngsnV9CpHks9LVmXk1qfRRPooCurcbizPulwExZLPMxSbKjmcp7NYntWFE/I72/oVpspaBSLKid4Y5bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gf/fm1Xuy5nNsip81jgnPQAgfaRX4h9522+LWJgoMw=;
 b=JbnseEl3fjVDjivolutS5ymb485qj61D9OSytJpwRDr1uMaRjTI8l3s35RNTlY7P8ihfS2RXLvMOB21yjF4ZFohbQ5NUHmprFqwIifW57xIQ0vB1n29neA89yPCDGDW4DGaCtsGT/h7h2UQ5wlMOBs4MRX8nVubG5MaP0PlGpNPYszvA2iJyzF5DZWvphdmO0WH+iBG7WUwxjFhoFNlmGXhTDlvaWBStuFSEGfT+bqZ60T4u/XqKfYMMzpQTe0JF49xMcYi4PCrbPi09f+c4hO8d8EwRVHfoRcNvGANGIYjpVBct7tTlEUCjYjiJU3IxH9Y4Uk9OvVFZz7T/r2TtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gf/fm1Xuy5nNsip81jgnPQAgfaRX4h9522+LWJgoMw=;
 b=Zu+C/YMt/KD7m/k31PK6FI8r0Z7hONrTGGrwxdqmP5XXMKxTfXIGNWhXU/r8LKbZOpJdZKHvuJQRS8wcWEfqnBxgODbYBrjvVMc79Xis+tkHJqMeMtueOq7Qj6v3v/oh4J6tyoa/sM3EasqEVv8h8Cmj1iHxjeFcksYGoG7i7jQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2100.eurprd08.prod.outlook.com (2603:10a6:203:50::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 14:26:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:26:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/4] nbd: make client_close synchronous
Date: Thu, 25 Jun 2020 17:25:39 +0300
Message-Id: <20200625142540.24589-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200625142540.24589-1-vsementsov@virtuozzo.com>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:26:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a236c39-a9d0-4397-92fb-08d81913c437
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB21006EEA268CEBA28624523EC1920@AM5PR0801MB2100.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF47U7O66pfirLDMqb+F2BlFR08rTOmJmE1HTQ+KVpLUIooZjQQM23gYRkQ17k3C9lLQ4JuygET3SHJpRBbFsmLZcr8kqw2PwKPLrukCEvATD8g2drgcqP3GsqYkBF87de1uaJfNcY1laMDQxvZ1V62ZO22ae3x1dfSz5A+F3oj+9sF2HPbLgjJ3LfgpRGuo6QIkkKxjtOo9GJHo+QHt7HMDzD+01TC7SjomahPrgF4GdXwyGY24HojV6QEhsEBs68dJWq52WDUjWvYPH/xDYoSuA0oNW1NxuwIhGuRFYFnUTHRtKCVanEn1KdhxjI80HnogD6A1B5afkehxmzAdXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(52116002)(5660300002)(6506007)(2616005)(86362001)(956004)(316002)(36756003)(6512007)(1076003)(6916009)(8936002)(4326008)(107886003)(8676002)(66556008)(66946007)(66476007)(478600001)(186003)(6486002)(2906002)(83380400001)(16526019)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Nvk03OUJU9deoKigOtAQGdop4w1DX3BBR3J8dBNo/CDNnETr1QGv8w/jSdvpn3y7miuWp3pncx6d6Rs/Z04pv74uMfxxpzmFmttaKXZuslB84OaHhOJuJTN3ykC8aOxz8+e7XpsEx+s0OuXisKYRqiCtDC5PFGhQwT2ljFR9VeE4Cq/YHmCPS5ZPJxyClX82Rd0zrZpvdvnJYzVjhzHeUe/UAZ5IAfPZUuOlQ4rIKWQ21ZzJGmz3GkX28nj2YaHBlWDT42iTpdxc3SD8pmh+3ollTa9ELOJVMBkFpGgVnWzw/uzwfQJ4WKKlFVo1rw0eu031nOazVPO9GH9ITo+czoIAFhIoicpeWwODaaTK9EEMdlz0u9XaBK42awaOgB8X3vBmjKz1x5VBl3gaxC+iA4ncXDuUocfYuQH5x5sbkvcf1faJiyQJ/rTkmGy81pfUoDV0MRFYGrwpPC5g+Vv4IyYoH9JEM7BPA1CCSRQzSaI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a236c39-a9d0-4397-92fb-08d81913c437
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:26:36.1507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQlZBO4YYNA6vIkTmUiRPQyICva1NO05iLxpOuYCsrjBZHYG06sZVp20ccN1Rvv9pKgBKh0xwBACsR8/+wR0Qu//o3Uo3tWD1jC3wy9BHfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2100
Received-SPF: pass client-ip=40.107.6.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:26:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

client_close doesn't guarantee that client is closed: nbd_trip() keeps
reference to it. Let's wait for nbd_trip to finish.

Without this fix, the following crash is possible:

- export bitmap through unternal Qemu NBD server
- connect a client
- shutdown Qemu

On shutdown nbd_export_close_all is called, but it actually don't wait
for nbd_trip() to finish and to release its references. So, export is
not release, and exported bitmap remains busy, and on try to remove the
bitmap (which is part of bdrv_close()) the assertion fairs:

bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 20754e9ebc..5e27a8d31a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1419,6 +1419,8 @@ static void client_close(NBDClient *client, bool negotiated)
     qio_channel_shutdown(client->ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
 
+    AIO_WAIT_WHILE(client->exp->ctx, client->recv_coroutine);
+
     /* Also tell the client, so that they release their reference.  */
     if (client->close_fn) {
         client->close_fn(client, negotiated);
@@ -2450,6 +2452,7 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     trace_nbd_trip();
     if (client->closing) {
+        client->recv_coroutine = NULL;
         nbd_client_put(client);
         return;
     }
-- 
2.21.0


