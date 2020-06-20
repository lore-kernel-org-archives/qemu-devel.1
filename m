Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA94823BCD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aX9uBkdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA94823BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmeeP-0007y5-2d
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecQ-0002sn-Pz; Sat, 20 Jun 2020 10:37:18 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecO-0004UK-SP; Sat, 20 Jun 2020 10:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4F79wJMwT09FptiTx+Fw7fqc1RcIJG1vKNLfHaWvrqmXiM0ulRw6KN42jitVsP2bLMHtqdsv/+bD5PTVHNV1GFngWFce+xrp6RB9DZXzGNlpbqqtgvrTcQADxQfkhDxwve2y5hFA8hEcMfYN5nBQm5TA7GF0lh5quYDpixDct9WU4R0WV2lWIu7OLhkAuM6gOcWcOs8+DrVG9ntEyBsgDW9IVMwbaItxQg5NCanU7es6kCsgKYxWXqP8nsTkFQvZS9NLu1+yRUlql2nRMQO3o987tupDhqhVYoTYUgaXmJNtRdMDkDfhjkvypVmHENrumJklHIlqMxNB+gBVkHKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxq4by7r7/43OxvqEV2GmA4STFQGX0fX6D3AxzMKc0Q=;
 b=nLrXfrgD6yTMocoyT24AY+ZaCBhJbGA6eGHo4yvMYq21HGm1oWv0fDFnu3eCLzXhTa79Sxj/2G2/7WKVFPvgEmm2p0qpO3trMZl/+Juvvw4KQrN2ZELPrgYASpNRiknRsOoaDQfLYFiLXrW5G84fUHU/B+DV0owOC4zibumOrH7/xacskNgTcABeA2RdSsH7TERoI5kmhz/pRG8kBdw9Xzm5TN+EmkQh6ub5k4HzGK5B+oeOmv2vuqPCIcQQhbh94xZqNz3HB5FrW6W985nsrIU43K1U8w14p4Np/jCAS7ZiFRJdWelCJPou6Z/srrH7IcSOTZmiDKelkwQRGavWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxq4by7r7/43OxvqEV2GmA4STFQGX0fX6D3AxzMKc0Q=;
 b=aX9uBkdyLax3qLupvJpogZUE3Y1a0Xl4uvfX2XkvbhA++e+eMPKyopHwte6ARQZXFg1Zzbh+qwnjPuUOIE1Sy7w1qI7sjxXa+LPtF1FvFTnp0UQsSV0hOHWKdMHcYDaFcvZ6ksop1y9Zi/CbLpaRQ+uTZYcPBymS7mjQ88CwYq8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:37:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:37:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/5] iotests: add 298 to test new preallocate filter driver
Date: Sat, 20 Jun 2020 17:36:49 +0300
Message-Id: <20200620143649.225852-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200620143649.225852-1-vsementsov@virtuozzo.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:37:01 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfcaa7bf-7512-47c8-3602-08d81527653b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430D9929A6EFF918E85359FC1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwCK/FRPyHjD1woIPWJj8WjkJY5O4LyE1YFv9O5o78gDfDewjazc8yXkPno+qm0c8s8ZnjqcWRMYZnMsm2kByqz95a43KpV/XIcVyl4Ujw9R/pFoRy688haAmKANuChn0M72XWK5MpK6GbznvaM4RF3x8uWN1CSkPJCygMtWm5mkkNkpcIfsM8uhM+DmxIx4zHuOUCnv2UiS/YbOhLj6o8UE41XrpHkmBr36DHoa7Q982VyddmtNuWFEJsKxEiAI7zKsnqQVP+R64TCbIln0bthbojZvINWplT8rdkfdYefE78Gwwsr7Vg3PpdwcUyzrTzqr+vo+V88BRJSEhNDjvIx7VF5xrOf1Uuz0sTlVNAyS4r3e8Vur2kYCY3WhkVPkRd7iVUkTkyGkDAnGR0Yx8AQqUH3WkyxFWCBwr8gkTnMAqY1aa9owPOSSzC6NNl0J6SmoE4B9NpmmDhZxrGBvMMyw01fvYiFoOFgpEkHJMK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(36756003)(5660300002)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008)(21314003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PUnYz3KfnkF3thYESDf1n2n20j5laY+zoIi/IXiqw5e6V5BVGemgYjS/7SJ27cTsgD5BbpuyiPqaXA65AKtf2E7y83vOpC/OusRCzGecHTmG2nrpNxapVbZ+dzgQ/3k+2DDJ2C+WeT0nCbREKNXAmnwT0q+FVQYXcXgH3wvb980BIee6FN3l/SS2YCx7PUbIeeoYfSxx1SNckIsbT89A1cGxvU5TdjKEn6WgUbgu9nRwLkQpTLmMNG+thqk2Oj4iBOvKyFYVW707srSLAeXdoVK58z8Xl1foJpNaQn/v0Czimz/ng+k0kRyGao2mvA7julPJMIoOEnKvAETo1t2ijzIRkUMM30w1QsB/Ne+XXH6yCjxaP6brFI69Qabrd74ndyQUPkReL2I2f/U8WX84WLWVVLjdL+DBjPIjFJlMVBSIgpL94Y6LoqnCnG+p45DabWPOfx+qRtag+hvkict5zLDOvSLk3dZdltk5MPSATwY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcaa7bf-7512-47c8-3602-08d81527653b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:37:02.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igr2+sA/HLFIR+R/TOsdZBIt9A0j+vF6dNg1FQCu9h2pQkL9q8W9SpBpa0e5gCSdMcl5vo7ueO8ylUN8qkVYqJEP2RRcvl1xPWShTgDtqDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/298     | 45 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  5 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100644
index 0000000000..a6af14fc55
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,45 @@
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
+from iotests import log
+
+iotests.script_initialize(supported_fmts=['qcow2'])
+
+size = 10 * 1024 * 1024
+disk = iotests.file_path('disk')
+
+iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(size))
+
+opts = f'driver={iotests.imgfmt},' \
+    f'file.driver=preallocate,file.file.filename={disk}'
+p = iotests.QemuIoInteractive('--image-opts', '-t', 'none', opts)
+
+log(p.cmd('write 0 1M'), filters=[iotests.filter_qemu_io])
+p.cmd('flush')
+
+if os.path.getsize(disk) > 100 * 1024 * 1024:
+    log('file in progress is big, preallocation works')
+
+p.close()
+
+if os.path.getsize(disk) < 10 * 1024 * 1024:
+    log('file is small after close')
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
new file mode 100644
index 0000000000..6c34d172a4
--- /dev/null
+++ b/tests/qemu-iotests/298.out
@@ -0,0 +1,5 @@
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+file in progress is big, preallocation works
+file is small after close
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..1bfb864841 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+298 meta
-- 
2.18.0


