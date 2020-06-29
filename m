Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0DB23134
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2mcAMRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0DB23134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpoAz-00012b-2c
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpoAK-0000Xh-O4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpoAH-0002D8-W0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593415516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nmpdSsAlvNFeF/JXOok5aZ6xjXwxntbv/hkmCphCySQ=;
 b=K2mcAMRsSLOTPCXtIhGtDRBk8ETwI62yiJLmFs3QjqO6eNm6Mwo3YQl9ALSat17mOPFLyj
 J4IQVVpvIWiv0l+1AIXKpdhMi7HYUfuOasKYZozD+wIJQLhjkvlxX/KiqxlvLgKOEW35bp
 OfMdT5WofwesXBaQmaF0uU5iMNjRZAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-896NHH2zPAWFFR4tEEQV0g-1; Mon, 29 Jun 2020 03:25:12 -0400
X-MC-Unique: 896NHH2zPAWFFR4tEEQV0g-1
Received: by mail-wm1-f71.google.com with SMTP id h6so18052583wmb.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nmpdSsAlvNFeF/JXOok5aZ6xjXwxntbv/hkmCphCySQ=;
 b=Io3J3VlbepN7Ip2nDYGJNVBfzbg787KAOdvXxPAqM58QuZ8UhJRiupUgV3SDbIzAtl
 wIIHsjtbQSxwXFVAxeq6K7gP+ndigimxm1q8UkW9RsvF84R7j5Sc8PoWb2eM4tjzDBiB
 Af9ZBsg/iFT6bketMbBDPKf69qGPE0tfXWLI1YlbTiveDSS6B2RXDfU8AOdQ+o0OOWYn
 2atGQFk7IZXE6GGje/OALGLtBdkbsp5XO5gpylLWqli7SNNiS9piUIhbXBFpmZY/Hkxo
 ZTmA6xrglBA3I7n013WEL0BPL5JIGa3bOMDGnyBNpTsHjp+1MwX3wZErXaeYYDGvI2gI
 aAhg==
X-Gm-Message-State: AOAM530w6uCE8hwlOvU3IPpugGj3DmmK82oi+wuYemSXJUdmdNg8WUES
 dWV8E2FIHD5ygrozkQtp5gPwwjrLCzui7Ihifbe6Bsafd3X18qMJnYeFJkMeWO2obNA0awEaB7X
 dNMLUzVmWmia2n44=
X-Received: by 2002:a1c:a181:: with SMTP id
 k123mr15519344wme.172.1593415511223; 
 Mon, 29 Jun 2020 00:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygiRzSAUMU6BXD+FIbWB4C71DdVym1BViwioXSf7HRRbZZGctuRErvZ99reY09TenJeIt3HQ==
X-Received: by 2002:a1c:a181:: with SMTP id
 k123mr15519330wme.172.1593415510994; 
 Mon, 29 Jun 2020 00:25:10 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm14087635wmg.6.2020.06.29.00.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 00:25:10 -0700 (PDT)
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
 <CAFEAcA_EnwYq4je-_OQz22zpxeqcSjaZnP7ieN-CyHC3pJp2Zw@mail.gmail.com>
 <87o8p4rahe.fsf@dusky.pond.sub.org>
 <CAFEAcA_fV4nf8paMXvfo-b+73oZTcEQHtyXV1u2gc9qbrEYc6g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <2541e062-d3c5-fdfd-eeaf-4072ac178b08@redhat.com>
Date: Mon, 29 Jun 2020 09:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fV4nf8paMXvfo-b+73oZTcEQHtyXV1u2gc9qbrEYc6g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/20 5:11 PM, Peter Maydell wrote:
> On Sat, 27 Jun 2020 at 12:53, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> Hi. I've just noticed that this commit added new global-scope
>>> functions to header files without documentation comments, eg
>>>
>>> bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>>
>> They actually have doc comments: next to their definition, just like the
>> functions they replace.
> 
>>> Please could you provide some follow-up patches that document them?
>>> I don't think we have any hope of getting people to follow whatever
>>> the correct new way to create/configure/realize devices is if we
>>> don't document it :-(   [Concrete example: I now have no idea
>>> how this is supposed to work after this patchset.]
>>
>> Please check out my function comments, and if they leave you confused,
>> let's talk about improvements.
> 
> I will have a look at them, but we should move them (wholesale
> with other documentation comments for qdev) to the header files.
> (That we are having this discussion at all demonstrates why -- people
> don't look in the C files for API documentation of functions.)
> The headers are where the API that faces the rest of QEMU should
> be documented; comments in the C files are for people who care
> about the internals of the implementation. "New prototype in a header
> file should have a doc comment" is a standard part of my code review
> I apply to any code which I see going past. We absolutely have not
> been good about documenting our facing-the-rest-of-QEMU functions
> in the past but this is an area where I think we should be raising the bar.
> 
>> I'm content to use comment placement / formatting I dislike to make my
>> code blend in, but I'm not willing to do conversion work from a style I
>> like to style I dislike.  That's a job for someone who won't feel icky
>> afterwards :)
> 
> Fair enough. I'm happy to write some patches to consistently put
> all the qdev doc info into the headers.

As a start I can respin
https://www.mail-archive.com/qemu-devel@nongnu.org/msg593422.html if you
want.


