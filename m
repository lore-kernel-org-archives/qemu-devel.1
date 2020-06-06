Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A9C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21E4207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pq+WOeiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21E4207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU4A-0007DX-SG
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2F-0003AQ-Hu; Sat, 06 Jun 2020 04:18:35 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2D-0000Zf-AK; Sat, 06 Jun 2020 04:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cje5nvUu0LvVu4O/eo1KKU8EuaX2NkhO6L8DRsKNzbVD4G33AogqsPw+GCfNH58WaF2CrNPFw8Gd2edwnmTxX3f/X+mLocfDkE28TScZZfROUr/+fI5NxLRJwSwCVyKwY00CM4YUyxoxBSVIP6anq3UnXILg1BGXGcbsH+8yAaS1IBcTxJV6+JPgvWe2nDL9V0QRV4ppqsqztB5Jy/ges5X8Ksz6ryxLMYCOLbcJYWNBmmDJFb7KM8Y57Mz83zwPK6yFnzK0BOAgCiXKn+QNvEn1RTcz7xV/eZS2xvYzAhDvpT7eaLdJKP9ADPEgYmtgwyj5nT32fOV2AMqtIj2MMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCG3WQZu7zT9i6+FJSAMGxnsq0FTcViWj0aLP4/kVw4=;
 b=ZbTbQgNv6HTD3OqwfrxaB5h956D5bw+G5vUAFzWBrc4ocjS74NWWrgfQoSjMsQRo65gfsvjjHL2mStoUSv3oDPXStrJjJyfK72E88zu64UI/Fp3pNQEtomBzLg6rZ9dGkmx6BCSLNaNnoZlsuTuL2hcYVLJG/JMIutpcfD43z70oqUtUlxg7BadiCp2E/rgJwy6fiOvDP2RfszlYD7axA4172oJZtBVRZgHQ28qT1Kk3PjcS6PgkMNiJ7f3d+kwjrjPYHX7v7J3mv0m3rREINmc3OBT0SxxI5HNtZsB7a1yhQd4vkbb3cqtHjr31T3cG0lPw83ays/n9UBFIo2fC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCG3WQZu7zT9i6+FJSAMGxnsq0FTcViWj0aLP4/kVw4=;
 b=Pq+WOeiQEhxr2+SYx6KyjTvdOt8FtT4A70z+zaU18LNrLZGGq7fXGEfYuNDjVBMg8Y3ONS/NILgIEESSlVNPX3t/akq73FEzXAZOiExVoAqIazPnoObUNEi3tHQ3S/NDW8DVH528xHszeuKBVsiHKw5C/nqpDr7yR7F17vRe7PM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 02/13] qcow2.py: add licensing blurb
Date: Sat,  6 Jun 2020 11:17:55 +0300
Message-Id: <20200606081806.23897-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200606081806.23897-1-vsementsov@virtuozzo.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:23 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10691825-cf03-42a5-06f0-08d809f22e97
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480274E9F10EF04E0CD7E56C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I61lye4C8LW1bL992LW43lkjeDVwLDKCxxFWT4/gBiSVvDXsDmykcj0V/MZdFTOlPID64/98di3FqQ6OKkq0FD13gFMllkalTYCIYuyFxOU6RMOwJfiH/4YG7hGpQs+InMnZ9cwCLcVzwW0xZiBuvBzTCVCvdjMQLl19AfGaDwcagWFRcpqp5CGF6OkYuRS6ETdyioJb4Mafk+LGyp8hUM5sR/kvI6arbqV6aCyfn/APDCySPlBQIXa+1InUtvnNFUCXiUuFGTodvqYJBlIZ3dFKTKSmYr8+i3lseRA3LhT5qSflcLR6Iyglsi191+2V0k3aRlwa3oZlJjQ/1/ye9GlSJMqytQvmuYjKIwl9d8uNMceGbKpmLFC2xyY4rWC63z48UhPwn9s09QeYi1RNUt24FQgVK2OT8jEtIW9ZGBlQPQ8PX+XtwuG6dyJ5kTTqKDmEp5X+H1QoknHgVt3ZvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xsBh4hq+Slwx5KDwkYGIRfSGbOf5at1gMYFRChp45ZTP9DWU7dg2P0Ppyzlt/2uIA9R4v2x6AHC4/4bvHMvVr67MfQlpziXJ+mnWOFB+V4raAY97p0TcDVyxungAx73dRY1dndLmz+ifAxTr7oG9bPpbKzCPkq/MbUe/hAyh8HUwYuNk/YxisB9HcUk8lzQ7ltPLzXRnnHipvvfFchptI0rqp/Tg3zIMoWFrzQ3Y+cSFrGgSgQKXTpNAKu6mk8jz49QZX24Mxn4fFrD4O4ZdRm+nxO+X/SYRLsx/Tl+MBBeXrUi6G7E1iJulhtv0q9i5VXHZq92XrHDuejxPnvF6n7EOygg27jqJANvQKFBLPa4eCxo2gWR3ckU7XoKtx/BR/hgPm0w4wpye07bDgMUxHvcT4EtyBHImhc++AlVkss5rGb9OF10eLjeBXmWLCZg7SGd5jGIwsGcH5D+cCvlrb+6yyXqUMRYtDVgXlfizvBGOtaBU0Ms4nGnbxy7WtvKf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10691825-cf03-42a5-06f0-08d809f22e97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:24.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4ecoY5zvudm7/7JOCggI+cLcVa3xKFYlLoH4AllxPzF1d1JeJ4GpfAX5bInlgFD82CqHpEvcOKVEGosXmshASci55/GwVWSHCoYv/EMvIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.20.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add classic heading, which is missing here. Keep copyright place empty,
for anyone who have added (or will add) some intellectual property
here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index d99f4ee3e8..2da434a013 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -1,4 +1,20 @@
 #!/usr/bin/env python3
+#
+# Manipulations with qcow2 image
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
 
 import sys
 import struct
-- 
2.21.0


