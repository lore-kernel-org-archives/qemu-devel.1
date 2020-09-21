Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC74C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826B820719
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC80btAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826B820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMl2-0006oh-BI
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMj5-0005fc-9t
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMiz-0002cw-Ag
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600698203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4EFUWlBVPK8ZidekA57NaKOeTwXEl6KqAsX0LpekwcQ=;
 b=FC80btAQE0XTkw6eQMW9dluYEbi13g+qFG1M2ry3agIzFc0MuAjo9evh1fckAXqkOiSCYc
 gxMvZ0i9GB+AlmPSojZ9y4vC4HzBrUag7/bjAS5YihnLpGtNaf+PbGUQrzc/90d9ulYqlK
 nwfMvwiNLfxNuzT73N0MTOJu3/yP364=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-d1iDV0HCOOmwnBQFVstyMw-1; Mon, 21 Sep 2020 10:23:21 -0400
X-MC-Unique: d1iDV0HCOOmwnBQFVstyMw-1
Received: by mail-wr1-f70.google.com with SMTP id v5so5884610wrs.17
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4EFUWlBVPK8ZidekA57NaKOeTwXEl6KqAsX0LpekwcQ=;
 b=IcHZLokQA0NY2BvdZZzTqieya9tJaCEA5/Ip6m8Vn4ZKIjn/RQOE8v93kDioYKmZ4v
 dvlguKVZveYF9oahnt7sHliPFBck5wVvsdqeqAcEdgk7iaUxSR/lIAMSxkA/d4uJ1xgu
 1t7vejgNGTAZfffl/C74wBD/zZ9VE4tx0BkGx7rPF6Axp+0sz7hM3mkJ7iZNUi7wgRmU
 kBnjYpfaNVdXUK4+/atFRcRttPEV/kvydx+Xzu6VQf0I+OMjNtJRhpLQG9XJlOakTFhi
 EhzFIqfB6u5YnuIu6oPFL1z9eNyd8TriZE6dQqVnt0sz72JxIcdt1HVW47bOk9vDdfrb
 4MEQ==
X-Gm-Message-State: AOAM5329wpRgPj8syM156D+XkNgHfwqpaYf4LkhqGBZxakwV4w5dnO65
 L40+ZyMtKCLAWfmI2Aw1SrKpLI0u2dgdljAOWDu698r5d7XVORMCwfF6qfR0Jfzb4leTDYdJ81Y
 a+grJb5AbtZSlrcg=
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr9221wrx.3.1600698199892;
 Mon, 21 Sep 2020 07:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMs7rcVBt3rxGL10jeJOv6HB8AcsiGMIXpCAeK/hUripHTlbXZ0vFh0J7074c4YCEPRFes3w==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr9189wrx.3.1600698199676;
 Mon, 21 Sep 2020 07:23:19 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t6sm23034585wre.30.2020.09.21.07.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:23:18 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org> <874knra5fk.fsf@dusky.pond.sub.org>
 <6384105c-65ca-60f8-4fa0-afd2e46b144a@redhat.com>
 <87pn6f48xx.fsf@dusky.pond.sub.org> <20200921122400.GI3221@work-vm>
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
Message-ID: <e88a8f34-ec08-f6b1-05b6-d91c447ee1ed@redhat.com>
Date: Mon, 21 Sep 2020 16:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921122400.GI3221@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:01:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Kevin O'Connor <kevin@koconnor.net>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 2:24 PM, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> Philippe Mathieu-DaudÃ© <philmd@redhat.com> writes:
>>
>>> +Paolo & Kevin.
>>>
>>> On 9/21/20 10:40 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-DaudÃ© <f4bug@amsat.org> writes:
>>>>
>>>>> As it is legal to WRITE/ERASE the address/block 0,
>>>>> change the value of this definition to an illegal
>>>>> address: UINT32_MAX.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>>>>> ---
>>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>
>>>>> Same problem I had with the pflash device last year...
>>>>> This break migration :(
>>>>> What is the best way to do this?
>>>>
>>>> Remind me: did we solve the problem with pflash, and if yes, how?
>>>
>>> No we can't. The best I could do is add a comment and as this
>>> is not fixable. See commit aba53a12bd5: ("hw/block/pflash_cfi01:
>>> Document use of non-CFI compliant command '0x00'").
>>>
>>> I now consider the device in maintenance-only
>>> mode and won't add any new features.
>>>
>>> I started working on a new implementation, hoping it can be a
>>> drop in replacement. Laszlo still has hope that QEMU pflash
>>> device will support sector locking so firmware developers could
>>> test upgrading fw in VMs.
>>>
>>> Back to the SDcard, it might be less critical, so a migration
>>> breaking change might be acceptable. I'm only aware of Paolo
>>> and Kevin using this device for testing. Not sure of its
>>> importance in production.
>>
>> Neither am I.
>>
>> Which machine types include this device by default?
> 
> To me it looks like it's some of the ARM boards.

My worry is TYPE_PCI_SDHCI ("sdhci-pci"):

    k->vendor_id = PCI_VENDOR_ID_REDHAT;
    k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
    k->class_id = PCI_CLASS_SYSTEM_SDHCI;

config SDHCI_PCI
    bool
    default y if PCI_DEVICES

> 
> Dave
> 
>> How can a non-default device be added, and to which machine types?
>>
>> I gather the fix changes device state incompatibly.  Always, or only in
>> certain states?  I'm asking because if device state remains compatible
>> most of the time, we might be able use subsection trickery to keep
>> migration working most of the time.  Has been done before, I think.


