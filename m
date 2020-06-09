Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5D92078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbKLqC+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5D92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigy6-0004dM-Q7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jigxL-0004Aq-8E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:18:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jigxJ-0007Fx-Lg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591719500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bzA+uKHfJgOizvoIVx6fe8Up9e5DHp9SUkoka2ytOrA=;
 b=VbKLqC+XjCcYUihuGwQkZ5bSQkOZwKlxf0FD7nNSuVHViT8j7FEijXM8V9FnlA185IjWxz
 Piy1H1mjLsVxILk7D5Y6/89Y/cbEgEJsz1+7U8yJhsU+W9OmK5Uhgj7uFJcIr1gTWB6hQ/
 tXey2s108xSyJUQnZ4z3aBxDNKqb2v4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-VjH1titMPfWBmtkEYNTiMg-1; Tue, 09 Jun 2020 12:18:18 -0400
X-MC-Unique: VjH1titMPfWBmtkEYNTiMg-1
Received: by mail-wr1-f71.google.com with SMTP id d6so8792108wrn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bzA+uKHfJgOizvoIVx6fe8Up9e5DHp9SUkoka2ytOrA=;
 b=M7Jk0M7g4ISvHJ/j1a+PHEPI56jCM9u2wQvY58yAl49Nl2EyWJHKe+WL95nDXvLaTi
 Dk6Tr2re7+BjZH8659csqDMcwl0IpuNT5RhM8K8uUNwZKu5rrr2+seULgRmwahff7WPL
 iylq/lhN26XkpMUCjXJYFl8BknIpCzBK9n5dJu/YBZ0fGRvMNOjxHSMt0hgse6XwidNp
 f7K3OnDZ6ii2kDpd3SsiEXfSKxsc/VzNVd761R9xGTzZv3F4RGa/Kfa9P6VKHPOYLxyJ
 JWpGuQoajJXm2XKVVsdvmByLCw1tTgwdoxLF3d/Cc2ziuPH//FhLF1fet7MRSDcXyVCt
 /Idg==
X-Gm-Message-State: AOAM53376HdGcak1ij1DdBkZcc34rtyezCgIbdhcEPLC/Nnsfdbi1bd5
 Mc+WReLEDUEXH4Vto6gl2qaJ6679YIs1d1YiiEx7+TIvgSAQBtkycVHbiHBO38FjKRHG/CtpPfJ
 EGOrQHN+rAFmqHfM=
X-Received: by 2002:adf:9205:: with SMTP id 5mr5086873wrj.232.1591719497891;
 Tue, 09 Jun 2020 09:18:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlb5w6z7rUHEby/acE4Y7C8tmlzlvD4TCtJ9AYRrlU4QbLWUSUNCE11oyejkjxkxIkigVFYg==
X-Received: by 2002:adf:9205:: with SMTP id 5mr5086848wrj.232.1591719497618;
 Tue, 09 Jun 2020 09:18:17 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id x186sm3519707wmg.8.2020.06.09.09.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:18:17 -0700 (PDT)
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
 <20200317201153.GB233068@xz-x1>
 <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
 <20200609114913-mutt-send-email-mst@kernel.org> <20200609161328.GB3061@xz-x1>
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
Message-ID: <f4faa7cf-1bb3-6381-05e0-64f01eb377cc@redhat.com>
Date: Tue, 9 Jun 2020 18:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609161328.GB3061@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 6:13 PM, Peter Xu wrote:
> On Tue, Jun 09, 2020 at 11:49:49AM -0400, Michael S. Tsirkin wrote:
>>>>>> @@ -417,8 +419,8 @@
>>>>>>    { 'struct': 'PciDeviceInfo',
>>>>>>      'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
>>>>>>               'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
>>>>>> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
>>>>>> -           'regions': ['PciMemoryRegion']} }
>>>>>> +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
>>>>>> +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
>>>>>
>>>>> and the pre-existing pci_bridge is indeed the consistency issue.
>>>>
>>>> Yeh, actually every key in this struct. :)
>>>
>>> Using 'irq-pin':
>>> Reviewed-by: Philippe Mathieu-DaudÃÂ© <philmd@redhat.com>
>>
>>
>> Peter can you fix and repost pls?
> 
> I still think irq_pin is better because as I mentioned previously all the
> existing keys are using underscores...  Phil?

No problem!


