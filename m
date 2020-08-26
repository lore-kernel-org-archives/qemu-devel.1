Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D0E2078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e7/QUYFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D0E2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0SS-0003nt-4w
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kB0Qo-0001xn-Vr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:45:59 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com
 ([40.107.223.49]:15616 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kB0Qm-0001b3-Fl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:45:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RshdRHrD6rF2LEUlFyBm3SyxNTYOf38G5euliv95EI+dmcsbYhtcOPW4z4CGxXuiDFnQQf1hX5rY2mv41BE1mTO2o1EM2dsOjdYfsxwO/vOM7z5ayHh6D14KzleXxqhoOORgs9jLQSiaQhEYo1IKcnQvjBExAtPYrv7ZncQupcKYhT5Ye2QXnW58P6mA7n3mC8mx+yy0anzeuFGpq/4MTn1Y/iuNtNC0+lkTzokq7jxGkywH7odyfWD7lBAlaaKYCTZyKJt6B/hiZw8MC1SBA3N+Zu737OmZA1xo31qkipdEdaEwPuJ1UWJ28hGG0ImsvjffRVpbekngBRouHxabTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1w45MBTHrOPa9Dg+Jg3OGqsRiXux7w+ItW48d6V96g=;
 b=krKXaZsZxPU6H0Lgf8/K3NXV9LY9kpI72KZozSZrPveK2MrKo/C/jeqGLW4VvgS5BCFMxPcx/ZqAL4QeMNmGr/11ZuXAjuNP5Vm2iwRaI0Ko1jJgtqAYdD/ahCaJ7M+/huyu8fWZY9aWjJ+954Tw8oOG9WAjY24RxaV/X/ONqBVXdmiV5+izRwck9nCs2dT8iYFOYgN97EmKNtWAAHstytVp2+dWQnzn9agwpPcfWpKRKe8WLeSu8tA6Xi2HlHawZGu1WXbP/of1eLusRvoDAKxagCLPni8Fi9zMisd/xE4Dtyl8OODjODpW13dYMNdq7zsCDqAnLdQnB5tQQ1c/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1w45MBTHrOPa9Dg+Jg3OGqsRiXux7w+ItW48d6V96g=;
 b=e7/QUYFqFcrGXdaBt8li8H++gxCdhvqwCFSvJBI5S2lUd/7nWxjVhH3V/XKKLFeC1d2Tt0iB38BxeoEpR69z6zztTqAvcVG7mGhV0pg+DMHC2VouBn4I03Ai8WWnHfoUTs9YTI8Rgr/DiqGOZzi36jHKUddseW/2PLVOwFXyCK4=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 18:45:53 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 18:45:53 +0000
Subject: RE: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com> <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
 <20200826183331.GA3977@work-vm>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com>
Date: Wed, 26 Aug 2020 13:45:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200826183331.GA3977@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:5:134::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:5:134::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Wed, 26 Aug 2020 18:45:52 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bb8bf8a-3237-4b0d-f6bf-08d849f042c7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2621BDA5EAE48897CA631EAD95540@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qegmCyEcJYL8/gVing9aJ2b76ZLSaUE43t/ur+SaTovuM1LL1JTIA7w8uoYxcWfY1Y8CupsZUTHG1dyrASBfLIC1iG7mmLwvQz4VZMOE0HV8EpsHpv4uX2CZmwCjN4wuV20VNdPax8BhvcQCz1aEh+z/eQupY4tBuTIBGg3MtbfP1IW9RIGVkWM4uhZbddG+Csw+FCKf4F84wSjPq39GWE7V+pYxDjtxQuuJuocM04q4EwVWgR1i2+TXciNtqK29Yra4A7V/VHHdVEML1ZvZbeiXYL+HzaI0NJQ90FpEXOnCi+VXvma10m9YbDYkhSFYAOMikuowqKEQB9SO0ncFOyKyb6oUyxkEnx63MaJkXchKqSUi+sMhkhe1484DgZCXF04TV+/uIfmcUr3eRcrvZaeHdgxVXSYjT5/oVknl5ODrSi30PFOhf7WrK9JG6U2XuGwOBCG+T89EWHj3Mh2wqQFzoLEGDzX+K0z5PntBNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(26005)(45080400002)(31696002)(86362001)(66946007)(66476007)(6916009)(8676002)(54906003)(2906002)(66556008)(966005)(5660300002)(316002)(16576012)(31686004)(36756003)(83380400001)(53546011)(478600001)(8936002)(44832011)(52116002)(186003)(6486002)(4326008)(2616005)(956004)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jm2W8AKGBulPTQksw42IFL6M2AViqSlvSlkejtXY0h5dfJxyAyUIAVwcoVVilvWOSCcSQwII4zkWc5eLDfbCoROLJG6pD5JskjW0nh7cmJyDsjtF//psA9snk2gU84f+rk/19WAv/UCgPmHCBJIWiOAH/OqJU/hYKpm7qgHAwIXixPG6mo7MKUb/52w9ardtdfnR6zCN7hSNTH6UqKbST5R+cp5kmkFx7ypfbZbFIAXxIt+guhsp51M33PM8YJX+OUObJoE7DpTMVwYF9fz4XJb4HClIBGLCA25difDjgd8TkypnX9YYBK00Dp5EP3LbX/Zs5PT7dhL657RlrNdCbkpMr8oHEYSN9tt56nModfeyW8RMm8z2TlpAk4gmTXG37oMtAujuzbf7DSmptjG0tXq2XptKHZ9aDq+RN5eoOHXHVNPuRs+PoyHKo4Fpv3HbG841LPKw0FBWXetXnY9wpAlmQIGxasg9HcA6+NKv4WJyNCkdVGE5Py+7XqtpdhOIY+OFhejsSsOgw3R//vqO4wwQqo7wu8QbJ+dzHgUthicUMLCHUiv589wlZGwlB4UDIW0g4bYSNQZAneUu7sKGxToixYUOOvndmElwpANo4IJmdAoNsLCuBvcBgcIhg2UYEua2FgWQ7GiF+7qTIe/1qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb8bf8a-3237-4b0d-f6bf-08d849f042c7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:45:53.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cx+9dnl53ggFEAwL6HH5fRF/cizVMrqGDGA3PV5PUi/O0CZDhH9+Pp04v4Q84iBW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
Received-SPF: none client-ip=40.107.223.49; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:45:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-2.239, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Wednesday, August 26, 2020 1:34 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: Igor Mammedov <imammedo@redhat.com>; Daniel P. Berrang�
> <berrange@redhat.com>; ehabkost@redhat.com; mst@redhat.com; Michal
> Privoznik <mprivozn@redhat.com>; qemu-devel@nongnu.org;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
> decode
> 
> * Babu Moger (babu.moger@amd.com) wrote:
> >
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Wednesday, August 26, 2020 8:31 AM
> > > To: Daniel P. Berrangé <berrange@redhat.com>
> > > Cc: Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > > rth@twiddle.net; ehabkost@redhat.com; qemu-devel@nongnu.org;
> > > mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> > > generic decode
> > >
> > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:
> > > > > On Fri, 21 Aug 2020 17:12:19 -0500 Babu Moger
> > > > > <babu.moger@amd.com> wrote:
> > > > >
> > > > > > To support some of the complex topology, we introduced EPYC
> > > > > > mode
> > > apicid decode.
> > > > > > But, EPYC mode decode is running into problems. Also it can
> > > > > > become quite a maintenance problem in the future. So, it was
> > > > > > decided to remove that code and use the generic decode which
> > > > > > works for majority of the topology. Most of the SPECed
> > > > > > configuration would work just fine. With some non-SPECed user
> > > > > > inputs, it will create some sub-
> > > optimal configuration.
> > > > > > Here is the discussion thread.
> > > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2
> > > > > > F%2F
> > > > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-
> > > d5b437c1b25
> > > > > >
> > >
> 4%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C8a5c
> > > 52f92
> > > > > >
> > >
> 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > > C0
> > > > > >
> > >
> %7C637340454473508873&amp;sdata=VnW28H1v4XwK3GaNGFxu%2BhwiMeA
> > > YO%2B
> > > > > > 3WAzo3DeY5Ha8%3D&amp;reserved=0
> > > > > >
> > > > > > This series removes all the EPYC mode specific apicid changes
> > > > > > and use the generic apicid decode.
> > > > >
> > > > > the main difference between EPYC and all other CPUs is that it
> > > > > requires numa configuration (it's not optional) so we need an
> > > > > extra
> > No, That is not true. Because of that assumption we made all these
> > apicid changes. And here we are now.
> >
> > AMD supports varies mixed configurations. In case of EPYC-Rome, we
> > have NPS1, NPS2 and NPS4(Numa Nodes per socket). In case of NPS1,
> > basically we have all the cores in a socket under one numa node. This
> > is non-numa configuration.
> > Looking at the various configurations and also discussing internally,
> > it is not advisable to have (epyc && !numa) check.
> 
> Indeed on real hardware, I don't think we always see NUMA; my single socket,
> 16 core/32 thread 7302P Dell box, shows the kernel printing 'No NUMA
> configuration found...Faking a node.'
> 
> So if real hardware hasn't got a NUMA node, what's the real problem?

I don't see any problem once we revert all these changes(patch 1-7).
We don't need if (epyc && !numa) error check or auto_enable_numa=true
unconditionally.

> 
> Dave
> 
> > > > > patch on top of this series to enfoce that, i.e:
> > > > >
> > > > >  if (epyc && !numa)
> > > > >     error("EPYC cpu requires numa to be configured")
> > > >
> > > > Please no. This will break 90% of current usage of the EPYC CPU in
> > > > real world QEMU deployments. That is way too user hostile to
> > > > introduce as a requirement.
> > > >
> > > > Why do we need to force this ?  People have been successfuly using
> > > > EPYC CPUs without NUMA in QEMU for years now.
> > > >
> > > > It might not match behaviour of bare metal silicon, but that
> > > > hasn't obviously caused the world to come crashing down.
> > > So far it produces warning in linux kernel (RHBZ1728166), (resulting
> > > performance might be suboptimal), but I haven't seen anyone reporting
> crashes yet.
> > >
> > >
> > > What other options do we have?
> > > Perhaps we can turn on strict check for new machine types only, so
> > > old configs can keep broken topology (CPUID), while new ones would
> > > require -numa and produce correct topology.
> > >
> > >
> > > >
> > > > Regards,
> > > > Daniel
> >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


