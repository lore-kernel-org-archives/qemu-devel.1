Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFB921548
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwC0cT5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFB921548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD86H-0005Tf-JZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD83O-0007PM-JG
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:34 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com
 ([40.107.237.64]:18144 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD83M-00069y-3l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV11ASA8JwlTtWS2vYGXlAQf6s3O59kgbbyJvJK4jGbCiTHyfCUgzz6CJf+M2BPRvbwK4iXh4c+bZUETOZbk0M8gJ5pBcf0cebsOo2FS4ckMRAHc4yi2HF44o2np9gSVYL3Ige7Nes2lPabSxMlMsj6YcCVhfJT/1MQz+IBtBWWyvl5X12fz7kRwsLYOgwAVREk32tlpnJwWKiZjox9piuzCtOXxPBIk/TyRCp2RwVPPeUqtBntj10gHUjA3s/fnZFzGwSaNUgVDeJjG+rHSNqvhch2i7+C+oEj/AvGqqIXgSUMNGQWhNg3aJK8flRcmPjsCWxWuKUFHyRR4FocZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dAPpwyxoA/Z4UzVBdNJG7O/wVqR0LfU7bMVc+rIh7c=;
 b=HVLo3s/qshAowN+ojxfbF6Bw+gOCJ6WIctopgg1FD6fTExO/YOAUfyNbbFgvsWMrYfm+PwcJzmWmoTY2SfJXXmidM1/eBpl/vRoUYKHnjuLUocbeCguAKs5XfNdGNUMJ8eadkj0yBccXfZshazQJgd5bWtVSZ/Ktqp+Cyb4jXUivqhOGm03fwJwtRRVkZv8obEtsIM/y4sdt0gIj4ahL0QdEE/+RN9YUSaoaJaKVQaGSie7FJy+kY0Xn+p8TcxSWUSnVo7Pv4JWdgJ7ob8pThjHwWtcpwAaklb1LNt2dJRPe0/xBAUEeyYbuY/LoQrCdMRlzadLvaME7lCrfsWiqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dAPpwyxoA/Z4UzVBdNJG7O/wVqR0LfU7bMVc+rIh7c=;
 b=qwC0cT5crEa59pzLe14su7Ga1RvvbPArQxcNl98bMqHsWrY+X6KI0eRXdGHqYje5KACy0yo8CPwuLC7vrRat54EMcDgNt3DlV8SLK1r4oX3725mQHqDfqXSUdI9gl0GZhxXfkW8PjcYdvAORJR2XPk3UuYdaq3HVj9DqLH/Zn0k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 14:45:32 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 14:45:31 +0000
Subject: Re: [PATCH v6 09/10] i386: Simplify CPUID_8000_001E for AMD
To: Igor Mammedov <imammedo@redhat.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889938099.21294.9493474163204060713.stgit@naples-babu.amd.com>
 <20200901135249.22db38e1@imammedo-mac>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <3d8e5b6f-3a0f-5679-d3a6-c758a445e804@amd.com>
Date: Tue, 1 Sep 2020 09:45:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200901135249.22db38e1@imammedo-mac>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:806:d0::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 14:45:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8077faf1-fc11-4dcf-b102-08d84e85acb1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2431415C637F356B1E49EDFB952E0@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckV3wTCMPz6CEYkwIwqvF31Sn0NdVxbGwSHJa0rwAfWVI0yk1mmvZTAEJyVgEF5CsQmZT0y2ll4LZ1xLqRLzGR6HbsB6tdFRLtGsn++092jMoVZyKsjmazHBYZ3foq8GBaHVEP9xcoJ823PwsRTa+1j42gjGlXZNfqe+MaX61y4ORY1A5eMlQoopRbyYwiwtt5HMel4OkSOssb5kdgvdUosKcy+/uc87szIN/2/PTFh82MQvz5Zo/V5dHzDKSpTj3IhIUpa2MTVvhwFeBH3+AXrBeqc6yTxRIeCLUa+eRjmwgndNiMaMqNQs0DzcZ0LF4zhGyzRdqOMQC4YFo/23fNlpPzF1//aDvOmefqi0EFI4xUp3JesAtccixdWDx39/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(26005)(186003)(6486002)(53546011)(316002)(8676002)(16576012)(6916009)(8936002)(31686004)(83380400001)(4326008)(66946007)(2906002)(31696002)(86362001)(52116002)(66476007)(66556008)(36756003)(956004)(478600001)(5660300002)(44832011)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oPshJyluT+oc9IR7sKAADyl3W6pzNc8rthR3FLAmJuRMZ7BeGvmp6Y7yadpVeQjJNX5/ftTEK/tjU1pkSRZzM5hCv2wd8o/lzwfWUjY8Vx0k0o7I+ULKgd10wyqy/KIt7wlbuET7D6NbYfUrcTYYFswabnlp+z8l/L6VJhZVha2f0p2EyBLzyWD95cnSAL/pceTE5oTOPda0cRSh4IYVtjxA0p4vJXUcm1l47vP6Zw53KeNC/xJ+6+GC/UiWKKGJWsGctu28CfdpcGm8hnijdVOtS4nD5UOmH9qeJF47Imp0kC85fox1uTG69ONotcg2Mvlr4Az8YIqpOPs661lAXOLzo3jy1T87zTEJ+j31pJPYM021BE9tbsiFIY/D6fNk9NbYwQEVNdlV7YGZ1DU4gkVbBlvCRCmFgYfIxzM5Z1uEA8a1t9b8neLjZDX3xM9hOhwo3KV304jNoQjkj7bD+abifV1aBIZUFCK2qrnZ6FSxTcjiq4LE3rp70Owq/FPOKuRkz2IFlW1l4wtNuVHTivaUM1m6heC1FVUF4FtB+xFfF6wryr0sJJw5BtIRMrwDRy8VbXuPDsE8IfeMrMGK30FWT/rkK9qfAepp19c4qgS7AAolomToZ7woAnFoeMxHO+2R+tH0JvdTE7zR2kQs0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8077faf1-fc11-4dcf-b102-08d84e85acb1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 14:45:31.2265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFLkQWpZ6/aSDnCyiCRomdXFgszp1pzWsn37U37gwaCx4RXSri+HPcrH9xnxMW0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
Received-SPF: none client-ip=40.107.237.64; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:18:30
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/1/20 6:52 AM, Igor Mammedov wrote:
> On Mon, 31 Aug 2020 13:43:01 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Remove all the hardcoded values and replace with generalized
>> fields.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  target/i386/cpu.c |   31 +++++++++++++++++--------------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ba4667b33c..d434c8545a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -395,9 +395,10 @@ static int cores_in_core_complex(int nr_cores)
>>  }
>>  
>>  /* Encode cache info for CPUID[8000001D] */
>> -static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
>> -                                uint32_t *eax, uint32_t *ebx,
>> -                                uint32_t *ecx, uint32_t *edx)
>> +static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>> +                                       X86CPUTopoInfo *topo_info,
>> +                                       uint32_t *eax, uint32_t *ebx,
>> +                                       uint32_t *ecx, uint32_t *edx)
>>  {
>>      uint32_t l3_cores;
>>      assert(cache->size == cache->line_size * cache->associativity *
>> @@ -408,10 +409,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
>>  
>>      /* L3 is shared among multiple cores */
>>      if (cache->level == 3) {
>> -        l3_cores = cores_in_core_complex(cs->nr_cores);
>> -        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
>> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
>> +                                 topo_info->threads_per_core),
>> +                                 topo_info->dies_per_pkg);
> 
> from spec:
> "
> NumSharingCache: number of '''logical processors''' sharing cache.
> "
> 
> s/l3_cores/l3_vcpus|l3_threads/
> 

Sure.

> Also why not use just:
> 
>   val = topo_info->cores_per_die * topo_info->threads_per_core

Yes. You are right. Will correct it. thanks

> 
> 
> 
>> +        *eax |= (l3_cores - 1) << 14;
>>      } else {
>> -        *eax |= ((cs->nr_threads - 1) << 14);
>> +        *eax |= ((topo_info->threads_per_core - 1) << 14);
>>      }
>>  
>>      assert(cache->line_size > 0);
>> @@ -5994,20 +5997,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>          }
>>          switch (count) {
>>          case 0: /* L1 dcache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 1: /* L1 icache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 2: /* L2 cache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          case 3: /* L3 cache info */
>> -            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
>> -                                       eax, ebx, ecx, edx);
>> +            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
>> +                                       &topo_info, eax, ebx, ecx, edx);
>>              break;
>>          default: /* end of info */
>>              *eax = *ebx = *ecx = *edx = 0;
>>
> 

