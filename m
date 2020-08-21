Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF79F20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q4YvclHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF79F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FW1-0003yB-4X
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FVR-0003XW-MO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:27:29 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com
 ([40.107.93.64]:59862 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FVP-0003jw-DM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWbvWiDL2Wj3wkK0QM2aelVCKSWy+QbngHVLB1fmuYBAf8i8jg4x2CknyzRAxYlBNpyP9Uj/+tXAOcIe7/toQnaR2kThLaRUSnqgt+dl8PrdmkDr9tEVycibVAjRaWJlS5SZWmocaEHm1gPDZXEDfn3nqCL5l9s2Hg+qkQyG0gQfj3WQUWoSV6hhoetGe/xxGRpg6QFNQ0QBqlMrGEHH38MHjOBCTOy7+tj/lEbV9yzDiZxEOJOfSM+jQv8VxFjC1MFQjierOBEv/uBHaZOqK70mReOEQ/eDS2P1et3wyQkicYF2+HHnh81pbc8JZN+rWGNI5JqhT+gh5f+khwiKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ulk/Y7nr5R6uh+cNOZU+I5rxwWHo8iLLPfV9X1poRA=;
 b=dPVgfoawC6auZfHiUGC17Pb5B/dMAUvseFotM+BRBZrXNOMvmtRQRhFwAcblr9sKXw6not5F4at37q82PY5Apde1+PPhYWlVOGR7CvW3RV7w+UXYOSyuESEG8vW3uwlNQO2vYak6/bs0+AtQ88VGRjXfSG+LaJ8MSwdeodlvZfyIl8imh6WRizmbenOaIT7JIL0rswqCVdRVA6EbrH0ydELsUJRfbD8l4mJLI5A9MTWM7SqQcUtTl4eath1AxxOPYYOuRY8otC/fGDFpxrl0q6KvX41EN/jDXcpzGcbZ1kHbvyE1irp/USyrFzm1SSyfWFKpLLevwSDh/RxrmQU0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ulk/Y7nr5R6uh+cNOZU+I5rxwWHo8iLLPfV9X1poRA=;
 b=Q4YvclHxq5nlDZiToCqIBL6xEdNox0XjUyblC65fd/UDjkrWipJaN6PyGD0FPVvLIkcqmC4y0YjRdWXhyrrC8VfUEQCo3Uw4BoDIuB5VkrFNOGBY3qhXLwS0cKMbirU7iE0PTZO6Y1oDQayZFjZh2hRLYREBOwivdMaDynunZ8Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:20 +0000
Subject: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic decode
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:19 -0500
Message-ID: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0113.namprd12.prod.outlook.com (2603:10b6:802:21::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 22:12:19 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14345aec-81da-4d97-34d6-08d8461f458e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2383DB2667C43B456D88F86F955B0@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+YpCCD3WIs1cRTZJa9/tB+EOCc6BZtSsNU6XXAFC4ndkSTLGBRDGu0mDNqXimi+V7TIjGJoD0Ytq+AOjCyWnwk8Np7UNSXWbRzrsMocmeR/UhailhJZnHcne1XpaJgcgRbt3P27AeE0kRueAPz1yBjgC4Zxs+zPsDZ6z8WW9ESXA4ITbsr1Qx0XQB7QgkF74xoYMSgk2Mj9wh199FW3mppoLnqSSoI/kJ/QFI0Tq8/4pIv5vmM9qkAlp9fMz1opm3Nvd64NoNGz5gY7BKM1xqeMC8p2GB/+FSIijMfeAVlWpiiQs2Pmz27lbh84Kl2k2zO6a044fLaiPM5McbbTi6kxiLXDOEGU9j5ETEvkODvMwgY0cRTEcVhTaQ8RdAAsnSV2t6LMV2WaHVibT5CP8/B3/BpSY08ZpvR7j8KdWHDVM5SbZc9N62wt0UIPFPZn/EtVQgqDBt0ZwlvGB15mzoWwAiR1uJ45dwkPpDO+16E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6486002)(2906002)(8676002)(103116003)(956004)(8936002)(44832011)(110011004)(26005)(478600001)(86362001)(966005)(16576012)(316002)(52116002)(66946007)(186003)(66556008)(66476007)(4326008)(5660300002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8hd+KJFpPy9EOKhynBTR3tU+N148on1RDe8yXB/A6ybifNJCFLPfT4plhdC6b2X81yx5YyzFwnaPd2SSnfCFEXRV85L7BqhEZZHe6HmCJog74P6gQtSIGmTbakYFkYKfRkHr+qVAMe6hAWVlRC6oe51tsUJsHG6lGNWq+SJxPZPEyQQS3sMfLHRe4Tm0u1js4oFPG88G/KnoTtyJnyNhBj8LrWoNn7WuSQ+YSLKnPxg4Blp0ANcE1cXBZ3EmXChSPuzX8kpPT30o/FQi3Lee895zpUGyj8zV7BD1R5br+HgzFxIs77PDto8S1+DKoqs1KVa1G6TLNhVjjMzxQerWlmS5uBlPvOlV6pKAxQAsyEd0C8i9Pa7xkCp24YzKKiKKh/eogGy60iTxQuNBGCoua6jV6Awwrpt8F9s5+w8R8i+80kF3TI92U+u/5sCtk/4WhGRp/010mOk1i1xxAC22qmGizbfd4MK5uICrScy58jazL5vyq4gdrkEwEE7Jta1MYi4Kjx8aOIu1jT1Yu5+OT0If76wl75tmKqrocJDqOgJB374O72pm6cLqJihOPY/izdQT32hN5RDDBNSE2OnW97wNOCMFfZmJhWFP39kOCu70eRyBQQNq6TX7wW1GTzAIVZln1lrNYt258OwNvN6MLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14345aec-81da-4d97-34d6-08d8461f458e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:19.9732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNHSEh0Nik3B1jsMLonRxIxYe70wLNrQjXJ0vV7Lo0SDdUQQ29HJzV52QwiXFwKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.93.64; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:27:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

To support some of the complex topology, we introduced EPYC mode apicid decode.
But, EPYC mode decode is running into problems. Also it can become quite a
maintenance problem in the future. So, it was decided to remove that code and
use the generic decode which works for majority of the topology. Most of the
SPECed configuration would work just fine. With some non-SPECed user inputs,
it will create some sub-optimal configuration.
Here is the discussion thread.
https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/

This series removes all the EPYC mode specific apicid changes and use the generic
apicid decode.

---
v5:
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

Babu Moger (8):
      hw/i386: Remove node_id, nr_nodes and nodes_per_pkg from topology
      Revert "i386: Fix pkg_id offset for EPYC cpu models"
      Revert "target/i386: Enable new apic id encoding for EPYC based cpus models"
      Revert "hw/i386: Move arch_id decode inside x86_cpus_init"
      Revert "i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition"
      Revert "hw/i386: Introduce apicid functions inside X86MachineState"
      Revert "hw/386: Add EPYC mode topology decoding functions"
      i386: Simplify CPUID_8000_001E for AMD


 hw/i386/pc.c               |    8 +--
 hw/i386/x86.c              |   43 +++-------------
 include/hw/i386/topology.h |  101 ---------------------------------------
 include/hw/i386/x86.h      |    9 ---
 target/i386/cpu.c          |  115 ++++++++++++++++----------------------------
 target/i386/cpu.h          |    3 -
 tests/test-x86-cpuid.c     |   40 ++++++++-------
 7 files changed, 73 insertions(+), 246 deletions(-)

--
Signature

