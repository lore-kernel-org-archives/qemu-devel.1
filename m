Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD05FC55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CE22084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LlabGQeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CE22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnW4-00037M-Q9
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSV-0006BG-0t
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnST-00077x-Vx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:42 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:47520 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSH-0006Xr-B5; Tue, 21 Apr 2020 03:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoASxwS9S7EBEsbL1MF+q4sGT9NblXverv7u/KAFkF7+9H5EueHCXuBqyeSA1gPgeN5L053WirAmejoiBYPR9lKfXovGX0C4z7AGydI0wSrI3Xny9pkuLU5AvkIeXLz8OteTKTL1FT/+my7AZuV/8apax5DnbGhijlRh9Ys0p1EmeU4LqXw01nomjA9L5kUztOXhAy73+y4J0Vc/z491IbeGRenVJ2WQrWgddP3MqdOSb3308RHjkHITTQPzvIDqT3H9DXOTUlXZhzMEf+q6bZ/X2w6aTxwXmPD0ScuuGug30lPbUotv2Vw7HKQFMLe7crbRMDmbaW1xUaYrrETJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMw6YYnxDt+5EUStQOqOSF7YwuagnE5NW14l6OIYrpg=;
 b=dc+QAcfFMEwEjlo7iAq83nW4i0OvGZ5ZDomQ7ozdAFE2oT1FY/FY3unofVMcZK5lYzQLGHghHBy1K/KPY1F2zBwL1OoA7WcKtoxRBZRq1eNWviqPj1Z9rKZZLby0Wr96lV4e2z08d4Upq/Ig8F1S5DeCwne84s1CtayuPfG+FyoMjZZQG0xuMt4qrWhB/35TUMHD8iAtzzpuCvaDM/hyFbhmsJnkwqaLnN7UEk8KVYVdokVhYlSYcpGD7mv1FpTuxUa2GiKs9atONsdKRiYi4iNygKrF7QieSTXK1rqBI0UPtf91pFeYisHWOOPjmvfXIR/PCNN+RxyarI86zBCIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMw6YYnxDt+5EUStQOqOSF7YwuagnE5NW14l6OIYrpg=;
 b=LlabGQeND5rTFLWTje/vMXihcEa+2RW2QM+u4YZhbxQ06bZQzNWsAmgWdJ18FekABBK3CAp+DweSfTwpkxyAoMhMmtRZIVAW3+OA2o/6aehs1wdQAoe5BcDzpSy38wAp7tSD13c6Ij007zwNbFP3AOYJ0Z0E1n8fwxGY/I5Xa2I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/10] Rework iotests/check
Date: Tue, 21 Apr 2020 10:35:51 +0300
Message-Id: <20200421073601.28710-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:24 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76cb50b5-8034-4643-51d9-08d7e5c6b28e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53971BB3450FE9148E65BBE2C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y2p3Kw1X3t2gywVtbx7bNI3y+2Q2Q4C4X4OADl6HFrIRXWfjoUnCI+6rqLln38ZCP2Z2xp1HvemJU4CEx0XnNh+IXpbO2z9Vw0sVYrVf67qaaT6HnEJMqvPPTRMn9jyKj1ScRzWMH9YSfjnbVSwQpjoPLqQ58z4nAbksSb/7EtptSA5stfGWvc/eOwXfY1b8Xjtz8t8ogt7PNgFvkoX7LnRzMUWAc+0ajrIP/kgr0Huzbtgnt9nvjWmFgrrJ3eKNLJuutoL5EGWK0WlZ68DXkUG0sN1GhJ0YfsMJoZ6Vdow1BIjvqu54+XNPQIymmqA3GegcflkIoRFZ8u/ul4Ctc2SSxWe75qkObJsPTG8eCZpMaEUK6HRtZ6/e03vU/BSXlHHQy9nuObOIKLFQQVm/s1IY0Is8ndlViZvweBCBxg7ANwNfOf4IFKE2SGpGXmblsyJ5FEnu5KT5xcORgFtu9RN4vJUPtI+EGaVlubpUhCuVEC8U9ipcVViIpaYdgR5
X-MS-Exchange-AntiSpam-MessageData: RAfElM98MQZA2HSo3otj77neNyYLGSFtNeS9WsJHczMWe1tvTMbYR7rmNN7uhjJRri7pwsAUBBV8P6iXGGFuKm1R3pJJDdKWypU6LCYfK0U/hoXFPQVy041YCaLJGFHjgjDoT+e5GCrr9Z/pnLjybg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cb50b5-8034-4643-51d9-08d7e5c6b28e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:26.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2qj2MfsLRGj5mvX+szG698UTpM1Amizd2F9dDShdEhE/zE33umzmTU511FBvqOtL0oTveF4uNDJYLo1/pAM7DS8vVU6CnH2ltR8njeuwdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.107
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This is a continuation for "[PATCH v2 0/2] Rework iotests finding",
so main user-visible feature here is removing tests/qemu-iotests/group
file, define groups in tests and allow human-readable names for iotests.

