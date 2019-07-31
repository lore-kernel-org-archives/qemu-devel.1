Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E102C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5154D206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5154D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsiLM-0005aA-GL
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 02:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsiKx-00059S-01
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsiKt-0004hy-Vl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:43:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsiKt-0004bK-Od
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:43:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so68298187wrf.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 23:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l8vTbqW3hyEk0D75+yYdZw9Ngp/Qa3NR9oAlOwKHuGk=;
 b=L+OtZKcB2WG1yBdmRdygTjPkqqAF9bT/Ea7KnJOCWZfgf3kh9ese34ewfrHP01IHnP
 Pm6Peadi3NGbR5jl2Kpcj8KTw7zz2snNTCPcAabicmSJWshY7b0ysVtRYDtPNcTkiw7u
 4kk7ww7u+os5J1sHw3315C5jy5EnNYP1AKBmrR+HldH6smpHDBeLap8/JlJHvAKUDTds
 Pmapk0PNEws+mmm1LSAdikiugTldgh5R1QIX09K6FjXRH/DidepwqpgU7OAUN9cjgo5d
 59Zo7DMfmBSOFdJjc8O2PstIwoXsx+PNOR8Z9HUrsZKMKiTVdONDG1pOvG333dytt6ts
 Kp5g==
X-Gm-Message-State: APjAAAUfslDKpLkB/g9rXo0lTWzJV/C7CgSwfSpB9ovIaCni0fNnrxOY
 UqzIOwB04C5dyKS/IvUlPOt2fQ==
X-Google-Smtp-Source: APXvYqxiHZp5K1A1yUX5cE0Q2vmkmpwOiBqzcf4R1Db0pNiRcCb0CEdoQnNGYHnQNZN67wuTsjZKMA==
X-Received: by 2002:a05:6000:1189:: with SMTP id
 g9mr97557501wrx.51.1564555421625; 
 Tue, 30 Jul 2019 23:43:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id b5sm56825303wru.69.2019.07.30.23.43.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 23:43:41 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <87zhku90bd.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ff25a5cb-c62f-a148-8350-2f64b4f7ae4a@redhat.com>
Date: Wed, 31 Jul 2019 08:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhku90bd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/19 08:37, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 30/07/19 15:15, Eric Blake wrote:
>>>> We occasionally give up and use types directly rather than their typedef
>>>> names, flouting the coding style.  This patch does.  Trades messing with
>>>> qemu/typedefs.h for having to write 'struct' a few times.
>>
>> I think Markus made the right call here.  Using "struct Foo;" in headers
>> is a null price to pay if all you need is declaring a pointer-typed
>> field or parameter.
> 
> Eduardo posted a patch to HACKING to clarify this non-usage of typedef
> is okay.
> 
> Should we continue to mandate typedef names elsewhere?  It adds
> cognitive load: you have to decide where to put the typedef, and when
> not to use it.

A lot of libraries we use (especially GLib) use typedefs, so I'd rather
keep them.  Also, a mass replacement would be tens of thousands of
changed lines and not really practical.

>>                      Of course this doesn't apply if you have to embed a
>> struct directly, but then qemu/typedefs.h wouldn't help either.
> 
> Yes, and if this leads to an inclusion cycle, I strongly suspect "fat"
> headers: since you can't embed something in itself, the cycle must
> involve different things, all bunched together in the same header.
> 
>> In general unless you're adding a new subsystem, qemu/typedefs.h should
>> only decrease in size, never increase.
> 
> This series grows it some.  I'll try to avoid that for v2.

Let me review it first. :)  Maybe some of them are good to keep.

Paolo

