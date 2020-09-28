Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15398C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5540E208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVExH6M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5540E208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxSF-0004sJ-8s
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMxQI-0003Bi-1N
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMxQG-0003uA-0e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:58:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601315925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=guPH8AW1Y6Mr9jRvkB4BNQX8jhbk097qDQxuuDDvkPo=;
 b=cVExH6M/5B4nlnb2A/XsH1HdloknOIWLyxRuVq7MZE2FJsMEN5k7tBQF4QRFYgnlbW3p3H
 xT6LT6lQAhYrNxAJeDYzlKrvdLg0f9T25DtS2sRujuAxz0jKew3ts9Wdbn3gZ8ggJpqzll
 ozCaMQiG7ovAbXqvME2rml6mi5m9VzM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-A1mM0oNsPbeOs37Q611wOQ-1; Mon, 28 Sep 2020 13:58:42 -0400
X-MC-Unique: A1mM0oNsPbeOs37Q611wOQ-1
Received: by mail-wm1-f71.google.com with SMTP id m19so676030wmg.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=guPH8AW1Y6Mr9jRvkB4BNQX8jhbk097qDQxuuDDvkPo=;
 b=KbaSH0OmKK+pKvbsfkEB8ZDtBn6qRBE99TMIpg+5FMbiDIuNELB73djfBdWPQDK2zz
 lOZV9IauNBpMI7fyBj1pLzl4ifoJ2laUGXdBLccavvuCgQ3KBOP+jPaXdx5C5IiIMSH+
 BDGuLucC3saPDYBYd/lfu0Vc50LpQ7ApVhqEJxAemTgvm5iqsR48KL3tLe+fCf8229US
 Hqa50+AUUpW3h4dPh8y6WJV9q/wdlGBUX6KxV8svSY7v/HTtNexHI2pJNPEsZ6rWLiaj
 8DPQXCAUKOZWypE/tQMmafcOI/vsIA3t5D4fqajVtoqfvACcAXtrL1GGCmo0VmeXXDgb
 ey6A==
X-Gm-Message-State: AOAM532QrrZPRMQMPGLQ4QbL9Pp3iRUibfebXbpbCids6ZKPUgGMbzm8
 nhg2aApX4+cbQg1IUcfNflEUKSjmZnNTqGTyXK6FxjD8BEILioDMS6CfoiGQ66J17Wkf0HuLzvY
 aCHSBJnWcSrccMOQ=
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr339651wmf.75.1601315920862; 
 Mon, 28 Sep 2020 10:58:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKCgqKYu6icv+F4iwwq8FG2Ua6SH+sLpt8c3ev6iWma0bn+bzhtha8xfIVgfmUOiS97LHRRw==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr339629wmf.75.1601315920605; 
 Mon, 28 Sep 2020 10:58:40 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id e7sm2460937wrm.6.2020.09.28.10.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 10:58:40 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] qemu/bswap: Use compiler __builtin_bswap() on
 FreeBSD
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-7-philmd@redhat.com>
 <8d50a945-a6f6-b1f4-392a-867360c50882@redhat.com>
 <c9769c3c-3857-c063-e22b-f7aa795795a8@redhat.com>
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
Message-ID: <9b45c9b7-3ee2-4afa-a413-8f0be2cdd7f2@redhat.com>
Date: Mon, 28 Sep 2020 19:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c9769c3c-3857-c063-e22b-f7aa795795a8@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:57 PM, Philippe Mathieu-Daudé wrote:
> On 9/28/20 7:32 PM, Thomas Huth wrote:
>> On 28/09/2020 15.19, Philippe Mathieu-Daudé wrote:
>>> Since commit efc6c070aca ("configure: Add a test for the minimum
>>> compiler version") the minimum compiler version required for GCC
>>> is 4.8, which supports __builtin_bswap().
>>> Remove the FreeBSD specific ifdef'ry.
>>>
>>> This reverts commit de03c3164accc21311c39327601fcdd95da301f3
>>> ("bswap: Fix build on FreeBSD 10.0").
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> Cc: Ed Maste <emaste@freebsd.org>
>>> ---
>>>  include/qemu/bswap.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>> index 719d620bfe6..1a297bfec22 100644
>>> --- a/include/qemu/bswap.h
>>> +++ b/include/qemu/bswap.h
>>> @@ -6,8 +6,6 @@
>>>  #ifdef CONFIG_MACHINE_BSWAP_H
>>>  # include <sys/endian.h>
>>>  # include <machine/bswap.h>
>>> -#elif defined(__FreeBSD__)
>>> -# include <sys/endian.h>
>>
>> Ah, well, no I get it ... you're removing this stuff bit by bit. Quite
>> confusing, IMHO, I'd remove them all in one patch instead.

Actually I thought it would be easier for each OS maintainer to
review the corresponding patch.

> 
> Sure. I did it that way because I was testing OS after OS, when
> one was successful I committed the change and went for the next
> one.
> 
>>
>>  Thomas
>>
> 


