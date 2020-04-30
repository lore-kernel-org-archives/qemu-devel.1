Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387DC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B97B2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gCroEk85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B97B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8ek-0002C0-LS
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bM-0004PT-S0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bM-0005nH-1j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:40 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bJ-0005iG-Au; Thu, 30 Apr 2020 08:47:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpumsD91HsCywhcVz35uhVPPDo0telPZ+jr9xFjSXGLXm87xWSXF1VGp2ex1+xlg/TIPdTcMYi3hpV0GGDhA7Pr6EguF1T1SYGCPYStRw8M0erqZG3lIsGZzSt3cyYaNPChDAotSgKllwlD00Q2b4gM4dIphNFarmkgSIOEYj92Q7xeE62XDv/vBEXXgf7WoJjTSJpgZ8GwR0zF/SNoS4a+77wJ+NE4xxMMSHvQTJjbY+ZSnDwYb/eY7m+5fwIgtl6kvW1NSSWb873kGgeA/MZjHhSNmSl+d9KMn+0OS0vFc8+5EEjPHY82Lz/UHlrjGrNbhaBwtlidoB6i5N/7Ttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOVusgBS9xrxUCQccgNmd15Ry0u/5VnIKnirCCd+w7w=;
 b=Iri31UBRPZUsVtMCkZiLYA9E3TOwtDwnv1RmNLxvT717Ex7HcAkwXzFKcrCxwOBA5WnSz437/+4vd8yrBjlUhscm8TDVa/CCWY2x6idp7rpiEGfeCdYH0owtG4e5EbsoHiqgLctpLAAHEbBBA/CRmlxi+3AtGd6J+96w7R6gGaA38hz7E7OWQ+cVvhwBvSiPCVrVlUqE2a6wt1XOwNDN/wvFKHv+PBske7b+KH4ozHAx6dK5AzAeoJMxOyjLV19K/scKaf4xWy/aw4DJpaAIy87Kc4JYZGBoJKHLGwNNQ94daWCwQ8YtMfW1Ah2E5bTNXT6vApqgSio1MBlkSoWCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOVusgBS9xrxUCQccgNmd15Ry0u/5VnIKnirCCd+w7w=;
 b=gCroEk851LN8BJtw/kvQZU+7CEINuZNqDTwO4TxGsoouuDu51enyh9B4BfEEWqj1kMhXs77+SQ1uvcwrVlpw0eDh+Z4PT/4aLyv0a82aIPniF69zZrD+3d+ZUr5CEeGqVEIpSQx8yozAXLf29KpqxPAB6Wf9xlHf8BPlIkj5g3g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/8] iotests/055: refactor compressed backup to vmdk
Date: Thu, 30 Apr 2020 15:47:10 +0300
Message-Id: <20200430124713.3067-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:32 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 107e517b-b0a0-42e0-70ed-08d7ed04a6b0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54785D1674E8E21B7F579A8BC1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9i6ipSmgzpE941hO2Zh3CG4hdsQoXCeJRkn836qbA87Gr270oJeE6nd3/l5/5WOIlSZdmOesdhnLim5VTjcZUVn20GGOOJUX3uT9+Dd4B9xvtW4Y3QcosOEDC89n02lEqG/iEELkkfFmRqF3MaF1OnEhtlnuG+vRQglDjv/Ubvh6l6PPONqFReqM/hOk1+ugfmhHSZdkk+RryavrNsVBkf8nSkUiUIZsx3DMSM5SZ0cpVKCCZ0NIp+kQc7bX0BgHDEyM0fZjoaajTNf2yII4RtkdE305tkBXISULdD0RoTbpIRMz+KJXagHJl4LLHQyLbPao8ZPwkU5WlUZMd8OeXu648Ewiv1jv9buWXf87ZqrAffooZEGS6ZV+2z5Lv8rsXYZjp5Ff1/GpJyZwTv2yZklrzzc8TWPqNAYwhKI8UjnFVdcr7ACm9270IszS+RJE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2zhg2+Z6fhitfk93PuB4+mq8aTgdoeRV9yVex9G0/AA54inKuJl0pgauL/IbBbxp74sI4tcgAFFf/KFio3IWcfhhWfRVaamAyctoWr62k6AVXgnscAJ68MXCj0wvE/OXF7Em9xRlmTLn9mY1nUwtu8DUAjxRhtMUCDfFo4ks1K5ofn3fkLecxgml0ELeHhvqgRqo0Nk72rPmt6L2xuaLEefFQsPDZhISWbtfh7zFBw0Dekmp3qHRA7S7UISOc5avC+i7RE65lA+HpJ8ZrIzBW87ThIgQlAk70Jzoc3THMGdk0fGKfGjlssojlF/b2C5PUCinlcMZg4a5FvViTrTw4YxMZSM3U410+lnv3rqtnQ+0VABUzCepTlMsW+ADhr713IroZBwyUUeT0OxgayVYm5eWELj4IgVfG4KCXuk3NGl7+z9+tlJ22uquhuMMqF3kDOM5j7gtWL6bGmpXCpfR02QhewViQvLDVM3mxEHcGCn0piTwurgAwRIc9I1GtPH9iVNROAofSIrMeWWE68oZliaF9U8m4FFLYBEcZ1fg5ulI66c72ePFuUL1ji4PfABqzT8TBeQZSE+ednRYZhiJxx7Os9tbKI/wruNv27VDEW2IF5I1ZLNp1YPFJ31z2OX32sSzXbz1BLKzCMrPHjSmx/LBibjCtky7kHKniG+EfpPiyqZV1VuyreNd4vJogeYQBjbd3DqVrYLdYpYIpSG8kXsbLbXXlufej0yfp0aJImFfQPrCqEPTqwCNmQbhQ79Qwji/ca0gtPclFfMFFfcf+BWLlKXXqiO6V9yzS3nNimw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107e517b-b0a0-42e0-70ed-08d7ed04a6b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:33.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBsGZCXSiVrf3IY+IWLmdwNZzQC9glhMAXkk0iNEm1P2CW9eirc2ePdBOjgUBbAnPcr7MUbEeOAueHiDTqTAYiEn+LDjh/Ox1+4fY5rXTKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of looping in each test, let's better refactor vmdk target case
as a subclass.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/055     | 70 ++++++++++++++++++++------------------
 tests/qemu-iotests/055.out |  4 +--
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 82b9f5f47d..13a999c391 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -450,10 +450,9 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
 
