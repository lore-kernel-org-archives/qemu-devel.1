Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF03C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF46A2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nom+gJ1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFUE-0000mj-58
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jlFTL-0008OJ-PB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:34:08 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com
 ([40.107.69.62]:21623 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jlFTH-0003ZE-Pm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:34:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVrEoPGaVgmZ5zQE8OFdeptjCB3trHQ1X3pRo738uW3qZg/sIemGwe+LY8NTQ/EA+o8+IGfloVxi9ooSCnFGDj5suhDxy3WwyXx1171s+h2EyIPP33Ankgwbacl8q3L0eksWntIfs20LnVypjv9pBhjD25EgdMEqIWcWIwQsXbQMSz0uLvTLJ3nvcPAGQZ80CQGohnjsnTB8eGeeEYdOTkCp3yyN7HvfODsEQ+EHbK5CXpLua6ancmtBqMTkAJ6ZTcuvS2srNyYF/JswOoIsl1h+c4GTV4RLhvx25tn2fERqQOcimnshngmvuEq6KuFOfIIdHurwECckgeP/tUIMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeH8jb5ACSQTkTbpjfCGMKZH9WMUJ+uNSGQSz84egUE=;
 b=YeFM5krO16Webv1QhnwGGboqVF/iMkc0qBwaMBTN6huFw1FCvg/p5nlB9f0VPWsZ4EOLgVy2MmB1H1pqO5PcLsVcJ+sCljKXDbua5prPhUV4tNSH9FN9z/OYXL1WQRZ4OF6FEVZTth8A8UlKZz2C+dFPqBa2ZmV/H0ySzYWQLHYYJXXOViWjmRSPHmNrW5MnclN0qJgGkp1Ya/WUbhUu9V6mgSjYfHzccnVD4LanPIw1JTWeOwWJKOGXZTvC2gKTJwMMxK1hORTDb3PSgV7rt4lFwY9/YYIit47q0dfUrLi0kTx0C9jGCAFYHssI9KyjbD0dBwO1Aw+ZgXUrjdDfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeH8jb5ACSQTkTbpjfCGMKZH9WMUJ+uNSGQSz84egUE=;
 b=Nom+gJ1RMiSS+L4f/QJ0SxfBdxvN2SyoF/iPuqAZO9TTdv8iCmL+6i8+R1I+Qkh3lzSxATgLhcpaF8JAzl0S0QS4NtmZYkwQEEvFpc+Fm2EBLQD/R27q19S/qzmUgersUCaZ/YbjnxrNGFPn7ASpKQFBUe46JehLJIl1lTnjYGI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 17:18:58 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:18:58 +0000
Subject: RE: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
 hotplug
To: Igor Mammedov <imammedo@redhat.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
 <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
 <20200616125901.772229a6@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <4810d5cd-9409-d2c5-0f0f-1845891c9aad@amd.com>
Date: Tue, 16 Jun 2020 12:18:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200616125901.772229a6@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:803:2e::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SN4PR0201CA0043.namprd02.prod.outlook.com (2603:10b6:803:2e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend
 Transport; Tue, 16 Jun 2020 17:18:57 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98ddcabe-55c3-4153-86fa-08d812195abb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4560:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4560781AD248985586E37612959D0@SA0PR12MB4560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpR4nd8GZTSem8TTluiDqRjniO10gu/vGHvjIw6pY6FMpFqQuLQk3Go7lULG3UDQE67LSrX5mk3Gr0DlZobqhj2bdbQc/5POiOdAOgNTzO216o/hJuxQplLdRgeTa29Y5k7wVOnIUhcZgv2Sqba1zQT50C7T71yyqFpxzBDxTS58cK8J+g4K4EJzt2BTGe7HN/sSmLKmSSJHrpe3SoWzMYFhNHR9CFg82HnxB6es8RweEkQcbMzagRCWC71pZxxAWc1WUaTJrRYok5c+nzD6gPdmphx+RxIenQ7Lo+BIQwjf1nRVFgEPyDAmwZL3a/PTCnNO+Ee4dYNYpzkljNFxAU3FBqY66geCmPcfaAua9U/LaiWKh27MsYDis22PXDSmO2TshTRIu+1Bt+ALK4m6lXXj0QMEWbX+wJUQRJTL5ZAmDhoAT3x/IWgsvxDiWE3vKKSJEiwjrJDJUlt/uGK80w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(86362001)(4326008)(8676002)(478600001)(83380400001)(8936002)(53546011)(83080400001)(52116002)(45080400002)(5660300002)(6916009)(66476007)(44832011)(316002)(16576012)(66946007)(31686004)(66556008)(956004)(6486002)(2616005)(186003)(16526019)(966005)(54906003)(2906002)(36756003)(31696002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ERhGz0UonRezFOLLB4jfXuGUW12tyL4BuszG1xIZmLFMj+zicqiqxj3ZsqtDbbIVkizaRHBenuQYuuwDnwerlysCQvwiGMOSgxxf1DYFApvgtvHQqqZKQN5tjRLHH4cz6syZzdLw88avBHzypCufHCJkZLkP459gbP/vrgOUn7923jwteHFDPfNR6E+4WdQJkYr4qkjRHjyBX59IepVfp/6vWm+CaZ+38lnKu+ffFcl2QZQWv/nEDnDEWZMb0TY+596oBuFD22ha+4goOwvGJC9zntgIavdoX1D+6skFd9Qf6DJUW6xGcyvA3bN0uEzaon+AYz85Ai1aj+jE9m2vJlYAS8iUGqIn636SSOciZzO2aJzWEKN6sIdNuKenBoExs0HIwAdk/ka76ggDM3PAm4CDPtQnMNAo1OVtLSRJos50+5iccoWJesmWwpO1+IAXcZIjP/cBHjD+72f4CuKmS8NaUqiD9t35XrIzcvBBnuQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ddcabe-55c3-4153-86fa-08d812195abb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 17:18:58.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QqIFunn3IW1zZhkQn3eWxl2oMGAfU/KWchAQudszI5x22iNBpl2mZK4Wy8Weuih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
Received-SPF: none client-ip=40.107.69.62; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 13:34:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Tuesday, June 16, 2020 5:59 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
> hotplug
> 
> On Mon, 08 Jun 2020 15:18:50 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > Noticed the following command failure while testing CPU hotplug.
> >
> > $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
> >   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> >   cpu,core-id=0,socket-id=1,thread-id=0
> >
> >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,
> >   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
> >   with APIC ID 21855, valid index range 0:1
> >
> > This happens because APIC ID is calculated using uninitialized memory.
> > This is happening after the addition of new field node_id in X86CPUTopoIDs
> > structure. The node_id field is uninitialized while calling
> > apicid_from_topo_ids. The problem is discussed in the thread below.
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> nel.org%2Fqemu-
> devel%2F20200602171838.GG577771%40habkost.net%2F&amp;data=02%7C01
> %7Cbabu.moger%40amd.com%7C02200d75fd8b48d1955608d811e44f5b%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279019564311233&amp
> ;sdata=ry3QO0Z5dxLPoRxkYVkOsVm3nl%2BxfCGv8be%2BMHdoUPY%3D&amp;r
> eserved=0
> >
> > Fix the problem by initializing the node_id properly.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/pc.c               |    2 ++
> >  include/hw/i386/topology.h |   11 +++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2128f3d6fe..974cc30891 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
> >          topo_ids.die_id = cpu->die_id;
> >          topo_ids.core_id = cpu->core_id;
> >          topo_ids.smt_id = cpu->thread_id;
> > +        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)
> ?
> > +                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;
> 
> I'd rather not calculate some default value here,
> this is the branch where we check user provided topology info and error out
> asking
> to provide missing bits.
Noticed that cpu->node_id is initialized to 0xFF(NUMA_NODE_UNASSIGNED).
We can initialize cpu->node_id to default node like how we do it in
x86_get_default_cpu_node_id.  We can use it to initialize topo_ids.node_id.
This is consistent with other fields core_id, die_id etc..


> 
> I also wonder if we should force user to specify numa nodes on CLI if EPYC cpu is
> used.
> (i.e. I'm assuming that EPYC always requires numa)

That is not true. Without numa all the cpus will be configured under one
default numa node 0. Like we do it using x86_get_default_cpu_node_id.

> 
> >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> >      }
> >
> > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > index 07239f95f4..ee4deb84c4 100644
> > --- a/include/hw/i386/topology.h
> > +++ b/include/hw/i386/topology.h
> > @@ -140,6 +140,17 @@ static inline unsigned
> apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
> >             apicid_node_width_epyc(topo_info);
> >  }
> >
> > +static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo *topo_info,
> > +                                            const X86CPUTopoIDs *topo_ids)
> > +{
> > +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> > +    unsigned cores_per_node = DIV_ROUND_UP((topo_info->dies_per_pkg *
> > +                                            topo_info->cores_per_die *
> > +                                            topo_info->threads_per_core),
> > +                                            nr_nodes);
> > +
> > +    return (topo_ids->core_id / cores_per_node) % nr_nodes;
> what if nr_nodes == 0?
> 
> > +}
> >  /*
> >   * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> >   *
> >
> >


