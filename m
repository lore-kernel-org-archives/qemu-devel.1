Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F81206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="whZ9CRIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F81206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgu0G-0007pF-Ku
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsR-0003F3-Nc; Thu, 04 Jun 2020 13:42:08 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsR-0005oK-3Z; Thu, 04 Jun 2020 13:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NboCwYcDekc+wl0JZrvMFny9aTX5EgCc+WTA3bDFFsz0HbZvyZ8dSk9a3e0Gf5jJ2jV9pjVcHfu54TEUdvBExm/7n2VqYbJj42f4xMtXzcwwtyHFH20qYUOtaSdO1S5rC5gD1Qw7AtwJH4X/kfyFEOJbbqWfRbq56lYvbIxp/TK1DEBwDoXBSRgZ5n8b2j8mzm/m8hAzxta3JAtFaP0qYCYnY72ugNFtKOgksL+HtUu1MbtKRIIE8slzz20GG+7y545Nr7uR4noA0UyZfwX06ZcU7oLdMyUKAxc0nzhmVRga+6Nenx0SG1ZM7ajWHw9Dx2PIQtiPqClLoTb0JjDfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRS7o17tJo8LBp/dEHVYO2RBXZ3zXw3xXhpqQGWqVKk=;
 b=c1z/hCq3FhdQSElBoDe33Mfv+K5ZrH5oK7b06mTjbpozvLc34i9n1wm6GHRtWJll76FIm6zaKwyJFFBZBBrTz69EIQkovcNdojWQX9wF9jr8qMCmPrUpdJ2pP4T5abIhXSvr6dmj3Yj0x+YCMWMIP+j+IFcMt/LnW16YdwEZ17pIN2APbQ/JtkQ7imU3s7q38ujdY2ZWZWTG0X9YCx0Mwp8KEsqXBmSGmtl/PNG+6abRnLX0uF6Dtw2r/g88e+duaoGqLj3RP2U+Hheds9xzqjQ3gC5zkg7RWqV3Wb4miFx0WA5EeKhExT0I5y1qX+Nb6szn6sLG0PhpqOBNdc547Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRS7o17tJo8LBp/dEHVYO2RBXZ3zXw3xXhpqQGWqVKk=;
 b=whZ9CRIxTWjlg5ODSbWx30odnHCR9gG2YWTto2+MmpUHn8ohwD4ypRircrMjQ1IqWvlGwgo5O2TUH6S0BVQ/m+8f+WDuPSMoV/uztEOjkmBdjStDJPSXT+xaVPJJGxsiTz6RW2ItdTqIcOmvhVfDY+mtlRbztzwxRktqW+va35Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 08/12] qcow2_format.py: add field-formatting class
Date: Thu,  4 Jun 2020 20:41:31 +0300
Message-Id: <20200604174135.11042-9-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05a4ac23-65d4-4bdb-711d-08d808ae92cb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538190EDFB73DBB5651658F4C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+8u6NoieZQEzWDKtYE46FEP0jvtp0Ev5N8g31dFdenAAQwbcWcyMgQ0aJgj+LQzVRam1xMs94d95wXTkcH8teg++zXp+P6oA/CmHrn1ctkqTPKe8tMD5gLUgUWygMCzn0U6G1axjwfCq9F9zaJkfiCXFly7fobpKdB+TkTI5pHrFi2BaWeYviYnOVT/WpKbNoEHhGBB3KxGJxaNL61BKOPobHs5otGQx1IaeY4MufFB4IyBGQrLZGGDzItXmNC9TkbwGVF0BZbcPsbxNfRdMfSwiwS2SCg9yTlJUxiKylAylcJGARWJsdHn5/DC7ew3x/7RjJ5ZRhxzMxYYd1k6WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZDHZPUfXECh2prDvZCWDR2G+6p5Wo9ZG6ruZ7mCsrXLJQtZqNttlQ80D7LWiDEELb/M1Ksr2qhIAvTpq8cFYL++mv1cyizKRRG3yVZc1gHfuU1JpWxIEs0VKzjL8srJtl52KOyeG74MDwwMk8GjTl8HwzeINzMCSp9/SzLsZsX7WW+QuTs/ZIhtj9crwDIVlx+c1EF9drOUrriYXKfoiyh8XcmXJQdKgkMdcSvR967d7noKqXU/FNFw1hCdOcIS6jzoObCHmpnJnvMaoiHUKXFbzXHR3Twrt1rJNQFVFPKPEBdQP9qbkh8cVDAFp6JMKwW8WoQ+0umxM+VGx0i8b1fOANXmcEcCY0s9nlPw5OKIeL0CD3Nk5P/lokSAjZb8eOXvYSdKyjfIunWgsnrdPuHLUxgURfcw7KWDuVQM0S6l8dSTcwvBTSYVHXus3qupSDyPozvwTLygHNGG0XzO0BHrqsyr8Mw+4x2WR6ORA/eE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a4ac23-65d4-4bdb-711d-08d808ae92cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:55.4715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2ChjAK1P5x21WZCyOCKUseSzyMaHY/xn9Rd3SHuDbhcM2A+pYIVjbkgFdJy21HyeqrvEsZJVuS8tMixbFw6ApRhDuITu6j3QEqRSYNt4p4=
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

Allow formatter class in structure definition instead of hacking with
'mask'. This will simplify further introduction of new formatters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 35 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d71f578377..ceb09bde5a 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -2,6 +2,25 @@ import struct
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
@@ -46,14 +65,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
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
 
@@ -93,9 +108,9 @@ class QcowHeader(Qcow2Struct):
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


