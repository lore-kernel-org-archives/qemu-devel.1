Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC82C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8AD20791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N8EvG1r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8AD20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6KkA-000585-TT
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6KjX-0004hw-Kc
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:25:59 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com
 ([40.107.237.70]:37660 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6KjV-0004Mn-CM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQGUvrN+EsnpWEB+YpgKZCfq1cVFtubamRGVggkJEO0Qq4DzCduc8um3QgQfK+d0uvf5DT1JT4aLci9Njsoep3TcUjnKgTRwBVjV/UKoRa3wnAIAlaxVPH6oxcq0jCuN587wl5HP+cSV7hfoDfSJQFQ1uiMxKUCL7cv9zCMLsW7Suquq/ZEsYY1AkRHxbZp3HYbyfPMCKpgeQir1bRjk6MWInjIR6pgYedIL+JZdoEmF5yr30evKkINdCV299eWN/LPoltYByWPAEbkDpY2ompa+vtxdM4Zph/YS8XIbx5F2SsgOOa5MMy0tefybE09W7hd0FEyAeBJZjVQP1ynOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjqiR0gIFLaII9gN8fr2gON0dV7fweMd/I7MI9r0e20=;
 b=dyLMGer+1hcBd/PTuiTqMvfan3yD33TmKyNUD8wHU0ENcbWqBcZlTZJyNnPWiyOhlJMAf/Yp2I0760IZKwAvI5kTMh7v9YlWOT2/wRgvCQaeV6AiTAxrp7JKW75p2+bneV/b9L9cfp0+YeQbQJSUARMcvKXm1wVGOJErX/93Fvokt4xTwWQnrP89EdvTwpjE5yu9idkPtpm07mPR0cIWlaVu/evRR14IhndgSHbpsyKcK14Igb1LGfl57Z93v3l0/rxFgE+xSgVEhzhSpePUTDpnqLp3v2mSJEzLU13iwMm8+kovAcsJS4m9XfkoNjASk+APHi0n9phj0zb/E2Npnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjqiR0gIFLaII9gN8fr2gON0dV7fweMd/I7MI9r0e20=;
 b=N8EvG1r2sMyugsD1E/RV9a+ayQMa5mL4bUHpBCBGp74IAm4s5M9bYRIo0aNaHNOi+51VKBmtPW8GSIA/JsZ8rh85kVlcJKALTb+anIkWy1ogKsmPEYtjDTC539EQkbanMYBm0Ww/xClWssRymTmkRsvSw4fGlYLIDyIpDNWbQnQ=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 13 Aug
 2020 21:10:41 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 21:10:41 +0000
Subject: RE: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
 EPYC
To: Igor Mammedov <imammedo@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
 <20200807165222.GB120942@redhat.com> <20200807211148.77749e6c@redhat.com>
 <9793a0d9-3152-6e40-4a1b-cb1aff7cfe38@amd.com>
 <20200813155610.02b1c5cc@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <baeab075-a900-f0d1-4ed6-40b7a8a2988a@amd.com>
Date: Thu, 13 Aug 2020 16:10:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200813155610.02b1c5cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:10:40 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7a3427a-c0ea-4002-af6c-08d83fcd5584
X-MS-TrafficTypeDiagnostic: SA0PR12MB4479:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4479EBA1B9560F39311FF5C895430@SA0PR12MB4479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jTMQ5IiKuSPU4+OKKiXziSmqENuu9/FbciP3BKMTt0Wi1gbc09BmwfCRP1gU0toikZmRmZH+sVpUgX4NxpRot2SUE7X1VZRm9uzKiPef6Dq6hcoHX8JQjKJSqKSxPBHW3Em3kpxubHG4rl5zO5OEafHyOZvu493B7TjRCVK+l9BMZBDSp5m2pNWqvsMIH24FKcCiEYCTQMHihN50zjcsKoSym29WTk6Cl/pzC3mn49+j5Dba1VqO/J3PPetTMiHrDK4babC4ZJ5QD2PIuv7IV149OJLj3UJ0IBeb6ehkcnn9dlglv9LNklQs6K5YCwtdvUJNW1zJ/2RWMeC2yKM6DilRLsOSR4Z5izZxH02fQUBDILK5ntDzY0aCteZxLH1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(54906003)(52116002)(66946007)(4326008)(31696002)(53546011)(186003)(16526019)(16576012)(83380400001)(66556008)(316002)(86362001)(2906002)(26005)(31686004)(6916009)(956004)(2616005)(8936002)(6486002)(478600001)(44832011)(66476007)(8676002)(36756003)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: THU8i9BwwtATOLMhQCgnI2xcMuCXJZPWcBJlX0DoH2pH88TMZ5VcSPeCOqUtbcVNy2J4J0V11Stju7l8kbQk6c83c/1CjrzQJbp/DKITC8Mr7K6eFM+qDFi4rhdz5fhbfJecB7Xr+7OvweB65Qg02Mf54xaVt90bDxfMTF9Z23sYq3cJGj/W0uDoPE7Idhs6SOAb1TL4kn/QmsYqtDYND4ubW1FrmaaujshOeV9ygZHGvFG4mm69YTPZkCtS8lXeYhaZtn1D6aEg3k0TlHQAiSDx3YOYkdCgm5Q5EuFvt3L2F1yTzY1s4sJr1czdxZBWT1F5xdOi7Zb5U9N7bLwbGSqytQ9A5qLl6DAM1S+cwFHU98L6K34Lc1BkZDFNEPmfN8MKYce79b+1hCtEr117brjHVZbwMpkUdz0mDRyAzMENuZy3wro2J3uCUYHRbj7IPWN7zlcOzxBFT8UfVMDXmxSlGAO8J90X8/fek72elKjCeIr+qCOEqUdCQIaUj/Q1m5kOiq5L/YEPVPqVRrpCEZ6xm4YyNneAWhvdbxF72rutHlf9VOnyXfU5EGMtRzBRuqPiOHJJKamDTzBIcNTLYe+gblXONLDMZYFoaa2Rq/gaQjuEvbEuJ2oBic7G/JsskvEW168ODAKyYkSXX/cEvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a3427a-c0ea-4002-af6c-08d83fcd5584
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:10:41.1058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrn7jWc/0A404HtPLmqUXAOV71sb0WIWUrTJ/rEgUn1BXiZs1yQiiMucHQNpMe50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
Received-SPF: none client-ip=40.107.237.70; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:25:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Thursday, August 13, 2020 8:56 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>; ehabkost@redhat.com;
> mst@redhat.com; qemu-devel@nongnu.org; pbonzini@redhat.com;
> rth@twiddle.net
> Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
> EPYC
> 
> On Tue, 11 Aug 2020 16:03:58 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > On 8/7/20 2:11 PM, Igor Mammedov wrote:
> > > On Fri, 7 Aug 2020 17:52:22 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > >> On Fri, Aug 07, 2020 at 11:32:51AM -0500, Babu Moger wrote:
> > >>> Adding a new check to warn the users to configure 'dies' when
> > >>> topology is numa configured. It makes it easy to build the
> > >>> topology for EPYC models.
> > >>
> > >> This says you're adding a warning....
> > >>
> > >>>
> > >>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> > >>> ---
> > >>>  hw/i386/x86.c |    7 +++++++
> > >>>  1 file changed, 7 insertions(+)
> > >>>
> > >>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c index
> > >>> 67bee1bcb8..2a6ce56ef1 100644
> > >>> --- a/hw/i386/x86.c
> > >>> +++ b/hw/i386/x86.c
> > >>> @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms,
> > >>> int default_cpu_version)
> > >>>
> > >>>      /* Check for apicid encoding */
> > >>>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> > >>> +        if ((ms->numa_state->num_nodes > 0) &&
> > >>> +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms-
> >smp_dies)) {
> > >>> +            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
> > >>> +                       "parameter. Configure the cpu topology properly with "
> > >>> +                       "max_cpus = sockets * dies * cores * threads");
> > >>
> > >> ...but you're actually making this a fatal error, not a warning.
> > >>
> > >> I'm not sure this is really OK. Wouldn't this mean that existing
> > >> VMs deployed today, risk triggering this fatal error next time they
> > >> are booted, or live migrated.  If it is possible someone is using
> > >> such a config today, I don't think we can break it.
> > >
> > > to begin with, users shouldn't have used 'dies' with initial impl. at all.
> > > (it was Intel introduced option and EPYC's added very similar
> > > internal node_id (removed by the next patch)).
> > > Now we are trying to consolidate this mess and reuse dies for EPYC.
> > >
> > > EPYC was out in the since with 5.0 (though broken), users could
> > > start a VM with such config but that would not be correct EPYC from apicid
> and cpuid point of view.
> > > Guest OS might run if it doesn't know about EPYCs or behave wierdly
> > > (sub optimal|crash|whatever) on seeing unexpected values.
> > >
> > > If we are hell bound on keeping bugs of initial impl, then we should
> > > keep it to 5.1<= machine version and do the right thing for newer ones.
> > > Though I'm not sure we should keep broken variant around (all we
> > > would get from it is bug reports*/complains from users with end result of
> their config anyways).
> > > I'd rather error out with clear error message so user could fix their broken
> config.
> > >
> > > *) there is at least one thread/bz on qemu-devel where users are
> > > trying to run with EPYC and pick up options combination so it would produce
> sensible topology.
> >
> >
> > I am still not sure what is the right approach here.  I can think of
> > couple of options.
> > 1. If smp_dies != num_nodes then go ahead create the configuration
> > with as  many smp_dies and warn(but not error out) users about the mis-
> configuration.
> warning is a bad idea, that usually leads to troubles down the road.
> 
> Provided that code is relatively new and produces misconfigured CPUs and if
> nobody insists on keeping bug around, I'd try to go for erroring out.
> Yes that would break misconfigured configs but that could be fixed by
> reconfiguring on user side.

Ok. I will refresh the patches if there are no other comments. thanks

> 
> > 2. Introduce it as a fix based on  machine version(5.1 >) like Igor
> > mentioned. I am not sure how to achieve that. I can look into that.
> That's a headache for maintaing point of view, so again if nobody insist I'd
> rather avoid it.
> 
> >
> > Thanks
> > Babu
> >
> > >
> > >
> > >> Regards,
> > >> Daniel
> > >
> >


