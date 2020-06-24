Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A05BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5AB20874
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL8stDfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1fv-0003Mj-63
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo1fJ-0002QQ-T1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:25:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo1fI-0005NN-7i
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:25:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id t194so1821173wmt.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oo3NMf7YK9TEG2D/rJAxpKuy2vCrq7uNo0yHsjEUIOs=;
 b=ZL8stDfkpS+mH43RXiiL+mzk0SeRJrmV94v51yFQT9xIOI+fMIeHt2oe0wIoDrnNFZ
 2QKo31YtIKkoXLk8NsEMDTedDa9V4aADXlsoXv+oTczrIM+PecOxGM28V24c5l1pp64A
 fGbQtyGekIy9kPNNGfFGdsLBAq64PAVmeqMpkTvqfI0eUfDEd4u+AOEfi7KNzYj7J5Kp
 T5z/k8kr/SD3FvFHJz2FboFpvjBCakt8+DBsDZd+1vmK9nIC7QmCUQO3aTMGstvQyBSi
 x4wqliqfJKrm1r4hcAvFtkKfRA8nAGUz+U/S45cE0eOSloJJPGptY3/A25kAFvEd0d/q
 ycQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Oo3NMf7YK9TEG2D/rJAxpKuy2vCrq7uNo0yHsjEUIOs=;
 b=rujc343PC4GSSkebHa6aSnovvjGeoY1JGIkTOndwgQHvD7YT8ocdhvuAiS3cQ1Ga5y
 SsLi70UT6Z9b5YHY4+xF+Gmf8fp8tF0S/4qF5n33+QB9IB5LK/NOgEBj4U4IChoMZtuv
 Ef2Dh4/kQv6WZTr3CFuyrowokYNa6jMHKRyNyBCGaJT2evJbx/QEIVGS3vX/KME7o/KR
 u0y3t25ExV/amk1N7Ghetlh6AwQrXVrY7yPni+2i2TzRx/noGAwKT+3dezieDIRdhnA9
 fDRaymg5RH+Rh6xa0BIYbjhVeaJbDKQ6B/GrUB+hqJPL2t4OaHBVqX+P2wdKTTSXq7k4
 VQVQ==
X-Gm-Message-State: AOAM530/CJBFzTiYRY6zbn/8gQsNZ41bcRvB1ESrjtJ7RkswOhDfti49
 SS180LXgW4VwMF6A+zRup0M=
X-Google-Smtp-Source: ABdhPJwRHOiynY4hIl7pm3RkaONc4R90nLpUmSw7jLREkSTgBOgLkWvz6FSREG90fdLR3EsI2W2zcQ==
X-Received: by 2002:a1c:7fd7:: with SMTP id
 a206mr21508570wmd.104.1592990754330; 
 Wed, 24 Jun 2020 02:25:54 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v7sm26550067wrp.45.2020.06.24.02.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 02:25:53 -0700 (PDT)
Subject: Re: [PATCH] ibex_uart: fix XOR-as-pow
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20200623195441.14646-1-pbonzini@redhat.com>
 <e47cdd98-ee3f-a222-5bc9-6f8f7085584f@redhat.com>
 <8635411c-d3c0-6d26-c068-4fa02de98df9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <5c9a8ccb-29d5-cf06-f8c5-2dce5ff3a2f2@amsat.org>
Date: Wed, 24 Jun 2020 11:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8635411c-d3c0-6d26-c068-4fa02de98df9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 8:33 AM, Paolo Bonzini wrote:
> On 23/06/20 22:07, Eric Blake wrote:
>>>
>>>              uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
>>>               baud *= 1000;
>>> -            baud /= 2 ^ 20;
>>> +            baud >>= 20;
>>
>> Dividing by 1M instead of 22 seems much more logical, indeed :)
> 
> Based on the spec, the "* 1000" is the clock, in other words this is a
> fixed point value relative to the clock:
> 
> f_baud = NCO * f_clock / 2^20
> 
> The example in the spec (https://docs.opentitan.org/hw/ip/uart/doc/) has
> f_clock = 50 MHz, while here it's only 1 kHz.  And the register is only
> 16 bit, so the above would only allow a baud rate up to 62 (65535 * 1000
> / 2^20).
> 
> Should the clock be a property of the device instead?

Ideally the device should use qdev_get_clock_in(),
(see docs/devel/clocks.rst):

  static void ibex_uart_init(Object *obj)
  {
     ...
     s->f_clk = qdev_get_clock_in(DEVICE(obj), "f_clock");
     ...

Then in ibex_uart_write():

     uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
     baud *= clock_get_hz(dev->f_clk));
     baud >>= 20;

Devices not using the QDEV_CLOCK API use QDEV properties.

> 
> Thanks,
> 
> Paolo
> 
>> It's odd that we are scaling up by 1000, down by 1024*1024, then
>>
>>>                 s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10; 
> 
> 


