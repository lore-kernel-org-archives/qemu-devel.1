Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA4BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F05206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F05206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsViA-0005B1-PG
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsVhl-0004gW-0p
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsVhj-0004TC-SN
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:14:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsVhj-0004QH-Mc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:14:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16717466wrr.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jaUSv3VJf+V+ChRyECDPLwYXei53onF28jWtYlsjjZQ=;
 b=BtbHJeuKj1ZgRmFHigqhJr9KAYiQ2CVqNQyxtogbaR8HSlSOrOMN5vE+B4FQbwfy0Q
 n+IFJOZoyIvBhWjHjLjzBVUFNUq9jc9tPcvgnDVlI9MrlnQzLaTOeFhUbd6UAgW8U+xM
 upGWfj937sctRtjpGjfKRqdk8dR7ZzJqtq4mXMbe4F7iBv0YBCSEZjfJq7IgBtY/2vgK
 vxew1UmkV2sTKWR2n9eamf3me9422p57fVyek6CB778HROR4p9/+KHwPm1LN8SPR6ZfD
 B+XeV0w+k3PcI1+FuH589arTX56AHGcnzro0nM+6a/ghhC0vGEbradiNxFpcWGNR3a63
 Trag==
X-Gm-Message-State: APjAAAUMvq6srxB+2D/RVTyStafiqnK+lXq9LR9t1ILpF6Bcxz6dIG5Q
 xlmkfaCtce4i87Fo15+8KYEo5Q==
X-Google-Smtp-Source: APXvYqyw/SCjqRuMPPC/CHN26txaGhj5ZA2OGT6qHfR/E/Xs0s0/5e9orcuDBRjt7xAFlaqJmkfoxQ==
X-Received: by 2002:adf:e444:: with SMTP id t4mr27910270wrm.262.1564506866578; 
 Tue, 30 Jul 2019 10:14:26 -0700 (PDT)
Received: from [192.168.43.238] (63.red-95-127-155.staticip.rima-tde.net.
 [95.127.155.63])
 by smtp.gmail.com with ESMTPSA id c11sm110206849wrq.45.2019.07.30.10.14.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 10:14:26 -0700 (PDT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7a78ef04-4120-20d9-d5f4-6572c5676344@redhat.com>
 <dc9c2e70-c2a6-838e-f191-1c2787e244f5@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e78f8ce4-3dcf-61b1-1eec-bd28f6ba9b4c@redhat.com>
Date: Tue, 30 Jul 2019 19:14:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dc9c2e70-c2a6-838e-f191-1c2787e244f5@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 7:05 PM, Christian Borntraeger wrote:
> On 30.07.19 18:44, Philippe Mathieu-Daudé wrote:
>> On 7/30/19 6:01 PM, Andrey Shinkevich wrote:
>>> Not the whole structure is initialized before passing it to the KVM.
>>> Reduce the number of Valgrind reports.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>  target/i386/kvm.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index dbbb137..ed57e31 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -190,6 +190,7 @@ static int kvm_get_tsc(CPUState *cs)
>>>          return 0;
>>>      }
>>>  
>>> +    memset(&msr_data, 0, sizeof(msr_data));
>>
>> I wonder the overhead of this one...
> 
> Cant we use designated initializers like in
> 
> commit bdfc8480c50a53d91aa9a513d23a84de0d5fbc86
> Author:     Christian Borntraeger <borntraeger@de.ibm.com>
> AuthorDate: Thu Oct 30 09:23:41 2014 +0100
> Commit:     Paolo Bonzini <pbonzini@redhat.com>
> CommitDate: Mon Dec 15 12:21:01 2014 +0100
> 
>     valgrind/i386: avoid false positives on KVM_SET_XCRS ioctl
> 
> and others?

Is the compiler smart enough to figure out it doesn't need to zeroes in
case env->tsc_valid is true and the function returns?

> 
> This should minimize the impact. 
>>
>>>      msr_data.info.nmsrs = 1;
>>>      msr_data.entries[0].index = MSR_IA32_TSC;
>>>      env->tsc_valid = !runstate_is_running();
>>> @@ -1706,6 +1707,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>  
>>>      if (has_xsave) {
>>>          env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
>>> +        memset(env->xsave_buf, 0, sizeof(struct kvm_xsave));
>>
>> OK
>>
>>>      }
>>>  
>>>      max_nested_state_len = kvm_max_nested_state_length();
>>> @@ -3477,6 +3479,7 @@ static int kvm_put_debugregs(X86CPU *cpu)
>>>          return 0;
>>>      }
>>>  
>>> +    memset(&dbgregs, 0, sizeof(dbgregs));
>>
>> OK
>>
>>>      for (i = 0; i < 4; i++) {
>>>          dbgregs.db[i] = env->dr[i];
>>>      }
>>
>> We could remove 'dbgregs.flags = 0;'
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
> 

