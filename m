Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC8C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AC92073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xQtc/Koh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AC92073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05cu-00056N-Gt
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k05bu-0004eR-0Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:04:18 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com
 ([40.107.220.67]:26209 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k05br-0000Qr-5R
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekad0KnPEti66F2ZT5m3pe146xpciitMfHZBCrooCWr0s7c2v0UdwRTSJOf59zPAFBxGTSSgausUJDaO2nIG9jWvY8cE3Glub6o5BHudh1oEyiLRe2WqGMO2HNQp1w4V7zhkyhydxvN7F9XfOnSkWQ5R9xsTq7QOkP0oDMlq6o3RcUvYi2x2Matz9Do/N0WlZAsX9HHeOhOWb7oru1lFkM7tZmXIycURBx5Ore2eyUigDmwHbadUamOUI23G6pHsj1cSO8Eyv44l+QyZN018B8K2EQ6P9du5dSclUYHtOWTyBy37Vrk0neoSkwQ0GU4YiSmyXBiwQs1J/V321kLPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEJYMmn5bQi1eEQf/DbuwezjBjWuwaCiU79Q6dgwLJM=;
 b=B8mHCeOxHJ3ulaZT6T74YyXiwoBJaptg5WcQ3yxgi/WHr41tZqhYYeleKFcId2Y1Fr15Dg34NA/CbvgFVTmPwWJpmYOsHUlQ/EWSwaAFl84suD2rBOMaTkQvYOQREBLN/cGhfq3EajcA1EHYNEjiYNl3R8NkAFIhdA2CJBMWF8TZS/Jp1ZD1r13+W6t+aEasDsXE5CTcxhpWFrsOBzgAjweyW0ab8j1Tq2U7IbWKCzfhjfHWYSHs7ZCG+GVlu+6JByCxn4XonIHfMhb+X72t2eghcxX9hDbKkp9pgEMbWnRiGAaL+XgKNvQP6FH5F6J9e78WW0Dz3BpC2UEvh/5imA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEJYMmn5bQi1eEQf/DbuwezjBjWuwaCiU79Q6dgwLJM=;
 b=xQtc/KohLHT/+yn8eKgy5eLCoOl778mQm5AbPBPmZJo4QPiAkIJPinCwNCNvynWbvH7TZfFGXtP5o8j0aXKNRnl6Ivc70d9UDyUMOWMXz/p+o4ZGN9lgWUltcf8OuI/WqDysitaPiyBjTc+X44qgF069hEiguyNMsUWSc6nHnlk=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 15:49:10 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 15:49:10 +0000
Subject: RE: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
To: Igor Mammedov <imammedo@redhat.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
 <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
 <20200713193221.27674630@redhat.com>
 <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
 <20200724190518.0f7a2b6b@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <5b32c961-4fd0-8b8c-4475-eafff2ae48a9@amd.com>
Date: Mon, 27 Jul 2020 10:49:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200724190518.0f7a2b6b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR1101CA0004.namprd11.prod.outlook.com
 (2603:10b6:4:4c::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR1101CA0004.namprd11.prod.outlook.com (2603:10b6:4:4c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 15:49:09 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84104104-4d6c-4dc0-4c98-08d832449a7a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4543:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4543DF5853460E81ECA3F37995720@SA0PR12MB4543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ff8fKxNs0Y1Iw4EVwNQAMOJtCXoC/JFRjVf0fwc6La4UlzKznHGAsKVgP2paGtue7+bF/gQu/5AfC7vC4QZy23BHQhH5w8/R6hzhtyDiZGiPWAJjbpxNlJ4IGaC6rTP1vp9g6xeQKuFMY8P58k2TRiWh6BmEHiMyD85lGEozwPBk9dBF7Ccg4jQfPtoYeGslZm6tMi47v9KFl2nNNIjBYvfLKfsA9O+dUU8EGEMy+eB9rB9DuE8/LED29PpXG5hhryNjnqXbEPPgKYGabErVVi1PhOF7Y6ViE2OBXmFo0gEZ2aArGK/vBK9U//8U606GXsniiHwO/Gyzs3VXHF8ye6wCyQSMJkMy3bbFEPci7IX2Q0CBnIdk6RjsBaAjPDyA9OBnSVG5gJCQNEwg86jQeQjeSsLtd6Fa1bxpIgmI0g61VIeENL4sqHBaVTvVkcCz2UHQGq60BSxN4xtA2bl93A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(5660300002)(66556008)(66476007)(66946007)(53546011)(8936002)(36756003)(478600001)(16526019)(186003)(26005)(45080400002)(83380400001)(2906002)(44832011)(52116002)(2616005)(956004)(83080400001)(31696002)(8676002)(4326008)(6916009)(86362001)(6486002)(966005)(54906003)(31686004)(316002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: unRC59WsiYwRIVqjbzBn6NvpjCn6jtPf4WFDpbnUpS7acENqdxBy/raG6/pylv7dcmF/JpIIAvIQRQU7vs9EFhcZ2RGHFY0/ddza8yKFgNU+F1nQdXFQcFyhqkOUyTl2X9SVpik64cGV7CWm+xZwQ44zDPmm91WniubymXMIrZQ2OFU1mseXuz3lSDYN9MaY/TEWtH3oBoRYHYYUQE6pzXPmGVHSG5/tv7HuQaaKR/ClQDNdAY+Ns7ZBOgN709DsObAF7ZT1ClR9lNEJXUgn9ZHQCR16srsqokQY3gg61ugQlKkLvYs/PP3Jc/SsoaRyT6v8FWOS3z6kWDqcdT9WW3pMree7ju3VTi6iHmTeHkxKUQvsbweNWWbeEfX4G3uIOYDiR2DEDTt1riHxCuaBjCul/REszuS+RfyQ8hvJd0xSbxZw7slG1Odi38arGPckMpjL3FJIUbmXfNlJgZkTK1G8bKHI7VP/94XbUjZ3Wfs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84104104-4d6c-4dc0-4c98-08d832449a7a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:49:10.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nhyqN4idkZVuz6cPL/LxL6I4fgm5DL3pvWh/rceBaI67ocjKnm/tNXtU1PNd2vd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
Received-SPF: none client-ip=40.107.220.67; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 12:04:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, July 24, 2020 12:05 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; ehabkost@redhat.com;
> rth@twiddle.net
> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> CpuInstanceProperties
> 
> On Mon, 13 Jul 2020 14:30:29 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Monday, July 13, 2020 12:32 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> > > devel@nongnu.org
> > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > CpuInstanceProperties
> > >
> > > On Mon, 13 Jul 2020 11:43:33 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > > On 7/13/20 11:17 AM, Igor Mammedov wrote:
> > > > > On Mon, 13 Jul 2020 10:02:22 -0500 Babu Moger
> > > > > <babu.moger@amd.com> wrote:
> > > > >
> > > > >>> -----Original Message-----
> > > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > > >>> qemu- devel@nongnu.org
> > > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > >>> CpuInstanceProperties
> > > > > [...]
> > > > >>>> +
> > > > >>>> +/*
> > > > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > > > >>>> + * node_id in CpuInstanceProperties(or in CPU device) is a
> > > > >>>> +sequential
> > > > >>>> + * number, but while building the topology
> > > > >>>
> > > > >>>> we need to separate it for
> > > > >>>> + * each socket(mod nodes_per_pkg).
> > > > >>> could you clarify a bit more on why this is necessary?
> > > > >>
> > > > >> If you have two sockets and 4 numa nodes, node_id in
> > > > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > > > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically mod %
> > > > >> number of nodes
> > > per socket).
> > > > >
> > > > > I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes
> > > > > per socket so APIC id woulbe be composed like:
> > > > >
> > > > >  1st socket
> > > > >    pkg_id(0) | node_id(0)
> > > > >    pkg_id(0) | node_id(1)
> > > > >
> > > > >  2nd socket
> > > > >    pkg_id(1) | node_id(0)
> > > > >    pkg_id(1) | node_id(1)
> > > > >
> > > > > if that's the case, then EPYC's node_id here doesn't look like a
> > > > > NUMA node in the sense it's usually used (above config would
> > > > > have 4 different memory controllers => 4 conventional NUMA nodes).
> > > >
> > > > EPIC model uses combination of socket id and node id to identify
> > > > the numa nodes. So, it internally uses all the information.
> > >
> > > well with above values, EPYC's node_id doesn't look like it's
> > > specifying a machine numa node, but rather a node index within
> > > single socket. In which case, it doesn't make much sense calling it
> > > NUMA node_id, it's rather some index within a socket. (it starts
> > > looking like terminology is all mixed up)
> > >
> > > If you have access to a milti-socket EPYC machine, can you dump and
> > > post here its apic ids, pls?
> >
> > Here is the output from my EPYC machine with 2 sockets and totally 8
> > nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus 32-63 in
> > socket 1.
> >
> > # lscpu
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > CPU(s):              64
> > On-line CPU(s) list: 0-63
> > Thread(s) per core:  1
> > Core(s) per socket:  32
> > Socket(s):           2
> > NUMA node(s):        8
> > Vendor ID:           AuthenticAMD
> > CPU family:          23
> > Model:               1
> > Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
> > Stepping:            2
> > CPU MHz:             2379.233
> > CPU max MHz:         1900.0000
> > CPU min MHz:         1200.0000
> > BogoMIPS:            3792.81
> > Virtualization:      AMD-V
> > L1d cache:           32K
> > L1i cache:           64K
> > L2 cache:            512K
> > L3 cache:            8192K
> > NUMA node0 CPU(s):   0-7
> > NUMA node1 CPU(s):   8-15
> > NUMA node2 CPU(s):   16-23
> > NUMA node3 CPU(s):   24-31
> > NUMA node4 CPU(s):   32-39
> > NUMA node5 CPU(s):   40-47
> > NUMA node6 CPU(s):   48-55
> > NUMA node7 CPU(s):   56-63
> >
> > Here is the output of #cpuid  -l 0x8000001e  -r
> 
> 
> (1)
> > You may want to refer
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.
> >
> amd.com%2Fsystem%2Ffiles%2FTechDocs%2F54945_3.03_ppr_ZP_B2_pub.zip&
> amp
> >
> ;data=02%7C01%7Cbabu.moger%40amd.com%7Ceacf7e8facbc4ae2eee808d82
> ff3ca9
> >
> 0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373120714103223
> 35&amp;
> >
> sdata=%2Fdr93YVlwSq82%2FwRh2NU21Zkw4HJ%2B%2FVVYxAkhCCKJ4w%3D&a
> mp;reser
> > ved=0 (section 2.1.12.2.1.3 ApicId Enumeration Requirements).
> > Note that this is a general guideline. We tried to generalize in qemu
> > as much as possible. It is bit complex.
> 
> 
> 
> > CPU 0:
> >    0x8000001e 0x00: eax=0x00000000 ebx=0x00000100 ecx=0x00000300
> > edx=0x00000000
> [...]
> > CPU 63:
> >    0x8000001e 0x00: eax=0x0000007e ebx=0x0000011f ecx=0x00000307
> > edx=0x00000000
> >
> > >
> > > >
> > > > >
> > > > > I wonder if linux guest actually uses node_id encoded in apic id
> > > > > for configuring/checking numa structures, or it just uses
> > > > > whatever ACPI SRAT table provided.
> > > > >
> > > > >>>> + */
> > > > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > > > >>>> +                                     CpuInstanceProperties props,
> > > > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > > > >>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > > > >>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > > > >>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > > > >>>> +    topo_ids->node_id = props.has_node_id ?
> > > > >>>> +                        props.node_id %
> > > > >>>> +MAX(topo_info->nodes_per_pkg, 1) : 0;
> 
> It looks like I was wrong pushing system wide NUMA node-id into APIC ID
> (choosen naming is confusing a bit), per [1] mentioned above, EPYC's node-id is:
> 
> • ApicId[6] = Socket ID.
> * ApicId[5:4]= Node ID.
> • ApicId[3] = Logical CCX L3 complex ID
> • ApicId[2:0]= (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,LogicalCoreID[1:0]}
> 
> which is can hold only 0-3 values, and defined as:
> 
> "A node, is an integrated circuit device that includes one to 8 cores (one or two
> Core Complexes)."
> 
> spec also mentions it indirectly as die-id if one looks at CPUID_Fn8000001E_EBX
> [Core Identifiers] (Core::X86::Cpuid::CoreId) ...
>   CoreId = ({2'b0, DieId[1:0], LogicalComplexId[0], LogicalThreadId[2:0]} >> SMT
> 
> and in
> (2)
> CPUID_Fn8000001E_ECX [Node Identifiers] (Core::X86::Cpuid::NodeId) ...
>   {5'b00000,1'b[SOCKET_ID],2'b[DIE_ID]}
> 
> Question is why we did not reuse topo_ids->die_id instead of adding confusing
> topo_ids->node_id in the first place?

Initially, I thought about it. But Intel uses die_id differently than AMD.
So, did not want complicate things.
If we take that route then we need to re-arrange the numa code as we need
to numa information to calculate the die id. So, did not want to mix up
things.

> 
> Also looking APIC ID and SRAT table provided here, CPUID_Fn8000001E_ECX
> corresponds to NUMA node id (i.e. what -numa in QEMU used for) and Node ID
> embeded into ApicId[5:4] is basically die-id.
> 
> Difference between die-id implemented in QEMU and EPYC's die id (topo_ids-
> >node_id) is that the former doesn't require numa config (maybe it should, but
> ship'salready sailed) and gets number of dies from '-smp dies=X' CLI option,
> while for EPYC we calculate topo_ids->node_id implicitly from number of numa
> nodes and sockets, which implicitly requires that machine 'must' be configured
> with -numa options.
> 
> Maybe we should drop this implicit calculation along with topo_ids->node_id
> and reuse '-smp dies=X' plus extra checks for EPYC to ask for -numa if there is
> more than 1 die and if we need to be really strict, add checks for limit of
> dies/cores within socket/die according to spec[2] so encoded APIC ID and
> CPUID_8000001E match the spec.

There will be complications when user configures with both die_id and
numa_id. It will complicate things further. I will have to look closely at
the code if it is feasible.

> 
> 
> 
> > > > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id :
> > > > >>>> +0; }
> > > > >>>>  /*
> > > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > > >>>>   *
> > > > >>>>
> > > > >>
> > > > >
> > > >
> >
> >


