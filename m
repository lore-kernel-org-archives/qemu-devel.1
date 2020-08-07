Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8D6221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wETFiXxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8D6221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45Xm-0005Ee-Nb
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45X3-0004oJ-SV
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:47:49 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com
 ([40.107.94.53]:17249 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45X1-00040q-IL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2Eq86l8HHrzjD0Gf8wdD9eFmzK+u75Zr9/4+p9E+Knmg45PGocg4WGmG6TWGJtFEpLJ5/VLyWUPCpdjdv4hR9KXqdRAyDi55ipDKgS/K28LDeQ54cYg56Zflaq/Kr+1nsUGBCw+r8Qof7NBYEroqhplljYpUE/JxJD6BDhjN7AKIQRY7uHMY14FJAHZZmkHqQUsSrQoMy4hJZbFbt1jpsltCqTdnLNXsi0xQeN0YEA7Zin7Lk3r1+6Iip7RtZs8u49TomxsnFn0lYFYuWSDmdZUoHFuhYV6c3hxEYEdV8yYqFqRERSeM7NqXQmfMiZDxNekKbprn8KqhymJwgiJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8p8fT3j5IPakmS3GQJLOUHD2CXbYu4YinfebQnlSQo=;
 b=L/rBBdC8kOz+ynlVWR+MDl5/quR9GnNJgpdsRPLoTdBa5Bo0GJRisD5Yrcei/FNp2B1Zq5iOsnidFHSNicqnPF7Lq88BG/3xTXaCHlZXdIbXWHPyeRy9sW9xVz78fM9CnCEwHl+iNBvPov84HoBuwB3U5iOL9mqE1AtTuepKN7RDlXMFYvCYdhrmEBzH1oKqlI/bLn5Kg/zFHmQ4cOXTG6hOHbi3t6N/x57g6ldQuU556wcvjA81CJbdgBilaPn32W2d0cNmSEfz7ZbrpV8HPHShnsSXKdQCZCYQThzwlLnbKLXUY2grvbIRniqqXZUQObs0k7fMS/QyZg48YX3H3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8p8fT3j5IPakmS3GQJLOUHD2CXbYu4YinfebQnlSQo=;
 b=wETFiXxoOtyIgiUIU1neEv/+7T5oMgG09YXBOZM6RYuXkrVDweQuixjkf7LYLFANHeTArW2B2mFdsqMc9T6NsUS+jEX8ff2IvhfTPsSZG6Sq5zoOJGhOAbqfgF7hFC2pb1dbn1LqUMXNJlFsIBsE0wsztaWw8IFdWsPpdWDPNrg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 16:32:40 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 16:32:40 +0000
Subject: [PATCH v3 0/3] Fix couple of issues with AMD topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 07 Aug 2020 11:32:38 -0500
Message-ID: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0501CA0056.namprd05.prod.outlook.com (2603:10b6:803:41::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.6 via Frontend
 Transport; Fri, 7 Aug 2020 16:32:39 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa7e5042-e56e-45b8-0560-08d83aef807c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44147B4881A9222CD4E4A00295490@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVnRoMyd7PtDvJmqFqL18rcHsmJqjZf2aOPjwCFpK9CW/UAwnJTlI2cK71pk+mzH58XXw6SA+w12C4ickgxgS0hVU3lfYzxAKND5oaoy4Un86R13S6LOFf5dKj6MzXjd2CUFFoToCMuyrxQKgrFsgn+Oz/ArXB4vqUmzJfZ2yz3e1sfLu8YxGjNcxy0kUG30Nlz5p7agLJUvhcseNePdLnV5RHoqhiHDw0qn2SeKYIxKY7gu4gq/hZ1c3HFU9LHR2TKQM/o40vutQaHLit9pVyuryLwrYyo7TZMaAlrzDSEPhenu5B3Htpe6J+zA+aAboqQFVDQ9saS5KiBvhekBXVEYi1f6a3YZcOlv5tReSjumDxTKgzutS/6yaAS6b7EFb1v1sB1AiFJmsOvmdymQqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(66476007)(66556008)(103116003)(66946007)(8936002)(316002)(966005)(8676002)(186003)(478600001)(16526019)(86362001)(956004)(83380400001)(7696005)(52116002)(2906002)(5660300002)(44832011)(26005)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PNAUPk6vMuvMokP/s3V7b1bV2SWqz4RgO6srmysAnFMUP2Qhz9OxYAkZ3BspPHHbiLGSVkBQ7cxVtpFodwmxTQcMFU1B32rPx12pj4E81KyaR1+4XoPOcL0+uBEk4uJ2t5FQe5xJU+i2MTTiGNxc16aq023oUswC7zbySexkmZmKQrdZEq9jOOWU7djpvhnKKXKIOaISIT501zs/FbIPA+bIKKqya35xUT+lNcgjHI63evjo+aMvNWvh2SlXVO7brdVtexlHa620UyMEEBtkJOKyreOKG1rvDbHgk6g3+B+aouo9bY/0olXNcWUER98iifWvwOUnuvGzsDY8Fux2N7HHBInEaVHKrGydBd8uu5X0Royh9zQMMOdi6gvwN0U9gj1d1p3M0cu6znz2VfZ2MtM2VPF1r9u0OOqZpWUPl3tlS/Imeo//pJXyHJWjsmikuQoCn4YckwvwXSecU1aXdQDbrB9cMJNT8LcIxd3tkMwAlgtqjtjuqno0aVjSRf9IbHbJjKxGHQ/CKUsKYQxmvojbyIWG3aVqpBFHERBPKS+vJFQLD/CYIhQo0NNnQUBXVpTkd22aFbLDMofNU0RCfB/fRmMimN4RzG6CuSrAWWXvi/RqFTudoR0i7tjwFoIJn5OqUZIllPi/t3trUOfrHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7e5042-e56e-45b8-0560-08d83aef807c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:32:40.1390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt8gEval37FfPcwy3pEyClmwoCCZxLy6DfDD4J4WLPqoj3f/Q5sy/44k5XSXUqSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Received-SPF: none client-ip=40.107.94.53; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 12:47:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes couple of issues with recent topology related code.
1. Warn users to pass the dies information if EPYC cpu is numa configured.

2. Remove the node_id references in topology and use die_id instead.

3. With node_id removed in topology the uninitialized memory issue 
   with -device and CPU hotplug will be fixed.
   Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750

---
v3:
  Added a new check to pass the dies for EPYC numa configuration.
  Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
  Dropped the patch to build the topology from CpuInstanceProperties.
  TODO: Not sure if we still need the Autonuma changes Igor mentioned.
  Needs more clarity on that.

v2:
   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
 - Used the numa information from CpuInstanceProperties for building
   the apic_id suggested by Igor.
 - Also did some minor code re-aarangement to take care of changes.
 - Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
   it later.

v1:
 https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com

Babu Moger (3):
      i386: Simplify CPUID_8000_001E for AMD
      hw/i386: Add a new check to configure smp dies for EPYC
      hw/i386: Remove node_id, nr_nodes and nodes_per_pkg from topology


 hw/i386/pc.c               |    1 -
 hw/i386/x86.c              |    8 ++++
 include/hw/i386/topology.h |   40 +++++---------------
 target/i386/cpu.c          |   86 +++++++++++++++++++-------------------------
 target/i386/cpu.h          |    1 -
 5 files changed, 54 insertions(+), 82 deletions(-)

--

