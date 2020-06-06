Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380BC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276C1207F9
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RWTrPjMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276C1207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU8L-0005rS-Fp
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2R-0003SK-8W; Sat, 06 Jun 2020 04:18:47 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
 ([40.107.8.98]:10318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2Q-0000aF-2K; Sat, 06 Jun 2020 04:18:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMI/g0iAc7BhgiLS2r5J5e+h0GIMua49hZyDF+pU4ADwP2C9w8fqcFqvTUa+CekRki3ZYa/R8lhtjiR87G+e12T6Ey4ZPf/GbjV6hy+6xGiePnds/aQTgCBajYGpduNYklxG1MQPgh7pfW7ky1BqRykCJBw3SL6wxrYnl1Tm+1zGrXze3pHd6pyhvxrM1NiOfF6yfz7DUvPmedrlCxnOnLxgV0t1CHyRfnl8sE/XtVylgX4CyiQNwYzSfxNeCgWa9PHqiYSmO/DemyTieAyhoxztwR15Zwmim0ax2xhMr6p468L7jBZOtMIPrVE/uqfPdnJ39IlQ+nXEIG+nY/oNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFqwTS+IEIF8fiGePnW8TJ+NGVw52lopBfxN1fYrXtY=;
 b=WAo0+cscZZN7vIThmlqUmHi/BUZXWoefy1/VLctC3OHpra8wgl+/oqLLzFj97HnTLiwE00cUSmRBgDuNxBPpgmfYe5DmXHa37kzIabARe5NzvG9sU/GdnozKds2ts3KnBQYXeGhQ8tuohkXUuHp7+mgmE6zFp6oclFr7B4ZMJZ2gsmNEza7REKsNV8vUzSeFv12rUWDp8uUOnN3At4PIF3J1jTCkhtxBBuWJPlxYtlmhGvhcwIiq49NFot6sfgpO5D7CyAWLeNzg97yM3HfZG18UM/x5lg45+LQ5D5pjHTKg3d3CKxulI3WhdZB2AYP6y43hMUVA/MnZA1Envlb6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFqwTS+IEIF8fiGePnW8TJ+NGVw52lopBfxN1fYrXtY=;
 b=RWTrPjMtyb40GxybQ30vdg0X6LULDcDFBzpxTAW/2nMMgkPpalSnpG7lXWo4boAhelaEJMO6C8myTqBrxptxDxLnxPqnVOEkY4nD7B2O0+Q4twZkMCLOFT7pqAEb2yjLejmUT6x+UzTOsmMORH/K3m7N21hKrJz4gTiMvMY00k8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for extension
 magics
Date: Sat,  6 Jun 2020 11:18:05 +0300
Message-Id: <20200606081806.23897-13-vsementsov@virtuozzo.com>
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
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c304ed-e996-42f6-b49e-08d809f232e8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480561AE2C35930FA12CF2CC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbQnHcp6xwnny4mGS1oZ4eOP3JfQSHix0PEomjoo0XKPfOxJU0RMCIh03c2sslCWZmzNsG6avMnHVD6FlrGsqq8keDoit5b2WTaHbWKbaFS91KET8Sa1t/aMxdKXNRj1HkOf7z8q2qb9n69g23CixPdcmKtdh8VZx+VGyWLEoxG4HCa5YR4xG5gTLCS3TBwzYW/Ety4vPHLrDdYJ2O+RGEsW1MyoNfunomrLPfIS8N51ozIZ4vjUzsaSsXCFmrdUvVC4JMdU2qBvU7GBdzUGA1zYVXNyPSq2J1bbhyCS7rRI+D4P3ZRZJGgJ1aKIeqMnLelaq2GeapHwwiSw/147bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bghchejYWGjT0CnbTyPdVVHjQQeMLg8VLCC5cDmYkf2L0l7mAvW4Eio5P7watjGShTfzeaMjX4Za9zmGteY1PEFUj13TtYVrbspnwFZtUwDGwRmBxu3xAuEwymWP92o17f5sDFfP8oK4u50nNdV7ILzn8rmUXtpW7Do7MMAQmZYhO7ElS4R3IK+bPgF9QE/HrN56mr05A0Yf3oLiOlTUFhqrW4QMpGw/BFNThWtWFrA0FPO2VWYcGW0BZR1cE9+1nHmyNs9VMpOvRc/F4YHc1Uk6R5O/ZFFjikbxkOcfmLFrBhX6qmr+X49awTw7kExg2Ze8HJcsfFpGsu/2Be1MGFHtA3xkw3FXo8u3GYf+0dDBGJnCtDIvgQIG+2APDQlPZyMianeZZmsq/0VSHDTMUxQlRlvD6vPrg9H+Mo4cZcScCjWYCjnry9LePoZm+DjhEdd+rDdOjZD8D0ODMbT/BgsZ/E40d2OuQoNTIRmJfZY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c304ed-e996-42f6-b49e-08d809f232e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:31.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66OMLWeIpEg75X9Uzu21Ko4wG2+chWP/9/wFIJfGnbUneehMLsYZ+7hTvY3wxLFFG07dKKfL7n6jt4HWesFSgAEI8OgfiPQssO/K4iEO2Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.8.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:34
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

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 5a4beda6a2..4b21d6a9ba 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -53,7 +53,7 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -81,12 +81,12 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0xe2792aca
+magic                     0xe2792aca (Backing format)
 length                    11
 data                      'host_device'
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -116,12 +116,12 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -149,12 +149,12 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -182,17 +182,17 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0xe2792aca
+magic                     0xe2792aca (Backing format)
 length                    11
 data                      'host_device'
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf60e..a9bed828e5 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -25,7 +25,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -37,7 +37,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a51ad1b5ba..2f03cf045c 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -83,7 +83,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -139,7 +139,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -194,7 +194,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -263,7 +263,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -325,7 +325,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
@@ -354,7 +354,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 32371e42da..40b5bf467b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,6 +39,12 @@ class Flags64(Qcow2Field):
         return str(bits)
 
 
+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value:#x} ({self.mapping.get(self.value, "<unknown>")})'
+
+
 class Qcow2StructMeta(type):
 
     # Mapping from c types to python struct format
@@ -99,8 +105,17 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
 
 class QcowHeaderExtension(Qcow2Struct):
 
+    class Magic(Enum):
+        mapping = {
+            0xe2792aca: 'Backing format',
+            0x6803f857: 'Feature table',
+            0x0537be77: 'Crypto header',
+            0x23852875: 'Bitmaps',
+            0x44415441: 'Data file'
+        }
+
     fields = (
-        ('u32', '{:#x}', 'magic'),
+        ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
         # length bytes of data follows
         # then padding to next multiply of 8
-- 
2.21.0


