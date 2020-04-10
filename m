Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8695C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 00:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7E020768
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 00:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H1UuCGra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7E020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMhIa-0000iI-MU
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 20:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jMhHj-00006w-Uh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 20:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jMhHi-0007sl-8l
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 20:12:39 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com
 ([40.107.237.58]:6134 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jMhHh-0007s8-JY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 20:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5A71/KiBwgGYNEc0vwirJUpoF1zF6kQG4GM1d2vddk3w8gpdna85tEhiCVToATNW1vmPr8n4sJXyWQ6y5e8dZhTHGy0b72THODspVWqrhs0CumY2HnqTjfYwWpl72iAybci7Lh74Kvr2PMeukFh3MLj8GIa2lQT+Vc5Z5erOejMowpLp/Fqf+Mgi8roGTM/1uKJA9nSsS7LcNHcVsL8l4g+sCbWJqz1chi9Ycwx3Fg2q9xUKel1WSK+af2mtydGQiu4l8q/em+ielOgKmTZwJLk4S78ylYUQCndzpsqRGMeI7zdYC3y8ZTATJxHoswcOV2cJcvpstE4MAFuz2hf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqW2vRFijOo1+qHIoR0Sbgv8Ov0mUNhTGKGPHCa/XqQ=;
 b=IKaJoAfndyzZDK0uXERUyVZg8Aayoxm8USwX3DuRlOFXvqd9N2IqiJBPkAdmK5SZ3J9JSZPrdbcy6x96BYRL4sPwc3li68E5l5/gww3tnfzU74gA6FjEKlOFTFKviuL5DQ2Y6BAgmW6K3LGwrDVFDz2B5dj4aa3W7FzqDVGTD9p7j5yVf1Rdt8ewdNJIWeF6OTx/IBl+sb0H4/KUit4Ajf2835v3PgSP+9p5Je9AUADq6n05m4MSKG9okVNbhnYknnRI3WqcE544nXpYt9aWdIYjAznYfmjW4gGkPpwIs3lK+JnUbT8MBpb9kTiTKZ8dkFwzXFpoVYQF1GyAuMrl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqW2vRFijOo1+qHIoR0Sbgv8Ov0mUNhTGKGPHCa/XqQ=;
 b=H1UuCGracPjt6fNf0/9fhExEZoDBSEMY3+OL514XdgnbnXu4NwpexjP0JuUL8G97O3OheTmdih4oCruulC7c5hZfiNQkFsgqDegau/ywOB2/CBCZym+YzICWIpqyxi3dhHtWNWzRNzBbMxPljdW4pN+W+qp4AL6xkMz/IsfpJb0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 00:12:33 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2878.021; Fri, 10 Apr 2020
 00:12:33 +0000
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number of
 cores inconsistent with ACPI.MADT
To: Igor Mammedov <imammedo@redhat.com>,
 Philipp Eppelt <1871842@bugs.launchpad.net>
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
 <20200409160037.431ec776@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <5f7b85c6-09af-1064-f7f8-66ea7abf3ae3@amd.com>
Date: Thu, 9 Apr 2020 19:12:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200409160037.431ec776@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:3:23::18) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:3:23::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.6 via Frontend Transport; Fri, 10 Apr 2020 00:12:32 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e137ee5-54c1-404d-ebe7-08d7dce3dd61
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2414CDE3DFFF00019E59616395DE0@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(966005)(81156014)(66946007)(8936002)(4326008)(31696002)(86362001)(53546011)(45080400002)(16526019)(8676002)(66556008)(316002)(16576012)(31686004)(478600001)(110136005)(6666004)(52116002)(5660300002)(44832011)(36756003)(26005)(2906002)(6486002)(186003)(81166007)(956004)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDQR89dIEmv5F+BjKDnU51CHuNXqrd/9epX3mbQ6UR2J3vTfBv58KXwrO3e1YOiAHOHP4f6RuXrPy8ejZ8QumMsCt4GMshWW6NxKIjVeE34qEvU5U5WvVRqXLznZgWtBr5i9J6o+a2cKt7CLdv6rAI1A/DaGQzoveOpx9C49ij45XSiulJMHirqp6PEaEsnU9SImYClybrip8J/DDZoehrq9MZ3HxyGISJ6Cea/zMlrl8hJKQ1OLVO1Kh9bBG64dQPFCrblJumu9dBFl9pli7aizptWHMx0TGpbqt6UczZyfs/6D5ZXew8S3mUmvsP7ShyR7vBBhqvIP/i1yuMdEjEETU60BZfQURMrOvZ6uuos67GNwL4DgJesajCROx8ZRxRbN3CqXuir2dw8Zw126/gHH+xzyDJYr95XCKjgYUXtFezdehBQQ3SCnQ25LIQbctxGPvvtYd//ZOa3kUFGeTR4ERr7xKPgKb9Aeye0yfPCMCtOqcVnLkshPIPzqxbYwJZSbeIm3dgBiREcJG7mGBg==
X-MS-Exchange-AntiSpam-MessageData: mTpzPPPdV3xOemvKkiUcZVH/+PFN0ljgPqVTdxUVgET9qNaE+rWIEVUf3JJHqH/TA4rysaWd9G93hETHtl0yB2LvCz0COHBSN+0M62+wjOtSVwz/RcXsJApVr2v8D5faeLJeaJvb0XAQOsfVlg+OfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e137ee5-54c1-404d-ebe7-08d7dce3dd61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 00:12:32.9161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC4j2xFh6TYkNwrpdYYXzmcnfQd+dEKkybqy/mnNuizfDK8iqNVa/v3rLVv3V2Yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.58
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

