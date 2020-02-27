Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF00C4BA3A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8A120801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="STOmaOtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8A120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79eU-0006GL-GD
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 22:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79dZ-0004xv-8f
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79dX-0002r1-Ie
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:56 -0500
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com
 ([40.107.92.104]:52033 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79dX-0002hH-7V
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE7jlKFkXgo2PAwvELj74YVfKG/TykgGFbwtDX72MX1UY1s3rlOwb8LbVHk3rDIYbmRYG9O9Oe9Kx9jVjlhNL3d8b2c1QwdPphR3HZNBcwK8pdRzQ4mTv0nxO8x7CGTJeRp4xoK5bc3jT8Taxa/zSvck6diHojvv8xvQhNaIT5ngVZ9otpaT4Zlc5TW/20l08C24coXdg3vu5wyHkQhdxSGyZSTvZ+By3AqJyVCDEs+4IShYviqvgEyyykmOwAnhBU8WDDA6tWpsXh6mK6BveUQPj6aeoWtO3o+Y7BrnCah5MAgRXbIBEG2BLbAcT/JH4AP0fEHVrmDMV0o2uZpIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHAb+fODXTudzewknuV4U7RXflmkoa0cmki7nCiSNLI=;
 b=gGE9kkDsXm0QCT4XQLV2ecOvzRVKDDsNnjIlPZ+bZ4vmt4xJ1wHQ8gXDH7rxz+QQoHBTCnAAIvvO3cIKG9FbSFJsV5rTGx3iQsk3N6nf1ptvS2WkU4nidAroxiWc9smAk8NXmFyYRg0tHCmJWyNK+kDalEiZJ5ZhR2eTgS2hVdol25M/0lFv4EhJBOPHVDTc0p6qtghdzl7RYad1dxXjcD5yjosw4hgapbFja4GYgW7GgoX1+ANz+GGcF4OGOepe3dhhazGMf5XWklxYCSs2yUpS+mAaMz2oznrUqk9StmVujgFpGintXLxiRNn/E1388wfVZwQN9iZFYsv3C49uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHAb+fODXTudzewknuV4U7RXflmkoa0cmki7nCiSNLI=;
 b=STOmaOtrZkWT0y0FgoHoCZpYq9ZAGyT8avCKQW9MUqw9bQdwQdbl/uBjgeaMJ+4zMVtZz6tF7Yqj0oxsVZ8uLPurURL0nKeGUZC2OBU8Il8+C27sn9qL0SyAL2vsnD8nOVRj30fTmi+xJKILviz/FwdBZZC0MpxaXbCbI1DqPHA=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3582.namprd03.prod.outlook.com (2603:10b6:805:41::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 03:14:53 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 03:14:53 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix spelling/formatting in fuzzing patches
Date: Wed, 26 Feb 2020 22:14:37 -0500
Message-ID: <20200227031439.31386-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:2d::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 03:14:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a57af4f-3c6b-4bfa-ba55-08d7bb3336ba
X-MS-TrafficTypeDiagnostic: SN6PR03MB3582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3582F7CE26575EC287C3F409BAEB0@SN6PR03MB3582.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(52116002)(7696005)(8936002)(86362001)(6486002)(6666004)(66556008)(478600001)(4326008)(66946007)(36756003)(66476007)(81166006)(81156014)(966005)(6916009)(2906002)(8676002)(4744005)(786003)(316002)(956004)(2616005)(5660300002)(16526019)(1076003)(26005)(186003)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3582;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGdybweXTdTiWMxWSAJOS4bq96pCXodh3oAFYICPFfMrSZNbSCeF09wC+s+ox07RKL6Cn4Bhi80QgUR5JqYiW5Fy0VzuCbR60YBx8PZKGln0NOlf+Ym0p2xP7sCNEC2lgMjeeqENFBZTP4PCy2u76tyK4HeWCxMCSKwWXtHP7tu2kiETwEPIgUPJ8wP47m832UenbwxAQkwMLHrVg5u5cKWR1O5io0BX25mhEfB1Q8iDOUEyaP+cy3SchI3k2qrk3DFg3W1dj3PgsrUoQsv5rp8Miv9YPNY4QF7iHSYpww4MH5+jGLsG+9O90Eoveg0OHwcJYMqAYdkvI8aJaxrjgxVoOLxa7qgkBN6cYzL9K6wng7HYoMY8NM/GmsNLBTn38/0mCxGDWpg/ZFhDhfDAnCna1gVE3qnr2MkQH8CFRC/w4WUDIqRMB+8TkWRgBLDBdtZBcA84SZY9f1RuqYgqPQ0zICYyTlnO4qWHJyavLXHfPFWRlUUR3I9cLCQLRXQGjxJ5uZ2SzLD6ZSWnh546lw==
X-MS-Exchange-AntiSpam-MessageData: fnT86GKHPXwNXGNt646tX1hPSaY5jOn1JKrGbIfnU6LkGrVNE2TQQJ5X2q+TSnpOKG7h3y9KhC53sWh5NmojZNTfvG4dM2Px9ltLxNdoxdw/iGhyHhOmr1a7xwDBHbqzXYd/tc/tP1tcnfbwQ1a1tw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a57af4f-3c6b-4bfa-ba55-08d7bb3336ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 03:14:53.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBf9zq8RxoHi26p5/24V4rgdCUygXXD4iQU+q/icZmfc/r+RepDhNxiJSFZsdUDW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.104
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
Cc: Alexander Bulekov <alxndr@bu.edu>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches fix some spelling and line-length violations introduced by
the device-fuzzing changes:
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05965.html

v2: fixes comment style in the fork_fuzz.ld linker script

Alexander Bulekov (2):
  fuzz: fix style/typos in linker-script comments
  qtest: fix fuzzer-related 80-char limit violations

 qtest.c                       |  3 ++-
 tests/qtest/fuzz/fork_fuzz.ld | 16 ++++++++++------
 tests/qtest/fuzz/qos_fuzz.c   |  5 ++++-
 3 files changed, 16 insertions(+), 8 deletions(-)

--=20
2.25.0


