Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7345E2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MNPzwiLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7345E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUxA-0005ir-LL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1joUwP-0005Jo-Kf
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:41:33 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com
 ([40.107.223.41]:6111 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1joUwM-0007H0-Ku
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:41:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyGdkOsCyl7GiW7fjFf4uhHMAWJBB2S2FRkBfJ21974Q/P3bWT/h2cIrqWJBD8RpzcWRyJHt++dZoh5aqoR5Wa9SlySFX4A+4ae0Yd+GPHHMQcS0c7VubvJKz96G3pHWpJJ3K4+wlGnLuxhRSjqN74WQGiaIsw9hr9BOG8LsyvcWFUC68gbkSt6a2ARATAhfZyfUDK7mjtBzZ67OXpWK0w3uaChzXutfS5GXgGWjI+qU4x35lQitFRx3ef77ycsfEUIyfcmd4zAA/YpOnxsIsYknFPywKvzqkyDkDfaWbgWJnnJl8qNjCCOuoqZb/OTq5Rs/EdNFMi5UWZpqZQfb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCOwnEz2Akl+JPSY3V9GzFnJt4AH+PhZdXzJUQYCri8=;
 b=k/tFIn2MTzj0jvFQOMoiU6ITBE23U+gaFOPSczyOk+gqELYbKbGBGp6HdDsZy05KzrSHglcNjPzHxX4RHf3SHoVgDpYFmz04D9ZSAR3X7K94FL5M74wGesUQ9pLKl4jAVbOMst682lL/IDjJ/x8Mk+/QrEjB4RT00d4wOI+W+BYzxjK5fIX2/H2hHu3/UKVuQpqgm3zmDrENpNzFLoy0V8f3V1SGn0/a44sbMk/Sg6XY+9NrR/etD39OJF6hhqxpJCd+TcWn6QamVezlYVoMO7LMabRhg98Gq+vMEnN8Q5GxpRCDR/qkS3YHDDtsZuEYGQTeJgXyAmF5OgiJSQFXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCOwnEz2Akl+JPSY3V9GzFnJt4AH+PhZdXzJUQYCri8=;
 b=MNPzwiLE9I8M+mwyIdNKYP5nq4nVPI/R/DZ3O7Ij5vtzcGWy/z9tbu5ojxLwpqJe7ojWP4AAPj4T9B1XZV92eJRR8NzGPfIID4E4u33OFH8ba/cqngwMKBnuefGfMv1rujaNyKKkCBaEBe+Tjc+hDQLbajeec7EL34lcEWVsfNE=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 16:41:27 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 16:41:27 +0000
Subject: RE: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
 hotplug
To: Igor Mammedov <imammedo@redhat.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
 <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
 <20200616125901.772229a6@redhat.com>
 <4810d5cd-9409-d2c5-0f0f-1845891c9aad@amd.com>
 <20200624154735.1c104fd8@redhat.com>
 <512e7103-2c20-da48-93e6-4f67e2eac166@amd.com>
 <20200625171831.6decaec9@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <7620a42f-204c-29ac-5a9a-e8c6e2f75ace@amd.com>
Date: Thu, 25 Jun 2020 11:41:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200625171831.6decaec9@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:5:54::23) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR06CA0046.namprd06.prod.outlook.com (2603:10b6:5:54::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 16:41:26 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ffd650c-0118-4f51-222c-08d819269b10
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB452878E380051DAE1DB6D65A95920@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Htg+3Ti1infREY2Mktr4FBB3DeO1FqNdrNcdx16F7p/e2z1CqKPQMJ0K7xeNrFcNgnFKFKSWwzFs9H+pwsp64b9RQSg08ZbNYZGp8OBttcnSTvartotZj296ZOuOrhtNBziWcn5xDduN8Bn3jZKS68vxTW/R0M03atskVbDkuYEkBXCIziHFx5mbJaha+PrTc6BvOs6tYkeFaZdcPw4mtkznAvono+zSUd7itbHvb7bTaYzihK5gSuHR92fUurVTxn/5NIAexf9U3ciBp3bIAfw28hZC3MIC9V3/e2kQBqxTEneS43Wi2gk+LQc1+Ki2lBUhjQO6SAWqSb+EUfBMvbGQ7/2ng05UFIKJNa6BMpzXWZqfuLm0wjRqsojm6k5LsE/UASyYYNjwhBCPyG9rzABoKe9rQJolBrh2mZAqWNxMEYFyHG4OFQZyhT/4/1PLTu6unZ1dRj/tzG+YquskiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(36756003)(66946007)(86362001)(52116002)(316002)(966005)(66476007)(66556008)(478600001)(16576012)(83380400001)(54906003)(4326008)(83080400001)(6916009)(8936002)(8676002)(45080400002)(6486002)(31686004)(2616005)(956004)(30864003)(53546011)(2906002)(16526019)(31696002)(186003)(44832011)(5660300002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: K2fV+YudK121FP7IsXq7mQZTa7rn1jaQyoewPo/Cyyp/8OyrSYztMD/DQp7BnGMj+zxBTr1p89icVBlPZ2YVtSLMcE075dAY49iYoTPEL5Afh18j6WSHt7ZKnzo7ts2YuoiRphYgodIBXaXp4IC6W5Nws6JZ2etRpf/s0oy6qBv/r5UW5wbU3ycpZCtl+msP9dnKSdn2JulxQot/leQc7YPw59CObghpzx3izfPk5ikbvi0KrZExS1t7p/kFWXo0wqDSt6t6VKQRn6W9Oguy/7nyB5QWv5mZYTwFugigoFHkI8qLYvtE15k427GfipZZDyb287coqyy6vI4cupRiU3YOF2XNbTAa5yZ/iiN6WZOIeRhtoMLIpjR/DdNdSQ1JgcaxQZevds1uNEZ307HH3ppV3wep2yToGJ5b0hL7IYs2pGDi444pCfDzbiPcFb9Cw/s6IFKGB6U9y6fLx+3rigyL8Avp7lWubV05aKGddhk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffd650c-0118-4f51-222c-08d819269b10
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 16:41:27.5671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3oliKP3O4BoxtrvAFS9onjnaFQocK2EuUN8hcXwTUq6nybttJHU9mTkoKJ1eNJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
Received-SPF: none client-ip=40.107.223.41; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 12:41:28
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

Igor,

> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Thursday, June 25, 2020 10:19 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
> hotplug
> 
> On Wed, 24 Jun 2020 12:35:59 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Wednesday, June 24, 2020 8:48 AM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > > pbonzini@redhat.com; rth@twiddle.net
> > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and
> CPU
> > > hotplug
> > >
> > > On Tue, 16 Jun 2020 12:18:56 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > Sent: Tuesday, June 16, 2020 5:59 AM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > > > mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-
> devel@nongnu.org
> > > > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device
> and
> > > CPU
> > > > > hotplug
> > > > >
> > > > > On Mon, 08 Jun 2020 15:18:50 -0500
> > > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > >
> > > > > > Noticed the following command failure while testing CPU hotplug.
> > > > > >
> > > > > > $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
> > > > > >   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > > > >   cpu,core-id=0,socket-id=1,thread-id=0
> > > > > >
> > > > > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-
> id=1,
> > > > > >   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
> > > > > >   with APIC ID 21855, valid index range 0:1
> > > > > >
> > > > > > This happens because APIC ID is calculated using uninitialized memory.
> > > > > > This is happening after the addition of new field node_id in
> > > X86CPUTopoIDs
> > > > > > structure. The node_id field is uninitialized while calling
> > > > > > apicid_from_topo_ids. The problem is discussed in the thread below.
> > > > > >
> > > > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> > > > > nel.org%2Fqemu-
> > > > >
> > >
> devel%2F20200602171838.GG577771%40habkost.net%2F&amp;data=02%7C01
> > > > >
> > >
> %7Cbabu.moger%40amd.com%7C02200d75fd8b48d1955608d811e44f5b%7C3d
> > > > >
> > >
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279019564311233&amp
> > > > >
> > >
> ;sdata=ry3QO0Z5dxLPoRxkYVkOsVm3nl%2BxfCGv8be%2BMHdoUPY%3D&amp;r
> > > > > eserved=0
> > > > > >
> > > > > > Fix the problem by initializing the node_id properly.
> > > > > >
> > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > > ---
> > > > > >  hw/i386/pc.c               |    2 ++
> > > > > >  include/hw/i386/topology.h |   11 +++++++++++
> > > > > >  2 files changed, 13 insertions(+)
> > > > > >
> > > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > > index 2128f3d6fe..974cc30891 100644
> > > > > > --- a/hw/i386/pc.c
> > > > > > +++ b/hw/i386/pc.c
> > > > > > @@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler
> > > > > *hotplug_dev,
> > > > > >          topo_ids.die_id = cpu->die_id;
> > > > > >          topo_ids.core_id = cpu->core_id;
> > > > > >          topo_ids.smt_id = cpu->thread_id;
> > > > > > +        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms-
> > > >cpu_type)
> > > > > ?
> > > > > > +                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;
> > > > >
> > > > > I'd rather not calculate some default value here,
> > > > > this is the branch where we check user provided topology info and error
> out
> > > > > asking
> > > > > to provide missing bits.
> > > > Noticed that cpu->node_id is initialized to
> 0xFF(NUMA_NODE_UNASSIGNED).
> > > > We can initialize cpu->node_id to default node like how we do it in
> > > > x86_get_default_cpu_node_id.  We can use it to initialize
> topo_ids.node_id.
> > > > This is consistent with other fields core_id, die_id etc..
> > > >
> > > > >
> > > > > I also wonder if we should force user to specify numa nodes on CLI if
> EPYC
> > > cpu is
> > > > > used.
> > > > > (i.e. I'm assuming that EPYC always requires numa)
> > > >
> > > > That is not true. Without numa all the cpus will be configured under one
> > > > default numa node 0. Like we do it using x86_get_default_cpu_node_id.
> > >
> > > get_default_cpu_node_id() which is making things up, is going to be
> removed
> > > eventually in favor of asking user to provide numa mapping explicitly on CLI.
> >
> > That will be good going forward.
> >
> > >
> > > now if it's always only node 0, why do we need to calculate it then,
> > > why not just assing 0 directly?
> > >
> > > what if we have several sockets, would all vCPUs still have node-id = 0?
> >
> > If there are several nodes then socket id becomes node id.
> I wonder if node id == socket id then why bother with node_id at all,
> probably node id is there to allow for design where several sockets are on
> the same node
> 
> 
> > > Another question is if we have CPUs with only 1 numa node set on all of
> them,
> > > does it require all other machinery like ACPI SRAT table defined or it's just
> > > internal CPU impl. detail?
> >
> > I am not very sure about it. To me it looks like it is just internal cpu
> > implementation detail.
> I'd think it might confuse guest OS, when it decodes more than 1 numa node
> for APIC ID/CPUID but then there are no such nodes described in ACPI.
> While it might work for caches, it would miss any relation of memory mapping
> to nodes or get it wrong if one doesn't match another.
> 
> 
> > I think we have two options here.
> >
> > 1. Update the patch to initialize the node_id the way it is done
> > get_default_cpu_node_id.
> 
> if it were only one node for every CPU (incl. multisocket), I'd go with enabling
> autonuma assigning all CPUs to default 0 node-id, since there is no ambiguity
> where
> CPUs and RAM are mapped to.
> Is it possible to use node-id=0 for all EPYC CPUs even in multisocket config?
> (it seems spec allows only one node per socket, but doesn't say that node ids
> must
> be different.)
> If not, then making up node-id is not an option.
> 
> > 2. Ask the user to pass the node_id while hot plugging the device. This is
> > a clean solution. Will require some data structure changes.
> 
> Here is my brain dump of current very non obvious flow:
> 
>   1. x86_possible_cpu_arch_ids()
>          ms->possible_cpus->cpus[i].props.* = x86_topo_ids_from_idx()
> 
>   2. possible numa_cpu_set()
>          ms->possible_cpus->cpus[i].props.node_id = user input|0 -in autonuma
> case
> 
>   3. x86_cpus_init()
>          // generate apic_id AND makeup node_id embedded into it
>          ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(x86ms,
> i);
>                         -> x86_apicid_from_cpu_idx_epyc() ->
> x86_topo_ids_from_idx_epyc()
>                                                                  same as x86_topo_ids_from_idx() + node_id
>                      or
>                         -> x86_apicid_from_cpu_idx() -> x86_topo_ids_from_idx()
> 
>   4. pc_cpu_pre_plug()
>          // basically topo ids module node-id is not set or user provided
>          cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> 
>   5.
>          // do it again with diff that in EPYC case it my have different node-id than
> cpu_slot
>          x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> 
>          //i.e. user input of node-id is ignored
>          set socket-id/core-id/... (but not node-id) from topo_info
> 
>          numa_cpu_pre_plug(cpu_slot)
>                            ^^^^^^
>               if (node_id == CPU_UNSET_NUMA_NODE_ID) {
>                    if (slot->props.has_node_id)
>                        object_property_set_int(... slot->props.node_id, "node-id",...);
>               // this applies to hotplugged without node-id and to initial CPUs (-smp X)
>               // so we may end up with "node-id" being set to user defined value
>               // or left unset (no numa enabled)
>               // while APIC ID will have some node-id encoded in it.
> 
> 
> that's quite a mess, maybe we should unify both
> amd make x86_apicid_from_cpu_idx_epyc()/x86_apicid_from_cpu_idx() use
> ms->possible_cpus->cpus[i].props instead of x86_topo_ids_from_idx()
> i.e
> 
>        x86_apicid_from_cpu_idx_epyc() {
>            topoids = x86_apicid_from_cpu_idx() {
>                           return ms->possible_cpus->cpus[i].props
>                       }
>            if (ms->possible_cpus->cpus[i].props.has_node_id)
>                topoids.node_id = ms->possible_cpus->cpus[i].props.node_id
>            else
>                error_fatal("EPYC requires use of -numa to define topology if using
> more than 1 socket")
>        }
> 
> that way QEMU makes up only node[0] by enabling autonuma or whatever
> user privided explicitly is encoded into APIC ID and it will be always consistent
> with cpu
> *-id properties in possible_cpus and SRAT table QEMU generates.
> 
> as cleanup we can get rid of back and forth conversion [5] and use cpu_slot to
> set
> the same ids.
> 
> Also maybe we should have a check that node-id is the same within socket in
> case of EPYC
> if it's guarantied that EPYC won't support multiple nodes per socket.
> 
> hope it makes at least some sense.

To make things clear, in case of autonuma we don't have to worry about
node_id. We just have to set it topo_ids.node_id to 0 in pc_cpu_pre_plug,
Everything will work as expected. This will solve our current problem of
uninitialized variable.

Problem here is, when user has configured the numa, then setting the
topo_ids.node_id to 0 might not work because it might create duplicate
apicids and device_add will be rejected.  As per the comments in
numa_cpu_pre_plug, this is already broken. Look at the comments below.
Looks like node_id cannot be passed down.
============================================
if (node_id == CPU_UNSET_NUMA_NODE_ID) {
        /* due to bug in libvirt, it doesn't pass node-id from props on
         * device_add as expected, so we have to fix it up here */
        if (slot->props.has_node_id) {
            object_property_set_int(OBJECT(dev), slot->props.node_id,
                                    "node-id", errp);
        }
    } else if (node_id != slot->props.node_id) {
============================================

I was trying to solve this problem setting the node_id correctly for EPYC
at least.  If you think, this is not important we can ignore it (by
setting topo_ids.node_id to 0) and move forward.  I don't see the need for
changing other topology specific code as we have already made very generic.

> 
> 
> > Let me know if you see any other option.
> >
> > >
> > >
> > > > >
> > > > > >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,
> > > &topo_ids);
> > > > > >      }
> > > > > >
> > > > > > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > > > > > index 07239f95f4..ee4deb84c4 100644
> > > > > > --- a/include/hw/i386/topology.h
> > > > > > +++ b/include/hw/i386/topology.h
> > > > > > @@ -140,6 +140,17 @@ static inline unsigned
> > > > > apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> > > > > >             apicid_node_width_epyc(topo_info);
> > > > > >  }
> > > > > >
> > > > > > +static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo
> > > *topo_info,
> > > > > > +                                            const X86CPUTopoIDs *topo_ids)
> > > > > > +{
> > > > > > +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> > > > > > +    unsigned cores_per_node = DIV_ROUND_UP((topo_info-
> >dies_per_pkg
> > > *
> > > > > > +                                            topo_info->cores_per_die *
> > > > > > +                                            topo_info->threads_per_core),
> > > > > > +                                            nr_nodes);
> > > > > > +
> > > > > > +    return (topo_ids->core_id / cores_per_node) % nr_nodes;
> > > > > what if nr_nodes == 0?
> > > > >
> > > > > > +}
> > > > > >  /*
> > > > > >   * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> > > > > >   *
> > > > > >
> > > > > >
> > > >
> > > >
> >


