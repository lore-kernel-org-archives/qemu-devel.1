Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA142C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8C3204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RYsXf5XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8C3204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtvm-0000P3-P2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsN-00039J-1F; Thu, 04 Jun 2020 13:41:59 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsL-0005oK-Uf; Thu, 04 Jun 2020 13:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocDdYMNoLj6ac5KbKTrYHq5WC+VAZ/pbfHwJPhpu/j9ZMikuKjhlcR8VvWB+K9pXqlMNMYWOA8pezQmaqiwoL6Jk30383YxdVuXVy7HG8zI37lW9og5QEQvhgo/0csFHW5O2h/WrEC9AHbm9mC3djVUKavxC7FpDKGrNiqhQffZJjY5m6AyY2XyH9yAsxWI//S0Z1J0ZuV/Tg0WVVyjJ1Lsh+88/guKmYF0dyfMVbjTRMbxSn+0kt1ZRukWqyQO4KZPMqBoYZ3u0MoGuYLqWufZReL9t8QNBcVxGG4JZOHXbnLnHrJ9TYX1uGp5llewIztDFkTgg65q3XGswbOXINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbOrX0FgQNjAy1iLtFP6KNkhnHFXfJ40KPJVDmw6zik=;
 b=P4PXtRMIQ0pJe5CE3XyBe+NzP/MmquYlXzZbpZiWpTz2+OCWGqt4EXTacARnPjUxPvL+K0U30Rk3SJzETO+Zy5JTK28w7Pug98Df+Ljmh8afvqG7Vfg+60hk/NvbMQ7QnFppO29agdkcStB1eKnWqIy+dE4Plo/ciOakUpn27zrgsVOh8H3EUG2R+2nxfWUr+k26OpKWbZjHTlViPuLltIELq65aTiC94K21p5VQj9sFxpJFhAXrDwX3Q99JmQ9MPOopl0dx4CTMgw5EiZYDe+/TBdh1skIb2Z2klPHEPlXRjT6iRrURLuTou/tRHafVocnjKtDTrKRxsUfTSmlHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbOrX0FgQNjAy1iLtFP6KNkhnHFXfJ40KPJVDmw6zik=;
 b=RYsXf5XDXndDTx/bn8C/+ckL8gT1lt9WDnjIUetmLg1ZrVIb3cH/Za2IxU5B1Vdcwf9ef+cDP324ncz3ZAj0e2H56aJkK8whGxWrHG/703U7qmQSoIG2ugBoanoB1NWuedMcZI0ffDF8J50F2U+YZ9m+0fUKEhBR68dhJRtm2l8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