While being here, rewrite check into python :) I tried to keep most of
its behavior, still some changes are made and described in three main
commits 06-08.

Vladimir Sementsov-Ogievskiy (10):
  iotests/277: use dot slash for nbd-fault-injector.py running
  iotests: fix some whitespaces in test output files
  iotests/283: make executable
  iotests/check: move QEMU_VXHS_PROG to common.rc
  iotests: define group in each iotest
  iotests: add testfinder.py
  iotests: add testenv.py
  iotests: add testrunner.py
  iotests: rewrite check into python
  iotests: rename 169 and 199

 docs/devel/testing.rst                        |  52 +-
 tests/qemu-iotests/001                        |   1 +
 tests/qemu-iotests/002                        |   1 +
 tests/qemu-iotests/003                        |   1 +
 tests/qemu-iotests/004                        |   1 +
 tests/qemu-iotests/005                        |   1 +
 tests/qemu-iotests/007                        |   1 +
 tests/qemu-iotests/008                        |   1 +
 tests/qemu-iotests/009                        |   1 +
 tests/qemu-iotests/010                        |   1 +
 tests/qemu-iotests/011                        |   1 +
 tests/qemu-iotests/012                        |   1 +
 tests/qemu-iotests/013                        |   1 +
 tests/qemu-iotests/014                        |   1 +
 tests/qemu-iotests/015                        |   1 +
 tests/qemu-iotests/017                        |   1 +
 tests/qemu-iotests/018                        |   1 +
 tests/qemu-iotests/019                        |   1 +
 tests/qemu-iotests/020                        |   1 +
 tests/qemu-iotests/021                        |   1 +
 tests/qemu-iotests/022                        |   1 +
 tests/qemu-iotests/023                        |   1 +
 tests/qemu-iotests/024                        |   1 +
 tests/qemu-iotests/025                        |   1 +
 tests/qemu-iotests/026                        |   1 +
 tests/qemu-iotests/027                        |   1 +
 tests/qemu-iotests/028                        |   1 +
 tests/qemu-iotests/029                        |   1 +
 tests/qemu-iotests/030                        |   1 +
 tests/qemu-iotests/031                        |   1 +
 tests/qemu-iotests/032                        |   1 +
 tests/qemu-iotests/033                        |   1 +
 tests/qemu-iotests/034                        |   1 +
 tests/qemu-iotests/035                        |   1 +
 tests/qemu-iotests/036                        |   1 +
 tests/qemu-iotests/037                        |   1 +
 tests/qemu-iotests/038                        |   1 +
 tests/qemu-iotests/039                        |   1 +
 tests/qemu-iotests/040                        |   1 +
 tests/qemu-iotests/041                        |   1 +
 tests/qemu-iotests/042                        |   1 +
 tests/qemu-iotests/043                        |   1 +
 tests/qemu-iotests/044                        |   1 +
 tests/qemu-iotests/045                        |   1 +
 tests/qemu-iotests/046                        |   1 +
 tests/qemu-iotests/047                        |   1 +
 tests/qemu-iotests/048                        |   1 +
 tests/qemu-iotests/049                        |   1 +
 tests/qemu-iotests/050                        |   1 +
 tests/qemu-iotests/051                        |   1 +
 tests/qemu-iotests/052                        |   1 +
 tests/qemu-iotests/053                        |   1 +
 tests/qemu-iotests/054                        |   1 +
 tests/qemu-iotests/055                        |   1 +
 tests/qemu-iotests/056                        |   1 +
 tests/qemu-iotests/057                        |   1 +
 tests/qemu-iotests/058                        |   1 +
 tests/qemu-iotests/059                        |   1 +
 tests/qemu-iotests/060                        |   1 +
 tests/qemu-iotests/061                        |   1 +
 tests/qemu-iotests/062                        |   1 +
 tests/qemu-iotests/063                        |   1 +
 tests/qemu-iotests/064                        |   1 +
 tests/qemu-iotests/065                        |   1 +
 tests/qemu-iotests/066                        |   1 +
 tests/qemu-iotests/067                        |   1 +
 tests/qemu-iotests/068                        |   1 +
 tests/qemu-iotests/069                        |   1 +
 tests/qemu-iotests/070                        |   1 +
 tests/qemu-iotests/071                        |   1 +
 tests/qemu-iotests/072                        |   1 +
 tests/qemu-iotests/073                        |   1 +
 tests/qemu-iotests/074                        |   1 +
 tests/qemu-iotests/075                        |   1 +
 tests/qemu-iotests/076                        |   1 +
 tests/qemu-iotests/077                        |   1 +
 tests/qemu-iotests/078                        |   1 +
 tests/qemu-iotests/079                        |   1 +
 tests/qemu-iotests/080                        |   1 +
 tests/qemu-iotests/081                        |   1 +
 tests/qemu-iotests/082                        |   1 +
 tests/qemu-iotests/083                        |   1 +
 tests/qemu-iotests/084                        |   1 +
 tests/qemu-iotests/085                        |   1 +
 tests/qemu-iotests/086                        |   1 +
 tests/qemu-iotests/087                        |   1 +
 tests/qemu-iotests/088                        |   1 +
 tests/qemu-iotests/089                        |   1 +
 tests/qemu-iotests/090                        |   1 +
 tests/qemu-iotests/091                        |   1 +
 tests/qemu-iotests/092                        |   1 +
 tests/qemu-iotests/093                        |   1 +
 tests/qemu-iotests/094                        |   1 +
 tests/qemu-iotests/095                        |   1 +
 tests/qemu-iotests/096                        |   1 +
 tests/qemu-iotests/097                        |   1 +
 tests/qemu-iotests/098                        |   1 +
 tests/qemu-iotests/099                        |   1 +
 tests/qemu-iotests/101                        |   1 +
 tests/qemu-iotests/102                        |   1 +
 tests/qemu-iotests/103                        |   1 +
 tests/qemu-iotests/104                        |   1 +
 tests/qemu-iotests/105                        |   1 +
 tests/qemu-iotests/106                        |   1 +
 tests/qemu-iotests/107                        |   1 +
 tests/qemu-iotests/108                        |   1 +
 tests/qemu-iotests/109                        |   1 +
 tests/qemu-iotests/110                        |   1 +
 tests/qemu-iotests/111                        |   1 +
 tests/qemu-iotests/112                        |   1 +
 tests/qemu-iotests/113                        |   1 +
 tests/qemu-iotests/114                        |   1 +
 tests/qemu-iotests/115                        |   1 +
 tests/qemu-iotests/116                        |   1 +
 tests/qemu-iotests/117                        |   1 +
 tests/qemu-iotests/118                        |   1 +
 tests/qemu-iotests/119                        |   1 +
 tests/qemu-iotests/120                        |   1 +
 tests/qemu-iotests/121                        |   1 +
 tests/qemu-iotests/122                        |   1 +
 tests/qemu-iotests/123                        |   1 +
 tests/qemu-iotests/124                        |   1 +
 tests/qemu-iotests/125                        |   1 +
 tests/qemu-iotests/126                        |   1 +
 tests/qemu-iotests/127                        |   1 +
 tests/qemu-iotests/128                        |   1 +
 tests/qemu-iotests/129                        |   1 +
 tests/qemu-iotests/130                        |   1 +
 tests/qemu-iotests/131                        |   1 +
 tests/qemu-iotests/132                        |   1 +
 tests/qemu-iotests/133                        |   1 +
 tests/qemu-iotests/134                        |   1 +
 tests/qemu-iotests/135                        |   1 +
 tests/qemu-iotests/136                        |   1 +
 tests/qemu-iotests/137                        |   1 +
 tests/qemu-iotests/138                        |   1 +
 tests/qemu-iotests/139                        |   1 +
 tests/qemu-iotests/140                        |   1 +
 tests/qemu-iotests/141                        |   1 +
 tests/qemu-iotests/143                        |   1 +
 tests/qemu-iotests/144                        |   1 +
 tests/qemu-iotests/145                        |   1 +
 tests/qemu-iotests/146                        |   1 +
 tests/qemu-iotests/147                        |   1 +
 tests/qemu-iotests/148                        |   1 +
 tests/qemu-iotests/149                        |   1 +
 tests/qemu-iotests/150                        |   1 +
 tests/qemu-iotests/151                        |   1 +
 tests/qemu-iotests/152                        |   1 +
 tests/qemu-iotests/153                        |   1 +
 tests/qemu-iotests/154                        |   1 +
 tests/qemu-iotests/155                        |   1 +
 tests/qemu-iotests/156                        |   1 +
 tests/qemu-iotests/157                        |   1 +
 tests/qemu-iotests/158                        |   1 +
 tests/qemu-iotests/159                        |   1 +
 tests/qemu-iotests/160                        |   1 +
 tests/qemu-iotests/161                        |   1 +
 tests/qemu-iotests/162                        |   1 +
 tests/qemu-iotests/163                        |   1 +
 tests/qemu-iotests/165                        |   1 +
 tests/qemu-iotests/170                        |   1 +
 tests/qemu-iotests/171                        |   1 +
 tests/qemu-iotests/172                        |   1 +
 tests/qemu-iotests/173                        |   1 +
 tests/qemu-iotests/174                        |   1 +
 tests/qemu-iotests/175                        |   1 +
 tests/qemu-iotests/175.out                    |   2 +-
 tests/qemu-iotests/176                        |   1 +
 tests/qemu-iotests/177                        |   1 +
 tests/qemu-iotests/178                        |   1 +
 tests/qemu-iotests/179                        |   1 +
 tests/qemu-iotests/181                        |   1 +
 tests/qemu-iotests/182                        |   1 +
 tests/qemu-iotests/183                        |   1 +
 tests/qemu-iotests/184                        |   1 +
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/186                        |   1 +
 tests/qemu-iotests/187                        |   1 +
 tests/qemu-iotests/188                        |   1 +
 tests/qemu-iotests/189                        |   1 +
 tests/qemu-iotests/190                        |   1 +
 tests/qemu-iotests/191                        |   1 +
 tests/qemu-iotests/192                        |   1 +
 tests/qemu-iotests/194                        |   1 +
 tests/qemu-iotests/195                        |   1 +
 tests/qemu-iotests/196                        |   1 +
 tests/qemu-iotests/197                        |   1 +
 tests/qemu-iotests/198                        |   1 +
 tests/qemu-iotests/200                        |   1 +
 tests/qemu-iotests/201                        |   1 +
 tests/qemu-iotests/202                        |   1 +
 tests/qemu-iotests/203                        |   1 +
 tests/qemu-iotests/204                        |   1 +
 tests/qemu-iotests/205                        |   1 +
 tests/qemu-iotests/206                        |   1 +
 tests/qemu-iotests/207                        |   1 +
 tests/qemu-iotests/208                        |   1 +
 tests/qemu-iotests/209                        |   1 +
 tests/qemu-iotests/210                        |   1 +
 tests/qemu-iotests/211                        |   1 +
 tests/qemu-iotests/212                        |   1 +
 tests/qemu-iotests/213                        |   1 +
 tests/qemu-iotests/214                        |   1 +
 tests/qemu-iotests/215                        |   1 +
 tests/qemu-iotests/216                        |   1 +
 tests/qemu-iotests/217                        |   1 +
 tests/qemu-iotests/218                        |   1 +
 tests/qemu-iotests/219                        |   1 +
 tests/qemu-iotests/220                        |   1 +
 tests/qemu-iotests/221                        |   1 +
 tests/qemu-iotests/222                        |   1 +
 tests/qemu-iotests/223                        |   1 +
 tests/qemu-iotests/224                        |   1 +
 tests/qemu-iotests/225                        |   1 +
 tests/qemu-iotests/226                        |   1 +
 tests/qemu-iotests/227                        |   1 +
 tests/qemu-iotests/228                        |   1 +
 tests/qemu-iotests/229                        |   1 +
 tests/qemu-iotests/231                        |   1 +
 tests/qemu-iotests/232                        |   1 +
 tests/qemu-iotests/233                        |   1 +
 tests/qemu-iotests/234                        |   1 +
 tests/qemu-iotests/235                        |   1 +
 tests/qemu-iotests/236                        |   1 +
 tests/qemu-iotests/237                        |   1 +
 tests/qemu-iotests/238                        |   1 +
 tests/qemu-iotests/239                        |   1 +
 tests/qemu-iotests/240                        |   1 +
 tests/qemu-iotests/241                        |   1 +
 tests/qemu-iotests/242                        |   1 +
 tests/qemu-iotests/243                        |   1 +
 tests/qemu-iotests/244                        |   1 +
 tests/qemu-iotests/245                        |   1 +
 tests/qemu-iotests/246                        |   1 +
 tests/qemu-iotests/247                        |   1 +
 tests/qemu-iotests/248                        |   1 +
 tests/qemu-iotests/249                        |   1 +
 tests/qemu-iotests/250                        |   1 +
 tests/qemu-iotests/251                        |   1 +
 tests/qemu-iotests/252                        |   1 +
 tests/qemu-iotests/253                        |   1 +
 tests/qemu-iotests/254                        |   1 +
 tests/qemu-iotests/255                        |   1 +
 tests/qemu-iotests/256                        |   1 +
 tests/qemu-iotests/257                        |   1 +
 tests/qemu-iotests/258                        |   1 +
 tests/qemu-iotests/259                        |   1 +
 tests/qemu-iotests/260                        |   1 +
 tests/qemu-iotests/261                        |   1 +
 tests/qemu-iotests/262                        |   1 +
 tests/qemu-iotests/263                        |   1 +
 tests/qemu-iotests/264                        |   1 +
 tests/qemu-iotests/265                        |   1 +
 tests/qemu-iotests/266                        |   1 +
 tests/qemu-iotests/267                        |   1 +
 tests/qemu-iotests/267.out                    |  48 +-
 tests/qemu-iotests/268                        |   1 +
 tests/qemu-iotests/270                        |   1 +
 tests/qemu-iotests/272                        |   1 +
 tests/qemu-iotests/273                        |   1 +
 tests/qemu-iotests/277                        |   3 +-
 tests/qemu-iotests/279                        |   1 +
 tests/qemu-iotests/280                        |   1 +
 tests/qemu-iotests/281                        |   1 +
 tests/qemu-iotests/282                        |   1 +
 tests/qemu-iotests/283                        |   1 +
 tests/qemu-iotests/284                        |   1 +
 tests/qemu-iotests/286                        |   1 +
 tests/qemu-iotests/288                        |   1 +
 tests/qemu-iotests/289                        |   1 +
 tests/qemu-iotests/290                        |   1 +
 tests/qemu-iotests/check                      | 980 +-----------------
 tests/qemu-iotests/common.rc                  |  14 +
 tests/qemu-iotests/group                      | 299 ------
 .../{199 => migrate-bitmaps-postcopy-test}    |   1 +
 ....out => migrate-bitmaps-postcopy-test.out} |   0
 .../{169 => migrate-bitmaps-test}             |   1 +
 .../{169.out => migrate-bitmaps-test.out}     |   0
 tests/qemu-iotests/testenv.py                 | 332 ++++++
 tests/qemu-iotests/testfinder.py              | 167 +++
 tests/qemu-iotests/testrunner.py              | 334 ++++++
 282 files changed, 1223 insertions(+), 1278 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/283
 delete mode 100644 tests/qemu-iotests/group
 rename tests/qemu-iotests/{199 => migrate-bitmaps-postcopy-test} (99%)
 rename tests/qemu-iotests/{199.out => migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => migrate-bitmaps-test} (99%)
 rename tests/qemu-iotests/{169.out => migrate-bitmaps-test.out} (100%)
 create mode 100755 tests/qemu-iotests/testenv.py
 create mode 100755 tests/qemu-iotests/testfinder.py
 create mode 100644 tests/qemu-iotests/testrunner.py

-- 
2.21.0


