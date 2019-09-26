Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D1C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F28217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F28217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQax-0004nQ-6V
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDQZO-0004Gh-Nv
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDQZL-00056v-PQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDQZL-00056h-H6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:15 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 933BA7FDFA
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:00:14 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id s25so814292wmh.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 03:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bauUsjuWbnaoh9t6v22F3ZYtsIzD27+ZQvdIdbZtAzQ=;
 b=kIz1zTGKrRtXMA3PlrycOdj4VGRBv1/mw4iJSG+Y0UQbF46d5MpfwyPyhZ/5qKoZMq
 bT++WLJTTzaEq5Oe4WXVHvev8N/AxCdmHyR+cL02K95+ilBPPq2EAHrm5406IYgYsr7k
 zA5vzDe3z5XSsx2tY9de+wGKpEJeiwRT/HytYEfRIOGHWR2zxXDIf/aHycOz/d0HU8Wt
 VPlyMbBXMDFfvkFVkXnl5MnFtaQZuOd5WibWr4TqaQHxfabpLMWRGhKmzFubVlv1AzWz
 kR3g3RBxlZyTppVR8TKfAfivlB1+/hDM1MeERL28rLDe6eztvQ+ipHjCFQXEy3i4GayV
 7icA==
X-Gm-Message-State: APjAAAXkyWyK0kgNs9gENY4RlZATxc2fHrmaw9IRLHDwPLEoTsiEVpus
 ebjkBWqj85vtWKmcw3GgiJ0DdqnCDzsuB35JoWyRy6eKgf/qW5o/NontPRb96jGojSmN2M7OL1e
 /U6TTUmp0VA0Ww2c=
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2147718wmc.175.1569492013236; 
 Thu, 26 Sep 2019 03:00:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUJlKKK9BlBJ0l4WqLd2937sIyQJ5Mtj2QHIUtiI9HK6ol8zL7n/WztWdMIh5gySQF6M1EHQ==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2147692wmc.175.1569492012939; 
 Thu, 26 Sep 2019 03:00:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id c18sm2716065wrv.10.2019.09.26.03.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 03:00:12 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Maxim Levitsky <mlevitsk@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
 <7c019f3a5236daaa79e67467f64cde212ad05f35.camel@redhat.com>
 <4ed0f9ca-6cd1-fd8e-9abd-4098f85c7f9d@redhat.com>
 <f8a138f8c00df4886045d6771415336a7e43b887.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a8d36ed-4a3b-fd12-303d-fc1ee50b2980@redhat.com>
Date: Thu, 26 Sep 2019 12:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f8a138f8c00df4886045d6771415336a7e43b887.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 11:41, Maxim Levitsky wrote:
>> Thinking more about it, I suppose that saves memory (the same EPT page
>> tables can now be used independent of guest CR0.PG), at the cost of
>> making TLB misses a little slower.
> Don't really understand what you mean. 
> Isn't this always the case that EPT and guest paging
> are independent (at least when no nesting is involved)?

There are two possibilities:

1) emulate CR0.PG=0 with EPT + identity page

- advantage: the EPT pages will be reused once the guest sets CR0.PG=1

- disadvantage: TLB misses have to walk two levels of page tables

2) emulate CR0.PG=0 with EPT disabled.  Similar to ept=0, CR3 will point
to PAE page tables that do the HVA->GPA transition.

- advantage: faster TLB misses

- disadvantage: need to build separate page tables for CR0.PG=1 (EPT
format) and CR0.PG=0 (PAE format), need to "waste" 4k of GPA space for
the identity map

Paolo

