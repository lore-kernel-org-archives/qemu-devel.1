Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C4E2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qm6tWEV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C4E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtvB-0007Sy-TM
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsQ-0003Dd-KX; Thu, 04 Jun 2020 13:42:02 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsP-0005oK-Rv; Thu, 04 Jun 2020 13:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw/aDzGCm6bY4GF/seq85HV2Lrco/x7gb7XuEAv0Eb1TObWsxWm6pbm+JPm91qNQXoDBk6D9+maVe3ntoqL3Ug4Cb8SG76H+/YT+EPPOuH2PzwcwTsgslEDOIpcJx8FvWZxh9cCfTzuGgM64rxuY5E/gFXWqedVX9iNm2z6WVzOqzDijmZ0jjUDHzAF8V3Tp3GhFKhkZr+wFqaS/jRiBTKz093GjY6Jd5yW86eNu4ztDxLXbPoQVbjcWfuqMt0eKhI7RhHRowBp8+DpW7i1q5U0v0HJ6ta7aLhmaiszQ5/A/NR96NtiNYocDdix2DkmM0RwZTX6szU03rTVpLCbLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QenxGvaEKfRv5eO84BLY3ff+Cj9E2+GrqCrw6ue/Jd8=;
 b=R2fkBDdzQHdiK4t3hVpOcP5VfGAOX0qEmRVxWd16PipdoW2SKC6i188TMkuZJkVugSBlx4d4lLo+cmwNHjwY4t9VdbFGqEYNI/yOgT/N+6rSVp0rJf4Ho5kCeePTvPRTsTif7Gxqju2xAiNQwOtIaIIpaI+kieDqSMVBie3CCCU0LoWVrijzlDJhzjMD9IJ+Uk6uchh54CXFTWnegBniYNPS2w+sf7lr8CRgNjhDWO7CFfi7YHI5p5INVYFBE705xUbkkMeOHEjcvMdO6GeyvlZ4sAQ1HGbXiQdUHw1x+zV60Fpqp/rHHXyxTCV7PcpE2IjBDGBaAedcHvqK84WSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QenxGvaEKfRv5eO84BLY3ff+Cj9E2+GrqCrw6ue/Jd8=;
 b=qm6tWEV/ZTjMPRifFcR863bCGpnn8Ov7GjnGpyOYvo6mbDyYEyM57khycnyLEJWnb6pqMx6jATwCZNUk9YdETPpbh5UggcNFOwiz4OBHDdSnEKF8nkoqLskq0fH10Fd6ICXl2w6sqVxD+BIwD8KAsxr8gXnDQdqHB5u+9Drtjd4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 06/12] qcow2_format.py: use strings to specify c-type of
 struct fields
Date: Thu,  4 Jun 2020 20:41:29 +0300
Message-Id: <20200604174135.11042-7-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6718923-a519-4cec-ea83-08d808ae91e3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538146559B7DEDF62D4AF2FAC1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNNR+V6WqDAAMp5TfK4RDw1KlH0gZEKo4Zb0V2Md0nwRj0hIKt3Fun+VWVGVlyNTB1suQAEsRXxE7irqCswRnjGKsEgnnLrBreIgUy17TCb2l025p72Bqtu0FMytiN62r6q41IcjNHcdqPwUxENa+NyfAC8F3BoxUztogdT94BKDiWhA9ls2Mo5JCv/4qiq9717/bKEZLBx+Ne2hgWC2iUK0fAffz5pymck90jFpvEUzqzMLCFuG3oFfufcWAqbEjdB740BSijtoSAzgr8gZjZh0SakbCTlVmeQyESZy0lAIw07DXordD7Z9Usw6INR3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0rGnxjEdFx8C6NH8QeEVYhSVxWCFfVvmVtx1cIRydXeev6BhXLjJIk/XawE4pAFXeQ4TgvjnJQpQ87f4qll9NGE5qFQOpWRwdI2OExZaPj3U07/BM8OIpptrUhu8ICoCHXQs6IsxzOuXAxRI4r+ADOt5Fuvl9P4bPdaqtSgvnKF9NXi5i//D59I2B3OkLjZtlnyEzIgG4Vc2XNz0cJVInLEWTdg0u8yGwoUcyiC20AIxCZQb97wgwxkSFWo815LoBWlld+ZcKrxTM2rFNI7UfPLo1v7xDdeftJA1hg1XfUWSYfCi1aewFgBDAIEob15xstLTgj5rumtskpjkPvt4JF0QtflluXjYi2W3jyMPKixGExAEkbNwhSso+oQ2HI2oibKlGzyfoP5teKgTF1P2YlY2HqTMi1vXYgbpZEK0mQ6yRP+/ZPUjN2wblzYXNCknE1L3m+09I1mjs5ugzO5ArY9rLkbArjMxQzO0Errw5jI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6718923-a519-4cec-ea83-08d808ae91e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:53.9472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErlX7S87X1HJeVr0KMSv+yh6Fa65fFdcXjq9rO+W1T/EqE/2OOtZLX2AXx81oWYJKnyqRnAtIV3VZLmAE66/bCXy0rklp+CavR5noLihRn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:50
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

