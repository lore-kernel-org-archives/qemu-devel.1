Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C6C207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmsvvv02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C6C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LBu-0003zF-W2
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8L39-0001yk-H4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:10:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8L36-0006cg-UQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597831827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bm1UnPSpwgbku6mhI5AKwh/ceTV04LVIppHW8u1g1UA=;
 b=fmsvvv02vz3VDDOmAZbgJPP3jwXL9H9r1wKIi3RyrC8PXHGg0bXZacVPBetCplr4QwNPwO
 cxIv1lciSTlt1a7xiQYE8932eKsh9fEHJx+rxJStAQf3NI9gdIv5Xakom8VYXIUKlcoGg1
 UyFKAObwWJ/bZBuMWkoFZdHpOWfLV+0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-_dhJryXfNUO7YOEBPZKqig-1; Wed, 19 Aug 2020 06:10:24 -0400
X-MC-Unique: _dhJryXfNUO7YOEBPZKqig-1
Received: by mail-wm1-f70.google.com with SMTP id h7so744142wmm.7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 03:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IyxkR30i7s5SVFtVvdObAqzcZvb1GUm0m+5TxqJhEtU=;
 b=jnoqvD7H3LnfamuMskP7r38tVjuk5aLByQU6WKaI02HuPpKGLMIpYV7ziKvvjkYKui
 EO4Wqs04RtLqhmgbH6c+mMsTq5GiNt216FAyJKKoq0DoTs1cOFFZKqAbIE+xDg0k7jZf
 4jbF66K9i5L6ulmGMUr9Yt67BA/mFRywKweMq3S3teWIiHOjtLvjOZlJZIcDY1crGIWI
 TSea5L43/l3xh2y/0/QrAQy+vVYs/MXCou3tfcxVoi+9n0gVCK6kidj5DS97i6h+LD5Z
 vmz3tj1aRZfO7tdQT641N5PcJaDTklA4/CFOG+Jo16NYDGh/DITGvqKlBbFsbBOw2p70
 +Nwg==
X-Gm-Message-State: AOAM532emYKwzAhRz76jqzftw84ViPNIRA99xjWCZI0XYRq2em5PHY6c
 61G5TthhsVIPheEqftfKlovRJ6j01xF/bDfXJKTdKiiyN2ZWg6zYJufYIlDesm1xtN1JqUKKN21
 YsKO/02F9FJuCdN8=
X-Received: by 2002:a7b:c056:: with SMTP id u22mr4236947wmc.188.1597831823001; 
 Wed, 19 Aug 2020 03:10:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw70lAQ4zcxsxLPxDcRHk6qU1GfASCCk+YAX4LH7nKRn/2n3fSRfc3zFGRhSS10jwJ3K8jEQQ==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr4236927wmc.188.1597831822753; 
 Wed, 19 Aug 2020 03:10:22 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y2sm4884013wmg.25.2020.08.19.03.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 03:10:21 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] memory: Add trace events to audit MemoryRegionOps
 fields
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200806152613.18523-1-philmd@redhat.com>
 <d87db8e9-40b1-334d-22b0-90674ddf8177@redhat.com>
 <161c9d87-677b-6806-b080-4aebfd5275c4@redhat.com>
 <20200819091417.GA357031@stefanha-x1.localdomain>
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
Message-ID: <0134a5c1-dabb-76cf-a08c-c6ecfbe4af5b@redhat.com>
Date: Wed, 19 Aug 2020 12:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819091417.GA357031@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:14 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 18, 2020 at 09:56:37AM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/18/20 8:32 AM, Paolo Bonzini wrote:
>>> On 06/08/20 17:26, Philippe Mathieu-Daudé wrote:
>>>> Add trace events to audit MemoryRegionOps field such:
>>>>  - are all the valid/impl fields provided?
>>>>  - is the region a power of two?
>>>>
>>>> These cases are accepted, but it is interesting to list them.
>>>>
>>>> Example:
>>>>
>>>>   $ qemu-system-i386 -S -trace memory_region_io_check\*
>>>>   memory_region_io_check_odd_size mr name:'dma-page' size:0x3
>>
>> (a)
>>
>>>>   memory_region_io_check_access_size_incomplete mr name:'acpi-tmr' min/max:[valid:1/4 impl:4/0]
>>>>   memory_region_io_check_access_size_incomplete mr name:'acpi-evt' min/max:[valid:1/2 impl:2/0]
>>>>   memory_region_io_check_access_size_incomplete mr name:'acpi-cnt' min/max:[valid:1/2 impl:2/0]
>>
>> (b)
>>
>>>
>>> Can they be detected using Coccinelle instead?
>>
>> For static declarations, probably.
> 
> Regarding the MemoryRegionOps checks, the following grep command-line
> shows that all MemoryRegionOps definitions are global:
> 
>   $ git grep 'MemoryRegionOps [^*]' hw/
> 
> This means static checking is possible.
> 
>>
>> (a) is not really fixable (because some datasheets don't
>> count the reserved space in the device address map [1]),
>> but is interesting to audit.
>>
>> I believe (b) has to be updated per maintainers preference,
>> not by an individual developer. IIUC Michael said [2] while
>> there is no bus information in MemoryRegionOps (and way to
>> report a bus specific error), it is pointless to blindly fill
>> the zero access sizes.
>>
>> Meanwhile I prefer to share my debugging helpers as trace
>> events instead of ./configure --enable-maintainer and #ifdef'ry.
> 
> Can they be turned into a CI check instead of debugging helpers? For
> example, all existing violations are exempt but new MemoryRegionOps must
> comply. This way it's not necessary to audit and fix everything right
> now but code quality is improved in new code.
> 
> Static checking is nice because there is no need to execute QEMU and
> trigger all the code paths that lead to MemoryRegionOps usage.
> 
> Here are more static checker ideas:
> 
> 1. Rename memory_region_init_io() to memory_region_init_io_unsafe() (or
>    "legacy", "nocheck", etc) and then add a checkpatch.pl error if a new
>    memory_region_init_io_unsafe() call is added.
> 
> 2. Walk the debuginfo looking for MemoryRegionOps structs and check
>    them. For example, a Python script that uses a DWARF parser. There
>    can be list of exempted source files that are allowed to violate the
>    rules (existing code).
> 
> 3. Use __attribute__((__section__())) on MemoryRegionOps so they can
>    easily be located in ELF files and check them. For example, a C
>    program that opens the ELF and finds the "memoryregions" section.

Thanks for the tips!

From the list 1. seems the easier to implement to me (no brain effort).

But for now I'm not sure the check has to be enforced, because I'm not
sure what we really want to do. First we need to figure out the 'bus'
component of a a MemoryRegion (where it sits), as it affects the
MemoryRegionOps possible range values.

> 
> Stefan
> 


