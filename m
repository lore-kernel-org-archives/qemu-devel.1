Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1860BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25E52075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="wWy1qIdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25E52075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGSJ-0002kp-3h
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 02:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGRg-0002EF-K8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:12:12 -0400
Received: from mail-dm6nam12on2106.outbound.protection.outlook.com
 ([40.107.243.106]:37728 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGRe-0005AE-Vt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbiXm8THk6NBklrFnDl0pG0Ab1zFQpAs2q1pOnzcOya60DWXfuOYFR437ty4HGISh/i18c+oN7t0chxMZqSc6qITE3yiR0epWfrbERU1GIgektf03DpT84gSQ4fXN74x0BaM/x7Os4iE3uUhHXKN20w2HOr1jAtbyHBhtZY+3IMLwzZm6gcwLe8TAxwgKEuon2cwN62+PaSMYGM/CtVs1CDHgEOO6/AorJx3mAGxpmlpGY4Wo4+Rpzv+rosvnEgcvd6hc6Jd662E5g7nVFnMSLhy1kpUmQHsP7irK9nRmgPfQpQhFWLV1JoZgOps45EjtJBO2JUNKrygnGXgkvj0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC5O+3zzBr0jRDhfzpv5PVf85FAIuzlp1EmY8JN6fmE=;
 b=UK3C6hOVS/YGtRgR1IvgIr0Bft2+AR1G9pfF3fTOHFjPCuiF7K1914sS+29iBHhXL0c5qVw5hBZ7lkQ3ZUFWKDodqDLHU75nnc6UxevyNJJbYDIZAiMEDnjrzL51kCUvvqLkjP/7yX9+OLGTf89CVuQz5taNPsn30k8G2w7y/Ph93g+pgdOUnpmPJDuIKYBbnoSS0clv4NwJvgWw20OIWHDF0lMl4qaJH0bOQDJHnttM0tTpA641RaIQIeC55s3VF8J2ANXJXmmOZ8Ks1weNYJKXojUzmXT2/i4mLIAm2VL6NbWWIPp/lXhqfxdP6vRWsHlqOyoCN1d6/ldgvBWW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC5O+3zzBr0jRDhfzpv5PVf85FAIuzlp1EmY8JN6fmE=;
 b=wWy1qIdkcnWGmrcDygW65Z6CwewuoRHiXaIqS3UwREgr4Iy56pW1h2LzBj2Uom3YQzQ7OFOhceMIA6epsL+hncorksEx5PHTVXUbv2H2knqsFaZaQmwlfrGiwjCIu1OQbP94gCBS88kn6+iVenyGN25YdNYF5aAaxA/lqINV+N0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4173.namprd03.prod.outlook.com (2603:10b6:805:c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 05:57:06 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 05:57:06 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] fuzz: add generic fuzzer
Date: Thu, 11 Jun 2020 01:56:48 -0400
Message-Id: <20200611055651.13784-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 05:57:05 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf88306f-564e-486d-c6f9-08d80dcc4567
X-MS-TrafficTypeDiagnostic: SN6PR03MB4173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB417388D39E3B595F29F2D3F8BA800@SN6PR03MB4173.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soSVotES1xN/oWzuRwogapj219ZTj+5gAkf3DlG/GItplwvEwtqXbyDcjXi6ZsCttuKTl44W7nitLmAWVFbJJKZ/c7bS+KMQbcsH2lbU3w4qm4HB3jRMHePPX3h2pxanJHP/gQ9gXknZuK10pNnx1yAGlv1hZ3nU1NSvFm2hOmqBGa3L8JW0rg/LbV8cGgo7TVgGHU6UnE29e30yqcPTIoNX0RoyHSo8w+QLGakvY77+ORqcQQd7CCDFq+5/EgWFKvcCxLKaOKsS5UDEEb+yrRZaHiWc6QtYwK33yGU9qgTz4J2df54S+1kTv1uGRJuFpWGJtdtm6gMioSIhNiKCXMOOb5tVXyteQz4Qx1KEhc4f+0unPNRRuZ0ri7DD9cqp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(786003)(478600001)(26005)(316002)(6916009)(186003)(66476007)(7696005)(4326008)(16526019)(8936002)(66946007)(66556008)(8676002)(5660300002)(52116002)(36756003)(2906002)(86362001)(83380400001)(6666004)(2616005)(956004)(6486002)(75432002)(1076003)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RrwfTCnIEOG7K0ZChpzSiUZJAXcM+ia5HOoCxhiJr4t1GsFNKmxd3B7JX/73u53ncOkTvAbgg2mH0mjYXalfA7hFQUg7ietvzHnzIhspAoNfMxunhreI9oTRqwr9k9uhXlvx7BG/4KW5sVtUwwm/xjQg51kcrRxqeCjb7s+cHJ8RCp9LP9k0SBohAsoSG4cBIa9vZ/g43Lxz4jweYHZWVck30NdUfl6IF3ffeZvDxAJjotc4IRa7Soa/TX1Q1ROaUBDSu5kSntUE/A95CngDkiLAtcn2w7zNOXPiXOhXxCMhKtGY1U0NSdee2T97Irgw7wLBJyf/X8di/tk/Pl0rR34W91bK0kRdWH3m4XeYJ49uqImJcEwx13obqO7N5oE1wnWx7LBNk6G7L3odd9EcVACEXYRmCi/B987PIAdFiKaRMj4od5YrZMq4Lzl1BqAxBv9vUfBQuxNSAmGTNPTmf1cL+FLnp2GGD+x+r35Xpu0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf88306f-564e-486d-c6f9-08d80dcc4567
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 05:57:06.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmOAOn/hiDjXesY37v7k0HyO0FUvJgQghGfQraHrIqrF9f4Hyvf679lMGUecbNEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4173
Received-SPF: pass client-ip=40.107.243.106; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 02:12:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

These patches add a generic fuzzer for virtual devices. This should
allow us to fuzz devices that accept inputs over MMIO, PIO and DMA
without any device-specific code.

Example:
QEMU_FUZZ_ARGS="-device virtio-net" \
FUZZ_REGION_WHITELIST="virtio pci-" \
./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-enum-fuzz

The above command will add a virtio-net device to the QEMU arguments and
restrict the fuzzer to only interact with MMIO and PIO regions with
names that contain "virtio" or "pci-". I find these names using the info
mtree monitor command. 

Basically, the fuzzer splits the input into a series of commands, such
as mmio_write, pio_write, etc. Additionally, these patches add "hooks"
to functions that are typically used by virtual-devices to read from RAM
(DMA). These hooks attempt to populate these DMA regions with fuzzed
data, just in time.  There are some differences from my reference code
that seem to result in performance issues that I am still trying to iron
out. I also need to figure out how to add the DMA "hooks" in a neat way.
Maybe I can use -Wl,--wrap for this. I appreciate any feedback.

Alexander Bulekov (3):
  fuzz: add a general fuzzer for any qemu arguments
  fuzz: add support for fuzzing DMA regions
  fuzz: Add callbacks for dma-access functions

 exec.c                                |  17 +-
 include/exec/memory.h                 |   8 +
 include/exec/memory_ldst_cached.inc.h |   9 +
 include/sysemu/dma.h                  |   5 +-
 memory_ldst.inc.c                     |  12 +
 tests/qtest/fuzz/Makefile.include     |   1 +
 tests/qtest/fuzz/general_fuzz.c       | 556 ++++++++++++++++++++++++++
 7 files changed, 606 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

-- 
2.26.2


