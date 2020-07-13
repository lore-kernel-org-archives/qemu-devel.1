Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED044C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF16E2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D6aiYB5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF16E2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4BS-0006FZ-0r
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv49s-0004xN-0U
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:30:36 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com
 ([40.107.92.82]:6156 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv49o-0007cV-VV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:30:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBLkxKYas2rzHE0DeieV+QEqL+JIFCqVlL0Hu77jy8CQWM00cDfza+zm0dcCs6QBZkUF0ykDDHhGfOs8l4zddahL6UqopI5AdsDMRWO0gsG1E2fJvH0gWDkp5XtxwDQxFE+63+gQf4uOET7QRjH3J+SwxMCBU+ZjBNT5Q27R/RbTgxw6kYGG3DjVWzbAvUUzfEpZFZzmDjFeAO6+VmhxxOhdozgQHoRtPCDHuLPnOuxOkQh23TyYTYl8c5cxglG5YcQp2IU9ix+hQmygipxelOw9HtBuiMajoNMJT3Ry8L4hzq9DoSMcntQTquNd+tANwz3GLjtLOYGvwXGh6d+RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66IcAS+y/DW7bpD2/hoVFHBfcIGXK8aCPp/z/8lcoZM=;
 b=Y32SKvByUXoaBBD2f94JZwRt01Zv2pDGXDlNaUwIJKSvZAmUFeSrJ2lAGhei7RUykzG/Hh/4aAMWucTRTRcl6Gi7CIYeHXO0/NFQpaevu9ENpt3kIrq8yIko7AzzabgkqopFciPD5qMtUgNVh3KDq2Yw7FDOQbAMjU7Abqp3ez8oGfwYzsifqAbKdqCrrNEUzD1WweYYmmMvfu7ottO480KyfcaHmdu8HuMU/loCccVi4E5yEWgTe+WMcPWDJ3AFmyJQBP/WUgDFUPXDxUmjG6bXVLgSMCmZMShwOaFFRoOvBUV1xPAooSQMflQLF++Ek6FL8b/YLeeuxl7IAAhH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66IcAS+y/DW7bpD2/hoVFHBfcIGXK8aCPp/z/8lcoZM=;
 b=D6aiYB5cXTSFCz0mn9gQHRw6OXEQ35mnBxOfZsAJsN5wsk8GTyStrxAN6NEkcHT4xgGZY9IgaSUTgDJvHRfX1kyY238uFQt6VNVbPk3eTVdlnKZqKIRrSg/kcbOfeK3W41PzAkOTP7EqgVBs739iqC7Kni3COOa01nhWApvihpE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 19:30:30 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 19:30:30 +0000
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
From: Babu Moger <babu.moger@amd.com>
Message-ID: <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
Date: Mon, 13 Jul 2020 14:30:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200713193221.27674630@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:803:2b::22) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SN4PR0201CA0012.namprd02.prod.outlook.com (2603:10b6:803:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 19:30:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a12b614-e6be-489b-65f7-08d82763342b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4350:
X-Microsoft-Antispam-PRVS: <SA0PR12MB435090E1120946A1E749CB0295600@SA0PR12MB4350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHRKlyxE4C1dUeRtJtMuiHcXuAEU1GS/k6IGmWOEFjXid0T/h6b9qjxmd/FjbQtn9mehzno5sS32qul/vx0pHNR6IlA5U0DwKE5erDT2/EySlhq1H6Do3qacFbmd2Voj2lz88DznDk0aVmJa1omEEWt+MJRSnFDJ79IZQbEv7UxI6SnfS6HKopfVe9jsnsOGqHT3z3uKZAKPjT90tCv98C4rt5RuLErd+cUAvH/zUQhAuE6FDj4C14HcSxW+9YlPPPt/sfpDf9WGQ8aLbSQRI7XhhIrwQp0Z9uAR477rvz0TlpATg666VjE8NMe+z9vfim4QCo/vvoUSQyljfmSeqrhzVRhlejp0TlHO+DvrnM8ZosG0XaZ7gmie3Mxcr/V21OgzKv2CHnnYS3pnedcu2xC1eSTsbWQLfcPxd1cJLl+aqTCgYf2tmvKPJy2N2yr5lOYpYtQtFVCbTosIBFzdUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(478600001)(5660300002)(66476007)(66946007)(66556008)(44832011)(83380400001)(966005)(54906003)(8676002)(186003)(26005)(2906002)(6486002)(2616005)(956004)(53546011)(36756003)(31686004)(86362001)(16526019)(16576012)(30864003)(31696002)(52116002)(6916009)(4326008)(8936002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rJXOaqPHlS8IAYVhSD0hSdfH2P80WFCjPGaX7nfXBcAULtdstWJ1GjvpGyJmvUu5sQsFiEFU9mpBLWqkg6C4vSLSI5QXXOQZ2Pcs38Dac+yRh1hPBHtsK92acknY7DpZs/JXsAKPGQerMLRiQKe8OMZVbPO1Q86XM8Z0T/CWNPbzy//V5TkUKbu6AImB+Ituvs4j3AQ9UuWU7BPtR+xhbHne1AbwZ6hJSMi5M1C3CB5tBje8TSJQSMVWjM9nxTfs3cMvg8m9XbUrrqPHmWmjakPjDSLLU9JrRoGqGZnP1GtOg+ZQNHdt0P5p08uKZW3IH5Swvd4sVK5ieSgqOnrud11I81AAD2byVAeisMHneec13INaBWnhFYSTzTsVJpgjcZge0/PJgjf2qYJbjBOhg3IzlUNpz8qRQRR4NojBWF3jkWbDMb1jSE4Y7eKGt2I+27A87eFRC+jdYJbUesJ24lsUEegoepTrBHkA8/0oYWg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12b614-e6be-489b-65f7-08d82763342b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 19:30:30.4939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcg3Jt4Vhrs5bt+NtxJAmsL5tRiHKaKqm+DQp6GGiwLEkenOrAYfwfMkUrldt93S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
Received-SPF: none client-ip=40.107.92.82; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:30:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Monday, July 13, 2020 12:32 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> CpuInstanceProperties
> 
> On Mon, 13 Jul 2020 11:43:33 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > On 7/13/20 11:17 AM, Igor Mammedov wrote:
> > > On Mon, 13 Jul 2020 10:02:22 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > >>> -----Original Message-----
> > >>> From: Igor Mammedov <imammedo@redhat.com>
> > >>> Sent: Monday, July 13, 2020 4:08 AM
> > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > >>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > >>> qemu- devel@nongnu.org
> > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > >>> CpuInstanceProperties
> > > [...]
> > >>>> +
> > >>>> +/*
> > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > >>>> + * node_id in CpuInstanceProperties(or in CPU device) is a sequential
> > >>>> + * number, but while building the topology
> > >>>
> > >>>> we need to separate it for
> > >>>> + * each socket(mod nodes_per_pkg).
> > >>> could you clarify a bit more on why this is necessary?
> > >>
> > >> If you have two sockets and 4 numa nodes, node_id in
> > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically mod % number of nodes
> per socket).
> > >
> > > I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes per
> > > socket so APIC id woulbe be composed like:
> > >
> > >  1st socket
> > >    pkg_id(0) | node_id(0)
> > >    pkg_id(0) | node_id(1)
> > >
> > >  2nd socket
> > >    pkg_id(1) | node_id(0)
> > >    pkg_id(1) | node_id(1)
> > >
> > > if that's the case, then EPYC's node_id here doesn't look like a
> > > NUMA node in the sense it's usually used (above config would have 4
> > > different memory controllers => 4 conventional NUMA nodes).
> >
> > EPIC model uses combination of socket id and node id to identify the
> > numa nodes. So, it internally uses all the information.
> 
> well with above values, EPYC's node_id doesn't look like it's specifying a
> machine numa node, but rather a node index within single socket. In which case,
> it doesn't make much sense calling it NUMA node_id, it's rather some index
> within a socket. (it starts looking like terminology is all mixed up)
> 
> If you have access to a milti-socket EPYC machine, can you dump and post here
> its apic ids, pls?

Here is the output from my EPYC machine with 2 sockets and totally 8
nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus 32-63 in
socket 1.

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              64
On-line CPU(s) list: 0-63
Thread(s) per core:  1
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        8
Vendor ID:           AuthenticAMD
CPU family:          23
Model:               1
Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
Stepping:            2
CPU MHz:             2379.233
CPU max MHz:         1900.0000
CPU min MHz:         1200.0000
BogoMIPS:            3792.81
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           64K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7
NUMA node1 CPU(s):   8-15
NUMA node2 CPU(s):   16-23
NUMA node3 CPU(s):   24-31
NUMA node4 CPU(s):   32-39
NUMA node5 CPU(s):   40-47
NUMA node6 CPU(s):   48-55
NUMA node7 CPU(s):   56-63

Here is the output of #cpuid  -l 0x8000001e  -r

You may want to refer
https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip
(section 2.1.12.2.1.3 ApicId Enumeration Requirements).
Note that this is a general guideline. We tried to generalize in qemu as
much as possible. It is bit complex.

CPU 0:
   0x8000001e 0x00: eax=0x00000000 ebx=0x00000100 ecx=0x00000300
edx=0x00000000
CPU 1:
   0x8000001e 0x00: eax=0x00000002 ebx=0x00000101 ecx=0x00000300
edx=0x00000000
CPU 2:
   0x8000001e 0x00: eax=0x00000004 ebx=0x00000102 ecx=0x00000300
edx=0x00000000
CPU 3:
   0x8000001e 0x00: eax=0x00000006 ebx=0x00000103 ecx=0x00000300
edx=0x00000000
CPU 4:
   0x8000001e 0x00: eax=0x00000008 ebx=0x00000104 ecx=0x00000300
edx=0x00000000
CPU 5:
   0x8000001e 0x00: eax=0x0000000a ebx=0x00000105 ecx=0x00000300
edx=0x00000000
CPU 6:
   0x8000001e 0x00: eax=0x0000000c ebx=0x00000106 ecx=0x00000300
edx=0x00000000
CPU 7:
   0x8000001e 0x00: eax=0x0000000e ebx=0x00000107 ecx=0x00000300
edx=0x00000000
CPU 8:
   0x8000001e 0x00: eax=0x00000010 ebx=0x00000108 ecx=0x00000301
edx=0x00000000
CPU 9:
   0x8000001e 0x00: eax=0x00000012 ebx=0x00000109 ecx=0x00000301
edx=0x00000000
CPU 10:
   0x8000001e 0x00: eax=0x00000014 ebx=0x0000010a ecx=0x00000301
edx=0x00000000
CPU 11:
   0x8000001e 0x00: eax=0x00000016 ebx=0x0000010b ecx=0x00000301
edx=0x00000000
CPU 12:
   0x8000001e 0x00: eax=0x00000018 ebx=0x0000010c ecx=0x00000301
edx=0x00000000
CPU 13:
   0x8000001e 0x00: eax=0x0000001a ebx=0x0000010d ecx=0x00000301
edx=0x00000000
CPU 14:
   0x8000001e 0x00: eax=0x0000001c ebx=0x0000010e ecx=0x00000301
edx=0x00000000
CPU 15:
   0x8000001e 0x00: eax=0x0000001e ebx=0x0000010f ecx=0x00000301
edx=0x00000000
CPU 16:
   0x8000001e 0x00: eax=0x00000020 ebx=0x00000110 ecx=0x00000302
edx=0x00000000
CPU 17:
   0x8000001e 0x00: eax=0x00000022 ebx=0x00000111 ecx=0x00000302
edx=0x00000000
CPU 18:
   0x8000001e 0x00: eax=0x00000024 ebx=0x00000112 ecx=0x00000302
edx=0x00000000
CPU 19:
   0x8000001e 0x00: eax=0x00000026 ebx=0x00000113 ecx=0x00000302
edx=0x00000000
CPU 20:
   0x8000001e 0x00: eax=0x00000028 ebx=0x00000114 ecx=0x00000302
edx=0x00000000
CPU 21:
   0x8000001e 0x00: eax=0x0000002a ebx=0x00000115 ecx=0x00000302
edx=0x00000000
CPU 22:
   0x8000001e 0x00: eax=0x0000002c ebx=0x00000116 ecx=0x00000302
edx=0x00000000
CPU 23:
   0x8000001e 0x00: eax=0x0000002e ebx=0x00000117 ecx=0x00000302
edx=0x00000000
CPU 24:
   0x8000001e 0x00: eax=0x00000030 ebx=0x00000118 ecx=0x00000303
edx=0x00000000
CPU 25:
   0x8000001e 0x00: eax=0x00000032 ebx=0x00000119 ecx=0x00000303
edx=0x00000000
CPU 26:
   0x8000001e 0x00: eax=0x00000034 ebx=0x0000011a ecx=0x00000303
edx=0x00000000
CPU 27:
   0x8000001e 0x00: eax=0x00000036 ebx=0x0000011b ecx=0x00000303
edx=0x00000000
CPU 28:
   0x8000001e 0x00: eax=0x00000038 ebx=0x0000011c ecx=0x00000303
edx=0x00000000
CPU 29:
   0x8000001e 0x00: eax=0x0000003a ebx=0x0000011d ecx=0x00000303
edx=0x00000000
CPU 30:
   0x8000001e 0x00: eax=0x0000003c ebx=0x0000011e ecx=0x00000303
edx=0x00000000
CPU 31:
   0x8000001e 0x00: eax=0x0000003e ebx=0x0000011f ecx=0x00000303
edx=0x00000000
CPU 32:
   0x8000001e 0x00: eax=0x00000040 ebx=0x00000100 ecx=0x00000304
edx=0x00000000
CPU 33:
   0x8000001e 0x00: eax=0x00000042 ebx=0x00000101 ecx=0x00000304
edx=0x00000000
CPU 34:
   0x8000001e 0x00: eax=0x00000044 ebx=0x00000102 ecx=0x00000304
edx=0x00000000
CPU 35:
   0x8000001e 0x00: eax=0x00000046 ebx=0x00000103 ecx=0x00000304
edx=0x00000000
CPU 36:
   0x8000001e 0x00: eax=0x00000048 ebx=0x00000104 ecx=0x00000304
edx=0x00000000
CPU 37:
   0x8000001e 0x00: eax=0x0000004a ebx=0x00000105 ecx=0x00000304
edx=0x00000000
CPU 38:
   0x8000001e 0x00: eax=0x0000004c ebx=0x00000106 ecx=0x00000304
edx=0x00000000
CPU 39:
   0x8000001e 0x00: eax=0x0000004e ebx=0x00000107 ecx=0x00000304
edx=0x00000000
CPU 40:
   0x8000001e 0x00: eax=0x00000050 ebx=0x00000108 ecx=0x00000305
edx=0x00000000
CPU 41:
   0x8000001e 0x00: eax=0x00000052 ebx=0x00000109 ecx=0x00000305
edx=0x00000000
CPU 42:
   0x8000001e 0x00: eax=0x00000054 ebx=0x0000010a ecx=0x00000305
edx=0x00000000
CPU 43:
   0x8000001e 0x00: eax=0x00000056 ebx=0x0000010b ecx=0x00000305
edx=0x00000000
CPU 44:
   0x8000001e 0x00: eax=0x00000058 ebx=0x0000010c ecx=0x00000305
edx=0x00000000
CPU 45:
   0x8000001e 0x00: eax=0x0000005a ebx=0x0000010d ecx=0x00000305
edx=0x00000000
CPU 46:
   0x8000001e 0x00: eax=0x0000005c ebx=0x0000010e ecx=0x00000305
edx=0x00000000
CPU 47:
   0x8000001e 0x00: eax=0x0000005e ebx=0x0000010f ecx=0x00000305
edx=0x00000000
CPU 48:
   0x8000001e 0x00: eax=0x00000060 ebx=0x00000110 ecx=0x00000306
edx=0x00000000

CPU 49:
   0x8000001e 0x00: eax=0x00000062 ebx=0x00000111 ecx=0x00000306
edx=0x00000000
CPU 50:
   0x8000001e 0x00: eax=0x00000064 ebx=0x00000112 ecx=0x00000306
edx=0x00000000
CPU 51:
   0x8000001e 0x00: eax=0x00000066 ebx=0x00000113 ecx=0x00000306
edx=0x00000000
CPU 52:
   0x8000001e 0x00: eax=0x00000068 ebx=0x00000114 ecx=0x00000306
edx=0x00000000
CPU 53:
   0x8000001e 0x00: eax=0x0000006a ebx=0x00000115 ecx=0x00000306
edx=0x00000000
CPU 54:
   0x8000001e 0x00: eax=0x0000006c ebx=0x00000116 ecx=0x00000306
edx=0x00000000
CPU 55:
   0x8000001e 0x00: eax=0x0000006e ebx=0x00000117 ecx=0x00000306
edx=0x00000000
CPU 56:
   0x8000001e 0x00: eax=0x00000070 ebx=0x00000118 ecx=0x00000307
edx=0x00000000
CPU 57:
   0x8000001e 0x00: eax=0x00000072 ebx=0x00000119 ecx=0x00000307
edx=0x00000000
CPU 58:
   0x8000001e 0x00: eax=0x00000074 ebx=0x0000011a ecx=0x00000307
edx=0x00000000
CPU 59:
   0x8000001e 0x00: eax=0x00000076 ebx=0x0000011b ecx=0x00000307
edx=0x00000000
CPU 60:
   0x8000001e 0x00: eax=0x00000078 ebx=0x0000011c ecx=0x00000307
edx=0x00000000
CPU 61:
   0x8000001e 0x00: eax=0x0000007a ebx=0x0000011d ecx=0x00000307
edx=0x00000000
CPU 62:
   0x8000001e 0x00: eax=0x0000007c ebx=0x0000011e ecx=0x00000307
edx=0x00000000
CPU 63:
   0x8000001e 0x00: eax=0x0000007e ebx=0x0000011f ecx=0x00000307
edx=0x00000000

> 
> >
> > >
> > > I wonder if linux guest actually uses node_id encoded in apic id for
> > > configuring/checking numa structures, or it just uses whatever ACPI
> > > SRAT table provided.
> > >
> > >>>> + */
> > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > >>>> +                                     CpuInstanceProperties props,
> > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > >>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > >>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > >>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > >>>> +    topo_ids->node_id = props.has_node_id ?
> > >>>> +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
> > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id :
> > >>>> +0; }
> > >>>>  /*
> > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > >>>>   *
> > >>>>
> > >>
> > >
> >


