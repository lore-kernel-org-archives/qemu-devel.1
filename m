Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C538C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052242071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="26Xl9B8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052242071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsTL-00052E-7B
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsSR-0004Ic-0S
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsSO-0005pW-LB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:38:10 -0500
Received: from mail-eopbgr820042.outbound.protection.outlook.com
 ([40.107.82.42]:36431 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibsSO-0005ok-Cc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:38:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl78Nr0rQx2GTpewqmi83/6ce2zEF+tQk+YC25VjIofRWRmYRVG6JiiI0ftJI9RYG1gR4eEztRUgaYiYPv2JcwzX6465646CQmNGc1xCgsYgfKn5f/Qg0fcs1Yl/2GsmLxygS7l2fDE/rUZgxDDGjBLOhXWJwBMNqNANHF+MWNDS3FOJjRGNOBHUpQvOW08Mae5IvTym40/sYi1odZF9+kDSIj7THcGei3hMmBugxTVVKGq3yPSvO93m06cIftF3CU/X1To98a7LFBtLRa6X8/z1y5Q/7kMNNgXi4jyeiapmo7u9xYW8n/WsgCk6776ArH0wqfAVQuF6hhD5j5TWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2yy1QrMawCVAqDrIT8bsrUrXZAPxtxe69bInVgVcPE=;
 b=XEmSna9ojjLJl530k+VKxZY0arXMDNxbPe7E8P8+D6bgdm00wK5T2y8CpyIF+YTdhYWxoIgHZgSpxfQtNNPajgc+mz0ApfRY4GsSS/JJRjna5eYWijTIk/h4v69cvqtnKlZnB8PH+GNN6wG0GPhk7ND3+rlSDZl+tkR9aP2SV0gkgDllH77DJDqFtV56d2P2jVSvCZJ7hKLuUKRLlqdthLZTEAuqXbd5ya27H4R0SRQfqh+k485a59fUzSqIw/TNLyoxde9NkmORlM4eDmwCGggmKvW+exnEL6tnz8gC5BfdjkXAJ9liSR7duSDeNL/xc7lzkKXsnflt/B71ZRbaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2yy1QrMawCVAqDrIT8bsrUrXZAPxtxe69bInVgVcPE=;
 b=26Xl9B8bjloGKd+w3g/bCRfsCSYOJL9/8u80mORFuZF/FNKKCbPLP7i/dOhBc7aguLuOiWH/7k/aYD+p3pcyQjtG5yl6AFN/UDWQ29fAwulQLW9T8anUj39rBVns0nA+OIO++qYrBM4YZIppKw75ZfPJX1nehTPnLtNfBISFKmA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1497.namprd12.prod.outlook.com (10.172.38.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 20:38:05 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:38:05 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 07/16] hw/386: Add new epyc mode
 topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779714362.21957.2682347975717100335.stgit@localhost.localdomain>
 <20191011032953.GD29387@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <d0b3badc-69d9-7538-0f47-e206c2123e6f@amd.com>
Date: Mon, 2 Dec 2019 14:38:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011032953.GD29387@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN4PR0501CA0020.namprd05.prod.outlook.com
 (2603:10b6:803:40::33) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cd90f43-92ff-4ee3-ca1a-08d777678897
X-MS-TrafficTypeDiagnostic: DM5PR12MB1497:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14976D75928B9729239AFCBC95430@DM5PR12MB1497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(966005)(6486002)(316002)(229853002)(66476007)(66946007)(2486003)(23676004)(66556008)(50466002)(53546011)(3846002)(305945005)(52116002)(8676002)(81156014)(6916009)(14444005)(2870700001)(47776003)(86362001)(65806001)(66066001)(65956001)(6116002)(7736002)(30864003)(2906002)(5660300002)(14454004)(6246003)(36756003)(31686004)(76176011)(81166006)(8936002)(4326008)(6306002)(6436002)(6512007)(478600001)(11346002)(25786009)(446003)(44832011)(31696002)(186003)(2616005)(99286004)(26005)(54906003)(6506007)(58126008)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1497;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUnblCf7InMfw1krnuxQxrTtT2NFawRCy2gpjPTaJoMavaLCQ2A5PjWjMrByXX254df9wPvXd5JBOy/j7h8yaH03TGrcHzmanSjtzQlu2glgHRCsnvF/nacFZ2fDKnjXsHC1aMf6yIIX0kn9y6es43SwRqMUqnE8SpqxyAOUmWdCrzrC38er9iwidoEJ27p38dpncNTq0EWVUenYbZKd2KbW/sqp3bWS8UzCwhKnUOgu3geh45WUbh6nGta8spTXgYEm0lyzBjpmjhDhF9mzBFIX0hjU77Fz8usdXTnnaiJBOvcHINXmfhXdrE5FNJ1hrisCKK9Ncppe2mD47UKPTsrUpsKDrSmZ78PKkMEO838SfX6cxVh2kGPUjeuF0TNfGA8EIsRkfl5zBwxUkxUZ+LchqakN3kZFT7V1Q396Oh3ebDx8xBlFeOZFI5gx/+rsO9ywZb7HRAvqE6XuyL+kRpERsuhHkzv01zoLOz2MStY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd90f43-92ff-4ee3-ca1a-08d777678897
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:38:05.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaYLfojsQbIa9R5UNiJ5nK9h7RrKzrAFh9AEcK/at50JePjmaRXcq2oapaesCjns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.42
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/10/19 10:29 PM, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 07:12:25PM +0000, Moger, Babu wrote:
>> These functions add support for building new epyc mode topology
>> given smp details like numa nodes, cores, threads and sockets.
>> Subsequent patches will use these functions to build the topology.
>>
>> The topology details are available in Processor Programming Reference (P=
PR)
>> for AMD Family 17h Model 01h, Revision B1 Processors.
>> It is available at https://www.amd.com/en/support/tech-docs
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  include/hw/i386/topology.h |  174 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 174 insertions(+)
>>
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index 5a61d53f05..6fd4184f07 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -62,6 +62,22 @@ typedef struct X86CPUTopoInfo {
>>      unsigned nr_threads;
>>  } X86CPUTopoInfo;
>> =20
>> +/*
>> + * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
>> + * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual V=
olume 3.
>> + * Define the constants to build the cpu topology. Right now, TOPOEXT
>> + * feature is enabled only on EPYC. So, these constants are based on
>> + * EPYC supported configurations. We may need to handle the cases if
>> + * these values change in future.
>> + */
>> +
>> +/* Maximum core complexes in a node */
>> +#define MAX_CCX                  2
>=20
> I suggest a more explicit name like MAX_CCX_IN_NODE.
>=20
>> +/* Maximum cores in a core complex */
>> +#define MAX_CORES_IN_CCX         4
>> +/* Maximum cores in a node */
>> +#define MAX_CORES_IN_NODE        8
>> +
>=20
> Having limits isn't necessarily bad, but if we look at the code
> that use those constants below:
>=20
> [...]
>> +/*
>> + * Figure out the number of nodes required to build this config.
>> + * Max cores in a nodes is 8
>> + */
>> +static inline int nodes_in_pkg(X86CPUTopoInfo *topo_info)
>> +{
>> +    /*
>> +     * Create a config with user given (nr_nodes > 1) numa node config,
>> +     * else go with a standard configuration
>> +     */
>> +    if (topo_info->numa_nodes > 1) {
>> +        return DIV_ROUND_UP(topo_info->numa_nodes, topo_info->nr_socket=
s);
>> +    } else {
>> +        return DIV_ROUND_UP(topo_info->nr_cores, MAX_CORES_IN_NODE);
>> +    }
>> +}
>=20
> Here we are trying to choose a default value for the number of
> nodes, but it's better to let the CPU or machine code choose it.
> Otherwise, this will be very painful to maintain if new CPUs with
> different limits appear.  I would just let the number of nodes
> per package to be configurable in the command-line.
>=20
>> +
>> +/*
>> + * Decide the number of cores in a core complex with the given nr_cores=
 using
>> + * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_DIE =
and
>> + * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
>> + * L3 cache is shared across all cores in a core complex. So, this will=
 also
>> + * tell us how many cores are sharing the L3 cache.
>> + */
>> +static inline int cores_in_ccx(X86CPUTopoInfo *topo_info)
>> +{
>> +    int nodes;
>> +
>> +    /* Get the number of nodes required to build this config */
>> +    nodes =3D nodes_in_pkg(topo_info);
>> +
>> +    /*
>> +     * Divide the cores accros all the core complexes
>> +     * Return rounded up value
>> +     */
>> +    return DIV_ROUND_UP(topo_info->nr_cores, nodes * MAX_CCX);
>> +}
>=20
> Same here.  This will become painful to maintain if CPUs with a
> different CCX-per-node limit appear.  I suggest just letting the
> number of cores per CCX to be configurable in the command-line.
> The "cores" option is already defined as "cores per die" when
> nr_dies > 1.  We can easily define it to mean "cores per CCX"
> when nr_ccxs > 1.
>=20
> If you still want to impose limits to some of those parameters, I
> suggest placing those limits in the CPU model table, not in
> global constants.
>=20
>=20
>> +
>> +/*
>> + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>> + *
>> + * The caller must make sure core_id < nr_cores and smt_id < nr_threads=
.
>> + */
>> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *t=
opo_info,
>> +                                                  const X86CPUTopoIDs *=
topo_ids)
>> +{
>> +    unsigned nr_ccxs =3D MAX_CCX;
>=20
> I suggest adding nr_ccxs to X86CPUTopoInfo, instead of making it
> fixed.
>=20
>> +    unsigned nr_nodes =3D nodes_in_pkg(topo_info);
>=20
> Same here: isn't it better to have a nr_nodes_per_pkg field in
> X86CPUTopoInfo, and make it configurable in the command-line?
>=20
>> +    unsigned nr_cores =3D MAX_CORES_IN_CCX;
>=20
> nr_cores is already in X86CPUTopoInfo, why aren't you using it?
>=20
> Similar questions at x86_topo_ids_from_apicid_epyc() [1].
>=20
>> +    unsigned nr_threads =3D topo_info->nr_threads;
>> +
>> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(nr_nodes, nr_cc=
xs,
>> +                                                        nr_cores, nr_th=
reads)) |
>> +           (topo_ids->node_id  << apicid_node_offset(nr_ccxs, nr_cores,
>> +                                                     nr_threads)) |
>> +           (topo_ids->ccx_id  << apicid_ccx_offset(nr_cores, nr_threads=
)) |
>> +           (topo_ids->core_id << apicid_core_offset(nr_threads)) |
>> +           topo_ids->smt_id;
>> +}
>> +
>> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info=
,
>> +                                              unsigned cpu_index,
>> +                                              X86CPUTopoIDs *topo_ids)
>> +{
>> +    unsigned nr_cores =3D topo_info->nr_cores;
>=20
> Is nr_cores cores-per-ccx?  cores-per-node?  cores-per-pkg?
>=20
>=20
>> +    unsigned nr_threads =3D topo_info->nr_threads;
>> +    unsigned core_index =3D cpu_index / nr_threads % nr_cores;
>=20
> It's hard to understand what this variable means.  Is it a unique
> identifier for a core inside the whole system?  Is it unique
> inside a package?  Unique inside a node?  Unique inside a ccx?
>=20
>=20
>> +    unsigned ccx_cores =3D cores_in_ccx(topo_info);
>> +
>> +    topo_ids->smt_id =3D cpu_index % nr_threads;
>> +    topo_ids->core_id =3D core_index % ccx_cores; /* core id inside the=
 ccx */
>> +    topo_ids->ccx_id =3D (core_index % (ccx_cores * MAX_CCX)) / ccx_cor=
es;
>> +    topo_ids->node_id =3D core_index / (ccx_cores * MAX_CCX);
>=20
> It looks like we have one extra constraint we must ensure
> elsewhere in the code: we need to make sure the node topology in
> topo->node_id matches the node topology defined using -numa,
> don't we?
>=20
>=20
>> +    topo_ids->pkg_id =3D cpu_index / (nr_cores * nr_threads);
>=20
> Now, these calculations are over my head.  It's hard to
> understand what "nr_cores" mean, or what "ccx_cores * MAX_CCX" is
> calculating.
>=20
> I will try to compare with the existing x86_topo_ids_from_idx()
> function, to see if we can make the hierarchy clearer:
>=20
> Existing code is:
>=20
>     topo->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
>     topo->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
>     topo->core_id =3D cpu_index / nr_threads % nr_cores;
>     topo->smt_id =3D cpu_index % nr_threads;
>=20
> The code is hierarchical, but not 100% clear.  Let's try to make
> it clearer:
>=20
>     unsigned threads_per_core =3D topo->nr_threads;
>     unsigned   cores_per_die  =3D topo->nr_cores;
>     unsigned    dies_per_pkg  =3D topo->nr_dies;
>=20
>     unsigned threads_per_die  =3D threads_per_core * cores_per_die;
>     unsigned threads_per_pkg  =3D threads_per_die  *  dies_per_pkg;
>=20
>     unsigned thread_index =3D cpu_index;
>     unsigned   core_index =3D cpu_index / threads_per_core;
>     unsigned    die_index =3D cpu_index / threads_per_die;
>     unsigned    pkg_index =3D cpu_index / threads_per_pkg;
>=20
>     topo-> smt_id =3D thread_index % threads_per_core;
>     topo->core_id =3D   core_index %   cores_per_die;
>     topo-> die_id =3D    die_index %    dies_per_pkg;
>     topo-> pkg_id =3D    pkg_index;
>=20
> The logic above should be equivalent to the existing
> x86_topo_ids_from_idx() function.
>=20
> Can we make it better for the smt/core/ccx/node/pkg case too?
> Let's try:
>=20
>     unsigned threads_per_core =3D topo->nr_threads;
>     unsigned   cores_per_ccx  =3D topo->nr_cores;
>     unsigned    ccxs_per_node =3D topo->nr_ccxs;
>     unsigned   nodes_per_pkg  =3D topo->nodes_per_pkg;
>=20
>     unsigned threads_per_ccx  =3D threads_per_core * cores_per_ccx;
>     unsigned threads_per_node =3D threads_per_ccx  *  ccxs_per_node;
>     unsigned threads_per_pkg  =3D threads_per_node * nodes_per_pkg;
>=20
>     unsigned thread_index =3D cpu_index;
>     unsigned   core_index =3D cpu_index / threads_per_core;
>     unsigned    ccx_index =3D cpu_index / threads_per_ccx;
>     unsigned   node_index =3D cpu_index / threads_per_node;
>     unsigned    pkg_index =3D cpu_index / threads_per_pkg;
>=20
>     topo-> smt_id =3D thread_index % threads_per_core;
>     topo->core_id =3D   core_index %   cores_per_ccx;
>     topo-> ccx_id =3D    ccx_index %    ccxs_per_node;
>     topo->node_id =3D   node_index %   nodes_per_pkg;
>     topo-> pkg_id =3D    pkg_index;
>=20
> The logic above probably isn't equivalent to the code you wrote.
> The point here is that each variable is very clearly defined with
> a "per_*" suffix to avoid confusion, and all parameters are
> coming from X86CPUTopoInfo.
>=20
>> +}
>> +
>> +/*
>> + * Calculate thread/core/package IDs for a specific topology,
>> + * based on APIC ID
>> + */
>> +static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
>> +                                            X86CPUTopoInfo *topo_info,
>> +                                            X86CPUTopoIDs *topo_ids)
>> +{
>> +    unsigned nr_nodes =3D nodes_in_pkg(topo_info);
>> +    unsigned nr_cores =3D MAX_CORES_IN_CCX;
>> +    unsigned nr_threads =3D topo_info->nr_threads;
>> +    unsigned nr_ccxs =3D MAX_CCX;
>=20
> Same questions as in x86_apicid_from_topo_ids_epyc() [1]:
> shouldn't nr_cores, nr_ccxs and nr_nodes come from
> X86CPUTopoInfo?
>=20
>> +
>> +    topo_ids->smt_id =3D apicid &
>> +                   ~(0xFFFFFFFFUL << apicid_smt_width(nr_threads));
>> +
>> +    topo_ids->core_id =3D (apicid >> apicid_core_offset(nr_threads)) &
>> +                   ~(0xFFFFFFFFUL << apicid_core_width(nr_cores));
>> +
>> +    topo_ids->ccx_id =3D (apicid >> apicid_ccx_offset(nr_cores, nr_thre=
ads)) &
>> +                   ~(0xFFFFFFFFUL << apicid_ccx_width(nr_ccxs));
>> +
>> +    topo_ids->node_id =3D (apicid >> apicid_node_offset(nr_ccxs, nr_cor=
es,
>> +                                                      nr_threads)) &
>> +                   ~(0xFFFFFFFFUL << apicid_node_width(nr_nodes));
>> +
>> +    topo_ids->pkg_id =3D apicid >> apicid_pkg_offset_epyc(nr_nodes, nr_=
ccxs,
>> +                                                        nr_cores, nr_th=
reads);
>> +}
>> +
>> +/*
>> + * Make APIC ID for the CPU 'cpu_index'
>> + *
>> + * 'cpu_index' is a sequential, contiguous ID for the CPU.
>> + */
>> +static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *to=
po_info,
>> +                                                     unsigned cpu_index=
)
>> +{
>> +    X86CPUTopoIDs topo_ids;
>> +    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
>> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>> +}
>=20
> If we make nodes_per_pkg=3D=3D1 by default, treat nr_ccxs and nr_dies
> as synonyms, and make all parameters come from X86CPUTopoInfo,
> can't we reuse exactly the same topology code for both EPYC and
> non-EPYC?  It would be better than having two separate sets of
> functions.
>=20
> I have one additional request: please add unit tests for the
> functions above to test-x86-cpuid.c.  There may be opportunities
> for refactoring this code later, and unit tests will be important
> to make sure we don't break anything.
>=20
>> +
>>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>>   *
>>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads=
.
>>
>=20

I have removed all the hardcoded values. All we need to know is the node
id if numa configured. All other fields just works fine as it is now.
Please look at v3 for more information.

