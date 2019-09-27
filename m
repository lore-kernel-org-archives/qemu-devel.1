Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8737B207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8737B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDq26-0001gM-EU
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDpk3-0002zg-WC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDpk1-0001QN-Gq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDpk1-0001PO-7d; Fri, 27 Sep 2019 08:52:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 590CF89810A;
 Fri, 27 Sep 2019 12:47:15 +0000 (UTC)
Received: from [10.36.116.169] (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B97F5D6A7;
 Fri, 27 Sep 2019 12:47:14 +0000 (UTC)
Subject: Re: [PATCH v3 08/18] target/s390: Return exception from
 mmu_translate_real
From: David Hildenbrand <david@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-9-richard.henderson@linaro.org>
 <73b5d922-a7b1-ac62-3195-f0e35a6478b3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <02b2eb7b-3726-6cbc-e0a8-cc98f7675274@redhat.com>
Date: Fri, 27 Sep 2019 14:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <73b5d922-a7b1-ac62-3195-f0e35a6478b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 27 Sep 2019 12:47:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.09.19 12:44, David Hildenbrand wrote:
> On 26.09.19 18:26, Richard Henderson wrote:
>> Do not raise the exception directly within mmu_translate_real,
>> but pass it back so that caller may do so.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/s390x/internal.h    | 2 +-
>>  target/s390x/excp_helper.c | 4 ++--
>>  target/s390x/mmu_helper.c  | 8 ++++----
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
>> index c243fa725b..c4388aaf23 100644
>> --- a/target/s390x/internal.h
>> +++ b/target/s390x/internal.h
>> @@ -362,7 +362,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
>>  int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>>                    target_ulong *raddr, int *flags, bool exc);
>>  int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>> -                       target_ulong *addr, int *flags);
>> +                       target_ulong *addr, int *flags, uint64_t *tec);
>>  
>>  
>>  /* misc_helper.c */
>> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
>> index ab2ed47fef..906b87c071 100644
>> --- a/target/s390x/excp_helper.c
>> +++ b/target/s390x/excp_helper.c
>> @@ -147,8 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>          if (!(env->psw.mask & PSW_MASK_64)) {
>>              vaddr &= 0x7fffffff;
>>          }
>> -        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
>> -        excp = 0; /* exception already raised */
>> +        excp = mmu_translate_real(env, vaddr, access_type, &raddr, &prot, &tec);
>> +        fail = excp;
>>      } else {
>>          g_assert_not_reached();
>>      }
>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>> index 3ef40a37a7..b783c62bd7 100644
>> --- a/target/s390x/mmu_helper.c
>> +++ b/target/s390x/mmu_helper.c
>> @@ -523,10 +523,10 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
>>   * @param rw     0 = read, 1 = write, 2 = code fetch
>>   * @param addr   the translated address is stored to this pointer
>>   * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
>> - * @return       0 if the translation was successful, < 0 if a fault occurred
>> + * @return       0 = success, != 0, the exception to raise
>>   */
>>  int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>> -                       target_ulong *addr, int *flags)
>> +                       target_ulong *addr, int *flags, uint64_t *tec)
>>  {
>>      const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
>>  
>> @@ -535,8 +535,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>>          /* see comment in mmu_translate() how this works */
>>          *flags |= PAGE_WRITE_INV;
>>          if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
>> -            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
>> -            return -EACCES;
>> +            *tec = 0;
>> +            return PGM_PROTECTION;
>>          }
>>      }
>>  
>>
> 
> Note that
> 
> [PATCH v1 2/5] s390x/mmu: Implement ESOP-2 and
> access-exception-fetch/store-indication facility
> 
> also messes with the tec (which is okay), but also with the ILEN on
> instruction fetches.

I'll drop the ilen change from that patch, now that I figured out how it
works :)

-- 

Thanks,

David / dhildenb

