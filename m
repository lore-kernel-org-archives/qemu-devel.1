Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A6D207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S6hNJ8/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A6D207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU9M-0007uF-VY
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2S-0003Uj-0i; Sat, 06 Jun 2020 04:18:48 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2Q-0000Zf-T8; Sat, 06 Jun 2020 04:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5ivt4Wj7W+UR7NZ3gk/EBvvI01EUAqmFw9qLIy2OwSEIe8X+rM22jGlYB3U/gpYRwcsambQPz5IQhkOSvFIXwy8IMgOK1F4z2nQezxpVg4te/N5kw1lltop5QYdX2MzTKP0iYIUhmLGHtireYb8MHOvmi6fAhdHB4KxEyi5HZ88SpwxukDelL8tFUtpC6EWCjdaa919UZX6mJQACrvCyupevEsKTH84Qm18IBY5qQXPK7L831PX02yExOMSK72MRm3MqAC4FRxpEJYSmoKdjq1ejwkyE0XtTeeObi/fufEbm9brVfyJNQkqGFgKC3Kbd04wBq+IW3bR2YLGYy2Xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8WrTAImqkNl3ff8n2fReNLTjrH9tdrDbEsbM0Pq0xo=;
 b=NZ/xrSHkfYlo+uYiq8x0JpFeK5eUwXs9nhAMXhe/MLWz7SiICFCqBemWOczIFEhAVgd8liIsfDQN8jo0cJnFFDwPs6lcxU7Eh9OovaFrjgVrlxeC/W2EHqa76m8moCSiNUAdARAaUJXxlrGFZXl5Twdo55c5nZt8JOlxzicKSQdI8mFIODhwQdCjG8Qs1gWk/rzcB71WiibwqVIMGKSppB2k9pR7Z8Wnz6054utbEbM7a+DR58iDOWPdnQoCJe61tgPFRqR2oJM3huuJFf8hmDyQ5vq4LZIXNxi9su9AZ83EbFlyDF5cLLsqB8n0BTSOFbG/kzOXmITId/9Tc6UITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8WrTAImqkNl3ff8n2fReNLTjrH9tdrDbEsbM0Pq0xo=;
 b=S6hNJ8/Zm9bnI6kYhU1cQH6+tFbDvlwu29bHRg1k0uhMsrC6MJzxC4KMygIHrbIYynuKTvM9ZVTCi8+nJk/pEDBIoo6Da5Mqz+maQXJwaRGYiF3MZOFcNIt8hO+84BxPhcENAM/hZ9IRnsPg4CD/Eh3YQqJ1ROrPgjJm+jmvVRc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 13/13] qcow2_format.py: dump bitmaps header extension
Date: Sat,  6 Jun 2020 11:18:06 +0300
Message-Id: <20200606081806.23897-14-vsementsov@virtuozzo.com>
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
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:31 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934a38d9-01fc-4884-d2af-08d809f23358
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54801780361752FD926E0D84C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2t11qrB5Z0pMjmP3MB6n4qoVGWxLxYy+0QC0uc/HywZBD+pOaDj5kzik0v7P9VWNxblMe0RNXVaG81iRdecZDYs9Qq0oqYCt/kaTF/IUST6z+M/0xxaFABvTfJ2ckWcdx7kzr/UtNz1kUwiSs//fslbzw5Jmf0cYYTqOz+N53EZQRtv72mwuvlIqqHHgovjsBxjEfeiqhGYRBz0k0zb3VAghQAWhMIGa77LJ0OpT2UBFC/M7CVTKSwmEAq1YoFQcMyY4Tzn0yXZJ19OrJj7mByyQwG4fCvkSDlWqS9U5Ur4Vb8RUO40LoF1dglInkmOkq/UQFfkFI2dYabk2HdLZq0+ffMgO7ONZQSZiYLu/B1BOGMFUoSCxmQgVzf2qIxM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XcSM5+cqMbO6x3PN9Nd13rK4GzwIgjnR+sHxLK2BeZOvJ/qL9Y9Wi37dwtnjAbcIoZd1Nerv2xs5/9AIzZKhDobNeX9B+2MSYsr7tlYGSZMO7p61Bsey/BcHRz7YjsrHp2hhKeEkCKjSx9U61ddsKYdQjQOjSmhI/6TwG27XKOyosBNphQS6JRNqqbyjkxrhdu9Ksz5tmKYiolWTgFlZwr1jxn9dVHrRNa0Kz2UOLXX/XQRGAHJ0++P2BBW0EQyiRBfCuoRDG3ZMgnRW0nyL4DrEj0s/FHH3POUHCCrQXy+IfPnZHLF2y858rFtXnToEKT/KaY3f/HhBUO6PG6+HaNnAz6DIi2pOlGXPXdhDOxO3e6XLSiGAE54IrskweLxAYHacOKBoCb8R/tTcCP92I4K8lRWkHCRtYZgx7zz5HNUv3gZ9XJn5wS883/8k0w9EwL/qRviiiev76/HOKy4vdTSmcSN8q+8XAUWkR+G1cLc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a38d9-01fc-4884-d2af-08d809f23358
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:32.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK581q4lhy/A0/pL/BzQU5WsFKnUyMSDicADW/grQhNtbTbLKZHa8AA9czCX8T/zErVTQiaif71DEIR6M/1yQiwlE21+uIdUaKlMybhmlAY=
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

