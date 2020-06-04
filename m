Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E619DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58D0204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GLVViEPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58D0204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgu02-0007SD-Tz
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsP-0003Bm-Fm; Thu, 04 Jun 2020 13:42:01 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:37664 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsO-0005oz-4V; Thu, 04 Jun 2020 13:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4J1WmWuAd9G3A4+blesiqRPppIJlgP1/kOsEGcap4aW8TXTv/aKsTGLSbeOYXwFAcy8xGC5dETRfRpMhgXP0NzlDf7IWGxnOIGJfTkX9XEpF9k+o0NfAP+TL/jNsVoxLxuuddTjpRF/3YdkeEuquc5cPneEbpZMesWraKiRg5L6/NboB35bKNG9jL8oTg91KNLHw5teuOo3AAaLN2R6zTxYBkx3SGm3Aw6dQGGCB+5494eWE5x1SzUs5wjHIaqY0HKiVHYjNX8AObGCDbPhDfShg6XW8oVe1SBqcrxRrw5+sMfnMhr5fM2MZGbmm8iGuWEIM73ih4EIlq0b899XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h72cIOwFcAvXsyXvShlntJjqindbpzVhggb0XZUMrFA=;
 b=A3MOOCwEWXSm0cDQNd1O5ZTfKQMOZR4TEv4luaHwZEBVeUyI3f/Vq/BQDvluuNwhU82AgtlPF45x5dz8g0ywWDAVyvD9v4Z7lV7Ep+gBIjJsuFJhDaj6Lm6TiKj07h5m7Ea9AZHEyJrXYTBkOOLTryNP6uxWHWPH8mvRvtwNHqFVWaz9mD70R+aYNIt20iRTSKoq4EQcToEvnX8Gl4JtS8AnwMmARzoAP+NVtt6720rMmR/25zU9BT9ee+hytfpR1N7UfFXSXXWqRlocR9M1iryuFzh9H4HbcYifqnB1cnw27n/950zicxbiF0G/ZTN50nKyEeOft0nfMivJhSOIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h72cIOwFcAvXsyXvShlntJjqindbpzVhggb0XZUMrFA=;
 b=GLVViEPqaqt2WBmBEGPC8J+Az3y+xvnx2imEeYtSP0BMKfbUANWmWVN/a6/YPGCv2oxfYukJtvwHJfU+RYmcugb0qJ6YPNS/5ggSRjDQHHG68a2e7VAVwxeFuWLZzUn4uYGbeZAzGvxoy/Sf5sJh4hPGKy9mv6NQmBf5RN/Jjjk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 03/12] qcow2_format.py: drop new line printing at end of
 dump()
Date: Thu,  4 Jun 2020 20:41:26 +0300
Message-Id: <20200604174135.11042-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200604174135.11042-1-vsementsov@virtuozzo.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM4PR0101CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 4 Jun 2020 17:41:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08808089-2afe-49b6-7c15-08d808ae9075
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381D1D54AC329FDC8F92187C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMfktcIqnneejpoS2C29EsxNGI5Y9METyGjApZaXEQXK1edEtNtH5axOYUPqPevVEKy3vokMDH6KpbsqxgTwVt8+bxe0oByRAifquMQAuxgjLoOHWqBNpQdBTA8WJSXYmE8lwOSvdPM/t0op9IdEuGuQ0JpGrBNnycz9ZdziAHGzhVOIZ9T0v4ay2GTeH/EYlhxRRFx4UmFSM5OwAhMJUUlZhARjwRZeu/mg5MI2zzOeCwLR3ehhORC9ARa4NQxXQqwyvEEJ5f4kAlRQtH5FW4p6ojMm5oqCe/IhDonrzwvBbaMLpm22SZt+RvnQgXYqrQ++nPG1kjXVhFWpqoPyjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(4744005)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: m0hkva1gWC7XvzPfizZr/43bTB1+2jD47xwtC4op2n3GOMkhwK6Nn0e7pBirJ+0MW/xS0B9k5QHI+ejSQnr46PmCAOT43u+gpe3wWE/v1ZnTBy9+LRBwe0EIH4snJ+cnw90t0hYFPwMryHKyOuk/GwGROrdmUU8AYgpD81Yvzl0JaVlYvaFoBGc2MMmuyVyeaYA9RvO6JMSmEqcAxXvUq757hxkFrME8r8wkB9LwqyZp6qMmmKxyBgsvlyF/Vj0jTSeYmEN85BH9Wlf4hgkTDyOt94JzA0U7h5jjIZwqyB6Wc1ZldJ6gKz3MEMBnUBfJL5+W5tYYRj8qntCgdp1rzl2rZPi7RQmg/CHu1lHtwKH8DrA+0k5V1MVY2kheoyU1kxETSgzJ7Ii8bKYkyb8ZBfTO1FjPt3LGaVzyCiyy+vbElw1KekPvHXFEMSJSfVfGWjYhV0Os7/SUZrbVH3taJJFujJnDCXFHOwxsoP6XVuZ8FKCT4mGf92fi/CQ+dqyn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08808089-2afe-49b6-7c15-08d808ae9075
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:51.5478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j7GcZ27g6I+1ax9FH4FKd0FUxWIEHQJsHrzBuyLjwDLc+kPzyievjaUmDUxajRAtp8ZDT6xauUDTXZsTQo5wyWrOA/0qWX9ehkgVrP38ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will simplify further conversion. To compensate, print this empty
line directly in cmd_dump_header().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 1 +
 tests/qemu-iotests/qcow2_format.py | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index d9c41668fd..79db81b040 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -10,6 +10,7 @@ from qcow2_format import (
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
     h.dump()
+    print()
     h.dump_extensions()
 
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index c7270a0a6e..99e5248e73 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -139,7 +139,6 @@ class QcowHeader:
                 value_str = f[1] % value
 
             print("%-25s" % f[2], value_str)
-        print("")
 
     def dump_extensions(self):
         for ex in self.extensions:
-- 
2.21.0


