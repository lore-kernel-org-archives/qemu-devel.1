Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543FC20772
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D1QYozyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543FC20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtyX-00055c-J9
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsW-0003FA-2T; Thu, 04 Jun 2020 13:42:08 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsS-0005oK-8v; Thu, 04 Jun 2020 13:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX9MXGdH7rasB/57MkkOy/D1Vk48hGLPYnh87uB0vISDd68PtCXYh4N9+Djkghs8jIlNuUYdJySdOnN4fuUWPUCa1r4CP+6r4bxv3QvDIW7BAqdKIBydQzvTjIVgJwChjMpr25LobCAamMIbqAxPBfO6ROUSHRwKDSwLHVc7+snxmyFhUvvhxIlbHM2+Hfip5kKPUMQuZI7rMrh8c5cArTq1Rhn0keeu7drN9stCwIQGypEjIP0OZDHV6Hbg24C7jDxVtDJ/HkC8YAgHNgKkMBewZ+r1zxXY+2XBzi4jmyoLnL0N7UlkiRhtqA2AOHA9j8EmImXxX8Wna83/ZB8SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fiYRt2Z4q9FnmfIBkUDwv+W4a6+anhcznMkH8OU3s=;
 b=dXHZiDA+HJ3WpNsnKYbUCEP1fGc4Mo32ROeg3ty0/iDfDcrZ6WM/ziGLNxytk2A9d3K9AzgS5/LUGjReGTcY/su6P8GsOd2KRD4PpHYwGj4mRDDKviWj/1I3xVchRyxseOp8WKZGcNyF+ZUewE9+PHsjmtC78foOZGm1OIK3KyqWWuowtz7sQ4y5TzVYbBJDj704UEd1MgI4Wew0svyFEn4CSsjn7z8ruN9NdFNJwv0YcPGlA7Qm0x4BYrz/e5qQNp5rKvVvZBlZOrPPw6hnoYNfgv8L3LGNwQrLeqG7HEmTjJQHwJnJjTP4g0SJTtKi29+XXiYPV9l6/oiDNCHVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9fiYRt2Z4q9FnmfIBkUDwv+W4a6+anhcznMkH8OU3s=;
 b=D1QYozythT/aq8feiV8zo5OyaBobG70ti/6wA+K6LfnL7r0XFdm/aK7njanPHTOrlSqTEPxFCW2WkdYHiipUOI5IPqy+MDP2zkaeIhTDFHXMcTKaYpN8IjTzBom/zmJSt5G/yP9tg5npX49qPeKbSDAaP+qVp17JOlFEVJxUMjw=
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
Subject: [PATCH v4 10/12] qcow2_format: refactor QcowHeaderExtension as a
 subclass of Qcow2Struct
Date: Thu,  4 Jun 2020 20:41:33 +0300
Message-Id: <20200604174135.11042-11-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447d432d-4379-4bcf-ba46-08d808ae93b3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53817467507CB70B8DDDD73CC1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9B66XLw4B5MpRWWe/RI/1cQ0YDexaNRF7xO+g4BaVFJsI+g6Spy4guv69a27JQIQ6XvMsOUWA9nWDOZcQccg2Ms4vEfdFuXL2hZbxuFytufv8SYPMoACGriAgGOz6glFZJDYU0PlXT1XZo3RcLafSMq6u/nTL+5FBsLdxWW1pZVHFbfZ51aKPNpfDkVk+q7wrw3r/4hWv9lwBq77z+s7TIq/AncnG2xKFhh6hZUbXMY0XL+VgO7Her3XJtFSZu1+rZZQ+cgPLs1NQQaQ2h1SY3V1BOvYYPabFI1Q5yHxbh/axDHwxxixsZNrKpoFPBk6PSb3LJeoJfghL4gkr/wbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OXS0tAy8K0sQTqL/DLhXyoAt4o/qLUQO8f3vR+xd35f3yBIwLYiKWL1LpOXA1fKdL+9790+6dgjlYDXuMdx4qbjvggbdY/sEEjj2xAPosK2l0H6kbDqV8z44O2qRKVfDudnlK7gpdauJOqA9YuZ54RAXkVwEu550ERO5gTdYlshj9/jd3e21EgmiFjQCPh51Gp9pJa2Y7UhhuCHILHmnscGXyHDn2RvfZOmUja5LpTSUS8/1zPlLtuqxoltgmUlXSFQKTXCDcJd/KkQXyNo8GIDrrGqm5sPfCDjzBzYLrTed/s2dIQwGfcb/KJ0+ilJsRPxg/jiEMvfPrhkn3znd2+6ie6QlKd+iDouwPdSdXljwVfXjgOpfuaoXgDSCW2DrT/d3VdXY/EDGqtYxCSq+j861Xm7ms56zJorDyg7dOMAzMdy4iHi/fdUtFcML/8qdhHAwNzH00n4XFbtzitIlaT2qx6jjcT7VB9eKZdctJk4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447d432d-4379-4bcf-ba46-08d808ae93b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:57.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMrSn1gq/38HMaNAH7JERT5CUzKMKksStqmZO4FZioxlcghtcN1yc82W5lBrn8vUepblC+TY41HPcLQjfjF1J3KhYmrIsD3KayxsCt+uPlg=
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

Only two fields we can parse by generic code, but that is better than
nothing. Keep further refactoring of variable-length fields for another
day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 51 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index ffc7c35b18..4683b1e436 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -73,16 +73,39 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
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
@@ -91,8 +114,7 @@ class QcowHeaderExtension:
         else:
             data = '<binary>'
 
-        print(f'{"magic":<25} {self.magic:#x}')
-        print(f'{"length":<25} {self.length}')
+        super().dump()
         print(f'{"data":<25} {data}')
 
     @classmethod
@@ -158,14 +180,11 @@ class QcowHeader(Qcow2Struct):
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


