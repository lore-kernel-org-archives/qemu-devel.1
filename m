Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EB22072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wm43KZ+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bUL-0004Qm-Fs
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFs-0007vN-HI; Mon, 17 Aug 2020 05:16:36 -0400
Received: from mail-eopbgr00134.outbound.protection.outlook.com
 ([40.107.0.134]:17743 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFq-00086n-HO; Mon, 17 Aug 2020 05:16:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDAqh/w5b0Tb8k0sKv/6GrSl+KZqIFVYORaxBaKs0R4dAPKHyIzgo5941M+bihDxh4d57HUm8HFs+Lq3lWNaBvZbLWCqtCNmP/UqSXTPLxB2VpqPoT7/eDkQacxcMKUM4kt7L9ECE/+1ZenNgayp+3XvaTAM4RlQbvzfWOngT03fbOXCCLYY4m0wskAHs3EtCNFb8oRt2lTxH7VvRBvM3DwOq1A+735VV9HFXRlUaJyM7E/0aZ3v7wGklmAKCUcC5GLCQR0HTVQOihkK+EHxScjPGrOUnMSCQiDjFFwgIDwsfVLmB0qvZ648yjTiQsqEqSrHZ6Vqk95HfCwJfJepYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8WR2ArAGOWsaIurcI6UsqgkUBJiqiJn+0b+w7wC3HM=;
 b=fDk0MW96wS0vg2C8SfYJYOCRpFL4Hcr3v4W4omnzQbMKdSW5M4X6jA52GoF2W/fK8JzYaD9CFl4uSJKyuunZNFvX5TaG4zI5FBewJrUBpTOD6qFnhryolNgcv0vflRoSEHxQ8ggSucgJhJAEGgzAxcot/kAnfLjsYQsueO61M12Ni+022oCCJME9dIkFFRzEHU7dgZ4yA23WYtPZ9cLGrqTcTIfF+RHeDCzLafvzzE/kLemfaCiDJbjzuXJyOGGFOV7D9vLTebSjObxP6MRL+8eyy3N3RCooFHIpgp5siQs0+0qB323/UDeDnaAeH9r/2W2OfrgSBBxU60rEeo0sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8WR2ArAGOWsaIurcI6UsqgkUBJiqiJn+0b+w7wC3HM=;
 b=wm43KZ+LBJ6XJwwnweJE+VXw68L0Y0V9fh2QBnf5kysAOoLPKGFIa+dSFH64/18EAn4HvJyCXVS2oM8sYc8pRD+nlqA+5ofChud867wWbJhqaAgvVerOuUNWEUoZTc+yrc6d+9Wwww9GzJjXqttOTEfCx9Fbz1Oiok4db/EYRdU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/12] iotests: add 298 to test new preallocate filter
 driver
Date: Mon, 17 Aug 2020 12:15:51 +0300
Message-Id: <20200817091553.283155-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:11 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16adf9c3-f97d-4b1f-8379-08d8428e2f38
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852B44D6D89AB0A3C5F9C91C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k14DEO9FFIEkHaMPW2UIU5OHikdYYjI+rrlMzRCwZbNMDwsNLGFmaYula7m6lwsPelwBYEU/kBIPTZZWu50cN+afx0sDBRAojO69q4VSHh7Q/m3qzgqD2s5tq+HC0B12FinZZ1wDRf9kWzErsMFVkt0KglHD/92AzW4l+CaoYHwJNNREtgjaIYKLhsh9YjFZuYEa7e+6rm9DtLnWTsSllVo6h4u0yj+2BdBbuspZiFptzAoxRGfBwyTTdwx7MS9V/o8COmMhQlMAyyxdrDvukzv81Dov10MOTdFjjjHdvaBEUKCmoVrMh8CxqZIqBSp8M30Yf0l5lxyJjroyYk+4OLxybyRxaAM0pUr4LeLsxf1QHGXiSTKQxhjk8TGhdTjCRpo/sTd1p8VZJvJ5wuvdGJ4n/nsVv6W1p8NZuAw7BPhlPkDCWzQ6fRpbDySnaXVsprTn7BQlLhJ9SjegpJ/uNYUCkLvYyYC2jm7+9FbUq/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DjNa6oaH60jhu+R1hQ1CpfZZIGZxlGUVQCBZW7TcEXYu0KNrC+xi13/IzXeqw2gc3eR24dXcznOPfmN24a0umgUE+DDqYJ2bZk0Srt+/+z67KwS+/4sHmK1t/1b3yF2nAJVVmU7IPPJbWjxCBMjDaxTyJAcZZl0xuwRflA6puFt9S63mq+/FmhKfUnaaIodAP9cSco+GPPPDhfVnaCxOXWju03Inarr4d9XIiI8QK5U4NNyjKXHrmlWk1LP48eG0ije5M7Tnfg9JA4qABhZ8L+X3EdYBXdWc3K8iGsbwEDJ119smK641VqwXIHLB9XiSitTiyYDgIj9aaA6FntAINg13wom/gZ/kS0Q64QqziRC85uUC38kRfzuAy8Tf0oMJCFR2ir9VsN8UNey30gpCB6jPcwomFaXsJDaGEeq+RZdWw9llcMXKSYVnXOAOXJhNd4fUb2ECrzjqdC4X0a/8JrCe7utQEfs8+TA2jSBbAoxnJFJImEl0hJoAbVXDbunaWaHX15wScfl2wRxtI/+gPpprXnJVH8AW23DKkJc99DU7xgX0KuiQguKD2SgvHifn3qVSSMhgKM/e0+sA57DmwVGDSNkESBMMFYCO0cSVUo8C15LHHFa10Seg5PGWlTXCSpueOQj5N/BJhbOCWFGudw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16adf9c3-f97d-4b1f-8379-08d8428e2f38
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:11.9440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmpADsVXE0+LeNRsfjEpAblN1fBULrhA+SsImIceiVWLNuXJTPdwl4F7UsOBK3HLks9JwnKT3SfPKginuhXZDSQj8X14h/Hn365VwYpKhpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.0.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:04
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.18.0


