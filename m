Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2915C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB50206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uyQFsVB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB50206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLAM-0000Hd-Ou
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0D-0007a9-EW; Fri, 18 Sep 2020 14:20:57 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0A-0004bq-1D; Fri, 18 Sep 2020 14:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5gxV1lsvf/DLKzCsUdkBJPy8/G5jLF68D9QcSXtSf4ycMqkseyoAMI1VBDzLKTeoyJInFZwIcQdM7ZNPHryYRgtsu/pBdOPv040GbLG73cdPlYq0gqIpUX4fxX6SGTJtuUYjv6uyhwroDfi3nXy65A29y2g2vxXeaeYoq13zZ5hfsuPveTYN0B9w/kaRKOwrRyvzqttnfCGrOp2waYvEuPxudF39/GtoMl1zQ/P77gjzv4xxhbAsdhjzkDjJEZtJYnkKsGqx6cPH+M+TIlb9Mx5vg1XO+4+wrWzav/hg9gAXvjjOY4UmniiNa8rWmxuOuzdiyVV8NEZNsrD5UfUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEUcVvT8Lw3DqzEreEtA4a5wMCTNnPpvL10ZLBJYeWk=;
 b=SiJK2p3Xl6NRb8YCCGckKqqRN/k2yCTEUCXvkwUtu8nIbvYaHTcsZYLwAkWqyheyRrTdU0VCGCXxDJHJm2s+fwHisUvLvJ5jb4MkEIpdxAxlDjF0nhktWeXYSgYTcgDXHT3QrXkYAv/sNiTZWitTf51NWhubLzQBlQMqE/vCuixrJF8RbdaexL7PfVpUKPF2s5vTOu2ZuebMb6gNPAbdhtTRM0whO4h8OrTlmoqMzZ/hbquzRKbypsOSEcM7OgxfxSVVylThU/E+i//2oeAI5nFaDGMaV0QnyS/Lhmzk3swLghul66UPPkUC5WxTJaBjxE2OgRQLn+xA8JFgPb2CIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEUcVvT8Lw3DqzEreEtA4a5wMCTNnPpvL10ZLBJYeWk=;
 b=uyQFsVB5ZVvhYXBMNNW5m/9BK+OWD4daGfHKc7+KZLuErINvY0codbQuYNk8HM6j/x4vkOGaAkjmC4J5cCG2rs3fLZ65fUPB5uG3ENUoybgOm9ShX7TQC67fhxlji7ZZOQojH05bysp0ebnPbiB/CkWwYL4ijAYGgH68Qi02HOk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
