Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C38207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dUmvsL8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C38207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU4n-0008RI-2q
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2H-0003Bo-CV; Sat, 06 Jun 2020 04:18:38 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2G-0000Zf-15; Sat, 06 Jun 2020 04:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUMwDQGfXNzSSZq7lm5rcp9cO0tfWcLJMNjgB/Xco5m9n6N5bVYdEBap3WcRmeYz5AExASjaojoKszqIh1sPnhCYlzaEhqceC/B3nGtRlV2rhS8QuKU1hvU5hNttyfKqoJakm+5jYlZw7lKVt6Ezcx2Euotf0BxtNfRINuQ2UWm99qlxX6tAbUjcVRodIY4VIhdmyYbeXuaXSKOhBoF//00jT/INbwMLTY35dSt4eHJMpb551DdFir9zXYdn4TgVNkknKTK2pwNCj8bUfTc7rsXr6DRfwk2a/sqMG3jmU2AgWO9NGrf+yYIYhtIn8WOOle8mARfBx2+77HMYuL9ZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=042mayG3ikBGqvj2zuaRxqRFbtz06/OoB2116rP3Quk=;
 b=DuD7e5m6mdTYChQL9axrJQkPl3cKwz9oUbrA/6dyyJcMKoiMy0ZI36zUdDFMjvZFTgxXxZKrUA+Q4/7zr6bvilabVpECns0PE+ce5yBeeLCpmeHwkGJJYmO2nFxwGmFRQ/b9/DeYxlL3MHnFS6gZI9jC+iWSRBfxxm4Pjm6JHbVaCoZGfIWsfMYZ3KD020n3mN8kuqSh9KrVlIW/ql5IvMbOxrRul2TfPUSzLPcRr+EKaplNaNqvVQgrux4ECL7sHRdS+OBAQuUCDD79m2DiJUcMV5eABQOdvlk2XroT+9IaotGAO/xk2H0bFy8EQ+NCIbu27E6ccaowANlf9IqENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=042mayG3ikBGqvj2zuaRxqRFbtz06/OoB2116rP3Quk=;
 b=dUmvsL8qUBF+TWjipQXeFXF+iO7StZF0mSwMcuxJU6rpHJeF81+j+HVjQnaL04TJCcQjnkP9QHEUq+YRW5C9xP7yIyjo7MvzyYzQwRY0zVn+7ERVhMl8vPdJ44ujGojjhRKtfzqrZH6QSook97fTupQot4tkfNLE0D3ttC4xwcc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 04/13] qcow2_format.py: drop new line printing at end of
 dump()
Date: Sat,  6 Jun 2020 11:17:57 +0300
Message-Id: <20200606081806.23897-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200606081806.23897-1-vsementsov@virtuozzo.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:25 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b232a7a6-b619-4e96-aae9-08d809f22f7b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54802516D970C888217049D5C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6RVDla50AXhnMX3mUaDF8Cj8rVr9KF2wqn+uZ2djIVeASvgtmDozoyAeRb3zN6bCxD7PizzNmT+W9dHLclChxqEWViKlmZSmlY8O2JNaN+JAWmySl0BuYJjTHYg04+eD0dAB7/5yVS4WRQwPsu0b2R4HQR6I9V7Lkyk+95EnR/FF44AWGbHO6Yz/3VbIqpRx9I+8R2p4KLyxRpoq9H7T/YDljbxt21dM/cxLUjAHq4ExrM2Gxrn6juDNvgOQ7y7gtq8iZbHIRYQKpUx1RwF3P6ZIXr2S0H0birZLgfGrVnnAkPQmoPEs+ehiRYTYAS3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LQHM5fYA0pWd18DFLPUSVn2lvPA78IABYNG7m0EFRzr+G4Ti9yKPY9sVfBF+ntHZGL7WWnSyiJIO0sSgibDhE4yrZUZDB8Db7LM6biprLXYW5xHbxDaJ8xgVzWMeBeTg3pTXMijLzAf96NrVHETZCOME/p/af/LxSk2z+AZBUihEiU3YVQcIw2cx/Cp2uY3lzyAQO8H3HnoVoCVxUVqCAdTfeAOChFGz30ipBUiYJ3+NQkKmGzNvOHJetZx2IqbMh8Xwm2shTyB9LPzKjxo3Za+9FCFUf/vUUI5nxMhbOQidsxb2rBVP8Nn9MNiq0AHi6M1xK1TcUQcP0lHZOGsjuMiFTYjDN6HaL7Sa241C5c0DvKL9i761LOHq0xm8cN66GbosNHhP0f028UpwIVL/AMdhv6n1zzvdHBWi4OIIXaoS26Am3q1kUGftnwbW8KihcNEA9jWKcmKbZYgjj9NCKXUR95Qd/TGRnHUvaLOQYUanxtH0olY7tZblHruyV9de
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b232a7a6-b619-4e96-aae9-08d809f22f7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:25.7618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCzybhjuKgJpgcT6a4+DDCIjdxOmANhDgjF7UcyXdPMS2cguG4YPhRnrlxCOPxfDIwM11J/4eh/1scGWVfB4R8jEf8bDANKofryXYL447eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.20.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 1 +
 tests/qemu-iotests/qcow2_format.py | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index e968869ea6..8c187e9a72 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -27,6 +27,7 @@ from qcow2_format import (
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
     h.dump()
+    print()
     h.dump_extensions()
 
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 0e517c1bbc..2b6c9612ae 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -155,7 +155,6 @@ class QcowHeader:
                 value_str = f[1] % value
 
             print("%-25s" % f[2], value_str)
-        print("")
 
     def dump_extensions(self):
         for ex in self.extensions:
-- 
2.21.0


