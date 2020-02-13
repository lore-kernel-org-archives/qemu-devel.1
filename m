Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED9C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88D121734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v+SVvZus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88D121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J7e-0007ZF-UL
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2T-0001Dx-Oe
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2Q-0006HS-WB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:37 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46]:6216 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2P-00068Y-Jy
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTnNUr6uwcJoeePTSvRPF7bNY2Lr4XcFToEVpqPAzphaDBIYeFwajG4xhGPPQIwWaME9mFBYEMGwGV5BXyrK1DdhD0o3AnIY72XPnPiMpV1nKBVVY9MzjJcUpj4+hTPIov4syM58GjzTkaXQG0kkOIUAyTAXgCJ9ubE2jE+P4gDxqMxRGqyT4d44BT7PSHut4DW8r4vSy0cbCddhsN+Iu9l8osgc7Hh3asTx0UpsJ+JeagJ+vsIdu8EQ80Nw85kByooQGl+F2Ipg9AFQVUpq4Qnx/p5zXfI73uKm42cqYxtexKE8J5hblWmAF2bGbKerJpeHOLounrUpAmmurTUmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1yJb/Rd4KxnCpwTy5l6WJdJPmqy0REItliWJ5O4OsY=;
 b=m5YhMF2giNklJTkQaM4zwFFJGxMdNgS6HbuZ+9wZZoDY6SFto9URZIWoI6Le+Cs0ad8dfeVoP1yUS0bd9UlBtwSY5wnemBD5ttRFXo1TgKwgZOxMEXAGJqbWs6+IfdZn7AbxY0a4WxF9hwXNMIB0x9IevgiII/rg5GAbrR/kstcWzrPtpq5zZu12euJR70h1c1r/teIDW2ycJI4mOz7kZYvIFTtYwaOgRLhgiOKawe/pWBBopRMg7ibxrQ0sqRX8Wkc6P9nv/0HzjImJZC88+uoRr+qjpdLpKKNkZwLOk8cEDuNlKcIgGw6rEFhOkVOs2jKSGYSYPBWYVQle2vHbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1yJb/Rd4KxnCpwTy5l6WJdJPmqy0REItliWJ5O4OsY=;
 b=v+SVvZus5MTypX/hv6PnX8NT8kcLEvsEGQLypwfV5YnKx0iT73tMD4lzO0nrPl/Hfo0TtL8BtD6VjTjRN9uRM8dOrC9MvbU/rBdrl8X6Ajx3Jo9H8hOq/L4YdE4cZBguD5ASrpaiShGqNBRGzvkw35HeDTdr/xnzyM7YaUGJVF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:25 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:25 +0000
Subject: [PATCH v4 00/16] APIC ID fixes for AMD EPYC CPU model
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:23 -0600
Message-ID: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM3PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:0:55::26) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM3PR12CA0106.namprd12.prod.outlook.com (2603:10b6:0:55::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Thu, 13 Feb 2020 18:16:24 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 272a1964-f4ff-4e15-cf3a-08d7b0b0d65b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318C2B4DDCAF81EA1B1C4D0951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(966005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJL1gwtxv6V9KXv2BF/JIho96yriT2YKyrXdInI30aECLxEWgXp2pkhIyX/sRG5G1kBTzqxYo5KJB3M2cDgVA0UerTg3GT6PWNuOuptU80VTY1XHzGMARGHWH6LKfZQdXeshwSkkSig7AxMP3xrOHCq+xaBAkgbAhV+TSIjCO/WnpC0hhRIKPRNmAi6+6ZODR4KgWiYGwd7EO72skhFe5NwvaRcnZnvGUEYfkIYgZ9TUWad/xWI8l6mEpVPA89iZBBIU0KzyeB/xnOsWG7RnzE2o7DO5dJuEl6VedZ0ULB29rmT5PUOU216YRXlGyeXsRa2JouRf/Yjo6RIXTR+KFSP2brzI6LyeVy7VclkgS3aRuT0tRO+kcuVnLxRGyzQcSkDdoR+tBdPXAVSMY2ZWBjkd59M0es9xjAB0o2LVNyOKKS46wH86iEs5JGrF+5oQmtKx3Y2ORQLk2Gs3lLsBlTfZR6Wf90O6O2gjP8BCGMH4Z/zv/7G9s9rABOvDiB2+klCKPJaBWgsJ/q5b+Z1nHg==
X-MS-Exchange-AntiSpam-MessageData: dNH3fuEriMGDqtlDJHBNS+Jq1pd9vd25Drz7Fbk05R46/KB+Q3AKo4EQbAIae/YugbtzEeQgfPAXMmtOqsDITYVQmNiu36Po1v5x1BcdC6nnhp96q9UZPStJkk4m0Qmddg2p1556XJmpzxt3AEVmXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272a1964-f4ff-4e15-cf3a-08d7b0b0d65b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:25.4807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1JIgpr0XktuHflBwwXZPAGBJ+8ZMmp4bbIVDcgg688QlFZaBVgbFO7HqpvcJ+mX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.46
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes APIC ID encoding problem reported on AMD EPYC cpu model.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166

Currently, the APIC ID is decoded based on the sequence
sockets->dies->cores->threads. This works for most standard AMD and other
vendors' configurations, but this decoding sequence does not follow that of
AMD's APIC ID enumeration strictly. In some cases this can cause CPU topolo=
gy
inconsistency.  When booting a guest VM, the kernel tries to validate the
topology, and finds it inconsistent with the enumeration of EPYC cpu models=
.

To fix the problem we need to build the topology as per the Processor
Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
Processors. It is available at https://www.amd.com/system/files/TechDocs/55=
570-B1_PUB.zip

Here is the text from the PPR.
Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize],=
 the
number of least significant bits in the Initial APIC ID that indicate core =
ID
within a processor, in constructing per-core CPUID masks.
Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cores
(MNC) that the processor could theoretically support, not the actual number=
 of
cores that are actually implemented or enabled on the processor, as indicat=
ed
by Core::X86::Cpuid::SizeId[NC].
Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
=E2=80=A2 ApicId[6] =3D Socket ID.
=E2=80=A2 ApicId[5:4] =3D Node ID.
=E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
=E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Logi=
calCoreID[1:0]}

