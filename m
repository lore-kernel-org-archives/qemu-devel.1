Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD86C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F2A215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1HrpHzzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2A215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBlB0-00041G-Cb
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBlAF-0003cl-Hb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBlAD-0002FK-Pd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:07:43 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com
 ([40.107.92.44]:6443 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBlAD-0002Ec-KC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoQxp/aH2vZp4abnTU4XBx2goRMnZy7YKejlp70bnNcpU1PfP/Ul0B9vG30iFPeBJ/nJx6G8ugFAjRiHcCk+mGec5nc3erq+Ortbzy4S1oKsJQQiRMVFHd7H01Qfq0241QPU1TzxbDgFkKkohDafKcjqZop+cGufGAxE0UXG7c0lO14+LePlhOvteHCgQ30gNugQL3G0LGGbZt+jHk5iu6vG4XwiAFntKkzUAdG/EqzWGSNpvGCqwXcTu0ETSgDyeYkEIc6HrLvUeAyy4igfnb5VhnStcbmsQ3JCzblz5SL8XNs0t8pQX/2wR/CRcXeLE3Mw5RBZ8jjchdHHAObb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uppF8cTC6g6PjThmrZCrm/i/p3iQLpNeyiWyP5PVgw=;
 b=X/Cqgvy7r/eYVeRxvD6lWeYVvig3uMFj8BX+NMc0tFh+6U7NAHannLcY71p4aooIpEJZ0FZvfXK3jwYI0DcM2U17atMTh0TASCjAX7WmyR6cZopzvf5qmrZKnmMLSq95MAMR8Dm+y3tf9mWe5yKucOLJIZDnUo04BmxU0MmiKRoeb4SXpmaw1m+LpYVnyiaREVmF86klt8QIZmfv/XLtvgti318KVHBBS9EzyH9K21/jdgTVPT5IL9dnz/Kli0cvD0VLoOmGhvuBU/5QRM1nYVrYCTIEIQvzyUouV9aY1qpEE3sHukukT3E6lu6jH43nXG0TCDi96A0KrJ1V1XdSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uppF8cTC6g6PjThmrZCrm/i/p3iQLpNeyiWyP5PVgw=;
 b=1HrpHzzlE0vanNQ0Nb0DoJjHSexUKFmrN7S6+PJczN0q8bclo+InBE+Aw/X5rWsY/Y6Yg/9cDSA4QTjW7vvyKLR79sczbLqCrl6JG/y76r+AT6s0RQQ1yzajB8/ihhlhzCeCO263fEfniFMUN1rVJGtL0Cm0o12KSYQbXcDLGS4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 20:07:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:07:39 +0000
Subject: Re: [PATCH v5 00/16] APIC ID fixes for AMD EPYC CPU model
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <20200310094027.48738e0e@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f5510cdb-c513-b49b-38ca-caed7cdcd194@amd.com>
Date: Tue, 10 Mar 2020 15:07:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200310094027.48738e0e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0501CA0109.namprd05.prod.outlook.com (2603:10b6:803:42::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.6 via Frontend
 Transport; Tue, 10 Mar 2020 20:07:38 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86cd8e3d-68d4-489f-a584-08d7c52eaeee
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241698F50B4D53F299C0395595FF0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(4326008)(186003)(86362001)(52116002)(81166006)(44832011)(478600001)(6916009)(16526019)(8936002)(53546011)(16576012)(31696002)(26005)(81156014)(316002)(36756003)(5660300002)(956004)(6486002)(2616005)(966005)(2906002)(66476007)(8676002)(31686004)(45080400002)(66946007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2416;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96jBhYxJDaUu6xleXFwpzs6H4B+X1WR0KXRORxWWWOwOkvN4lD3Z83teGTTWsvXx0anDXfSHw6DPNxPP9tXdPZknM6LuvtddZ+1kyQAWrXgIhSpi3jQhP7/t0pu+lCGhU0LxUuglp+4YeXlHgzV+kBtrIHfdZQwTFQdHa24nvT/Egh2iFRQ3dT42S4fOGn1O98d9ReGJDNnroxmICW9psw27LoFasviAbVnf1ha4JVQeu+DhOdFjyZTLdwEwyAblez4G7xmZCOHh6LqTdpYPfZ3Gl19fbnHqCyncux3feB5L3C+Yl6yjKiSbRLx1dp0Bbti+8430mVcTUiXW7oVKZ5m2SPrDenj+2OcnmNlaDNAMNi81or1T8ZB1VyeqSwk3gzT7yq/6UubkFT4+KJ8+wQmnFd21+QpLDx1jcp9y8KXEDJBYQ4ALRVpTvPNVCO4XGCqeYk6XwTDlR0lR6S9n9v0OYn+ID2SIyplyCtvwMZboV9y0KCkES/PZWvlpqsm++x+XCLhmMaXjL9txJp+TSg==
X-MS-Exchange-AntiSpam-MessageData: Wegl9/YiISZ9AKFbYEd301I60c47j+ABs30OYWdzOPiYpuHlWt42QhCzWfWqjdn4pdeowV6pbc1Kpu1caWi7W6iSTObKcmZEtUgvDVhGecH56wWBXqIexHOdHUpBmOP5G0sn6jxQ2MoNmLOeRNGIYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cd8e3d-68d4-489f-a584-08d7c52eaeee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:07:39.1976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqJ4PzrOVIzkNesHG+bvpav3+XuKhj1rwHyrNE1UZn1dIGt+m62Q4daE1JrXmFwa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.44
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/10/20 3:40 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:56:51 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> This series fixes APIC ID encoding problem reported on AMD EPYC cpu mode=
ls.
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz=
illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.mog=
er%40amd.com%7C45a40d6e3f3e43db7f1c08d7c4ceb6ea%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637194264422137307&amp;sdata=3DaK22ORKQVO91LQg8S5HLIkwokh=
Sr1gZtbiPBT6f1xfY%3D&amp;reserved=3D0
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
u.moger%40amd.com%7C45a40d6e3f3e43db7f1c08d7c4ceb6ea%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637194264422137307&amp;sdata=3DyRvpeioi434loufborv7Z=
emhIezNEF2yv9Lt1740Gn4%3D&amp;reserved=3D0
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
>>
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
0naples-babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C45a40d6=
e3f3e43db7f1c08d7c4ceb6ea%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371=
94264422137307&amp;sdata=3DMk0f4lBq8dqfowge9Bqab8b%2B89eGFJBU6XJs6S%2F5CKQ%=
3D&amp;reserved=3D0
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
40naples-babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C45a40d=
6e3f3e43db7f1c08d7c4ceb6ea%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
194264422137307&amp;sdata=3DHa6v2Bwa%2BiIChPxIeJhuzsr%2F9VEa5%2BB73l90ABPhp=
gg%3D&amp;reserved=3D0=20
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
0localhost.localdomain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C45a40=
d6e3f3e43db7f1c08d7c4ceb6ea%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7194264422137307&amp;sdata=3Dq1KrQrdSHBul%2F36gx5eBZZTeK%2Bv3FQWxOMi7SfVcFg=
Y%3D&amp;reserved=3D0
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
&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C45a40d6e3f3e43db7f1c08d7c4ceb6=
ea%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637194264422137307&amp;sdat=
a=3D0EVG%2Ba3uJHkTtYlcOyU%2F%2BMLOM7nksU3pkSG1ocZIZdU%3D&amp;reserved=3D0
>=20
> There will be soft freeze soon,
> if you respin it soon, I'll review it ASAP.
> I hope there won't be anything to amend, so
> we could try merging it this week (otherwise
> it will be postponed till next release).

Ok. Will send it ASAP.

>=20
> I guess it should go via Eduardo's tree.
>=20
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
>>
>=20

