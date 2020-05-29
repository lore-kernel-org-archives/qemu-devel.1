Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED56C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7CC2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="D6XzUF4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7CC2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejM8-000524-Jp
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKw-000461-JC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:30 -0400
Received: from mail-bn7nam10on2138.outbound.protection.outlook.com
 ([40.107.92.138]:39969 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKu-00068r-VE
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmiQrJ+rQmSNl52Xf7m+P2SAeX4/gZOosiccX2J35F2W0Wsp8mx5k/xo/pw6DAX/H3YjhVGX0FSwomJ9nsO0iZHbWrj/+ykhr08UUqEoBKSafCg+jvOQikoxOwcAwQk51mum7y+OY9AkfMa22bkLhNhT7+5cJp7ih20GOEnsWQ4BU0zaCzMCZgcQZFn4OTpY4UW/52kUVRm30VTsNzqi+JNLEfrVEfm+zlpVhS98HJUAemJLRElE481d572MnB0HkCcET4mt65D7rofmZk1EzOJsR+sHAtzxnNHEOdQckXAo446ejS7SQnv11PTpLWy3IlIC/ZoOzYSCDWWQwp0QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+a2IEywwjy5JBRUa0DLU/C+DGPibQoXR4xpUVfQ9Ks=;
 b=dgBK0UsnN3Z9CpgFxJR5IWMUdvmqC1t5D8NxDHHOPF/6e4XClM8IgSuCuFEshR5e1rt9d5iJ3q+PoVz2h3tBQTif14eF0LrQjw2oOsDFq4BNwBE3+24bPobJbcGOlKxy5dsuCb/iZ0KKO8KGMQ1VGs5gOUcpYAt2diBQ+Doaqs6NNaby9p7mJG80sYwsiMvc5CTHisl7lLR5tpuSWcs+oAFC+ZGMT7kEl4E0dS6vTmf4jPImV9U28yxmzd/f4o7vDveS7voBhGj638z5m2tNZwZhWZYO6t8k6OPATY90y7Rx42EkHMs+4tp6cMCKqjdHAbjy33NvP5jR1YIBRrCTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+a2IEywwjy5JBRUa0DLU/C+DGPibQoXR4xpUVfQ9Ks=;
 b=D6XzUF4Wv6peRXraYDR47MZysQdGYl8k6zWK5G/YkJchJqrVBOAF5rJchiCZVE0i8TcWKZMsGiQrUjJp/3BJnzeTjLwGnjmTPBQ1KUD/EFAH0YR5p9nJ1D/rCZ/OFlkUJbeVLqGrekhwZz9ZJeKnK15ledkvTYONqaTkLG5hkRw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4096.namprd03.prod.outlook.com (2603:10b6:805:ba::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 29 May
 2020 18:02:26 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:02:26 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] fuzz: Skip QTest serialization
Date: Fri, 29 May 2020 14:02:08 -0400
Message-Id: <20200529180210.28120-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend
 Transport; Fri, 29 May 2020 18:02:25 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09fe8e90-be76-483b-5713-08d803fa71da
X-MS-TrafficTypeDiagnostic: SN6PR03MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4096F6005A5571C124DD1646BA8F0@SN6PR03MB4096.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJYlJhKnZJmfcU9EQn8USXIkPmNk1FUPxvDX0auXLcGZjEmnDJHc58TpeeaqGoxANH3HUa5az90M8g24VTo3vfvZ4XHtFRuvwFoX+7eTsk0DyT/ET21J9wtRn2oPBXRBrtmywqOJwjP5ZhmfgdqLViL8xdMGuOGlfqeJPdAIJ+5U80Jl5m50dawFmcOD/YvokxBNDPDsaU48P6gl/rO4auB8/gBuwE+Dpb1LKFIwk4FQm9Q3T20mf0c17DUViIOeK9qBkkkqbR+g/39MUJkAnPQ+4yZSCzRNYsXZN5sZ9yUEgSlW9Mp6wHzTo8sCzFPj5del+EW+0NXw68d9QtSM07q+LV9cSMMKfFbwcgHUbWZpFhrjW9WgWRO6aMLqw9rd4R9XPxpQyXPtDQVNUFRxJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(8676002)(4326008)(6486002)(786003)(956004)(8936002)(6916009)(7696005)(186003)(26005)(52116002)(478600001)(83380400001)(16526019)(316002)(2616005)(66946007)(36756003)(66556008)(1076003)(66476007)(966005)(4744005)(6666004)(86362001)(5660300002)(2906002)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: X24vUgJzfCrCRBXQHXoHVjsQV7JqnpYDDadAmevqgTMHdIpVRwuNwAIFkuWIz2e37YfXK5esd3ZWhSlcSpqHTwntJa6tV7zYsnEo4bbN8fa1U1DjcWURzzKPizEAwHV369mJ00SK3Dz7UNmflYJyd2ZBgL6u+2Qctlak6M11RAkxYNiy+htmdb5hlcxXKnZd2NJvD2xY7BTslTWXfpptTXNKYOzcTpsZ9xfWlMF2lBlXIdphRRL+cg/nx0T8fq0QVqH1v0x8fcHyiGELLsGrrR0YBGwD5cA5zFo3zqeL+1I8NOggCQj78ON0jKM9hOST6AjwRPrn/R4OsTW2GF2ucVTokH6wcrPsOCNnHJaUi/UV4iEazeTr4RXPVIkbsyu5MUqbAHQw1xN060Cr8WHV5gW1HnsNa7KB4WbXvsSmPer2NIR19C1Hf6IiFDUhM2hqZDvDY0VY0r5iWvekRSC+7xVtgkf2lU6xgGcJifThEWU=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fe8e90-be76-483b-5713-08d803fa71da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:02:26.1875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5SlACm4IzCEJxWloZ33vyiE+h1hu5MgEEcNbcDNNX5UfnOe70thbR6PKLGnalLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4096
Received-SPF: pass client-ip=40.107.92.138; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 14:02:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the same vein as Philippe's patch:

https://patchew.org/QEMU/20200528165303.1877-1-f4bug@amsat.org/

This uses linker trickery to wrap calls to libqtest functions and
directly call the corresponding read/write functions, rather than
relying on the ASCII-serialized QTest protocol.

v2: applies properly

Alexander Bulekov (2):
  fuzz: skip QTest serialization
  fuzz: Add support for logging QTest commands

 tests/qtest/fuzz/Makefile.include | 21 +++++++++++++++++++++
 tests/qtest/fuzz/fuzz.c           | 22 +++++++++++++++++++++-
 tests/qtest/fuzz/fuzz.h           |  3 +++
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.26.2


