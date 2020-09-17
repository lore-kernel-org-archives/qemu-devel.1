Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C0CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA8D21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nw5yCXPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA8D21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyML-000798-Lg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIyJy-0004rp-2v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:07:50 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com
 ([40.107.93.65]:27616 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIyJv-0006jr-GA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ/Z8eV7ZB80Ueb3P7gUFHI6Xp5fRuR7wDdsFIE2FbQmw0Pb5ts582M4yBh54ABPdb0EDGSRrC/St8uP6lpP90tk4v/NOTfwW5hJ5mcStidDxYsMFR8aE/OiSRqujO0waVRecPXTiuWtKOvMedYaFcgeaeIUsKjonW4WkCmaBnVKgUBM79hD86PNVuoFnFLQA1sugXnNVxn0b25Sm0mOxIIAtYtiSfgik/71dPZJziXYk/wK7vgSovRivOxughjmjTYGX1KRcOpsqGH74FM64H2aIFonk16SibwiPVqm8MjBP7hrZGuwgMutG1yK2uYSm1b7LLNYbJ8sT8zd30dpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5o/TO9KlynlcCYYCHA+URbK6BjRckraMLKxa3WigGo=;
 b=D5jrNKK6herBEmJP+H7aipZgmTwluQWVq7XgTMxr9rgMs0sFgrLdQyTjQ8MhV2G3z6f1sEW7e1I/kY9jlH5vRxuUdi5NSNTmtwuFBkaY7l5n9Y8v6jOUHZF0XNZNsa9VvnUs6VIBm29P2T8KazuTALvoTMudf8sIZgNab8BPwW1Oym4NU1+wY0msV/SybLoR4YPNOBmruI1Y4JR8cDeID8l0h+K+JoD0xaiXyVKzNUHIfqpGFkZJCcYs5Y7G77/FJGnGWeVz93PcWHBgP71rBrTHji6MiA4K4a8UtKeDYK1d81wxurkV9WWw73ZdSdq/PLhr+M6dntO1v/ujAz8x4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5o/TO9KlynlcCYYCHA+URbK6BjRckraMLKxa3WigGo=;
 b=nw5yCXPjDkqJ6kWzCvvvOteRPv2p7T0zFhm/dezZJBnJKy7T3uhSEFqPBQ/IadoPh/fMj1W2F60+3UOTgR1nLUwXdyJdRIwfRsn7L8cEbtjwlBI31oDHC+qfNAbePVDdHWbCXVscyRHeUa1w8tirNWSOzmYj+XBqXS3aP+7ZuvI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 18:07:44 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 18:07:44 +0000
Subject: Re: [PATCH v3 3/5] sev/i386: Allow AP booting under SEV-ES
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <9d964b7575471f45c522eea9ea3a7d84ed4d7d2b.1600205384.git.thomas.lendacky@amd.com>
 <20200917164635.GQ2793@work-vm>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <46f52fa8-fc5f-0442-8b2f-dfd95d6c9049@amd.com>
Date: Thu, 17 Sep 2020 13:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200917164635.GQ2793@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:806:d2::7) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 18:07:43 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04ee5142-5b0c-4ab6-44ca-08d85b34936f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3577FEA16573E54E6502FB81EC3E0@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5hPFdfdeqV/Bjvwp2Nd9Z59Lu604TfIaPUP9NoA8UQH/HfvwV8IwMazZaqAOw27RbduHrmeqZrBeHQJN287ZX4BCL0P9sQByxskC6mh0mXD5Uos3RCPrEJxllXRynktGLJHZpHeyUpFn3dOi1uqe/01FTXvztOSfC0glfgxFnHFN4+/nGON4g/PL/9gp/69OrDXNORChdZwx4Eq5NqA4u2vIcRV+cUNWTAka7JHZNZmorI78LTUGUJBXV2bH8U8+hpqpYzfxwEOLDOzySqq3aZtUA+r32iLhdzruHZ1Fk6BaFSD9l0LgkgZqv9W8ugXFMjMiLMuw1RWu8Wyg7VecsZ2GwxUJ3xLd9wQAhAZ8aYE3W2O57T4NGC2JrWV74/z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(52116002)(36756003)(54906003)(2906002)(7416002)(8676002)(66946007)(66476007)(66556008)(53546011)(5660300002)(83380400001)(16526019)(478600001)(186003)(31686004)(86362001)(6512007)(6506007)(26005)(6486002)(316002)(4326008)(956004)(8936002)(2616005)(31696002)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SPqpxGykTadi1DBoR1YRj/Cnm4zbPFQGzh3TcCVmiuCH9/FiSAQO6vXOkjKsYrqoUF+tW9llB6ZOXPD7YT1MgUWWi9j7W4+4waUAccTqkztkh+i1P4pcwKFmvwOk/j2eXZT0NB51D7rankmxJUbVqy8LUmLQGIEEynCHeEVb69XwgV4q4bVxOjH066+Tj5ovmwxvHgvTKCdmdxDWGA67bB82DmUDnli+YphnDd99vKsfbeVqHw/zd627DZN9TpduUFBciaglfefGMpwKf3JC4XAoqj1DZ+x1CXdt1/fl7TdKlvf486Bgm8QRgrK92QE0j8wGPrzyIOqj2CPTmRZlF+9sO1n5exmbtW7LvuEI33uLRgQcyMln3WbgL2B4Xeut7CXTdaEpLnW3vNBbo80wr9eGP7Bfrz5sNexQ7D6BP3oLqu0B+hoHdyJfWYyJFu5ExvPbUWf0uS/4Q690SwX6EPVMvD+rJIjcxUJt+MqgLoZa2ZLP+phc8ECKGxp5a4gAcaf6EGCHafm2EvFNEO5jcR8oM61FE4G9TJJu8k50R0pPkhhWVyYjUcwxhvIeUSLFuc4Q3bLa0j/j9Blw01Ywn06PvzEBP8GEJIRIFsmJKc8UgEQhTA9PS3S/dABKcYJK0zK47w4sH3h/SKOC43DtjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ee5142-5b0c-4ab6-44ca-08d85b34936f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 18:07:44.5573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRrDTyJRDbNX3sY5iZofDyTy+0b//aA92o6KQZ53TRRx7B5/8yAhRMClT1XOveMca2xk3MdgDv6q0sId38voOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
Received-SPF: none client-ip=40.107.93.65;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:07:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 11:46 AM, Dr. David Alan Gilbert wrote:
> * Tom Lendacky (thomas.lendacky@amd.com) wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> When SEV-ES is enabled, it is not possible modify the guests register
>> state after it has been initially created, encrypted and measured.
>>
>> Normally, an INIT-SIPI-SIPI request is used to boot the AP. However, the
>> hypervisor cannot emulate this because it cannot update the AP register
>> state. For the very first boot by an AP, the reset vector CS segment
>> value and the EIP value must be programmed before the register has been
>> encrypted and measured.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++++++++++++
>>   accel/stubs/kvm-stub.c |  5 ++++
>>   hw/i386/pc_sysfw.c     | 10 ++++++-
>>   include/sysemu/kvm.h   | 16 +++++++++++
>>   include/sysemu/sev.h   |  3 ++
>>   target/i386/kvm.c      |  2 ++
>>   target/i386/sev.c      | 51 +++++++++++++++++++++++++++++++++
>>   7 files changed, 150 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 63ef6af9a1..20725b0368 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -39,6 +39,7 @@
>>   #include "qemu/main-loop.h"
>>   #include "trace.h"
>>   #include "hw/irq.h"
>> +#include "sysemu/kvm.h"
>>   #include "sysemu/sev.h"
>>   #include "qapi/visitor.h"
>>   #include "qapi/qapi-types-common.h"
>> @@ -120,6 +121,12 @@ struct KVMState
>>       /* memory encryption */
>>       void *memcrypt_handle;
>>       int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
>> +    int (*memcrypt_save_reset_vector)(void *handle, void *flash_ptr,
>> +                                      uint64_t flash_size, uint32_t *addr);
>> +
>> +    unsigned int reset_cs;
>> +    unsigned int reset_ip;
> 
> uint32_t's ?

