Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC7C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4032067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="psS6TzIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4032067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQiw-0001u6-Dc
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCQha-0007AS-Tl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCQhY-0004nT-W7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:54 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com
 ([40.107.92.67]:60352 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCQhY-0004mR-My
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrD/jPml0hZj3MEFHQ9l/6R54d8tDdtUIU7FV43drIxguvLs8gaT67uET/834XNHc85v2G8ns38DtG/UWWU5CuWm+vs1IUJtx37IpNmGRcxvVHj8jraXY5lwKY1/g9rz5BFMDsTWO19OznupgAILgQNnDbbK0HdxRp0LjniSYx6eaH8TZcsSYGLpqQPilTHRE5ylN3CVikLLA03ghSirKaMtAkv6xvwmcIR8hv/8g10GBSOO3fP9pfbZ0MBNI3QJlPbd95MJMW8jpkSzu8l6eRFd9PIlaW5X1KcUNBlMTJ7p/9+XQ0hFvTXFkQikZFqicMPgO10dhFphWOyg4SUhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uEnyJdNmMj2NUolT89z1f2sJr9lvkqb3OSKZgaXucU=;
 b=BcxrOlcyjeGQPAgsb3Hwccd5AlEOGcjM3bKbFnxNs8c9qiAFmNHwqoqvnUsAijCBjcXU8lSv88BuFuolFbk+Pfe2uTxRvCJ3WAH6UMwPo/V5R/Cl22OXy9+SyS25tbYxC5nG+lU1pIvAEVYmMeGm4T20aBp+WaqwIP88osn0QxXPyPswnnmBwfofYl65odqzM5Ns3nmD0Tq7Iq7gfyzI9OkI/7/5KBfu0jR9ziLAk86IO9X4Ku7KZR9aYZiz2wKfd2l13A9Nbd9uduYT5Q2ndeq47DdNJq2R1YDmjLp6v5s8SHGTky4UUx3Nyy5QwotmnsToiIF6gA+SD7X2mYryIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uEnyJdNmMj2NUolT89z1f2sJr9lvkqb3OSKZgaXucU=;
 b=psS6TzIb8to7DwherF2tzHEAK3TyGNe6iHV0flVua87pq6ZZDMI1BfwGZ4QCSJvAKyEe8+AxcbMiVSOVUcgK+QFLhPtgQp7VvbGUiGxkF6XjPZDOrhpGaK3DDqwySF/ZccA9bh8JC7+cwYK7B51rUZQuE/WErO6QnTuzHMS/IZ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2479.namprd12.prod.outlook.com (2603:10b6:802:29::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 16:28:50 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 16:28:50 +0000
Subject: Re: [PATCH v7 00/13] APIC ID fixes for AMD EPYC CPU model
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
Message-ID: <5a90d4e6-5f7f-5a8d-6895-3b5f9890b58b@amd.com>
Date: Thu, 12 Mar 2020 11:28:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:5:100::37) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 16:28:49 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3adf79d5-6575-4f1f-213e-08d7c6a27217
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:
X-Microsoft-Antispam-PRVS: <SN1PR12MB247996752E11B23FFE254ECE95FD0@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(26005)(4326008)(478600001)(8936002)(31686004)(8676002)(81166006)(6486002)(36756003)(316002)(16576012)(81156014)(5660300002)(186003)(66556008)(44832011)(66476007)(16526019)(31696002)(52116002)(2906002)(2616005)(53546011)(956004)(86362001)(966005)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2479;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMXaMhxWcFkZUbNK5kK/oHB2wAbRJ+tmMnmwIcP5kOhbcgtwhO2CZNCUNp+f2cAXiB7FsShYWc2NRZY+A7eEGq8M6Zrom7npaJXojD6Vr1mkmMHPSyA0uO4u3g9OT9lSCQUZI55KWqZtIyhMcSuR3uHWUJd/yP1or1KQGQUNwIrOIhqNJly7s/iBISnuhOso2Qf9Y06Sreo7xBwR/TILrBSflzQd7L8jvJhLdwBks98NcTlu+i5bvYYfO3sRKfk1AXOWxhrOuwdDz3Ro1gkvZE6jG7vCjbe+HSkLOX41sduzZQ959xoqtYaye0jN1LqN6NLpwvn/Wg28EiKNDlEDQOH8OTZbIWHTVsUs86TPufq/jZTtGGAkt3SzIuVkEJ3skENxfeBA1KeJZvxFRbZiX1l3c3RzZR4IWjF08HjXlvWUzt+IEEBG9ezqukj7edhO85lbYlwQmYaWkeGREKS8nccjTCw97bZU93bVkgZQjnb3z1/I3txwZGZnhOpt0iaO/1mpgLA3U2MO+gwN6HsSZQ==
X-MS-Exchange-AntiSpam-MessageData: gCLIkUJOM+w4+SQnfNNEjmTfoR1zD4Dmk7x5VdIuEo94sVne54zTZ0JpTzAshCI5gkUNcz9LUYebwR7hxpAne7HVao+gPZB/YsC4GdMnX26i0ceUQQmeGIOxHXmTl5RmKBbUcrAirXxe3rGJeIG0Vg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf79d5-6575-4f1f-213e-08d7c6a27217
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 16:28:50.2171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKuNciLEr4ocPiVIb34FPQh1zMMLUkexci6oZI4bpY2TQQy90QpH6H9O1LtPvCjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.67
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

Eduardo, Can you please queue the series if there are no concerns.
Thanks

On 3/11/20 5:52 PM, Babu Moger wrote:
> This series fixes APIC ID encoding problem reported on AMD EPYC cpu model=
s.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
>=20
> Currently, the APIC ID is decoded based on the sequence
> sockets->dies->cores->threads. This works for most standard AMD and other
> vendors' configurations, but this decoding sequence does not follow that =
of
> AMD's APIC ID enumeration strictly. In some cases this can cause CPU topo=
logy
> inconsistency.  When booting a guest VM, the kernel tries to validate the
> topology, and finds it inconsistent with the enumeration of EPYC cpu mode=
ls.
>=20
> To fix the problem we need to build the topology as per the Processor
> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> Processors. The documentation is available from the bugzilla Link below.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>=20
> Here is the text from the PPR.
> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize=
], the
> number of least significant bits in the Initial APIC ID that indicate cor=
e ID
> within a processor, in constructing per-core CPUID masks.
> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cor=
es
> (MNC) that the processor could theoretically support, not the actual numb=
er of
> cores that are actually implemented or enabled on the processor, as indic=
ated
> by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Lo=
gicalCoreID[1:0]}
>=20
> v7:
>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-=
next).
>  Changes from v6.
>  1. Added new function x86_set_epyc_topo_handlers to override the apic id
>     encoding handlers.
>  2. Separated the code to set use_epyc_apic_id_encoding and added as a ne=
w patch
>     as it looked more logical.
>  3. Fixed minor typos.
>=20
> v6:
>  https://lore.kernel.org/qemu-devel/158389385028.22020.760824462730313290=
2.stgit@naples-babu.amd.com/
>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-=
next).
>  Changes from v5.
>  1. Eduardo has already queued couple of patches, submitting the rest her=
e.
>  2. Major change is how the EPYC mode apic id encoding handlers are loade=
d.
>     Added a boolean variable use_epyc_apic_id_encoding in X86CPUDefinitio=
n.=20
>     The variable is will be used to tell if we need to use EPYC mode enco=
ding.
>  3. Eduardo reported bysectability problem with x86 unit test code.
>     Quashed the patches in 1 and 2 to resolve it. Problem was change in c=
alling
>     conventions of topology related functions.
>  4. Also set the use_epyc_apic_id_encoding for EPYC-Rome. This model is
>     added recently to the cpu table.
>=20
> v5:
>  https://lore.kernel.org/qemu-devel/158326531474.40452.114337228504255377=
45.stgit@naples-babu.amd.com/
>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-=
next).
>  Changes from v4.
>  1. Re-arranged the patches 2 and 4 as suggested by Igor.
>  2. Kept the apicid handler functions inside X86MachineState as discussed=
.
>     These handlers are loaded from X86CPUDefinitions.
>  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Sugg=
ested
>     by Igor.
>  4. And other minor changes related to patch format.
>=20
> v4:
>  https://lore.kernel.org/qemu-devel/158161767653.48948.105780644828783995=
56.stgit@naples-babu.amd.com/
>  Changes from v3.
>  1. Moved the arch_id calculation inside the function x86_cpus_init. With=
 this change,
