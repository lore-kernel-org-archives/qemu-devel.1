Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9397C2073F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aytuEoI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9397C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icK1A-0006yo-NM
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 21:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuR-0005Y1-5W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIf6-0000B4-KZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:02 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com
 ([40.107.223.89]:61408 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIf6-0008TF-95
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlonCTNz7UGrX3Mp3KTnhp20VkZmL7GEF+6yks2dFx9y0pwKdQJgS5h8Nv8rz11G4oMGAub2OGIJcryxhpa/Yw7Q/+jzEEM8VKE+IZ71t+dusrQhlAAhCFCykfB153z+sMA0Wt34GjXB5pwDtlJm46G3n8VtFisnhrpRwJcqjAUGWF324y+WqxGIdU/D7b3e5CLIGRz+uUNm8zVvmHQF2+odh+S7FDnaYW09i0IEIcXKlcJiZ/o/sOaPI0D1aUcT/i7DwYb7+arCnqiFAYrKkYu9aLVPWxKeGeGZ+QTO/hguUedosXYny+yMEkTAwk/JHIthQW7zicMUBmDioXcuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deMnMRAtCbsdW4lCVcL0qnPsFRwD1jbZt63f53ZKWBA=;
 b=f7i/V801FlLln+ZJqJPeWkpHq9yTse567ZnajJkQKvksOxD3A6yevIRPtRBvoPdkpe3FP961/6HeOsBcEKIPwaEAotgN090+8Z3RvW/C3qdacvZmqjNeGLxCRxi1rgiepc/D2yDdOQkIz6LdX5f/BFjAKJlF68AdZ6q2lcl19nSe4Ce4nVZBL8tkVUuBxHfheKIuhiUrzVT7kMk1dAmarOv5NqUNX9tjRxkPTML3LTIsDeGc82hovypUZmNvO82zXZtuS/ZGJa4NKBUrCl4TW13N52E2dN6ZfD3HMymp6a5opQMj/NimlO/np8rKlHMH8zTrMlwlK3LrGCINqexxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deMnMRAtCbsdW4lCVcL0qnPsFRwD1jbZt63f53ZKWBA=;
 b=aytuEoI2uhRuBSsz2OZK02iC/S5tG7gUbXguq3QvCww1lChIe/ns66CIGkyVy/XY0tvCjUdbgRdogmPbx960Q6tNpgnlHSR1AmiGDjaGlNEVIPFbFCnbq0cjy952D5vMBBso7cl/7y2bFbxK59N1xmtgodIaR/HU8zwhKvbpIiM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:36:56 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:36:56 +0000
Subject: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:36:54 -0600
Message-ID: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN2PR01CA0079.prod.exchangelabs.com (2603:10b6:800::47) To
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 737ccd4b-0b05-4556-641b-08d7785210bf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369589EF3C5C0B8E68071C2955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(66556008)(2870700001)(44832011)(4326008)(14444005)(966005)(99286004)(14454004)(6512007)(23676004)(316002)(58126008)(81166006)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003)(6306002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2eASIYpxnFpskEZc52AzPfBqUmhSYr60X/OG9lDrYrKdXIaPQbfC4KeVy33v+JW8m1jbId5igTGVX0wfDydd1RjJq89XZwap3Cq1dJqyiZTYV982tE0hiOXCnce1QQtVUAJ4TvgOYZNprRaMyvJSg1NW3I6/ltuPf/Cssga5VVdHaii/uNMt8lQqV4D38Oa1uW49tWT15tBYzRKgHGihYFwFsDB1aUHRgSdhOHQmmKHcVONXSFqCG2gLmM2u7CKJynTe/cDgqMdqhJvWzT9vTixFHsakkyFfzfqrRJnVns3yE6+PPESpNMcH38Fvy9+hZG2FzfCxC5HnjrSI93j22TBaG+VrOMVvCIb2QuCgphfYtFl1aqX87hXEMPCZpg2BDSRtRH/IxdcFyA+MBBHaMuNXLRm6nV/HLI0M0W/4TzML8wCPZDLRT04UZQ1Fa2D0RC8A1z7dL97EEpRdIF468Ku2OI4NBk9VnlRDn7H+ZrOpnB9JsgnVvjR6+X51u4jjua07ccdkNEdT92PG472Q3kYpu4p/GahpRefo0PI/Rg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737ccd4b-0b05-4556-641b-08d7785210bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:36:56.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gNS05UgTaSgFWjBP1P9dTY4vlPhGLTtyMOdjMtnjw260J8MqtQVBidgfc5ZN5w6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.89
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes APIC ID encoding problems on AMD EPYC CPUs.
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

v3:
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

Babu Moger (18):
      hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
      hw/i386: Introduce X86CPUTopoInfo to contain topology info
      hw/i386: Consolidate topology functions
      hw/i386: Introduce initialize_topo_info to initialize X86CPUTopoInfo
      machine: Add SMP Sockets in CpuTopology
      hw/core: Add core complex id in X86CPU topology
      machine: Add a new function init_apicid_fn in MachineClass
      hw/i386: Update structures for nodes_per_pkg
      i386: Add CPUX86Family type in CPUX86State
      hw/386: Add EPYC mode topology decoding functions
      i386: Cleanup and use the EPYC mode topology functions
      numa: Split the numa initialization
      hw/i386: Introduce apicid_from_cpu_idx in PCMachineState
      hw/i386: Introduce topo_ids_from_apicid handler PCMachineState
      hw/i386: Introduce apic_id_from_topo_ids handler in PCMachineState
      hw/i386: Introduce EPYC mode function handlers
      i386: Fix pkg_id offset for epyc mode
      tests: Update the Unit tests


 hw/core/machine-hmp-cmds.c |    3 +
 hw/core/machine.c          |   14 +++
 hw/core/numa.c             |   62 +++++++++----
 hw/i386/pc.c               |  132 +++++++++++++++++++---------
 include/hw/boards.h        |    3 +
 include/hw/i386/pc.h       |    9 ++
 include/hw/i386/topology.h |  209 +++++++++++++++++++++++++++++++---------=
----
 include/sysemu/numa.h      |    5 +
 qapi/machine.json          |    7 +
 target/i386/cpu.c          |  196 ++++++++++++----------------------------=
-
 target/i386/cpu.h          |    9 ++
 tests/test-x86-cpuid.c     |  115 ++++++++++++++----------
 vl.c                       |    4 +
 13 files changed, 455 insertions(+), 313 deletions(-)

--

