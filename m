Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37113C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AF8207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iOQ3L8Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF8207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pea-0006VQ-8O
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUK-000177-In; Thu, 20 Aug 2020 14:40:36 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUI-0003Bm-J6; Thu, 20 Aug 2020 14:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP1z2W7Rz7oHuJfY4/kaFXgbo5yy8nmmIqOfkWitEiBhSLgnw5mLznmJZLjeQ3eSjLyGdMw61bQXXQkv2yPoTiZzBrsFStjvMqSOtzK3EXGrFlPv090UXxXEo2xMUX1WhhbuqymCehkm6vDOYqzlwEN/t8ZJ/vWPbzrd3W6PzoDaVJPCV14PWFpEnKCdoOG8c/CztqJE5iQrqE0x9VNqpG25ZYNPfyDFQw8JfoYf2hB1wIAgATZJRq2Np9iLd1p8CzOmwg1zTWZtdmIHYjOdIQYnI3tAziJqe/f/CmweG57TpCjLzKSaFTc8tz8pB4pUSmsN0fxIDCL3Nr1Yr9EIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PojbpGlAjyIZLQtIBV+fJDsMPKIisfljgBp7buOOgss=;
 b=RGWo4ituEu5mw84kcldHM635pNZAtr8OfDMQGAsVTeoEEweHoiQ0N9UfFCrERqNGKBS692roKvAQSiTwlSmd+MPXY1jQn0oOlXZzb9F7CAEXElcW286XS5aQchy8SFKR8Eehi44TQJ6NKZ3BQ8QHkpSLuczg9OR9gGakkWA1BiC5yTSBhUbkDt5gfE02ZbMyAKyl14emY8v5SVsuQWozjPt/0GYe5FwQ6XslDALXvt1zfCbG3fKGvmyxBt6UFXysCg3XCIv7otv640j4SknsGa45XYAPRkZtNkgZYW1/3R8elYXlo6z1SMGCkRB3+vXXvRaUcDk5YPh/0AF8c23B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PojbpGlAjyIZLQtIBV+fJDsMPKIisfljgBp7buOOgss=;
 b=iOQ3L8WzYBoOJLc30YMRDeJQsZHNJMados4xIkq8Ohc2B2bnwh8wv/dJIp92ZdrKdGNIIKkQst7gWgOL7aVv0jz7XCnChs7ZxqApsSJL6c1QaXkjMv+BEVlJQzs84AE6fzLWL82U10J4PECByS7sxhx+HNRRfwK7ClATzb+3x3U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 10/10] iotests: add 298 to test new preallocate filter
 driver
Date: Thu, 20 Aug 2020 21:39:50 +0300
Message-Id: <20200820183950.13109-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:12 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b35401eb-43f9-4d15-f74c-08d845387932
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032F4DAD3816D4E7554C81FC15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsAA7DLFvE5sJl6rLsOLatGSMMMugGYY111kPqiiYrhosPu9JqRqRWcb+EwAKLGyrZN+Mtw4tPgVleo5iRPk3NuucII7ouICahc+Oj8OyurjLrwWeXR7DJda+ciUz0u4yshu0swQgkft+aOxId/K2mvdOySQ5AusInYtPQKvpx7t06z71pmDlDUMuusBKtQYtY4YoqaCEGcC8J38b/oJNRCOP5meooMrnqGhpm4c9v4CyIILkkKEjHn0LTGsQJhtHwnkaomyMtw4BZJQu7+lv+fSJBFJel/KlKgkDdnCAZgQ+L257H1amLZLhrFMXnujBjyRdRVh6Q3WMrTe2vJtPUBa+qn+NSr4YIrw26U8mz2hIyrbN9ZDDMWCLldzOp/hj+apg4PB7f1A5N5j/9OAYJUuunNgPGjp/10Z6SsB6Gpojlc/+IOGnxkDd7t0/YbxJ+rDqoAjodBXcqlzk7oyQk3QBwVcgMRm8CVR6ox8yKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Dlde9cPbQI2+sGX+XJc3E682MXS3OylXTkhXzEiBeWC/IogNv0hCc+rN2dZQo6w63qLH7O9qpbcmdJnIQFzSBORC2Mp23MQmCJF5eHog1E1EfETtfmvJaBGnXeJQzxRtkHQZ4FsUSmFtBqq8WrYHy9od1aByP+AbGzxNQNC1WoP63VvM1FBwzkIJvvyE5nWzWriVaOtLBShGUFOiKDLwc6d3C6yntVNKPDMzaq1IJNU7QXTudZ0/F3i8EN/0+feP2NMZohvnK8gQkPXS/65G39FdfW9cwx7KeplyPuW2/ZTAYE6sCLvyjZHBaA9561X3T6ZQKKQrm31TdMy35WMFFGPBMBYimI2NoEnKmkn94P7pHjsWugPWudLuALwdzjYuAwcOoyhmV+sg81ujoKPdx613lFuA2EGxadMcxiFAioMVy3Rs0AIG/p3bM4Aq50duru+U12v7Z35ZwaDgkgi7ohT8BjVUpdAc/5x5iM31kBGhacIXUr/Mi5n2bdk0zst18R9hy+pWSyK0lmWOYXyQsykeCig81/2UcAuK2ShmOAAHGbuTIIK9dtVDloBTUm/qpM39RqdIPtCyzOW2/Kl4Qy0/upOSTifC4pz/d7V5w9lbuOPmPMaTSwrXB2q6ckodpbNfwlhBASuz/EsJ0/6W5g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35401eb-43f9-4d15-f74c-08d845387932
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:12.8117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT7NNvb55AuLxPxtXtSFgijA5Ym/oPB91xWuXfRE/HLHfKODNiIlawi5kOx3NygkI7kniVRzwyPTKHeEZ7NnF7eg3c8J6f3DFdsTrpHLdaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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


