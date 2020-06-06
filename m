Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C71207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SuqFaBcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C71207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU88-0005Oh-IJ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2Q-0003PH-97; Sat, 06 Jun 2020 04:18:46 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2P-0000Zf-9J; Sat, 06 Jun 2020 04:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAjtOSY2WwLYRtaizBDiKROdLorCfHLTaDMMahb2b9oDkrEJiNWjozN8kHBzXI3fenG3bLL477wbMfdnWPDl2RJPb8/fN3FCMCcH1mm9Nm82o+CObDTEUO5+hLpgRr97gu8ITu262vH1gPtNL1KJVXqKhK9GDXezTgCPqljdUlbyfxwzoxuFQo1DdcBhBzf2USKf6F+M0pIkEl6niBXUw+xKmh43+SaWx4s9ZWLkGI8Abb03QjWo25t7SGa63Wbs+DJUDqBBlBGjXf39/YEl6ttnm9zNar5AGOLHZmJ6m0Vu/eiRu9K4/yah+Dz+NCfgesGBpr3g+i9QEc5XqKF2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKY7QTi9FnFaSyknR9zk/lUliUn46aL1evV6rgPbhug=;
 b=TpgY82D2FWHJFhJ+l554sOgTj2nuRRr84BreQIsKkXlC0QnzUxy4aQeUskshhud99nRHcKbvbTptnRMupI+BbkJBhm5Xc+q39P0aGyWd41BrAcsnt/OvfBFsEsyTV0fBM3dSlbtabnEgL83lhBObOBkmIqb9XTgDXvTkECJMemFUHhZEtqPoZBTFJAhzmUvGB4WgBel+Co9EDMoHM4qH1sGxlb/VDTQDhaN7oaUNUR/78yE29ytq89+AoOfOP7LhZCRuh15I8Y5qB2wBWZYcxXlGyrLm6EfkYb1Ihl114WK2gnBVgTB76nbyf42Y+f+drXLRzclgugVyVdEk5MF8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKY7QTi9FnFaSyknR9zk/lUliUn46aL1evV6rgPbhug=;
 b=SuqFaBcVrBxMG+LoX7IabDTeY7AsHCsXvGeoYsLpSE/Hl1xa63rNmuNsUPkZ48ztVEAiG4BSX0l+Y/jqWE/GSO99FskjD/NhxojKZUuAgPyRX//kJjRf21KxWHmZ+Ii3iKVGJeNy+9ulfL73K2jpwp+Ss+0m3y3AZjpp05yIcEQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 11/13] qcow2_format: refactor QcowHeaderExtension as a
 subclass of Qcow2Struct
Date: Sat,  6 Jun 2020 11:18:04 +0300
Message-Id: <20200606081806.23897-12-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e700780-0845-4346-2bb6-08d809f2327b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54802BB34EEDAC458A291DCDC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnhyk05frpO91i0nhIxznXD1sZO8MkUkfv50hj5hW3xZV3XaKerBiO6X6eCXkTj55ZQgpRqhaxuYqvISq1cP6ueiU5SQ5DrAONyDPCPo7URC+XonfPOlPNuCTcE1gnQor1ARZ5sJ+vWZqzHWcGT9KL3qK/reWgZoO/eaF7Oljsb3K9jEG703BmwICColMMIkTazpkC6v7PGNZSDf0QcXqWFFi3Q4Xl5o1C0pWTcAatWZGUsxrZ67o5eAokjpX3UDfqMHL0/H0V6gXj8BtguM04VlPt/DI1+SwtkS3DOQ4vBeLYG3LT4g8gkKgqVWGnGFTlWjvFGm828c55TnkpWAcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zfI+TLMfseivzw0wzGncHcvDAnhLLCHoU7U6dWdJ7TGxty25+6XdmXFhC/Aylx3fe63LaDDa05MQXJrBCOSbPTWVq6VdfJ2eO1ZaOJN2C90GHltLHB9jq1YFy6+51hLOgAx3aSiH/WBwW6kcusWDm+7CAOavAmFY7y0fYXPUx9ltD/F+R+J8dUUv3jFxMN9bO890RC5hj/0UEI2/eScFG2PBNEPSBJ0ptw75P1D1L2UThBfgwGHdHHCWC5h6YaOf52T4Ay4eyBjsHx9OSqic+uSF/9bBXh147MeJmyxmYQtsSiW+xa6TqqHoEwhvsoX3m9lL3HTi7IvkDtKbFgHetSC4kIQ6n6e2LFl9xI+SFRJcfXIdHWeJej7D7DlTBtg+rIvGkdJ2qf6xgBqd47TaCu9DQiD1XQaIpv5Pwiu5/SLso08HM7rfXJKSebJB7A1Wfr3feY8wsLdZIRZPCA6ZZFcns9036TZ1XToP0L978aI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e700780-0845-4346-2bb6-08d809f2327b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:30.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG9MCz4tkR9nifEtWIRUCM5BN3jRmz+CGPH+8vg6frBFxHuoOBzPDn22ZDgSHpZ/8X/xEZYgJmAxlPyKvcsCcAKJYEEgg348R0zl4BpN4FI=
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

