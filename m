Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F7BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD77D206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ggImo3ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOmTI-0000sR-0R
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jOmSV-0000GJ-9j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jOmST-0005UA-Th
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:08:23 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com
 ([40.107.94.73]:53089 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jOmST-0005TI-IF
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0cYO6cQCgVdKPo0hwczCXqOgaCGP24pXAVZa2vvmBBoTv5eQIBaN7feF6MkuclbGBEzH5UWN2Sk74j0miwsjUJKEq168Xhs5GFqzdlAQ4frhh4w6MQgTmlCXWj0AHWaPa2XHKAcm+y2Nr/9bFTzA37qOVBhQ8UI44xYSHskeXg5PNfJkgzA9kEMnwiAGM0tj/4dW2HB9hEZ3JgciaM7YG8cyH21SdslJEhc8AWNbCyfFSiKLTK3sfmm7JC/WLWEBVze81WpUwARGH8phrG2y6Ly/oQpaAWvqGQJaaodTr1ymaX+MHpXWs4Z2anN9fTOBp9blQstJK8AM+oAgFmPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrCWbNeTWLcbbxUg7afle4FVYckzysUZEDX2uQ7+MD4=;
 b=eZB3YNZNUgDBZ35zoJ5pYKenK2GIliQMeApo94cjPJIa58qE+zoK6GQtwYSG3XTgFUlUwP+qc48rGZ78dht++AlboyJ2jK7UMaE5568bSon0dMlmuLHfkBoRBtKsCiIJOOuyVt/Nivjhtxtl0BWWO4v29wMs2ZVjlcElA0cPFZNAWtJWDsodZtruArG8rbFt/N6trHxSkBhOugZtjxiIhfUqlNyxs8obVkVnkMITG239FgVpQEwD0SuEODvPp5OO917bD3olT8fofU9V+NGuRnAXgSOIfBWAjbqT8D2EXL2yHA1BNURAX1s9A4WyEJmjUqzMt2YGq3jj/k30D61vIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrCWbNeTWLcbbxUg7afle4FVYckzysUZEDX2uQ7+MD4=;
 b=ggImo3urPzHtLGjDm64RheVox4e6iA/7PX/4ncHuWZRFsn5W8rR1vM1JweCV8khKpESKCsp2SKyT2fazVvBXLw4kKVLFrSmK4ifwCfBXsNcnc5NlxIOOtULekf6lL1FXpwam8+wKJ9CTjQ/jqynHoNsV/MOr4+9ZPdF6+b4AMqY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Wed, 15 Apr
 2020 18:08:18 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 18:08:18 +0000
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number of
 cores inconsistent with ACPI.MADT
To: Igor Mammedov <imammedo@redhat.com>,
 Philipp Eppelt <1871842@bugs.launchpad.net>
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200409160037.431ec776@redhat.com>
 <c01f506c-5447-d048-15b2-3f113818844f@amd.com>
Message-ID: <884b4dcd-5ff2-2834-e73f-f88b868dca56@amd.com>
Date: Wed, 15 Apr 2020 13:08:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <c01f506c-5447-d048-15b2-3f113818844f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:3:c0::33) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:3:c0::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 18:08:17 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6676ae9f-3f39-4f97-67c2-08d7e167f99b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23517BBD0F714992D080437F95DB0@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(86362001)(6486002)(8936002)(110136005)(2616005)(478600001)(53546011)(956004)(316002)(81156014)(16576012)(8676002)(966005)(36756003)(2906002)(186003)(16526019)(31696002)(26005)(66556008)(4326008)(66476007)(52116002)(31686004)(66946007)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+5qoxfovFvC7/Cu9E7dq1D/g+5yRMhLhlvDkNXzFnEvkhZ6xa2Hj3MhnckUnQAS+VcPMbyNBTB++1HuBD4G8piixEdzn6pMr0n/pvR+aaXsITqE8+ndeuUruahloRAqEjdgjxGvGylT3smON5S1wjMbk0hOrwInTlTKz0iNCCMuJnKy1qL6ko87r+CxbyodQ5bp0Lug0XZi6Ma/FhpvnF1OTk1k+8BkCQr50u2AsYTpmTWmfh2WlJZ/tBnEb1PWvpwy5NUDW9pFJa06dvzlaI2EGbTfkQ6tGf0bDnnzLqHGB2UWpqf9as7hTpZuzysAcLCJiZVNBbpIJwoeqmC8NGwUWS+zh6blrzYDLNiRHY+xAVUs8cS4GZXYhpd7B2wcUkZbMWSTFKbqGSrlDQl8dk/zFhujYYZPGPUK3O4/pRnS3MF8xMcMcJWyTdEAn3Khg/kxiCr1/GAk57+2cd5t3uPg9YUi/taS6B/zATpTecC2MUoW6GuwTnZAOZ4MtaCcUckIX/sYMAxtr2Tfp26wcA==
X-MS-Exchange-AntiSpam-MessageData: uqjNIsEPFHwNB03ZLbzXVCRHfH665seyNQplQNFXtcMFwnpz7mqqwWNOff5Yhdcg1IByetFzdXjJlJQ9I4Zw3D8YoLB8gq1y3vXRStNChSgRrKNrMyk6FpxujyoOeYytHrp/50UDypssO9gnNJiwgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6676ae9f-3f39-4f97-67c2-08d7e167f99b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 18:08:18.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXj0JEOVFfxZPEaNTzGg/h1O7iebfJYbaJbya7wUGCLBsnHyKWb3nD1eKxNVHVGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.94.73
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks. I saw the update in the thread.
https://lore.kernel.org/qemu-devel/42f0624d-b0fb-5d96-2921-8994c28b9937@kernkonzept.com/
Looks like you have found a way to take care of your problem.
But We need to fix the CPUID leaf 0x8000'0008 anyways.
Will send the patch to review later this week. Thanks