Date: Thu,  4 Jun 2020 20:41:25 +0300
Message-Id: <20200604174135.11042-3-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d32168a-b581-44b0-77c3-08d808ae8ffd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538126C019D960148C91E096C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYlrGu0UIlQ72MzG0PYqK6+Ucq7pCkJFVsesZX+mHy77eEiIAbo5tuaVIXFLrFPpWObf+WOGYhVdVZScIrEGZIZil93/T1+74zfHn7V8/FjmPYW+8WXn13S0xjkrK+Jw8GilzeU069J/Ygd2ryP7es6q+RtCLxHlK2PO9I8/0vGQjK/QGFUbr9A1JhNFVv/JvdMZ7ZwAHEWi4HPE7FlBcIME6LfRdaP6e5pjvu+DSjq9hPC8pKKBJF7WWwUX/QyWOjJKn/IYqBhrQ0eEq+LE7sjrK0PIA8MxPyrxGYv2zJH5SYLrkJKFrjibKji2tfeWQtixIaQHxgfFG4Ix5os+YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6mMqTspX1zk3Cxx35ROhAy0XEZK54CZB1qn1bkb9yPQ0Jmfk6SqjhXI9d2L1Gx86mDZY4DHTwwhLPjgJBObHthw5/MNc7aKhGlUyDAIs1VRoWbkfTwK3Yd+JJLMMC8Wf8GfB2Vj1zDB8N/Z3Cd5x13mP+PQCmYwkuPxuYcefDDXbZ9UhOH+WvjBE53UZXWkd81u8zS/Oy2TYSX6EXRE3PsYifTF8NrIwjjUvQZug+WnOVHkb9WK1tbM+hye+QQOYF5GTabvP3IjJx5+SS1Edi1yJPzU7vyux5iOcFNpEyLD/XxGypPr9HeBx9wnxHXyJiVkAxdhgCqg7H1tA3LSHIssqyXcLBZt96/pJRnqfopopfo1wIN9jnb+/C5yhNBCyhvtAvuVxByTV/rh4BNsMkH/wspW2h//kvP7aj6C1FxUJTozWH5GWvUDi05qRfcL0eAT6Tc50YUzzCRXH+8o/P0XXUM1ozHurDanyI8rzn72mAHsmdXnw8JTDuk+1S/bs
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d32168a-b581-44b0-77c3-08d808ae8ffd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:50.7921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwPeX1HnQtQExGmTrvpo1dk2e0RWmWbDLxYZFVkFRpIwU+JGMA784jINMzXVl5973jclwDC5FFFB0inaeBp+WqmlqDj8ZY1LNj1rrA2tMkw=
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

We are going to enhance qcow2 format parsing by adding more structure
classes. Let's split format parsing from utility code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 161 +----------------------------
 tests/qemu-iotests/qcow2_format.py | 157 ++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 157 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 539f5a186b..d9c41668fd 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -1,163 +1,10 @@
 #!/usr/bin/env python3
-
 import sys
-import struct
-import string
-
-
-class QcowHeaderExtension:
-
-    def __init__(self, magic, length, data):
-        if length % 8 != 0:
-            padding = 8 - (length % 8)
-            data += b"\0" * padding
-
-        self.magic = magic
-        self.length = length
-        self.data = data
-
-    @classmethod
-    def create(cls, magic, data):
-        return QcowHeaderExtension(magic, len(data), data)
-
-
-class QcowHeader:
-
-    uint32_t = 'I'
-    uint64_t = 'Q'
-
-    fields = [
-        # Version 2 header fields
-        [uint32_t, '%#x',  'magic'],
-        [uint32_t, '%d',   'version'],
-        [uint64_t, '%#x',  'backing_file_offset'],
-        [uint32_t, '%#x',  'backing_file_size'],
-        [uint32_t, '%d',   'cluster_bits'],
-        [uint64_t, '%d',   'size'],
-        [uint32_t, '%d',   'crypt_method'],
-        [uint32_t, '%d',   'l1_size'],
-        [uint64_t, '%#x',  'l1_table_offset'],
-        [uint64_t, '%#x',  'refcount_table_offset'],
-        [uint32_t, '%d',   'refcount_table_clusters'],
-        [uint32_t, '%d',   'nb_snapshots'],
-        [uint64_t, '%#x',  'snapshot_offset'],
-
-        # Version 3 header fields
-        [uint64_t, 'mask', 'incompatible_features'],
-        [uint64_t, 'mask', 'compatible_features'],
-        [uint64_t, 'mask', 'autoclear_features'],
-        [uint32_t, '%d',   'refcount_order'],
-        [uint32_t, '%d',   'header_length'],
-    ]
-
-    fmt = '>' + ''.join(field[0] for field in fields)
-
-    def __init__(self, fd):
-
-        buf_size = struct.calcsize(QcowHeader.fmt)
-
-        fd.seek(0)
-        buf = fd.read(buf_size)
-
-        header = struct.unpack(QcowHeader.fmt, buf)
-        self.__dict__ = dict((field[2], header[i])
-                             for i, field in enumerate(QcowHeader.fields))
-
-        self.set_defaults()
-        self.cluster_size = 1 << self.cluster_bits
-
-        fd.seek(self.header_length)
-        self.load_extensions(fd)
-
-        if self.backing_file_offset:
-            fd.seek(self.backing_file_offset)
-            self.backing_file = fd.read(self.backing_file_size)
-        else:
-            self.backing_file = None
-
-    def set_defaults(self):
-        if self.version == 2:
-            self.incompatible_features = 0
-            self.compatible_features = 0
-            self.autoclear_features = 0
-            self.refcount_order = 4
-            self.header_length = 72
-
-    def load_extensions(self, fd):
-        self.extensions = []
-
-        if self.backing_file_offset != 0:
-            end = min(self.cluster_size, self.backing_file_offset)
-        else:
-            end = self.cluster_size
-
-        while fd.tell() < end:
-            (magic, length) = struct.unpack('>II', fd.read(8))
-            if magic == 0:
-                break
-            else:
-                padded = (length + 7) & ~7
-                data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length,
-                                                           data))
-
-    def update_extensions(self, fd):
-
-        fd.seek(self.header_length)
-        extensions = self.extensions
-        extensions.append(QcowHeaderExtension(0, 0, b""))
-        for ex in extensions:
-            buf = struct.pack('>II', ex.magic, ex.length)
-            fd.write(buf)
-            fd.write(ex.data)
-
-        if self.backing_file is not None:
-            self.backing_file_offset = fd.tell()
-            fd.write(self.backing_file)
-
-        if fd.tell() > self.cluster_size:
-            raise Exception("I think I just broke the image...")
-
-    def update(self, fd):
-        header_bytes = self.header_length
-
-        self.update_extensions(fd)
-
-        fd.seek(0)
-        header = tuple(self.__dict__[f] for t, p, f in QcowHeader.fields)
-        buf = struct.pack(QcowHeader.fmt, *header)
-        buf = buf[0:header_bytes-1]
-        fd.write(buf)
-
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
-                value_str = f[1] % value
-
-            print("%-25s" % f[2], value_str)
-        print("")
-
-    def dump_extensions(self):
-        for ex in self.extensions:
-
-            data = ex.data[:ex.length]
-            if all(c in string.printable.encode('ascii') for c in data):
-                data = "'%s'" % data.decode('ascii')
-            else:
-                data = "<binary>"
 
