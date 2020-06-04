Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C69204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LpdAfXN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C69204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtyP-0004h5-Bu
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsQ-0003E3-PC; Thu, 04 Jun 2020 13:42:02 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:37664 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsP-0005oz-WE; Thu, 04 Jun 2020 13:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/ZJAJaM3oF4hv608ONNePCAvM5qIa3acHqyQT24uIbzXRiEHeZOoIcZnCu2u651QlHQ2TlsxUZ/wIGet+pY24h6f9RSjxgLRmjCoTXETdsLYdGB2egQiLyu8k72Zp7kpYxqzlw8bTb0bRhhsxTQ+NH+KtFie+T57tzBWXENX37Strc0L4v3V/+yn9X8alCt/xrp74jqjDeNpRDnsdKgMN1mvL20UTT/pJU/ryeRNCOZyTF1Zhisnsgs8n2I36sh265KyzelI8K1lBLPuslH8kFz2oFfM5p9QTrh8uIstJ2pN1UkCFv6Qbw7kZcakX91faOZb85bY6TaxcFLXhpLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgLtXa3WJzuTkOEj3BfqfIOjZ/gcOiyZAtf80ZmSGE8=;
 b=cw6p289FRByzoPQrn5t16FNF2vZn8RHgFhykciTtL4bR8ZOZqqjCkiZXCLarjQ85r6lp3KQ1o2dPKVZutoStvb+su7beyRmPIitFVKK4rnNoz4ue9+w4t7MBccoIxmjel8JQ/oIBNFLS3t7cL8LP2Bg2vYX8kdsT56YaTOsmS1BwAhgqOeB2+5hRe2d6S1pPzRyyORwcHPLdDNu3UDu/zWbtheSyq1xHsW839nbnIWB0lgxItsvqvzS6GiftNbTvnyR/RhFUIwxWfevmkK9RxjpMOsphcvlGO7ZCXqPvBzUf5v9e8TZ/NmsfWeZs/Ub71iWYWEMZCOA8CGW+aJ5sqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgLtXa3WJzuTkOEj3BfqfIOjZ/gcOiyZAtf80ZmSGE8=;
 b=LpdAfXN08Gf8YbEpXOxSsc+HhfXLGF/RfpAqkGt5or0zc4alwj31qWor/swTFj0WOqkiGb+rVpkAV/EyxPD32zfCr8ThwR3H72yWW6RyXAqz3vYGDKTpdqNQleyJSrxJYbmVtNfDJAgk7vt/ADqq8WmEuJBvXVsHr6K4YpcTT14=
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
Subject: [PATCH v4 07/12] qcow2_format.py: separate generic functionality of
 structure classes
Date: Thu,  4 Jun 2020 20:41:30 +0300
Message-Id: <20200604174135.11042-8-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc675412-8001-453a-a763-08d808ae9259
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53810817C457D499833885C6C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usNoli1hiXiq05tV1a6nYEjyQvMw50q+iWLsXOyvAJcbqhpkpslej7hZNB+s8L/vz17/QmbuASyyBM6OLhYh9wsomIxn1w1jfV2bvV9ix9hkUrxCS1aub7nY7oG8/kkUE2i+8B0yPrrZa1C3K7QEZCKQEbStmRtzZioumUByfpq/gTaxilQZm8RK6LuOIMSrJt99NtJdhnp34FM1MDtuc2Sq/YGVyZF8zbolb1gtFvp1d5l9ujKnIs9l03RwnWawaym0y2SqGYNLk1hhII1T21ofpdM3llSV7WxY4rvzk78s+t4UX2BllCFcCQuKw/8v6r4kms9sG/8vMbrX2ttRUxPv3Jn9P8OINN1+bLeLYKcfgc1284iXYNuin0Q0k+Sr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oWW7sz1dF4ncGRU9lvgGQDEgJs3M608YWU4dCaQyaM4WQLqPWlZpoHwaehcRPbMu/tHHUBdUNnoagfdclzLXu6BPXTKPVgylM4MbQgu2j2h88j2Iqlq7nT9qnZrT64QvuCdhlLTvI9fgv0ChqrS62go8AKvCIC750Hcn1crZrMjvHYrWcPyvH4OGAaMtQEkY7UWZYnXPaLENpLq5WiE1F1VR1Nw3YZ53vFA7jAqMDGgdqKaIoeKTunWSvioBdlaiPb12xqYgfyvxoi6+Mg9hd/DAqrtJP+9dtYF4onX0W4Aml9VIpeyrPEL9St+/901ght+M3+YMAbUQDo2XzIMX9Au1h/YKk/reIwcNyjJT4tgNTsDhTJN0Ycoc5j2uaOsqpRwyBE7l0cq0Fay0rzOx/ZQs/rgjCjoMFv3++3cc+jZBvTyOipjb0RUf652FkDsgEY7PMa4B7fdEKlUyzPFkA4Mlqp2+fHNh2+NBWm67Ijc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc675412-8001-453a-a763-08d808ae9259
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:54.7308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEUvBG0jLLqZ/E+zVq47TgvNI9x/5hr9ISsk/l/jk/F3eJuVPcwNhi601Y4eqjm2U1EXii+Fw4yUaFydwdiqeZxS8mTZkxjXBcnDJmSSN4w=
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

