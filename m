Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98915C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630DB207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TLSf4DLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630DB207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU6B-0002aC-Lo
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2N-0003IJ-Sr; Sat, 06 Jun 2020 04:18:43 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
 ([40.107.8.98]:10318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2K-0000aF-I9; Sat, 06 Jun 2020 04:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScUJf9UHtQhJreQt1uYYozRED8DxGtCxyVerhMNVnStjJOZV8uReerASHMlzCPRgPIWnn/uwHWVQhAr74Sdmp8NzZ2hI86wim6Ppk5m8QMQfKJ7WxGJwYN66G20IsjUP4mssITfjHpbPz2lJFfQL01ozQf1WpOuAx7wsVFmeY8cT/sgmIDI839EspIDT1x8bVkNLSvqvhCk7GIxUbDvD8tmyB7+CUpzp+lQWCwftrJDqVu3JXuwho9NDqm3EuhmBoKOqRw6fP4JyUtEIwv2Pnq6FbMzT/kiWF2oVec2v9O8jyKICMcPS65tZg4dLg1mCSek61NvzvpxsOGW1Fzho7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfHFnBeT8k5Gv6jsSDuoFAuC6gR1S+++A/88xbRCNFY=;
 b=Y2y/m9mUK9QtYvz5QemoFzheiuAq78Iv42e13HZ71WRkOsI3ptTH5oM9BK3rMIBKuxvmCb9X728sKVc/zuRJP5nDNubDoWTldq+hhivxHDyfbKxa7Fs7JqZgd5zk37nUbsHMa2o/6Hc+HqvIvlWumKaLNOs1zdvQHd9Qo05Kmrpe7nQVPtazmJvjIyDmV3unFpLcCYwPy6g4SgBVMhMar29kDc8tkGb2D6z4Q9xujn72MOt87HLACBHNAP9gr3W4IceYfCIowObTnPXtksWHRVDcKAa/JnqaG5IdWEiUUcizkO+maJFB76xx5jQ2HnPmUBiKtoKfRoDJ+i1oN+wMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfHFnBeT8k5Gv6jsSDuoFAuC6gR1S+++A/88xbRCNFY=;
 b=TLSf4DLlPcKPOMJZF5kQQsSQUqh24F98q4vHbNSuq8ucVXX9RkQVXXNcnl02hz3JuDe5FDr7PJbIibOq82qAgM1zAo/0pJfZXYorH1bFvoJe13T/3E5fgEodkzKka+cTV55edjHIMxD5CUlh5j+xYbpWToycVjXwVWL4036KlbI=
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
Subject: [PATCH v5 08/13] qcow2_format.py: separate generic functionality of
 structure classes
Date: Sat,  6 Jun 2020 11:18:01 +0300
Message-Id: <20200606081806.23897-9-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80d6c1fa-6951-4004-eefd-08d809f23133
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54805FB0B731DBE883A2150AC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH6WEmmeipuFsi2X2sHrs7Y6z1uQUlxC0YUqeeFAIOebxmJHds4geRJl3B7ghDhQKMOutCjSbgx6K5/SoymBmGKbZYFVg8h9yRbFfx4ZZf+hSth2Fd2k8D+HN9MIhPn1/vryEWfj5S9DIzm0LDFJtS4SYXlzHC7MTC4QP1s79LbI0jgS9zTYcF9ZChpg3FLaDfIIbqfjIm6jQnEdbDFRHBlPoPYCF9JC+WkkZ8pKgFNo2u51oqGu4c7UODjFM6yGcQRA1XiOMYSehyGdav8Ms4oS/9cLSENITe9A8e3oHw4PxYLSlRGo/Bs0KF/dDrv7uzofiMnhiT3Kyb3ye143M8ovF+1nVxMkeKkMJoZOGhZiO3mWCEo4oKe0Z1Qvc/yqCSJ4VYl0zzUFNDPJDCwaHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002)(41533002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L00WG6KQ0BoRPkPY5FdCM2PMSdbnLZi/lZstV3ughtAS1kffRWiTiOAKLaJhN746oBICQXLOI0vlSu0XRVAjw3Qnnl9Qs7FtzowRm8ikTogzPW6/mzW3OwyN+fWmWUsySoeJwTnzpacvFP/JinzgvQCOv/01UdBNL5FkjoPT33PvS7W/ZSMYsP8b5zdCSov9SK8ROl8SdRsxEg2Oh9yYXa2ZaFE7qISewodXKlADFiOQ5NZY0NfNTheYD58RDf3P9IcVnNQINkUL8QJpUUzg8CCHl7c3ZlWvx0m6VqzgagsqvrblTHxG+aGJcmRhKgNH7UzLJ9xGRINE0d3jLLJtPUP5hbTm1vb2oKOGYAHAU58dlHDa/RcPrlDFA6cyspg2BGkwkzMX6u4knlVfEoACnHdDclIpDeUKHUzGrK+E0T83n/PW7o3vyBN/QoEERsF7rq0UvRwGWP51bZLgLQB+m6LEFyb1DBle0HuCLb4Cyq4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d6c1fa-6951-4004-eefd-08d809f23133
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:28.6472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goobGIpl5ZoIZLgZMx9hQ61nB+6iDkz0trqk3I68A3yZ/9ugd2VXHVIHQNDtrs5bbygrvx/Sdnkl/2QhNRbxNnAL2XG4PRs4axCQn6B/k8Q=
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

We are going to introduce more Qcow2 structure types, defined like
QcowHeader. Move generic functionality into base class to be reused for
further structure classes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 101 +++++++++++++++++++----------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 28f2bfa63b..898d388b8a 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -1,5 +1,7 @@
 # Library for manipulations with qcow2 image
 #
+# Copyright (c) 2020 Virtuozzo International GmbH.
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
@@ -18,6 +20,68 @@ import struct
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
+        - c-type (one of 'u8', 'u16', 'u32', 'u64')
+        - format (format_spec to use with .format() when dump or 'mask' to dump
+                  bitmasks)
+        - field name
+    """
+
+    def __init__(self, fd=None, offset=None, data=None):
+        """
+        Two variants:
+            1. Specify data. fd and offset must be None.
+            2. Specify fd and offset, data must be None. offset may be omitted
+               in this case, than current position of fd is used.
+        """
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
@@ -34,16 +98,7 @@ class QcowHeaderExtension:
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
@@ -69,18 +124,8 @@ class QcowHeader:
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
@@ -148,20 +193,6 @@ class QcowHeader:
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


