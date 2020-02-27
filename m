Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59DC4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0B8222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="1acZ9F+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0B8222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79GP-0004yj-6S
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79Eo-00044I-Ab
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79El-0003Z7-OU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:21 -0500
Received: from mail-co1nam11on2132.outbound.protection.outlook.com
 ([40.107.220.132]:6976 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79Ek-0003Or-MJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Qo5gIm/vdH8Llzjx0jTR3/ionWRvxOgXClCrHRD4hV3WxaW5LRvD5WhYiI/R1S/cFRksnOFocgpYgV3DmCjf0AVK7JgzvBZVwXdJExFFkhZTnXdUzmc/296pqDaneZSa3ntGIX+q4GBytTuerDFzYD7D1axX6qIzDohBUFxuv5v/6BmQ3+6/6ytGtyDroghHvPM9o1a7FvpUYddr/cxcOMWs2VEPo43uZlCRl03v/SpzFskH78GKka/E5SoPqpq5ysVkLb3/GCCGX0hvFZm7s8iT5UhBsWPliiFu0Vk6iOUSjBxOflwUEACKNW6FPyL1v7/PyXP4201DHt6r9PcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PCoTBb1HN/VgTYESxY0A3ECcM4DmmBjigNhpJh0SpU=;
 b=Dg/Oqz9VHp7qAI5Q9AX+wkUO6lbPe+fjJkKobtCfZbOn/sVVcxZ9+mVlYB2BgBffasbyq7msVKiYx0n5OApBMUBx/O+QEyDqp5q/zYT4X/LzSZlM4O5L26XYaT3i0GQHGcDYc5f0q24bZ1oIOqxsmt07yM3ZHUy6xOcmwhABHz27anqIKdumka0LmDvIiBlO5EGm8Ug6cCn/+w1ycIXz/0TTU1ygG+/7UbbNSj1RsobASbIpi6kJgGE2tlWshtKmK0Q7/wMTKzPN+7hU6fvZiZJms+C3Ll0nhnW2mkAeGCbUX69xeGuFJMJKjvGmrIx+JnmMVjTelEHTmFY82nKFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PCoTBb1HN/VgTYESxY0A3ECcM4DmmBjigNhpJh0SpU=;
 b=1acZ9F+6RL/GmhzmtwVL0X1zb1rTtBPJxhUQnd5DanrsqlerMBBLAwsSXpdXkGKBOCry4utanj+AjKDsTkKhCTk7b96MCn5GR7ySLpCjCbTBNrWuinR0lSTcCSb/fO6GHZxRzLKrtsYZzuOZptmYdLh9mpYWUvZYzjXB8StaQY4=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3503.namprd03.prod.outlook.com (2603:10b6:805:41::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 02:49:14 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 02:49:14 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix spelling/formatting in fuzzing patches
Date: Wed, 26 Feb 2020 21:48:53 -0500
Message-ID: <20200227024856.23777-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0111.namprd02.prod.outlook.com (2603:10b6:208:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 02:49:14 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf4c6c8-d84e-4037-5e74-08d7bb2fa174
X-MS-TrafficTypeDiagnostic: SN6PR03MB3503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB350318F731174287B7A208C4BAEB0@SN6PR03MB3503.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(189003)(199004)(36756003)(26005)(8676002)(6486002)(16526019)(186003)(4744005)(4326008)(478600001)(52116002)(6916009)(786003)(316002)(81156014)(81166006)(1076003)(86362001)(2906002)(966005)(7696005)(6666004)(5660300002)(2616005)(66946007)(956004)(66556008)(66476007)(8936002)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3503;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U72oIMA9aX8oL6U5HqRnUNmNKOR9NWMouTb/b2w+h8m0VG0voiWVY+gw7t+yvvleEhpcDm+ZUwvI672vdHttWUISV3f9DXFO1byt1ksSAwze8LvIQcPCuX/3GWTbAZKdqyEiTWERrTZkA4gu7XwLPpvydFdlwkAeEcpOZd8cNMsOHMsAmW+DPmCK0p8MuSbb9njuVzi3T596OwutfBRpKW7RCw0SgfJ+HsmP5ez1L4qZXmya+mPy5pdQSgyjM3dsqQbhKxUVkYOdd5EDdcGzvW4u6+wyzfAioyNu7z7+OKTUA0dBPfoEKXZZpS5iJeDXRYQR9LSX2i9+edteVnG2EyglCPRcOWxsNWFGHdquz5WI43qs3McoKAN9XbJGxaI7Vg7Jq4sx5Nc6yUu19SsCnU6HE2EiSSBkyHxPJkhDmkazVBRJOIiHafmhhxzCFkloMDbVo1WIp2PGSC3x+/NUtAZRB2evwsOU0oVz/Q/oUj0HKoZj9B64GRW4smjUiT4HUN+k/ta5svpT2EWd9nT7pg==
X-MS-Exchange-AntiSpam-MessageData: jYjRlqzoO3VCQjv/XQjVhAMCwd7ytDinUv6v23Tibm+Q9fDPgNG0DsGm2S8XUnEZmizysYiyklCK0EP2+Mr6sbIDhj/1DlyO4uRs6LU+KC4cBWTwafWa69RIQnzXMqA2kgDj00ZUH+1bT17ChxIjVQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf4c6c8-d84e-4037-5e74-08d7bb2fa174
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 02:49:14.5797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ1XSAMhzOOXz0gVqj0dG3v8cgpAIht1HH59IL6GwitLEzimRW4eAGR6+BnXOKkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3503
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.132
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

Alexander Bulekov (2):
  fuzz: fix typos in linker-script comments
  qtest: fix fuzzer-related 80-char limit violations

 qtest.c                       | 3 ++-
 tests/qtest/fuzz/fork_fuzz.ld | 4 ++--
 tests/qtest/fuzz/qos_fuzz.c   | 5 ++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

--=20
2.25.0


