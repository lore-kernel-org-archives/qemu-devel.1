Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA8BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31648206E3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s/fp9IlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31648206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCjcb-0004zC-Ar
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 09:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCjbp-00047C-2Q; Mon, 31 Aug 2020 09:12:29 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com
 ([40.107.94.54]:63291 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCjbl-0007kw-Np; Mon, 31 Aug 2020 09:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEVpzc8jUMGmTPM/+aQY7cl0mAh5j6pMJxlao5HgU4S+kgtkeU3Q5LJUmPyLnn5U5KCo1yghylimDefVwSO3pgax99R5ILtDZV8aoVRbIZ0LzBh5gKvP3E4gpISRxkFg+LgnqHu8iPsRxzHm1AiBXdl6dunXcP1hRlCRn8u++YuzOJqTw6Yd9qy0mq72d43727ZHHrpX5bb+Y5lM/vsgks2t1rHPLfhEf0B2XK7oy5PDU1JHjUmQ+qX7gXp7XZb7mjV4Qycc1Wa4FraVs4+Ih5wcSZK16IOr5eKXTuwdLN+uxPHeuO0KJGxa5OcPZp8RnHsQlG3uopeXnK/jofMo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJwV3wqZyRJlE/LL5ZpEQdAYoJ5tDmWqzLJ8Z1Edktk=;
 b=RmhFqhLQe3Q53KPCIO9q3/llSZZbvy+dhuqRBG/reSI12ai5T4PFAj16Mf4n9EI8c/uYS1+LFoeWoCs3+WjoLh7RppYc3JQmGoD4wJgSI29auvMMSwuc8rGbC0v6J3sOsQiwVITYl6ubrx+D4tORzqT/o7+2VCdUflha1ebZ5nc/DB9jLAkRv/bpAQG+IPAd05bXSDZTe9uZ2R5d2xVw63YSd62LHLQ18BZPYDq3VPEuuRq3K4+SD7GqGiMDlyPy6O7i8/G66qnOzDHvXCk6cOouckIUQDd18sCktJexB82a8Mgtg4pUIHj8V6wLVJdWoEvFSNyjmIiOgSLBbGYOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJwV3wqZyRJlE/LL5ZpEQdAYoJ5tDmWqzLJ8Z1Edktk=;
 b=s/fp9IlQdgPxz65pKitsOAwHo2FMFAPosGY7DvUnvIh7IiXsC4HIM8D9JDU6GbviEDHXi5zK+lyVKO0IIiWaovrJmdNEv3ZGbSTDPx4CL2QK0/G5/tnterLglp1Q9fd+6cS+leI8GA1whIhg1exr8iIwspV51AiftUfFQ1sJ6QE=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 13:12:17 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 13:12:17 +0000
Subject: RE: [PATCH v6 15/20] x86: move cpu hotplug from pc to x86
To: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-16-kraxel@redhat.com>
 <20200831095032.55e7863b@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <1fb9ff57-9f7b-11d1-a3c7-e18550829ec4@amd.com>
Date: Mon, 31 Aug 2020 08:12:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200831095032.55e7863b@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:5:74::17) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM6PR07CA0040.namprd07.prod.outlook.com (2603:10b6:5:74::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 13:12:15 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f6962c9-29b8-472b-cf13-08d84daf7ba7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB238394342ADE4F929567668D95510@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUZ7rwzI+dXsi6Ohl4pgGI1MpzZbnfsHloFN0cc5n4L5H3/UCHZj6RZlrv2iM6hvet33dMbebhVH8ad9M0wyFUo7Uz2mCpDIEXDCJj79Rv37mi4yzYBwujHHHX9/N8NSyYUtW8lnugz2oRYwp+0r1rmIGaZ46uCsiHflZQRSqjXHctJD1K7lc53lxtrkE/ybSMRwBI0gAsYg6917M6e8gfP0TuJfVtNnKgFVyD50LbxZV5ffI7Gs/nohaIMHP6GCj0ZkoZu7dw9ZBy3vKX8y1Rxu15jfM/Fta9ptWOqBNXEvqInwVMBSI1gavQxCXyZd/mmyTOcRWBIAF5IeM6Reou7/9ERc3P8DJPJ3m/kPLINzHtNCNZjSp1M/Nv6DOsBD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(2906002)(8936002)(31696002)(26005)(186003)(6486002)(44832011)(52116002)(31686004)(53546011)(2616005)(956004)(66946007)(83380400001)(54906003)(110136005)(4326008)(86362001)(478600001)(8676002)(316002)(66556008)(66476007)(30864003)(36756003)(5660300002)(16576012)(7416002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2x1WxrBm9q48JopYB49roOqF7tSE+wqxkeS/QIU5eNsKPm8C++GJgpYlH+BqI4yeAYawbfGNBpwv2GV8ugv1Ssahn8PvVxvvteb5vuP2KYDUtCEjrZ+qzOO1fOpgU6mpeTFY40KHPyLDqgkM8pq+3ndBgksVRqbk5nsjMUVJYZxn/cDwaXd7tNRthaaMDPNA2CkJRWcQHGHtV14vLxr59NbA/Ab1EtW0HY5c5eYj5XRLG3wiSVid1rqjj7tH2RedhhACGnEYXYliuiZSaEtYSOkLF9dL2qbJl55etlyMTScnLJwVxa47Yprh/lV1hy4RyCeF6PuEldqEEyUsFtRMfQW84G9YaWC1u3+tnWAHJsVxkHLHCyivk88E/TmZtD1bjlxLKciO6FS4sogHGqIbkphK5rPLaM1bDOE2e0WMrYQN9fWMLoK5U5D1J2GJeNWl40D17xw14FZRQsYWOJJweLD7MmULjOfkaqaEEeGDf0PVv9+By86TyJ/UrY4QhkmUS8L326Wen982ePrqZfZLB/RXhIXzZxIk4D82ccwME3FKLFBv2lZG9OFnVmbSosmEqw3aez6Lk2M5ZV0C6JVcddYPNq12bOzycH0LbwyFOiIv/ZzudJf6ltWbd4WMsc0Hbl/z8k0d2tqr1NjuONBUnw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6962c9-29b8-472b-cf13-08d84daf7ba7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 13:12:16.8951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs4IHvcli2R2Zg4oCg4PslDUpCTc1yoBYDGeGsTB+pOmA83OywAjxUwan/NjWBVE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.94.54; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 09:12:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-2.13, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Monday, August 31, 2020 2:51 AM
> To: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org; Laurent Vivier <lvivier@redhat.com>; Peter
> Maydell <peter.maydell@linaro.org>; Thomas Huth <thuth@redhat.com>;
> Eduardo Habkost <ehabkost@redhat.com>; Sergio Lopez
> <slp@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Shannon Zhao
> <shannon.zhaosl@gmail.com>; qemu-arm@nongnu.org; Paolo Bonzini
> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>; Moger,
> Babu <Babu.Moger@amd.com>
> Subject: Re: [PATCH v6 15/20] x86: move cpu hotplug from pc to x86
> 
> On Wed, 26 Aug 2020 12:52:49 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > The cpu hotplug code handles the iniu hotplug is not supported.
> >
> > Move the code from pc to x86, so microvm can use it.
> >
> > Move both plug and unplug to keep everything in one place, even though
> > microvm needs plug only.
> 
> this will conflict with planned revert of EPYC changes
>  2e26f4ab3bf8 hw/i386: Move arch_id decode inside x86_cpus_init so it will
> mess up otherwise clean revert, I'd prefer revert being merged first and than
> this reased on top of it.

Sure. I will send the revert patches later today. Thanks

> 
> 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/hw/i386/x86.h |  10 ++
> >  hw/i386/pc.c          | 283 +-----------------------------------------
> >  hw/i386/x86.c         | 268
> +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 283 insertions(+), 278 deletions(-)
> >
> > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h index
> > de74c831c3ab..5c3803e74e31 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -102,6 +102,16 @@ CpuInstanceProperties
> x86_cpu_index_to_props(MachineState *ms,
> >                                               unsigned cpu_index);
> > int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
> > const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
> > +CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int
> > +*idx); void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t
> > +cpus_count); void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > +                      DeviceState *dev, Error **errp); void
> > +x86_cpu_plug(HotplugHandler *hotplug_dev,
> > +                  DeviceState *dev, Error **errp); void
> > +x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> > +                               DeviceState *dev, Error **errp); void
> > +x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> > +                       DeviceState *dev, Error **errp);
> >
> >  void x86_bios_rom_init(MemoryRegion *rom_memory, bool
> isapc_ram_fw);
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c index
> > 0bd6dbbd7bf6..b55369357e5d 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -803,19 +803,6 @@ void pc_hot_add_cpu(MachineState *ms, const
> int64_t id, Error **errp)
> >      }
> >  }
> >
> > -static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
> > -{
> > -    if (cpus_count > 0xff) {
> > -        /* If the number of CPUs can't be represented in 8 bits, the
> > -         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
> > -         * to make old BIOSes fail more predictably.
> > -         */
> > -        rtc_set_memory(rtc, 0x5f, 0);
> > -    } else {
> > -        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
> > -    }
> > -}
> > -
> >  static
> >  void pc_machine_done(Notifier *notifier, void *data)  { @@ -825,7
> > +812,7 @@ void pc_machine_done(Notifier *notifier, void *data)
> >      PCIBus *bus = pcms->bus;
> >
> >      /* set the number of CPUs */
> > -    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> > +    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> >
> >      if (bus) {
> >          int extra_hosts = 0;
> > @@ -1373,266 +1360,6 @@ static void pc_memory_unplug(HotplugHandler
> *hotplug_dev,
> >      error_propagate(errp, local_err);  }
> >
> > -static int pc_apic_cmp(const void *a, const void *b) -{
> > -   CPUArchId *apic_a = (CPUArchId *)a;
> > -   CPUArchId *apic_b = (CPUArchId *)b;
> > -
> > -   return apic_a->arch_id - apic_b->arch_id;
> > -}
> > -
> > -/* returns pointer to CPUArchId descriptor that matches CPU's apic_id
> > - * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
> > - * entry corresponding to CPU's apic_id returns NULL.
> > - */
> > -static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int
> > *idx) -{
> > -    CPUArchId apic_id, *found_cpu;
> > -
> > -    apic_id.arch_id = id;
> > -    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> > -        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> > -        pc_apic_cmp);
> > -    if (found_cpu && idx) {
> > -        *idx = found_cpu - ms->possible_cpus->cpus;
> > -    }
> > -    return found_cpu;
> > -}
> > -
> > -static void pc_cpu_plug(HotplugHandler *hotplug_dev,
> > -                        DeviceState *dev, Error **errp)
> > -{
> > -    CPUArchId *found_cpu;
> > -    Error *local_err = NULL;
> > -    X86CPU *cpu = X86_CPU(dev);
> > -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> > -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > -
> > -    if (x86ms->acpi_dev) {
> > -        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
> > -        if (local_err) {
> > -            goto out;
> > -        }
> > -    }
> > -
> > -    /* increment the number of CPUs */
> > -    x86ms->boot_cpus++;
> > -    if (x86ms->rtc) {
> > -        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> > -    }
> > -    if (x86ms->fw_cfg) {
> > -        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms-
> >boot_cpus);
> > -    }
> > -
> > -    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> > -    found_cpu->cpu = OBJECT(dev);
> > -out:
> > -    error_propagate(errp, local_err);
> > -}
> > -static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> > -                                     DeviceState *dev, Error **errp)
> > -{
> > -    int idx = -1;
> > -    X86CPU *cpu = X86_CPU(dev);
> > -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> > -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > -
> > -    if (!x86ms->acpi_dev) {
> > -        error_setg(errp, "CPU hot unplug not supported without ACPI");
> > -        return;
> > -    }
> > -
> > -    pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> > -    assert(idx != -1);
> > -    if (idx == 0) {
> > -        error_setg(errp, "Boot CPU is unpluggable");
> > -        return;
> > -    }
> > -
> > -    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
> > -                                   errp);
> > -}
> > -
> > -static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> > -                             DeviceState *dev, Error **errp)
> > -{
> > -    CPUArchId *found_cpu;
> > -    Error *local_err = NULL;
> > -    X86CPU *cpu = X86_CPU(dev);
> > -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> > -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > -
> > -    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
> > -    if (local_err) {
> > -        goto out;
> > -    }
> > -
> > -    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> > -    found_cpu->cpu = NULL;
> > -    qdev_unrealize(dev);
> > -
> > -    /* decrement the number of CPUs */
> > -    x86ms->boot_cpus--;
> > -    /* Update the number of CPUs in CMOS */
> > -    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> > -    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms-
> >boot_cpus);
> > - out:
> > -    error_propagate(errp, local_err);
> > -}
> > -
> > -static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > -                            DeviceState *dev, Error **errp)
> > -{
> > -    int idx;
> > -    CPUState *cs;
> > -    CPUArchId *cpu_slot;
> > -    X86CPUTopoIDs topo_ids;
> > -    X86CPU *cpu = X86_CPU(dev);
> > -    CPUX86State *env = &cpu->env;
> > -    MachineState *ms = MACHINE(hotplug_dev);
> > -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> > -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > -    unsigned int smp_cores = ms->smp.cores;
> > -    unsigned int smp_threads = ms->smp.threads;
> > -    X86CPUTopoInfo topo_info;
> > -
> > -    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> > -        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> > -                   ms->cpu_type);
> > -        return;
> > -    }
> > -
> > -    init_topo_info(&topo_info, x86ms);
> > -
> > -    env->nr_dies = x86ms->smp_dies;
> > -    env->nr_nodes = topo_info.nodes_per_pkg;
> > -    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
> > -
> > -    /*
> > -     * If APIC ID is not set,
> > -     * set it based on socket/die/core/thread properties.
> > -     */
> > -    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> > -        int max_socket = (ms->smp.max_cpus - 1) /
> > -                                smp_threads / smp_cores / x86ms->smp_dies;
> > -
> > -        /*
> > -         * die-id was optional in QEMU 4.0 and older, so keep it optional
> > -         * if there's only one die per socket.
> > -         */
> > -        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
> > -            cpu->die_id = 0;
> > -        }
> > -
> > -        if (cpu->socket_id < 0) {
> > -            error_setg(errp, "CPU socket-id is not set");
> > -            return;
> > -        } else if (cpu->socket_id > max_socket) {
> > -            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
> > -                       cpu->socket_id, max_socket);
> > -            return;
> > -        }
> > -        if (cpu->die_id < 0) {
> > -            error_setg(errp, "CPU die-id is not set");
> > -            return;
> > -        } else if (cpu->die_id > x86ms->smp_dies - 1) {
> > -            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
> > -                       cpu->die_id, x86ms->smp_dies - 1);
> > -            return;
> > -        }
> > -        if (cpu->core_id < 0) {
> > -            error_setg(errp, "CPU core-id is not set");
> > -            return;
> > -        } else if (cpu->core_id > (smp_cores - 1)) {
> > -            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
> > -                       cpu->core_id, smp_cores - 1);
> > -            return;
> > -        }
> > -        if (cpu->thread_id < 0) {
> > -            error_setg(errp, "CPU thread-id is not set");
> > -            return;
> > -        } else if (cpu->thread_id > (smp_threads - 1)) {
> > -            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
> > -                       cpu->thread_id, smp_threads - 1);
> > -            return;
> > -        }
> > -
> > -        topo_ids.pkg_id = cpu->socket_id;
> > -        topo_ids.die_id = cpu->die_id;
> > -        topo_ids.core_id = cpu->core_id;
> > -        topo_ids.smt_id = cpu->thread_id;
> > -        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,
> &topo_ids);
> > -    }
> > -
> > -    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> > -    if (!cpu_slot) {
> > -        MachineState *ms = MACHINE(pcms);
> > -
> > -        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> > -        error_setg(errp,
> > -            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> > -            " APIC ID %" PRIu32 ", valid index range 0:%d",
> > -            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id,
> topo_ids.smt_id,
> > -            cpu->apic_id, ms->possible_cpus->len - 1);
> > -        return;
> > -    }
> > -
> > -    if (cpu_slot->cpu) {
> > -        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
> > -                   idx, cpu->apic_id);
> > -        return;
> > -    }
> > -
> > -    /* if 'address' properties socket-id/core-id/thread-id are not set, set
> them
> > -     * so that machine_query_hotpluggable_cpus would show correct
> values
> > -     */
> > -    /* TODO: move socket_id/core_id/thread_id checks into
> x86_cpu_realizefn()
> > -     * once -smp refactoring is complete and there will be CPU private
> > -     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals
> */
> > -    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> > -    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
> > -        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> > -            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> > -            topo_ids.pkg_id);
> > -        return;
> > -    }
> > -    cpu->socket_id = topo_ids.pkg_id;
> > -
> > -    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
> > -        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
> > -            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
> > -        return;
> > -    }
> > -    cpu->die_id = topo_ids.die_id;
> > -
> > -    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
> > -        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> > -            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> > -            topo_ids.core_id);
> > -        return;
> > -    }
> > -    cpu->core_id = topo_ids.core_id;
> > -
> > -    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
> > -        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
> > -            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
> > -            topo_ids.smt_id);
> > -        return;
> > -    }
> > -    cpu->thread_id = topo_ids.smt_id;
> > -
> > -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> > -        !kvm_hv_vpindex_settable()) {
> > -        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
> > -        return;
> > -    }
> > -
> > -    cs = CPU(cpu);
> > -    cs->cpu_index = idx;
> > -
> > -    numa_cpu_pre_plug(cpu_slot, dev, errp);
> > -}
> > -
> >  static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
> >                                        DeviceState *dev, Error **errp)
> > { @@ -1701,7 +1428,7 @@ static void
> > pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          pc_memory_pre_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > -        pc_cpu_pre_plug(hotplug_dev, dev, errp);
> > +        x86_cpu_pre_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)
> ||
> >                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> >          pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp); @@ -1714,7
> > +1441,7 @@ static void pc_machine_device_plug_cb(HotplugHandler
> *hotplug_dev,
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          pc_memory_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > -        pc_cpu_plug(hotplug_dev, dev, errp);
> > +        x86_cpu_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)
> ||
> >                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> >          pc_virtio_md_pci_plug(hotplug_dev, dev, errp); @@ -1727,7
> > +1454,7 @@ static void
> pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          pc_memory_unplug_request(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > -        pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> > +        x86_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)
> ||
> >                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> >          pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp); @@
> > -1743,7 +1470,7 @@ static void
> pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          pc_memory_unplug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > -        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
> > +        x86_cpu_unplug_cb(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)
> ||
> >                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> >          pc_virtio_md_pci_unplug(hotplug_dev, dev, errp); diff --git
> > a/hw/i386/x86.c b/hw/i386/x86.c index 31a82885d735..f1eeca01cd79
> > 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -41,6 +41,7 @@
> >  #include "hw/i386/topology.h"
> >  #include "hw/i386/fw_cfg.h"
> >  #include "hw/intc/i8259.h"
> > +#include "hw/rtc/mc146818rtc.h"
> >
> >  #include "hw/acpi/cpu_hotplug.h"
> >  #include "hw/irq.h"
> > @@ -165,6 +166,273 @@ void x86_cpus_init(X86MachineState *x86ms, int
> default_cpu_version)
> >      }
> >  }
> >
> > +void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > +                      DeviceState *dev, Error **errp) {
> > +    int idx;
> > +    CPUState *cs;
> > +    CPUArchId *cpu_slot;
> > +    X86CPUTopoIDs topo_ids;
> > +    X86CPU *cpu = X86_CPU(dev);
> > +    CPUX86State *env = &cpu->env;
> > +    MachineState *ms = MACHINE(hotplug_dev);
> > +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > +    unsigned int smp_cores = ms->smp.cores;
> > +    unsigned int smp_threads = ms->smp.threads;
> > +    X86CPUTopoInfo topo_info;
> > +
> > +    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> > +        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> > +                   ms->cpu_type);
> > +        return;
> > +    }
> > +
> > +    init_topo_info(&topo_info, x86ms);
> > +
> > +    env->nr_dies = x86ms->smp_dies;
> > +    env->nr_nodes = topo_info.nodes_per_pkg;
> > +    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
> > +
> > +    /*
> > +     * If APIC ID is not set,
> > +     * set it based on socket/die/core/thread properties.
> > +     */
> > +    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> > +        int max_socket = (ms->smp.max_cpus - 1) /
> > +                                smp_threads / smp_cores /
> > + x86ms->smp_dies;
> > +
> > +        /*
> > +         * die-id was optional in QEMU 4.0 and older, so keep it optional
> > +         * if there's only one die per socket.
> > +         */
> > +        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
> > +            cpu->die_id = 0;
> > +        }
> > +
> > +        if (cpu->socket_id < 0) {
> > +            error_setg(errp, "CPU socket-id is not set");
> > +            return;
> > +        } else if (cpu->socket_id > max_socket) {
> > +            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
> > +                       cpu->socket_id, max_socket);
> > +            return;
> > +        }
> > +        if (cpu->die_id < 0) {
> > +            error_setg(errp, "CPU die-id is not set");
> > +            return;
> > +        } else if (cpu->die_id > x86ms->smp_dies - 1) {
> > +            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
> > +                       cpu->die_id, x86ms->smp_dies - 1);
> > +            return;
> > +        }
> > +        if (cpu->core_id < 0) {
> > +            error_setg(errp, "CPU core-id is not set");
> > +            return;
> > +        } else if (cpu->core_id > (smp_cores - 1)) {
> > +            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
> > +                       cpu->core_id, smp_cores - 1);
> > +            return;
> > +        }
> > +        if (cpu->thread_id < 0) {
> > +            error_setg(errp, "CPU thread-id is not set");
> > +            return;
> > +        } else if (cpu->thread_id > (smp_threads - 1)) {
> > +            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
> > +                       cpu->thread_id, smp_threads - 1);
> > +            return;
> > +        }
> > +
> > +        topo_ids.pkg_id = cpu->socket_id;
> > +        topo_ids.die_id = cpu->die_id;
> > +        topo_ids.core_id = cpu->core_id;
> > +        topo_ids.smt_id = cpu->thread_id;
> > +        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,
> &topo_ids);
> > +    }
> > +
> > +    cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
> > +    if (!cpu_slot) {
> > +        MachineState *ms = MACHINE(x86ms);
> > +
> > +        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info,
> &topo_ids);
> > +        error_setg(errp,
> > +            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> > +            " APIC ID %" PRIu32 ", valid index range 0:%d",
> > +            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id,
> topo_ids.smt_id,
> > +            cpu->apic_id, ms->possible_cpus->len - 1);
> > +        return;
> > +    }
> > +
> > +    if (cpu_slot->cpu) {
> > +        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
> > +                   idx, cpu->apic_id);
> > +        return;
> > +    }
> > +
> > +    /* if 'address' properties socket-id/core-id/thread-id are not set, set
> them
> > +     * so that machine_query_hotpluggable_cpus would show correct
> values
> > +     */
> > +    /* TODO: move socket_id/core_id/thread_id checks into
> x86_cpu_realizefn()
> > +     * once -smp refactoring is complete and there will be CPU private
> > +     * CPUState::nr_cores and CPUState::nr_threads fields instead of
> globals */
> > +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> > +    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
> > +        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> > +            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> > +            topo_ids.pkg_id);
> > +        return;
> > +    }
> > +    cpu->socket_id = topo_ids.pkg_id;
> > +
> > +    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
> > +        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
> > +            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
> > +        return;
> > +    }
> > +    cpu->die_id = topo_ids.die_id;
> > +
> > +    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
> > +        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> > +            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> > +            topo_ids.core_id);
> > +        return;
> > +    }
> > +    cpu->core_id = topo_ids.core_id;
> > +
> > +    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
> > +        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
> > +            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
> > +            topo_ids.smt_id);
> > +        return;
> > +    }
> > +    cpu->thread_id = topo_ids.smt_id;
> > +
> > +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> > +        !kvm_hv_vpindex_settable()) {
> > +        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
> > +        return;
> > +    }
> > +
> > +    cs = CPU(cpu);
> > +    cs->cpu_index = idx;
> > +
> > +    numa_cpu_pre_plug(cpu_slot, dev, errp); }
> > +
> > +void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count) {
> > +    if (cpus_count > 0xff) {
> > +        /* If the number of CPUs can't be represented in 8 bits, the
> > +         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
> > +         * to make old BIOSes fail more predictably.
> > +         */
> > +        rtc_set_memory(rtc, 0x5f, 0);
> > +    } else {
> > +        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
> > +    }
> > +}
> > +
> > +static int x86_apic_cmp(const void *a, const void *b) {
> > +   CPUArchId *apic_a = (CPUArchId *)a;
> > +   CPUArchId *apic_b = (CPUArchId *)b;
> > +
> > +   return apic_a->arch_id - apic_b->arch_id; }
> > +
> > +/* returns pointer to CPUArchId descriptor that matches CPU's apic_id
> > + * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
> > + * entry corresponding to CPU's apic_id returns NULL.
> > + */
> > +CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
> > +{
> > +    CPUArchId apic_id, *found_cpu;
> > +
> > +    apic_id.arch_id = id;
> > +    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> > +        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> > +        x86_apic_cmp);
> > +    if (found_cpu && idx) {
> > +        *idx = found_cpu - ms->possible_cpus->cpus;
> > +    }
> > +    return found_cpu;
> > +}
> > +
> > +void x86_cpu_plug(HotplugHandler *hotplug_dev,
> > +                  DeviceState *dev, Error **errp) {
> > +    CPUArchId *found_cpu;
> > +    X86CPU *cpu = X86_CPU(dev);
> > +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > +
> > +    if (x86ms->acpi_dev) {
> > +        hotplug_handler_plug(x86ms->acpi_dev, dev, errp);
> > +        if (*errp) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    /* increment the number of CPUs */
> > +    x86ms->boot_cpus++;
> > +    if (x86ms->rtc) {
> > +        x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> > +    }
> > +    if (x86ms->fw_cfg) {
> > +        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms-
> >boot_cpus);
> > +    }
> > +
> > +    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id,
> NULL);
> > +    found_cpu->cpu = OBJECT(dev);
> > +}
> > +
> > +void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> > +                               DeviceState *dev, Error **errp) {
> > +    int idx = -1;
> > +    X86CPU *cpu = X86_CPU(dev);
> > +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > +
> > +    if (!x86ms->acpi_dev) {
> > +        error_setg(errp, "CPU hot unplug not supported without ACPI");
> > +        return;
> > +    }
> > +
> > +    x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
> > +    assert(idx != -1);
> > +    if (idx == 0) {
> > +        error_setg(errp, "Boot CPU is unpluggable");
> > +        return;
> > +    }
> > +
> > +    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
> > +                                   errp); }
> > +
> > +void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> > +                       DeviceState *dev, Error **errp) {
> > +    CPUArchId *found_cpu;
> > +    Error *local_err = NULL;
> > +    X86CPU *cpu = X86_CPU(dev);
> > +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> > +
> > +    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +
> > +    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id,
> NULL);
> > +    found_cpu->cpu = NULL;
> > +    qdev_unrealize(dev);
> > +
> > +    /* decrement the number of CPUs */
> > +    x86ms->boot_cpus--;
> > +    /* Update the number of CPUs in CMOS */
> > +    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> > +    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS,
> > +x86ms->boot_cpus);
> > + out:
> > +    error_propagate(errp, local_err); }
> > +
> >  CpuInstanceProperties
> >  x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)  {


