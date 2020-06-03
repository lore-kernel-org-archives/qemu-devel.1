Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F454206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v6UBcFqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F454206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVEJ-0001PC-Pg
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgVDc-0000sr-TN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:22:16 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com
 ([40.107.243.63]:30112 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgVDb-0000EW-2f
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4MjCnv24vIDC82vBsZnVlj0x8rQVnjAJpRcTjVbqCYWJTE7NXs3GB3hXmDd6ty9PsqRzBmyLUrdSVsh5fbzMeyGLhLauBzCZIJtU3IySq2jcrBTmNAKipY0+JlPcwc8jrvmmDMQyYesRTit0pY7K6wGU9XlFnfUo1md07QJdxvZq2nBF8B/iMG8sWWlWwdgAHszaB6ydDWxkfEnmPSLVoV/8xdWVPxKxNDQsQQ2bM7GLwXJtVHZBYg7jOhJduaSz/J6Czi8qrsJfDDitX9yY9p3LfcseEK8WBeQZA7FwswWpNUVPLuHBZPnayVrahmxjSwPLftB4zKaGNC1pcqwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbSLdfarNMNCGs/Vad5PwO1rSifvG/nkxw7ORXj5d5w=;
 b=RudI5hIjv/MkpjP0MVkEjro/fM6Y+aB0P6kH4nQ0HcuKb2f5NwV/kjdRFD1WyjKK7FYuT7iiOo7DKJZ41KW33/AKehsNtozX+kJ7P/B2b1JEN0Lq6iEy5Mp1RP87Du4txWBK646/Q76O3jUPumczVZQwMlNwe031G47AOnVHJo/d1a1iCj6/IqUzYJTwcjuaSb5SFwGyZaYnaWbiShMsTBxijYCMU+qdgs9RMg0CUSiDKIY/RGC5Yov0LU4QyYsKSYZcEKJWFCQCCK51ZE8Ja7478F+l9x/RSRYloM5TUkulB4yllbpsKiThOM3p606xgjYF4N/N7NM348NM3oqvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbSLdfarNMNCGs/Vad5PwO1rSifvG/nkxw7ORXj5d5w=;
 b=v6UBcFqPvRj+uj3Hmxjm/HMQKnABlNAgCZyb1Bmq2B6hoDsFoCAT9GRRNWmShL66Rv80Tnnvn3P/wpxreSWEOzH7xqCUcRxH+Wz5alE3HlaktOiZK3Wa/fyn5uji30fxqU8lBPyxOM5iSCRETMrJXQDkbkSRhp5GZjOTi6XIzLQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 15:22:12 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 15:22:12 +0000
From: Babu Moger <babu.moger@amd.com>
Subject: RE: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
 <e68f8536-40fe-3c35-7d66-04f20fcabb8e@amd.com>
 <20200602230105.GI577771@habkost.net>
Message-ID: <cc7e970a-0f03-7778-d7f9-76d528c3e260@amd.com>
Date: Wed, 3 Jun 2020 10:22:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602230105.GI577771@habkost.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SN4PR0701CA0001.namprd07.prod.outlook.com (2603:10b6:803:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 15:22:11 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0426d8d-8a4f-4792-a9b2-08d807d1e35d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447A7EC167BF5ADA61BA5C295880@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGwjHP8GmWxDnVaJZHt+V73kcsOY/OlHG4J0Ip+hXwv1espoQCiySn0AP1AeSgDjMUsLk1IduBnfVDHNzPCyfqr87AQkHBjAO9tJq7xpNDAj2KHU+m2+FIo0ly6ejngQCI9EAPQIA8gjcJm2wRkwMXTwSWL5ctUsIcPr2gOTutZmOy7IP4dPinCzoIujIxY7TOrw9IZYYJo1z1zwCVH6uO1rnxhIMs2L9WwMPQWt412dXN7VFvpBE9SPnpRJVJ/9VJ361EbNIkm0XcZMGhj5ljF14FtNSaa+vlVWoGNCPPMB1wWWoCcWPCuttidEQnZm2FwK06qX0fsaNN2Tcbr8W+F8TltduJsUyboB3ofo2oCJcC4UZ/3sR9iLR5oLhxdfpG5C9v7/oGreB5gJeUBan8DQWUWdBqgJNyDP7+hvpxNW2UBrOQdbK+7ECFyhzGtKuBk3Rm3YYD0KXZhXHf8bbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(8676002)(186003)(16576012)(16526019)(44832011)(26005)(83080400001)(316002)(31696002)(53546011)(4326008)(83380400001)(54906003)(956004)(8936002)(2616005)(478600001)(31686004)(5660300002)(966005)(52116002)(6486002)(66476007)(66946007)(36756003)(66556008)(2906002)(6916009)(86362001)(45080400002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BAkHXfgJJC33p3hAJgu2bnIHFXBMScwJZFOqJuNfFvw11gMmaUeOpdYvIrYjlrU2PmBKnSOsVreWIhSY+Cc5qwWchdQ1GwSKoQFEjVqLyeUFdCRAxaNX0XNs2dV8Uwu+g00njVmj9aDK9Hgmm4x2tZ1V6Fis9Um9P9Te4LhbdmD+2CM4BF5Cung2bfSK7RwzjSYLhqHtyusa3B+U427+En2swUNGRNmCKUUpA29tXqjHX9Th1zu4dHtQtalMfVIa0ZRgDkNTkgATJ1uf6Q/7+X8Md8CFO0ZWd+dg4FK6FfgFQuSNy/I7I0zO6AdrTuX90wwsFCDBqDAdIFDFMs0ekxzU8a+JsFdXezduTCq6mJUeAUu5UpvbG42MUu1UqLw6/iM27KUj0O4LSI5f5+DCLAyjy6kJACuzZKvL9rHxQbiI6ksOmOBDNBT0RPQpWSqTuWoguQl76MragScqe0q2i6XU8A4HRoSztl5XrGzSXVE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0426d8d-8a4f-4792-a9b2-08d807d1e35d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 15:22:12.0608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4ZEaDk4s5TW9WRikCcVWwFDc20c0u3iG8rO2hMv5FYxgUXLnokALtrWscdzOUWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Received-SPF: none client-ip=40.107.243.63; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 11:22:13
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

I just picked up the latest tree from
git clone https://git.qemu.org/git/qemu.git qemu
Not seeing the problem.

./x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=kvm -smp
1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device
EPYC-x86_64-cpu,core-id=0,socket-id=1,thread-id=0
VNC server running on ::1:5900

It appears to run ok.

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

It will be zero if numa is not configured. Node_id will be zero for all
the cores.

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
> 
> Also, is topo_ids.core_id really allowed to be larger than
> cores_per_node when calling apicid_from_topo_ids()?

Yes. It is. If we have two numa nodes and 8 cores. Then cores_per_node is
4. Nr_nodes =2. Yes. Core_id can be larger than cores_per_node.

> 
> >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> >      }
> >
> 
> --
> Eduardo