We are going to introduce more Qcow2 structure types, defined like
QcowHeader. Move generic functionality into base class to be reused for
further structure classes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 93 +++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 1fd9473b7f..d71f578377 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -2,6 +2,62 @@ import struct
 import string
 
 
+class Qcow2StructMeta(type):
+
+    # Mapping from c types to python struct format
+    ctypes = {
+        'u8': 'B',
+        'u16': 'H',
+        'u32': 'I',
+        'u64': 'Q'
+    }
+
+    def __init__(self, name, bases, attrs):
+        if 'fields' in attrs:
+            self.fmt = '>' + ''.join(self.ctypes[f[0]] for f in self.fields)
+
+
+class Qcow2Struct(metaclass=Qcow2StructMeta):
+
+    """Qcow2Struct: base class for qcow2 data structures
+
+    Successors should define fields class variable, which is: list of tuples,
+    each of three elements:
+        - c-type (one of 'u32', 'u64')
+        - format (format_spec to use with .format() when dump or 'mask' to dump
+                  bitmasks)
+        - field name
+    """
+
+    def __init__(self, fd=None, offset=None, data=None):
+        if data is None:
+            assert fd is not None
+            buf_size = struct.calcsize(self.fmt)
+            if offset is not None:
+                fd.seek(offset)
+            data = fd.read(buf_size)
+        else:
+            assert fd is None and offset is None
+
+        values = struct.unpack(self.fmt, data)
+        self.__dict__ = dict((field[2], values[i])
+                             for i, field in enumerate(self.fields))
+
+    def dump(self):
+        for f in self.fields:
+            value = self.__dict__[f[2]]
+            if f[1] == 'mask':
+                bits = []
+                for bit in range(64):
+                    if value & (1 << bit):
+                        bits.append(bit)
+                value_str = str(bits)
+            else:
+                value_str = f[1].format(value)
+
+            print('{:<25} {}'.format(f[2], value_str))
+
+
 class QcowHeaderExtension:
 
     def __init__(self, magic, length, data):
@@ -18,16 +74,7 @@ class QcowHeaderExtension:
         return QcowHeaderExtension(magic, len(data), data)
 
 
-# Mapping from c types to python struct format
-ctypes = {
-    'u8': 'B',
-    'u16': 'H',
-    'u32': 'I',
-    'u64': 'Q'
-}
-
-
-class QcowHeader:
+class QcowHeader(Qcow2Struct):
 
     fields = (
         # Version 2 header fields
@@ -53,18 +100,8 @@ class QcowHeader:
         ('u32', '{}', 'header_length'),
     )
 
-    fmt = '>' + ''.join(ctypes[f[0]] for f in fields)
-
     def __init__(self, fd):
-
-        buf_size = struct.calcsize(QcowHeader.fmt)
-
-        fd.seek(0)
-        buf = fd.read(buf_size)
-
-        header = struct.unpack(QcowHeader.fmt, buf)
-        self.__dict__ = dict((field[2], header[i])
-                             for i, field in enumerate(QcowHeader.fields))
+        super().__init__(fd=fd, offset=0)
 
         self.set_defaults()
         self.cluster_size = 1 << self.cluster_bits
@@ -132,20 +169,6 @@ class QcowHeader:
         buf = buf[0:header_bytes-1]
         fd.write(buf)
 
-    def dump(self):
-        for f in QcowHeader.fields:
-            value = self.__dict__[f[2]]
-            if f[1] == 'mask':
-                bits = []
-                for bit in range(64):
-                    if value & (1 << bit):
-                        bits.append(bit)
-                value_str = str(bits)
-            else:
-                value_str = f[1].format(value)
-
-            print(f'{f[2]:<25} {value_str}')
-
     def dump_extensions(self):
         for ex in self.extensions:
 
-- 
2.21.0


