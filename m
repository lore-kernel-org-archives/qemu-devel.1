Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F67C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC522074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F0IeWhKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC522074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8d2-0007sj-Oq
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bO-0004UX-M3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bO-0005o5-8Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:42 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bM-0005iG-8P; Thu, 30 Apr 2020 08:47:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmA+xbXhEbppPbPT8ectIydWhhPcLuEFD8GbHqM+1EuhLPQu86zImqD+NIL3NkG8fGFgL3y/h+yYYH8G3rPEdfK7V6rVcTTFG8kQu/5++5N8kAKkdn3xvW9PlCzATIKwgqYUer1/ayZhThBDRjH4v+4S35YkLhRa0edfBMLwRAz/DLq+zMRPaPGr03610vy+Ad6XCJ6d/1ILNQNy3xXZMQsQbLiuHeXmqpQfmq+S7lGppWjwqHj1IWFvNXUkwDScEJtdQkn/hR8krKd6CD4WuFgf0rltWlVO6G4IhZlAfGtHb1A87Ud+kC/IEytNubYynrA24kxlatnbc1eLafhoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEiKDKucFr1NBXKG0lS89iyrgw8lFuYupSiAxz81FbY=;
 b=eHdVTGQo0YCHvrEAo2wCdju9+YTTt/pdmGg9BkYvR7PqaKmnT2yiEB7FKuto+Jv+Y+OIqBXVYq0kDNT4w54SS87Lxz6Ie3AeljWEz3nHsf+d+YBQ7f79+05t2Pl1RFmbKh+Jr3z9+35SIPQK4FR8ZWSW2YWwTMRrxCzIj5xmtFZe/QNR/503aazxFzal7NT7a4hhH62pgWCh/CrEpXAxPRadE5TFUVVaWOHY2njz3M6rSQiLUHEVqAmU2pIgq/jfooPlHFcUDrSxBqerw857Dek0sW6jG2L1KVt2rnETPIGPLCaM/VLNjQMFVf4E+3Tc0UF+BbYfGRBDEysCQktCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEiKDKucFr1NBXKG0lS89iyrgw8lFuYupSiAxz81FbY=;
 b=F0IeWhKdtY8kBKgCAPKDVb1vFQTxazGOckxnO+AnGcgVUABcwirE0qp+xE+7gAAk+sUay0yEbtZk985uLNEvKMzrk0Nty8d6komY7eDODHP7FZfQgr5mnKwwEuqduQXAAIO6xPTsuSTWawVVfT9mD/IaiNhlzoFMPGZ1b6z8WJA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 8/8] iotests/113: mark bochs as required to support
 whitelisting
Date: Thu, 30 Apr 2020 15:47:13 +0300
Message-Id: <20200430124713.3067-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b4cef5-455d-4cff-fb3a-08d7ed04a7f7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478D4F8B2427B7C5C8E21F8C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ5AlUKrVEHWSjM7jT/rWsfd3EicqtZPZ4LoiZ17qFDbvQ8PvWeAh8nUccoNZX0XyV3bgHWCRNr1+mcDx0s2LVkHQ+6F26g+u/wbevEGWvHn0ccPZ3fPhNQDHZZS1fgDV4sFmgNWVscK5JW6+pbZ4gyJnB13lWkjHK6nDKn7emnZ7ddLXQEtJPvJOwErZ7fzKiJN6A2SetALyTkpdQFJDlAQpo38DoFu5j3l+r3ivVQpSxVWqnBcOKl7CB3S3siB7FA7LkkCCEPmaYjsHv/7WxeQale8hh72pwe4rUIHILFdUGOzquk5qGhSEHP1OGwVkLuIADI96QmAG3b7oJOPefyPaKhIi9FuoFsVyIO17ZADIIMlqrqnHz4ZJhwmqrqEcJdr5tStNVcBhbO6NVgbLEYtlwjkdGFdXJDRXvCH3KHzHtVYIK+psW6FirgYbHRs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(4744005)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 10pcYS6I1mCfgJ2k0HOf0O8TXhxkpQ7GQDVoUiG9C4HI7iByXeYDCzt3zXgY7sQEvZLncLTBAil8oob6egILc9j5pT/t8ZFSjPVbwAPmIFKAk5RR81fCz/KeVHAg+fTki7WZ8zy0KOtDi75aNgboyJf5MYn5YlXqUeb6cMtLh7fyF19hZ2bTUSs/v9Eb6nuAISdsJfaWhLlUHPABxiT5b1OR1XWYMFjjjicpLjvm19RmISwrrIRCrl9aNasJEXrKurDh4xcK+C0IV3KU6q8dHP8M0BxvRs+LtPa0O+HCCoPKSyocBpVHn3/wcik61+uaOEJWDYRdIpx9EimXxtGFHNqYYR1zc1QSTwQbvU32gDbP4qvHrrOa+H96wsvboB06U85d7pNjbmfqIt7U1fLls6J2VLIRcAHUp1TWEXoEDqqQLIPIgZACc6FPmTJY5U/ri1yrAYk2H14F/OFHG9b8US0RQ9qZErKrE66C5DCUb7luduEjedJPo6cKXPVLrPhFWlNUIYuDAcxB9AqaE1TioPR6D828vT8y7U5Z26oM2XdeBDXZQiFAujnsa1uApguS1u9QVw5Gnyo6EH566OX9QUwLDUN/1KAGQquGZtS4bcuCrAgVf/G0M5u/XxzeC/sbsPZlNf+H+KGC+QympaLZVQ938Ze54eE19OjAUQpP/TqZnRhJKethgnuyWAS5GAE3dKBPJQYzUCd+D7HzPj9JSpLE75mYYaOOAl5dgN1c4WqMC749k8J02B6UarR8pe7Uf9vp/F5KVLA+4K8Z4BrTK1bVqMpZAxwv9vzoDeeFclA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b4cef5-455d-4cff-fb3a-08d7ed04a7f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:35.1416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VPU10lo8V1/wpjzkObguZAGKPN1RMujcH5xp1kWx/vhk6HtbPQcapMUIjC2pJDfvgZqLTBVsLUDvhPu2zs5SxAdgMn2g/kW3kaxwZ31l0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/113 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index f2703a2c50..71a65de2e7 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -37,8 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-# Some of these test cases use bochs, but others do use raw, so this
-# is only half a lie.
+# Some of these test cases use bochs, but others do use raw
+_require_drivers bochs
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
-- 
2.21.0


