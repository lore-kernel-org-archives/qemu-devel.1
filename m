Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD3AC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E7D208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MRfoFnSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrCy-0000aT-Vi
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBY-0007oO-ML
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBW-00063z-VA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:28 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com
 ([40.107.93.41]:32480 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrBV-00061Z-7W
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFEQfYnVWmV/s6WnO1pmHfzh3bfFf6SWEyOclTXK1gwQB3dY/1jmDIVoMAlMNbz1c7YZy5HJfupJnGblB+cauBL5XziF/gs63GYR0QOfiiwXV5k4kbjNnaen7PTntFGySKd/gQoYOUGmJFxRsyx7jcQhwEJVWgF8nFun0z0AZOwNOn1X8pUQPap4wqPhck8oVynrS+X8Jjiqs1C8DvBtVXoU2iIzCqZBVuOWnG/goEPTeh9tDy4ShChSH4VRA/7Owv0lH0NuBgfnLyGOKsk5SX7SSHYNS2ry8TeMBPadguEXdpqJrS24hhPfcX/F2yo8Y3w9eMAf5PbmlUTHpAeBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlsUYjX3Fcz6An5K3/V67aUBV0NZQiVw18dTu59meMg=;
 b=MJK01W1I2jLYlbVejD3ArgK8qXzBlfRkjBgRqOadYBCGr2dXZsC86pdeSnUO53gg4uD+dgxPaAUe9sWi91wwl3uOxsutEo60LAyRGl4n356yITZyGOjxn1hnVsLVQ4HrguN70X5Qzti87W3PJ31MO0XwyMC/+I7vA5frUMld5EJfhFbmcfYcV6cCagefgaPnmtHEBGhaqJdcHHTqpthH/mu2OKUtgrujIETcMQgtKwLOzXp7wD9KBdVU956hBI6IdoLyCH50yfL+aEhKs075bGaATuqw27Mp1VrTT+/06qz0I86c/QslZXdQZ1wFboR5Qsij71x2ziHoz1gQ1oLnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlsUYjX3Fcz6An5K3/V67aUBV0NZQiVw18dTu59meMg=;
 b=MRfoFnSXiderqCZ4GpBSZ6rs13S8wdaIyUdByt6czX3MxMRlxaXriNgR1MTtNbPloEu29ZebYWl4eR54xP8H5d283vlyKb0BV1o15VNS+LZQ9pmBpQZEkJAlsay0VYr4xNed9KODROUwc/b3rvRi6DUSl4JSsicovK6idOvYquM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:20 +0000
Subject: [PATCH v6 00/13] APIC ID fixes for AMD EPYC CPU model
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:19 -0500
Message-ID: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN4PR0501CA0051.namprd05.prod.outlook.com
 (2603:10b6:803:41::28) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0501CA0051.namprd05.prod.outlook.com (2603:10b6:803:41::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.6 via Frontend
 Transport; Wed, 11 Mar 2020 02:33:20 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c066334d-6410-4b1e-030a-08d7c5649052
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24939FFC5F412ADE2294B21195FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(8676002)(5660300002)(966005)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUiMiF9793rG4NzJR/hMu+9AneLqMbJIETtpKg/Y03145D5V+SAXnGjLqGrr5QK1VMIDHSJ5ExnYzynKdauQqMJGB6c8QPhL39B4vDWTVxx0TplrpPcnGm9DBSAI86X4v7WEZiOanb9rVUCVOl40Dyp5Q7xu2IcsU9nlgBAbNuL3EZ1GzSE5vJWXFuBoypA3RpiYAyju4UUq5LmrJUIOXEK3Ef46zTCold/CQjRbo/2YNrItYHW0J7YDfCl5qnQEm1KIf6gcQWQTe6sHzuoXDsDynaJ4bBN1fqwNoRVNHp0ob0jm7+JC5w67nohZFbItgE1uUFwvxnzSkNcMQWeKYl+bIXNB73IodULM+I3rNNZlUyHnVsGexsWEMm9AU3RW3ilj7rB0DaAAqv/y3UwOiegZz/FGlaST9nzFR/1rHSscRzFfY9Dg8xMsUYjWRRJzNffie2a4spsH/Ea/3hbjqUShbimxXBFv73FKJM3zDohM5GA3IHFb+dKJrZsTC/IZzHDE+SatDNGXTIVR13R9Aw==
X-MS-Exchange-AntiSpam-MessageData: 5thT/BOytOyCwOBSDJ7hZkUOjD0zuaNDDxXggA+EhH9TPNUd/rvNA6l4WH/lzaZcM5vCEbawOK0PTpA9u/fxYHex8gbCwpT7QdlDykSRLOJ8CyV7P5UFnpWVFWtSGtpoY6nHfSn+iI7iS7cB0goSfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c066334d-6410-4b1e-030a-08d7c5649052
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:20.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UOJL4ksMsgOYgXRksPZY9ejU4+tM5rNftEuwyW/A1xv3qzH7XVM89a3gdEKarLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.41
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

This series fixes APIC ID encoding problem reported on AMD EPYC cpu models.
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
Processors. The documentation is available from the bugzilla Link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537

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

v6:
 Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-ne=
xt).
 Changes from v5.
 1. Eduardo has already queued couple of patches, submitting the rest here.
 2. Major change is how the EPYC mode apic id encoding handlers are loaded.
    Added a boolean variable use_epyc_apic_id_encoding in X86CPUDefinition.=
=20
    The variable is will be used to tell if we need to use EPYC mode encodi=
ng.
 3. Eduardo reported bysectability problem with x86 unit test code.
    Quashed the patches in 1 and 2 to resolve it. Problem was change in cal=
ling
    conventions of topology related functions.
 4. Also set the use_epyc_apic_id_encoding for EPYC-Rome. This model is
    added recently to the cpu table.

v5:
 https://lore.kernel.org/qemu-devel/158326531474.40452.11433722850425537745=
.stgit@naples-babu.amd.com/
 Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-ne=
xt).
 Changes from v4.
 1. Re-arranged the patches 2 and 4 as suggested by Igor.
 2. Kept the apicid handler functions inside X86MachineState as discussed.
    These handlers are loaded from X86CPUDefinitions.
 3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Sugges=
