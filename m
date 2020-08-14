Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60BAC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54B2204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nm9IYlSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B2204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZR6-0006jF-SW
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO6-0001Nb-8A; Fri, 14 Aug 2020 09:04:50 -0400
Received: from mail-db3eur04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::72e]:48915
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO4-0006dr-4n; Fri, 14 Aug 2020 09:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq9E/fAyrFczDjOFh5g7AX2sLTFkk44nJjXt3yodVz9EKZkk1DZnk++xGVNm0CpU2zfb1bBdEPY5Q+wy/ke8eAHGY3mMBQc17B+2/823adr7JpIndrn/H9oJVz5w64keKeV4bwY7Y6bjzfpyPUOuAquKNYe1DSVax3rwvMyBBR3YuubQcrgugBoqFiPI+kGDCo0BlHFKZ8EXZnpR5UTjsLfRvvTypL5rTDWfbUCWPbwPWvGED7rXADLfWDtMUtJQbQwW1pzQoYDzPxFchZp7mXGXgMX3XgVLScdeblW4eCHJfphFIGJ2+NOFWiag6DziQcAhu/AsoYdl7ZIWBD0JDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwJJICaHIpkjdPbIEjn3UdJ8jHH3nyXZ6FM0fT77gxU=;
 b=GiL07nz39fseohbtfNuv4UGrKMWp7NyWIJ6YtOJa/lTBHeFmnBXK6I8DQt5HUyrBLZausmMk/MLnwlY85T3RlYMHrUZxlbKpEZyTFaxDPV5xrV1Lu3ifYKUatYYvqGOIqR6bNmWBgDZCQ5EWyybycU/ONmCi5HzaXFlKBvkpljRd8d948yNEzhk3E8WIHpHsay8nRkQktNkG9EorilYDBU2YxThZ3n+FwjqQUY9fq59DLvheQzKTnYGDYyQvYWzwwZ0GcubipO6l4BTcaJYBdeTl5lXRlnb//z+2Ml1IohRpYrq3S4flC7DbmbxSeNy+NufpuEcGVQMQihPhh6wxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwJJICaHIpkjdPbIEjn3UdJ8jHH3nyXZ6FM0fT77gxU=;
 b=nm9IYlSjvO604bE/chj5j4nBjQTxFVPomoWtxryk0wBLaTeqIzxyQGl6UX+8wsGBCpxmim+ioHr3S5RaK7TXPUJjSTN09Xy+bespbDoxDwjCcvPrphu5pZMzLXbupJzY/TWDcC/ugtvORTm6yZvZz0IIPCRhH8kbM4uaa+Qcc+A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 9/9] iotests: add 298 to test new preallocate filter driver
Date: Fri, 14 Aug 2020 16:03:48 +0300
Message-Id: <20200814130348.20625-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:27 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ced3d61-b2ea-4efb-f7ba-08d8405293d0
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB298123EB2F5DF0B510007635C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7Sz8swdf5SnDKv7XBwR8zhdRc6Axok6d4xEKpPSA/yf5y2SxdQk/IAVdVk7vJEA3Qp+f1xMSbMx7cE6hGsYJ1zXxR0sE9juUHdHFVxV+LMC1/DLO2K906KoPQSsAjZcMxXXSVokb/azGXWMjFkX/wORgh3wC94kVbUP3+i8Tehfz57OguqBBf30iPwXZY1mydh8oRBR+C2EyvXssb6wUW/e4ElguRq4waoEd0hvGQUj8qym6DGwpZdfhO6qltXsxmZFK64rX62NfvIohFuguYsn36y28J7MmtGfwXzXuhKEJuCnxF1ZzeUR8vH14FxrMiIdIOAhmkrFuVOB4dzHBzAj7DldMSQc/o5nZ5rmyZwDeV6pcFDLco9omzkixw43QhNI9C6y8nRhTYuQs+w2JD0raNuquWiCcjIt6fSN5fHBiJ0ItcTiFuZAl5gMbFs3V5PmtVP1Wcj8AYDKXT/9yB4UORkibHcA/IilTaueUA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AV93DvAIrYDQO0a3q3lb6td9OUrGIUHQ84yfkE9DgVLv1Vdc6af6HSrrDsAeEtfYjKvjCsjUYYDv2d92DTX8x2NmD7Suo/Gw6NvoCPyRlpvwiomL+gwNPpo+gkkx78VD9bHpF5Pu0u53ObXV2yESkzm9cZx/pqORtu4OXXgR1neyFeVYpGqFvvR7cWF0nMdhISbGLV80l6lmMi2a6IvpscqGe0LZqAmcdhB3ePLwNhG1p30LCYZsGwMQYnShe5C5z3WfxxCD723xJeiQlhF5JmmkccgfNZALkypgPE8I9Nn3hzrdfrKlQUMS6eNh9hB4GFzd8ATLMjoUF9yU39GHB9PzqXnySD2Ufq0bfrawbGIT3b2lO/UbGEEJUVh0UG2ibMOya5SwbrsjDpiWGuN4tDpGXht+rKdmOrPEYxaP7YLoCxY970QPk9dKwKz7lvKYW+dKBGKyVXd2kPzSi/s29FW8TjFB/+18YdyIDewtFnzU/bmGazpWnNMhEmhS8SnqtP4S6XXMp+JR/UiFA28v2gR8J4KH2qpjOw8reuLZNJs38qOSi03ffbbilzweOCDrWG7NL65bQ/CO2DbxSJlRVzkJ+vy+ZIoiIqSpSJ6e8zPu6A8A1U3eJQlsfbsaxaBhS6I7/H9aILhdHirO+QwsHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ced3d61-b2ea-4efb-f7ba-08d8405293d0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:28.6925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/2GO6oyv5DGvpA2s9hV7oK0hLy5BFndQyjz64ZYrx0MwxidoeP+QjUL2494sEVKK+tofPWPJvNe6oRCiV+7iwQIIrU29jfibIJm46U7BT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=2a01:111:f400:fe0c::72e;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/298     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  5 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100644
index 0000000000..f10b14fd35
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,46 @@
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
index 025ed5238d..ac4772b43f 100644
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


