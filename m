Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B7C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2BF208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2BF208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkMd-0004na-7P
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hnkMC-00034Z-At
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hnkMB-0002Mk-7Q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:52:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hnkMB-0002Lb-16
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:52:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so11893425wmc.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lcPKlikHVw0UKOu5w7sujRIctLFD92nRZ7VhRKeyegM=;
 b=pza0iLM4Lp0mXrQsWV0x6yPwg7iFc5lIA9isPu+mLB++2asPbv0ziSjk+QTMkriOuD
 x9gVwK8OhxjJwE2O/UHpgfkZA9yC3DbfzjbfoSUMVeCbC2CBqh4YrRGa6/3ql0/Jl73f
 X0sWWoc18cWDJ+O+at6zcxUpw6pfMRudRGWgttO1AWDRhvUw6oHZH4FYq2VpEDVOD5ab
 6/sNOVb+z+mzXd1E0lCu8j1045DinB1gUdGFdrn9vkv2G8rAA6F1TLKAcgyImdVJGBLj
 x+tRd+3R2eGe6xXwm60b7LWR+fmn8HGMTqtiRJ8hL81e2/m3UALGi5r3q/j6FU62i07B
 JLCA==
X-Gm-Message-State: APjAAAWje4QqB8wm3BHl3gujtfJkmjARbybUYaU6CPI1aIUp90b1seve
 HAC5yDqyC4S+Ktp2zWFxUBqZXw==
X-Google-Smtp-Source: APXvYqziNvMjIbDvojBWsg3svqTFETmwdKblqqmdyZ7n+h7uLvEKvMQxIpRMQJAodFwJVcZlcBVJWA==
X-Received: by 2002:a05:600c:2388:: with SMTP id
 m8mr35524465wma.23.1563371549409; 
 Wed, 17 Jul 2019 06:52:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id h133sm24905915wme.28.2019.07.17.06.52.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 06:52:28 -0700 (PDT)
To: Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-2-philmd@redhat.com>
 <ca528cdc-6118-0b2f-c1b8-30b06875dde8@redhat.com>
 <CAFEAcA-wgTVfj0TUJ=piP0wEgLGiNpOYia5DK2GQAO4Q7gNaWg@mail.gmail.com>
 <6d69e8ad-d720-ce04-20f2-a03193903078@redhat.com>
 <20190715125653.6e65d575.cohuck@redhat.com>
 <c1c68faf-0424-6c7c-e39f-42159457c3ee@redhat.com>
 <20190715130955.4a117388.cohuck@redhat.com>
 <13fce62f-234c-1b13-595f-5910c066bc4f@redhat.com>
 <6c39a198-e951-c0bd-1ddc-5d227afe72ff@redhat.com>
 <87a7dfth4i.fsf@dusky.pond.sub.org>
 <20190715181206.3cb1db93.cohuck@redhat.com>
 <799aa0f5-8850-5caa-5103-e1cf3cdb018f@redhat.com>
 <87h87m2knh.fsf@dusky.pond.sub.org>
 <beb5fe93-991d-ba2b-d2c1-51e01b912dbe@redhat.com>
 <50befb09-d381-4362-9cd1-6fb11c96a719@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <633cc3f7-eb20-1bfe-03d2-e481be188eb1@redhat.com>
Date: Wed, 17 Jul 2019 15:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <50befb09-d381-4362-9cd1-6fb11c96a719@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH 1/3] hw/Kconfig: PCI bus
 implies PCI_DEVICES
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
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "open list:S390" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 14:59, Collin Walling wrote:
> On 7/16/19 11:04 AM, Thomas Huth wrote:
>> On 16/07/2019 15.06, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 15/07/19 18:12, Cornelia Huck wrote:
>>>>>> Is it INTx vs. MSI vs. MSI-X?
>>>>>
>>>>> I think for s390x we need (INTx || MSI) vs MSI-X...
>>>>
>>>> I think MSI vs MSI-X is just how it's configured, not the actual
>>>> behavior, so it should be irrelevant.
>>>
>>> My best guesses from confusing information, please correct
>>> misunderstandings:
>>>
>>> 1. PCI devices need to support MSI or MSI-X to work with s390x.
>>
>> I think Cornelia mentioned that we might even require MSI-X there ...
>> Collin (being listed as "S390 PCI" maintainer), can you confirm?
> 
> MSI-X is mandatory for PCI devices in the s390 architecture.

How are MSI and MSI-X distinguished?

Paolo