We are going to move field-parsing to super-class, this will be simpler
with simple string specifiers instead of variables.

For some reason python doesn't allow to define ctypes in class too, as
well as fields: it's not available than in 'for' operator. Don't worry:
ctypes will be moved to metaclass soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 50 +++++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 80e7c3f81d..1fd9473b7f 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -18,36 +18,42 @@ class QcowHeaderExtension:
         return QcowHeaderExtension(magic, len(data), data)
 
 
-class QcowHeader:
+# Mapping from c types to python struct format
+ctypes = {
+    'u8': 'B',
+    'u16': 'H',
+    'u32': 'I',
+    'u64': 'Q'
+}
+
 
-    uint32_t = 'I'
-    uint64_t = 'Q'
+class QcowHeader:
 
     fields = (
         # Version 2 header fields
-        (uint32_t, '{:#x}', 'magic'),
-        (uint32_t, '{}', 'version'),
-        (uint64_t, '{:#x}', 'backing_file_offset'),
-        (uint32_t, '{:#x}', 'backing_file_size'),
-        (uint32_t, '{}', 'cluster_bits'),
-        (uint64_t, '{}', 'size'),
-        (uint32_t, '{}', 'crypt_method'),
-        (uint32_t, '{}', 'l1_size'),
-        (uint64_t, '{:#x}', 'l1_table_offset'),
-        (uint64_t, '{:#x}', 'refcount_table_offset'),
-        (uint32_t, '{}', 'refcount_table_clusters'),
-        (uint32_t, '{}', 'nb_snapshots'),
-        (uint64_t, '{:#x}', 'snapshot_offset'),
+        ('u32', '{:#x}', 'magic'),
+        ('u32', '{}', 'version'),
+        ('u64', '{:#x}', 'backing_file_offset'),
+        ('u32', '{:#x}', 'backing_file_size'),
+        ('u32', '{}', 'cluster_bits'),
+        ('u64', '{}', 'size'),
+        ('u32', '{}', 'crypt_method'),
+        ('u32', '{}', 'l1_size'),
+        ('u64', '{:#x}', 'l1_table_offset'),
+        ('u64', '{:#x}', 'refcount_table_offset'),
+        ('u32', '{}', 'refcount_table_clusters'),
+        ('u32', '{}', 'nb_snapshots'),
+        ('u64', '{:#x}', 'snapshot_offset'),
 
         # Version 3 header fields
-        (uint64_t, 'mask', 'incompatible_features'),
-        (uint64_t, 'mask', 'compatible_features'),
-        (uint64_t, 'mask', 'autoclear_features'),
-        (uint32_t, '{}', 'refcount_order'),
-        (uint32_t, '{}', 'header_length'),
+        ('u64', 'mask', 'incompatible_features'),
+        ('u64', 'mask', 'compatible_features'),
+        ('u64', 'mask', 'autoclear_features'),
+        ('u32', '{}', 'refcount_order'),
+        ('u32', '{}', 'header_length'),
     )
 
-    fmt = '>' + ''.join(field[0] for field in fields)
+    fmt = '>' + ''.join(ctypes[f[0]] for f in fields)
 
     def __init__(self, fd):
 
-- 
2.21.0