-class TestDriveCompression(iotests.QMPTestCase):
+class TestCompressedToQcow2(iotests.QMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
-    fmt_supports_compression = [{'type': 'qcow2', 'args': ()},
-                                {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}]
+    target_fmt = {'type': 'qcow2', 'args': ()}
 
     def tearDown(self):
         self.vm.shutdown()
@@ -463,18 +462,19 @@ class TestDriveCompression(iotests.QMPTestCase):
         except OSError:
             pass
 
-    def do_prepare_drives(self, fmt, args, attach_target):
+    def do_prepare_drives(self, attach_target):
         self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
 
-        qemu_img('create', '-f', fmt, blockdev_target_img,
-                 str(TestDriveCompression.image_len), *args)
+        qemu_img('create', '-f', self.target_fmt['type'], blockdev_target_img,
+                 str(self.image_len), *self.target_fmt['args'])
         if attach_target:
-            self.vm.add_drive(blockdev_target_img, format=fmt, interface="none")
+            self.vm.add_drive(blockdev_target_img,
+                              format=self.target_fmt['type'], interface="none")
 
         self.vm.launch()
 
-    def do_test_compress_complete(self, cmd, format, attach_target, **args):
-        self.do_prepare_drives(format['type'], format['args'], attach_target)
+    def do_test_compress_complete(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -485,21 +485,21 @@ class TestDriveCompression(iotests.QMPTestCase):
 
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, blockdev_target_img,
-                                               iotests.imgfmt, format['type']),
+                                               iotests.imgfmt,
+                                               self.target_fmt['type']),
                         'target image does not match source after backup')
 
     def test_complete_compress_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('drive-backup', format, False,
-                                           target=blockdev_target_img, mode='existing')
+        self.do_test_compress_complete('drive-backup', False,
+                                       target=blockdev_target_img,
+                                       mode='existing')
 
     def test_complete_compress_blockdev_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('blockdev-backup', format, True,
-                                           target='drive1')
+        self.do_test_compress_complete('blockdev-backup',
+                                       True, target='drive1')
 
-    def do_test_compress_cancel(self, cmd, format, attach_target, **args):
-        self.do_prepare_drives(format['type'], format['args'], attach_target)
+    def do_test_compress_cancel(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -513,17 +513,16 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.vm.shutdown()
 
     def test_compress_cancel_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('drive-backup', format, False,
-                                         target=blockdev_target_img, mode='existing')
+        self.do_test_compress_cancel('drive-backup', False,
+                                     target=blockdev_target_img,
+                                     mode='existing')
 
     def test_compress_cancel_blockdev_backup(self):
-       for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('blockdev-backup', format, True,
-                                         target='drive1')
+        self.do_test_compress_cancel('blockdev-backup', True,
+                                     target='drive1')
 
-    def do_test_compress_pause(self, cmd, format, attach_target, **args):
-        self.do_prepare_drives(format['type'], format['args'], attach_target)
+    def do_test_compress_pause(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -549,18 +548,23 @@ class TestDriveCompression(iotests.QMPTestCase):
 
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, blockdev_target_img,
-                                               iotests.imgfmt, format['type']),
+                                               iotests.imgfmt,
+                                               self.target_fmt['type']),
                         'target image does not match source after backup')
 
     def test_compress_pause_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('drive-backup', format, False,
-                                        target=blockdev_target_img, mode='existing')
+        self.do_test_compress_pause('drive-backup', False,
+                                    target=blockdev_target_img,
+                                    mode='existing')
 
     def test_compress_pause_blockdev_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('blockdev-backup', format, True,
-                                        target='drive1')
+        self.do_test_compress_pause('blockdev-backup', True,
+                                    target='drive1')
+
+
+class TestCompressedToVmdk(TestCompressedToQcow2):
+    target_fmt = {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
diff --git a/tests/qemu-iotests/055.out b/tests/qemu-iotests/055.out
index 5ce2f9a2ed..5c26d15c0d 100644
--- a/tests/qemu-iotests/055.out
+++ b/tests/qemu-iotests/055.out
@@ -1,5 +1,5 @@
-..............................
+....................................
 ----------------------------------------------------------------------
-Ran 30 tests
+Ran 36 tests
 
 OK
-- 
2.21.0


