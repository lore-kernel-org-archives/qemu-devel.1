Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56061207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mFFbnkqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56061207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kConC-0000yq-Bg
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCokr-0005W6-TQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:10 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com
 ([40.107.236.63]:26189 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCokp-0007SR-Rg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNAa4J6Vnqk0lM8t0Y6GxoRbonbpJ8tmBQ91swyHbpW76jlg56mwd0znR6UHC+FJSX1GU1JGDYzMROks2r9yFL28EKgtVe8VkPyvFl/BImcyD5c7Hp8G08oB7t7jjOihZEZnrlkTdz81QAZr3hhJLhru1RFxK+kdU1aZ6HdMNFMYWgL5yO6CK79ehd6jfO35Vk/dfOwewzkE8nmR971sOWAH40CV3G+azGPzBLICLSNNcIo6AJXRDaK5iN225a23TPbwk5Ly7bWKUfuDKlnWqKEhc6pkVVbDNydYWp2MuBELP0y4OD633Qm90h9J+94ORVf3kVAZ//w5PH2a/uUx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K3kjOPuJF6b3yZz8RQJW+IGyT06gKlHS0Pax7GrMi8=;
 b=MXPvGHervlHWGNmc/NmgtofUh2LMa6t+SttgAdiEI8lV9LFS9KSkEm+syhJvNlZL+YzQQqUaSMo2L4D92HLN3ItHzFfzbHDJtqI8nvRS63L7ol/rqRo4GXME+b0TYwm5QkXlwt98H7YXUp0b+AB9V/nddqLjMgTw338rHpvokwFAocD6OY9XNLLzaoeYYDHdhnejNitjRSLt5T/dcvR/tVsuGr63z18W5TgDXap0Kjp3MoIgwDvS1j56O8fpu4jFlBaZ+FRTVT6p+aNO2Y2x+qB/XTP+ixT/CcKYLjStN14y3E+MQJzUuAPpLlRCO+wH9tZsnfww7O3bD5dZX4WdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K3kjOPuJF6b3yZz8RQJW+IGyT06gKlHS0Pax7GrMi8=;
 b=mFFbnkqbBAdqAJfIpqdKvAj0EJ/w2teZjupgkt20gGCx/jVtS5Eb9FPPXl2mdAaGbbsk8x8LgPFFC82neNxM8pZgnia4Gp/ebKECRxxg68hJNbH26eqa9m08LpG8DO81q2OwFx3LAxC15ohKZfArMlnLHxORr9eMdjR9iLGkvJ0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 18:42:06 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:06 +0000
Subject: [PATCH v6 00/10] Remove EPYC mode apicid decode and use generic decode
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:04 -0500
Message-ID: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:0:55::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM3PR12CA0107.namprd12.prod.outlook.com (2603:10b6:0:55::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 18:42:05 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07c2d8b3-2a39-4f73-5d9b-08d84ddd8f33
X-MS-TrafficTypeDiagnostic: SA0PR12MB4560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4560A062E8C043E5ADDB956495510@SA0PR12MB4560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t+EvW3h5xLJVe7CXKPrc0Pe9cb74OLcaMtb4OoeRb0hu2yOcjcUbK3hlfW2nns15AJsmdyyHjKiuhiRlTgVi3jqNIj3v69lxCSEYLyloFa49aPu9G3cP2vcwaATD4Tqnh8veg2z7UPXXP7QlSzNkH5wRKhzz3TYDG7p2ToIBNR486ONYp3OVrq65HG6K5MyES0LbfB0eR12tfvQXRxlZ1+utV8E70R/KsUzSBqhnlO3HfAduH1nY4x5EELcU9OA0G2iU5hB0EDnssCdtRYNFOYx25HwcSToPeR6yccIJqkDkycfsG9Lebooh5XV+sr0BEepS09l0PEEtKqc0npTz+V8RGs6HbSrFjw/taWgvfD4ewLXooXpx56VeIF6qZm9TDLL2KZ9UBcy/Q3SCBqzRoVu1C3QfEcMZbLrITpWxjzfK+A72cj6v/ULKl1Ffe+RVssVZDHLOOq671iYL7pQvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(86362001)(66946007)(5660300002)(83380400001)(8676002)(44832011)(16576012)(103116003)(52116002)(8936002)(66476007)(966005)(478600001)(66556008)(2906002)(316002)(26005)(186003)(956004)(4326008)(6486002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YZyO/yWiGddvlKMw79pyKaUX9gcDMWZAre/kXLfxP0+TCW+35L7hzPYy8ZoJHCIdjaX9XHiBNxgqHH7i+A46VVQiqiOjjekAdGiN5yC8mry0cMq5jQFSC4AMH3c5YO6Jlu9Xdy/GE9SAS4F+UZwnHNgFBd5GYpxeDPRcrJzi+W7wCUiqXEWkC+Yu+/jRZG7I58jEztuPYikSoybByrYPfRDHFCEZ3kj7s/UP3FvHOTduSwcT1pa+W935Qf1/9hnOHLGPd7EH3jmjuKQwfHPVPzx+RLBLkScOpj8I5OmqTQKHiFn6BoP3uOVYVmBxJtVsvlVl5Fsnw+YPc3db64jPwAHY5+CpUAt5Nj6ChabbICZTVFiau/ZqgMbGMWjIthoCMrV1/xXw16hp5NHUOsXaGenLlOgq676Sus5mMcCYXXdqpvjkWHpbZRdqvFmfBpvyFnZeOs7OcrJqDCzQbb93KcrQRlNWXKaodsGb6u6YLlILE9kg3xBU0fnuRnDr1tAZImbowLm5waKTguLPi+nz80vDAMezbqiM7kgTPFwUMEhs40ZvxYkwI+Sib5g7Rum+h+V1VMqcD+9X3D4EN+VhW/WbMrQgmGyWdL2qQmHTkBUpgBcOfR78gvT48DJbVi6dK1eL6Xjl5sFB3FKJeP0wTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c2d8b3-2a39-4f73-5d9b-08d84ddd8f33
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:05.9543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnWKyaQGfcvqOLY2br4mdE87wG6MOxL9vpx0vbPV4MapXJ1M8TUtJhLy/D2ozBc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
Received-SPF: none client-ip=40.107.236.63; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support some of the complex topology, we introduced EPYC mode apicid decode.
But, EPYC mode decode is running into problems. Also it can become quite a
maintenance problem in the future. So, it was decided to remove that code and
use the generic decode which works for majority of the topology. Most of the
SPECed configuration would work just fine. With some non-SPECed user inputs,
it will create some sub-optimal configuration.

Here is the discussion thread.
https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/

This series removes all the EPYC mode specific apicid changes and use the generic
apicid decode.
--
v6:
 Found out that numa configuration is not mandatory for all the EPYC model topology.
 We can use the generic decode which works pretty well. Also noticed that
 cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
 Took care of couple comments from Igor and Eduardo.
 Thank you Igor, Daniel, David, Eduardo for your feedback.  

v5:
 https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
 Revert EPYC specific decode.
 Simplify CPUID_8000_001E

v4:
  https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
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
  Used the numa information from CpuInstanceProperties for building
  the apic_id suggested by Igor.
  Also did some minor code re-aarangement to take care of changes.
  Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
  it later.

v1:
 https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com

Babu Moger (10):
      Revert "i386: Fix pkg_id offset for EPYC cpu models"
      Revert "target/i386: Enable new apic id encoding for EPYC based cpus models"
      Revert "hw/i386: Move arch_id decode inside x86_cpus_init"
      Revert "i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition"
      Revert "hw/i386: Introduce apicid functions inside X86MachineState"
      Revert "target/i386: Cleanup and use the EPYC mode topology functions"
      Revert "hw/386: Add EPYC mode topology decoding functions"
      Revert "hw/i386: Update structures to save the number of nodes per package"
      i386: Simplify CPUID_8000_001E for AMD
      i386: Simplify CPUID_8000_001E for AMD


 hw/i386/pc.c               |    8 +--
 hw/i386/x86.c              |   43 ++------------
 include/hw/i386/topology.h |  101 ----------------------------------
 include/hw/i386/x86.h      |    9 ---
 target/i386/cpu.c          |  131 +++++++++++++++++---------------------------
 target/i386/cpu.h          |    3 -
 tests/test-x86-cpuid.c     |   40 +++++++------
 7 files changed, 81 insertions(+), 254 deletions(-)

--