ted
    by Igor.
 4. And other minor changes related to patch format.

v4:
 https://lore.kernel.org/qemu-devel/158161767653.48948.10578064482878399556=
.stgit@naples-babu.amd.com/
 Changes from v3.
 1. Moved the arch_id calculation inside the function x86_cpus_init. With t=
his change,
    we dont need to change common numa code.(suggested by Igor)
 2. Introduced the model specific handlers inside X86CPUDefinitions.
    These handlers are loaded into X86MachineState during the init.
 3. Removed llc_id from x86CPU.
 4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code cha=
nges
    inside the x86.
 5. Added new handler function apicid_pkg_offset for pkg_offset calculation=
.
 6. And some Other minor changes.

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

Babu Moger (13):
      hw/i386: Introduce X86CPUTopoInfo to contain topology info
      hw/i386: Consolidate topology functions
      machine: Add SMP Sockets in CpuTopology
      hw/i386: Remove unnecessary initialization in x86_cpu_new
      hw/i386: Update structures to save the number of nodes per package
      hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
      hw/386: Add EPYC mode topology decoding functions
      target/i386: Cleanup and use the EPYC mode topology functions
      hw/i386: Introduce apicid functions inside X86MachineState
      i386: Check for apic id encoding
      target/i386: Enable new apic id encoding for EPYC based cpus models
      hw/i386: Move arch_id decode inside x86_cpus_init
      i386: Fix pkg_id offset for EPYC cpu models


 hw/core/machine.c          |    1=20
 hw/i386/pc.c               |   15 ++-
 hw/i386/x86.c              |   78 ++++++++++++++---
 include/hw/boards.h        |    2=20
 include/hw/i386/topology.h |  195 +++++++++++++++++++++++++++++++---------=
---
 include/hw/i386/x86.h      |   14 +++
 softmmu/vl.c               |    1=20
 target/i386/cpu.c          |  199 +++++++++++++---------------------------=
----
 target/i386/cpu.h          |    3 +
 tests/test-x86-cpuid.c     |  116 +++++++++++++++-----------
 10 files changed, 361 insertions(+), 263 deletions(-)

--
Signature

