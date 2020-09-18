Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB2C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6470206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v9TEiA9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6470206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLDN-0003Yd-F4
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0B-0007a2-RP; Fri, 18 Sep 2020 14:20:57 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:41027 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL05-0004nY-Pj; Fri, 18 Sep 2020 14:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP3KKFKxFNViuQTLSbu42BloRlYFLTyEpLyiEuBsQPchLcTPPPFRmv4o242hjR15kgaqcNvie9QBwCu0W3Kj3vWFPCdtH3lm3Uby6sfxVUjjc/7oTmatoCPXEVJwhfXM6xfkfn9ef89X764xr6+eT0276Fjgg0KjuYuyAZpEe+lqQHf2R4m1unSLPXmqr+7kZaROj6hD5cosEI/p18ITnbEoeEXgqncYB00ZW4GjCfnp9NQ3O+BvqzjfhI1eqbbgfzUM8fv5emcHcg9DqzLo8Xdqs8H0mmphOdANIIcJApCf1k9BHQKc1/2to+0UGQvy/mLyLSsu/fhWSbOJUfoTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFtDdBsLRaAa8u2s9iXVijeZsGRzBTN0x5Wv3n+u7Vo=;
 b=T2IK6Ao/49ZpsRPDMg8xQPgbxt0Pnhb7sZPEO0JaXYQ6N0B3JZq4NWKB/kOX92igJtMq2SAdY5HhNCAXpnZhiYYEt2UqBxfeg2bo656KZS1w6bbzJ+3qBLox86QuaC/MOiFVQP1iBOHwNFgZk4J+7wEx+OcDeP4CkDOIRRGYF17XHdHhor8JM0nm/z3znuZ59Fmz3WYKI5KGku4MgG+02J7WMJJqXuWxOEQmMm2B/tTp8Y6gw1Rpua839Jbf2WLao9OlSuVeknvSJ06hngEIAVv2mL9SqAzoExz8KCg68Vqk1xpkpyZNqXRcjDc644Rc1E2u6UpGQy9xJRVku0Tg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFtDdBsLRaAa8u2s9iXVijeZsGRzBTN0x5Wv3n+u7Vo=;
 b=v9TEiA9dF3rrp1ncP5Zvpl0fIBhWv71DtFybNVZjBW3h/1E2AqGrb3T9DGn9MX1FfMgToUy3DG0w6Ov/NXeneSTDTa5FISCjSpnLSxumbEUdekYuUZnortLnljqZ8zuFUaeV4+JsTTBxdgPjywhK3BvZFju5FQ23xG0ERS6Eb8c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 08/15] block: introduce preallocate filter