I can change those.

> 
>> +    bool reset_valid;
>>   
>>       /* For "info mtree -f" to tell if an MR is registered in KVM */
>>       int nr_as;
>> @@ -239,6 +246,62 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>>       return 1;
>>   }
>>   
>> +void kvm_memcrypt_set_reset_vector(CPUState *cpu)
>> +{
>> +    X86CPU *x86;
>> +    CPUX86State *env;
>> +
>> +    /* Only update if we have valid reset information */
>> +    if (!kvm_state->reset_valid) {
>> +        return;
>> +    }
>> +
>> +    /* Do not update the BSP reset state */
>> +    if (cpu->cpu_index == 0) {
>> +        return;
>> +    }
>> +
>> +    x86 = X86_CPU(cpu);
>> +    env = &x86->env;
>> +
>> +    cpu_x86_load_seg_cache(env, R_CS, 0xf000, kvm_state->reset_cs, 0xffff,
>> +                           DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
>> +                           DESC_R_MASK | DESC_A_MASK);
>> +
>> +    env->eip = kvm_state->reset_ip;
>> +}
>> +
>> +int kvm_memcrypt_save_reset_vector(void *flash_ptr, uint64_t flash_size)
>> +{
>> +    CPUState *cpu;
>> +    uint32_t addr;
>> +    int ret;
>> +
>> +    if (kvm_memcrypt_enabled() &&
>> +        kvm_state->memcrypt_save_reset_vector) {
>> +
>> +        addr = 0;
>> +        ret = kvm_state->memcrypt_save_reset_vector(kvm_state->memcrypt_handle,
>> +                                                    flash_ptr, flash_size,
>> +                                                    &addr);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +
>> +        if (addr) {
>> +            kvm_state->reset_cs = addr & 0xffff0000;
>> +            kvm_state->reset_ip = addr & 0x0000ffff;
>> +            kvm_state->reset_valid = true;
>> +
>> +            CPU_FOREACH(cpu) {
>> +                kvm_memcrypt_set_reset_vector(cpu);
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /* Called with KVMMemoryListener.slots_lock held */
>>   static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>>   {
>> @@ -2193,6 +2256,7 @@ static int kvm_init(MachineState *ms)
>>           }
>>   
>>           kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
>> +        kvm_state->memcrypt_save_reset_vector = sev_es_save_reset_vector;
>>       }
>>   
>>       ret = kvm_arch_init(ms, s);
>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>> index 82f118d2df..3aece9b513 100644
>> --- a/accel/stubs/kvm-stub.c
>> +++ b/accel/stubs/kvm-stub.c
>> @@ -114,6 +114,11 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>>     return 1;
>>   }
>>   
>> +int kvm_memcrypt_save_reset_vector(void *flash_ptr, uint64_t flash_size)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>>   #ifndef CONFIG_USER_ONLY
>>   int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>>   {
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index b6c0822fe3..321ff94261 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -156,7 +156,8 @@ static void pc_system_flash_map(PCMachineState *pcms,
>>       PFlashCFI01 *system_flash;
>>       MemoryRegion *flash_mem;
>>       void *flash_ptr;
>> -    int ret, flash_size;
>> +    uint64_t flash_size;
>> +    int ret;
>>   
>>       assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>>   
>> @@ -204,6 +205,13 @@ static void pc_system_flash_map(PCMachineState *pcms,
>>               if (kvm_memcrypt_enabled()) {
>>                   flash_ptr = memory_region_get_ram_ptr(flash_mem);
>>                   flash_size = memory_region_size(flash_mem);
>> +
>> +                ret = kvm_memcrypt_save_reset_vector(flash_ptr, flash_size);
>> +                if (ret) {
>> +                    error_report("failed to locate and/or save reset vector");
>> +                    exit(1);
>> +                }
>> +
>>                   ret = kvm_memcrypt_encrypt_data(flash_ptr, flash_size);
>>                   if (ret) {
>>                       error_report("failed to encrypt pflash rom");
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index b4174d941c..f74cfa85ab 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -247,6 +247,22 @@ bool kvm_memcrypt_enabled(void);
>>    */
>>   int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
>>   
>> +/**
>> + * kvm_memcrypt_set_reset_vector - sets the CS/IP value for the AP if SEV-ES
>> + *                                 is active.
>> + */
>> +void kvm_memcrypt_set_reset_vector(CPUState *cpu);
>> +
>> +/**
>> + * kvm_memcrypt_save_reset_vector - locates and saves the reset vector to be
>> + *                                  used as the initial CS/IP value for APs
>> + *                                  if SEV-ES is active.
>> + *
>> + * Return: 1 SEV-ES is active and failed to locate a valid reset vector
>> + *         0 SEV-ES is not active or successfully located and saved the
>> + *           reset vector address
>> + */
>> +int kvm_memcrypt_save_reset_vector(void *flash_prt, uint64_t flash_size);
>>   
>>   #ifdef NEED_CPU_H
>>   #include "cpu.h"
>> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
>> index 98c1ec8d38..5198e5a621 100644
>> --- a/include/sysemu/sev.h
>> +++ b/include/sysemu/sev.h
>> @@ -18,4 +18,7 @@
>>   
>>   void *sev_guest_init(const char *id);
>>   int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
>> +int sev_es_save_reset_vector(void *handle, void *flash_ptr,
>> +                             uint64_t flash_size, uint32_t *addr);
>> +
>>   #endif
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 6f18d940a5..10eaba8943 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1912,6 +1912,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
>>       }
>>       /* enabled by default */
>>       env->poll_control_msr = 1;
>> +
>> +    kvm_memcrypt_set_reset_vector(CPU(cpu));
>>   }
>>   
>>   void kvm_arch_do_init_vcpu(X86CPU *cpu)
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 5055b1fe00..6ddefc65fa 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -70,6 +70,19 @@ struct SevGuestState {
>>   #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>>   #define DEFAULT_SEV_DEVICE      "/dev/sev"
>>   
>> +/* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
>> +#define SEV_INFO_BLOCK_GUID \
>> +    "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
>> +
>> +typedef struct __attribute__((__packed__)) SevInfoBlock {
>> +    /* SEV-ES Reset Vector Address */
>> +    uint32_t reset_addr;
>> +
>> +    /* SEV Information Block size and GUID */
>> +    uint16_t size;
>> +    char guid[16];
>> +} SevInfoBlock;
>> +
> 
> Is that all signed off and happy from the OVMF guys?

Yes, upstream already.

> 
>>   static SevGuestState *sev_guest;
>>   static Error *sev_mig_blocker;
>>   
>> @@ -833,6 +846,44 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>>       return 0;
>>   }
>>   
>> +int
>> +sev_es_save_reset_vector(void *handle, void *flash_ptr, uint64_t flash_size,
>> +                         uint32_t *addr)
>> +{
>> +    SevInfoBlock *info;
>> +
>> +    assert(handle);
>> +
>> +    /*
>> +     * Initialize the address to zero. An address of zero with a successful
>> +     * return code indicates that SEV-ES is not active.
>> +     */
>> +    *addr = 0;
>> +    if (!sev_es_enabled()) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Extract the AP reset vector for SEV-ES guests by locating the SEV GUID.
>> +     * The SEV GUID is located 32 bytes from the end of the flash. Use this
>> +     * address to base the SEV information block.
> 
> It surprises me a bit it's at a fixed offset.

It's based on the end of flash having fixed offsets for the reset vector 
code. So going just before those results in a fixed offset for the first 
GUID entry. After that, more entries can be included and accessed based on 
the size value of the structure.

Thanks,
Tom

> 
> Dave
> 
>> +     */
>> +    info = flash_ptr + flash_size - 0x20 - sizeof(*info);
>> +    if (memcmp(info->guid, SEV_INFO_BLOCK_GUID, 16)) {
>> +        error_report("SEV information block not found in pflash rom");
>> +        return 1;
>> +    }
>> +
>> +    if (!info->reset_addr) {
>> +        error_report("SEV-ES reset address is zero");
>> +        return 1;
>> +    }
>> +
>> +    *addr = info->reset_addr;
>> +
>> +    return 0;
>> +}
>> +
>>   static void
>>   sev_register_types(void)
>>   {
>> -- 
>> 2.28.0
>>

