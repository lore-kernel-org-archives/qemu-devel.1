Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ECDC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2742080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rLBqf1UR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2742080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyhSW-0003NB-SX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 14:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iyhRb-0002jy-Cy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iyhRZ-0006g9-9n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:31:39 -0500
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com
 ([40.107.237.43]:8096 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iyhRX-0006aa-9I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:31:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V77sSa10fS/p1PwvcNfbk2PpBTRozGKfaaLCC2FvPW1+2jglEAJvBrKCtkNAxomeQbV8FxFsQH03NzgO7OgcvrUGSqo0UjGphg6UV3dWowFT+vmT/NFPT7NAxDFZK0sub6r4LljOpGA3kFo2jMRiM4h82+XAWzclgp3eNkFmSk8T2LbmToAo6qSoozKJoy6HMa7ULeGI3S+vlf2doxFuXlSUZ1vyzjxlBjdUJ2q+QFFZy3j52nE3ygY/j7/WeuJVWFv4rdL9mAAKGdzL/oX9TYhe71WWpMYjzZmdEyoSnZATKp47bsrTBa8m4Jgw6Wb8VYBqbDc6t+KMRxox70CNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3WlIRDL0ozsUwwCbr11zjR4qIB/PbZlnNHwzgjvYEc=;
 b=eZGSmfMRp36iXqX4b3lJbsVZ3SG45nneLJOSmO0slPVMli3RaqvN69ncX9/U7TToshl0zqK2Ha39lV+HKz/2p8YI9Oo10aZ3Ssh+SMae4kw7GjVtdg0tavo8xKki2PEDO3DhhFBHxgOmUZ4TgLKgXpKDGyKr+oJUVBQ56t2EFamDBf11F0EVm8ZU9Oyn6Z7YkXbyUJfWKzeInQxuzJgR1RtwliJhei1hhhQLExmY5BjoL6u8xIJESJNpxiv/sinKN7N0AJSlD8//fUYldqpNm46sNrqjPqVotlPdO/mfA++MF1ydfkbltfFllLAyKgcbG0dLzcGM5eK5Hk03IHLxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3WlIRDL0ozsUwwCbr11zjR4qIB/PbZlnNHwzgjvYEc=;
 b=rLBqf1UR7vwFlsbbbJ4P/QkuaW+l8wUHNycbLXllxpsvx4Tc4x8HSKJwJPBNee/sANvUFyz6ZGKvuGG2fuLgyCvA7WOvoOHFgLrITDygkdjMpNUDxiOoLC+84A9+9gZIQs7JnQATN2Rilkig+AjeOE3yM2brofHL/2CcmohGRkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1399.namprd12.prod.outlook.com (10.168.164.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 19:31:32 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 19:31:31 +0000
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
Date: Mon, 3 Feb 2020 13:31:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200203155921.658d7765@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN1PR12CA0081.namprd12.prod.outlook.com (2603:10b6:802:21::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Mon, 3 Feb 2020 19:31:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd2cf83a-4d00-4be5-1300-08d7a8dfac15
X-MS-TrafficTypeDiagnostic: CY4PR12MB1399:
X-Microsoft-Antispam-PRVS: <CY4PR12MB139913D657743F6CC65C94B595000@CY4PR12MB1399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(81156014)(81166006)(316002)(52116002)(6916009)(478600001)(8936002)(2616005)(31696002)(966005)(44832011)(2906002)(53546011)(956004)(45080400002)(8676002)(31686004)(186003)(6486002)(36756003)(16576012)(86362001)(66476007)(5660300002)(16526019)(26005)(66946007)(4326008)(66556008)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1399;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4B+NZ2tKuskAtpchXCVqpVnY+eV24kSyHKEf6WYZwzFclIUYZZYf7Zu3PACwzM7rj+HWfOr5Gt/r+AQQxhSB3ZnoT4AdXFfOaA3g4s0qUnV7b26zpDTxuN2+btYQqFRgVqwE5L78tnAZWxlSAyhwBl6S+tV6llnJ/HrdPR+SaXOtNQVHoeDYO/1g5v6cUlqkDUBYD840chanFKr6zhVxkLtbNwIjrf3iFVQ6FZdnrc7+aLmrE4KCJQsTon2yJsRFETY5qetT3vCHlGhq3AdiRb88LzCDtD1QeCnSbjBzzffRVSTk0jZAYZ9CE2y1LN9cQNNUxu9WJO7ootLOSC6D26ltTmHWibxbhUPaxkr9RTnKbLhBOSgF4kI3wm9ov+7aBVNWzvZ1xa288C+zYCc1UhgNcEirH6e+qtUMl8FYsRM84DwQOptlMZGfv/v2nb7B6MrfziB6MyPPhDD4mMKwkkSiO2GR3r+2fE6SKjjNuzZ/XhfWqTrEv2cSa5MR2MC3NHK705atSAvFCBlOQ1vdQW3QBoI/cVJrCaykSwAdMLmtzibp3XXMMkViUxzmS+Lq
X-MS-Exchange-AntiSpam-MessageData: A1OPhdVGCMNgTWpOgD55nTT4iQeDxLbW6wwbiRF8yLIA0KDr60p9tmqrqnlY8W1fNv6o7eIUYqJGnKqSd/koUelml50fSmE/jYVkz/Gj0oYdh3IMbbJyTstDoBJIYCcRndWX4PbZd9aoqKBydLBE0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2cf83a-4d00-4be5-1300-08d7a8dfac15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 19:31:31.8408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OygvyxO57V6NbKztlvSKHzob+DX6ARadLt7ucWlqBFECyFPm+K4OTMZXud6dKoCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1399
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.43
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/20 8:59 AM, Igor Mammedov wrote:
> On Tue, 03 Dec 2019 18:36:54 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz=
illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.mog=
er%40amd.com%7C50685202e372472d7b2c08d7a8b9afa6%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637163387802886193&amp;sdata=3DN%2FaBBZ8G3D1gCNvabVQ%2Fra=
HvINazcVeEc9FWdxQAWmg%3D&amp;reserved=3D0
>>
>> Currently, the APIC ID is decoded based on the sequence
>> sockets->dies->cores->threads. This works for most standard AMD and othe=
r
>> vendors' configurations, but this decoding sequence does not follow that=
 of
>> AMD's APIC ID enumeration strictly. In some cases this can cause CPU top=
ology
>> inconsistency.  When booting a guest VM, the kernel tries to validate th=
e
>> topology, and finds it inconsistent with the enumeration of EPYC cpu mod=
els.
>>
>> To fix the problem we need to build the topology as per the Processor
>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
>> Processors. It is available at https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55570-=
B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C50685202e372472d7b2c=
08d7a8b9afa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63716338780288619=
3&amp;sdata=3DMcjyMS3A3x5Jr57VxJmHDyh5jumdybzW%2FwLtE4FAKHQ%3D&amp;reserved=
=3D0
>>
>> Here is the text from the PPR.
>> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSiz=
e], the
>> number of least significant bits in the Initial APIC ID that indicate co=
re ID
>> within a processor, in constructing per-core CPUID masks.
>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of co=
res
>> (MNC) that the processor could theoretically support, not the actual num=
ber of
>> cores that are actually implemented or enabled on the processor, as indi=
cated
>> by Core::X86::Cpuid::SizeId[NC].
>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
>> =E2=80=A2 ApicId[6] =3D Socket ID.
>> =E2=80=A2 ApicId[5:4] =3D Node ID.
>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,L=
ogicalCoreID[1:0]}
>=20
>=20
> After checking out all patches and some pondering, used here approach
> looks to me too intrusive for the task at hand especially where it
> comes to generic code.
>=20
> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify without readi=
ng
> reasoning behind it first)
>=20
> Lets look for a way to simplify it a little bit.
>=20
> So problem we are trying to solve,
>  1: calculate APIC IDs based on cpu type (to e more specific: for EPYC ba=
sed CPUs)
>  2: it depends on knowing total number of numa nodes.
>=20
> Externally workflow looks like following:
>   1. user provides -smp x,sockets,cores,...,maxcpus
>       that's used by possible_cpu_arch_ids() singleton to build list of
>       possible CPUs (which is available to user via command 'hotpluggable=
-cpus')
>=20
>       Hook could be called very early and possible_cpus data might be
>       not complete. It builds a list of possible CPUs which user could
>       modify later.
>=20
>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,node_id=
=3Dx,cpus=3D"
>       options to assign cpus to nodes, which is one way or another callin=
g
>       machine_set_cpu_numa_node(). The later updates 'possible_cpus' list
>       with node information. It happens early when total number of nodes
>       is not available.
>=20
>   2.2 user does not provide explicit node mappings for CPUs.
>       QEMU steps in and assigns possible cpus to nodes in machine_numa_fi=
nish_cpu_init()
>       (using the same machine_set_cpu_numa_node()) right before calling b=
oards
>       specific machine init(). At that time total number of nodes is know=
n.
>=20
> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to be d=
efined before
> boards init() is run.
>=20
> In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu_nod=
e_id()
> which uses arch_id calculate numa node.
> But then question is: does it have to use APIC id or could it infer 'pkg_=
id',
> it's after, from ms->possible_cpus->cpus[i].props data?

Not sure if I got the question right. In this case because the numa
information is not provided all the cpus are assigned to only one node.
The apic id is used here to get the correct pkg_id.

>  =20
> With that out of the way APIC ID will be used only during board's init(),
> so board could update possible_cpus with valid APIC IDs at the start of
> x86_cpus_init().
>=20
> =3D=3D=3D=3D
> in nutshell it would be much easier to do following:
>=20
>  1. make x86_get_default_cpu_node_id() APIC ID in-depended or
>     if impossible as alternative recompute APIC IDs there if cpu
>     type is EPYC based (since number of nodes is already known)
>  2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based
>=20
> this way one doesn't need to touch generic numa code, introduce
> x86 specific init_apicid_fn() hook into generic code and keep
> x86/EPYC nuances contained within x86 code only.

I was kind of already working in the similar direction in v4.
1. We already have split the numa initialization in patch #12(Split the
numa initialization). This way we know exactly how many numa nodes are
there before hand.
2. Planning to remove init_apicid_fn
3. Insert the handlers inside X86CPUDefinition.
4. EPYC model will have its own apid id handlers. Everything else will be
initialized with a default handlers(current default handler).
5. The function pc_possible_cpu_arch_ids will load the model definition
and initialize the PCMachineState data structure with the model specific
handlers.

