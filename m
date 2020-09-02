Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0279C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7299620773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="j0LekTG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7299620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTm4-0004qg-LL
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjx-0001AG-3Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:57 -0400
Received: from mail-dm6nam12on2106.outbound.protection.outlook.com
 ([40.107.243.106]:47968 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjK-0001T7-12
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEOikWnyr1dGjAWzzlG00A0p89P3gL9GipxEAvzqMNewjYsgOfBObgNTwpmtUo6UvPOO+XBVIeUkIxKqr7ALLsfF282Sn2qvBzBQm9bBZ6QA0MUEnscLHH3dW5oRYCajzOS43A6Cdr10YhB1nHNx4LgTf9C5CyhIfMPIWqFj5c1JNsUu2CoMgPU6z3ZtheDNl+9/aWTW/9er9T+3PBqi54t0qjLKJINzmCRnipSfB53TJY4TiPE7RGQLkYVYCU+ScMmGrRL+/fD7oGTsLSYTr1VutG9dwlX5M7LW84x403t2qd22a+BLj6koXIi4xtyuoIUNfPZYrgSlZGsOCOlNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yuXIvTpUlAm89vyF17NRrJ+nFPia9zRQ5WNbED8eTI=;
 b=AhmdmurG8Zd497Z8lgsGJV38bXN4nKALCxcaBbxQ2/cs5Z3TjEgM3ed7/IQB8+jVDDJ/m+vDPovPclorpWqNV2JF1wnt/suLFBmtu5pkAF53ATpRihLY2tKhS4oK9zzqIkIdYoiBEL3JTEIyrvwPLdHeumu1ghdEcG5mPcugpVv4/wPwU17uk5ww00j6kqDCBCLJtoDG/ARqRRHHrTuH31t9FHAV6Q5KChzyoA6jo8Sx4mf3ET+JLBz7o95KjCu+fOiSQH3cy8ledqWpzPtzDHwamSpG2h/NDecfHi7Q4mrk6QC0MUO5QLFpctEYqkIyT7RRRJUeCfUJUD4NS8ouVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yuXIvTpUlAm89vyF17NRrJ+nFPia9zRQ5WNbED8eTI=;
 b=j0LekTG6sqQQUgXRW4gr7PiQd/OsqmAVCdRyMryzafvX80qdCL2ccJl5I4d2bguBdDmT5rDlr08MdDJwr3TWxyBXFjQQEmP5rYSj96Se1FtwaLQfkrWcfa1NKWckvPu8kp6tAfm7kKopmcLUokTQp0QLIar4rA1BFauVlYVXw2E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:27:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:27:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix oss-fuzz builds post-meson integration
Date: Wed,  2 Sep 2020 10:26:55 -0400
Message-Id: <20200902142657.112879-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:208:e8::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 14:27:14 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660d3e87-ca00-492d-c1dd-08d84f4c49ee
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB546571A2DB609B56711F035BBA2F0@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJqQXATL0TzdHBAPIaHqXeBFxOmgRBVTmMuE5+Ugu6Jwk3n3Nl1CkfS7BczYyDiPEcZQxQyyGM7JnrcHXZ0hn4LswXbA4lq0L/VgbOd0bzua9xGFoRsQl9MJOIeEspTIGaLVahHtM2Q6L60IYHmQ0+n07bwkn6XcL1qiUv0OhNHP+Rsv5vhST6PXtteuPpmBsrSQcECzdmAzrmG/G60L88vXCS6sDbmqyu2VYRic33NiyDnkduvWsJlOeyjWAPW2MNy1senbkamlsPjbJ/DEx3HolxP8T1eXZPWRu5uTOZQYTetbK2DEw9l6hooazBkT/7Q7AB/Q9zTJuRRt/+NP977cYKMPmVib4PzGTDth5RJWr0s3Ju+OmdXr+7XcrH1qo+pw0rzXyIPZWqW+kXiMsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(1076003)(8676002)(4744005)(66946007)(6916009)(66476007)(66556008)(52116002)(6666004)(86362001)(4326008)(75432002)(5660300002)(6486002)(478600001)(83380400001)(8936002)(316002)(956004)(2616005)(786003)(36756003)(186003)(2906002)(83080400001)(16576012)(966005)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fEuujcty5KWJV0Ne6IT0A6UHUmuzWM5/5aPA82EML9QM/KC+u0Fgm51FFxGrGdVFh06RTDsXXu4hxEYIf4DQrrhW7qSKsqLTRnkXSXOfCG+5hMNxZWeJqc0GOLX+fer2BEUj+gAuZfhlGJhnwNu2DEWp5sOWHE0EldRWWNmZLZ95ibcLkenXshqcFgHi/sKL8f3JQaKvqHLmQwczuVSg1BTS0FUHcywUB2dKZ4abMxVTbKPjo0sizWtCQ0BBJ7ca8M5UHVyqHgrJw5epEnBqFvmdnBvP87B3R/MkobVivNHACoasPCMvHVrQaL6FtPKyM7JWhTrR/v/d3G9K4SdOCvTpvzqPIyb1d/qP0H2j4XDB3KsJznoJPAuuLTyd7yj1MCB8mFNU1cbcqBxt5Lkk13INqY9P8/JGtbmi/OevKAn9PJ2DfxOsF1lXsGpg9v3XcR662jUYq/eRYE5qwvMyAG+No4eFIM9aYytX30yuRT5c4yIdHJNC8AEK5lo7zM6QnxhDtF0AbpV/J9rI85WwA6uclCitokvPX9B7yMU13uvHheqPvaQNjkumgm3JA1QVqgoHz9FPdZr0rKqpDWgch0UpfVoPlYvnb2p+UU/h58+q+XrZjdrifTymyAQQxVFXYe7ZxRcTPntCn+4E/bCqUw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 660d3e87-ca00-492d-c1dd-08d84f4c49ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:27:15.2975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF7G0XCbFQ7N6Dr8uiLNSO1n1t3wqdBHKC9CQyjH5/Mh9KjINeHlO3ekkxN0ycXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.243.106; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:27:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: bonzini@redhat.com, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU stopped building on oss-fuzz, after the meson integration, due to
some linking issues:

https://oss-fuzz-build-logs.storage.googleapis.com/log-3eaddfbd-7e05-4ddd-9d86-ee4b16c0fac6.txt

Those problems should be partially fixed by:

Depends-on: meson: fix libqos linking
(https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00802.html)

These patches:
1. Build on the above patch to fix the way we specify the linker script,
   to ensure that it is not specified within start-group/end-group linker
   pairs
2. Add support for running --enable-fuzzing with a custom LIB_FUZZING_ENGINE
3. Fix a problem with how we specify custom rpath in the oss-fuzz
   build-script

Alexander Bulekov (2):
  fuzz: Add support for custom fuzzing library
  scripts/oss-fuzz/build.sh: fix rpath

 configure                    | 12 ++++++++++--
 scripts/oss-fuzz/build.sh    |  2 +-
 tests/qtest/fuzz/meson.build |  4 ++--
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.28.0


