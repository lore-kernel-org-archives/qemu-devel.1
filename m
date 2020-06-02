Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 22:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8553206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 22:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jft/qXQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8553206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEyj-0000px-2Q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 18:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgEwP-0007Hz-R9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:59:25 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com
 ([40.107.243.81]:12311 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgEwN-0002uQ-PZ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/vOys+ZOXP9e91sjn27Z/ucMcDiZN96mPNnA9ErDUx/wF2tokou4g2gDr8xNnV3uTwoTx37IEq+AlYsNiaLry9JOxDbdvSzpkVtTn6IQPF0Td8YGYDP3SS9P+CXOUpzHpJX8Rx4CJZKOiy12TvRscF+gRsVpH4ZiGwk+fArzuubVaXbPnzPCU2bzS/xptofffdcNXm6ZYIlmS2XHbYBUsUgqzQeZhNPNBOC6xEhqD935hRz02JL46XnrQU9EuGTd3TJWcPeehhAgnoWUJAj8yrF4lnB0s3o87qoQMFo6t5CGJml5d2ki4Yic0OkHqy+HBg+S7jwc2hGnuIv7g1iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEPtWsMT9LzAXMPJw9DUXaXD62FPvnZhiHnrCNTTvf0=;
 b=gEijLllBJQjgXFl/MAxlzqNiI0u7zgGMmTLWNfT00OXjN9l4iA4jHUDDZXrReDShWOLQ0I8C0XPWEMPyXnK2PpLzIcdx26BcGo8mv5wW4EGpqOAT8h7uzT6+d/j8Pv01u5O9GxlCkE42350q5DUfyIZpbbPwiQsy8Kp4lrk4MmTj7sYkaGviAA2gSQthSW1hoeswOtis9glrkTrKCYeufBuWoPxBHmQG/gG7km/Sq4y7/CPq7nBqK5dfj+9WrGxi9iRYqrlcS/pUBKPmtNe2prC5WryY3ud6We1vkAvsMeIXILp8AgwDlLnqKBlAaHTBuTZr3HeV3XEM1ywz8yWpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEPtWsMT9LzAXMPJw9DUXaXD62FPvnZhiHnrCNTTvf0=;
 b=Jft/qXQ6ySq+kAOLHyXdZN6AcTaL4KEdq7hcAydwDM6J2ljhw+QVSFvpwNbXBkv5yeJBnaDqodxFaqKmyv4PAVkp5qK4qI1r5hJZFw22kFjPvvMhQgQJWLOemM5mPPZDR+jgdTZhasjWMKLg9+kxs+Nh8ukAOt80UV1rq/+th24=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 21:59:21 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:59:21 +0000
Subject: RE: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <e68f8536-40fe-3c35-7d66-04f20fcabb8e@amd.com>
Date: Tue, 2 Jun 2020 16:59:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602171838.GG577771@habkost.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:5:14c::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22 via Frontend Transport; Tue, 2 Jun 2020 21:59:20 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad613ca0-8e98-4a28-9679-08d807403485
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241483A0BF1C81E5CC8C8BC5958B0@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8n4xcEpOoYwzzhPHDzmrqx5rA+XUt9XDK85xPR8yuNpfcuZJg0OrSZGBbaFVDQVhi7hm7ZsvU7kPg8ZHpkZH7HnGsoQYP5VukRU5EE+nwzm6pCVNRalDsSswMmnjeprcd/KS91OBuJx2ZkzbfuUseOqa+GEiQOKkXpFS5QueKoPIzNXnhI+NA6t4Uq5WUcT93HvLfkunE6XXrCCUtqJxs6ValMz3QANg5vWxKCC0ytnUvk/TpmMDGGTeYwtkQAbTrNFRfmFwZIfELPaNkoqIAm1rdLzcJbOTc7iWhzWWUKjPPXiKaXmoWXyfTqF2nGVO3krkz83roirwO5Av7mntFINI9FAb/MFfmv37H3Ys0u8DhJDE9aRUU80cPEoW5mFJ/vFN/24J8fupE9zulKZLJpzXh6CKJ3o/9VjWbeFXxmo7eWJs3yVFzusb4XgkybuJsiJ1Alu9MU+yMXhAWqPmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(8936002)(31686004)(8676002)(316002)(2616005)(66476007)(16576012)(66556008)(66946007)(956004)(6916009)(86362001)(54906003)(31696002)(4326008)(2906002)(44832011)(966005)(83380400001)(36756003)(5660300002)(6486002)(26005)(186003)(16526019)(45080400002)(83080400001)(52116002)(478600001)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZE5FJqRScvKKgarlgRW8dyjzPV8m+R0+t9PQ6odxwfot1HAuI0fVteiLEPbtTSwPmdKECZhFaXdOnoLRNzJ7xBjLET1sZYYer70ylrXa4JgYwUU3cwrew4SLypEgL/IMst9gJ0cezk1GKi4d/Q27b0doZ7SA7LU0I/FjIrEVBf7jNs4IvcLspitxDf4BLQA9fX87iPC5THL/ttPx986yHgsxjbkvfNbJeUaYDI+IIwXYBwdblQEBh89pYVIdpNzzLpCEfcva+3uFhb17hkv2B52CKZ/jL+++0q0pcCSwpu5rL29QnUMEGnREQNP+2fAkEN5vjDrsmLbXIhOH/3nTDzUitjirGq6ZgYzBKqBKwnfTucBwj2L+iiVqKpv7dwc8z9+GaW90tfnNmVJse0n9y4KPyU5SIwI7nP7r7xXMTk5XvylhJ03JzLt1FSG/wy5nwq+o8++vEgRSdEqSNwH0F668FT0DvDflkwwFrBjmJZ4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad613ca0-8e98-4a28-9679-08d807403485
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:59:21.5225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j85xkG+MPhAhEEEIDrsJiJQES9RPBZIOjhuavbc6olc5qn/p5CGsmlqwbgDPGM6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
Received-SPF: none client-ip=40.107.243.81; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:59:22
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
> Sent: Tuesday, June 2, 2020 12:19 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
> functions
> 
> Hi,
> 
> It looks like this series breaks -device and CPU hotplug:
> 
> On Wed, Mar 11, 2020 at 05:53:34PM -0500, Babu Moger wrote:
> > These functions add support for building EPYC mode topology given the smp
> > details like numa nodes, cores, threads and sockets.
> >
> > The new apic id decoding is mostly similar to current apic id decoding
> > except that it adds a new field node_id when numa configured. Removes all
> > the hardcoded values. Subsequent patches will use these functions to build
> > the topology.
> >
> > Following functions are added.
> > apicid_llc_width_epyc
> > apicid_llc_offset_epyc
> > apicid_pkg_offset_epyc
> > apicid_from_topo_ids_epyc
> > x86_topo_ids_from_idx_epyc
> > x86_topo_ids_from_apicid_epyc
> > x86_apicid_from_cpu_idx_epyc
> >
> > The topology details are available in Processor Programming Reference (PPR)
> > for AMD Family 17h Model 01h, Revision B1 Processors. The revision guides
> are
> > available from the bugzilla Link below.
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
> kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.m
> oger%40amd.com%7C3487f40d37df4d59097d08d807190248%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637267151289763739&amp;sdata=wE0
> ukXIVh0l5eNQWsv6VDE9UZEVJmisofaW192gcZAI%3D&amp;reserved=0
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> [...]
> >  typedef struct X86CPUTopoIDs {
> >      unsigned pkg_id;
> > +    unsigned node_id;
> 
> You have added a new field here.
> 
> >      unsigned die_id;
> >      unsigned core_id;
> >      unsigned smt_id;
> [...]
> > +static inline apic_id_t
> > +x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> > +                              const X86CPUTopoIDs *topo_ids)
> > +{
> > +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> > +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> 
> You are using the new field here.
> 
> > +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> > +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> > +           topo_ids->smt_id;
> > +}
> 
> But you are not initializing node_id in one caller of apicid_from_topo_ids():
> 
> static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                             DeviceState *dev, Error **errp)
> {
>     [...]
>     X86CPUTopoIDs topo_ids;
>     [...]
>     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
>         [...]
>         topo_ids.pkg_id = cpu->socket_id;
>         topo_ids.die_id = cpu->die_id;
>         topo_ids.core_id = cpu->core_id;
>         topo_ids.smt_id = cpu->thread_id;
>         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
>     }
>     [...]
> }
> 
> Result: -device is broken when using -cpu EPYC:
> 
>   $ qemu-system-x86_64 -machine q35,accel=kvm -smp
> 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> cpu,core-id=0,socket-id=1,thread-id=0
>   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,thread-
> id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0] with APIC ID 21855,
> valid index range 0:1
> 
> This happens because APIC ID is calculated using uninitialized
> memory.
This patch should initialize the node_id. But I am not sure how to
reproduce the bug. Can you please send me the full command line to
reproduce the problem. Also test different options.

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..047b4b9391 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1539,6 +1539,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         int max_socket = (ms->smp.max_cpus - 1) /
                                 smp_threads / smp_cores / x86ms->smp_dies;
+        unsigned nr_nodes = MAX(topo_info.nodes_per_pkg, 1);
+        unsigned cores_per_node = DIV_ROUND_UP((x86ms->smp_dies * smp_cores *
+                                                smp_threads), nr_nodes);

         /*
          * die-id was optional in QEMU 4.0 and older, so keep it optional
@@ -1585,6 +1588,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
+        topo_ids.node_id = (cpu->core_id / cores_per_node) % nr_nodes;
         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
     }


