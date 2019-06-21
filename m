Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8D521530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8D521530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJ04-00039E-Eb
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heIvE-0001mM-NP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heIvB-0006JH-KI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:45:40 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heIv9-0005zT-OV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:45:37 -0400
Received: by mail-wr1-f54.google.com with SMTP id m3so6488133wrv.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vDmWHqPZAzTY+C7TxAofKOgBepN7iUYOILRu3BI6NUo=;
 b=ugQ9Ec6e7X6SWWcYRWm80YO+sZp9KsW0IrBQQWRbiYcZbshhmPFfY6UIWPC4ihaE/y
 1JyOZ/WmFPgZTk3ca+/kU+gkIcWzzJdRXMhTsltE7Prv18gsDBuKfY79XRXUAw98mrFZ
 wegKOqqtBegAbVSO69FHhlEYn/ckE5olJZUS/efHhk4TRCgQOE4isyToX4c5WSVjfac9
 Z7oWG/NB52IYsN/8dqXpEDsZDkUNAB6UAE9pY6dd5euItioVeO3D/ykvwI+KKIh62pj5
 AAar+K2G0OVb3147TUDU7rbA5h3YixK8Hb8y4N9FUYsJiqvOkGjnm5Nm+jl+CUEHDLvC
 hQpQ==
X-Gm-Message-State: APjAAAVzs7CWFvTpLbFk5UBXRVJL0w/6iafEt3SmeYH09lGuQ+/zdo6B
 mcYOEp/ljJup56krM56MvaVyCCT4ieU=
X-Google-Smtp-Source: APXvYqyYWb0G/dFwT7EkmXg/UBiIeBox5ptx8SFRhIBZ1WEWjX+YVWW/OmW9W2ueJ8olB8I7fVChSA==
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr5380382wrn.278.1561121130919; 
 Fri, 21 Jun 2019 05:45:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id s12sm1745836wmh.34.2019.06.21.05.45.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 05:45:30 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
Date: Fri, 21 Jun 2019 14:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
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

On 21/06/19 14:29, Liran Alon wrote:
>> +    max_nested_state_len = kvm_max_nested_state_length();
>> +    if (max_nested_state_len > 0) {
>> +        assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
>> +        env->nested_state = g_malloc0(max_nested_state_len);
>> +
>> +        env->nested_state->size = max_nested_state_len;
>> +
>> +        if (IS_INTEL_CPU(env)) {
> I think it’s better to change this to: “if (cpu_has_vmx(env))” {
> 
>> +            struct kvm_vmx_nested_state_hdr *vmx_hdr =
>> +                &env->nested_state->hdr.vmx;
>> +
>> +            env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
>> +            vmx_hdr->vmxon_pa = -1ull;
>> +            vmx_hdr->vmcs12_pa = -1ull;
>> +        }
>> +    }
> I think we should add here:
> } else if (cpu_has_svm(env)) {
>     env->nested_state->format = KVM_STATE_NESTED_FORMAT_SVM;
> }

Or even force max_nested_state_len to 0 for AMD hosts, so that
kvm_get/put_nested_state are dropped completely.

Paolo


