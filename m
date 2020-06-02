Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C56206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a05CthZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C56206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAwO-0003Ql-FB
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgAvb-0002rT-Uq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:42:19 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com
 ([40.107.94.51]:46016 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgAva-00070D-Ah
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+C2ObuxBujXgDM1Gbzp6V8wtngOuAJxwHgG4ICmiTNDWj967PM4c1tpoZcfI5BBhJZm1TmHByKjtpIXYYnw9rylgKpIqM8Dfsvr4VodY8ZUCqiGrUulLY5i56DCliFYK/S3tS/CpQNe3DvNKatsbNe8q730hAi+NXyotKG5UcTYtE5JaVXYS+ucO0YspNNu7KKxJX6Ze013HNIzYjJyZPkOLch90o8goHsAYpr6bznCPQLsYGTWE7JKNrqDoVzWuqsjzP7dSLhfmioCL/e2HZ5UnXszvSoU10BmU5NNQa5L0QopQLb+HhxmBQ+9sjAHwjW+CAYn4DWk3Fa3fWegrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxXdeCOndaomq4exaSKrLgAZn2YVnmVTvkNS6yArQdk=;
 b=Lltq1Z5TlbOPOV41/l4VYmXyE4Y6VdKpZ0sL0AvmX9+HPey1Z4EoI878RitV7om79wKkOYY4aDeYpI4RnfLNE2omFUYScsEltQTS7Oj0Ex2smtX9QBZeVnlfmfrfz0ybGuWDu9JYYCTd/1+HEEM0xy36xpLHu7NT2K8I80iPXG9S56WOFMwuoTNAuckv1HMLHlWLpJjyVrTpQdDxPfmbKjwQLlwQVngikSO1gnZCZxEAgRJhd4jrdwBFYjKQ44rEfkoi9v45sBqfaN3sFjsDR0N9CkIqVkMGwD7K+p6wLkGSxUvJWSAt6/7CKzkFnrKvaEGFi34QqhtVRLsrjqYcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxXdeCOndaomq4exaSKrLgAZn2YVnmVTvkNS6yArQdk=;
 b=a05CthZZBKlp1uWw/QiXjjVShDpsubXSd4Lflx3k6MrU7CHfHySKy22xNCSY/uad3NAAKawVdVJ3twGUOuc2pCBN4liouQU5rS/Kp8khJ7rV5gTHuye1XOEfW1PTxKJKGTTAOTLSNtp4q/m8TuI/o1OWqy1rewmacSjtX4uLOO8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 17:27:13 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 17:27:13 +0000
Subject: RE: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <69200139-f0d8-cbce-04a4-28df3763c886@amd.com>
Date: Tue, 2 Jun 2020 12:27:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602171838.GG577771@habkost.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:6e::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SA9PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:6e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Tue, 2 Jun 2020 17:27:13 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d88cc21-0a60-48c5-cb00-08d8071a3043
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25606E7425671A946DB97C8D958B0@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0td2pNdcVRbfOcUUHL/JfA0ZrS1Px8e2EVAZWJ5WAAnqwR9xagWpoAik2gxZqydvIxfDMjZwRp2wfvAY6bt3VbiVRTCSHrx18jqiHmNfVZmkkGo0dOhGWDUUvvjhz58t4Ib1Mu1NKTCL21o4RyeEFCeWTrkONneGLMVbuRp4qaHWf2Rim/JZ94oP9D9LABn3tDyvMF/a4KNQKB0p6hWJ2TijkqpypcYFPzEjtyEJnAGApnWs2kK+SjqJ8712XqG8ThcYsSeMiIZ2WfBqJSAhZI6MLC+4+2hhuHcpzy6lnWMj9u/5H6320682zEBHsv5Rdajp9xWkgMOSzraBoOHK1rqgDXPeJbECiuCJEq5HKVkJwN1XsFbghyNV3xFTXExXquuyQPVKsOgdpJJDyb33I/cElBM5u2TEdGdgYDbbprHkbKUQz1yUDcNj+exDI0NWFfdATwfGCxzJqXm36Ysdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(16576012)(54906003)(83380400001)(2906002)(66946007)(66556008)(83080400001)(16526019)(31696002)(66476007)(186003)(44832011)(2616005)(316002)(956004)(6916009)(4326008)(53546011)(36756003)(966005)(478600001)(31686004)(52116002)(8676002)(86362001)(8936002)(5660300002)(26005)(45080400002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aKq9cYbBelS1cBZd1jDGNoV2zDvRIudw1waF+959Ml+xJRhnIIOedQ69INC2kgc3Pco2JXMeA8yMu0Hz7e/gCITS54hLEK5mEI9JaYRloxXUjQ8yiFIFnop6kYdKe9Puq/jKTu9evcaReZsGsPsarNknxY5niaN0IuNS5zuXOO2p8qMosEVU3GTbOunbJwEe5D9EBL6xwn7FHdyDnmqJeohCJzeyUkJbbuIz7y6I71/vGq8W+jJVGwQmJmSwxTynCqc7XcSSIuqwAozacoTO9JYMfiMJC+CRUuK+7+hQlrFLHe5adeRGQmhAIDY3bZ/pcLYm/oJqMkSYxU0+Z+ieoKajFdTRV643yyJCNZ4xbmNpm3P8ZnZ+f6i9HtemIyTeYiNqghuwcc3Zhynz2hKke7wHx2XN3zomT3kfnSi+XTn7tbhRS8/BvxEU5cirn6mnRXf+BVU8vS7qVWMZiEukwmIu40Nt0cuuXxWSwahBqsc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d88cc21-0a60-48c5-cb00-08d8071a3043
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 17:27:13.5956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm8+GR6f3ESBJmKOEXLnh4hzinLVkqJ4GkIUYTq8ynVh2MJCFA/InyEslM/uIZks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
Received-SPF: none client-ip=40.107.94.51; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 13:42:16
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

Oh. Ok.. Will look at it. thanks

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
> 
> --
> Eduardo


