Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED2BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E925220758
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aNy/+4o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8WXB-0004Zp-7W
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 18:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8WWc-00049T-BK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:25:42 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com
 ([40.107.92.72]:59873 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8WWZ-0006aL-Nu
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgD9DFzTNvNDcmpBZnFP6TcL9Pc0f7aVrcld9u9YfxUQ76833ic6dFlyFUQD2X5Uwrl9N2uxquy04dHa5aZ2nXQLUmR3zTEO/wyNKB3WLI6w7m8H1ji67M+DxGHHGk06XVEMIassHyG6rbtNPGXsy8uQ870Z9UPuB5gQKRb9/fkdlioivdBJjYNXJdgg/8xr3nLKcUTLyZN/26BzU6qnJ6zs3aLp3gayZCh7Bg4UqDvdl7tbnh6psuyNTRhq3wHLbmqxTBoB1jPIII6eINojtPu4Ebs58/2ekwwNRgdCKI7yQqVk5WtroZTjYLARdx0rbURfHVu9xU5yqZe3W/QqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WjojCY0nEVJzD+LQl0J5LJ78s5wZPamxs9W6UOXHPU=;
 b=cyvx0fQU8eyHtcO64xTGHSwsANxGYQc3oYEqwJTMpiFII5QeJEQuWik3y/MGxc5fWYJo6kMIajl7mdAgkW1pGhWUb5YeyItBMrmno2NSy3fXF+a8pX0lcFbAIBnKK1hHzASIwKiQ1+i9XuuaWkM7d5JZ/Q7jNBpOoap3CCXDju/6nr+hGDPKfivmVWxToGtcliAVNYyqcgOMuB2UV5q5I54aA2xqEAXU6+/scsF0cUhRl8pi8nkiqbFVf8nHxq6dLmnu6gC28DEA7McqrODjjuv9X7o1uzZnHOAeWYzDEB6jy3WPoHnda+87oPz7lDROKk2CIeks5IAGaS4CUu1W1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WjojCY0nEVJzD+LQl0J5LJ78s5wZPamxs9W6UOXHPU=;
 b=aNy/+4o9W4ze9OCCdVBZDTb3as15ZxQbE3xwUEZpKPolT6SOSLGlgyMGx6ojheUHs7T+ILmXmqfoBxzTquUDGDMNuG5seTL2FcE+iOc6q2zKNalxLb84uWqQb92qzEVmnfxoyONPJ1GF6GUun8AqpqUNrbFCfDD5/VmRkXuikJ8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 22:10:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 22:10:34 +0000
Subject: RE: [PATCH v4 2/3] hw/i386: Update the EPYC topology to use
 socket/dies/core/thread model
To: Igor Mammedov <imammedo@redhat.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
 <159744117377.39197.9319853595178174798.stgit@naples-babu.amd.com>
 <20200819132538.1173e444@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <82b39dd9-3e70-c3cb-6ee7-163d57097d4f@amd.com>
Date: Wed, 19 Aug 2020 17:10:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819132538.1173e444@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0601CA0019.namprd06.prod.outlook.com
 (2603:10b6:803:2f::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0601CA0019.namprd06.prod.outlook.com (2603:10b6:803:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Wed, 19 Aug 2020 22:10:33 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15705e40-2931-408a-6176-08d8448cb1ba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:
X-Microsoft-Antispam-PRVS: <SN6PR12MB262396D7099997C234F60D6E955D0@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfKbF/ZyPOf4Jh6b2E8B5p+kWnq8IqKN27B7PPL8CdZpGFbZU8hBb2BRX3ypW+0RktgIEhYdHavguZMI74uFFzGDy+imMN4Ds2AMXXnHNvhaf4zEo3wOKzlSEmoMn8A23qI2ixaefzRPGqhK8wEmeS941u/JZDrrUzdj6BNQsNnnbLzt+Dv4nFTPSoPoNEHDbxR4GDnJJZ3sh9T2lCsnKad6UvYMN46RfXp2ClBDjrle305DzQRfFRZ4FFcqDRH9Tss9sNaUXl0rTT8mM2q8fTmeWdPeyPdjTjxr/TVVyB6ILnhdDYa13smhL7xiNScmfBLD0yHTes0ebSao1IgjqCQB07D35N1V5LxWrkWdib2kFSJHhNbS5cEopUBb8fPamGWVSYXTJKTlr87poPxQys2ZWY+2TDogKbtFcVsZI38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(186003)(31696002)(4326008)(26005)(86362001)(8936002)(31686004)(44832011)(478600001)(956004)(110011004)(66946007)(2616005)(8676002)(5660300002)(54906003)(316002)(15650500001)(52116002)(16576012)(66476007)(83380400001)(2906002)(53546011)(6486002)(36756003)(66556008)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MQl98glzXsyHP2tD6GhJIETpN0DHbgjQY3wHqgHXu6raT6R+ZFkETchf+DcwiXrJBICaQV8MF94YvvoZfgwLP/DlWixaAxDj6fEsUamL3S66+tlJIRFLEem6YKUpf+6IplTbyC6oljzUjf5ldn6ROLtasCtMisekPUm6NE0Z9qO5f8MhOPXn8XgNyzITnF915Y8TpTUoHwSTQAUIZE1+hfjcuyTLJObZ4UcjGYARDVYMTcHIQ9V7aujqqXBOsiJ5X0r3SzMZXzTCaPIYGYCBEkO1K7YGF+sN9jjibKybrTm1oxcUG6i7hsX/dAOO32ohRubZSI5GC4/URNZmiRqpQ63KmrFjPbAxpanAHdZge79d05/rmcK01hXxyY9FCl50vfpgMAdWCH8TxpNbPuV8Dmr07XhMwBhrppAqtDj/32LY6pVJzP6BKTVCu3QxplXIeHZ3IixGmkwwDIfh+ZIya70eVbTxD6IJnw1MBFocntnLpG3l/AY9XgUgaUNM6EhKjaxPr5VQmDzwypj/ELSbQlvxDc6dt49rNnnItEmwtYYWfh69Wq+SfDRBfMGLeAZi6AMy49fc7OwA5Iwk5DATvsnGzkr1K++M0LqbL6usAxiLb0th9bWN+PEz8Y4+4fBw42jrSbco1/XDfUTs944oug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15705e40-2931-408a-6176-08d8448cb1ba
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 22:10:34.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pioKa+Qdftp35VfppKfJN/bF8J0d3xeg2HZE5CRPFexPEiDXmVFqjOvITadD5aYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
Received-SPF: none client-ip=40.107.92.72; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 18:25:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Sent: Wednesday, August 19, 2020 6:26 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v4 2/3] hw/i386: Update the EPYC topology to use
> socket/dies/core/thread model
> 
> On Fri, 14 Aug 2020 16:39:33 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > Update the EPYC topology to use socket/dies/core/thread model. The
> > EPYC model does not use the smp dies to build the topology. Instead,
> > it uses numa nodes to build the topology. Internally both are similar
> > concept which divides the cores on L3 boundary. Combining both into
> > one terminology makes it simple to program.
> >
> > Add a new check to error out when smp dies are not provided when EPYC
> > model is numa configured. Next task is to remove node_id, nr_nodes and
> > nodes_per_pkg from EPYC topology which will be done in next patch.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/x86.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c index
> > 67bee1bcb8..e90c42d2fc 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -138,6 +138,14 @@ void x86_cpus_init(X86MachineState *x86ms, int
> > default_cpu_version)
> >
> >      /* Check for apicid encoding */
> >      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> > +        if ((ms->numa_state->num_nodes > 0) &&
> 
> > +            ms->numa_state->num_nodes != (ms->smp.sockets *
> > + x86ms->smp_dies)) {
> this case is gated by (ms->numa_state->num_nodes > 0) so it won't work in case
> -smp dies=>1 but there is no -numa options at all

Looking back again, this check does not appear to be a good idea. The numa
information is coming from ACPI and die information is coming from CPU
internal hardware config. It may not match. I don't think this check will
be good option. Sorry. I did not think about that earlier.

> 
> we need to error out and ask to provide numa nodes corresponding to
>    (ms->numa_state->num_nodes == 0) && (ms->smp.sockets * x86ms-
> >smp_dies)
> 
> or better alternative would be to enable autonuma when EPYC cpu is enabled,
> that will insure that this patch will work even if user hasn't specified -numa
> option, since it will create a single numa node automatically.
> 
> The later will take care of (-smp 1,dies=1) case, which is broken due to lack of
> explicit -numa we end up with CPU_UNSET_NUMA_NODE_ID in
> CPUID_Fn8000001E_ECX.
> 
> > +            error_setg(&error_fatal, "Numa configuration here requires smp "
> > +                       "'dies' parameter. Configure the cpu topology properly "
> > +                       "with max_cpus = sockets * dies * cores * threads. Dies"
> > +                       " is equivalent to number of numa nodes in a socket.");
> > +            return;
> > +        }
> >          x86_set_epyc_topo_handlers(ms);
> >      }
> >
> >


