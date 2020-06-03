Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D06C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34B52067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PdABfQaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34B52067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGxC-0005TH-8T
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgGwQ-0004kq-J7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:07:34 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com
 ([40.107.93.86]:37088 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgGwO-0003ah-JR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQo4lWPRyAxOdrXhgaqCpnKByfzf+fi3mDCl0k1M3jZroApGr6ka7VyulRn92v0bXaW9f6SDU3Q6eYT4fg0YnnNRh8FgY7fY9qL/sJdpPZrgIfwgW/t3Es8werowBtoc9PmPxIMQ7ZNBiZXdiSpgTWDFgGuRMVXDnVhUQQswoE9vBL5XCW6XNnvdTc8Z1J8aG30moGmsHmyMzuZcIEdPHGX7P/wm3bDDYndPGiU/JDzOhrh/ZLZU/Xjhe0u+4RRxX81TH6qqttBN4LI1xOkaomy8J8dyVtAwxezBQSm7F2iuRmeqm5XeTl2Mpek0bd7v30QDKP4Rcqf+/dw2UzibCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju78yFp8j4cftJ1ij0y83Vme2EBbjpZ8+h2VAlSemG4=;
 b=f5IvUMPoTon5e7fpYxvT5pww0mbsoJOsiMzvvFduOX302PkwN9n+oAFQ5c3/qf4td0vCalXWx/q0Uxue8nulTse2AexvgM8F+dsF64+OW5LTptHwXKZ4To4vn2Nm8Czippjw/w3eLsDq3FN6sEfvfXQXAtliJjuHkPlzfysvxH2vXkzgbFzTa9FYpnNhYNsgz+LTX6y47+5qAiQp/xccW+WAForZIHUZ55dIcilLdeeddh51EuK3KrxwBReKjVIs4e39ruWgqot5iaNJkgj1JE469pP4EIDlSEKrYeCxAHT/n/agXYdLaCtzFNnXxe8fL96w5VhYFgP3PpwhXRei2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju78yFp8j4cftJ1ij0y83Vme2EBbjpZ8+h2VAlSemG4=;
 b=PdABfQaER/eSaJD7din5gy3jfNH4eah3TYj9DL7+jSHUjX0wBfAz0w/xl6WkjB1ROfkg1mLNGIlpzTlL+qHO6nFyex1J/x02KtgOGrinK6gGVN+8SSAPILdL4Vav0x/VEaaMeKvFLuLAThdY+HFyx0JoTV0bemiZHvTuUtitKAs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2526.namprd12.prod.outlook.com (2603:10b6:802:2a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 00:07:29 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 00:07:28 +0000
Subject: RE: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
 <e68f8536-40fe-3c35-7d66-04f20fcabb8e@amd.com>
 <20200602230105.GI577771@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <9aae5dd6-26fb-cf5f-2bab-db619836ab08@amd.com>
Date: Tue, 2 Jun 2020 19:07:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602230105.GI577771@habkost.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0131.namprd12.prod.outlook.com
 (2603:10b6:0:51::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 00:07:27 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdd7dd8e-1042-47cf-7ada-08d807521a6e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2526:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25263D8981B96913D1154D1F95880@SN1PR12MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWXo7ypQ8mrCeHPG+SHYiJgyh5all4uslIyyrCY/k+GKtForOfxeGHoZqTIxBZ4L1vi4bWkn5bYiUWGWcw4Otsb3PWAQvQ2IjGEfPDtJlgDa9eNAThG67XmHQ86eyIdTdRAn6bH9EyypySdfZ8IaeSkpPRjHxDFptL2wSA3x/nW7wvSi7fWXWb6M4Y3A8X0prYBMhB1NdCKfFXzFZFsn5jF/H3odPvLu0CO9Mohg2QftZ8y45xuO0WOpY+a8MJOE3jCjAjHhvVajTI9Iyh29gZBrou2V+iBGeUhiRtCW/tVB7ks8fdyiXqc1oqrCYQj15SKdZVSSU3GL/WzWHdrMEBjm/FW0J51tYWPVfV6UYMF8q8MZ5rmFH9+09kzL6nuvZBr7LWxeaxg5sGGlb8hDx6Dg0SjwL96JpM6/e5AUhiLvp+3Lkj//ob+rMRkK2vUZ9WFHw3HPYsP+us4+Pkw4cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(83080400001)(498600001)(966005)(6486002)(8676002)(36756003)(5660300002)(31696002)(83380400001)(52116002)(31686004)(6916009)(2906002)(8936002)(66476007)(66946007)(26005)(16576012)(53546011)(44832011)(2616005)(186003)(86362001)(956004)(4326008)(54906003)(45080400002)(66556008)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nuxz6rFQnQSqN6f3BA6pNCzRS9/GR+e2LhhnY7/qJp/j1Ly+FHNrAhtu8LIWReytGxJqH/1+i7DsCHGbDnl7N42rUymy3ktzH6XIelv7srEP/Of6vpZq8soStOz8PhWiBWB5PPZNRqrnSuLOC1MvJnunmgKjEI95/Blp74T5KPYVhylPdctMOkcTueeOsb4xpOjmvVyvwrbFPKlko9c1mA1QOsZ9xXB3vYXqZy+3T1KJpCNWfB5oVvcQqN87s00DuPaUTPWaWVbUw3f0HCXUJj2/6VRldgCR0U89+3naW0hGmtyJBPpW8s6B3DqXoteqWvRRco77JVSFJnBCG/OVuJ/lauLc2wBDKiWzKcyZKfiU8aAEB/oEu6eJBa/ApQiVWPg16l1IBM+28TEHwGDsQ4lhMe7/EE/q8ddMSMTZYg0TkjE1w2yOWgKzt/YMq488Dyv7TB5bX1Yq7T+vzRMAQu5TzLuA1kOAXffHFeE2KsA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd7dd8e-1042-47cf-7ada-08d807521a6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 00:07:28.8184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0blDJ6alu9IGcfs2iPVpR5sv7AOTIKam2nUN0HOIiZDuhMlsMVa5dtRItry0kQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
Received-SPF: none client-ip=40.107.93.86; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 20:07:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Tuesday, June 2, 2020 6:01 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
> functions
> 
> On Tue, Jun 02, 2020 at 04:59:19PM -0500, Babu Moger wrote:
> >
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > Sent: Tuesday, June 2, 2020 12:19 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> > > mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> > > Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
> > > functions
> > >
> > > Hi,
> > >
> > > It looks like this series breaks -device and CPU hotplug:
> > >
> > > On Wed, Mar 11, 2020 at 05:53:34PM -0500, Babu Moger wrote:
> > > > These functions add support for building EPYC mode topology given the
> smp
> > > > details like numa nodes, cores, threads and sockets.
> > > >
> > > > The new apic id decoding is mostly similar to current apic id decoding
> > > > except that it adds a new field node_id when numa configured. Removes
> all
> > > > the hardcoded values. Subsequent patches will use these functions to build
> > > > the topology.
> > > >
> > > > Following functions are added.
> > > > apicid_llc_width_epyc
> > > > apicid_llc_offset_epyc
> > > > apicid_pkg_offset_epyc
> > > > apicid_from_topo_ids_epyc
> > > > x86_topo_ids_from_idx_epyc
> > > > x86_topo_ids_from_apicid_epyc
> > > > x86_apicid_from_cpu_idx_epyc
> > > >
> > > > The topology details are available in Processor Programming Reference
> (PPR)
> > > > for AMD Family 17h Model 01h, Revision B1 Processors. The revision
> guides
> > > are
> > > > available from the bugzilla Link below.
> > > > Link:
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
> > >
> kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.m
> > >
> oger%40amd.com%7C3487f40d37df4d59097d08d807190248%7C3dd8961fe488
> > >
> 4e608e11a82d994e183d%7C0%7C0%7C637267151289763739&amp;sdata=wE0
> > > ukXIVh0l5eNQWsv6VDE9UZEVJmisofaW192gcZAI%3D&amp;reserved=0
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > [...]
> > > >  typedef struct X86CPUTopoIDs {
> > > >      unsigned pkg_id;
> > > > +    unsigned node_id;
> > >
> > > You have added a new field here.
> > >
> > > >      unsigned die_id;
> > > >      unsigned core_id;
> > > >      unsigned smt_id;
> > > [...]
> > > > +static inline apic_id_t
> > > > +x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> > > > +                              const X86CPUTopoIDs *topo_ids)
> > > > +{
> > > > +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> > > > +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> > >
> > > You are using the new field here.
> > >
> > > > +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> > > > +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> > > > +           topo_ids->smt_id;
> > > > +}
> > >
> > > But you are not initializing node_id in one caller of apicid_from_topo_ids():
> > >
> > > static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > >                             DeviceState *dev, Error **errp)
> > > {
> > >     [...]
> > >     X86CPUTopoIDs topo_ids;
> > >     [...]
> > >     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> > >         [...]
> > >         topo_ids.pkg_id = cpu->socket_id;
> > >         topo_ids.die_id = cpu->die_id;
> > >         topo_ids.core_id = cpu->core_id;
> > >         topo_ids.smt_id = cpu->thread_id;
> > >         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> > >     }
> > >     [...]
> > > }
> > >
> > > Result: -device is broken when using -cpu EPYC:
> > >
> > >   $ qemu-system-x86_64 -machine q35,accel=kvm -smp
> > > 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > cpu,core-id=0,socket-id=1,thread-id=0
> 
> [1]
> 
> > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-
> id=1,thread-
> > > id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0] with APIC ID
> 21855,
> > > valid index range 0:1
> > >
> > > This happens because APIC ID is calculated using uninitialized
> > > memory.
> > This patch should initialize the node_id. But I am not sure how to
> > reproduce the bug. Can you please send me the full command line to
> > reproduce the problem. Also test different options.
> 
> The full command line is above[1].
> 
> 
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2128f3d6fe..047b4b9391 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1539,6 +1539,9 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
> >      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> >          int max_socket = (ms->smp.max_cpus - 1) /
> >                                  smp_threads / smp_cores / x86ms->smp_dies;
> 
> So, here's the input you are using to calculate topo_ids.node_id:
> 
> > +        unsigned nr_nodes = MAX(topo_info.nodes_per_pkg, 1);
> 
> When is topo_info.nodes_per_pkg allowed to be 0?
> 
> > +        unsigned cores_per_node = DIV_ROUND_UP((x86ms->smp_dies *
> smp_cores *
> > +                                                smp_threads), nr_nodes);
> 
> x86ms->smp_dies should be available at topo_info.dies_per_pkg,
> smp_cores should available at topo_info.cores_per_die,
> smp_threads should be available at topo_info.threads_per_core,
> nr_nodes should be available at topo_info.nodes_per_pkg.
> 
> >
> >          /*
> >           * die-id was optional in QEMU 4.0 and older, so keep it optional
> > @@ -1585,6 +1588,7 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
> >          topo_ids.die_id = cpu->die_id;
> >          topo_ids.core_id = cpu->core_id;
> >          topo_ids.smt_id = cpu->thread_id;
> > +        topo_ids.node_id = (cpu->core_id / cores_per_node) % nr_nodes;
> 
> apicid_from_topo_ids() have access to topo_info and topo_ids, If
> all the information you need to calculate node_id is already
> available inside topo_info + topo_ids, we could be calculating it
> inside apicid_from_topo_ids().  Why don't we do it?

Sure. I will try it. Will post revised patch tomorrow.

> 
> Also, is topo_ids.core_id really allowed to be larger than
> cores_per_node when calling apicid_from_topo_ids()?
> 
> >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> >      }
> >
> 
> --
> Eduardo


