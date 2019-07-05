Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8EC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 23:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F384220863
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 23:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F384220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56895 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjXHe-0007XA-BS
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjWuQ-0000dM-3P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjWuO-0004Kz-Sr
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:42:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjWuO-0004KI-M6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:42:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so3759895wmg.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 15:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WbT8uddacS0MBsLdGmYorxeWsRGrlw65adq5Yikgh7Q=;
 b=pbKlR5K5AUhAGymJsWyweRu4RO+gAhl6RcsQdb8KMlwC4yTKCdwAXRFEpOzCLIu3qD
 O1ByPrPll1iE8/uhBmwjppNk4P0FWqA5qpLDZWLhyNq5d0Z4OviUUTXmR/lJoaqz7EcN
 QaasimhJLM2+XLwa6z7fMXU0GCDVZvR/qXNn9Vbe5DNg2BXDw1h4LYQdMAOAREGEcNNk
 2c+MbdnqSgKkbQyLoFg5+6CRkewT/XZQHzRvGgIukQgT3p89fla8sYWCCr2iZc4vB/xf
 E7Qox2DE6H+qnIurdRFCgdssn9mnN3U8ZTK9Uqu+sQrwBFqry17MdaeBMr+8u89eHw6H
 /4gA==
X-Gm-Message-State: APjAAAW2w6KkEFwKK4VSLHAXf69y2N4Bas2yu+/kAP8yDF+MUOeB/fC2
 y+jMWMtO9GSdr0dihpPRP7EXYA==
X-Google-Smtp-Source: APXvYqzeCo4L6f6LHpoYFhUbGgmsJBWyyOpFBbl08JEHh4/Bf9dmtuN/tgls3y/DCnl1AMJKBcF48A==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr5055283wma.90.1562366543536; 
 Fri, 05 Jul 2019 15:42:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id p4sm10293875wrs.35.2019.07.05.15.42.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 15:42:22 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-7-git-send-email-pbonzini@redhat.com>
 <20190705212249.GG5198@habkost.net>
 <6262c798-fc94-5100-8836-e3cbea306282@redhat.com>
 <20190705223329.GL5198@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea52e4c3-2553-b778-2b25-6a460fd67967@redhat.com>
Date: Sat, 6 Jul 2019 00:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705223329.GL5198@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 6/7] target/i386: add VMX features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/07/19 00:33, Eduardo Habkost wrote:
> Oh, that's the info I was missing.  I always expected
> kvm_arch_get_supported_*() to be subject to change (depending on
> KVM and hardware capabilities), and not be part of guest ABI.

For most bits that's true.  Just not for these ones, because they are
integer values rather than bit flags.

The reason for the complex rules is that you need to know what is a
flag, what is a fixed value that the guest uses, and what is a maximum
supported value.  Simpler userspace than QEMU can just use the defaults
since they don't care about maintaining the guest ABI.

> Now, if KVM is going to to implement the guest ABI guarantee at
> KVM_GET_MSRS, that's OK.  Is this going to be obvious to people
> touching KVM_GET_MSRS in the future?
> 
> What if we do want the guest ABI to change in the future?  How do
> you expect QEMU to ask KVM to enable the new guest ABI?  How do
> you expect the user to ask QEMU to enable the new guest ABI?

That would be with ioctl(KVM_ENABLE_CAP) for KVM, and with -cpu for QEMU.

>> - KVM could change bits 16-24, but it always allows writing a value that
>> is _smaller_ than the one you read.  So I'm zeroing those, ensuring no
>> future ABI changes.
>>
>> - KVM could in theory change bits 25-27: here it also allows writing a
>> value that is smaller than the one you read, so guest ABI is preserved.
>>  Such a change is very unlikely, all Intel silicon has always had 0
>> here.  But I can change the code to zero these three bits just like bits
>> 16-24.
> 
> The complex rules above make me a bit nervous.  Can we at least
> make QEMU validate the values returned by
> kvm_arch_get_supported_msr_feature() to catch ABI-breaking
> mistakes in the future?

I don't know... I'm a bit wary of adding hard-coded values in QEMU,
userspace simply should not care.  But I can add comments to KVM to
remind people of values that should not be changed.

Paolo

