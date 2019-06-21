Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C7BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC40A206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC40A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLDB-0007Fq-Vb
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heKwW-0004ZB-T4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heKwV-0004S3-QQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:55:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heKwV-0004Qs-JF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:55:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so6905724wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4S4Tn/hIzBHcSLcIYO6lsh0V1lHzJoy8WrKzb4zNunA=;
 b=qjOrMr2mkkL6AR4Rd0BCWRKOLxCVY8UQqjz8bC0m3j9FzmKAtVAqHJN5UELyj+C2Kd
 1WUy9ABOdeqibgMnW9o4+Q3bPMi2f5zbOCgcq+wDcRVm4tWzeGiwPkYIwvrnTuF9UxHz
 y05cL8QMUsL6BLdMxEXkrVXqkYWGIbaFdbCMcq1KZOJMwlHhgiN85J4SQYI9aWTthHnq
 /Pb5iMOrqmNCSYShklQPDRwGDDnJq+czCHAMSoMP6gxi20eSDoJueFhvwSU4BF5NlXJ+
 e2jLJsEodZ4zRh5/IO6WSBs5Yp0DMFRCc/JonXWVHb0/8nNz8I6RicWh7fCBmQYgr8wA
 EYuw==
X-Gm-Message-State: APjAAAUD9TqPX1bavpHZs+p4UwctMoD1CS5xysK+qQp9TYL06jEOb1cw
 OPZy/OANrpcoc2t+xpnEkuDgi0sBYRo=
X-Google-Smtp-Source: APXvYqzOU9XeVPcyu2iDGPp1FgOGE84RlZlPg9eEK/hTV0d4xV9ubAudWSvB/uzhpkSYmk/o4FutEw==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr4484053wmi.140.1561128905480; 
 Fri, 21 Jun 2019 07:55:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id c17sm1809463wrv.82.2019.06.21.07.55.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 07:55:04 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
 <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
 <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
Date: Fri, 21 Jun 2019 16:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for
 save and restore nested state
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

On 21/06/19 14:48, Liran Alon wrote:
> 
> 
>> On 21 Jun 2019, at 15:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 21/06/19 14:29, Liran Alon wrote:
>>>> +    max_nested_state_len = kvm_max_nested_state_length();
>>>> +    if (max_nested_state_len > 0) {
>>>> +        assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
>>>> +        env->nested_state = g_malloc0(max_nested_state_len);
>>>> +
>>>> +        env->nested_state->size = max_nested_state_len;
>>>> +
>>>> +        if (IS_INTEL_CPU(env)) {
>>> I think it’s better to change this to: “if (cpu_has_vmx(env))” {
>>>
>>>> +            struct kvm_vmx_nested_state_hdr *vmx_hdr =
>>>> +                &env->nested_state->hdr.vmx;
>>>> +
>>>> +            env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
>>>> +            vmx_hdr->vmxon_pa = -1ull;
>>>> +            vmx_hdr->vmcs12_pa = -1ull;
>>>> +        }
>>>> +    }
>>> I think we should add here:
>>> } else if (cpu_has_svm(env)) {
>>>    env->nested_state->format = KVM_STATE_NESTED_FORMAT_SVM;
>>> }
>>
>> Or even force max_nested_state_len to 0 for AMD hosts, so that
>> kvm_get/put_nested_state are dropped completely.
>>
>> Paolo
>>
> 
> On AMD hosts, KVM returns 0 for KVM_CAP_NESTED_STATE because
> Kvm-and.ko have kvm_x86_ops->get_nested_state set to NULL.
> See kvm_vm_ioctl_check_extension().

Yes, now it does, my idea was to force that behavior in QEMU until we
know what SVM support actually looks like.

In principle I don't like the idea of crossing fingers, even though
there's an actual possibility that it could work.  But it couldn't be
worse than what we have now, so maybe it *is* actually a good idea, just
with some comment that explains the rationale.

Paolo


> I just thought it will be nicer to add what I proposed above as when kernel adds support
> for nested state on AMD host, QEMU would maybe just work.
> (Because maybe all state required for AMD nSVM is just flags in env->nested_state->flags).
> 
> -Liran
> 


