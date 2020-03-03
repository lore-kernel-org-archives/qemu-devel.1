Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C1C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975A92073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QQoSal4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A92073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DgH-0001Zr-Ks
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Df2-0007zJ-9E
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Df0-0002rp-Nl
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:00 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com
 ([40.107.94.70]:6178 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Df0-0002rQ-Bj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:56:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4PNeReQs6FoZNBIWy5rtY3wipn2KWbgm01NV2h5jY810442damUbLsWkhva72sSvXxAilRggLer7O+j6sbOg9POI9esBQ8ukRTk8WGldRhV9E6KUm4FYqUHWGet/6DWvSQJw6ISd+2vsMRN1ddhkT68O5Yo1s34AWcKPRtsWkl3to9O6qaB+q2Uma6vWsZzvRbthD/OcJAWuJ47i1MYVgvOBTpRZv/prHCCI2BcRmWnMOyThlBybYIjZ7xYMMhqEKTcidYlYPNF8BiG0F5L+Xz+IEi3Tx6Fnh2FDxjNWLegn75bOT3rLETZSkIsV/+vtn8V/VDwXikVhm+AA7lfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzitqJ+RCl+kghhQ5Jl933jgUxf2+CTPPzvseOdQDHc=;
 b=Fx7IZmfpuJazU5vAx0fOwIfAdTyLsg+NxmGVLGmQ9FBECRicAjiMQ1BYYH8/DJRDbOo8IJDyk50hbn7TxNZxy+V6Q/SoUGA6JeKEe1KniI5M+g7nyuE98LDtO1VSpOFPCatIbfwM86M6ac+V+lWpnkV109uuYI3TeQCXF6sbvQ+IJsU5ZrHtDj+onpOwrKE0BYtahSMrSGJjpHRSQ7CI6qoyO+nyVfJU0AK5BZXynQWO78iS8k+oyNCaYJ6fvW+w0KHJmzIPY+HO/99rPdNhcqY3pfKQtEMVIZDUblMhmVIBpq/eJQzjIAVm+qzSd5zvpmQLQZVD5sh7gu+M9BoHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzitqJ+RCl+kghhQ5Jl933jgUxf2+CTPPzvseOdQDHc=;
 b=QQoSal4G2p1vxX2YTg0CnCuHGMUFTfP5FiLpcKKJX4/NGyInY5hE9pagxC6NTKziL8NY+G4lRI/W4Xah58zJjw3xUAE+elwJqW2VLEEHhAr2Z/zgVtcZlUrlA9WdwSWKhjGP4m7C1EG6izjuhn78ZJBeyPmvch9lYC1aLM5r4Y4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 19:56:53 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:56:53 +0000
Subject: [PATCH v5 00/16] APIC ID fixes for AMD EPYC CPU model
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:56:51 -0600
Message-ID: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:3:13d::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR20CA0044.namprd20.prod.outlook.com (2603:10b6:3:13d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 19:56:52 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8294a620-f9cf-4f35-7b13-08d7bfad052d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:|SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25123C687E23694CD039085C95E40@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(26005)(8936002)(478600001)(81166006)(52116002)(44832011)(966005)(7696005)(956004)(316002)(81156014)(4326008)(103116003)(8676002)(55016002)(5660300002)(16526019)(2906002)(66556008)(66946007)(86362001)(186003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2512;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewbySuK63WWVm5ND3G2h9QHOSQgRuno/CDNlLbx8KtTE+SAE5NeAinI564wHiFOQBonPyQFRSl1FB3r1k53O577CjdxkFg9BF2jtn+pUFcnfp0wh3qk8PIbT5dqWz3JPjc3Gj26iBpnZDJkkl+zjMP8tWe0HDdUaq8dY7W6k9lfx9lwxWvwgsnCl+ma71b0+yW1NcfhtY35S0y6aF0Yjshp8mFkE6tDWGgW5QdDB2trUpDvRimEiijRs+J7q9nbeLMA/Dz10b0DVvsVUziSwpdoymxoMpcYBYRkBUXqQ0nrcUOEnOlqJqt5IRFWUQXM6uy4ci97VbOk8xsJV7FkduvJ+i+TZB0QoTH/GTqPMjrEM8iae03TAZBVb9l/QeNwCTlqUQStDXVwttu0xYRfZ1tL48pt8UlQK4FGpfsROtbl2+a2npnkYUFOWnAwh/RyWCiYF8V/qBXNI/V6D+Fv1nJi19Y2190qGz7dGi+wNS9vqFFyRA9SsxJI2+wYo/C26OY6IcBe6V7qkoDyPCgWgVA==
X-MS-Exchange-AntiSpam-MessageData: pBkA4/ofq5A6Q9vEn8tvOXKaOeopFjoq8703SgNHmoDxcpRc40TJKejdgA3PYto4IcC+uSG6Bx392Siq+t1hX4ctvyYyBP7MNRkJA6PSdwi6ydykfmgo5jVo1Oqt9legjxdfr0qBT6Cr7ejworvZvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8294a620-f9cf-4f35-7b13-08d7bfad052d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:56:53.5007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzeyZ1VwjFMMKg0KLTteOrG5VDvZBj4iwoanDxxCyyFitjg2Rl5DVXLPf2vhfXbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.70
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

v5:
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

Babu Moger (16):
      hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
      hw/i386: Introduce X86CPUTopoInfo to contain topology info
      hw/i386: Consolidate topology functions
      machine: Add SMP Sockets in CpuTopology
      hw/i386: Remove unnecessary initialization in x86_cpu_new
      hw/i386: Update structures to save the number of nodes per package
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
 hw/i386/pc.c               |   54 ++++++-----
 hw/i386/x86.c              |   72 ++++++++++----
 include/hw/boards.h        |    2=20
 include/hw/i386/topology.h |  215 ++++++++++++++++++++++++++++++----------=
--
 include/hw/i386/x86.h      |   12 ++
 target/i386/cpu.c          |  224 +++++++++++++++++-----------------------=
----
 target/i386/cpu.h          |    3 +
 tests/test-x86-cpuid.c     |  115 +++++++++++++----------
 vl.c                       |    1=20
 10 files changed, 403 insertions(+), 296 deletions(-)

--
Signature