Date: Fri, 18 Sep 2020 21:19:44 +0300
Message-Id: <20200918181951.21752-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:12 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae79f881-b8c5-47f2-9d58-08d85bff7c01
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905B5A6F7BA51EBA8B23B5CC13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGfEArPPwYrZXJD0W83j1Lp90AzU7FFQFaruO1BN8W9UDEg+n0oy+GW0BJXijnYBhO3V6XgNeP+PTn+QP0jxbiiOgY3xdZBaMa3WdqNj1VIBF/Ii00Z613TGjBxaG613yHZDjRbJggzH3XcnSZtjIgTq6ayx2pyOyxt4kamY3LuL0QKuuc9zydKIheqK2InYL2QWoSMEhZmLwC34viEMHDHLkVb2YLyKyQO9yK5/Zg9e/fcMPmwV8D7HqEC+01c91M5rg20E8knDTNfRAwPXoATBPHmK+vzYMYnPux0KOhphRaoJTbMuC8dLYLFhdjC2ub1bvM7pGk6mH5wyhL+LQSJSJDhF+I9Y0dfb4/9zFSCk1GXbzcBpB4Pb3Z6iaUfvNL7Z0zAbTqkcyBQWlLfAas8nFiJNORY9kKVFmXYqNGRYxUnFLhuJkEXoc8blQSwVqbfQLbKzV1IHTXr06kfk4U33+fvzgR7Xt5Tp6gynjEkTFUle/aLzvPVudmYspojT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(30864003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IYUMjbJT36KHo0w3RmlH8TpoIt/x6BDUg8YdzwoxtNCXWDC6+i5SDonEkw/GDbgphlQV5khG4uJXMHMClQaJhNcC0Ye/oWP2ntvYxJiv8WpnS7ATJh4Zba/jQbJAS4HLXH4YyaM7jo9fOjYocr+z5x/8Tx4a/mYF7qt9scs8QoWy4TwDoiFCIBLgvZrG7QwKriw2Ey3VWhxpivATJ7nobZ54GfpnaT9fOwJUXnCkQxvC4c2mgmAptPLNpUvaQ++wocF4YKwWwoGKI2tDlDtP5NgA77ALLQBZUutYRZWn4gEi6d28Oagx5hdxgNEOERCTa6AcovmrmdfvGn0W0xxpZkVO3RL1/DiXG09lIvwC4u8bnulYvPix3+UOCtg/TZnsMRiqI8bMAUGexdEVk3KwPAfzgY0+X+AG5VpqF894Y0eKI1LaQ5FAVAiFm6dehiPCya5y8rHFNx4smXzSpEhSJL03WUt0OcuPcKZ/1V76Mu0mqtnLY3UuNl2XCbMqFwW4pPPL6ZsU21Ukn1HaZWanqKhrGWXSvgFkXyqd2mhGmU4cuYa3Cbn5jVmrdmvx1Lb8NzlZ929Y4mabzcgDhu33MJD0FpPkM6bxYAcHoif7TxF8764nCLr8mJFQeOxAw13VKNr29WNoq5UA9kvx6s6Lnw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae79f881-b8c5-47f2-9d58-08d85bff7c01
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:13.1140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U03Fn/kVRWjbgQcfZlZXfEbPHOlhtS3gT/WLgjk0/1WV5Id6JP2Cujtpa4/rOIBgjjqNrbf4Td8+Svv+85qdEoMdQWw0dnbMo1ULL5/Fa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:23
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

It's intended to be inserted between format and protocol nodes to
preallocate additional space (expanding protocol file) on writes
crossing EOF. It improves performance for file-systems with slow
allocation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/system/qemu-block-drivers.rst.inc |  26 ++
 qapi/block-core.json                   |  20 +-
 block/preallocate.c                    | 556 +++++++++++++++++++++++++
 block/meson.build                      |   1 +
 4 files changed, 602 insertions(+), 1 deletion(-)
 create mode 100644 block/preallocate.c

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index b052a6d14e..60a064b232 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU process on the image file.
 More than one byte could be locked by the QEMU instance, each byte of which
 reflects a particular permission that is acquired or protected by the running
 block driver.
+
+Filter drivers
+~~~~~~~~~~~~~~
+
+QEMU supports several filter drivers, which don't store any data, but perform
+some additional tasks, hooking io requests.
+
+.. program:: filter-drivers
+.. option:: preallocate
+
+  The preallocate filter driver is intended to be inserted between format
+  and protocol nodes and preallocates some additional space
+  (expanding the protocol file) when writing past the file’s end. This can be
+  useful for file-systems with slow allocation.
+
+  Supported options:
+
+  .. program:: preallocate
+  .. option:: prealloc-align
+
+    On preallocation, align the file length to this value (in bytes), default 1M.
+
+  .. program:: preallocate
+  .. option:: prealloc-size
+
+    How much to preallocate (in bytes), default 128M.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2d94873ca0..c8030e19b4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2819,7 +2819,7 @@
             'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
             'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
-            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
@@ -3088,6 +3088,23 @@
   'data': { 'aes': 'QCryptoBlockOptionsQCow',
             'luks': 'QCryptoBlockOptionsLUKS'} }
 
