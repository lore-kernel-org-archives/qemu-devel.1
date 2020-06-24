Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA4AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9C32078E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x9rglkz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9C32078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo9Z0-000486-Sy
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jo9YE-0002Rf-O6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:51:10 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71]:21139 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jo9YB-0003PF-4S
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QneuKAxh4a5YfSeShoMEePHmTmjACB25Le/4k6WhboxTYsWYfZuiAWdWGPNEx2quYkfKdfhy+yFpqctU71MIWLfb+nRVNfcbBQMR6u7ujvB5qtrsgeZgKcnx/XJU5L7uhTFUHGsAfhMD+korejz2B0tPQxXgLLdR/x5/DFWragDNkgqYJZXTGR6fFgZuoGreEyLTU3S5XNGOk3pq6jpjJx7xLTsofxG33RYl6Nc8pQ+aL8wWUwqbTO8v/XqTV2wJSCDw4+stA57xjpEL6VS+I+JhbyNkEg5GWFxe113hNqYIAP3GWnds8vakHPftL1ucd6gyi5PKbgPnBUmZUsu0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7i3qnOuk28nMMv4gDRlxpGpDNu4U/y0BvmJCBgBrj4=;
 b=lWMtsni/l2Ednw9dVJltnoNoGueD4yT9FBRMjY547aXU9IHl9WxhRSDhpdOvxdCxcYSNmUMdaOVcka6qUY2+ksJdHhL4qzSsNPdEyjjpfFG3N1q7KTEgcEGuDXVXko7IP/cikkbtKfuyFnW86Otd7WXeSWAD+sTrjlSTadpSu71mq7mbFfsjrJR3osa1GcWD3WLkT58coof2VLbfzbEKaoHjgZLiuvblFRMYSoF/zUFmV5bcZQxL/tcddmNAgYnarHjBiq9w8dD+/sUqHoGqIdaiDMby1PDGEtRHYPxdHrJ2JXDwc9cUYyIExRB8VWozmLAU1ilwF/by2Scu/CSdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7i3qnOuk28nMMv4gDRlxpGpDNu4U/y0BvmJCBgBrj4=;
 b=x9rglkz7ZZAQeTOsgS3YYqkPSmRBPfbl/RjgB8adrzZK4pKTFYXR8PUYbH4f/cys4iLc2bQ1yb7ahVVclRWQW/xsotjKYGEigsknBOH2yxYwCZ3Gkl5KJbyNmQLMcAS1/0nLiFamLz7LapWaBj58dPyLNA6WZ4E2pi8jv4L3AUs=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 17:36:01 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 17:36:01 +0000
Subject: RE: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
 hotplug
To: Igor Mammedov <imammedo@redhat.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
 <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
 <20200616125901.772229a6@redhat.com>
 <4810d5cd-9409-d2c5-0f0f-1845891c9aad@amd.com>
 <20200624154735.1c104fd8@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <512e7103-2c20-da48-93e6-4f67e2eac166@amd.com>
