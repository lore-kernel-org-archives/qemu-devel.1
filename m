Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09532C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64A42051A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eGv+nORA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A42051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MvR-0007Ox-3L
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Mul-0006wr-Ks
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Muk-0002hC-9W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:13:27 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com
 ([40.107.220.73]:60864 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6Muj-0002fd-T3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:13:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9MEh7qPxOZHEouAktxVLDaHJttpz+8cF+9npR0I3YJ4gcZwA2FwlfWPiE62ATqSaqfA0wT4QdzwIFVAF6x1YAegOzhwBb4cBiEdA/guVTwG5ZuG/2xAy/dir4T0r2jpR9I2GdXXtLmj5+mJ5qLri0D2eP5Mtai+DWkO2s5kql7KDslge1On+g1Qx3b5RYYWz5HEWNs6mGgqVkGRrnsjkotGOQ9fuGrF2VPk1r2EqO+jWNg4LS/Jx8vKJrFTp72BU38VhDcSHMnAOhutKaCYuLzO/Q4BSzj87vk2yk5BWyvfrDqtU1K0CtHJ7ck8PfsNnscSv9e1q9QXIG2sKj1ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2rZTbTizWRyAcMOg2mHuMOrHc6Vq6zLjURL7CnbNeE=;
 b=d7YU5XO0XV/TyirLERfS9UyC8/KLHBxjflnYUmOkehGp0lWzRWbeQeHOXtVk+xMoKBDwOfhSfwp/fscFr0qAT9xlEj49etymb+ZOAc3sI24KysxdkzM2hb5tNy0ihKmO6wd1M45f//lU/tAQ65DbzXo36oNX2CemZd0R/KsV6DqEfqBjcKOHVEQhccqiGJvNwmhReNI38UUv4Q3t5YjH9Mx4t5EyHtc3nFLUPUF6jWtxDIezdslZ66GJVHxm61kuLqsW0XEtXMJgzK7bCPlvp5wxQuINvjAzr3/8/7rt5CvKjWhytwpUtIkNrjuoY2VuAikafsbegN/C8q27Grb1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2rZTbTizWRyAcMOg2mHuMOrHc6Vq6zLjURL7CnbNeE=;
 b=eGv+nORAieXDLJhvDyb1kdkfN2dtqDajcfNYipwzFXUp+5XkhciB6KJuANeCbQDikQskfYKNCverJlcdQ2mK9Xj+wO7ooYbVgCny4kC6weKOgbvbFfevN6JX+2HOe2WGvsU6YFTk8VOpaMwAizKRzxvHIevJuI2vwPCCw4IoCxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 23:13:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 23:13:20 +0000
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
 <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
 <20200224223149.GF4440@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <5931c329-79ea-1f9c-5df7-db06d930a0e4@amd.com>
Date: Mon, 24 Feb 2020 17:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224223149.GF4440@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0029.namprd04.prod.outlook.com
 (2603:10b6:803:2a::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0401CA0029.namprd04.prod.outlook.com (2603:10b6:803:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 23:13:19 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 086c3a61-6427-4d6a-291a-08d7b97f233d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:
X-Microsoft-Antispam-PRVS: <SN1PR12MB259188669937DDB8562FD78095EC0@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(2906002)(52116002)(478600001)(45080400002)(31696002)(86362001)(5660300002)(44832011)(81156014)(4326008)(2616005)(66556008)(66946007)(956004)(66476007)(36756003)(6916009)(81166006)(8936002)(8676002)(53546011)(316002)(966005)(16526019)(186003)(26005)(6486002)(16576012)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2591;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM2n1jvKGkU/Ud0t8AUqqYKbaWnRCsI6eXD2PQa12t4z4gjyYWoaoCivkaWw4991yoHoua2w9AF3xXtdgYcqIRaL52SbnzkvcYYcUQeEQz6C7XRHMyZZYwVWLefig/PiVx40lWiJ+Y5lmRnClcpZlEAKqdqVDeJQe3x3Iqmp9R7OktBB5Acx/wqMvY/xynZiPsUt9n6qXKdO/PEC8vw6ej5VFItvX6RJpMs3tAHxKmHpt+G1i1Zzz/vM97iTgr41oR/BCCy3XKP1dBKzzlILAGtcsAw0rvVWTZOP7jBMFUClfKYz1r34+08vIehe70Lyr0NcZeZS0zw73JStaN5jjXQchl0ZeIbd90OU0VlynJVQPg2ypX72hbCbUHgbskTKYKUF8M2JWnreRhLzhqkz7wrDOHQEyBdGOsGVFKnIbUr8HZeqMBJrEnWLqlRaVc1XSBlnUQKu2fBbacIBeYT4Y10ZthYFOMPADnIOjyP9PgbdSZ3NaqEgiL1X04LDlWCuEACqSTGaCu4PtZV9MJIXLw==
X-MS-Exchange-AntiSpam-MessageData: wYRU1mYyqobji4EZXqVf5BhGIOGLV6bqvpx9ujvQ5du448VVf00BJdxUVhHvmhZyFw15ko1UG93OldFVunQveSkypYfDc4JSyQb6E0mvhZIBQapPZbH6C0LfdI9cyPk3Jzf0Fucdh7qkoqx+t1CbMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c3a61-6427-4d6a-291a-08d7b97f233d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 23:13:20.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr8cSwaROhKjuVSssOZsaEavPyg2yA72qYstpnerx6fBZYqZFSpU4GJOMuJ6YxCX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.73
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/24/20 4:31 PM, Eduardo Habkost wrote:
> On Mon, Feb 24, 2020 at 11:58:09AM -0600, Babu Moger wrote:
>>
>>
>> On 2/24/20 11:19 AM, Igor Mammedov wrote:
>>> On Thu, 13 Feb 2020 12:17:46 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>
>>>> Check and Load the apicid handlers from X86CPUDefinition if available.
>>>> Update the calling convention for the apicid handlers.
>>>
>>> Previous and this patch look too complicated for the task at the hand.
>>> In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 more
>>> reference to Machine into i386/cpu.c (even though it's just a helper function)
>>> and I think un-necessary hooks to X86CPUDefinition (it's not really CPU's
>>> businesses to make up APIC-IDs).
>>>
>>> I'd rather do opposite and get rid of the last explicit dependency to
>>> ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
>>> so for this series I'd just try to avoid adding more Machine dependencies.
>>>
>>> All 11/16 does is basically using hooks as a switch "I'm EPYC" to
>>> set epyc specific encoding topo routines.
>>>
>>> It could be accomplished by a simple Boolean flag like
>>>  X86CPUDefinition::use_epyc_apic_id_encoding
>>>
>>> and then cpu_x86_init_apicid_fns() could be replaced with trivial
>>> helper like:
>>>
>>>   x86_use_epyc_apic_id_encoding(char *cpu_type)
>>>   {
>>>       X86CPUClass *xcc = ... cpu_type ...
>>>       return xcc->model->cpudef->use_epyc_apic_id_encoding
>>>   }
>>>
>>> then machine could override default[1] hooks using this helper
>>> as the trigger
>>>   x86_cpus_init()
>>>   {
>>>       // no need in dedicated function as it's the only instance it's going to be called ever
>>>       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>>>             x86ms->apicid_from_cpu_idx = ...epyc...
>>>             x86ms->topo_ids_from_apicid = ...epyc...
>>>             x86ms->apicid_from_topo_ids = ...epyc...
>>>             x86ms->apicid_pkg_offset = ...epyc...
>>>       }
>>>   }
>>>
>>> That would be less invasive and won't create non necessary dependencies.
>>
>> Yes. We can achieve the task here with your approach mentioned above. But,
>> we still will have a scaling issue. In future if a "new cpu model" comes
>> up its own decoding, then we need to add another bolean flag use_new
>> _cpu_apic_id_encoding. And then do that same check again. In that sense,
>> the current approach is bit generic. Lets also hear from Eduardo.
> 
> To be honest, I really hope the number of APIC ID initialization
> variations won't grow in the future.
> 
> In either case, X86MachineState really doesn't seem to be the
> right place to save the function pointers.  Whether we choose a
> boolean flag or a collection of function pointers, model-specific
> information belong to x86CPUClass and/or X86CPUDefinition, not
> MachineState.

My bad. I completely missed that part. Yes. You mentioned that earlier.
I can move the functions pointers to X86CPUClass and initialize the
pointers from X86CPUDefinition. Thanks

> 
> See the reply I sent at:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2F20200128200438.GJ18770%40habkost.net%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7Cda1d1c9f34af4475596108d7b9795fef%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637181803279890359&amp;sdata=Z%2B%2BA2%2FMIVQZfGtUe1aBLzttCQnCpZKEwshOhoVAg1%2BU%3D&amp;reserved=0
> 
> ] If you need a CPU model to provide special behavior,
> ] you have two options:
> ] 
> ] * Add a method pointer to X86CPUClass and/or X86CPUDefinition
> ] * Add a QOM property to enable/disable special behavior, and
> ]   include the property in the CPU model definition.
> ] 
> ] The second option might be preferable long term, but might
> ] require more work because the property would become visible in
> ] query-cpu-model-expansion and in the command line.  The first
> ] option may be acceptable to avoid extra user-visible complexity
> ] in the first version.
> ] 
> ] 
> ] 
> ] > +        pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
> ] > +        pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
> ] > +        pcms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> ] 
> ] Why do you need to override the function pointers in
> ] PCMachineState instead of just looking up the relevant info at
> ] X86CPUClass?
> 