v4:
 Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-ne=
xt).
 Changes from v3.
 1. Moved the arch_id calculation inside the function x86_cpus_init. With t=
his change,
    we dont need to change common numa code(suggested by Igor).
 2. Introduced the model specific handlers inside X86CPUDefinitions.
    These handlers are loaded into X86MachineState during the init(suggeste=
d by Eduardo).
    Removed the string comparison for EPYC model.
 3. Removed llc_id from x86CPU. Added node_id inside X86CPUTopoIDs to take =
care of
    EPYC apicid decoding.
 4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code cha=
nges
    inside the x86.
 5. Added new handler function apicid_pkg_offset for pkg_offset calculation=
.
 6. And some other minor changes.

v3:
  https://lore.kernel.org/qemu-devel/157541968844.46157.1799491814253379131=
3.stgit@naples-babu.amd.com/=20
  1. Consolidated the topology information in structure X86CPUTopoInfo.
  2. Changed the ccx_id to llc_id as commented by upstream.
  3. Generalized the apic id decoding. It is mostly similar to current apic=
 id
     except that it adds new field llc_id when numa configured. Removes all=
 the
     hardcoded values.
  4. Removed the earlier parse_numa split. And moved the numa node initiali=
zation
     inside the numa_complete_configuration. This is bit cleaner as comment=
ed by=20
     Eduardo.
  5. Added new function init_apicid_fn inside machine_class structure. This
     will be used to update the apic id handler specific to cpu model.
  6. Updated the cpuid unit tests.
  7. TODO : Need to figure out how to dynamically update the handlers using=
 cpu models.
     I might some guidance on that.

v2:
  https://lore.kernel.org/qemu-devel/156779689013.21957.1631551572950676212=
.stgit@localhost.localdomain/
  1. Introduced the new property epyc to enable new epyc mode.
  2. Separated the epyc mode and non epyc mode function.
  3. Introduced function pointers in PCMachineState to handle the
     differences.
  4. Mildly tested different combinations to make things are working as exp=
ected.
  5. TODO : Setting the epyc feature bit needs to be worked out. This featu=
re is
     supported only on AMD EPYC models. I may need some guidance on that.

v1:
  https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@amd.=
com/

---

Babu Moger (16):
      hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
      hw/i386: Introduce X86CPUTopoInfo to contain topology info
      hw/i386: Consolidate topology functions
      hw/i386: Introduce init_topo_info to initialize X86CPUTopoInfo
      machine: Add SMP Sockets in CpuTopology
      hw/i386: Update structures for nodes_per_pkg
      hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
      hw/386: Add EPYC mode topology decoding functions
      target/i386: Cleanup and use the EPYC mode topology functions
      hw/i386: Introduce apicid functions inside X86MachineState
      target/i386: Load apicid model specific handlers from X86CPUDefinitio=
n
      hw/i386: Use the apicid handlers from X86MachineState
      target/i386: Add EPYC model specific handlers
      hw/i386: Move arch_id decode inside x86_cpus_init
      i386: Fix pkg_id offset for EPYC cpu models
      tests: Update the Unit tests


 hw/core/machine.c          |    1=20
 hw/i386/pc.c               |   51 +++++-----
 hw/i386/x86.c              |   73 ++++++++++----
 include/hw/boards.h        |    2=20
 include/hw/i386/topology.h |  219 +++++++++++++++++++++++++++++-----------=
--
 include/hw/i386/x86.h      |   28 +++++
 target/i386/cpu.c          |  228 +++++++++++++++++-----------------------=
----
 target/i386/cpu.h          |    3 +
 tests/test-x86-cpuid.c     |  115 +++++++++++++---------
 vl.c                       |    1=20
 10 files changed, 421 insertions(+), 300 deletions(-)

--
Signature

