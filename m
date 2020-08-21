Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA09C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0636A204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="scL8sYEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0636A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97vr-0008B4-9V
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lw-0005hx-L5; Fri, 21 Aug 2020 10:12:00 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:44416 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lu-0005AI-Mw; Fri, 21 Aug 2020 10:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQmIjemLHVjL2tAc1eKocV8yBJYJDde0qxl7n1kITSWPgaP8sZRLgHIDHU9MgkpHEAvhT5DyTS9vkJlb9KJcBsMBoUswHzY0gp5tfljX1bK790GlGuVL7RP+i+x3mdnGzfDDDbwixTe3ym+8ll17FqbCO2GkjPX8JtCHQaJBTUC1BM+CpkosW9wfjteGHKO/mV/rYdmnkyKWOQgtQ3Vf5Jf2XW+BT1JSjZrsIXNrPvQ7uSEc8+SqC032Mf/qIeXPO8z2scHAKXzMgZHZARtZvl3xV9BHaHngTohFW0rN0YMT27vkMqbHOIts1sMa36Jccl3srKbBoU5kWvV3mRC2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PojbpGlAjyIZLQtIBV+fJDsMPKIisfljgBp7buOOgss=;
 b=SKVM18pbnjA23iHNamg81SMO4Bu6qmgisd2s4x2q6WlSwnp5APD41r2cQeMbXyVriJVPW2G+M/BbLmMY8Ayj4mTuXwEffl4iZkg08kVRVILtOt5SD4kz2opeGe/IEAmaTM1z15HxlQU/wkBin45jNwYlAJ69wJQlGunVuA1+mcReY4Wh7UTTbvUfG0K9jwLtX7LY2YWRK+ZSX5KwbZuZOQ3jaqjV/wM0OKtuo3HwBey0Honjn5QW0nrKTD3wufdgNdO+9jcPyDl8KMELbWCqa1vbAshJCijVqxD/SZ7Ru6YCp/9FDihzdsXG6C2Qs2xtLAVN+oDunr+z5K7KnCxN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PojbpGlAjyIZLQtIBV+fJDsMPKIisfljgBp7buOOgss=;
 b=scL8sYEe60CBAQrNcpAqEfdAWF0sDIJaMyuXcffuLAafnBF17n8jjsqpoZ+QZq7/XfV3qBIXyR77ZthMsrAP3PzZnDC5LNxUshcZsgRj2WJ0bdVmplH0/QdRKw4p9w4dpb76euBQiC2OvgPEefO+kzL4oAzFKqOnocKKKGa+D04=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 10/10] iotests: add 298 to test new preallocate filter
 driver
Date: Fri, 21 Aug 2020 17:11:23 +0300
Message-Id: <20200821141123.28538-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:46 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ff7567-5116-4e8d-377a-08d845dc240f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52532059FA3A68B1F3C239DAC15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofuxbgHvlzpb8BVipLjKdP2gYuEew8aZRWRHjwNbhf5gLWBVvqmUjsTiNuEnVsqpUZPRfX+3CnLswvPCo20DASU1TSuw/+LTRcm6JFHot0VUl7eI4qnV+xYLyd2RTbih8NoAxzoLcxWQ+88ISVGGvMT0I8LC8eUkbdmiKSlW2hUJQ2Uyx1pVMRSjgUPBAT545L8BonlgH6kTpjrduZzrys1VTvkdkFh9LiI3zQ3o3lUf8NCeHd8EJudF8d0YHSnt6m0lxu1Wd2eJrS0PdJXrsF6pwY9PH25QCsQdnMAEiYan1ySKc8h/IHo6Rw2Dw+OV/wYGxQ6q8+bHNfxvaKJGJ2cPzJe1+GuVXBMhEvLkw7AoJHgaBSMx3sSg+aFpQ2d5YrOQu5AQJvwTkCN6ODJEyFy+28usJDeCsZnc9EEpvIEvAfs8jQVBHkJxr/maXdO4egWOpa6PAcxYj+IeYQbTmp4Yjb8GylSKupXNl0onsKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5NuDqFw++oncoSRttz/DC/RAc3adyKgePwFiQ/4Bhz61rEZ0mqYoGJxSMKWR0D9tSwG0s1aPQ3HfcusYjCTTy9tdI5un62Xpst8P+PnUxGcbX4RMt0bBsYtiPDCSVZx51FM4qveqQRnC+62RdFMBziFlGQSMigaE6BJo9U+mHMatLnJy7n85GU/s4a0RlDc/YbLrbCbhV51jh7Jj/xNPbuCdVCle02NKLVU+AwTkG7Ead9Fj/7XFDSYQVK0v977ejsPYUHWRW6W9GWXgMnnOq445olEPX/OR6tOxwIbuEcRDxyOEBZiX+rxFJ+mfz5jytOXNPXoyR+6x9tMswY/IKdBVskp7YfKtUa51B/FRXp7OrmSqzTObSPJMRNqvgc5d7Rq9AFhTbXZz2fTwXGi+E9Q0oZO/9QJA9OV5iNkfxGFvU7vQPtojS2hXAMqrLLCtkRW46y64oDhDyhVz0WGjN+1vUgAPbCJn9HtjXxKlpXuCe/pHjeHYvINYsF9XkK/JSrxqaqIdGzqq+XLZBhwbIEyAJuC57/HmSXcbrIoU2UTaAHmnLiCAaP7UueL7W5Ef/5QS9d+lNK2tFChygzQ/Xvcpc6CbY/womMCZ9Rm9hpMv22r2n4XoLDKP7PGxaRFwMbUnZxvcuPe6xqHrE8SyvQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff7567-5116-4e8d-377a-08d845dc240f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:47.4507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lssm9DJYFq5eXppnFIMkYuYVSg8o7iPpCX9FlDzZkF3ZBWaVe5BojLdVr8UwgnFxyaup9Zn+VMoMaPiDHOFo6J3FJhK5iJZ3bBhrR+bIAzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/298     | 50 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  6 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 57 insertions(+)
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100644
index 0000000000..4f2087352a
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,50 @@
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
+iotests.verify_o_direct()
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
+
+# Check that there are no leaks.
+log(iotests.qemu_img_pipe('check', '-f', 'qcow2', disk),
+    filters=[iotests.filter_img_check])
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
new file mode 100644
index 0000000000..baf8f8425c
--- /dev/null
+++ b/tests/qemu-iotests/298.out
@@ -0,0 +1,6 @@
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+file in progress is big, preallocation works
+file is small after close
+No errors were found on the image.
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7f76066640..cdcde2fe48 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -306,6 +306,7 @@
 295 rw
 296 rw
 297 meta
+298 auto quick
 299 auto quick
 301 backing quick
 302 quick
-- 
2.21.3


