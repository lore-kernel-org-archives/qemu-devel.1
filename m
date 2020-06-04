Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93D12053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j2EQjunF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtuP-0006Bx-1i
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsW-0003FD-H1; Thu, 04 Jun 2020 13:42:08 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:37664 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsS-0005oz-IP; Thu, 04 Jun 2020 13:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0sDrElGmw0iciNv8nntVZk9uvJdqxzUiJ+Mv+FvN5MXkOR/n136yPZ0wauJ3plyefIAFHTIHJ1VdjZhKPi4CMKyGBqgluXgF6FPH1G171f+OkxnAkOkAVEJlMfsjr6jtd24dlKkAANv9gn9ZuvUH48SPRsKqmQS7NDgqISs195EfiMJqCTumYWVTUuTIXR47W4OyZlPDNv1XLhbm0fg+RRCUyQ4ygRK0Cms4ZmSimjTaPgdNP1GVlyo6vqHarwi0G6R73/pINB51fBHmUaDcBUeOOQWB0ld9RyKEf6ZRXUIbprnLE3TUGLCMycxAf4x/4wz9IZ2dJpygRXRTLpI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlQ0+04pOg0uYzgX1xyCAPm/hccG4vcFx1Rjl26i0HM=;
 b=foz/j/ud3JOqUGEUZWM7TF/9YqHuiZpYO+BjK2JV3HHFa0vSE09EM+Xa1VpS7S8ASW1zEkVmXXeJ7AsCbXf9/IOoMida9ZC2tgbQ0VGdGPCm2Y5q9+sAWmGktPfOCLSYtpc5IceM+xo5jXrAHg0gZJJwdZXBOq2aL11gReJ0HmY556kcpo+yhodDrPZdG5zz361vCN1VxSzWIyNWoSiixlwPulcNT5FX3hAqkW4gnww08Vu4UEqsUiyZnGCHk7cXFwHsHE4jMgpqrK/kLnW9zcS3HNRwZtxXO8cB6lEcFEIbeEpU7f5MITUQY7Wj++Zw/XZFs5JHhSTklS0P2lZ3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlQ0+04pOg0uYzgX1xyCAPm/hccG4vcFx1Rjl26i0HM=;
 b=j2EQjunF2ubWlLU6AB9Y9BDeqDeYWcKJqY1WWgV/zzR3CnVOMlVERg8b9i7+DrTZGb5XLzQu/0T67Ghw+dEeF2bbKrgY2OSu+fPn4fJWNrx3m0faLI35fvACnwYlkrdwlwVl0bHzQhPkdqhxsa0kmOkvlmKGclZH+sE+xzSU4nQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for extension
 magics
Date: Thu,  4 Jun 2020 20:41:34 +0300
Message-Id: <20200604174135.11042-12-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 675f68b4-2cd0-480f-6092-08d808ae942a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381BFAEAF6EA05C62C4EF8FC1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Qt8ozsBPFxpe4Z2TXAZiMz7JNTdPR9YMUPYIY+g52w/6LSfSl9PVGXuWMt8s2QXDCOAgPgH1dyx6in0/U2T7y4Ad69K+bEp4boxFV1Cd8oAInpKYRzL2IICNvaCg0MVZuiKJst/2lHvFtJMumqi8CkOicDu8DDH9v914QQbMowqvWTtfZQ14O1jxJQ6BpFVHczfCqQ2JaoYEOJQMbQyexLM4nib0eUOEjK8sq/zWfwlXBh+NTky3MfzUPI7fXDdRYZRCNiLzl//5J0YJ5UplHRyEbCac22I0YWMtDgmabiadABsw76ux871sAkEswtfBN6kQ5GNgMAyVGpB+2E9tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Mtr0q9Y39lIfZqzk3fcXd410r58NWQiQF0E5gotOm4a8RSpmDlfZwsy8KeQW3Bpc582ZCODS0g4eLwDk5ZrmtluLmlhvCYs25eyaWWDEEReznsF06JJLnPDS43NNNjEk0bXRjVGdz9rehGdPNBfJUKzESvEcrbS3SX+XmnkKcAbV7jz43CxB+9E2uGMysU7kQygGLiZUXK4LBMS6PBPzGFsIfVgqvoj6yWjlo3e4km5fhq4hannDxE004eTwuF6LoSxx5wZtsxbvmuSk7vWaXF9DcmNnTyVmBNPByaF5Jfnspv0n6HRGvmgbAjC3dBxu59k5XiPAlnrYn93fWyLlAhNeFzCPPi62m8uB388iNcN20y+pCNDU9uEApV9INHs9SQUYaPLFsoikaSmDzZDsVeixu1ZZyb0JCgHa2kBRL5CICypEWepvEihmcTzEHOrnTG8AmgJImur5jFoA8x9frtJ4ekNYecpLg1FwsCtaT/o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f68b4-2cd0-480f-6092-08d808ae942a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:57.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+jNZON1QE3JEaE17q3BbdRVFDT0isw1OvaHlyZAoeEre8Lif4YnsjsmyQ7dgJSpRm7NhefUETPc4ILg8P8HOuB+sv+gCKPz4WaSov44MsY=
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

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 5a4beda6a2..e0225f4247 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -53,7 +53,7 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -81,12 +81,12 @@ refcount_order            4
 header_length             72
 
 Header extension:
-magic                     0xe2792aca
+magic                     3799591626 (Backing format)
 length                    11
 data                      'host_device'
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -116,12 +116,12 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -149,12 +149,12 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
@@ -182,17 +182,17 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0xe2792aca
+magic                     3799591626 (Backing format)
 length                    11
 data                      'host_device'
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
 Header extension:
-magic                     0x12345678
+magic                     305419896 (<unknown>)
 length                    31
 data                      'This is a test header extension'
 
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf60e..6cf892123a 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -25,7 +25,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -37,7 +37,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a51ad1b5ba..7afd2be9d9 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -83,7 +83,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -139,7 +139,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -194,7 +194,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -263,7 +263,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -325,7 +325,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
@@ -354,7 +354,7 @@ refcount_order            4
 header_length             112
 
 Header extension:
-magic                     0x6803f857
+magic                     1745090647 (Feature table)
 length                    336
 data                      <binary>
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 4683b1e436..caa190f7b1 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -21,6 +21,12 @@ class Flags64(Qcow2Field):
         return str(bits)
 
 
+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value} ({self.mapping.get(self.value, "<unknown>")})'
+
+
 class Qcow2StructMeta(type):
 
     # Mapping from c types to python struct format
@@ -75,8 +81,17 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
 
 class QcowHeaderExtension(Qcow2Struct):
 
+    class Magic(Enum):
+        mapping = {
+            0xE2792ACA: 'Backing format',
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


