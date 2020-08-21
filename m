Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BB9204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TMPMgZ0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BB9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97tg-0004yt-Gd
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lu-0005b8-1G; Fri, 21 Aug 2020 10:11:58 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:44416 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97ls-0005AI-4e; Fri, 21 Aug 2020 10:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXl7H6Nnt+JSG+ouHmHc2BWdqURkNfVt0IncBWtGrNqwa77VySc/TpIZo7b55Fly88B70kbDZMWZ5eIiAP0hFPVCLENGFZbT8E5eYInb83dIxeK0Jrvz/uQ/ONTZVhEiGSa0SRybdWOMbmI1PDwwIRp3Mt0Qr1rSB3YssdyUiIlBaKJn2kQcmXCu+0o6f+kqFrlt/Ht0gMWbgJ9/Pi26eGv/+vfCBVNX+VjDkKpP6cC46I5HxvxzY18Yrw9LcNu703qGgCelwUnalV4jUnt3o3ZQZSuzhHolPxS3/+9mC0XkK9tzDu3l6TMMMFKfX+kuU4uccVNVJYI4zgDlbznkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2MXAeW/RMI77KkOtkr88BkwvA/NnR/QKKS6KgN4M0A=;
 b=IbDtApT+sJFFYKwQ40aG/tICSAhgdK/BphsGKb8IGMmfcrotihT1lZS26uRIUqntMl4DKo9P5jOSXqMRfivXs+i1+XOgdH7yjoARLGRmXsBMjOTQjlJIewpjPe1gs4gcTBCwWUQfC26fEc7ibAXI0dJqqovSjkvYhrOS5nqhTDPQwRfUKRO3L+8VKayZ7ckIe4z+evlYeR3REaC+GfBWD7e2zyagsgf0BiYcZ8s68ftbeYzO5TPntCGloqZHapOjSWfMRD6l3hGhEhkgVmd8aAolE9OXurTd5hmWaAA9732MaGrfEEFwx18rMCXZg0NWKC35I5CMrNdQ7D/lxf2Ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2MXAeW/RMI77KkOtkr88BkwvA/NnR/QKKS6KgN4M0A=;
 b=TMPMgZ0jw2pyLFcjHQh8tl/ZfE/HbcXrAEnzNoI330nqEQPR0z8wEEMDDrsrpqxuxqsZTA9hNymX5jM4cMZ5hJ1yBqJYoYYZlXkB2dsmpNMuM/i+tsp2wQhMsmPUSMdt3cTZuXXs008JYnbOyNYq6dcxMluBRHBQ9wCQ+s9JJjo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 08/10] iotests.py: add verify_o_direct helper
Date: Fri, 21 Aug 2020 17:11:21 +0300
Message-Id: <20200821141123.28538-9-vsementsov@virtuozzo.com>
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
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:44 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dab13f6-0088-43d6-1960-08d845dc22f5
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253637BEC695FCDF2FB7367C15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffrMMg98Tg1uBfggmHO3czBh2RjtvpBQE0dUA9uj0EujgUzzWbTSFRFe7rffrBaVn+R/wWBrMWZXklJyF6Pur5dTbWlIdZeXHI85dtoKc4Pftxu9BDKQvt63Ry68s5ckg5qSfJaJ0Sdw3dg29Qzt2FqFS1LsEcDGRtAU3uoVBs89/K/Dqn9mTgaXKqCsll6Ze0FW40rkjYggezbklmVw+HCVYSqahWq/dErB5kiLOUYhLo0wgUPwLhbLhcQPoOzNxkUdUJ+c97iTP7YkNIw+J7Ztc195Y6aY8zDopq/EClfUnUqW8I/S8XAykj2gVTTfercE+R2ZZQAq/C6jAREKuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(15650500001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NOLU7VLL2PLqWXG6c0wjUd6ZKGrfEHu6WPhwiWGz/2FhUQe6935awrTbpN+zwdecILhWCYJ5oyVH87V4wbPGKcN9eYMmb2qI7U5zquZTBN7Kw6ZmAOC7IPsxGBqYY+OEf5/nq6/JcCm47/AOlAoIlBS7pf2HN5ZIkgDopix8QsTUtucmU6ZDtuF4DxbfDrWbJv/Vb66NNFrN84U3AxINNq6znoai+XK6Mn2BFAN5IumHm0yM0vL6OtOv3+nCnLQ/mqxm6Q++QRz7xjmKyQiwB/ktJabP2mPcU8AOf8M4NbNzcNL5sAPq40jDTJKLWTfCfX7gPA3juHuz+GPH9H8diORQFY38gvdXbQVNZz7vAQ74XkSdYC0X4eUUzc6X7a3yJpb4w6kNbCP1R57GAp9YKHIfuPStvQYGjslGr0UlWzA3+wnS1GlEfJ062BE4XNc5ebgyj+VYjygvvurRmp+FvQ7VZrSuSNRUPY/HXPav7f2i5tdbHU4xvgb1IJ+IoiOEbiYXfBC4t4HvnmFnlAkcHbCSGYGBTkZv5JINtzqhs/MwSjEEbzd/YFwuvnKErWU1jjZESGyvIBoBL1Q8N49uJjEahlft7khCOZhgqtUuXf0yv4y9O3d0zDgLAWICJQJuwP7NTDiOeHbRg2aePDYK+w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab13f6-0088-43d6-1960-08d845dc22f5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:45.5779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiXorVrtaOQMnTGD3wZyfDVF5ET7wdX1MIY2DH2yNW/cbxueb6JHKXySPpQ5M/Q9BmZiJZzKt+TXaPrCx/j8aCZvmPcQJvw8DpqcRZ5KOnA=
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

Add python notrun-helper similar to _check_o_direct for bash tests.
To be used in the following commit.

Suggested-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 717b5b652c..7f1aa187a9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -29,6 +29,7 @@ import struct
 import subprocess
 import sys
 import time
+import errno
 from typing import (Any, Callable, Dict, Iterable,
                     List, Optional, Sequence, Tuple, TypeVar)
 import unittest
@@ -1083,6 +1084,17 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
 
+def verify_o_direct() -> None:
+    with FilePath('test_o_direct') as f:
+        try:
+            fd = os.open(f, os.O_DIRECT | os.O_CREAT | os.O_RDWR)
+        except OSError as e:
+            if e.errno != errno.EINVAL:
+                raise
+            notrun(f'file system at {test_dir} does not support O_DIRECT')
+        else:
+            os.close(fd)
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
-- 
2.21.3


