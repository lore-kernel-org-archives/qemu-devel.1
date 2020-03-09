Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706AC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58D021D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kH64GO+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58D021D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNq1-0002c0-RP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNp2-0001ju-O7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNp1-0002YW-Hf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:16 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com
 ([40.107.93.41]:6059 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBNp1-0002Xo-Bv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrhj5rISD+75JI1f2G04uw7mo48TZfkymVY4DslEBiCNkW3vuRt6DmHcu4h4X5ERSJUHvkvTT3ZHT2e21wMA3RaJiA6vXzjrssOfhSX2KpKgeTNONJEbxPbvOIzUE3tpKCK0A9lVywnnURPGqbAGXt81VXcjZm0lhrSYhcHi+MPh5xjrpMGdMs4zaUzRzie5OQY7rzYgeIfbLov4V8Bu30SZVFeDnD+vr7WTaSEwAVgr5aB/X7TilqCGGX1NKPElz+I7xNUseN/tuSz1S4oggBTUm5JjD9PvXp4cwU5fLcmgya0yLr8YgCo1pl3csubRaUMCsSxbo4ihtvs5M3hgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqNaDJdt4TxjCzzrt3l6OYkcg4B8wAQAOlcK1/hrqeg=;
 b=KIJvjZKpknSNvmbREOoIp/S3R4LdhSVBiHRUG2oHoXmJJqMhRsDWqMc40JmMmUANdcWK2WTFRfwgmrIsLzh1+4WwjGoqNd1XrJKlGNJRleSX3nTWD/mQVWdtOHvepmCcqCtBokGWqcVwb3jyZkgFuBpHxUbM2N5N2+8vSbmXqb7uqhSJ8k6fBVNbzgezhp/7IAo4BEwJKCAXmd5P5kjFnXMdc4Y2T1PZR9gEAeEzmc1oiOmn++FjOi/d9bX2geOVIVIetFvmlkoCEHjtl+lr1TX8NhjhJHUtlAAccup+4Lnw/zeCbjXAbb1vEHcciTyAPbKKAPFWhiskKPHGAQjt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqNaDJdt4TxjCzzrt3l6OYkcg4B8wAQAOlcK1/hrqeg=;
 b=kH64GO+mLii56QZsJhLHOBwSXxC2OrEZ1m9DaDUSZqLG1g4FpljuIYD5FpYqXNbj68IgjtdlVhWbt8v64VnVLhrIBkEgbhExOYb6l1PVqd1hK/xecfwD/N1qTSy/FgpoA6cudHzA1xFya0nfOLfnuoyStBRYtg/BxaRXxjuhQ+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 19:12:13 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:12:13 +0000
Subject: Re: [PATCH v5 13/16] target/i386: Add EPYC model specific handlers
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326549681.40452.14219781294371149597.stgit@naples-babu.amd.com>
 <20200309160301.00243403@Igors-MacBook-Pro>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <df9e6525-f9a7-2f98-d5b4-985efc634335@amd.com>
Date: Mon, 9 Mar 2020 14:12:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309160301.00243403@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:3:103::13) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR12CA0051.namprd12.prod.outlook.com (2603:10b6:3:103::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 19:12:12 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c7ca233-a7b2-4217-95d5-08d7c45dc5e8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2381DF8B263F7F36A932703995FE0@SN1PR12MB2381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(8936002)(8676002)(6916009)(81166006)(81156014)(316002)(31686004)(6486002)(45080400002)(5660300002)(478600001)(66946007)(66476007)(66556008)(2616005)(44832011)(966005)(186003)(16526019)(26005)(956004)(2906002)(86362001)(31696002)(4326008)(53546011)(52116002)(16576012)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2381;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbV/xdDc7liniu4mdIaIPrGz6JgP+JyGm+KiuFhvoAAd3tzHkcHNn3UqsWeJgPJw1pMoSwOolVifi0D7AxFAWKv8o0zWqjOgbTONCfAFSXk9E71JwFUpADtpsMLODtCq1h9py9cwcyNeB9JLlQnKh7M7Wa2QMrLcdtO1P+z2jLyN0qFK7f+cv99uOZ5xcO8rPSFnoomb9MZDCV/6VMwGJFqKOQJyq3E+1RsE3iqJRlPjI4TkEpkIzMmIV4dFO/+v+eg0p/266yaa04U64EM43IGsc2ZhXSVvPmeZBbECe18Y0iVIdEzNDe/UC1cjrpgGWDhlYa+s0tXuliWzdNvItOlh+oqpMCOI1EytK25spLPlHAe296pIoSeXyTe6TI/S/ROw1fyP2Zj6vWBmHGQNveixZxVYXcduw16E8+nYUW54k+FXt9xjnNwPrkGWA1ytAntsceXoCrQxD4BYgnIlrr5U+2fSf12/lNztYz9NxLJE0l5J/7NkFp5DPvhnuk/M0FcJNJD7+rThe4n0fp22Rw==
X-MS-Exchange-AntiSpam-MessageData: K51+6GcJFQd0MsSIj3fazq5gYkHO3+SRDN2uNCtbs5q1GGCsSqyopmv205aeAYIAxBnTaeEJ8ebZbDR405HFmIlbILLcs5K8I3hJ/bWNjCKeTZ8JO0fpfAN4L3vSJTJJn9Eneqrlqc84bB7PuwbGGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7ca233-a7b2-4217-95d5-08d7c45dc5e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:12:12.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA8Vp5Rd0O3mmLhTdPIqyBJbd9hgKE+g+PJ7fZOrJkZFn0C+HHmLnIkBzKKkikNV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/20 10:03 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:58:16 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> Add the new EPYC model specific handlers to fix the apicid decoding.
>>
>> The APIC ID is decoded based on the sequence sockets->dies->cores->threa=
ds.
>> This works fine for most standard AMD and other vendors' configurations,
>> but this decoding sequence does not follow that of AMD's APIC ID enumera=
tion
>> strictly. In some cases this can cause CPU topology inconsistency.
>>
>> When booting a guest VM, the kernel tries to validate the topology, and =
finds
>> it inconsistent with the enumeration of EPYC cpu models. The more detail=
s are
>> in the bug https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01=
%7Cbabu.moger%40amd.com%7C3ddda6803d584aac171b08d7c43b0530%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637193630113242242&amp;sdata=3D3TkNY2O8HWBqaOr=
mO8QQoxlzvIv2oEdTO1P9k6VglmU%3D&amp;reserved=3D0.
>>
>> To fix the problem we need to build the topology as per the Processor
>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
>> Processors.
>> It is available at https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55570-B1_PUB.zip=
&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C3ddda6803d584aac171b08d7c43b05=
30%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637193630113242242&amp;sdat=
a=3DcPYmcthdgilh9lOiGDrwKwOt7cn%2BvBcT%2F8PhRs92x8I%3D&amp;reserved=3D0
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
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> Acked-by: Igor Mammedov <imammedo@redhat.com>

If use a boolean variable, then I dont need all these handlers in
X86CPUDefinition. I just need to set a boolean variable here.
>=20
>> ---
>>  target/i386/cpu.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index f33d8b77f5..f870f7c55b 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3884,6 +3884,10 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>>          .xlevel =3D 0x8000001E,
>>          .model_id =3D "AMD EPYC Processor",
>>          .cache_info =3D &epyc_cache_info,
>> +        .apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc,
>> +        .topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc,
>> +        .apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc,
>> +        .apicid_pkg_offset =3D apicid_pkg_offset_epyc,
>>          .versions =3D (X86CPUVersionDefinition[]) {
>>              { .version =3D 1 },
>>              {
>>
>>
>=20