Philipp,
  Can you please check if this patch works for you.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f..e467fee 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5831,10 +5831,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
index, uint32_t count,
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
         *ecx = 0;
-        *edx = 0;
         if (cs->nr_cores * cs->nr_threads > 1) {
-            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
+            unsigned long max_apicids, bits_required;
+
+            max_apicids = (cs->nr_cores * cs->nr_threads) - 1;
+            if (max_apicids) {
+                /* Find out the number of bits to represent all the
apicids */
+                bits_required = find_last_bit(&max_apicids,
BITS_PER_BYTE) + 1;
+                *ecx |= bits_required << 12 | max_apicids;
+            }
         }
+        *edx = 0;
         break;
     case 0x8000000A:
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {



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
> 
>>
>> Please let me know, if you need more information from my side.
>>
>>
>> [0] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b879cbbd19%2Fsrc%2Fkern%2Fia32%2Fkernel_thread-ia32.cpp%23L109&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=hcFJzLAVQoIh5IN9CP%2F9cUQNOZoBnpRA6FliJur1wzQ%3D&amp;reserved=0
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fkernkonzept%2Ffiasco%2Fblob%2F522ccc5f29ab120213cf02d71328e2b879cbbd19%2Fsrc%2Fkern%2Fia32%2Fcpu-ia32.cpp%23L1120&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=ANJIbYKbwfq2bDelH%2FRLKnDPIUZc1BwxHspmgxLU7gs%3D&amp;reserved=0
>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fqemu%2Fqemu%2Fblob%2Ff2a8261110c32c4dccd84e774d8dd7a0524e00fb%2Ftarget%2Fi386%2Fcpu.c%23L5835&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=oj3mv9e5YOzUsfUjXK44gC8LybyWgMKo8JBIrRR%2BmDA%3D&amp;reserved=0
>> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24594.pdf&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C57569f7959744399655b08d7dc8e6e24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637220379083511672&amp;sdata=7Yr3J9ihlqSqXCXKN5JJNTByO3NGI%2BGMz2EqBF2Y4hw%3D&amp;reserved=0
>>
>> ** Affects: qemu
>>      Importance: Undecided
>>          Status: New
>>
> 