-            print("Header extension:")
-            print("%-25s %#x" % ("magic", ex.magic))
-            print("%-25s %d" % ("length", ex.length))
-            print("%-25s %s" % ("data", data))
-            print("")
+from qcow2_format import (
+    QcowHeader,
+    QcowHeaderExtension
+)
 
 
 def cmd_dump_header(fd):
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
new file mode 100644
index 0000000000..c7270a0a6e
--- /dev/null
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -0,0 +1,157 @@
+import struct
+import string
+
+
+class QcowHeaderExtension:
+
+    def __init__(self, magic, length, data):
+        if length % 8 != 0:
+            padding = 8 - (length % 8)
+            data += b"\0" * padding
+
+        self.magic = magic
+        self.length = length
+        self.data = data
+
+    @classmethod
+    def create(cls, magic, data):
+        return QcowHeaderExtension(magic, len(data), data)
+
+
+class QcowHeader:
+
+    uint32_t = 'I'
+    uint64_t = 'Q'
+
+    fields = [
+        # Version 2 header fields
+        [uint32_t, '%#x',  'magic'],
+        [uint32_t, '%d',   'version'],
+        [uint64_t, '%#x',  'backing_file_offset'],
+        [uint32_t, '%#x',  'backing_file_size'],
+        [uint32_t, '%d',   'cluster_bits'],
+        [uint64_t, '%d',   'size'],
+        [uint32_t, '%d',   'crypt_method'],
+        [uint32_t, '%d',   'l1_size'],
+        [uint64_t, '%#x',  'l1_table_offset'],
+        [uint64_t, '%#x',  'refcount_table_offset'],
+        [uint32_t, '%d',   'refcount_table_clusters'],
+        [uint32_t, '%d',   'nb_snapshots'],
+        [uint64_t, '%#x',  'snapshot_offset'],
+
+        # Version 3 header fields
+        [uint64_t, 'mask', 'incompatible_features'],
+        [uint64_t, 'mask', 'compatible_features'],
+        [uint64_t, 'mask', 'autoclear_features'],
+        [uint32_t, '%d',   'refcount_order'],
+        [uint32_t, '%d',   'header_length'],
+    ]
+
+    fmt = '>' + ''.join(field[0] for field in fields)
+
+    def __init__(self, fd):
+
+        buf_size = struct.calcsize(QcowHeader.fmt)
+
+        fd.seek(0)
+        buf = fd.read(buf_size)
+
+        header = struct.unpack(QcowHeader.fmt, buf)
+        self.__dict__ = dict((field[2], header[i])
+                             for i, field in enumerate(QcowHeader.fields))
+
+        self.set_defaults()
+        self.cluster_size = 1 << self.cluster_bits
+
+        fd.seek(self.header_length)
+        self.load_extensions(fd)
+
+        if self.backing_file_offset:
+            fd.seek(self.backing_file_offset)
+            self.backing_file = fd.read(self.backing_file_size)
+        else:
+            self.backing_file = None
+
+    def set_defaults(self):
+        if self.version == 2:
+            self.incompatible_features = 0
+            self.compatible_features = 0
+            self.autoclear_features = 0
+            self.refcount_order = 4
+            self.header_length = 72
+
+    def load_extensions(self, fd):
+        self.extensions = []
+
+        if self.backing_file_offset != 0:
+            end = min(self.cluster_size, self.backing_file_offset)
+        else:
+            end = self.cluster_size
+
+        while fd.tell() < end:
+            (magic, length) = struct.unpack('>II', fd.read(8))
+            if magic == 0:
+                break
+            else:
+                padded = (length + 7) & ~7
+                data = fd.read(padded)
+                self.extensions.append(QcowHeaderExtension(magic, length,
+                                                           data))
+
+    def update_extensions(self, fd):
+
+        fd.seek(self.header_length)
+        extensions = self.extensions
+        extensions.append(QcowHeaderExtension(0, 0, b""))
+        for ex in extensions:
+            buf = struct.pack('>II', ex.magic, ex.length)
+            fd.write(buf)
+            fd.write(ex.data)
+
+        if self.backing_file is not None:
+            self.backing_file_offset = fd.tell()
+            fd.write(self.backing_file)
+
+        if fd.tell() > self.cluster_size:
+            raise Exception("I think I just broke the image...")
+
+    def update(self, fd):
+        header_bytes = self.header_length
+
+        self.update_extensions(fd)
+
+        fd.seek(0)
+        header = tuple(self.__dict__[f] for t, p, f in QcowHeader.fields)
+        buf = struct.pack(QcowHeader.fmt, *header)
+        buf = buf[0:header_bytes-1]
+        fd.write(buf)
+
+    def dump(self):
+        for f in QcowHeader.fields:
+            value = self.__dict__[f[2]]
+            if f[1] == 'mask':
+                bits = []
+                for bit in range(64):
+                    if value & (1 << bit):
+                        bits.append(bit)
+                value_str = str(bits)
+            else:
+                value_str = f[1] % value
+
+            print("%-25s" % f[2], value_str)
+        print("")
+
+    def dump_extensions(self):
+        for ex in self.extensions:
+
+            data = ex.data[:ex.length]
+            if all(c in string.printable.encode('ascii') for c in data):
+                data = "'%s'" % data.decode('ascii')
+            else:
+                data = "<binary>"
+
+            print("Header extension:")
+            print("%-25s %#x" % ("magic", ex.magic))
+            print("%-25s %d" % ("length", ex.length))
+            print("%-25s %s" % ("data", data))
+            print("")
-- 
2.21.0