Does that sound similar to what you are thinking. Thoughts?

>=20
>> v3:
>>   1. Consolidated the topology information in structure X86CPUTopoInfo.
>>   2. Changed the ccx_id to llc_id as commented by upstream.
>>   3. Generalized the apic id decoding. It is mostly similar to current a=
pic id
>>      except that it adds new field llc_id when numa configured. Removes =
all the
>>      hardcoded values.
>>   4. Removed the earlier parse_numa split. And moved the numa node initi=
alization
>>      inside the numa_complete_configuration. This is bit cleaner as comm=
ented by=20
>>      Eduardo.
>>   5. Added new function init_apicid_fn inside machine_class structure. T=
his
>>      will be used to update the apic id handler specific to cpu model.
>>   6. Updated the cpuid unit tests.
>>   7. TODO : Need to figure out how to dynamically update the handlers us=
ing cpu models.
>>      I might some guidance on that.
>>
>> v2:
>>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Fqemu-devel%2F156779689013.21957.1631551572950676212.stgit%4=
0localhost.localdomain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C50685=
202e372472d7b2c08d7a8b9afa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7163387802886193&amp;sdata=3Dls1cxA1yh0P05zYsAf3sLXDM11DFHtxZvfWWaar7Mgg%3D=
&amp;reserved=3D0
>>   1. Introduced the new property epyc to enable new epyc mode.
>>   2. Separated the epyc mode and non epyc mode function.
>>   3. Introduced function pointers in PCMachineState to handle the
>>      differences.
>>   4. Mildly tested different combinations to make things are working as =
expected.
>>   5. TODO : Setting the epyc feature bit needs to be worked out. This fe=
ature is
>>      supported only on AMD EPYC models. I may need some guidance on that=
.
>>
>> v1:
>>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Fqemu-devel%2F20190731232032.51786-1-babu.moger%40amd.com%2F=
&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C50685202e372472d7b2c08d7a8b9af=
a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163387802886193&amp;sdat=
a=3DnT4T9RIL4EeSvB%2Ff9%2BjbU7lldopjglQ2X6uYx13WMPE%3D&amp;reserved=3D0
>>
>> ---
>>
>> Babu Moger (18):
>>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>>       hw/i386: Consolidate topology functions
>>       hw/i386: Introduce initialize_topo_info to initialize X86CPUTopoIn=
fo
>>       machine: Add SMP Sockets in CpuTopology
>>       hw/core: Add core complex id in X86CPU topology
>>       machine: Add a new function init_apicid_fn in MachineClass
>>       hw/i386: Update structures for nodes_per_pkg
>>       i386: Add CPUX86Family type in CPUX86State
>>       hw/386: Add EPYC mode topology decoding functions
>>       i386: Cleanup and use the EPYC mode topology functions
>>       numa: Split the numa initialization
>>       hw/i386: Introduce apicid_from_cpu_idx in PCMachineState
>>       hw/i386: Introduce topo_ids_from_apicid handler PCMachineState
>>       hw/i386: Introduce apic_id_from_topo_ids handler in PCMachineState
>>       hw/i386: Introduce EPYC mode function handlers
>>       i386: Fix pkg_id offset for epyc mode
>>       tests: Update the Unit tests
>>
>>
>>  hw/core/machine-hmp-cmds.c |    3 +
>>  hw/core/machine.c          |   14 +++
>>  hw/core/numa.c             |   62 +++++++++----
>>  hw/i386/pc.c               |  132 +++++++++++++++++++---------
>>  include/hw/boards.h        |    3 +
>>  include/hw/i386/pc.h       |    9 ++
>>  include/hw/i386/topology.h |  209 +++++++++++++++++++++++++++++++------=
-------
>>  include/sysemu/numa.h      |    5 +
>>  qapi/machine.json          |    7 +
>>  target/i386/cpu.c          |  196 ++++++++++++-------------------------=
----
>>  target/i386/cpu.h          |    9 ++
>>  tests/test-x86-cpuid.c     |  115 ++++++++++++++----------
>>  vl.c                       |    4 +
>>  13 files changed, 455 insertions(+), 313 deletions(-)
>>
>> --
>>
>=20