Date: Fri, 18 Sep 2020 21:19:47 +0300
Message-Id: <20200918181951.21752-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:15 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106c410d-2e5f-4f89-0e71-08d85bff7dac
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190525104D03462ADE47A228C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMmnC78hbcJx0YOaRZWUe/vyeIKwpJJAJ2IgKbcpjQxLO9S3/8OcqbDX9AE2NdoOCkOk0DltOA+UKmQ4h5mkh+bQbiY+9NHbV/0fBMlWE10y6Css4W4uNsP9D3ddevWtOS1rspxvMxjp0fo3yRYJvPPoX6ZWISIi+U0PAta5PlQ/GG3yqXwJGSK7ydh5dmLk03uUvkXZuT9OqMrIAFr8pekxPIYbrA2JA0vRLjFhhu3+H6ER1kr0JYNx+i7puLu/LZ2TazIO/+JA3w9F/MMwkfB5l24OhmArum4pN7u13qeRR+vD8L57y0sWkP7IgNHCj7COauejWcABvyzPLBGzha54fzRSVmvfKNKvSHzQ61VF/Yk9k9TJffKbtZh8TX9zqLx9m2fpE3RLh2Sr+5FGzl2SKAxacALH0S1z1X/wEE3epbf2gh+xHWFY5NdWEaNZrEmeB+IzQQtsLy0CTTxGiP3fgQwmCoqH9I6myDAFsnxOZwGRBKGbAi8+FwJuspkA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AVs5xOTIso66JM4bhs5hfXlxnLCKSTa/6sXEk7JoaM8kCrB7FfmR/cQISw6qQumZGHdzpQRiCHKl+v73R2ZydD51u9Q3Gmft52A/bRwGIPP49xTYAKuz/tgHXu7RI0Z4dVRMrs3lRIC0uswZiXfMC2/qnPGLD4hl+xVXuYQLqp+OGQlepeXsBc22E0A/o2v5kdUSkRacSrwelxu/LdxsjjyDvFFhx1pDEMaPFM6WGiMxLKc4wAyTdyKoeY6eLguYUfe8KbeU61p2T1NenENR5WcAc5wLX2QcO/3jPymsC4HCHtI7sA6AJBQSgPiHEAaBJnJT5z9CxFoa2u5Cy5Mo13ItjrcOIhKjdP5CF531YA65j3Ga2EdHoWd2H2aXH83WQAYC9Wjji7cEZMMGka9zCFIooWhujL8jdzAgtZrOlQDRGmhKcUt4XkfjzHHFDUNXUPur0LBsc7FPQVmIPxXtEqbqaJQ6WoKtDCvXpQdTrry88gxi2HnFi65eIJO1GTBRlslctN1ymGtJc8b3MwqNUFaf9qR301sk18KfVZdbNkzFSNk9Y8g5NQR6U1iPVJcZUOoAfA483qMzh+4N1DQgXMfAzmrQjqZd35N6EGoOB4G5NX5NfuN5n2hiOjNGN8jH/IRIg+LwyxzPZdwkLNtfHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106c410d-2e5f-4f89-0e71-08d85bff7dac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:15.8172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWmV0Iy/O9SODdzS3I/IjYBypvlDE1hlTQiisyArrHG5cI1jRa8LWxMxR9zQWyIewmMxQ+Jxi0D8FMJyKvcWUAv7av4iliQmrYcPFpFRwYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/298     | 186 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |   5 +
 tests/qemu-iotests/group   |   1 +
 3 files changed, 192 insertions(+)
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100644
index 0000000000..fef10f6a7a
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,186 @@
+#!/usr/bin/env python3
+#
+# Test for preallocate filter
+#
+# Copyright (c) 2020 Virtuozzo International GmbH.
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
+import os
+import iotests
+
+MiB = 1024 * 1024
+disk = os.path.join(iotests.test_dir, 'disk')
+overlay = os.path.join(iotests.test_dir, 'overlay')
+refdisk = os.path.join(iotests.test_dir, 'refdisk')
+drive_opts = f'node-name=disk,driver={iotests.imgfmt},' \
+    f'file.node-name=filter,file.driver=preallocate,' \
+    f'file.file.node-name=file,file.file.filename={disk}'
+
+
+class TestPreallocateBase(iotests.QMPTestCase):
+    def setUp(self):
+        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
+
+    def tearDown(self):
+        try:
+            self.check_small()
+            check = iotests.qemu_img_check(disk)
+            self.assertFalse('leaks' in check)
+            self.assertFalse('corruptions' in check)
+            self.assertEqual(check['check-errors'], 0)
+        finally:
+            os.remove(disk)
+
+    def check_big(self):
+        self.assertTrue(os.path.getsize(disk) > 100 * MiB)
+
+    def check_small(self):
+        self.assertTrue(os.path.getsize(disk) < 10 * MiB)
+
+
+class TestQemuImg(TestPreallocateBase):
+    def test_qemu_img(self):
+        p = iotests.QemuIoInteractive('--image-opts', drive_opts)
+
+        p.cmd('write 0 1M')
+        p.cmd('flush')
+
+        self.check_big()
+
+        p.close()
+
+
+class TestPreallocateFilter(TestPreallocateBase):
+    def setUp(self):
+        super().setUp()
+        self.vm = iotests.VM().add_drive(path=None, opts=drive_opts)
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        super().tearDown()
+
+    def test_prealloc(self):
+        self.vm.hmp_qemu_io('drive0', 'write 0 1M')
+        self.check_big()
+
+    def test_external_snapshot(self):
+        self.test_prealloc()
+
+        result = self.vm.qmp('blockdev-snapshot-sync', node_name='disk',
+                             snapshot_file=overlay,
+                             snapshot_node_name='overlay')
+        self.assert_qmp(result, 'return', {})
+
+        # on reopen to  r-o base preallocation should be dropped
+        self.check_small()
+
+        self.vm.hmp_qemu_io('drive0', 'write 1M 1M')
+
+        result = self.vm.qmp('block-commit', device='overlay')
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait()
+
+        # commit of new megabyte should trigger preallocation
+        self.check_big()
+
+    def test_reopen_opts(self):
+        result = self.vm.qmp('x-blockdev-reopen', **{
+            'node-name': 'disk',
+            'driver': iotests.imgfmt,
+            'file': {
+                'node-name': 'filter',
+                'driver': 'preallocate',
+                'prealloc-size': 20 * MiB,
+                'prealloc-align': 5 * MiB,
+                'file': {
+                    'node-name': 'file',
+                    'driver': 'file',
+                    'filename': disk
+                }
+            }
+        })
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.hmp_qemu_io('drive0', 'write 0 1M')
+        self.assertTrue(os.path.getsize(disk) == 25 * MiB)
+
+
+class TestTruncate(iotests.QMPTestCase):
+    def setUp(self):
+        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
+        iotests.qemu_img_create('-f', iotests.imgfmt, refdisk, str(10 * MiB))
+
+    def tearDown(self):
+        os.remove(disk)
+        os.remove(refdisk)
+
+    def do_test(self, prealloc_mode, new_size):
+        ret = iotests.qemu_io_silent('--image-opts', '-c', 'write 0 10M', '-c',
+                                     f'truncate -m {prealloc_mode} {new_size}',
+                                     drive_opts)
+        self.assertEqual(ret, 0)
+
+        ret = iotests.qemu_io_silent('-f', iotests.imgfmt, '-c', 'write 0 10M',
+                                     '-c',
+                                     f'truncate -m {prealloc_mode} {new_size}',
+                                     refdisk)
+        self.assertEqual(ret, 0)
+
+        stat = os.stat(disk)
+        refstat = os.stat(refdisk)
+
+        # Probably we'll want preallocate filter to keep align to cluster when
+        # shrink preallocation, so, ignore small differece
+        self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
+
+        # Preallocate filter may leak some internal clusters (for example, if
+        # guest write far over EOF, skipping some clusters - they will remain
+        # fallocated, preallocate filter don't care about such leaks, it drops
+        # only trailing preallocation.
+        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) * 512,
+                        1024 * 1024)
+
+    def test_real_shrink(self):
+        self.do_test('off', '5M')
+
+    def test_truncate_inside_preallocated_area__falloc(self):
+        self.do_test('falloc', '50M')
+
+    def test_truncate_inside_preallocated_area__metadata(self):
+        self.do_test('metadata', '50M')
+
+    def test_truncate_inside_preallocated_area__full(self):
+        self.do_test('full', '50M')
+
+    def test_truncate_inside_preallocated_area__off(self):
+        self.do_test('off', '50M')
+
+    def test_truncate_over_preallocated_area__falloc(self):
+        self.do_test('falloc', '150M')
+
+    def test_truncate_over_preallocated_area__metadata(self):
+        self.do_test('metadata', '150M')
+
+    def test_truncate_over_preallocated_area__full(self):
+        self.do_test('full', '150M')
+
+    def test_truncate_over_preallocated_area__off(self):
+        self.do_test('off', '150M')
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
new file mode 100644
index 0000000000..fa16b5ccef
--- /dev/null
+++ b/tests/qemu-iotests/298.out
@@ -0,0 +1,5 @@
+.............
+----------------------------------------------------------------------
+Ran 13 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ff59cfd2d4..15d5f9619b 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -307,6 +307,7 @@
 295 rw
 296 rw
 297 meta
+298 auto quick
 299 auto quick
 300 migration
 301 backing quick
-- 
2.21.3


