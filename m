Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F181320720
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5oHmwYJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181320720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYC11-00019L-Vs
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYByG-0007d7-Jg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:44:21 -0400
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com
 ([40.107.237.132]:26273 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYByE-0006tS-Do
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QICKLWD4/GzN73tAybIBnO8X0TgRU2TfejRJ2S6O/wPL13GZd8WV2Ihq3nP0Ob/vUPxWkSbkxvN5Fst3Lz5WrJ2Ig3mwJEPs34quF3TYdW6aVuGAOGCiLgVgMvZ2TmJBP1hMAmAR5Uuv+HlmYUeLSEuznWOuEQNDAukq+syGTE37f/q5ND2+IVM8W8prB14KjfpULgQQe+mQehx9g4V04OMovT+Y92ALkV3cNzOu2H91rLFmpCQ9CY2XKGiuZWPwFFNSG1OmpiMsB57xmuEh00hIFOlCgW3aRQ8WLJSP+AfDOkRqj3wWPGjatf/qVkXnNbkKKKPQYSc9dsUvfPA0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C7/v6DnTuZbZM6uwKJ/JD0j9UdfEhjJHaYUF4Exc2s=;
 b=EwpHhWzIwI8O77CeTiXE+UeY8W/e/68S5uKiVCNt9xsBDx25Xf/1OivJTL3RIv3BSCNEqagTjfb173ivHipTekpbOPPep014G2Ak7n+cdYrzKYRB6S4HBWbwD9CEjzOlK44BY+pMBOg7oDBPUNJDODFAONmZvh8jBjBRWizc4cHF7dW8itAtEvikvOsyF8Br4Rf/6o06He3W+da0WiDpzI6s4tU9BdYZzDLXdPsVtIop5v01xIwF2uqaUv70cNDGhmFe148DMtvVCOnleZ1VT147+wkWuASWyCpPJpVOrZ5HnvgkEe8vPsiAZQhOmxcYHTJ+Pu/xDpgf6w/BTt2lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C7/v6DnTuZbZM6uwKJ/JD0j9UdfEhjJHaYUF4Exc2s=;
 b=5oHmwYJz5QFWnjeQad+TvKfFPm95Uq+scOvV1Q81az4f6NUxArCgj15JpCFQbrtjb09ttnQdcUasvdukikpnBMDEfvibiPa2uJ4eGiwWS8xfZ00cHb5IyBU+bDZdYkEOQ2A2WogCP8a8ZK2b5BGqmBRLkFYmFdh+LaV6aL4/qSI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 17:29:14 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:29:14 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/3] Bug-fixes for the generic-fuzzer
Date: Thu, 29 Oct 2020 13:28:57 -0400
Message-Id: <20201029172901.534442-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:29:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 466184d2-0fba-4261-f48a-08d87c302799
X-MS-TrafficTypeDiagnostic: SA0PR03MB5531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB553125F602EE56499966B7E2BA140@SA0PR03MB5531.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NuBFZ0q44C7j1ZP9/kTrAZbnCFkTkANwgP7ukGHGdEJllF1ECPXvDBOYlH5nJmuGQ3HHJaUXPuQBvN9DcFOz9hS27s5SlAbcMneIoh2F1Te4Ao6U0cPbo+5VcQw3X0YKE2mLotk2jZGNEC0BzOcxmNnUzAD6JyeBpoF7rQWssWWaU7n7TeAfWf3Pg6IbFAyq/YLPLEPhddhrKjgP+dfmy0iAx0Od3ysO8mk0z2Epgr4k94W2ejLEWtGHGWKq87G7pdVnex8p5Zz9iexIi5LzudLjdZWEfOmnQUh/6OvlbbYbSXyTwKYPQIKlmGNqOSnKxGsKBc9WxqIDkZC97isNmN3gf0nOP3NKfAXpHu+Yl5liJr9RHSi1QG6Ru5P1JYZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(1076003)(2616005)(6916009)(956004)(86362001)(786003)(316002)(83380400001)(6512007)(36756003)(8676002)(26005)(8936002)(2906002)(4326008)(6506007)(186003)(478600001)(16526019)(52116002)(6486002)(4744005)(66946007)(66476007)(66556008)(75432002)(6666004)(5660300002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O83sA3HgOs3wj1k29Szj6cU55yBFRmvufiwEr2wLu0DZEs8cMTcRiY9Syt5J+ufYSTLXIraRW3kQv+dSRPX914ouoAzKr+nlIKgnLmtfIz3afVMlysQIKOOxB6GvKMytg5/HkiPJADevtcZpDi+sAtjFDlMVxt8Kf8jY9C5b04kCuamQb1HmZtyUUXemLGHc85vqab/bskM8F/rxvgq+7OwY3TEzOMzfcOa2XbvBBklwW7BQRiKCMSxq511aw/qqDeqZMXyNDjiNzScHqqIra+rkwcMy6KJipjSJJ0uCCaOc6VEuqQszbJ1WTM4w8NIBmHmfUP3AJg0uCRydCiAU3MJdflS9nJMz4UnUojetVXvbHzZ25BxMRMpiov3Ik6dbjpSJcYCAMyeqVKcXLrzR+Mw1TQXcpx3o1BBYkuQtcnjxo8335HfD1kXjdqjSw0XBuI9CghNf/IVsa7j6DRtg5L4Lv9490wufhb4HTLhw6q0VrZPgWGkh8Z3GsPuyrG2SjCU8d5LDwuKvVRNr8mU+Zl4ZQSjPWGAQU/cvpEtBBpl2vi3HOBBfaAZh3PkXWFRE2sYXwLgsx+Oe8a0poqqxlBgI6AB9EgEfVDl6r+hQP/NApHyxJHfLWytPNkEcSQw3NSE/AlqWU09kA/v0mQ+UJw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 466184d2-0fba-4261-f48a-08d87c302799
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:29:14.1078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wpa/upbIc6mtYZjjrhhFlG4B29De5rwtWmnSWK7jSr+fuoLAeKe/I+m9wm3VxQGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5531
Received-SPF: pass client-ip=40.107.237.132; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:44:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.021,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches fix some silly issues I found after the generic-fuzzer
started running on OSS-Fuzz.

Alexander Bulekov (3):
  fuzz: fix writing DMA patterns
  fuzz: check the MR in the DMA callback
  fuzz: fuzz offsets within pio/mmio regions

 tests/qtest/fuzz/generic_fuzz.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.28.0


