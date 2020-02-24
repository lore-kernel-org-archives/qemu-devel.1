Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A0C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5120732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aeP4+jQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5120732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HcL-0003w5-DA
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HYB-000074-Q7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HY9-000353-T2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:29:47 -0500
Received: from mail-eopbgr770058.outbound.protection.outlook.com
 ([40.107.77.58]:50766 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6HY9-0002zt-Kz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEbzK5UTkzeRGiJC5LZdyAFimeEvpJ/IdzHRhgj5k5hfspn8KtaQ7oCYnKS7m4p5CyZX37pFM0/knCO5GM5OYZbX5Dk9s9exh0PzBpcmUH4HKpJROhZlJk07MbAatTLXhXSor5glJl5RB57UFR7IurmdD3KSJ4rVIUIgav6sIo9NUcQI35dGPK4woISoa3UQRI8dmdwBz4aMpCZlnZnWNqmBU6YcaHInumoVU9TCZEwRH3tVqeKNWksEpik1OKZ6dhkMBkTwTF43xUJAz95+B4G1VXt0v1ADm+e8pNcuaGEzm+2aqGq4ojsJ4GrGRkLAez9ylyf75cGYmH136YOL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdSj0fc5IHR/uf+9MDyo4c0RtMw0YBb46xvh7+D5iR8=;
 b=Pwh/DUyP9z8RjSXtLql++zqabNd/Bv7A/08yamqh9iCJOHCh1NvgRBuxKvrCOq283HLK/PGSRnG3iGZICspQW9yfdjLXuFxERY0PWnQ4PJZXwPQhdbPVyfT7aQNc1VdCnn/8oM+tzAgyIFHYBWdm1HFCalAkamSSjuEA0qjiDvGMBrg+KNhxigDi+8gL/A9eZXBaIwUMH1ca7b/ljFjtZCUhFpag+q3AaaU7sATdY5MsxE9+oWxZkyNF5W5aQIoZw7GEjQ+coYk4kHA51Ew/d7ifmopwNpXUcUTqH26rZNLTInd0fnHV3EEUpsXpXTz5OmkOq5Z4lhmvIa2SLxFY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdSj0fc5IHR/uf+9MDyo4c0RtMw0YBb46xvh7+D5iR8=;
 b=aeP4+jQeHjsJ+rv5+lBh8JERfcC603hZCKQK5c5QRlgxrb7l7N6iWcVw+bgizRLcuyn1dfc4bi47ZW2STyk4ejwUtmOuA/QN3eoq0WpQb4/GFrx7ZYrd3HDQnD3HKCbkg9bk+FGVtGG900uDokmgbbgn5HeQutZyacfzwt3SMLU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 17:29:41 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:29:41 +0000
Subject: Re: [PATCH v4 09/16] target/i386: Cleanup and use the EPYC mode
 topology functions
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161784564.48948.10610888499052239029.stgit@naples-babu.amd.com>
 <20200224095253.17fb9852@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <85bb2603-115a-1df2-df5d-887faae66bbe@amd.com>
Date: Mon, 24 Feb 2020 11:29:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224095253.17fb9852@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN6PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:805:de::47) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR05CA0034.namprd05.prod.outlook.com (2603:10b6:805:de::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.10 via Frontend Transport; Mon, 24 Feb 2020 17:29:39 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55233f80-e6e8-4ae9-38f4-08d7b94f216d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2463:
X-Microsoft-Antispam-PRVS: <SN1PR12MB246369E1DA14ABBA5F10242395EC0@SN1PR12MB2463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(86362001)(31696002)(81166006)(8676002)(316002)(16576012)(8936002)(81156014)(36756003)(52116002)(5660300002)(44832011)(66556008)(4326008)(2616005)(956004)(31686004)(6486002)(6916009)(478600001)(53546011)(2906002)(186003)(16526019)(26005)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2463;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNoUkLhZar8cRi9cjpETaDmorggmO+CmDSfVQ0ThlrgJoq2ShaI0sBeSJGjdPknDMQN9hTgwhpoN5ThP4hobV6IBc0uiL3xozYdJVIBuTUQkBL5lMOylmfHY0Drl3AT8qfTy6rLvg0+okUoXKSEPd1VIrpvocbODkF55eDtV0ZpKwYEfZYflAydObU+i6AkVZRf9eyzRDa5pG4r6yC3OivgblIdSqHp7It0pcOflmdHNvDyzJnKBroMS1eGhwibQ+vAui+A/jIRDgVV0JiMmw2rnYMGhr8G7Zh+OO2rKhn5ifG0DKpVXQHzMbUgqulyvEhu9HQxpMKLcVX5biPtWUEcLBUfN34fzXjAbgsa1VMg0Q+n+yWqEdzD2H2b6C7sHgB4Smv0JaBndB4yjvZbWU3+WaZY0zhoRVbZ0Lam+2gIvp+mfIp+TJV/k48zc73cj
X-MS-Exchange-AntiSpam-MessageData: myaAviq9YQ5oewMC2x/VUTz1zapjCs9kQCH1JA5UlmNONfKpYYGJwtWRihRzbIHhLqK4/1mc1ZYwMKQ46Z23S/BoZAXRFVFQ/wQsJWW3YD7pKqDYHqxly0PAugWaFNQyArpwnQD+ixZslL1Sq1lM1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55233f80-e6e8-4ae9-38f4-08d7b94f216d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:29:41.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrMvCm4SYu/9NUsT+08vCDJfP/wPdLWGoC7V8BJkri3y49lFzfjs03rWmYjHudWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.58
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



On 2/24/20 2:52 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:17:25 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> Use the new functions from topology.h and delete the unused code. Given =
the
>> sockets, nodes, cores and threads, the new functions generate apic id fo=
r EPYC
>> mode. Removes all the hardcoded values.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> modulo MAX() macro, looks fine to me

Igor, Sorry. What do you mean here?
>=20
>> ---
>>  target/i386/cpu.c |  162 +++++++++++-----------------------------------=
-------
>>  1 file changed, 35 insertions(+), 127 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 5d6edfd09b..19675eb696 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -338,68 +338,15 @@ static void encode_cache_cpuid80000006(CPUCacheInf=
o *l2,
>>      }
>>  }
>> =20
>> -/*
>> - * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
>> - * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual V=
olume 3.
>> - * Define the constants to build the cpu topology. Right now, TOPOEXT
>> - * feature is enabled only on EPYC. So, these constants are based on
>> - * EPYC supported configurations. We may need to handle the cases if
>> - * these values change in future.
>> - */
>> -/* Maximum core complexes in a node */
>> -#define MAX_CCX 2
>> -/* Maximum cores in a core complex */
>> -#define MAX_CORES_IN_CCX 4
>> -/* Maximum cores in a node */
>> -#define MAX_CORES_IN_NODE 8
>> -/* Maximum nodes in a socket */
>> -#define MAX_NODES_PER_SOCKET 4
>> -
>> -/*
>> - * Figure out the number of nodes required to build this config.
>> - * Max cores in a node is 8
>> - */
>> -static int nodes_in_socket(int nr_cores)
>> -{
>> -    int nodes;
>> -
>> -    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
>> -
>> -   /* Hardware does not support config with 3 nodes, return 4 in that c=
ase */
>> -    return (nodes =3D=3D 3) ? 4 : nodes;
>> -}
>> -
>> -/*
>> - * Decide the number of cores in a core complex with the given nr_cores=
 using
>> - * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE=
 and
>> - * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
>> - * L3 cache is shared across all cores in a core complex. So, this will=
 also
>> - * tell us how many cores are sharing the L3 cache.
>> - */
>> -static int cores_in_core_complex(int nr_cores)
>> -{
>> -    int nodes;
>> -
>> -    /* Check if we can fit all the cores in one core complex */
>> -    if (nr_cores <=3D MAX_CORES_IN_CCX) {
>> -        return nr_cores;
>> -    }
>> -    /* Get the number of nodes required to build this config */
>> -    nodes =3D nodes_in_socket(nr_cores);
>> -
>> -    /*
>> -     * Divide the cores accros all the core complexes
>> -     * Return rounded up value
>> -     */
>> -    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
>> -}
>> -
>>  /* Encode cache info for CPUID[8000001D] */
>> -static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *c=
s,
>> -                                uint32_t *eax, uint32_t *ebx,
>> -                                uint32_t *ecx, uint32_t *edx)
>> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>> +                                       X86CPUTopoInfo *topo_info,
>> +                                       uint32_t *eax, uint32_t *ebx,
>> +                                       uint32_t *ecx, uint32_t *edx)
>>  {
>>      uint32_t l3_cores;
>> +    unsigned nodes =3D MAX(topo_info->nodes_per_pkg, 1);
>> +
>>      assert(cache->size =3D=3D cache->line_size * cache->associativity *
>>                            cache->partitions * cache->sets);
>> =20
>> @@ -408,10 +355,13 @@ static void encode_cache_cpuid8000001d(CPUCacheInf=
o *cache, CPUState *cs,
>> =20
>>      /* L3 is shared among multiple cores */
>>      if (cache->level =3D=3D 3) {
>> -        l3_cores =3D cores_in_core_complex(cs->nr_cores);
>> -        *eax |=3D ((l3_cores * cs->nr_threads) - 1) << 14;
>> +        l3_cores =3D DIV_ROUND_UP((topo_info->dies_per_pkg *
>> +                                 topo_info->cores_per_die *
>> +                                 topo_info->threads_per_core),
>> +                                 nodes);
>> +        *eax |=3D (l3_cores - 1) << 14;
>>      } else {
>> -        *eax |=3D ((cs->nr_threads - 1) << 14);
>> +        *eax |=3D ((topo_info->threads_per_core - 1) << 14);
>>      }
>> =20
>>      assert(cache->line_size > 0);
>> @@ -431,55 +381,17 @@ static void encode_cache_cpuid8000001d(CPUCacheInf=
o *cache, CPUState *cs,
>>             (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
>>  }
>> =20
>> -/* Data structure to hold the configuration info for a given core index=
 */
>> -struct core_topology {
>> -    /* core complex id of the current core index */
>> -    int ccx_id;
>> -    /*
>> -     * Adjusted core index for this core in the topology
>> -     * This can be 0,1,2,3 with max 4 cores in a core complex
>> -     */
>> -    int core_id;
>> -    /* Node id for this core index */
>> -    int node_id;
>> -    /* Number of nodes in this config */
>> -    int num_nodes;
>> -};
>> -
>> -/*
>> - * Build the configuration closely match the EPYC hardware. Using the E=
PYC
>> - * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_=
IN_NODE)
>> - * right now. This could change in future.
>> - * nr_cores : Total number of cores in the config
>> - * core_id  : Core index of the current CPU
>> - * topo     : Data structure to hold all the config info for this core =
index
>> - */
>> -static void build_core_topology(int nr_cores, int core_id,
>> -                                struct core_topology *topo)
>> -{
>> -    int nodes, cores_in_ccx;
>> -
>> -    /* First get the number of nodes required */
>> -    nodes =3D nodes_in_socket(nr_cores);
>> -
>> -    cores_in_ccx =3D cores_in_core_complex(nr_cores);
>> -
>> -    topo->node_id =3D core_id / (cores_in_ccx * MAX_CCX);
>> -    topo->ccx_id =3D (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_cc=
x;
>> -    topo->core_id =3D core_id % cores_in_ccx;
>> -    topo->num_nodes =3D nodes;
>> -}
>> -
>>  /* Encode cache info for CPUID[8000001E] */
>> -static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>> +static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU=
 *cpu,
>>                                         uint32_t *eax, uint32_t *ebx,
>>                                         uint32_t *ecx, uint32_t *edx)
>>  {
>> -    struct core_topology topo =3D {0};
>> -    unsigned long nodes;
>> +    X86CPUTopoIDs topo_ids =3D {0};
>> +    unsigned long nodes =3D MAX(topo_info->nodes_per_pkg, 1);
>>      int shift;
>> =20
>> -    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
>> +    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>> +
>>      *eax =3D cpu->apic_id;
>>      /*
>>       * CPUID_Fn8000001E_EBX
>> @@ -496,12 +408,8 @@ static void encode_topo_cpuid8000001e(CPUState *cs,=
 X86CPU *cpu,
>>       *             3 Core complex id
>>       *           1:0 Core id
>>       */
>> -    if (cs->nr_threads - 1) {
>> -        *ebx =3D ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
>> -                (topo.ccx_id << 2) | topo.core_id;
>> -    } else {
>> -        *ebx =3D (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_i=
d;
>> -    }
>> +    *ebx =3D ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_=
id << 3) |
>> +            (topo_ids.core_id);
>>      /*
>>       * CPUID_Fn8000001E_ECX
>>       * 31:11 Reserved
>> @@ -510,9 +418,9 @@ static void encode_topo_cpuid8000001e(CPUState *cs, =
X86CPU *cpu,
>>       *         2  Socket id
>>       *       1:0  Node id
>>       */
>> -    if (topo.num_nodes <=3D 4) {
>> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
>> -                topo.node_id;
>> +
>> +    if (nodes <=3D 4) {
>> +        *ecx =3D ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids=
.node_id;
>>      } else {
>>          /*
>>           * Node id fix up. Actual hardware supports up to 4 nodes. But =
with
>> @@ -527,10 +435,10 @@ static void encode_topo_cpuid8000001e(CPUState *cs=
, X86CPU *cpu,
>>           * number of nodes. find_last_bit returns last set bit(0 based)=
. Left
>>           * shift(+1) the socket id to represent all the nodes.
>>           */
>> -        nodes =3D topo.num_nodes - 1;
>> +        nodes -=3D 1;
>>          shift =3D find_last_bit(&nodes, 8);
>> -        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shif=
t + 1)) |
>> -                topo.node_id;
>> +        *ecx =3D (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
>> +               topo_ids.node_id;
>>      }
>>      *edx =3D 0;
>>  }
>> @@ -5318,6 +5226,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
>>      uint32_t signature[3];
>>      X86CPUTopoInfo topo_info;
>> =20
>> +    topo_info.nodes_per_pkg =3D env->nr_nodes;
>>      topo_info.dies_per_pkg =3D env->nr_dies;
>>      topo_info.cores_per_die =3D cs->nr_cores;
>>      topo_info.threads_per_core =3D cs->nr_threads;
>> @@ -5737,20 +5646,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t in=
dex, uint32_t count,
>>          }
>>          switch (count) {
>>          case 0: /* L1 dcache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, c=
s,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 1: /* L1 icache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, c=
s,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 2: /* L2 cache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs=
,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 3: /* L3 cache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs=
,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          default: /* end of info */
>>              *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
>> @@ -5759,8 +5668,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
>>          break;
>>      case 0x8000001E:
>>          assert(cpu->core_id <=3D 255);
>> -        encode_topo_cpuid8000001e(cs, cpu,
>> -                                  eax, ebx, ecx, edx);
>> +        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
>>          break;
>>      case 0xC0000000:
>>          *eax =3D env->cpuid_xlevel2;
>>
>=20