Add class for bitmap extension and dump its fields. Further work is to
dump bitmap directory.

Test new functionality inside 291 iotest.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/291             |  4 +++
 tests/qemu-iotests/291.out         | 33 +++++++++++++++++++++++
 tests/qemu-iotests/qcow2_format.py | 42 +++++++++++++++++++++++-------
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 3ca83b9cd1..e0cffc7cb1 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -62,6 +62,8 @@ $QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
 $QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
 $QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+echo "Check resulting qcow2 header extensions:"
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Bitmap preservation not possible to non-qcow2 ==="
@@ -88,6 +90,8 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
 $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+echo "Check resulting qcow2 header extensions:"
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Check bitmap contents ==="
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 8c62017567..1d4f9cd96d 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -14,6 +14,25 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 2097152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Check resulting qcow2 header extensions:
+Header extension:
+magic                     3799591626 (Backing format)
+length                    5
+data                      'qcow2'
+
+Header extension:
+magic                     1745090647 (Feature table)
+length                    336
+data                      <binary>
+
+Header extension:
+magic                     595929205 (Bitmaps)
+length                    24
+nb_bitmaps                2
+reserved32                0
+bitmap_directory_size     0x40
+bitmap_directory_offset   0x510000
+
 
 === Bitmap preservation not possible to non-qcow2 ===
 
@@ -65,6 +84,20 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+Check resulting qcow2 header extensions:
+Header extension:
+magic                     1745090647 (Feature table)
+length                    336
+data                      <binary>
+
+Header extension:
+magic                     595929205 (Bitmaps)
+length                    24
+nb_bitmaps                3
+reserved32                0
+bitmap_directory_size     0x60
+bitmap_directory_offset   0x520000
+
 
 === Check bitmap contents ===
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 40b5bf467b..0f65fd161d 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -103,6 +103,19 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
             print('{:<25} {}'.format(f[2], value_str))
 
 
+class Qcow2BitmapExt(Qcow2Struct):
+
+    fields = (
+        ('u32', '{}', 'nb_bitmaps'),
+        ('u32', '{}', 'reserved32'),
+        ('u64', '{:#x}', 'bitmap_directory_size'),
+        ('u64', '{:#x}', 'bitmap_directory_offset')
+    )
+
+
+QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
+
+
 class QcowHeaderExtension(Qcow2Struct):
 
     class Magic(Enum):
@@ -110,7 +123,7 @@ class QcowHeaderExtension(Qcow2Struct):
             0xe2792aca: 'Backing format',
             0x6803f857: 'Feature table',
             0x0537be77: 'Crypto header',
-            0x23852875: 'Bitmaps',
+            QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
             0x44415441: 'Data file'
         }
 
@@ -130,8 +143,11 @@ class QcowHeaderExtension(Qcow2Struct):
         This should be somehow refactored and functionality should be moved to
         superclass (to allow creation of any qcow2 struct), but then, fields
         of variable length (data here) should be supported in base class
-        somehow. So, it's a TODO. We'll see how to properly refactor this when
-        we have more qcow2 structures.
+        somehow. Note also, that we probably want to parse different
+        extensions. Should they be subclasses of this class, or how to do it
+        better? Should it be something like QAPI union with discriminator field
+        (magic here). So, it's a TODO. We'll see how to properly refactor this
+        when we have more qcow2 structures.
         """
         if fd is None:
             assert all(v is not None for v in (magic, length, data))
@@ -148,15 +164,23 @@ class QcowHeaderExtension(Qcow2Struct):
             self.data = fd.read(padded)
             assert self.data is not None
 
-    def dump(self):
-        data = self.data[:self.length]
-        if all(c in string.printable.encode('ascii') for c in data):
-            data = f"'{ data.decode('ascii') }'"
+        if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
+            self.obj = Qcow2BitmapExt(data=self.data)
         else:
-            data = '<binary>'
+            self.obj = None
 
+    def dump(self):
         super().dump()
-        print(f'{"data":<25} {data}')
+
+        if self.obj is None:
+            data = self.data[:self.length]
+            if all(c in string.printable.encode('ascii') for c in data):
+                data = f"'{ data.decode('ascii') }'"
+            else:
+                data = '<binary>'
+            print(f'{"data":<25} {data}')
+        else:
+            self.obj.dump()
 
     @classmethod
     def create(cls, magic, data):
-- 
2.21.0