+##
+# @BlockdevOptionsPreallocate:
+#
+# Filter driver intended to be inserted between format and protocol node
+# and do preallocation in protocol node on write.
+#
+# @prealloc-align: on preallocation, align file length to this number,
+#                  default 1048576 (1M)
+#
+# @prealloc-size: how much to preallocate, default 134217728 (128M)
+#
+# Since: 5.2
+##
+{ 'struct': 'BlockdevOptionsPreallocate',
+  'base': 'BlockdevOptionsGenericFormat',
+  'data': { '*prealloc-align': 'int', '*prealloc-size': 'int' } }
+
 ##
 # @BlockdevOptionsQcow2:
 #
@@ -3993,6 +4010,7 @@
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
+      'preallocate':'BlockdevOptionsPreallocate',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
       'qed':        'BlockdevOptionsGenericCOWFormat',
diff --git a/block/preallocate.c b/block/preallocate.c
new file mode 100644
index 0000000000..6510ad0149
--- /dev/null
+++ b/block/preallocate.c
@@ -0,0 +1,556 @@
+/*
+ * preallocate filter driver
+ *
+ * The driver performs preallocate operation: it is injected above
+ * some node, and before each write over EOF it does additional preallocating
+ * write-zeroes request.
+ *
+ * Copyright (c) 2020 Virtuozzo International GmbH.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/units.h"
+#include "block/block_int.h"
+
+
+typedef struct PreallocateOpts {
+    int64_t prealloc_size;
+    int64_t prealloc_align;
+} PreallocateOpts;
+
+typedef struct BDRVPreallocateState {
+    PreallocateOpts opts;
+
+    /*
+     * Track real data end, to crop preallocation on close. If < 0 the status is
+     * unknown.
+     *
+     * @data_end is a maximum of file size on open (or when we get write/resize
+     * permissions) and all write request ends after it. So it's safe to
+     * truncate to data_end if it is valid.
+     */
+    int64_t data_end;
+
+    /*
+     * Start of trailing preallocated area which reads as zero. May be smaller
+     * than data_end, if user does over-EOF write zero operation. If < 0 the
+     * status is unknown.
+     *
+     * If both @zero_start and @file_end are valid, the region
+     * [@zero_start, @file_end) is known to be preallocated zeroes. If @file_end
+     * is not valid, @zero_start doesn't make much sense.
+     */
+    int64_t zero_start;
+
+    /*
+     * Real end of file. Actually the cache for bdrv_getlength(bs->file->bs),
+     * to avoid extra lseek() calls on each write operation. If < 0 the status
+     * is unknown.
+     */
+    int64_t file_end;
+
+    /*
+     * All three states @data_end, @zero_start and @file_end are guaranteed to
+     * be invalid (< 0) when we don't have both exclusive BLK_PERM_RESIZE and
+     * BLK_PERM_WRITE permissions on file child.
+     */
+} BDRVPreallocateState;
+
+#define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
+#define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
+static QemuOptsList runtime_opts = {
+    .name = "preallocate",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = PREALLOCATE_OPT_PREALLOC_ALIGN,
+            .type = QEMU_OPT_SIZE,
+            .help = "on preallocation, align file length to this number, "
+                "default 1M",
+        },
+        {
+            .name = PREALLOCATE_OPT_PREALLOC_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "how much to preallocate, default 128M",
+        },
+        { /* end of list */ }
+    },
+};
+
+static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
+                                    BlockDriverState *child_bs, Error **errp)
+{
+    QemuOpts *opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
+        return false;
+    }
+
+    dest->prealloc_align =
+        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_ALIGN, 1 * MiB);
+    dest->prealloc_size =
+        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
+
+    qemu_opts_del(opts);
+
+    if (!QEMU_IS_ALIGNED(dest->prealloc_align, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "prealloc-align parameter of preallocate filter "
+                   "is not aligned to %llu", BDRV_SECTOR_SIZE);
+        return false;
+    }
+
+    if (!QEMU_IS_ALIGNED(dest->prealloc_align,
+                         child_bs->bl.request_alignment)) {
+        error_setg(errp, "prealloc-align parameter of preallocate filter "
+                   "is not aligned to underlying node request alignment "
+                   "(%" PRIi32 ")", child_bs->bl.request_alignment);
+        return false;
+    }
+
+    return true;
+}
+
+static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
+                            Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    /*
+     * s->data_end and friends should be initialized on permission update.
+     * For this to work, mark them invalid.
+     */
+    s->file_end = s->zero_start = s->data_end = -EINVAL;
+
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    if (!preallocate_absorb_opts(&s->opts, options, bs->file->bs, errp)) {
+        return -EINVAL;
+    }
+
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+
+    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
+            bs->file->bs->supported_zero_flags);
+
+    return 0;
+}
+
+static void preallocate_close(BlockDriverState *bs)
+{
+    int ret;
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->data_end < 0) {
+        return;
+    }
+
+    if (s->file_end < 0) {
+        s->file_end = bdrv_getlength(bs->file->bs);
+        if (s->file_end < 0) {
+            return;
+        }
+    }
+
+    if (s->data_end < s->file_end) {
+        ret = bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0,
+                            NULL);
+        s->file_end = ret < 0 ? ret : s->data_end;
+    }
+}
+
+
+/*
+ * Handle reopen.
+ *
+ * We must implement reopen handlers, otherwise reopen just don't work. Handle
+ * new options and don't care about preallocation state, as it is handled in
+ * set/check permission handlers.
+ */
+
+static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
+                                      BlockReopenQueue *queue, Error **errp)
+{
+    PreallocateOpts *opts = g_new0(PreallocateOpts, 1);
+
+    if (!preallocate_absorb_opts(opts, reopen_state->options,
+                                 reopen_state->bs->file->bs, errp)) {
+        g_free(opts);
+        return -EINVAL;
+    }
+
+    reopen_state->opaque = opts;
+
+    return 0;
+}
+
+static void preallocate_reopen_commit(BDRVReopenState *state)
+{
+    BDRVPreallocateState *s = state->bs->opaque;
+
+    s->opts = *(PreallocateOpts *)state->opaque;
+
+    g_free(state->opaque);
+    state->opaque = NULL;
+}
+
+static void preallocate_reopen_abort(BDRVReopenState *state)
+{
+    g_free(state->opaque);
+    state->opaque = NULL;
+}
+
+static coroutine_fn int preallocate_co_preadv_part(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags)
+{
+    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
+                               flags);
+}
+
+static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
+                                               int64_t offset, int bytes)
+{
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
+}
+
+static bool can_write_resize(uint64_t perm)
+{
+    return (perm & BLK_PERM_WRITE) && (perm & BLK_PERM_RESIZE);
+}
+
+static bool has_prealloc_perms(BlockDriverState *bs)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (can_write_resize(bs->file->perm)) {
+        assert(!(bs->file->shared_perm & BLK_PERM_WRITE));
+        assert(!(bs->file->shared_perm & BLK_PERM_RESIZE));
+        return true;
+    }
+
+    assert(s->data_end < 0);
+    assert(s->zero_start < 0);
+    assert(s->file_end < 0);
+    return false;
+}
+
+/*
+ * Call on each write. Returns true if @want_merge_zero is true and the region
+ * [offset, offset + bytes) is zeroed (as a result of this call or earlier
+ * preallocation).
+ *
+ * want_merge_zero is used to merge write-zero request with preallocation in
+ * one bdrv_co_pwrite_zeroes() call.
+ */
+static bool coroutine_fn handle_write(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, bool want_merge_zero)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    int64_t end = offset + bytes;
+    int64_t prealloc_start, prealloc_end;
+    int ret;
+
+    if (!has_prealloc_perms(bs)) {
+        /* We don't have state neither should try to recover it */
+        return false;
+    }
+
+    if (s->data_end < 0) {
+        s->data_end = bdrv_getlength(bs->file->bs);
+        if (s->data_end < 0) {
+            return false;
+        }
+
+        if (s->file_end < 0) {
+            s->file_end = s->data_end;
+        }
+    }
+
+    if (end <= s->data_end) {
+        return false;
+    }
+
+    /* We have valid s->data_end, and request writes beyond it. */
+
+    s->data_end = end;
+    if (s->zero_start < 0 || !want_merge_zero) {
+        s->zero_start = end;
+    }
+
+    if (s->file_end < 0) {
+        s->file_end = bdrv_getlength(bs->file->bs);
+        if (s->file_end < 0) {
+            return false;
+        }
+    }
+
+    /* Now s->data_end, s->zero_start and s->file_end are valid. */
+
+    if (end <= s->file_end) {
+        /* No preallocation needed. */
+        return want_merge_zero && offset >= s->zero_start;
+    }
+
+    /* Now we want new preallocation, as request writes beyond s->data_end. */
+
+    prealloc_start = want_merge_zero ? MIN(offset, s->file_end) : s->file_end;
+    prealloc_end = QEMU_ALIGN_UP(offset + bytes + s->opts.prealloc_size,
+                                 s->opts.prealloc_align);
+    s->file_end = end;
+
+    ret = bdrv_co_pwrite_zeroes(
+            bs->file, prealloc_start, prealloc_end - prealloc_start,
+            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
+    if (ret < 0) {
+        s->file_end = ret;
+        return false;
+    }
+
+    s->file_end = prealloc_end;
+    return want_merge_zero;
+}
+
+static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    bool want_merge_zero =
+        (flags & (BDRV_REQ_ZERO_WRITE | BDRV_REQ_NO_FALLBACK)) == flags;
+    if (handle_write(bs, offset, bytes, want_merge_zero)) {
+        return 0;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *bs,
+                                                    uint64_t offset,
+                                                    uint64_t bytes,
+                                                    QEMUIOVector *qiov,
+                                                    size_t qiov_offset,
+                                                    int flags)
+{
+    handle_write(bs, offset, bytes, false);
+
+    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
+                                flags);
+}
+
+static int coroutine_fn
+preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
+                        bool exact, PreallocMode prealloc,
+                        BdrvRequestFlags flags, Error **errp)
+{
+    ERRP_GUARD();
+    BDRVPreallocateState *s = bs->opaque;
+    int ret;
+
+    if (s->data_end >= 0 && offset > s->data_end) {
+        if (s->file_end < 0) {
+            s->file_end = bdrv_getlength(bs->file->bs);
+            if (s->file_end < 0) {
+                error_setg(errp, "failed to get file length");
+                return s->file_end;
+            }
+        }
+
+        if (prealloc == PREALLOC_MODE_FALLOC) {
+            /*
+             * If offset <= s->file_end, the task is already done, just
+             * update s->file_end, to move part of "filter preallocation"
+             * to "preallocation requested by user".
+             * Otherwise just proceed to preallocate missing part.
+             */
+            if (offset <= s->file_end) {
+                s->data_end = offset;
+                return 0;
+            }
+        } else {
+            /*
+             * We have to drop our preallocation, to
+             * - avoid "Cannot use preallocation for shrinking files" in
+             *   case of offset < file_end
+             * - give PREALLOC_MODE_OFF a chance to keep small disk
+             *   usage
+             * - give PREALLOC_MODE_FULL a chance to actually write the
+             *   whole region as user expects
+             */
+            if (s->file_end > s->data_end) {
+                ret = bdrv_co_truncate(bs->file, s->data_end, true,
+                                       PREALLOC_MODE_OFF, 0, errp);
+                if (ret < 0) {
+                    s->file_end = ret;
+                    error_prepend(errp, "preallocate-filter: failed to drop "
+                                  "write-zero preallocation: ");
+                    return ret;
+                }
+                s->file_end = s->data_end;
+            }
+        }
+
+        s->data_end = offset;
+    }
+
+    ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
+    if (ret < 0) {
+        s->file_end = s->zero_start = s->data_end = ret;
+        return ret;
+    }
+
+    if (has_prealloc_perms(bs)) {
+        s->file_end = s->zero_start = s->data_end = offset;
+    }
+    return 0;
+}
+
+static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static int64_t preallocate_getlength(BlockDriverState *bs)
+{
+    int64_t ret;
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->data_end >= 0) {
+        return s->data_end;
+    }
+
+    ret = bdrv_getlength(bs->file->bs);
+
+    if (has_prealloc_perms(bs)) {
+        s->file_end = s->zero_start = s->data_end = ret;
+    }
+
+    return ret;
+}
+
+static int preallocate_check_perm(BlockDriverState *bs,
+                                  uint64_t perm, uint64_t shared, Error **errp)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->data_end >= 0 && !can_write_resize(perm)) {
+        /*
+         * Loose permissions.
+         * We should truncate in check_perm, as in set_perm bs->file->perm will
+         * be already changed, and we should not violate it.
+         */
+        if (s->file_end < 0) {
+            s->file_end = bdrv_getlength(bs->file->bs);
+            if (s->file_end < 0) {
+                error_setg(errp, "Failed to get file length");
+                return s->file_end;
+            }
+        }
+
+        if (s->data_end < s->file_end) {
+            int ret = bdrv_truncate(bs->file, s->data_end, true,
+                                    PREALLOC_MODE_OFF, 0, NULL);
+            if (ret < 0) {
+                error_setg(errp, "Failed to drop preallocation");
+                s->file_end = ret;
+                return ret;
+            }
+        }
+        /*
+         * We will drop our permissions, as well as allow shared
+         * permissions, anyone will be able to change the child, so mark
+         * all states invalid. We'll regain control if get good permissions
+         * back.
+         */
+        s->data_end = s->file_end = s->zero_start = -EINVAL;
+    }
+
+    return 0;
+}
+
+static void preallocate_set_perm(BlockDriverState *bs,
+                                 uint64_t perm, uint64_t shared)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (can_write_resize(perm) && s->data_end < 0) {
+        s->data_end = s->file_end = s->zero_start =
+            bdrv_getlength(bs->file->bs);
+    }
+}
+
+static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
+    BdrvChildRole role, BlockReopenQueue *reopen_queue,
+    uint64_t perm, uint64_t shared, uint64_t *nperm, uint64_t *nshared)
+{
+    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
+
+    if (can_write_resize(perm)) {
+        /* This should come by default, but let's enforce: */
+        *nperm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+
+        /*
+         * Don't share, to keep our states s->file_end, s->data_end and
+         * s->zero_start valid.
+         */
+        *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+    }
+}
+
+BlockDriver bdrv_preallocate_filter = {
+    .format_name = "preallocate",
+    .instance_size = sizeof(BDRVPreallocateState),
+
+    .bdrv_getlength = preallocate_getlength,
+    .bdrv_open = preallocate_open,
+    .bdrv_close = preallocate_close,
+
+    .bdrv_reopen_prepare  = preallocate_reopen_prepare,
+    .bdrv_reopen_commit   = preallocate_reopen_commit,
+    .bdrv_reopen_abort    = preallocate_reopen_abort,
+
+    .bdrv_co_preadv_part = preallocate_co_preadv_part,
+    .bdrv_co_pwritev_part = preallocate_co_pwritev_part,
+    .bdrv_co_pwrite_zeroes = preallocate_co_pwrite_zeroes,
+    .bdrv_co_pdiscard = preallocate_co_pdiscard,
+    .bdrv_co_flush = preallocate_co_flush,
+    .bdrv_co_truncate = preallocate_co_truncate,
+
+    .bdrv_check_perm = preallocate_check_perm,
+    .bdrv_set_perm = preallocate_set_perm,
+    .bdrv_child_perm = preallocate_child_perm,
+
+    .has_variable_length = true,
+    .is_filter = true,
+};
+
+static void bdrv_preallocate_init(void)
+{
+    bdrv_register(&bdrv_preallocate_filter);
+}
+
+block_init(bdrv_preallocate_init);
diff --git a/block/meson.build b/block/meson.build
index a3e56b7cd1..367ec7a525 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -13,6 +13,7 @@ block_ss.add(files(
   'block-copy.c',
   'commit.c',
   'copy-on-read.c',
+  'preallocate.c',
   'create.c',
   'crypto.c',
   'dirty-bitmap.c',
-- 
2.21.3


