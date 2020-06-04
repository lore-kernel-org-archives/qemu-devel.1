Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0653C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C89204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OpXyqcHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C89204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtxg-0003EV-ON
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsX-0003H6-F1; Thu, 04 Jun 2020 13:42:09 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsW-0005oK-JQ; Thu, 04 Jun 2020 13:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIacqKDazUhO3OFrU+zw0QytXCDWULfxdfq9vyowGakMJBNhOhF1CcGnSUSfz0bcFYpZvcz4GU5KO213yqBdGO00iLntMuB7P8aqSein/gWvaojoF9DtoPtjBybUvLOr2ghk/e6Ey6GyN8d91oOEchH+6GAxac6S6aDkF4R4CVv0dOIms0Ol6xFn9Fev7hQDukILgl9HrBeF8aYyhF3Hx7dKeI+HtQnrMbFNOG2m4zs1i648wfV0a3yFmnkK6DRTT7wNLlBGq9JavzODo2R2vSh+M6Ua5crhU0+VBuanQfiNSwiAtdWMkYg6nvEB2cORxXe2XmoaseGCrbwZisypKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zge2olxOGfA/kN9Ncmml25aNwlwhsuq+R2IsppnxlWw=;
 b=b0nd1KiLDDDcD5YBvJDM+4zYZj+v0RK99H+FVt5PAgLrSsNZPoPNf8jnHUwr99JZE+Gdxcv585Myss5Juk0JagfhwIb/WH28aJMZ4pzSh2X9BQfuY6DTCF8d+oQrNy9rOqlLGbQpB4GvwYdGiktW5phPMtV2JlSo2UyNEdATpP/cS/OVU94pTqqlTj5OIn0bPgaXdBbrMVwicCQIoClM31cXynbM42i7hQrwCWTklPNGhlJhzwxGDWqlRP308Qf6b4V2VtwBC4gLDQO5pS3gyTViMvrWEZldaxJ+c2ljZ84F4nvzoN8zROoWKX9ZDEcTNPUiwn3F9kmFq+1qJrG5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zge2olxOGfA/kN9Ncmml25aNwlwhsuq+R2IsppnxlWw=;
 b=OpXyqcHOSTzNFjY6t4F12v+/571pMDdl2g+95ZCY6THRsiqXSx6TBGJCM/UWDzYwc7WpaHDjyvER66ZDQewNB3wsz3KQ/aZlQ7ouRX1fwXSE0BxcTNDsxh2Jnve6U0/Q5PbVRBrn2FXRhEf/5kt+amx3w/xNlBLJdNbDFiiIB/Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 12/12] qcow2_format.py: dump bitmaps header extension
Date: Thu,  4 Jun 2020 20:41:35 +0300
Message-Id: <20200604174135.11042-13-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010e4021-42e1-4b71-e663-08d808ae949e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381DD71E7F6B27D5A2351E6C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZJWoB1pCw1foSLU1zkBoITQNEp10i+9iSinS+fVx1iNO4cKMIG7mQCOSUzl0lGB0841huhCyj1UmUSEjWxxYEvh2IWY57hIHgtTFDSVpih6Kuq80jjFLTjDRSSFoE+0H0rsxW32+pKAvJ1KNBYurc9uwbLfhX7ZhJZpD3YEU937dG9FH4xa2aetG1LvT4G6aJssCi/PnVBkom9x9F4EDvaNSjOEyxBxvVNDS/Js4ZuLUGNXxPqAlmAzv4KS2azbXDUb2NdcuH5qI+ZwGga/LGBRUo1X2sI2JPm2yLQ+4zpbAhiVml15aXgoo514gHaC5kSP08JbWxOP7tKw01OOKKkRSUKhxi5bF2egZNJYKJIw4A2nt7nL6g8T/P+X2IHg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sXdeBmOnTJUAw/KNeFZAbNmDDIS27MP2X0NS/+5ETzto2pXEdTo0WepkX9Uinj1F9RJRt1yeBBySVe7n0u2VF9jMC6CB226uu4jFIad+NNI1EF8KxZ0I264p5cT1jcUMzlVC7cO5mcendsFyMOsypbzIpBCg+jQybETkVxRMPxexza8r5zwv1ZH1tdGutcVwvLFd2M25Y8Nk/KcA+fFyVXJIzwXzGmivxHmN+Soa1HGU0NclVgMh9gRL+6KmSA2lru6JSv9AOSFQ7aL1fOvpAUUVJBS7EeOFYyyg32AaV81hbbUh5mMrzI2NfokMALZaJ/o4Q3Q8pPsHfQYrhJdvuAQiTsRICKiGnCOR6C6ysW4F0FHI/ATa/yjzigHzjgh7BZP9wsHYJOOlVo2kkfUeI4WfMvQplpWflbq7CX0mttrKrd28ngBlYq8c2o2A5rcBboDqdrLL5fHP+N2crw3xRimeRU5fsXlFpRb3wqshR2s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010e4021-42e1-4b71-e663-08d808ae949e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:58.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qegXeVHqFgprNPR3Z/pyGCtctZiJRRYzlqS4b9ctyuTxggaTx8hE8sHSQKLDnSmqB2FQ0I565ylx8gijQR63BdPYwrXlMVcpcuFiw/+nDM=
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

Add class for bitmap extension and dump its fields. Further work is to
dump bitmap directory.

Test new functionality inside 291 iotest.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
index caa190f7b1..c2c636b442 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -79,6 +79,19 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
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
@@ -86,7 +99,7 @@ class QcowHeaderExtension(Qcow2Struct):
             0xE2792ACA: 'Backing format',
             0x6803f857: 'Feature table',
             0x0537be77: 'Crypto header',
-            0x23852875: 'Bitmaps',
+            QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
             0x44415441: 'Data file'
         }
 
@@ -104,8 +117,11 @@ class QcowHeaderExtension(Qcow2Struct):
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
@@ -122,15 +138,23 @@ class QcowHeaderExtension(Qcow2Struct):
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


