Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A20C207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JVZNkNhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20C207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqWe-000670-Ha
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgqVw-00059K-8C
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:06:36 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com
 ([40.107.94.54]:17259 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgqVu-0004PB-NJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU6ZKindQdzybwN2IpY27RP0CoODdQk5f716Dt7xE7yJoGbh2QLbW3rYY0nitFY4wej8hN2sDZm7q4joyuFeAZq3p9nGSpr1MiWlH2jwXqDF8Nj3V6lScvlzseJfaU4ZXx8XM27NeYq+WzxgsTfdy805mhCvdPzmrcHHOygajeh4UYs6H/NggX2PpEN5BPbReZwu3xQcnHWJ0dItH0zfEXG84SJF1Dp/jtZwFZxF6HtDkSEBEFnSEammohyUbJ3IWVNPast1XA4KmquTLMr6uS8SlZYtaybCWp9BadgpHHwyv353qNcr1HyDObDYOb4Iop31adgylUp/V7somuQM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSQBy4TLgJqLp8WgUlCWZeNv3FsNxIHx9Ewi7NkIt/A=;
 b=TFnBo4Qvcs6ImuzOzo1FCPicOABoAp4+qtVRg1XAFJkcX/OcMKY6ZS4frgMV2Ge+5PGo/nM0KoVZ4PFmm9aVlEsqDjgT590q8VUnIR41u0tLR49TMYZnJatQwJR7XEZ3tFlWscM3rMLvfb/1qwPiiTfYApQQMjFnIo/+IoFUSxgZjBBAOepWVH9h6GBrWBJyBXtYLH1Lr5LwX+NXEQzs3Cj9q8308f4z2Xm3ESpx9oyC6fYX7Vj2C3XDCsPCcVprxOPOhfHE802X1y+Mjmf1VkL4BdCav0A64ZmG2Fv25eUR8vQjBEqGYEgDDcRZPqc+8VpJ+0s0m7s9jj1wyZQJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSQBy4TLgJqLp8WgUlCWZeNv3FsNxIHx9Ewi7NkIt/A=;
 b=JVZNkNhYr1vvwo000Yq3VaGcylNKwsrkDLD21+YKA3EyZPIiVeNRaVz5Zl51B2Jc+ABy8bTVp1Z49hPkhlS0KBojyS344mc9F2h5X5n35aDVIGv7dJohu7MxLhbs0Hw4XgGve4nFM+5HHiFpIZNbmE/sDkmx+QOPsR/saG/ya5k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 14:06:30 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 14:06:30 +0000
Subject: RE: [PATCH v13 1/5] i386: Add support for CPUID_8000_001E for AMD
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
 <1528498581-131037-2-git-send-email-babu.moger@amd.com>
 <20200602175212.GH577771@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <b6e22360-5fa0-9ade-624d-9de1f76b360b@amd.com>
Date: Thu, 4 Jun 2020 09:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602175212.GH577771@habkost.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:5:40::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 14:06:29 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50d40944-cefd-4b8b-943d-08d808907adc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24152C4571D35B8026B1BACD95890@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/vyKHzbiA3auMil/zvCF8A+QzawA/h00yOFpXoUMf5k2bOMrCh1EcjHIPzwVpGu4724e79XinLFn/j8iQY8QtW0CfEbbBWFKuFZuypxIZjLBM805vkQmpn3WadlIuneyQ7Xr7XSbRPkSzaFx4jJyAr1Y8vPV/nqF78/juYeQUystK7YcMt35gzAOvcDSgpXBmHLbu/94rKL6Ayp+kDsPEG88I+ECjutWWM0MntZieQDgx1Kahdf+y0ruFEIwJyM0CrHSe/uB0jnElfjQM/2zBkyQbWFgkzey1Wzv55d8/UlN4QJUuGA2Cs+OzA988r1n8zhAjhloq6V9A5ktBZXg8g//eFH9N6E+Bw+xvDC3q4vkFGJsNQoDGzmQvl1gomr6vrpfJIX55Xg7LF28/dmFeShtHjAinZGvPtawAeh7GiJQaHLs3RZ7LMH7vDayoAg57q7N4jj0mgPijbRsjttTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(16526019)(44832011)(2616005)(186003)(316002)(7416002)(956004)(86362001)(478600001)(83380400001)(16576012)(54906003)(45080400002)(53546011)(52116002)(26005)(83080400001)(5660300002)(8676002)(6916009)(6486002)(8936002)(966005)(66946007)(4326008)(36756003)(31686004)(2906002)(66556008)(66476007)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8NeOchgu8QNviIVL1e6vy/a4IlJIkVdVt32ELT+yKQnLl/GEOnV/pSfYGyS67Ilt+DI5uNqruCW2y2103QN/7qZ7Xltd11ZeDo1IuY97qSW1BRQs0eno/KbjEq75gy2qR4BAKvPd6T3Z1/c464l8zJJJ8idU5RasgHHn1Ty0kGYk0srq+BWid82z0FCMKVFgrsqC7IJhjON8e/DERs0Y6792IEEEulpkuFkLFi1whhJyBT+BcYhLOBzRCM7rkNMf9usoohRB7+0ZbYmtFnaABdoyaRXqPCsYK/fwnTkeBiVIzcwSwbzoZFVhGqKo8PG2+qCnStjmq7tqIwYPs1sSd24RhU/gAruiwTUg32XVA4oziNwN9CSxjCk7QD4FZEaRthNFpyGeKTY3mdJa6qghs9k02EPzeugdl075Ndvth25fO2803MBYPOFSXM69Ld0RLkUIWbJzOPKgy8cuuUW1IoGsTuPi3JRxy7dkGTA7pi4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d40944-cefd-4b8b-943d-08d808907adc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 14:06:30.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/KbzSYIvdakFbvHAt9HqDImqyur0tU8vqoEjnjMy4vmnpuJw19k6vuisQ0cOB5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
Received-SPF: none client-ip=40.107.94.54; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 10:06:32
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
Cc: "geoff@hostfission.com" <geoff@hostfission.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "kash@tripleback.net" <kash@tripleback.net>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Tuesday, June 2, 2020 12:52 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Dr. David
> Alan Gilbert <dgilbert@redhat.com>
> Subject: Re: [PATCH v13 1/5] i386: Add support for CPUID_8000_001E for AMD
> 
> On Fri, Jun 08, 2018 at 06:56:17PM -0400, Babu Moger wrote:
> > Add support for cpuid leaf CPUID_8000_001E. Build the config that closely
> > match the underlying hardware. Please refer to the Processor Programming
> > Reference (PPR) for AMD Family 17h Model for more details.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> [...]
> > +    case 0x8000001E:
> > +        assert(cpu->core_id <= 255);
> 
> It is possible to trigger this assert using:
> 
> $ qemu-system-x86_64 -machine q35,accel=kvm,kernel-irqchip=split -device
> intel-iommu,intremap=on,eim=on -smp
> 1,maxcpus=258,cores=258,threads=1,sockets=1 -cpu
> qemu64,xlevel=0x8000001e -device qemu64-x86_64-cpu,apic-id=257
> qemu-system-x86_64: warning: Number of hotpluggable cpus requested (258)
> exceeds the recommended cpus supported by KVM (240)
> qemu-system-x86_64:
> /home/ehabkost/rh/proj/virt/qemu/target/i386/cpu.c:5888: cpu_x86_cpuid:
> Assertion `cpu->core_id <= 255' failed.
> Aborted (core dumped)
> 
> See bug report and discussion at
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
> redhat.com%2Fshow_bug.cgi%3Fid%3D1834200&amp;data=02%7C01%7Cbabu.
> moger%40amd.com%7C8a2724729b914bc9b53d08d8071db392%7C3dd8961fe4
> 884e608e11a82d994e183d%7C0%7C0%7C637267171438806408&amp;sdata=ib
> iGlF%2FF%2FVtYQLf7fe988kxFsLhj4GrRiTOq4LUuOT8%3D&amp;reserved=0
> 
> Also, it looks like encode_topo_cpuid8000001e() assumes core_id
> has only 3 bits, so the existing assert() is not even sufficient.
> We need to decide what to do if the user requests nr_cores > 8.
> 
> Probably omitting CPUID[0x8000001E] if the VCPU topology is
> incompatible with encode_topo_cpuid8000001e() (and printing a
> warning) is the safest thing to do right now.

Eduardo,  We need to generalize the encode_topo_cpuid8000001e decoding.
We will have to remove 3 bit limitation there. It will not scale with
latest configurations. I will take a look that.

For now, best option I think is to(like you mentioned in bug 1834200),
declaring nr_cores > 256 as never supported (or deprecated); and throw
warning.

What do you think?
> 
> 
> 
> > +        encode_topo_cpuid8000001e(cs, cpu,
> > +                                  eax, ebx, ecx, edx);
> > +        break;
> >      case 0xC0000000:
> >          *eax = env->cpuid_xlevel2;
> >          *ebx = 0;
> > --
> > 1.8.3.1
> >
> 
> --
> Eduardo


