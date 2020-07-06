Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751FFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E83D206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="8DCKW7yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E83D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXSp-00084X-Ga
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXS0-0007XS-Qk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:10:52 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com
 ([40.107.243.100]:43201 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXRy-0005jv-Kt
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6ovcfAChv9eL3eQgUoqegYyZD/FWEzpva0bx2E2H9yax5uMGxsVZNhBYWtvMQln0La77u05w3KlfE103VFHHsSvyqKy/o4e80rla8a8zTTeI0GGHDU0CFJwV34jPc3TfcKq1dQaJDZQpIZKtvjM0D2t4OB9+9dmg67YLmvphdLi4mFbeNMnoTFnnL8fPduzZoerRe80xxJN3OynXDFTUU1CLD/YFrtSQNRrN0SJ5UrPHUKp2c9eCPqMuJv8fOoTS50qHsTPRFKpdGnbhHqP0dkBlmuySYZXzdNSWFeuydW/BrB3WzMP1T4ZRW1YbJX926CPmr3as+shKoUBpuqTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxTxRILYLSpOC6sp78mT1IgiomL+3C4KxG+GUiH7Dpg=;
 b=b+opBFBQLuUhS1DCBqjXnW8CJ1mbFXlHUenZzu1cpWez00I/sMGvhltE2+tvIHRUyDLYwTfN2ZSJdj1fTMRvxHU1ctsuUq4pbXABuuuxqdpTZla2MHDkYZ7PPbEYouLZReHQD/uYN7JWoY5glkBgTdtb1w6jMD+9rWZJZeEdU6SzgnJ9rANFNNZNh1utGDC7uTi2njyNOe98+VqLUhO1E6Y/IE+Ox3CNusGjbWoHWd8+Y5SPR5/CcE24zTxiF6G4yodiAHRLO7O9bSPVMt27JkmbvXnfMhGfOd497xvpXZvWI13qGXmCKaZLKeIca3mC+vWfH4oIkyj3Ht7M69p0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxTxRILYLSpOC6sp78mT1IgiomL+3C4KxG+GUiH7Dpg=;
 b=8DCKW7yjUZTzIE58aaz4vJ8HzINUTNJCbgiR4/COlU9E1I/FmFBRZ32VySU6pIBQCQAYVVvhuueoU6gqo7/Mdticv94GTEUj2j0GKlbfLHMw2N9F7YbSVfAadHd+Mi9BDulqCCfOPeH3MzEuXLun6iHyYeU7j4XIYL3EpFPtg9U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 19:55:45 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:55:45 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] fuzz: misc patches
Date: Mon,  6 Jul 2020 15:55:30 -0400
Message-Id: <20200706195534.14962-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 19:55:44 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6410f5d7-555b-4c07-0fe2-08d821e69238
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3520FD129F44667522B7D79FBA690@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cwcjx8HljyQ2PkGbB5zZFqedF4M0F7eFhRcA7W43Z7pHCkUh+aNh8h+Pgi/x7AktzvMXR993NBJVWijRwN0TbMa1d9nTA56mzMp9+vFsVHbpOH1I84m+pLYuBahgQpXF51xwG1Z2r3/7n1ablzhiNMyOKMMUc+vJz6/kz31/iNuNOfKjcTls8nCocM5ijKzebcVR5JYqNlNn8L19Phy175fHHyqge6z3GoqDi21MZE6p36RI0diafmmieD0bardaAKJka5VYDSQbFq+hBNKdzd5ZRwgJdnNg3hIQaPhIF16UOpe4nXQ5QleEayq8B9pGYG3caWw5WXDJFJSK4bw3nc01aHHFI5eLVpnimM8s4kcpzQlv1ZgQsg/NFX+C+j33qCse4tMLbhw9Bzj+/ymXfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(4744005)(83380400001)(16526019)(26005)(8676002)(966005)(66476007)(66556008)(7696005)(4326008)(786003)(75432002)(478600001)(8936002)(66946007)(1076003)(36756003)(86362001)(52116002)(316002)(6666004)(2906002)(186003)(5660300002)(6916009)(6486002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WW+aeoWbHIVFq7qWnj3d+X9nEaNTmdanLzVbbhPjgJp2VsAWv5KHiW4FCze6v5FTWW+h93R3Bpyh/F0jb/6dxUD3EoQmt4HOJDPchnzwbRCyf8GkkkV0VySbZ0iBrZJnIwSWBhT3w8/Skf4LsIJJ3KrBQF4k2haSwtszN5PKlsMXZiSIM1JcK8UE6xiBBh5NnWs+mBABhGwaStNwcp7d7OdhaZ3SgUVvL+rt3r4v3cNpMa2d1Lt6t/ZsZMXKp1U53eB7p5uGMdtuRRY0JtgRFt9rVxPdwblNedJ8qIe9yya9ItIBsRdf1lYMDOrdD44EfHhrUN8sBWxbtctCnSfQ4z1+tC1rCGQ+aQJbPwsOLlf+6fDHbtTOnHoJ5u9bJx4sgV7rXWZnmncIIeL+UFbbhLd8vIaOmlT43W8vEiVkMEYPUoOt5c8utm9dGUmkNH6qzKYtO40nR+Ix0qj4WsIryyB/Eth0TPuJpGgiK+Z4vag=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6410f5d7-555b-4c07-0fe2-08d821e69238
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:55:45.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EguqVFeC0+W27YJSA1fziYnIEzDAsqPyJuKaIJZhmNGRvHtG1ng4cO7eUfWaTQda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3520
Received-SPF: pass client-ip=40.107.243.100; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 16:10:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
This removes ASan from the default build of the device fuzzer (it can be
enabled using --enable-sanitizers) and adds some content to the
documentation.

This set also contains a respin of this patch:
https://patchew.org/QEMU/20200524143738.23218-1-alxndr@bu.edu/

Thanks
-Alex

Alexander Bulekov (4):
  fuzz: build without AddressSanitizer, by default
  docs/fuzz: describe building fuzzers with enable-sanitizers
  docs/fuzz: add information about useful libFuzzer flags
  docs/fuzz: add instructions for generating a coverage report

 configure              | 10 +++----
 docs/devel/fuzzing.txt | 63 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.26.2


