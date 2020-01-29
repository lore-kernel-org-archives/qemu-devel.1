Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755662070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eQbsImVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755662070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwq2d-0000Nq-Jp
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwq1m-0008Nq-OH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwq1l-0004hl-CU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:17:18 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com
 ([40.107.223.55]:26961 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwq1l-0004gK-44
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:17:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+TaKH1tT8oGe3WJTzX8RnGvRLlfC3q0GmnpVqlg7L5g6y4bxNYGqtPYaEwhCXDC0mVAuBzjnLQm7Iv8wh8AXRnV7IP4qHmBREVUUbNQpUJETdSe+nMgkN610OraYFu/V1YzHbYOI/ac1zLWHursU6aJnOaHvA/MP5F1oGqlWYmevLqkSU7m3BwhfGtg2bSQLtLoUsdOKRZoqM5C+yjMmWrvpgiLJqQaNTjOP5bTCUM6kbe/LPUkMFb5gvErdvfgsNW6fhjqwXERh6rkBuZsSTd7eh57abudGCfCuPRyrT6aTpaeqTVQjklxvMQvpAnMdWx6AmtEW404n3IbDJIk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMzf5KaQ2Q/A3Pk7dLseHW7q29XHt3IsYzxy84uvFsQ=;
 b=Y7zCUnE/OdtFHs1orA3GcqjTZvu1Hj/iWDxspYX9uBstryE4NhZbU/7AR/TAx3YD2qLfX0/ALOUs49t1N4PsZyR9xra3VHlDGKghaiwwvjR7kgNfwKPSxTOPopi2m7pulEPmmj3daQhI5mt0g6qQb+Mu1v3yLk2+riAZDz9bIip+iXFoxetaWSpVhxo+DIN7vOyOuWaqKeF8UtqMxVCH6rNxaTyqiRLEzLx3PtnM7Ke4ml1v8rD6mPDKuHi+hHxqnb3X0MZnUTd4pHEbxwNFR3CIS2sovVXGwPxA4ql9RBVQZkBEzv9r17hL2bK0kb+7bUcGGBa4XBqOO7+gyBHDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMzf5KaQ2Q/A3Pk7dLseHW7q29XHt3IsYzxy84uvFsQ=;
 b=eQbsImVKXSOX+khjRybB9cXWCsAlqrpJBKfvHJexDlPUJRCW0DJTMoRVmfHgv2jZqgxoBVD9Ux/SR5+m+FulgXk8Eu8zAyKALdE8qzpj6oaa87GYv1oXAXY7lRchLZY8iLR+fLh9T+guDlgvL6InCvmdieL4g+OyQlpv5zZ/Eic=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1496.namprd12.prod.outlook.com (10.172.72.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 16:17:14 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 16:17:14 +0000
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <b75928ec-c062-7edf-bc24-8dc0ccd7439b@amd.com>
Date: Wed, 29 Jan 2020 10:17:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200129101458.6a108431@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN6PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:405:75::38) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23 via Frontend Transport; Wed, 29 Jan 2020 16:17:13 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa77c3f4-fdb8-469f-3ec9-08d7a4d6b3ed
X-MS-TrafficTypeDiagnostic: CY4PR12MB1496:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14966DBED97BCF044307C49D95050@CY4PR12MB1496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(16526019)(186003)(478600001)(5660300002)(81166006)(81156014)(16576012)(44832011)(6916009)(316002)(31686004)(52116002)(31696002)(53546011)(66556008)(6486002)(66476007)(66946007)(8676002)(36756003)(2616005)(86362001)(966005)(26005)(2906002)(956004)(8936002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1496;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKRJyUX+k/HIzC83XVxKPPmqkSf8tXZCYg5cm7U+aieRGcVCI81Krohm79HRrMP3kPqxqoW0TovspFrfukV7P/HtiTe4UcRIkWWK0D0y+hdXo7S+7I5bdfEPGiBdgEWQIFRMxa/hXwo5DdoZvndm/QmIpOEJFCOSfiP33O8UcdZ+Bn4/BGE1LJcFjtAludp5Q+qKNlTKVraxswpqr9QZRsiuY415p6RFAh1IolKiQUwNqt4IjOu8ybp9lVYy+qc5sQleHL60GHG9Fz593EgUrsUrfaVhi84T62V6XONtpeKT1HBPX/IZk/X+ZKXN79kdED1xxREAVIHwrPacvl8hlZHiaS4X2xONNPcnBcmt8rYbfNYEn3T+IbPD6XVO9R321EF3pP1WPPjwUjc+x8fZ5wyt5eZdHXZHEHjVRypKhx+z7uIIwEGU6LP8pbhh6xEt2PTuTIw1Nqh8QIGQs9H3hHVS54G0nLAhcxpKnTGvp9ZMX0zYtYhxa/ISmIjkPV/DQFLLRH1Wi8o9QxxTByqJoQ==
X-MS-Exchange-AntiSpam-MessageData: HFG8xaOflqkfBELPWhJmcw6bMGF/9gimnGL5edGfrHUUnA4fYhyRIH+hQNzCok6c8H0gqxkv4jVx4IdADzebDyWjyPu7+5tEX87uOATiUSsr7WM6wJwvwqIqT0orhu4xsDt2bhO0x/PwM9GIc450Nw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa77c3f4-fdb8-469f-3ec9-08d7a4d6b3ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 16:17:14.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gk2K/FHU3EwkC6dr4/zYp0khBx8SkmAP0lNEe2slHu0VdTrbV68JmQqry8SzpYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1496
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.55
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



On 1/29/20 3:14 AM, Igor Mammedov wrote:
> On Tue, 28 Jan 2020 13:45:31 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> On 1/28/20 10:29 AM, Igor Mammedov wrote:
>>> On Tue, 03 Dec 2019 18:37:42 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>  =20
>>>> Add a new function init_apicid_fn in MachineClass to initialize the mo=
de
>>>> specific handlers to decode the apic ids.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  include/hw/boards.h |    1 +
>>>>  vl.c                |    3 +++
>>>>  2 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index d4fab218e6..ce5aa365cb 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -238,6 +238,7 @@ struct MachineClass {
>>>>                                                           unsigned cpu=
_index);
>>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machi=
ne);
>>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int id=
x);
>>>> +    void (*init_apicid_fn)(MachineState *ms); =20
>>> it's x86 specific, so why it wasn put into PCMachineClass? =20
>>
>> Yes. It is x86 specific for now. I tried to make it generic function so
>> other OSes can use it if required(like we have done in
>> possible_cpu_arch_ids). It initializes functions required to build the
>> apicid for each CPUs. We need these functions much early in the
>> initialization. It should be initialized before parse_numa_opts or
>> machine_run_board_init(in v1.c) which are called from generic context. W=
e
>> cannot use PCMachineClass at this time.
>=20
> could you point to specific patches in this series that require
> apic ids being initialized before parse_numa_opts and elaborate why?
>=20
> we already have possible_cpu_arch_ids() which could be called very
> early and calculates APIC IDs in x86 case, so why not reuse it?


