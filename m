Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77268C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B053205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CIoK/SUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B053205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bV6-0001sk-B7
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k5bSQ-0005Fp-BB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:05:18 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com
 ([40.107.236.75]:54176 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k5bSM-0001kd-IR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcOI+s7eODwLBUDM7xlKW1pN1nZU9+U55Wg6wOwPzAEHYBHicm4IgmlC6PkDoj7tMvLp01HtmbX3jC/GVBtdhGh4Jmw8fPzblWsXMpJItDygAQXhljgPKp59AvuohmpDcVQmwykXh2C0Z0ThNsaTwGOBr8XUtgG2ibRkXvnRI5PaqhapttkljkxUlvt0ULjVJlpvzca9MxaqBlvlcSqkpqILXgnTugzRJ4Nc9qWoCsMuG3mk9XwfMAOpLAzV9l8oHwd3/qNUF8Sg5IFcztm9Cg8zFbaezFCmMb1Nwd2tHE3/kYgUsjiKnHJfpYhI3O+x57iup028ivZIUESxJ4vECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7egGLk8QsqJ8PHc5lFfIiF4fPb7X4JGU5UZfmQDX4E=;
 b=ELqKyvcYt6yvpzO0lnPXTTmu1zxspD6pmxya2OCzz6rShFHADeoXxyqIJ5wb6IMwH1BcZdog9NGDuL28l+c06Bv41en5VIue7OZde8xCmiadXHIUyVGJKDnh9kBWcLbKddi8NGR49PkexvkGDl0nqT0f+YI9np54wR+UNnSi+TaX2cTj/4Kbz838P74lgWe/0W4pMOVKQ9xJ0vQXQmTAJJ3/rx8ppILtQlKRnXx1po7BM3A8F/8FO/gS3p/8RANLsiLBFsjItMshlSYU5ho59/g6PgNINF1PWmcFAEZOg8ok7OIA1fgGtJjcI/1J8JNOwbLiHCtor+B1fNPHXGj59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7egGLk8QsqJ8PHc5lFfIiF4fPb7X4JGU5UZfmQDX4E=;
 b=CIoK/SUkiRqtTYd30IN1oAuaEiQYJAWP4cLb4sJsO4S4yEeg7Bh32WOcPVi8CvaVZd+gxenCIjA40E7kuWi84W3t1T8UK0JFeHRKmQ10fBkprQbdcsSCq7mSLoH1xcm7LPQPUsBHljghGFdx4OUEqZmfsUbL14uybziJv7+DO1E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 21:04:42 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 21:04:42 +0000
Subject: RE: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
 EPYC
To: Igor Mammedov <imammedo@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
 <20200807212729.1cb2ede0@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <b76346d3-de65-9689-36e5-5d071beba78b@amd.com>
Date: Tue, 11 Aug 2020 16:04:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807212729.1cb2ede0@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:5:74::18) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Tue, 11 Aug 2020 21:04:36 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 312fae74-ea0b-4f80-39b7-08d83e3a27bb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-Microsoft-Antispam-PRVS: <SA0PR12MB441421FD2C1EBCE81AFE324B95450@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYXRR2LfuHAYg5lb01nJclTYRZjXyeYL+FwFr1OQLlXn0fjhypwGHUmTv/kmeJTNVL9hkf39PVrqa2uluI5Z7T0zNdZsaMsp3aZ1T/yzJyNMsUDJrUiWr6az0FrUjPYEhjcpuT8Sf9oyGNiUA4efDEMGEeUzjdX2glzbMHoxqZbstlPQNjqo23CGgw9hScjkTTd8kRVyIYHwMzi7I6mHZCxhFhcsUHKuouJxezIYewu2sZHc59pseRRfXXrDSadDij8IbND/m/AzA82pLTBmphdj6g6m916UajJ1gLr7g0VFf/jRkm+62b1H4cg9gdU2ufdotlAoHD7G5+B8JFzx72VkJtEaq/OvR/Q7rIjdDL/acVPcWsjg7sj7DHewcNCz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(31686004)(36756003)(66556008)(66946007)(6916009)(186003)(66476007)(44832011)(956004)(2616005)(6486002)(5660300002)(83380400001)(26005)(16526019)(316002)(16576012)(31696002)(54906003)(8936002)(2906002)(52116002)(86362001)(53546011)(478600001)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GnZu66vA8RL8r1rheTBMeUHeYaOFCeoo90yidnO6/k6o7SIL4kFpuelyejjyeV3DgLjRJJJZ+9wCdwgkEU9VxeePw9NKqom+c3ORBHLMQ6IPlpkrVtSKTYJDnGcrXLrDRg2YOdjdrgRX/Yu+w2OyN8dN15+GuTaNbgeCd2KMpxZOPMCq7oPhNUKqoHIHojTnRbucIkaqOvEYHWYfKgb7CF+Ge1J+6Wgkzhxjg+UT72HeaEfri1QSciuEXMbAn/cSEDLjwnzQNrUX97kzUGAzFXvJygLVDMBOBDpXX/g0d+aiuR3K/tRidZYdwjLSekZ8zg6pwamOrJJxOXO4tNgWr3oT872WW1sceW3xmcArW9Qh6W+EZ2aQ5V5IEK2MWkqbt2B117t2hJnlN/yTN8htORI5glzWosDQsq9E8S/bEEuRjA6y6fUNWebP+DY0R3zmptE+Ej7cvuYs0BF2JJLCS3CO6ynvKGc/pOedd4M75LVJoZdW1+5jozijK5Jv5PliPu6ibZeGPFsp2EoXkftG5IR0MoxHNw9uRd78Ow+UMegBdCbJpiW1PNA6uET4Y9XMpsJkrCefBaqe+536Kg2g01pdHN59uW0Pa4i6bVfudCnV3uVnm+K5hEybnfDI/vIHmdgN26R4RzZxTb6h5QieuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312fae74-ea0b-4f80-39b7-08d83e3a27bb
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 21:04:42.5179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXZRksyk5xapX0yPcbhkmZCuggJRyNYKY4xW8wsMAqjRVFsoLhhwT/uVt6+ShNlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Received-SPF: none client-ip=40.107.236.75; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 17:05:13
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, August 7, 2020 2:27 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org; mst@redhat.com
> Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
> EPYC
> 
> On Fri, 07 Aug 2020 11:32:51 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > Adding a new check to warn the users to configure 'dies' when
> s/warn .../error out .../
> 
> > topology is numa configured. It makes it easy to build the topology
> > for EPYC models.
> 
> probably it should mention that will break configs that do not have correct
> topology configured.

Sure. Will do that.

> 
> 
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/x86.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c index
> > 67bee1bcb8..2a6ce56ef1 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int
> > default_cpu_version)
> >
> >      /* Check for apicid encoding */
> >      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> > +        if ((ms->numa_state->num_nodes > 0) &&
> > +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms-
> >smp_dies)) {
> > +            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
> > +                       "parameter. Configure the cpu topology properly with "
> > +                       "max_cpus = sockets * dies * cores * threads");
> > +            return;
> > +        }
> >          x86_set_epyc_topo_handlers(ms);
> >      }
> 
> we also should error out in case
>     ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies and
> ask user to configure numa to match total number of used dies.
> 

I have already added the same check above. Do you want anything more?


