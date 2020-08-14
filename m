Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5CDC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4085B2310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UX7YxEMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085B2310F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xup-0008Em-9v
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xpc-00016a-7F
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:10:56 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80]:11076 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xpZ-0000DK-7j
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/BpNEjdXSySWu7SbrgOBHbx6pPLDJHbP2Sje3HlSVlnsd7bQ6slrCUI2rYtEWExu3YR15la66ZvBe2IFUlSVUKjAPIxEZm+VHa7jW4F6MZGF8kgf0n6PWiFB3nxZLw7g/2wdh5RhBdazS8A6ljVeAeuHFY9aiMNarQ3ZErYWHcPdQp2WIgPpRFODQsLHK3gwU8irlRIbFtO4V3kCJiQpdi77jya5dSk2T+bcOjYA9mShQZyq+xHPv9ybEZP9er1QiEPZJW8iyPCoq97QbkJoQMQEKocfR0HdDzQgKaCVHtthUME2HkXzj7wlrCmbQzbdgxZ+LVHldENXeRz03vz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSD9XM51GzxBaKjYQ8JGbSN9XEQPdLjYWFOoJv69et0=;
 b=Mf/mp0Jyrx/OmKZiMAzx7BZMt3jK+AvWoGxcsGRZovRxWIMiH4jPCxBqfDULwBQUEJCZNEdqcKYAjXQqQTgrvJioBokh1fer/Tvd/6D3CDyoA6SAh9eo17LusIB6z6pu8BfW92Fw6x8L3lnoAL+z1DJLf867FaBVWdk1e1vRHgeqLyns+11km8Akk8zlOzj3/xNdFCod6jMFoUNIm+6m7LES3wb/tHxW9K2NZRTSiBQqCMwGV2vOJsnYQCIftZlu2YAaQUsroXdN0Sz2lN5vIy+2mCE/F1ipbkr8fBzjFbAppkqLy6l1E3YdovFNuZ539WXH0ljL7zSdpMQbYqn/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSD9XM51GzxBaKjYQ8JGbSN9XEQPdLjYWFOoJv69et0=;
 b=UX7YxEMj73zoQcEX4cUltYiUsCUauzkprnAKS6gxUD+QABOYSE6rxZinjZiXOEhavplH7jYKsBsEFHGTC9g24ZVFrfeTHgzSH4aepWTxKeu+yeLoTWtipZZsBz6oYS35QJRq6WzSlDJV5SIUy5HbdJaB+P+EuffEr6GzR7TMVQ4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 21:39:22 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.026; Fri, 14 Aug 2020
 21:39:22 +0000
Subject: [PATCH v4 0/3] Modify AMD topology to use socket/dies/core/thread
 model
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 14 Aug 2020 16:39:21 -0500
Message-ID: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0201CA0057.namprd02.prod.outlook.com (2603:10b6:803:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Fri, 14 Aug 2020 21:39:21 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03531a0a-9edb-4129-5e1d-08d8409a81f4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB452829334060DF2061A84E2F95400@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0bjCpq2eVE4lyshrXB15YXNgn5/zPhoLMDfy4mVV6y3wVIVIKZyIRFCDcK0OJLNaznhX/OVSgAIjrTozEVp+Gws7NIajZoym1HnbYNPUoOourX9tfwiiNsyb0mYQ6S5JiiHSYMyAZsa+LOWMm6qE4lhAkXTJWFjgiD6y3QK8jIFOIyn3fTWK2TGgAu9kKzSeaTayPVp/ujknhRX7dryKEGrcpmHzt1XJhuN4a/4H3aI8vJah+XjPYZ/o/CSwH7TVmR9x3e1Iseh6XIXfl9RQ6hojtPAQOlYFruB43I/5Zu9jQdgLsJ0r4/XjkF5LW0NkzJ87nMD9Hj5XQ63yat6RFvcLFcKP0Eyb4pp1V07gL99lmVcWHG77UzBQ2MUEthwzZoYu3jdgCiTGoQhizA+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(956004)(186003)(16526019)(26005)(316002)(478600001)(966005)(8936002)(8676002)(2906002)(86362001)(44832011)(4326008)(52116002)(7696005)(55016002)(83380400001)(5660300002)(66556008)(66476007)(103116003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AeV+T8GYDfe62R8DLkOwo+JtLJkFXbeFRRU7Wq61Jm4Nt23eeRnSUXNh9WgN84vbPNrcM2MIddOJSm0kLnc+9XqPdYhh4LNHdWZlHr3UXrHlO9DWhgDoPTs14sybc1m2sFwBuZJq30DltpUkgdKI62qlycP5eNa1PO6Orj/y1nHX1BWLwl4AzbTFyQKzsQ87DiKyrapdDboqkMwXOvCPtN32IEnzz22UCC45xrvRgqHN531uArZfJ+gEiObgy/XZXwfzYsE9bb1q50bNHrN2IQNe/IocFCXl/O8d08PUo0Reba2CcDfbsDtG8QCILQs8J58npYaemAXk8cyIOyXa+rVRBCePND2GUzmp19Dx9aRyCzqyaknsww8fgoxp3CP2eY4QVm5ewJqlHkrLKwPJDIippsLyEBKsHZYlviiwuJPpboKyr/oAGs/3hGDoN2jfr1L6jBfv4qXq0JT3RSMHFX+okfr2jWtcKXpXB4ZoGHwsVc31Lc3mSu/smmCFd1vkQ97f4sl8bHmqAUuPCqn78j7GApvjC7UgUR0w7cnNjzK5ZsHhZixyI5rzn2YTshkoGNm3ZU2A6s1WdMZVPT7QSF5/PEF9Ccbu8EOZYEkQxYXAWMIfDpwQKR1KdLmOSjSrjx97kZMOgq1MCYlhCal+wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03531a0a-9edb-4129-5e1d-08d8409a81f4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 21:39:22.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvu+KQbM5rSKO7/kKGgOpUdm0eOvthLwpQ1xfrHKQvqH3+uLR8d5F7UxqY38V4Za
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: amd.com
Received-SPF: none client-ip=40.107.237.80; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:10:47
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

1. Modify AMD topology to use socket/dies/core/thread model

2. Error out if the user does not pass the dies information if EPYC cpu is numa
   configured.

3. Remove the node_id references in topology and use die_id instead.

4. With node_id removed in topology the uninitialized memory issue 
   with -device and CPU hotplug will be fixed.
   Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
---

v4:
  Not much of a change. Just added few text changes.
  Error out configuration instead of warning if dies are not configured in EPYC.
  Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.

v3:
  https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
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
      hw/i386: Update the EPYC topology to use socket/dies/core/thread model
      hw/i386: Remove node_id, nr_nodes and nodes_per_pkg from topology


 hw/i386/pc.c               |    1 -
 hw/i386/x86.c              |    9 ++++-
 include/hw/i386/topology.h |   40 +++++---------------
 target/i386/cpu.c          |   86 +++++++++++++++++++-------------------------
 target/i386/cpu.h          |    1 -
 5 files changed, 55 insertions(+), 82 deletions(-)

--