>     we dont need to change common numa code.(suggested by Igor)
>  2. Introduced the model specific handlers inside X86CPUDefinitions.
>     These handlers are loaded into X86MachineState during the init.
>  3. Removed llc_id from x86CPU.
>  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code c=
hanges
>     inside the x86.
>  5. Added new handler function apicid_pkg_offset for pkg_offset calculati=
on.
>  6. And some Other minor changes.
>=20
> v3:
>   https://lore.kernel.org/qemu-devel/157541968844.46157.17994918142533791=
313.stgit@naples-babu.amd.com/=20
>   1. Consolidated the topology information in structure X86CPUTopoInfo.
>   2. Changed the ccx_id to llc_id as commented by upstream.
>   3. Generalized the apic id decoding. It is mostly similar to current ap=
ic id
>      except that it adds new field llc_id when numa configured. Removes a=
ll the
>      hardcoded values.
>   4. Removed the earlier parse_numa split. And moved the numa node initia=
lization
>      inside the numa_complete_configuration. This is bit cleaner as comme=
nted by=20
>      Eduardo.
>   5. Added new function init_apicid_fn inside machine_class structure. Th=
is
>      will be used to update the apic id handler specific to cpu model.
>   6. Updated the cpuid unit tests.
>   7. TODO : Need to figure out how to dynamically update the handlers usi=
ng cpu models.
>      I might some guidance on that.
>=20
> v2:
>   https://lore.kernel.org/qemu-devel/156779689013.21957.16315515729506762=
12.stgit@localhost.localdomain/
>   1. Introduced the new property epyc to enable new epyc mode.
>   2. Separated the epyc mode and non epyc mode function.
>   3. Introduced function pointers in PCMachineState to handle the
>      differences.
>   4. Mildly tested different combinations to make things are working as e=
xpected.
>   5. TODO : Setting the epyc feature bit needs to be worked out. This fea=
ture is
>      supported only on AMD EPYC models. I may need some guidance on that.
>=20
> v1:
>   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@am=
d.com/
> ---
>=20
> Babu Moger (13):
>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>       hw/i386: Consolidate topology functions
>       machine: Add SMP Sockets in CpuTopology
>       hw/i386: Remove unnecessary initialization in x86_cpu_new
>       hw/i386: Update structures to save the number of nodes per package
>       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
>       hw/386: Add EPYC mode topology decoding functions
>       target/i386: Cleanup and use the EPYC mode topology functions
>       hw/i386: Introduce apicid functions inside X86MachineState
>       i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition
>       hw/i386: Move arch_id decode inside x86_cpus_init
>       target/i386: Enable new apic id encoding for EPYC based cpus models
>       i386: Fix pkg_id offset for EPYC cpu models
>=20
>=20
>  hw/core/machine.c          |    1=20
>  hw/i386/pc.c               |   15 ++-
>  hw/i386/x86.c              |   73 ++++++++++++----
>  include/hw/boards.h        |    2=20
>  include/hw/i386/topology.h |  195 ++++++++++++++++++++++++++++++--------=
----
>  include/hw/i386/x86.h      |   12 +++
>  softmmu/vl.c               |    1=20
>  target/i386/cpu.c          |  203 ++++++++++++++------------------------=
------
>  target/i386/cpu.h          |    3 +
>  tests/test-x86-cpuid.c     |  116 +++++++++++++++----------
>  10 files changed, 358 insertions(+), 263 deletions(-)
>=20
> --
> Signature
>=20