Date: Wed, 24 Jun 2020 12:35:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200624154735.1c104fd8@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SN4PR0801CA0017.namprd08.prod.outlook.com (2603:10b6:803:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Wed, 24 Jun 2020 17:36:00 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 909860d9-f620-44e0-bf57-08d818650fdd
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:
X-Microsoft-Antispam-PRVS: <SN6PR12MB260513CE26C2DF5B19A71D5895950@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGYJ7SGCZ4Qcg4+cBLJn0OIrp9EXXrYCOeck3q+TC/hbnClemphdFBEuIpurzYCSPG7v4ZRoTABIsZlqcuRsxDF+cMalwha3H5jg+firR6WhqcyfQxluvDA6ZtLsVNuTwgn8iIM8JQEGOMZUvs5jSi9Ffk3g97I4wumq6reTW2MvhP1NyIJ49eSlC3QBn0/1M77e3wiRKdhaZ9YwO+b/n6lfvvI0wmHHdWjuL2kWEKGBz0Iu2RrIkV2gByiuuV09oZNV3AnLOaRBaFT0NqKhrtVZ1WbWrGHGq5H0/TKr7Iz2+1+gIa8u7Y2Nrks5eT3RQVhmY/wzNYhtt9/WJ5eG5uSMwBm5kVuzhKLcNT+6xx5QGBDAq1gJnn+ZFVjbE0bCqg4tZJNEtJ5pXJn6YvshWRkNCMqVkANvHkVaOnWyURftKZedeRlEN56mcxDVhOCKgq3tr3GNdP+XAWwJ3wniig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(6486002)(6916009)(36756003)(45080400002)(83380400001)(44832011)(8936002)(54906003)(4326008)(53546011)(83080400001)(2906002)(16576012)(956004)(2616005)(316002)(966005)(31686004)(26005)(52116002)(66556008)(66476007)(478600001)(31696002)(5660300002)(86362001)(16526019)(66946007)(186003)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3TtBzPjXv/8H/pN8qjN/uXD8OmbMjHHkRSzp4tZ7PUf3BtDTuJ0dNAPKfoKcWfSWXMDNZ6Zx83hLArqkqIPwr0FGb5keJSFasPoIXeJx4xbn1t3qZfYlMonzqeExaa5F+kaZWKeyqC1rxVjJCa05Qb9T5aOmBfjO132f6DC9R1Zav4JIzfcAHRF9xWUUT3YbB9jFuUQ0GmlxH1v81W/wy2TNpUMmVwH/ITjXiwMyqXhyFTFlwU9IZSj4VQXZAlpeSZ/feb6bX4KAwEu+Eq3JPlNbuvQB4s5HgVmbiwSRryc65ApaFZTOh2HPWooRz2+m7KH50R4vycOpcB2CdCvB9JJzhwrTwhjq0CxihD6RxQ/3uCgHT/Ve/AWCmxHZ3Ro7DkFN8XZCHQmvQ+8zcYBny0idtNDWcIioQewJEeSmD6z95Tn/8No2/U/l6If4jx9qUl/GHb72Eb/0gfI0Ahl1v8jO0Hl/vIrnQlus4ofLuxQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909860d9-f620-44e0-bf57-08d818650fdd
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 17:36:01.3517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAB1eqEjrx+9W7HuBW8XKOrhIxkvx78XcH1/zhTiNGh6jQCC6vRRmLR6YkvlsCJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Received-SPF: none client-ip=40.107.93.71; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 13:51:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Wednesday, June 24, 2020 8:48 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
> hotplug
> 
> On Tue, 16 Jun 2020 12:18:56 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Tuesday, June 16, 2020 5:59 AM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org
> > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and
> CPU
> > > hotplug
> > >
> > > On Mon, 08 Jun 2020 15:18:50 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > > Noticed the following command failure while testing CPU hotplug.
> > > >
> > > > $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
> > > >   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > >   cpu,core-id=0,socket-id=1,thread-id=0
> > > >
> > > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,
> > > >   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
> > > >   with APIC ID 21855, valid index range 0:1
> > > >
> > > > This happens because APIC ID is calculated using uninitialized memory.
> > > > This is happening after the addition of new field node_id in
> X86CPUTopoIDs
> > > > structure. The node_id field is uninitialized while calling
> > > > apicid_from_topo_ids. The problem is discussed in the thread below.
> > > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> > > nel.org%2Fqemu-
> > >
> devel%2F20200602171838.GG577771%40habkost.net%2F&amp;data=02%7C01
> > >
> %7Cbabu.moger%40amd.com%7C02200d75fd8b48d1955608d811e44f5b%7C3d
> > >
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279019564311233&amp
> > >
> ;sdata=ry3QO0Z5dxLPoRxkYVkOsVm3nl%2BxfCGv8be%2BMHdoUPY%3D&amp;r
> > > eserved=0
> > > >
> > > > Fix the problem by initializing the node_id properly.
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > ---
> > > >  hw/i386/pc.c               |    2 ++
> > > >  include/hw/i386/topology.h |   11 +++++++++++
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > index 2128f3d6fe..974cc30891 100644
> > > > --- a/hw/i386/pc.c
> > > > +++ b/hw/i386/pc.c
> > > > @@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler
> > > *hotplug_dev,
> > > >          topo_ids.die_id = cpu->die_id;
> > > >          topo_ids.core_id = cpu->core_id;
> > > >          topo_ids.smt_id = cpu->thread_id;
> > > > +        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms-
> >cpu_type)
> > > ?
> > > > +                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;
> > >
> > > I'd rather not calculate some default value here,
> > > this is the branch where we check user provided topology info and error out
> > > asking
> > > to provide missing bits.
> > Noticed that cpu->node_id is initialized to 0xFF(NUMA_NODE_UNASSIGNED).
> > We can initialize cpu->node_id to default node like how we do it in
> > x86_get_default_cpu_node_id.  We can use it to initialize topo_ids.node_id.
> > This is consistent with other fields core_id, die_id etc..
> >
> > >
> > > I also wonder if we should force user to specify numa nodes on CLI if EPYC
> cpu is
> > > used.
> > > (i.e. I'm assuming that EPYC always requires numa)
> >
> > That is not true. Without numa all the cpus will be configured under one
> > default numa node 0. Like we do it using x86_get_default_cpu_node_id.
> 
> get_default_cpu_node_id() which is making things up, is going to be removed
> eventually in favor of asking user to provide numa mapping explicitly on CLI.

That will be good going forward.

> 
> now if it's always only node 0, why do we need to calculate it then,
> why not just assing 0 directly?
> 
> what if we have several sockets, would all vCPUs still have node-id = 0?

If there are several nodes then socket id becomes node id.

> 
> Another question is if we have CPUs with only 1 numa node set on all of them,
> does it require all other machinery like ACPI SRAT table defined or it's just
> internal CPU impl. detail?

I am not very sure about it. To me it looks like it is just internal cpu
implementation detail.

I think we have two options here.

1. Update the patch to initialize the node_id the way it is done
get_default_cpu_node_id.
2. Ask the user to pass the node_id while hot plugging the device. This is
a clean solution. Will require some data structure changes.

Let me know if you see any other option.

> 
> 
> > >
> > > >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,
> &topo_ids);
> > > >      }
> > > >
> > > > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > > > index 07239f95f4..ee4deb84c4 100644
> > > > --- a/include/hw/i386/topology.h
> > > > +++ b/include/hw/i386/topology.h
> > > > @@ -140,6 +140,17 @@ static inline unsigned
> > > apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> > > >             apicid_node_width_epyc(topo_info);
> > > >  }
> > > >
> > > > +static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo
> *topo_info,
> > > > +                                            const X86CPUTopoIDs *topo_ids)
> > > > +{
> > > > +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> > > > +    unsigned cores_per_node = DIV_ROUND_UP((topo_info->dies_per_pkg
> *
> > > > +                                            topo_info->cores_per_die *
> > > > +                                            topo_info->threads_per_core),
> > > > +                                            nr_nodes);
> > > > +
> > > > +    return (topo_ids->core_id / cores_per_node) % nr_nodes;
> > > what if nr_nodes == 0?
> > >
> > > > +}
> > > >  /*
> > > >   * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> > > >   *
> > > >
> > > >
> >
> >


