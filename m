Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E145C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09969207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="duKsxyVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09969207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU5f-0001iX-As
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2I-0003Bt-BG; Sat, 06 Jun 2020 04:18:38 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
 ([40.107.8.98]:10318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2G-0000aF-BT; Sat, 06 Jun 2020 04:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUabfLkwJ5UnNo1fHMFqYjbSzRHQHqYUizX8/fy3RFKhPFLcCbR8n332eUc4p/j4XP0b1G0TA+LmczwAq/9cSJ1jBc2Lbvcr+IOVZsufFVahKClXYCcjOLEYVKTKJ84sW1UFCVq3qmygOaC5yVuYj4au9IQQgLXBJuA9uoXzinL/dQDb4hjCz/KKeReLAO2vTkWZdI27wUxU5Bf+3HtOyKlC2RB2FryQf+h4VL+qZqDrRZnAv+VrZ8btnjQFe9r6Z9hAd4UezqXIN5W0TuIIFKvy9BsJWw56JixplCfuWkhGsFdcNLf87Abjj1A1JUJn+oi1NGhzpgq6AmFVN8PIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV4F9tAzUXiVlUUcHYbuqDvhLaZpidtclIHPB9Hhq78=;
 b=SmUFBqbeL1zwxenE2Ytrz+7Hazr9KfDPWVbz9i77BYx6C9bF5LfddWFQdTznh4kqk//eKZ+3Ykx1VLVbwznaDcQao0or6MilemnjMgTeOU2wvbPicYPcw0XCYZm/MIRrMS4SC8IV0ub46F2kaNnwNk0Fhrt5UbUF1oQQyIV8BXxzfX1ACCGY/3cy3T57xyHodg6kqbP5Y/pD7HdvnxmxsQYCfNJ9eQwJBH4OZmJVuNNcYd21rilcdyjjSyi9P7SlLoRJEmV9TGrk5YfmAdevocVPGL10InsTZ8PSlZmZwDOVqfbw2qJh1fD79HlYAKdWKaqOwG6p7b8U3TPwA2aHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV4F9tAzUXiVlUUcHYbuqDvhLaZpidtclIHPB9Hhq78=;
 b=duKsxyVs2+6Cjh2PdRpPR9+zYbmyLGDjx87cVThfcdOj9UrRGMZFjqWn2t3mIHi42G+bX8dOfsH+LdakEovQtQEEf67nVqG/uYW26HtFAEcw2+01AnQMZ01jHUJ8t9ZEmTKsiBcgQMXIURzipu/jrgeqqdZc3RPxZyEkLQyRJe0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 03/13] qcow2.py: move qcow2 format classes to separate
 module
Date: Sat,  6 Jun 2020 11:17:56 +0300
Message-Id: <20200606081806.23897-4-vsementsov@virtuozzo.com>
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
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:24 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7430039f-c416-483d-99ac-08d809f22f07
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54806A47B2EC2D848FD4CC8DC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AI/qc1JdRTH99tHQk5j60U/DLfiygqoPf636rJEy7mxhYjyGdA5Y5LKqqWYYAgMg8dFvab/c4OvC2nNsbFmkGxSETGpriCyjS9hmXkHA/4mpqJ3e+gvvL4LeZ9vNCFP0bnOQrbCLByfVRFYEn+WOUEfVv0rlWCo8jb1uWbYwtJtlTauUnWNpzQLgjx2wo2fGji3enTktyece+wYx93YGr54N0pB+PjDzwis8+qc5NxHVsXqtBiuIvM0nHFO1FoGi+SX9s/DVpt1w6PlT4JBVvVYByO1+8ptnvoZfWPWOhhqBIavFQxBY9s7qxrYdteBNJFSyMqKyM+8bfzmNheoD9/t0w7/0CQL6fc/v2rWoBPRYKSB2SVCzLIWAYKARTdm4Mz8+GEBwQkFDL2iT64wFvj70l9Uzi6Bw5P5SSRBVUhSmgalXYC/aHVq7c1PcCMSpwH2nF4BNErLZlNtgQAoDcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o8T6JlnbAkjE3uPJ6e2yYauFtu19jyM68FYL6HdHWR0iB9C7GfSXY+Sl0O4pk4Jzld0C2pAPZVz6harZsnBJ9kWCFF0jG+g4Rq2dcLCHH0AajrwVNoAIcrHwfatEKm+wiCMs3XbqB6C6SGwfUzBAbl7fRQcy7ACj9RXYz2plWOvgT1kxUCOQCbiz+W3tmWaOsIlbrztAqNXJhszkUfTrthERxZEu3ba4d5Ax2pZgeAH4x8/7ETv1cwI10YvGpPNK4EnJrzOuWk6/gA7dzWhMJpCBjcXs2BNEXzcNNqIllRUYj2a7Mp2kfcQee0E/+t/OqnluVUnuSvl6Mc+hPKXRsv5ZTiiLaqUUlQsazpulga77N7clz3XWIfD5ON7ZktOxDsAcleE9r6JfdFpXDAj4938Z4CzvMowjIOvSaz5fgpJ+KBv8IJQIrDt1t6hJLy+ZnZV7jlVnKGnYdacIVePxGa1mKpLC8GlLuZq3Y+2XYmEcqiF2HZiI4cdlg0bzdFcX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7430039f-c416-483d-99ac-08d809f22f07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:25.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10nQry46uRZxoHXNh9OUYU6L4jCR+UhkLuR6MGnq/zwZESWWeGgcztaE6f/1xl1xzvkOZnQCsvQR9E99uyIZ7UrOkOoRvG2yEs1dvgsiVqg=
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

We are going to enhance qcow2 format parsing by adding more structure
classes. Let's split format parsing from utility code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 160 +-------------------------
 tests/qemu-iotests/qcow2_format.py | 173 +++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 156 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 2da434a013..e968869ea6 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -17,163 +17,11 @@
 #
 
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
index 0000000000..0e517c1bbc
--- /dev/null
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -0,0 +1,173 @@
+# Library for manipulations with qcow2 image
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
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


