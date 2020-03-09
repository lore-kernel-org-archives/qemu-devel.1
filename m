Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD53E20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zzU8mCmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD53E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMYQ-0001Jt-0T
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBMXm-0000qF-FH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBMXk-0003nU-N2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:50:22 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com
 ([40.107.244.45]:6227 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBMXk-0003ld-CW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRT6qk61KBztDLCkenWKXuGOGhAwbgHSDqbQ7JUY29KveJOyEojFd96Ai9Hat1BZ1tp11u8WUkw7OhZmNJauIyFto0b7/Lnl9uu5gwSIr+rpEZC5dnaqBWjRqJbDYT4zfs7+/kdNCfOQ0afuQ3CvF9IIIZQwuPeSUjWKawJ+XTj+c2WFWKpAF1JxRAnwADzF0CpAgJGhWVwm5Ko5S3K/5QoQNvpVmpJ9G8MahzbiNL524+Mu8OWjOuEYCumzcjosW+PRHtpoyJf3papkzN4N1LEZK8IONkNFsJDIGHd0R7PkkZXjxEg/4AspbmksSdOMu7jg0xbe63qylgMsMtg0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjy4D//uyfzCzdZ2TxRUM2oW4Qpb0n/VBZKlbPGMJTw=;
 b=cYZF0FsfPAClzS63+1iKcQJJdK4kCk9+oClWG9P879Rz4DKnfSzyauW8sMdm6SFIyY1JWDd7Qod2dmcSyrhEAKoBUDtNdG1BKZEi1eoNU4+Dgp+28XY+gQKTQB6M54I4oPWbsCmlPZj1vyJq63cd1syEmnS7uUaGV/eXvniYru3WdLe88g4cS9YlZfj+XhbuqcpxRos/z9hlEzu8gXKYYTMy2ZfIOXlpy7kZQW8GRmg7h1aA2XuYb5BR/dvQ72MUnYOO8zRW6F9DiMbNgGFgedXEOY5rdfYaYZFnrcvBoYKf++zcqybLyYJUuva4lQkrVJl+G7awRfHhAAQ5mtJvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjy4D//uyfzCzdZ2TxRUM2oW4Qpb0n/VBZKlbPGMJTw=;
 b=zzU8mCmKKsqn8HEvq+9mp/jcHBGyXUzinIKOGE6p2EYQeJl0vPnosmzJ80L0hdEh4NlH4pbqoeD7xmExHREBGGXNKhsErwfLauzCi1oBbPnTX/RUYR/b/lONlCfkkIxB0hT35IqfDTG2fchUH6WyMuaJrtbuD6YQwKZPHhcTopo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 17:50:18 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:50:17 +0000
Subject: Re: [PATCH v5 00/16] APIC ID fixes for AMD EPYC CPU model
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <20200308092458-mutt-send-email-mst@kernel.org>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <2f50e705-eb89-05ac-f8e6-4d8f69372627@amd.com>
Date: Mon, 9 Mar 2020 12:50:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200308092458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:3:117::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0058.namprd13.prod.outlook.com (2603:10b6:3:117::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.7 via Frontend Transport; Mon, 9 Mar 2020 17:50:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b470edf1-6194-4024-e3d2-08d7c4525422
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446F5073D840E427D96880A95FE0@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(199004)(189003)(52116002)(31696002)(66556008)(66946007)(2906002)(66476007)(53546011)(86362001)(45080400002)(4326008)(966005)(8676002)(8936002)(81156014)(478600001)(81166006)(5660300002)(31686004)(6916009)(16576012)(316002)(6486002)(186003)(16526019)(26005)(44832011)(2616005)(956004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2446;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+UnqNCvqhZ7QS4Iwh1Kzh2H4TP39ubSBwthdbEFmNNalljUul5SpYZiw+6h/i31s5TMAhx2vUDxeGybRCNlCz8ShrDuVf6cRwfK5IfGlinfmVRPBewg/1UFX4XglrxrdS1kwK6swIvHQ0AGHdyHo+cISianrIiz5dQ9fmFDN871x8TZiYENHbGkJsyksFz5KH+AHOCdPuoZK28Dowo2/YP6f6TAEwLu4pL5QCVwCSCuqiJ5obAB0Zamfb6XKuwniXhkJtpp0c73jwsbstzfJH6BK9cH2VNqO024lSEWgsmVBmqNKIDUJHQPLe1EL2K66CHivrGjAe5QqhzdfhfWT3L0O5EMjVQk0aobtVXfcOAGuCdfLQ6nUTiOYchM32GWRS5S3HE/4brOk9o6bWSnDwV5FC4atQ6dbs5rmGGIoC3+P5SQ2YHM2yrWb0kVgv5NgNMybvD3br8mCmdMyeQJuUAW6bcusmcLDqtTS+H1yPe6rM2iDaQgthsn24g1CuVzmutke/XVcCB6UmzEyo5SeQ==
X-MS-Exchange-AntiSpam-MessageData: 8B+6Sv+6LJNpUrQWBMtjCM2RonQtgfGlkS05UThPCZa0RE3cl6RQk2OP+Dt2KqGFjsWhQHWHZCKwXKapem6D0AUcCqOzgXZmPFDjgDY9FjyCJ8p15A/AUEVfKxw8uG06U6ivQ460Fgrc0VJK3+L/Ww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b470edf1-6194-4024-e3d2-08d7c4525422
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 17:50:17.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhIvzTS70067FmMmFD5Pgd4/t/vJrtwX0Cxfr/ZU/Hoi2clPOviX/v7B01Bf5+Cy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.45
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/8/20 8:25 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 03, 2020 at 01:56:51PM -0600, Babu Moger wrote:
>> This series fixes APIC ID encoding problem reported on AMD EPYC cpu mode=
ls.
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz=
illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.mog=
er%40amd.com%7C9176c1cef91b4ece2b5e08d7c3643a0a%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637192707563033288&amp;sdata=3Dr%2Frpma42Ms356HFtNthqJNI3=
CiQBEfI%2BNWsWCr%2BabV0%3D&amp;reserved=3D0
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
>> Processors. The documentation is available from the bugzilla Link below.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D02%7C01%7Cbab=
u.moger%40amd.com%7C9176c1cef91b4ece2b5e08d7c3643a0a%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637192707563033288&amp;sdata=3DPWj8%2FEcBYPmcJVg4qgb=
f%2BPZ1VbLzqXgAiQ7ujtfFp90%3D&amp;reserved=3D0
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
> Looks reasonable:
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Michael.Thanks
>=20
> belongs in Eduardo's tree I guess.
>=20
>> v5:
>>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86=
-next).
>>  Changes from v4.
>>  1. Re-arranged the patches 2 and 4 as suggested by Igor.
>>  2. Kept the apicid handler functions inside X86MachineState as discusse=
d.
>>     These handlers are loaded from X86CPUDefinitions.
>>  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Sug=
gested
>>     by Igor.
>>  4. And other minor changes related to patch format.
>>
>> v4:
>>  https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Fqemu-devel%2F158161767653.48948.10578064482878399556.stgit%4=
0naples-babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C9176c1c=
ef91b4ece2b5e08d7c3643a0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371=
92707563033288&amp;sdata=3DbKJ2d%2Blhxm%2Bht7hZBsQpHtFOaee3FHwA0ploz%2BNpPu=
w%3D&amp;reserved=3D0
>>  Changes from v3.
>>  1. Moved the arch_id calculation inside the function x86_cpus_init. Wit=
h this change,
>>     we dont need to change common numa code.(suggested by Igor)
>>  2. Introduced the model specific handlers inside X86CPUDefinitions.
>>     These handlers are loaded into X86MachineState during the init.
>>  3. Removed llc_id from x86CPU.
>>  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code =
changes
>>     inside the x86.
>>  5. Added new handler function apicid_pkg_offset for pkg_offset calculat=
ion.
>>  6. And some Other minor changes.
>>
>> v3:
>>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Fqemu-devel%2F157541968844.46157.17994918142533791313.stgit%=
40naples-babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C9176c1=
cef91b4ece2b5e08d7c3643a0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
192707563043283&amp;sdata=3D90dNqhJMpQiyv4KdBfuf9hxX8EHFesJUT5jxSnuU84E%3D&=
amp;reserved=3D0=20
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
0localhost.localdomain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C9176c=
1cef91b4ece2b5e08d7c3643a0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7192707563043283&amp;sdata=3DtKtt4Kz599IkFhyObyg9%2FVC3BEKPjo4KAGi%2BsdVe9z=
M%3D&amp;reserved=3D0
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
&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C9176c1cef91b4ece2b5e08d7c3643a=
0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192707563043283&amp;sdat=
a=3Dbiydl3JXU0YGLK%2FY7sXtSbdCcb7P4Qjl40Kr0Fp5CEc%3D&amp;reserved=3D0
>>
>> ---
>>
>> Babu Moger (16):
>>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>>       hw/i386: Consolidate topology functions
>>       machine: Add SMP Sockets in CpuTopology
>>       hw/i386: Remove unnecessary initialization in x86_cpu_new
>>       hw/i386: Update structures to save the number of nodes per package
>>       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
>>       hw/386: Add EPYC mode topology decoding functions
>>       target/i386: Cleanup and use the EPYC mode topology functions
>>       hw/i386: Introduce apicid functions inside X86MachineState
>>       target/i386: Load apicid model specific handlers from X86CPUDefini=
tion
>>       hw/i386: Use the apicid handlers from X86MachineState
>>       target/i386: Add EPYC model specific handlers
>>       hw/i386: Move arch_id decode inside x86_cpus_init
>>       i386: Fix pkg_id offset for EPYC cpu models
>>       tests: Update the Unit tests
>>
>>
>>  hw/core/machine.c          |    1=20
>>  hw/i386/pc.c               |   54 ++++++-----
>>  hw/i386/x86.c              |   72 ++++++++++----
>>  include/hw/boards.h        |    2=20
>>  include/hw/i386/topology.h |  215 ++++++++++++++++++++++++++++++-------=
-----
>>  include/hw/i386/x86.h      |   12 ++
>>  target/i386/cpu.c          |  224 +++++++++++++++++--------------------=
-------
>>  target/i386/cpu.h          |    3 +
>>  tests/test-x86-cpuid.c     |  115 +++++++++++++----------
>>  vl.c                       |    1=20
>>  10 files changed, 403 insertions(+), 296 deletions(-)
>>
>> --
>> Signature
>=20