Only two fields we can parse by generic code, but that is better than
nothing. Keep further refactoring of variable-length fields for another
day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 53 +++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d4ad5431b2..32371e42da 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -97,16 +97,41 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
             print('{:<25} {}'.format(f[2], value_str))
 
 
-class QcowHeaderExtension:
+class QcowHeaderExtension(Qcow2Struct):
 
-    def __init__(self, magic, length, data):
-        if length % 8 != 0:
-            padding = 8 - (length % 8)
-            data += b'\0' * padding
+    fields = (
+        ('u32', '{:#x}', 'magic'),
+        ('u32', '{}', 'length')
+        # length bytes of data follows
+        # then padding to next multiply of 8
+    )
 
-        self.magic = magic
-        self.length = length
-        self.data = data
+    def __init__(self, magic=None, length=None, data=None, fd=None):
+        """
+        Support both loading from fd and creation from user data.
+        For fd-based creation current position in a file will be used to read
+        the data.
+
+        This should be somehow refactored and functionality should be moved to
+        superclass (to allow creation of any qcow2 struct), but then, fields
+        of variable length (data here) should be supported in base class
+        somehow. So, it's a TODO. We'll see how to properly refactor this when
+        we have more qcow2 structures.
+        """
+        if fd is None:
+            assert all(v is not None for v in (magic, length, data))
+            self.magic = magic
+            self.length = length
+            if length % 8 != 0:
+                padding = 8 - (length % 8)
+                data += b'\0' * padding
+            self.data = data
+        else:
+            assert all(v is None for v in (magic, length, data))
+            super().__init__(fd=fd)
+            padded = (self.length + 7) & ~7
+            self.data = fd.read(padded)
+            assert self.data is not None
 
     def dump(self):
         data = self.data[:self.length]
@@ -115,8 +140,7 @@ class QcowHeaderExtension:
         else:
             data = '<binary>'
 
-        print(f'{"magic":<25} {self.magic:#x}')
-        print(f'{"length":<25} {self.length}')
+        super().dump()
         print(f'{"data":<25} {data}')
 
     @classmethod
@@ -182,14 +206,11 @@ class QcowHeader(Qcow2Struct):
             end = self.cluster_size
 
         while fd.tell() < end:
-            (magic, length) = struct.unpack('>II', fd.read(8))
-            if magic == 0:
+            ext = QcowHeaderExtension(fd=fd)
+            if ext.magic == 0:
                 break
             else:
-                padded = (length + 7) & ~7
-                data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length,
-                                                           data))
+                self.extensions.append(ext)
 
     def update_extensions(self, fd):
 
-- 
2.21.0


