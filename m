Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF64207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bnOD2L/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF64207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU8E-0005e9-Qi
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2L-0003GH-0G; Sat, 06 Jun 2020 04:18:41 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2J-0000Zf-NW; Sat, 06 Jun 2020 04:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu8YYEQpwKBAik5L1XX6qe3t+CBYttk0WX/oe5IU4HnknBQBA54qwkciOcE9xzKiK977A1WWi/uhu2icqVRVQhY293zb/5WXVwnBUktX55tiLkSp36rCoYEK4aBL7yqo1d0xH0XUGGwNff0rxJEd/CbN7GmUBnxVKMssHJhUJCWpLUiETTgH+/Y5C+nHQhHUsnHRKkj0ujKmVDluclNhDfUd0DYfpWYCA6M+X/9l6yOaF8hblqva0BP1GLpKIxMrgzpmDeN/zJnKrxkDUFq3FLzMY/iloE263I9PXimQn1bIGWIVm5+9G8adkUqQcc9ELf4gZZEJrEiM8hGoh8i/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07M5mSe0ynU1SWeUTUqfG3L6vjoa1fNC2Z6hlBZsuJQ=;
 b=ClfLOaiMBEXT+SRdm3ONpR51+kCwLLGkqEaVlpRAbcgasS/ljhsfQYc7D7qu3uvZPqtZoCurhCUYZ0CkyfwpjInzFE+9moh0F5UYCNnlycg1rEwFn13J+bJlIX7KhDyMPUERBlInRiSuRZedHhphJafuD93f9graIaLV8BeBGSkqNljyPVDenJquOlTVY9DrXHwDo1IcB0lEcWH0B5V6TB4FEmyF7c61FlgF5Fy4OIiX796oZjdpvgBdkP7+r4wxbHK/V+ZlOJZvZjY5YJhn0y+cbXyxi5KlWKD/ZkNEp7f4gCM8Kg21nSXYohfQdKmHw9LCX4lqQTFWl2htY0y2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07M5mSe0ynU1SWeUTUqfG3L6vjoa1fNC2Z6hlBZsuJQ=;
 b=bnOD2L/DzcG2Si0mYIPL5DABlKwcyVyb6J7z1IXeldmFmpWZw898ZQipJjAGfNrBt1e48lhmXr9BjhdV/avVOkqaGG8mqotIqN7sZR3Mxg/Ftf49wMK1kCySO/qaCkJM+3hlF6yQfTeC0DuXDKnR//hSM+K6D0LzlJDzwtWydtY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 07/13] qcow2_format.py: use strings to specify c-type of
 struct fields
Date: Sat,  6 Jun 2020 11:18:00 +0300
Message-Id: <20200606081806.23897-8-vsementsov@virtuozzo.com>
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
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:27 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1072a1-b7db-4bdb-bdb0-08d809f230c9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480DA394758175C3B161179C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +B9I6ndMHt2xJ9zkyeuC5c1wMi+J56liQSy4fDbrT51Y9IlbdFxSIQQoZaYa7aqJ4oCfVcLW+RE9pqDs/hCeInr4VdhbWcwNDynskEDzypEOguqt1wTKgRZMjRV3a9WTHJMakgOAZRRJjyu3S1XOJdVFYuVFrjNDN8wa1sPLELu5MqYbBCr96Ps9wLpv+NTthXoTw/SyHoM+cvKXNEdESTQUyNTgnm6hxBrtysYNOUS3hbZUYcxcoIyhSSjOF6tYNbRIKsoNpJ8z6m9vCilo6/pCd9pxtGwmZm4gFIjo0YdBmX6N9Lm+VhT2oR0C+ph0k/JnUPNwqMVNbYkGtR/jlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HKZT4PHTyDmN6JqOiAfnzMuw0Vo2l9lFVa6fI0JrTctbirsf2HeFPOggHwNsABvvkWpHYQCFeL5EmQFRGI1gtIxxrR55Nr4J1yZxVF8U9nHnAR5cRRAWoJlF6dB+S5a3Zt1fRULipC/uJ1YPatgcx2UBawMrKTaSis6nN9R0+zcYdei27EymS2xMUj+uDGv66SWUJLO9IKzL0Cp2X9b8b/mXeUz12TxYa7T+LMKkPTOs0FZzJoyEBh4By1zCUd+y8jm3OdbOJ0KwfVTAIz3NEg9YmaFT9NP/NBdvmU7DbaBqjji4HmHYCCy2b1X+AiWHedyi7W7Y1WCA2H+Q9DbomkxdWrG+pZdiKiub0nAZgQbXbWdn4PjYRmcZVAT/h8TwomYHF4WT6+eps0iD8cVsAoimDw/qmGICATx4TibcYJG8lq1cMcuwIPCDCrVviYKsyQEvj54GStf3U4Bd5QDwAVoo7bx+uPdTaVtejGh5mwg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1072a1-b7db-4bdb-bdb0-08d809f230c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:27.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D/drCMNMIUIpjARLI1WbYtBBit/1Ua5u5N2DC7Lrx/Z8TogMOWS25Yzq0sfpSict/7BXjU1ARcwZZROr24Duz8Ex85vqkXrv1zRt9EHLO0=
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

We are going to move field-parsing to super-class, this will be simpler
with simple string specifiers instead of variables.

For some reason, python doesn't allow the definition of ctypes variable
in the class alongside fields: it would not be available then for use
by the 'for' operator. Don't worry: ctypes will be moved to metaclass
soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 50 +++++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index da66df3408..28f2bfa63b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -34,36 +34,42 @@ class QcowHeaderExtension:
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


