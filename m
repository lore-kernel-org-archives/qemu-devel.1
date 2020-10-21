Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F29C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D22225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G8RqztXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D22225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFyg-0003C9-Di
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaU-0006Mu-CE; Wed, 21 Oct 2020 10:59:38 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaR-00086M-VE; Wed, 21 Oct 2020 10:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyJzGVro4BWYjipzWKE0YTVfFB/RqLogglzO+RGOGbXvEOMi+PSlgXzwPDaw/iL+uiXMrRF9P0vwm7zOn/9gEqy64R3r2Rsf2qp/5sLN7hEXulo/2waXagy7xF/WMZznboEBL5tsLjEmiZJdy02OXcYPLiYmafwhpVONAjNKlUy55E78mX4o1K+HBI4yjH9j8NEzVqLYeqkhA9mWton2jalZCWAwOGJAkEz0oJcIuxXC1w7w7bc1nVg+XwtAc1+DjsmBK3IG7GVjDxMgfImoQG9tZD1+SHF6gqOgFxEMPkq7oo72DEK+sGDHtRLbj3F0lRYVSYzBIgli+hXobUqbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r4UTuyDBg3eudP/ejNSaY3z6P4VodQzs3RlOw/PjHA=;
 b=TNtTF/XjAUG0vRVYwwSeKpoeHzIpL2S+oup9TGylNuyUWfIKBIIe/1DoSoHuiERIqjVxamwPA4Fg+1ETa4GOfOs0jKRsipQrwRYI+5r4ZN1QGl10F5FjBFwW06Vibsbu/YyXOkJapAzOh9APTkIuo9GETALRewOP8AD4IB+skCKt345i6yQQ3frsx18g4XpqsjPCDwheq5DLyCVMeZKZ4hHWIIfHJPqWIHrblpUXckt1Tn8oVo+ZNjzEqqZxWE4v0aMzYMEtZSd0Oj1g4MQhFmf/aBSPKugr2WZmnOTIsctaFDutd5+SxQ/F5ineQ1iypmqlikNdhxgmkyTP/zFZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r4UTuyDBg3eudP/ejNSaY3z6P4VodQzs3RlOw/PjHA=;
 b=G8RqztXe5q7Tl5TTPHhrkDrroTMZSixp4lVZ9pC6MyEnn7JzSFGSCse6afpBPPSJ3zWzpE7sOuFVz88+30M/bFF9klgsU7MSUMRkmyHPP9uaBzVtSruKaDFBrJBAw3YQJPwNANfVo2aVACN622euZWdLNDu4FnjRKL85vrFKSRE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 12/21] iotests: add 298 to test new preallocate filter
 driver
Date: Wed, 21 Oct 2020 17:58:50 +0300
Message-Id: <20201021145859.11201-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ffd7224-480a-4b2d-11aa-08d875d1e556
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472EB7CEF33AA7C37CD5529C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVXNIFlvZjNRTPpDpmKQ7Afk1sqWRogLzXVSwFUVIMFW6PLTRhPziNGVk+OO98IiOBLJzacu7Kx6lI/Z6QqARh0IKbWpJ4K3MJYiOWUXGhL+16Um1HKThdFw+9AXPaR1p2++oTsEb9cbKLZ4nIQmlZ3EzruI1rxmKpcdb8C60DUr00qQl7IFk7AnmIXYr4FgXDJGUfTMBMqhcUwg8yDk2uD8XO6nUwqlrsVzXJwfehoClgGyFuLbFSk0aco5sPbmrekybkqwfTpTxYljBoAHNtuNggtgWyW92LfAuJfxwyspm2dr5A2jnxfXIvncKDoqZWfN/S0QnT9COa4K6AuYCCeNFgx5vylijKP+DivLZdkpXvoWnB53wE/fFr3ZSJF8XPYOMZfc3ZhQ6iUoIHdjEamH16QRnLeonIbm9pXHEKBgckk0aXSg9+gVGItKtotn7J7OWffwV+c3PI2bhQJQkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /222lG6QgYpQk09JRLet1IPD/ch0cx4b2FAOAh7E3BsCG9bAfKxvRjT4eiCdqQNwCSfBvDFwmONqVy6ObANXveH1O3niWFC3moTiURY/sLk7r9I7KHaeZpP7LhIQGrCO/unhxLs/TT9zJmJPxwkSuC44PRs+6JhC8wUiU8oQWpMVhKYnOBYBbvv95J6MfgBvJKP/xOBrRAbvYXKq77eaRHUKt1YHlWf6yK0qmDa4+sYesUib0yVkP48NFQsRK3PoZ63CHMhbuYZ97nWSR3dwD6dqWp2In6/Ayw73aIwxCv5u+cOVGXxMQAx/ufg203evLrsijJ6hm2GPFj46+lj70IWOLqSPWsNdIsOzc8X8L1+Edctgbb/g6RTcBCDlMMctl9RbQZrG78U+fGWUP4jdRwwBSzpgNen5yvlr/n6Je9x/1Y/FH8NtUFOQn5C9XEcwQXzXJa6DnlHf7v+TN71GVUh30uO+7MdYQvdopDYnL9Hx8/03CkrULlioDcggyKzXXq9utEi0U73bILNVcMfrZ7iPC+5dF8nvygQFO30ic8ua84TSq2OYzk5vf9zObLQKLADoYcobKnSdVKCQJmE8Soki06nuGBJ0LHYo8W52PZbiq9oEZZLw5Vcn07ndFIcePRrhdxulvVU8vw8UUUtURQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd7224-480a-4b2d-11aa-08d875d1e556
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:23.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYVzdve5Ffl5xuR32Q99UNMD3s45Fbai9bR5lFgWp7IkyY+9XydkcpFybIufIlRUy2QgHC0MAx4P88oIpWkWOzw4bAX9u+QXytALtMm60mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0000000000..d535946b5f
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
+    iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'])
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
index 3432989283..43da33337e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -307,6 +307,7 @@
 295 rw
 296 rw
 297 meta
+298
 299 auto quick
 300 migration
 301 backing quick
-- 
2.21.3