The current code(before this series) parses the numa information and then
sequentially builds the apicid. Both are done together.

But this series separates the numa parsing and apicid generation. Numa
parsing is done first and after that the apicid is generated. Reason is we
need to know the number of numa nodes in advance to decode the apicid.

Look at this patch.
https://lore.kernel.org/qemu-devel/157541988471.46157.6587693720990965800.s=
tgit@naples-babu.amd.com/

static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info=
,
+                                                  const X86CPUTopoIDs
*topo_ids)
+{
+    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
+           (topo_ids->llc_id << apicid_llc_offset_epyc(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
+           topo_ids->smt_id;
+}


The function apicid_from_topo_ids_epyc builds the apicid. New decode adds
llc_id(which is numa id here) to the current decoding. Other fields are
mostly remains same.


Details from the bug https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166

Processor Programming Reference (PPR) for AMD Family 17h Model 01h,
Revision B1 Processors:

"""
2.1.10.2.1.3
ApicId Enumeration Requirements
Operating systems are expected to use
Core::X86::Cpuid::SizeId[ApicIdCoreIdSize], the number of least
significant bits in the Initial APIC ID that indicate core ID within a
processor, in constructing per-core CPUID
masks. Core::X86::Cpuid::SizeId[ApicIdCoreIdSize] determines the maximum
number of cores (MNC) that the
processor could theoretically support, not the actual number of cores that
are actually implemented or enabled on
the processor, as indicated by Core::X86::Cpuid::SizeId[NC].
Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
=E2=80=A2 ApicId[6] =3D Socket ID.
=E2=80=A2 ApicId[5:4] =3D Node ID.
=E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
=E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} :
{1'b0,LogicalCoreID[1:0]}.
"""

>=20
>>
>>>
>>>  =20
>>>>  };
>>>> =20
>>>>  /**
>>>> diff --git a/vl.c b/vl.c
>>>> index a42c24a77f..b6af604e11 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
>>>>      current_machine->cpu_type =3D machine_class->default_cpu_type;
>>>>      if (cpu_option) {
>>>>          current_machine->cpu_type =3D parse_cpu_option(cpu_option);
>>>> +        if (machine_class->init_apicid_fn) {
>>>> +            machine_class->init_apicid_fn(current_machine);
>>>> +        }
>>>>      }
>>>>      parse_numa_opts(current_machine);
>>>> =20
>>>>
>>>> =20
>>>  =20
>>
>=20

