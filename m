Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED21C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCDD20706
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWSuVi2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCDD20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfGY-0000oL-9I
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnfFf-0000G8-9p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:29:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnfFc-0007MV-Nd
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592904595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yuYLlLgvyrJeXUSy4NWBnp41zSw2A25KjBbHFWApQ5E=;
 b=dWSuVi2McwbXYaMRtboIlFtw+MAs3L5EV53cneC12EBLtXBFe+BrSVnwdaEwHAjeAdLSXb
 DKnoCClG8yMqBv8kSWpRDOSs9IOLrfrFIqh689PwdjFA9Yf6stQhhZ/E041iHSjo5MCKbw
 qCbK1DlE6a/wVj2Wj/qSczWQw8BuVsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-O_xrBGShMIqXUJXeAz2dRQ-1; Tue, 23 Jun 2020 05:29:54 -0400
X-MC-Unique: O_xrBGShMIqXUJXeAz2dRQ-1
Received: by mail-wm1-f72.google.com with SMTP id r1so3324488wmh.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yuYLlLgvyrJeXUSy4NWBnp41zSw2A25KjBbHFWApQ5E=;
 b=Ls9B9U1G/YXJ91oJDDclLVVYIv8A3ydq8z3Qb7PK6nd+eaP2tfj/oDsKZD2Nf18h1e
 fJpS/ko9CejbWdhzmZip+IysRsxaLc6wE9Q/7TChiF0cxXomi7qlrsGjNHrkMv5IECXY
 TKNJi6Aqu1+Bl9JQrTB7ZJHugIO0fW65ZGfYH4crgohe5iXVeAbgbHlTl8ZBrPTvrL4Y
 Y5mazusCIMbYMFYra6LlVsXBBl8NQFsd5L+72cawuQ8fN3WaA6WrL2xeIatgyLCnPkKr
 bMICmkrz8jKIUmkNkHlJFasTSw2r+6499/6B2iAuRl94zwcxoqDmLUMfvQ/+9tfW/4op
 U/Ug==
X-Gm-Message-State: AOAM532CETtYFd+1QSwu5x/98pyhLudTMDQl0nr4lBBI1o6qJtF0yhFN
 Kc8nb3b5EGMmJBpPS1y/aMYNhFzuaeLBU9foFoFVie8pBocrzuaPNRBVPBJUtGqe1X4rliz2t/z
 d4WJHg0jEi4MhHkw=
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr22539761wme.74.1592904592770; 
 Tue, 23 Jun 2020 02:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf4SsUIv3m7W17TCwkn5fbF4otpNtUGOyAFMEQr+waRyNBd8cK83XMfm2mZaML8v1qhPHJCg==
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr22539735wme.74.1592904592564; 
 Tue, 23 Jun 2020 02:29:52 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g25sm2802178wmh.18.2020.06.23.02.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 02:29:52 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] target/arm: Fix using pmu=on on KVM
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
References: <20200623090622.30365-1-philmd@redhat.com>
 <20200623091807.vlqy53ckagcrhoah@kamzik.brq.redhat.com>
 <CAFEAcA-2-g=ZMMRkxoT-ncxqbdjc5vV1WbFzGXw7R8o7QOb6hQ@mail.gmail.com>
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
Message-ID: <1ec46d92-ae37-0d78-0a5e-7615d91d36b6@redhat.com>
Date: Tue, 23 Jun 2020 11:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2-g=ZMMRkxoT-ncxqbdjc5vV1WbFzGXw7R8o7QOb6hQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 11:19 AM, Peter Maydell wrote:
> On Tue, 23 Jun 2020 at 10:18, Andrew Jones <drjones@redhat.com> wrote:
>>
>> On Tue, Jun 23, 2020 at 11:06:20AM +0200, Philippe Mathieu-Daudé wrote:
>>> Since v2:
>>> - include Drew test fix (addressed Peter review comments)
>>> - addressed Drew review comments
>>> - collected R-b/A-b
>>>
>>> Andrew Jones (1):
>>>   tests/qtest/arm-cpu-features: Add feature setting tests
>>>
>>> Philippe Mathieu-Daudé (1):
>>>   target/arm: Check supported KVM features globally (not per vCPU)
>>>
>>>  target/arm/kvm_arm.h           | 21 ++++++++-----------
>>>  target/arm/cpu.c               |  2 +-
>>>  target/arm/cpu64.c             | 10 ++++-----
>>>  target/arm/kvm.c               |  4 ++--
>>>  target/arm/kvm64.c             | 14 +++++--------
>>>  tests/qtest/arm-cpu-features.c | 38 ++++++++++++++++++++++++++++++----
>>>  6 files changed, 56 insertions(+), 33 deletions(-)
>>>
>>> --
>>> 2.21.3
>>>
>>>
>>
>> Hi Phil,
>>
>> Thanks for including the test patch. To avoid breaking bisection, if one
>> were to use qtest to bisect something, then the order of patches should
>> be reversed.

Oops :)

>> I guess Peter can apply them that way without a repost
>> though.
> 
> Yeah, I can just flip the order.

Thanks both!


