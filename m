Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E8C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CE7217BA
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRCVGDHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE7217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHQRO-0004QO-Sy
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 07:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQOy-0002Jf-TD
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:42:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54549
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQOx-0003mn-2u
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599997354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YzzUzExnk4lJrfqWcFFqxb4T2DLOs+soNXtK6RFCLak=;
 b=GRCVGDHfuWMO81wlzQ1LLMYQFc/trbc16RKmDQTR4zy6dlgsfRzCIboecGb9IVgfpOr2Ax
 ZJ8feW+7z+ljARGixKq3blrx29XBWRbK/9+3aTJ+VcFun3hynlRioMLobfN61QoqkALFoJ
 rZ/QMqpJNPfKxekPO11NEdHxndql4OE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-dhxc3O8WPe-Y8_NIwkGOtw-1; Sun, 13 Sep 2020 07:42:31 -0400
X-MC-Unique: dhxc3O8WPe-Y8_NIwkGOtw-1
Received: by mail-wr1-f72.google.com with SMTP id n15so5452739wrv.23
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 04:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YzzUzExnk4lJrfqWcFFqxb4T2DLOs+soNXtK6RFCLak=;
 b=QlkS0/2zWLb7xWxZQemhHWW1qRu+Zr71aOcplNcOkUbB6A6qnaaECMWmdnddH8qWYx
 NDWjLzoJNNwDBu74AL0IuKE7LObWMupGULR+SAmh4VHaPNC+v3aqigKElX30gwP95Xnx
 vhgLQ5PX05P8KQhdqPg6HJA+XxTPdVcY+0W0Xi334G1z5pk7e5U4CzK2ILl/4fWGV1/k
 UKdWNqdOTj2JUoBv+xNZDdQ+L7ZCHyjcOAXxkyuy4xmrJ2oElSv136dJNzmrD1Lm+uJc
 TvibPNR77Vi24p5M+5A2UbTk1HiKMXedZjg35I7P2ZqcK63nyI3OsStsJp6pjxD7qgYe
 sOcw==
X-Gm-Message-State: AOAM532C5vPZD3maSUXqvGvdgGprOxIkXdnewZQYCmMTmV8tT72QK7QO
 rYo7MfowMp8s5BN6CGzFE+rAH4k8MLZeybwkfDOoce/u8Lr8M/XQo1tk4p2F4h1ZJbKTKO8Ag1Y
 ZdeBi4BprbGoLnnA=
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr10783690wmd.187.1599997350008; 
 Sun, 13 Sep 2020 04:42:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmN7RR7tjkEI/U6wY/w2vAIKs0OqcryCl1ZJ7tXMkkZDhrGKRafqg3MjsxUaL2sLdJqNIOJQ==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr10783686wmd.187.1599997349851; 
 Sun, 13 Sep 2020 04:42:29 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f14sm15269802wrv.72.2020.09.13.04.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 04:42:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/timer/hpet: Fix compiler errors with -DHPET_DEBUG
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
 <8d9ae068-77cc-6152-7b90-a51bf70648a0@redhat.com>
 <4918b958-dbd4-bd18-bb75-da7386124886@linux.vnet.ibm.com>
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
Message-ID: <f246ada9-bf7d-2c94-e24e-e28bf3d2efc2@redhat.com>
Date: Sun, 13 Sep 2020 13:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4918b958-dbd4-bd18-bb75-da7386124886@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:40:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 9/10/20 2:53 PM, Dov Murik wrote:
> On 09/09/2020 20:24, Philippe Mathieu-Daudé wrote:
>> On 9/9/20 10:36 AM, Dov Murik wrote:
>>> Fix several compiler errors when compiling withe -DHPET_DEBUG.
>>>
>>> Steps to reproduce the issue:
>>>
>>>      mkdir build
>>>      cd build
>>>      ../configure --target-list=x86_64-softmmu
>>> --extra-cflags=-DHPET_DEBUG
>>>      make
>>>
>>> Dov Murik (2):
>>>    hw/timer/hpet: Remove unused functions hpet_ram_readb, hpet_ram_readw
>>>    hw/timer/hpet: Fix debug format strings
>>>
>>>   hw/timer/hpet.c | 27 +++++++--------------------
>>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>>
>>
>> I sent almost the same patches last week :)
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg736836.html
> 
> Oops, missed that. You're right.
> 
>> You seem to fix a 4th format, can you rebase on top? (As these
>> patches have already been queued).
> 
> Actually there's a small issue in one of your suggested fixes: you added
> "0x" but kept the "%#".  I think it should be without the "#" (also
> according to the coding style document).
> 
> I suggest you fix this small issue, and also add any changes you wish
> from this patchset; then we can throw my patchset to the bin.

Let's use your patchset instead.

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> -Dov
> 


