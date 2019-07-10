Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A81C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CF920844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CF920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFZ5-0004Ve-KM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlFY9-00041a-Ks
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlFY8-0006zc-NE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:34:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlFY8-0006yp-Go
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:34:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so3147738wru.10
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s4liC5WiSixEVRe8xXGDYE8exLBkH6qy6qi4hf+f+lo=;
 b=fFJxq9DzuHgLEmjstnlo/GHJZWi4gM4P7PwRUgqiFg+UO3iFaiKxl2sZPN4jEHA8rZ
 bnxNFXkX6Qd1H5O/06LVtk2q+RLogHN1A8wICzw1068SsgIlaFjS4LnuBEf32eLm5Pas
 0c915ceNAO8sUYU5nZL4e6UvTB/wXAyzDZ7S8L70CfUqEvcvyBGliPwu3a+YlY8bl6xM
 kof54QYsVzqhNINL6QNukhljefN5wEmH1DG9331X6HiyLfHs3x+8ydcjZuBGcXGkr8qX
 uDQluqXjIsIrOsvnS1QooO9SYm/DvYpMiPDyr9lJiqDWFEPMBd7qJ9upSgO9kzWSDFHm
 Pc4Q==
X-Gm-Message-State: APjAAAVJBdZ8ChtwGf3Sm5gyVzOb57sVB6+tPRwa0jpeRN9a8xHXPHYz
 dR125WkqX2IetTpVc5KY47fLfg==
X-Google-Smtp-Source: APXvYqzgr6AZhg4mQjdIAd6CiteVQ1yHMOlhGcqvQgHCT56i2pOXPqt2dPx0RaLFWH2PW4X0ngzwkg==
X-Received: by 2002:adf:e343:: with SMTP id n3mr32488332wrj.103.1562776471141; 
 Wed, 10 Jul 2019 09:34:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id x6sm3292081wrt.63.2019.07.10.09.34.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:34:30 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <e253d736-8cf5-0c5c-5766-ee71ad808cfd@siemens.com>
 <7431700b-0bfd-32e6-e9f2-64608f8ba6b9@redhat.com>
 <753cb413-9e8f-581b-8d9e-635dfd30627d@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <479bbda0-17a5-b915-e70b-c2bc23c9ac75@redhat.com>
Date: Wed, 10 Jul 2019 18:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <753cb413-9e8f-581b-8d9e-635dfd30627d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 18:08, Jan Kiszka wrote:
> On 10.07.19 16:40, Paolo Bonzini wrote:
>> On 08/07/19 20:31, Jan Kiszka wrote:
>>>> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
>>>> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
>>>>          error_report("Guest enabled nested virtualization but kernel "
>>>>                  "does not support saving of nested state");
>>>>          return -EINVAL;
>>>>
>>> Starting with this commit latest (bisection issue...), running Jailhouse in a
>>> guest first stalls L1 (looks like we lose interrupts), and if I try to reset
>>> that VM, I lose my host as well:
>>
>> If 5.2 is still broken, can you gather a dump of KVM_SET_NESTED_STATE's
>> payload?
> 
> savevm or is there a dump function in QEMU or the kernel?

There is qemu_hexdump.

Paolo

