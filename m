Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20991C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA257207F5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cDIjGLfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA257207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0tmU-0008Cn-56
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 17:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k0tlg-0007ly-4n
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 17:37:44 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com
 ([40.107.94.68]:47329 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k0tlc-0004Q9-Vj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 17:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxIFCGgqhSU7Zgmyl3ukoSfgjzsCdaWK9Q/MqoxGEArxjGz4VdpbqZjNSpjQaA6szi89NpnXBbLmOWEX3xkwl7ss4ExLRe7g31KQ6t2HmhZOph2zTu9cYrsROoZAuswbM8oNU+BCVqk/P5cDnsDihL131qrLmDDmtRmpcvhfKGp1EInDaF77p1GxhX+Edf01v5DDcxdvmnM/LhZofOo3u+MCMfjnDqUvqm4wQ5hCLPUR2+FWPN7DuCd9kVDH1bRrDHQTJXvAITmW5k7e9N3JPn43oXJYczXCGaPC0vFiUZsfQnb5Ky/vcHE8U8CeH+aGrB4DeKCkF7XmRRFLFzEoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEqsIWuCJTRreOBr8/DB1kHHG+h7jxdFV+CJpqRZQuE=;
 b=OFGzMkGWmrpUuBtzcu9s0X+OsnrEFaUXHwQZQ3hZHAcCBPCJn5UPXBh/DpktdmKF/oljW94si+gdFWLTmFMimye0zvmKY6EtrPE2J/DgL5wibrIrJzn6ShXjT0MUY6SVrMfodrulsfX8nWVRRHvb+SkGn9sQukOgp2Bi0lCgxeaupl4jm/w9o8HX5H5QDbwf1ZAxmJ3g5VLpc6uSMZlj4+XCfpTtPj7DEZSi7h5j5KzhJniXKMlthKnPsmVjlNg1nS4I6e7a5/HJzNKkn7bURx0xYRfaPeio9FmoXcvjRJoJpPMLMR4uTueuxXlc08iWu3UIpZXq4iMSNqnxG7rVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEqsIWuCJTRreOBr8/DB1kHHG+h7jxdFV+CJpqRZQuE=;
 b=cDIjGLfrRjUA/KigCK6efzCIH/J+dUdGTB6fHfVYSXiUWkoqphAtr3Yy7PieZxWLpKhcEmMsGmLim8N+uf+KYJItuT7NJCYD81bMVgTS14FMdu4drD4tK98rhkB3827cqp2K9veQuSa2mPXFNY0DIClhBxq0I7iWMydH6EDWe+M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Wed, 29 Jul
 2020 21:22:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3216.033; Wed, 29 Jul 2020
 21:22:34 +0000
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
 <5b32c961-4fd0-8b8c-4475-eafff2ae48a9@amd.com>
 <20200727191416.2bf6e34a@redhat.com>
 <5df170bd-ea91-8347-a2cf-7ac234248197@amd.com>
 <20200729161213.3daa3933@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <e0b8086f-3678-37ea-aab8-ca5163ecee07@amd.com>
Date: Wed, 29 Jul 2020 16:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729161213.3daa3933@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR18CA0073.namprd18.prod.outlook.com (2603:10b6:3:3::11)
 To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR18CA0073.namprd18.prod.outlook.com (2603:10b6:3:3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 21:22:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d688797d-cd6d-449d-e95e-08d8340582a2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2623B18BAC5F6203B59EF86795700@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzA7oDl4ORrBwRmlM1c57/tIYr4LDYpY9oKh/y66IYdj2uGiYZJRbkLuJD/CABAKrdKmuN3jVRAVlSE20MM3r+lh1MKp2GxpzCY6iX90S8+Bw7BKKv4iAItZniTjP9XJKSVC87zZNdsN+qscJ/P/V2ZQbRLi5FBaxDKnGXVsyQ/EdZ5iSAQhAgxEvfTZG9oF68CbFhYyT9HMy8sckOCajG7K0lhx60x99GGZjgMnMgVbHBM6BkXhZl17yOGHiCTH36TZidlnpJ8mmlMS7HWWs5fPOwhGnH52GUnVquhfhra4C2nn2NlGsWstVEQqcxesg5Eq0MPuf0JpMV+EdH4DdxKe3tcqd4M3xYS+4JlwcTm5H+m7HwA647wCPS6dvtCXLe8UWUcrIJuDyB/gw6UT3FOBiTEM4Yv1umTpDOl5ASlZspqDkDhyrzdWs4idfquD6KUBiYaKYyfLHy+dAxn77w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(66476007)(6916009)(66556008)(31696002)(956004)(4326008)(83080400001)(36756003)(66946007)(186003)(16526019)(2906002)(86362001)(83380400001)(31686004)(8676002)(54906003)(966005)(6486002)(45080400002)(52116002)(53546011)(2616005)(316002)(8936002)(478600001)(44832011)(16576012)(30864003)(26005)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qBlYyEGWehLRUfw9KM38WX4x96V7cd+l7q7xhsXyWzETrggEUThXXBY2weJnjd5eLH4cHPXUvPEbbKnQ9ixcLUHgxZ48XFc0nxFW5lTGKQ0F0QSOYRVeUU27PkvlG4/2WWLXNxJJrQrbjkGpAi14rIjXpidbriFQDT4KLW2mZCl7yA73BGEBUJbNkQZSGR4Vp0cnWqTYqmiW3OFwRtHEAn1QE3xd94xlzwivK2JB1vR5dge+yh7Yau6FxjT4YEC9+i+EG/B3MpCOjX+mBwwb+X2K09QaMfK2NcokjNVkQkzhzeaf1VjETpYCEapIeZkRlOA1LzlQIwyEUyPyKNU3LfPt2uEd5o5ixiKJd1iULwebowcW8v9UB+PZl2zpOU1/pP3uPz3KFDjJi9k1u5fkrSF8kLHQgfWQeCwsNswy5DFGfxRFMhWRAkjneBycFITqrMpcabbvkI/wAAr7dJSNBM+d2M9MomBO+HH2XkV054w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d688797d-cd6d-449d-e95e-08d8340582a2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 21:22:34.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1qV3qWYxXaOkAM1C0B8wEFt/zlu+m3Cy+ro4XgBkynXbl4HNntzTQ3p52x4Nxw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
Received-SPF: none client-ip=40.107.94.68; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 17:37:38
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor,
Sorry. Few more questions.

> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Wednesday, July 29, 2020 9:12 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; qemu-devel@nongnu.org;
> ehabkost@redhat.com
> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> CpuInstanceProperties
> 
> On Mon, 27 Jul 2020 18:59:42 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Monday, July 27, 2020 12:14 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com;
> ehabkost@redhat.com;
> > > rth@twiddle.net
> > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > CpuInstanceProperties
> > >
> > > On Mon, 27 Jul 2020 10:49:08 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > Sent: Friday, July 24, 2020 12:05 PM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com;
> > > ehabkost@redhat.com;
> > > > > rth@twiddle.net
> > > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > > CpuInstanceProperties
> > > > >
> > > > > On Mon, 13 Jul 2020 14:30:29 -0500 Babu Moger
> > > > > <babu.moger@amd.com> wrote:
> > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > > Sent: Monday, July 13, 2020 12:32 PM
> > > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > Cc: pbonzini@redhat.com; rth@twiddle.net;
> > > > > > > ehabkost@redhat.com;
> > > > > > > qemu- devel@nongnu.org
> > > > > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids
> > > > > > > from CpuInstanceProperties
> > > > > > >
> > > > > > > On Mon, 13 Jul 2020 11:43:33 -0500 Babu Moger
> > > > > > > <babu.moger@amd.com> wrote:
> > > > > > >
> > > > > > > > On 7/13/20 11:17 AM, Igor Mammedov wrote:
> > > > > > > > > On Mon, 13 Jul 2020 10:02:22 -0500 Babu Moger
> > > > > > > > > <babu.moger@amd.com> wrote:
> > > > > > > > >
> > > > > > > > >>> -----Original Message-----
> > > > > > > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > > > > > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > > > > > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net;
> > > > > > > > >>> ehabkost@redhat.com;
> > > > > > > > >>> qemu- devel@nongnu.org
> > > > > > > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize
> > > > > > > > >>> topo_ids from CpuInstanceProperties
> > > > > > > > > [...]
> > > > > > > > >>>> +
> > > > > > > > >>>> +/*
> > > > > > > > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > > > > > > > >>>> + * node_id in CpuInstanceProperties(or in CPU
> > > > > > > > >>>> +device) is a sequential
> > > > > > > > >>>> + * number, but while building the topology
> > > > > > > > >>>
> > > > > > > > >>>> we need to separate it for
> > > > > > > > >>>> + * each socket(mod nodes_per_pkg).
> > > > > > > > >>> could you clarify a bit more on why this is necessary?
> > > > > > > > >>
> > > > > > > > >> If you have two sockets and 4 numa nodes, node_id in
> > > > > > > > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > > > > > > > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically
> > > > > > > > >> mod % number of nodes
> > > > > > > per socket).
> > > > > > > > >
> > > > > > > > > I'm confused, let's suppose we have 2 EPYC sockets with
> > > > > > > > > 2 nodes per socket so APIC id woulbe be composed like:
> > > > > > > > >
> > > > > > > > >  1st socket
> > > > > > > > >    pkg_id(0) | node_id(0)
> > > > > > > > >    pkg_id(0) | node_id(1)
> > > > > > > > >
> > > > > > > > >  2nd socket
> > > > > > > > >    pkg_id(1) | node_id(0)
> > > > > > > > >    pkg_id(1) | node_id(1)
> > > > > > > > >
> > > > > > > > > if that's the case, then EPYC's node_id here doesn't
> > > > > > > > > look like a NUMA node in the sense it's usually used
> > > > > > > > > (above config would have 4 different memory controllers
> > > > > > > > > => 4 conventional
> > > NUMA nodes).
> > > > > > > >
> > > > > > > > EPIC model uses combination of socket id and node id to
> > > > > > > > identify the numa nodes. So, it internally uses all the information.
> > > > > > >
> > > > > > > well with above values, EPYC's node_id doesn't look like
> > > > > > > it's specifying a machine numa node, but rather a node index
> > > > > > > within single socket. In which case, it doesn't make much
> > > > > > > sense calling it NUMA node_id, it's rather some index within
> > > > > > > a socket. (it starts looking like terminology is all mixed
> > > > > > > up)
> > > > > > >
> > > > > > > If you have access to a milti-socket EPYC machine, can you
> > > > > > > dump and post here its apic ids, pls?
> > > > > >
> > > > > > Here is the output from my EPYC machine with 2 sockets and
> > > > > > totally
> > > > > > 8 nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus
> > > > > > 32-63 in socket 1.
> > > > > >
> > > > > > # lscpu
> > > > > > Architecture:        x86_64
> > > > > > CPU op-mode(s):      32-bit, 64-bit
> > > > > > Byte Order:          Little Endian
> > > > > > CPU(s):              64
> > > > > > On-line CPU(s) list: 0-63
> > > > > > Thread(s) per core:  1
> > > > > > Core(s) per socket:  32
> > > > > > Socket(s):           2
> > > > > > NUMA node(s):        8
> > > > > > Vendor ID:           AuthenticAMD
> > > > > > CPU family:          23
> > > > > > Model:               1
> > > > > > Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
> > > > > > Stepping:            2
> > > > > > CPU MHz:             2379.233
> > > > > > CPU max MHz:         1900.0000
> > > > > > CPU min MHz:         1200.0000
> > > > > > BogoMIPS:            3792.81
> > > > > > Virtualization:      AMD-V
> > > > > > L1d cache:           32K
> > > > > > L1i cache:           64K
> > > > > > L2 cache:            512K
> > > > > > L3 cache:            8192K
> > > > > > NUMA node0 CPU(s):   0-7
> > > > > > NUMA node1 CPU(s):   8-15
> > > > > > NUMA node2 CPU(s):   16-23
> > > > > > NUMA node3 CPU(s):   24-31
> > > > > > NUMA node4 CPU(s):   32-39
> > > > > > NUMA node5 CPU(s):   40-47
> > > > > > NUMA node6 CPU(s):   48-55
> > > > > > NUMA node7 CPU(s):   56-63
> > > > > >
> > > > > > Here is the output of #cpuid  -l 0x8000001e  -r
> > > > >
> > > > >
> > > > > (1)
> > > > > > You may want to refer
> > > > > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.
> > > > > >
> > > > >
> > >
> amd.com%2Fsystem%2Ffiles%2FTechDocs%2F54945_3.03_ppr_ZP_B2_pub.zip&
> > > > > amp
> > > > > >
> > > > >
> > >
> ;data=02%7C01%7Cbabu.moger%40amd.com%7Ceacf7e8facbc4ae2eee808d82
> > > > > ff3ca9
> > > > > >
> > > > >
> > >
> 0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373120714103223
> > > > > 35&amp;
> > > > > >
> > > > >
> > >
> sdata=%2Fdr93YVlwSq82%2FwRh2NU21Zkw4HJ%2B%2FVVYxAkhCCKJ4w%3D&a
> > > > > mp;reser
> > > > > > ved=0 (section 2.1.12.2.1.3 ApicId Enumeration Requirements).
> > > > > > Note that this is a general guideline. We tried to generalize
> > > > > > in qemu as much as possible. It is bit complex.
> > > > >
> > > > >
> > > > >
> > > > > > CPU 0:
> > > > > >    0x8000001e 0x00: eax=0x00000000 ebx=0x00000100
> > > > > > ecx=0x00000300
> > > > > > edx=0x00000000
> > > > > [...]
> > > > > > CPU 63:
> > > > > >    0x8000001e 0x00: eax=0x0000007e ebx=0x0000011f
> > > > > > ecx=0x00000307
> > > > > > edx=0x00000000
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I wonder if linux guest actually uses node_id encoded in
> > > > > > > > > apic id for configuring/checking numa structures, or it
> > > > > > > > > just uses whatever ACPI SRAT table provided.
> > > > > > > > >
> > > > > > > > >>>> + */
> > > > > > > > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo
> > > *topo_info,
> > > > > > > > >>>> +                                     CpuInstanceProperties props,
> > > > > > > > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > > > > > > > >>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id
> : 0;
> > > > > > > > >>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > > > > > > > >>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > > > > > > > >>>> +    topo_ids->node_id = props.has_node_id ?
> > > > > > > > >>>> +                        props.node_id %
> > > > > > > > >>>> +MAX(topo_info->nodes_per_pkg, 1) : 0;
> > > > >
> > > > > It looks like I was wrong pushing system wide NUMA node-id into
> > > > > APIC ID (choosen naming is confusing a bit), per [1] mentioned
> > > > > above, EPYC's
> > > node-id is:
> > > > >
> > > > > • ApicId[6] = Socket ID.
> > > > > * ApicId[5:4]= Node ID.
> > > > > • ApicId[3] = Logical CCX L3 complex ID • ApicId[2:0]= (SMT) ?
> > > > > {LogicalCoreID[1:0],ThreadId} : {1'b0,LogicalCoreID[1:0]}
> > > > >
> > > > > which is can hold only 0-3 values, and defined as:
> > > > >
> > > > > "A node, is an integrated circuit device that includes one to 8
> > > > > cores (one or two Core Complexes)."
> > > > >
> > > > > spec also mentions it indirectly as die-id if one looks at
> > > > > CPUID_Fn8000001E_EBX [Core Identifiers] (Core::X86::Cpuid::CoreId) ...
> > > > >   CoreId = ({2'b0, DieId[1:0], LogicalComplexId[0],
> > > > > LogicalThreadId[2:0]} >> SMT
> > > > >
> > > > > and in
> > > > > (2)
> > > > > CPUID_Fn8000001E_ECX [Node Identifiers] (Core::X86::Cpuid::NodeId) ...
> > > > >   {5'b00000,1'b[SOCKET_ID],2'b[DIE_ID]}
> > > > >
> > > > > Question is why we did not reuse topo_ids->die_id instead of
> > > > > adding confusing topo_ids->node_id in the first place?
> > > >
> > > > Initially, I thought about it. But Intel uses die_id differently than AMD.
> > > > So, did not want complicate things.
> > > > If we take that route then we need to re-arrange the numa code as
> > > > we need to numa information to calculate the die id. So, did not
> > > > want to mix up things.
> > > >
> > > > >
> > > > > Also looking APIC ID and SRAT table provided here,
> > > > > CPUID_Fn8000001E_ECX corresponds to NUMA node id (i.e. what
> > > > > -numa in QEMU used for) and Node ID embeded into ApicId[5:4] is
> basically die-id.
> > > > >
> > > > > Difference between die-id implemented in QEMU and EPYC's die id
> > > > > (topo_ids-
> > > > > >node_id) is that the former doesn't require numa config (maybe
> > > > > >it should, but
> > > > > ship'salready sailed) and gets number of dies from '-smp dies=X'
> > > > > CLI option, while for EPYC we calculate topo_ids->node_id
> > > > > implicitly from number of numa nodes and sockets, which
> > > > > implicitly requires that machine 'must' be configured with -numa options.
> > > > >
> > > > > Maybe we should drop this implicit calculation along with
> > > > > topo_ids->node_id and reuse '-smp dies=X' plus extra checks for
> > > > > EPYC to ask for -numa if there is more than 1 die and if we need
> > > > > to be really strict, add checks for limit of dies/cores within
> > > > > socket/die according to spec[2] so encoded APIC ID and
> > > > > CPUID_8000001E match the
> > > spec.
> > > >
> > > > There will be complications when user configures with both die_id
> > > > and numa_id. It will complicate things further. I will have to
> > > > look closely at the code if it is feasible.
> > >
> > > it's worth a try.
> > > conseptionally die_id in intel/amd is the same. Most likely intel
> > > has a dedicated memory controller on each die so it still should
> > > form a NUMA node. But that aspect probably was ignored while
> > > implementing it in QEMU so ping of configuring QEMU right is on
> > > user's shoulders (there is no checks whatsoever if cpu belonging to specific
> die is on right NUMA node).
> >
> > So you are suggesting to use die_id to build the topology for EPYC.
> > Also initialize die_id based on the numa information. Re-arrange the
> > numa code to make sure we have all the information before we build the
> > topology. And then remove the node_id inside X86CPUTopoIDs. Is that the
> plan?
> reusing die_id might simplify logic and at very least we won't have 2 very similar
> fields to deal with. With die_id it should be conditional on EPYC.

Not convinced if the using the die_id will solve the problem here. But
going to investigate this little bit.
> > Regardless of using die_id, we should
> 
> (1) error out if tolopolgy will require more than 1 numa node and no numa
> config was provided.

We already have node_id check in numa_cpu_pre_plug. Do you want me to
bring this check in pc_cpu_pre_plug?

> (2) for 1 NUMA node use autonuma to create 1 node implicitly, that requres
> converting static MachineClass::auto_enable_numa into an instance specific
> value, i.e. moving it into MachineState, so that we can change it at runtime
> depending on CPU type.

Isn't it already taken care in numa_complete_configuration when num_nodes
= 0? Where does this change go if at all required?

> (3) use NUMA id from CPU::node-id for CPUID_8000001E and have a checks that
> will ensure
>     that used value is possible to fit in CPUID leaf.

Node_id is already part of apic_id. We can easily extract it from apic_id.
I have already sent the patch to simplify CPUID_8000001E. I will make it
part of this series.
https://lore.kernel.org/qemu-devel/159164753686.20543.4158548114186964547.stgit@naples-babu.amd.com/

> 
> 
> 
> 
> > > What AMD has implemented on top of that in CPU hw, is to expose NUMA
> > > node id in CPUID_8000001E. I don't know why it was done as usually
> > > it's ACPI tables that describe relations between nodes so for OS
> > > this info almost useless (I'd guess it's faster to use CPUID instead
> > > of fetching pre-cpu variable but that's pretty much it from OS point
> > > of view)
> > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > > > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id
> :
> > > > > > > > >>>> +0; }
> > > > > > > > >>>>  /*
> > > > > > > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > > > > > > >>>>   *
> > > > > > > > >>>>
> > > > > > > > >>
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > > > >
> > > >
> >
> >


