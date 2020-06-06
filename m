Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB077C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA56207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SY6sg6Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA56207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU4y-0000SY-MV
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2O-0003Kv-Q2; Sat, 06 Jun 2020 04:18:44 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2N-0000Zf-TK; Sat, 06 Jun 2020 04:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUelm02PkAQpJXA0Nw7jacyxtzHCga8P2bCux602j5DfUy3v6gUhvPwBpb/f166wBx9fIbbPzuIKuvQ1fTBIVZqtW+B2IHQmrFURNElxd6F7k0HS4d1DDc+zAUOEoyKvry68PEc8Md7k0/jkhC5KYu8/KR/+sy9rUgxPsqxdkJjkU8SuJuNi0CiHyDoEHxN7uWrKNRBhdRCnvU3u9DcVGrXwfOtXFKS42kQ8GQioad/mMjEvER/runay/doIwq/sJsCYFdsperJqaxjnZ/R9zwCZpd5d/r/whTvxFmU7sa5vtBdfObyvF6PPKNQKO+klBFGMs6MnVrXXxC84GqJWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYdQPZ6ZDUQvSjgesCMJB1IHyF6PBVFhoX0n22pLP8I=;
 b=js+hOAR63CqhL8LAWPCR2bseU96lyxbhQ7x+NAazmzFghEOKCCnSHtvxNyh3dTKCqqW6hyiIWBBDqF5/SuLiWaA6JJA+pYUOu5jdV4vMpUSRNIV9ViRzmKhou7dFhXsgp3PZ3TuMTUDj7Ag82l7BnWY8r5LbA7Q1Akw2LIRgJ3Ld3/nmIZQNsPOl3vCXkA52UnacOYWbzTVzGY2UU2HbXoEgNkvCDb4mlkZE5iw+flLT+qpSD/9v4i8xO4CWAlSA9Y779YCDn+Fh5y1B8xNOI8TrCK0fmPERs04MVKZloBJoNMPDP6xxsgbPhzwC1WsNjl2vZKNQv9I77MNVLEzDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYdQPZ6ZDUQvSjgesCMJB1IHyF6PBVFhoX0n22pLP8I=;
 b=SY6sg6BcDIlBV9R2oj3Nl5zd8VWy8KjUexeRNbBEAZ9mZFJ7qlulT06ryXekKgR3fN3aNTZ8GRNAC3btAJFNS5BoRCbFcHsBCVhWcI9ZwlcZhdwr/Nt2uWuOq6dqg7UslMSDXo8S+1NS9mmxD2QJYu8T+Trn8feAajGp6/wtSA4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 09/13] qcow2_format.py: add field-formatting class
Date: Sat,  6 Jun 2020 11:18:02 +0300
Message-Id: <20200606081806.23897-10-vsementsov@virtuozzo.com>
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
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:28 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca96768-f7df-4540-6b1e-08d809f231a5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54802F12797894EDAEDA21BBC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Oy+mrVlxiAoj5NjT++8+fj0+wSn6MtAQvGjTNXnmHN+0Mb1m6WnaXZv2C9FrNy9/f5RTurBu1AIXHWGZBjBjbRRCvF81zQsuCGNFnNZZ36mikZRPQ2wervS7isx73GRgZceZrXfPwCZafkhYIZPT6FgQqTsQ3GPDI2Gwa4r1r5ANE23o/XzcmnV5YYY9zhHpHGWo2Xcw5mB3TRwV88nUQJXVOfTyG15TbxtNVptfQeqogfrTXmWYlc/bWOFsgv0+IZw6ahPC/ziZEjg4jq/zVEdU17Ew/yZn9vXZ9qpGWRCkmd77zHPrqvC+TIY+2FKJrYXxrc4nOC+40O7wne4IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oYpR/agEmUvwhNnBpnOEaGIOz5wuQyte4TOn43pHnpWylsudndY3srWNI1H3qyDBsdGq0HjAXz8DC1U0MuPItR4eO0kZWMDQmkuWpmd/vq/G7V8cnfg5fe+iytiyoZn53bI93B6pSG0KxX4FVpL3C/NmOXgFQIVr//2OcVfGxrCEZY5WfuSAs2p8U6tIdZS1VfZ6lDSJsQ7ydBEPaY/aI/1XI6nIsOpRGKQ6Aom8ksZPmY5/5PMqBFOhlBiS7wVtIall3+qnOd0Q8881aAoU1l81FvtvhDVy63rzo9tcJwZLXBong4jKpmaldhk+Ca3wzidsVAYdHkv9WNNwDhdYIJh89IMJ9nyzCEyI56wgj6nxyyzkklf4A33gBPYmIhyqrQl0kSR4V+bqowjjqLQfmW/siftMiegBtQPFXouqxMZxB/0NWIoFt7kv2Q6ZkbhEqYOeL36zU8UuArA0i1F8hwMZEW+nYPxuhIlaZJrOS0I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca96768-f7df-4540-6b1e-08d809f231a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:29.3869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUEomgbhrkxrZ0U9lnrQMOfysxZJ1eoY8zNZzChOU2SVVYEDs9xsiAt9h/MUzcALju4gx02omqDCGxsX34mF66eCQs9un25bonoBTNXd2dc=
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

Allow formatter class in structure definition instead of hacking with
'mask'. This will simplify further introduction of new formatters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 35 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 898d388b8a..74a82f9263 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -20,6 +20,25 @@ import struct
 import string
 
 
+class Qcow2Field:
+
+    def __init__(self, value):
+        self.value = value
+
+    def __str__(self):
+        return str(self.value)
+
+
+class Flags64(Qcow2Field):
+
+    def __str__(self):
+        bits = []
+        for bit in range(64):
+            if self.value & (1 << bit):
+                bits.append(bit)
+        return str(bits)
+
+
 class Qcow2StructMeta(type):
 
     # Mapping from c types to python struct format
@@ -70,14 +89,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
     def dump(self):
         for f in self.fields:
             value = self.__dict__[f[2]]
-            if f[1] == 'mask':
-                bits = []
-                for bit in range(64):
-                    if value & (1 << bit):
-                        bits.append(bit)
-                value_str = str(bits)
-            else:
+            if isinstance(f[1], str):
                 value_str = f[1].format(value)
+            else:
+                value_str = str(f[1](value))
 
             print('{:<25} {}'.format(f[2], value_str))
 
@@ -117,9 +132,9 @@ class QcowHeader(Qcow2Struct):
         ('u64', '{:#x}', 'snapshot_offset'),
 
         # Version 3 header fields
-        ('u64', 'mask', 'incompatible_features'),
-        ('u64', 'mask', 'compatible_features'),
-        ('u64', 'mask', 'autoclear_features'),
+        ('u64', Flags64, 'incompatible_features'),
+        ('u64', Flags64, 'compatible_features'),
+        ('u64', Flags64, 'autoclear_features'),
         ('u32', '{}', 'refcount_order'),
         ('u32', '{}', 'header_length'),
     )
-- 
2.21.0


