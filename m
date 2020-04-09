Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FABC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E403B206F7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D8FmBr7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E403B206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMc4w-0000oG-4n
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jMc3f-0008Ho-ES
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jMc3e-0003kS-4G
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:37:47 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com
 ([40.107.237.46]:44000 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jMc3d-0003k7-Rk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:37:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAIfDMCZtnJ9/c7FBXGLXH1GvTiAB9iIxpiyrBQgu9W9YIy/4tJk1oNeo1m2XkymIWaxmJWDS2hyUml8/eg0CXNeGF7MvoHzO5c1C20PbjxQ0pnPhkTH4rpky9zF6Sh4KzyPCtDakOWC/AjOTS7lMB8tjl72uUQB+7QdOc74liZ4AWF91b1E+hk4CMnFl3sfxAcde5ZKxay6qrU/TqdITzUcSUK65BROiE1dahoQUl056XOy+moiw9N3JVXY0Emc2MylTIItCdlyJ/pOY2d6f8toayivJyc1X0OgTAcI3SIM/KMSZ+RF3in9g1cFIaYLV26/TVu++ZEfnkZVOMbRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3X/T1DJw1evflLSmHzxplhkgrrWutRWu4Q47mT08po=;
 b=Mj1jgWhJXBD+QyOC8EBJNxkkKDM+Fy6haLFVtvIofmf693UPFCfqYU6ITMNq/Jj1M3DufPxL3X44ca3PyxFgTU0Jy6ZzgxKCNSNDftkM+LTPC/CSWYNvKXFjnk2Ot2QnkGtoZOwCjNo6TGYkUnsIGP+wTvcQqNZG2ADvZiUH61sij/wsrtDoNKBO7wSquDV6xkskhEbg31fWUh0r/D/xg8en2+acJ6smDkUpoub1zUgkgH1JMG0lEKdpOd1fYihCkysV/W7XS4OC7wO7sZk5z12JshdHBBNVHCiz+j29h6/PtaBS02+K1yC4QxJtLWoZU/qgX4YR2EybPTFhdtag1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3X/T1DJw1evflLSmHzxplhkgrrWutRWu4Q47mT08po=;
 b=D8FmBr7ITwy2AxV0Cf5hrjukeTuHHqO4chd4EZXUr92BeVUN/F3USxSCcCpRkMXMwOtC3UsoCh0QzGiDggVtO+729I/wqC5pqwnAD76Q4QKbTdIRIWaqJ2qQ79fCtENZw60g0X8Y3n6iz/iVSBQK3iDeuB4bAyLF4NTi/wC5qMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16; Thu, 9 Apr
 2020 18:37:43 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2878.021; Thu, 9 Apr 2020
 18:37:43 +0000
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number of
 cores inconsistent with ACPI.MADT
To: Igor Mammedov <imammedo@redhat.com>,
 Philipp Eppelt <1871842@bugs.launchpad.net>
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200409160037.431ec776@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <679ba0cc-1af0-42ee-f8bc-26e7cafcc304@amd.com>
Date: Thu, 9 Apr 2020 13:37:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200409160037.431ec776@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:3:23::25) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:3:23::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.6 via Frontend Transport; Thu, 9 Apr 2020 18:37:43 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0ae670b-f192-4f5d-134f-08d7dcb51761
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2350E32BE5673E2F56CBBA7F95C10@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(66556008)(4326008)(52116002)(66476007)(66946007)(6486002)(5660300002)(26005)(16576012)(316002)(186003)(81166007)(16526019)(81156014)(8936002)(31686004)(2906002)(2616005)(956004)(8676002)(36756003)(44832011)(110136005)(53546011)(31696002)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pu0MqfkdZTX+fL4jM6wdV+VQnK2vLuGogb3FowCLcviGkMBH98f3dPAe77PXdk6SKnBdLmTj/lrsSEJI2Rx/d5xXUeMoqfm154Jygddavx8jTsP4t3FZWJo9RzC/6JYhdYm0TLalDFrpfQnjdXCVVMH80pj8GdpodTh2msz22yPkUoHcSZsOkEmRE8tOQvSNsGgSQ8lD7c0l9SMp+rAEGOSbUX+8dzj1TyMv/Cb9KJz7PugE5N/ceiGiYI8nryoioPAf6E646nUWtYiNPOxujS7ggLfhuWmH7s/idLq6G1ANqS9HR6DBcLWyrvk5F4OGg/sorojwa5WLnnTz0rQ5Pr5hA9WnTmFnG5YdU7bqDPpa/JA7uHX2oD+6/DxCN+KNAr6wOgcpaYtMrtC6ZRaGMaQgMk/h2lFUy5rAw8WvZ2jsbczC7fqnY3ctzkaDdEbS
X-MS-Exchange-AntiSpam-MessageData: 07V7Bj8LR9r6FLPIeX6yF2e079PHsQkAUvZQxWQBEwAfB/Hc/5kaYfoDLvGOOC4w88G4KlZOFpRraVlomytXH05BIx5Lzh+IAzQXf6v6pr4bBS1ga6zJQ7dlgVdnydW7UZ8mZWB0Mwp61pFhaAaNpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae670b-f192-4f5d-134f-08d7dcb51761
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 18:37:43.7752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKiKevJs8dVus1z610zfEoKkjgHgf/RnYeIvNks/RURJ7trtSEK0UbJ6g/7ZxIqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.46
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/9/20 9:00 AM, Igor Mammedov wrote:
> On Thu, 09 Apr 2020 12:58:11 -0000
> Philipp Eppelt <1871842@bugs.launchpad.net> wrote:
> 
>> Public bug reported:
>>
>> Setup:
>> CPU: AMD EPYC-v2 or host's EPYC cpu
>> Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
>> qemu version: self build
>> git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
>> config: Configured with: '../configure' '--target-list=x86_64-softmmu,mips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu' '--prefix=/opt/qemu-master'
>>
>> Cmdline: 
>> qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64/bin/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco , ... " -serial stdio -nographic -monitor none -nographic -monitor none -cpu EPYC-v2 -m 4G -smp 4 
>>
>> Issue:
>> We are developing an microkernel operating system called L4Re. We recently got an AMD EPYC server for testing and we couldn't execute SMP tests of our system when running Linux + qemu + VM w/ L4Re.
>> In fact, the kernel did not recognize any APs at all. On AMD CPUs the kernel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX[NC] or [ApicIdSize].  [0][1]
>>
>> The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x18cf757 ECX: 0x703f EDX: 0x1000
>> The lower four bits of ECX are the [NC] field and all set.
>>
>> When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically as replacement and addition to the above cmdline) the CPUID leaf shows: EAX: 0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
>> Note, ECX is zero. Indicating that this is no SMP capabale CPU.
>>
>> I'm debugging it using my local machine and the QEMU provided EPYC-v2
>> CPU model and it is reproducible there as well and reports:  EAX:
>> 0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0
>>
>> I checked other AMD based CPU models (phenom, opteron_g3/g5) and they behave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
>> I believe that behavior here is wrong as ECX[NC] should report the number of cores per processor, as stated in the AMD manual [2] p.584. In my understanding -smp 4 should then lead to ECX[NC] = 0x3.
>>
>> The following table shows my findings with the -smp option:
>> Option | Qemu guest observed ECX value
>> -smp 4 | 0x0
>> -smp 4,cores=4  | 0x3
>> -smp 4,cores=2,thread=2 | 0x3
>> -smp 4,cores=4,threads=2 | QEMU boot error: topology false.
>>
>> Now, I'm asking myself how the terminology of the AMD manual maps to QEMU's -smp option.
>> Obviously, nr_cores and nr_threads correspond to the cores and threads options on the cmdline and cores * threads <= 4 (in this example), but what corresponds the X in -smp X to?
> I'd say X corresponds to number of logical CPUs.
> Depending on presence of other options these are distributed among them in magical manner
> (see pc_smp_parse() for starters)
> 
>> Querying 0x8000'0008 on the physical processor results in different
>> reports than quering QEMU's model as does it with -enable-kvm -cpu host.
>>
>> Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
>> CPU leave reports a single core processor.
> it matches -smp X as it should be.
> 
>>
>> This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
>> wrong number.
> CCed author of recent epyc patches who might know how AMD should work better than me.

Hmm.. Interesting.. Not sure why this did not come up during my testing.
Probably this cpuid information is not widely used.

Yes. I am looking at it right now. I see that EPYC model is reporting
wrong. Not sure why -cpu host is reporting wrong. I thought -cpu host gets
the information directly from the host. Will investigate.