On 4/9/20 12:48 PM, Babu Moger wrote:
> 
> 
> On 4/9/20 9:00 AM, Igor Mammedov wrote:
>> On Thu, 09 Apr 2020 12:58:11 -0000
>> Philipp Eppelt <1871842@bugs.launchpad.net> wrote:
>>
>>> Public bug reported:
>>>
>>> Setup:
>>> CPU: AMD EPYC-v2 or host's EPYC cpu
>>> Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
>>> qemu version: self build
>>> git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
>>> config: Configured with: '../configure' '--target-list=x86_64-softmmu,mips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu' '--prefix=/opt/qemu-master'
>>>
>>> Cmdline: 
>>> qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64/bin/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco , ... " -serial stdio -nographic -monitor none -nographic -monitor none -cpu EPYC-v2 -m 4G -smp 4 
>>>
>>> Issue:
>>> We are developing an microkernel operating system called L4Re. We recently got an AMD EPYC server for testing and we couldn't execute SMP tests of our system when running Linux + qemu + VM w/ L4Re.
>>> In fact, the kernel did not recognize any APs at all. On AMD CPUs the kernel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX[NC] or [ApicIdSize].  [0][1]
>>>
>>> The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x18cf757 ECX: 0x703f EDX: 0x1000
>>> The lower four bits of ECX are the [NC] field and all set.
>>>
>>> When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically as replacement and addition to the above cmdline) the CPUID leaf shows: EAX: 0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
>>> Note, ECX is zero. Indicating that this is no SMP capabale CPU.
>>>
>>> I'm debugging it using my local machine and the QEMU provided EPYC-v2
>>> CPU model and it is reproducible there as well and reports:  EAX:
>>> 0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0
>>>
>>> I checked other AMD based CPU models (phenom, opteron_g3/g5) and they behave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
>>> I believe that behavior here is wrong as ECX[NC] should report the number of cores per processor, as stated in the AMD manual [2] p.584. In my understanding -smp 4 should then lead to ECX[NC] = 0x3.
>>>
>>> The following table shows my findings with the -smp option:
>>> Option | Qemu guest observed ECX value
>>> -smp 4 | 0x0
>>> -smp 4,cores=4  | 0x3
>>> -smp 4,cores=2,thread=2 | 0x3
>>> -smp 4,cores=4,threads=2 | QEMU boot error: topology false.
>>>
>>> Now, I'm asking myself how the terminology of the AMD manual maps to QEMU's -smp option.
>>> Obviously, nr_cores and nr_threads correspond to the cores and threads options on the cmdline and cores * threads <= 4 (in this example), but what corresponds the X in -smp X to?
>> I'd say X corresponds to number of logical CPUs.
>> Depending on presence of other options these are distributed among them in magical manner
>> (see pc_smp_parse() for starters)
>>
>>> Querying 0x8000'0008 on the physical processor results in different
>>> reports than quering QEMU's model as does it with -enable-kvm -cpu host.
>>>
>>> Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
>>> CPU leave reports a single core processor.
>> it matches -smp X as it should be.
>>
>>>
>>> This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
>>> wrong number.
>> CCed author of recent epyc patches who might know how AMD should work better than me.
> 
> Hmm.. Interesting.. Not sure why this did not come up during my testing.
> Probably this cpuid information is not widely used.
> 
> Yes. I am looking at it right now. I see that EPYC model is reporting
> wrong. Not sure why -cpu host is reporting wrong. I thought -cpu host gets
> the information directly from the host. Will investigate.
> 
> 

