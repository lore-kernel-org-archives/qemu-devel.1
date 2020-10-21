Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60555C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B7E2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pxvbDaIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B7E2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFpb-00080u-7z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaO-00064K-3Y; Wed, 21 Oct 2020 10:59:32 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaJ-00086M-Na; Wed, 21 Oct 2020 10:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BifydPTyNkRXvcokruL92RFKxs7vxCFvBgZd17oKovC4AX9wk1iycJiCYB4Fq1dpG19BijO72kJXtGcscp2g8RmBqKDFM9JtYaHzE24UIeSzZJhvTZLtfHIFcdZ8DZgQR1tBrWW+FB466iX6JrC4NhiGBh5FHyuC/pyPw3J2uwv/yfQOvbCZv3EDAYGc87/s4P3AlkuDwJGtJj1NLZRIVUFa/8epKUI4KihcYRpm2q/qht0NkQox/HFIsmNqjBclRo9KvQ3fTYmt7eOhezWCYC7vC3XqzBSDd9CmbW865iexDm/XN5Vy21hvh8F9efla6NnsrWDD/nxLsnTAafBjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk9xnLRJEkaRCqwclW4RZ1jHwvcdggDXzWHxBtZNzEI=;
 b=hYzTTcC7H24YAANDQt6wPae1R7c7SW6hsYTVsVvp4XaRysINe3Y5Z22v/AAF+kwQnD4Od4aE6jZWGB70X4Z9W3llUhbx1HUrDYs+K2anYz5NoJ4mJArd4mtQwilYiTsBEcRudeMcd9VGuvpw94XhSLMvFJSKc6lpQ+cKrQ32DBtDpFCT/ER0oqinD75vBqu7pVdwTpml0NqP9p4a6tuMcb2UIkGwl/MNzzjMQ1jASsWgpWUx3yXwhHCk2DNk/lKZYG4Y0eypStVpHh6dzEOhP69Lmv+cGAB7LR11kFrVdTwRoKCqJa9fD7y4HkDB7Q4OSqfLD+9bC9A4fApmLq65rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk9xnLRJEkaRCqwclW4RZ1jHwvcdggDXzWHxBtZNzEI=;
 b=pxvbDaIPRWfzQFD6dGBjKe7Dlm+TgQcSaLjRG6arSQG/RmNEd33mVRCmkiY+cHrOC5qBZmEbfuVtHbxIDTmBUmzZOZGwu5fLKjcSf28Ixy40eJ8G6oyAwBJioVh/tV/yo/2FV79C+lo02HiavHZQYhigb0yyEObjYinKyNzq/Jg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 08/21] block: introduce preallocate filter
