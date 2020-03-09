Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4EDC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2624C24655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZfMOWVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624C24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBL1d-0001A8-D0
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jBKeT-0008JK-HF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jBKeS-0004ED-2R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:49:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jBKeR-0004Ds-TH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583768947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CfLIzdnjtm7Bv8mmIFHmo3xhMtsOAbvU4FZTj+u2X+0=;
 b=hZfMOWVYBPljAiwWMBPQE7Rl4Tdq9FwNMjlk0Es6ALSscnv7P4yXBLEhCPyUi02U6yozCv
 TMMcZ57YE9/goBGA4m5qSvahyOrJlg+iA6eMKOE5PXKN/hksqBEvPiRDjyULRQE47x+wcy
 5esVpjwGEMdvI11DyBAlIoQ1osWjFUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-PIkpW0DUNHeTuFC_S8du6g-1; Mon, 09 Mar 2020 11:49:05 -0400
X-MC-Unique: PIkpW0DUNHeTuFC_S8du6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A168017CC;
 Mon,  9 Mar 2020 15:49:04 +0000 (UTC)
Received: from [10.36.118.226] (unknown [10.36.118.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3EE5C3F8;
 Mon,  9 Mar 2020 15:49:01 +0000 (UTC)
Subject: Re: [PATCH v7 02/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-3-frankja@linux.ibm.com>
 <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
 <ce634e32-a38f-056d-9cf9-76455fdab5d1@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <7f975689-5fc3-02d4-3fd9-2703102ecadf@redhat.com>
Date: Mon, 9 Mar 2020 16:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ce634e32-a38f-056d-9cf9-76455fdab5d1@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>>
>>> +    CPUS390XState *env;
>>>  
>>>      /* get the reset parameters, reset them once done */
>>>      s390_ipl_get_reset_request(&cs, &reset_type);
>>> @@ -327,9 +411,16 @@ static void s390_machine_reset(MachineState *machine)
>>>      /* all CPUs are paused and synchronized at this point */
>>>      s390_cmma_reset();
>>>  
>>> +    cpu = S390_CPU(cs);
>>> +    env = &cpu->env;
>>
>> Can you just pass "cpu" to s390_pv_prepare_reset() and handle it in there?
> 
> Wouldn't it make more sense to test the machine state here anyway?

Whatever you prefer. Just saying, that introducing "CPUS390XState *env"
in this function can be avoided.

> 
>>
>>> +
>>>      switch (reset_type) {
>>>      case S390_RESET_EXTERNAL:
>>>      case S390_RESET_REIPL:
>>> +        if (ms->pv) {
>>> +            s390_machine_unprotect(ms);
>>> +        }
>>> +
>>>          qemu_devices_reset();
>>>          s390_crypto_reset();
>>>  
>>> @@ -337,22 +428,52 @@ static void s390_machine_reset(MachineState *machine)
>>>          run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>>>          break;
>>>      case S390_RESET_MODIFIED_CLEAR:
>>> +        /*
>>> +         * Susbsystem reset needs to be done before we unshare memory
>>> +         * and loose access to VIRTIO structures in guest memory.
>>> +         */
>>> +        subsystem_reset();
>>> +        s390_crypto_reset();
>>> +        s390_pv_prepare_reset(env);
>>>          CPU_FOREACH(t) {
>>>              run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>>>          }
>>> -        subsystem_reset();
>>> -        s390_crypto_reset();
>>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>>          break;
>>>      case S390_RESET_LOAD_NORMAL:
>>> +        /*
>>> +         * Susbsystem reset needs to be done before we unshare memory
>>> +         * and loose access to VIRTIO structures in guest memory.
>>> +         */
>>> +        subsystem_reset();
>>> +        s390_pv_prepare_reset(env);
>>>          CPU_FOREACH(t) {
>>>              if (t == cs) {
>>>                  continue;
>>>              }
>>>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>>>          }
>>> -        subsystem_reset();
>>>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>>> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>> +        break;
>>> +    case S390_RESET_PV: /* Subcode 10 */
>>> +        subsystem_reset();
>>> +        s390_crypto_reset();
>>> +
>>> +        CPU_FOREACH(t) {
>>> +            if (t == cs) {
>>> +                continue;
>>> +            }
>>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>>> +        }
>>> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>>> +
>>> +        if (s390_machine_protect(ms)) {
>>> +            s390_machine_inject_pv_error(cs);
>>> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>> +            return;
>>> +        }
>>> +
>>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>
>> [...]
>>
>>>  
>>> +#if !defined(CONFIG_USER_ONLY)
>>> +static bool machine_is_pv(MachineState *ms)
>>> +{
>>> +    Object *obj;
>>> +
>>> +    /* we have to bail out for the "none" machine */
>>> +    obj = object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
>>> +     if (!obj) {
>>> +        return false;
>>> +    }
>>> +    return S390_CCW_MACHINE(obj)->pv;
>>
>> Maybe you want to cache the machine, so you can avoid the
>> lookup+conversion on every new CPU.
> 
> Christian has provided me with a fix to this code, I'll squash it.
> 
>>
>>> +}
>>> +#endif
>>
>> [...]
>>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>>>                                uintptr_t ra, bool write)
>>>  {
>>> +    /* Handled by the Ultravisor */
>>> +    if (env->pv) {
>>> +        return 0;
>>> +    }
>>>      if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>>          return -1;
>>> @@ -93,6 +101,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>>          return;
>>>      }
>>>  
>>> +    if (subcode > 7 && !s390_has_feat(S390_FEAT_UNPACK)) {
>>
>>> = DIAG308_PV_SET
> 
> ?

Instead of the magic number seven, check against "subcode >= DIAG308_PV_SET"

-- 
Thanks,

David / dhildenb