Date: Wed, 21 Oct 2020 17:58:46 +0300
Message-Id: <20201021145859.11201-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3bcd6d4-a95c-448e-6384-08d875d1e35d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472735C48DA13317A3976BDC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LqXQGGhuPMaPnaqabkOFS2t84DJfhnGUDCAb8/GAhA9cM546bCmH312e9t5XJ+VXpEUmgYzXiSzEnSLTzEirHRX7qQfdwhocjuU9u4mvleU7gH9NXh0jI33yzax+Z5bYvb8VkUl0K5CkttJPGxqLJzzjrchwwPfkrx3hfxH3cHmnU+kaOFF4S8fbwnbjSIvatdXUIobg4sborNpLjCygHTLwskohCEv4H3mDTAR/ttARFAQvlaDxP1+b1Van7bHU8p0L9zOHvp1fhblwVVGDNC4tvWsciYS8atblXJhgYKAwt1mt+mMLlwhYnlVsTz32guzyhWIx0xWmUNBmVKEUiQplWyXh4XXSBlNPet38RGQ5g2KW1hC0AXFRwKZrr4t+GUiioYdAeZxbQRFOWw+7h424FETKCzK54gYRo1ySxTyPG2cKrqz86fzAGyQviOxzfqABH9VnwiPwaYf665bNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(30864003)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9fYJkC0OdzdsS8SOSS+vCKjEmZiCCrv69YP/U21JdRb/FYHyZl+n0nqO4vjmKhDjg+P+oJF36CZBd5mONhx5JJacIJ10+mwGZhch973LnLGctMmFyETyghU3z1oqBNfNoUPpVK3qsNBFlTdqDVPl6qL+73OzHmFj9XfngFMIVcdHXkp3yPdjliKOVVfJUt6FLX+RWilURBFJKFDdd7O4F2yTFdLGeSE43IzciPNH1Wuc7l2hczXFwJaNV8CSJ9nNaFe6gOElXDB8mtNNeQc7i48VeNQu8HgyrJcLwLNHnthezBM9l6dyOJ0Yvwm1tydQK4SUsDbjkadG+NkwtcOVqMhnJNQCvg/VEzmyDj3izur8z8aMQs6SZDangzYZgmGVI3A++PdazhZOpaT0dorYmshDzpRGlZ0TDDGnoGI0hNjv0IcFMUvl75MbVT0Ng+iTzKerde95hjJdKElY/LdQqWWbYzdA/TqDiDpZAxspbZepDtxxtwV10GLZuH2vWc2NpeNmodk6ZsHHGFAosdR7LtolhotXqxluxryu+C36OfDWl5M0ODDxt7jCzpF6FTe35+5/Owwe2IjdYgzH66qGlwnFkQ9XbMaXJlELU4+Er2bsnfTtWlgqBvDUJO6JaIW8v/BX5VyKH+rJ7WvRC4oJSg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bcd6d4-a95c-448e-6384-08d875d1e35d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:19.8746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGHoqYCj7BumukfmHxZBtN5e0o//m2l9ZaBN2FX6USl5NuRuY5C35FpjL1Jc8hz7+gPA6iBSWMKBECh612WLLHhOUUWY1vYZr6v+Uo4yUzc=
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

It's intended to be inserted between format and protocol nodes to
preallocate additional space (expanding protocol file) on writes
crossing EOF. It improves performance for file-systems with slow
allocation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/system/qemu-block-drivers.rst.inc |  26 ++
 qapi/block-core.json                   |  20 +-
 block/preallocate.c                    | 559 +++++++++++++++++++++++++
 block/meson.build                      |   1 +
 4 files changed, 605 insertions(+), 1 deletion(-)
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
index ee5ebef7f2..e74669159c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2828,7 +2828,7 @@
             'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
             'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
-            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
@@ -3097,6 +3097,23 @@
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
@@ -4002,6 +4019,7 @@
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
+      'preallocate':'BlockdevOptionsPreallocate',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
       'qed':        'BlockdevOptionsGenericCOWFormat',
diff --git a/block/preallocate.c b/block/preallocate.c
new file mode 100644
index 0000000000..bada72e1da
--- /dev/null
+++ b/block/preallocate.c
@@ -0,0 +1,559 @@
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
+    prealloc_end = QEMU_ALIGN_UP(end + s->opts.prealloc_size,
+                                 s->opts.prealloc_align);
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
+        !(flags & ~(BDRV_REQ_ZERO_WRITE | BDRV_REQ_NO_FALLBACK));
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
+         * Lose permissions.
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
+            s->file_end = s->data_end;
+        }
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
+    if (can_write_resize(perm)) {
+        if (s->data_end < 0) {
+            s->data_end = s->file_end = s->zero_start =
+                bdrv_getlength(bs->file->bs);
+        }
+    } else {
+        /*
+         * We drop our permissions, as well as allow shared
+         * permissions (see preallocate_child_perm), anyone will be able to
+         * change the child, so mark all states invalid. We'll regain control if
+         * get good permissions back.
+         */
+        s->data_end = s->file_end = s->zero_start = -EINVAL;
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
index 78e8b25232..9104e4d470 100644
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


