Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE882C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D76E206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI5CADYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D76E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPan-00012E-Hd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGPa8-0008Up-Tr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:37:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGPa6-0001Ol-V1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599755874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RSmldqhHr4Jg/KosdIadhVn8AGegL9ck5NtSAjo0Rlg=;
 b=CI5CADYhw4Ru9WuiUn3Y/g9og7r0GvB762/IJDZpJekgoHAH4snifMFZuFNj2s2IDA5oNL
 jSA4+1tGQAbI1sfjguLeQgpv6NV9f6xAzAzyh1jfOeNS+F03RxXNOlDtgBOVGPAU0HpQcX
 iPAO94F4r+07Q7ySYPuWogMjdu5qOyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-wyLztYPFP0qc8hkUpP94TQ-1; Thu, 10 Sep 2020 12:37:52 -0400
X-MC-Unique: wyLztYPFP0qc8hkUpP94TQ-1
Received: by mail-wm1-f71.google.com with SMTP id b14so205999wmj.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RSmldqhHr4Jg/KosdIadhVn8AGegL9ck5NtSAjo0Rlg=;
 b=auKsOOJOqXk+4A+qfwaMCDsgp21NgUrlSlDxz1Es+S5NUVYdhSDeo7YBrb6rmyEJ5H
 54GHc/yMvKU83W7yzJXKqdg40XzDdgnqO1RgZ90TGrMH9B9TEz6GIB/r8zbqkWxHLNCt
 GFRBsRbEdJ6lH54u/u43As5gR9qdtM0yqBZh+gYA4uUFgzARbJrt1FNE8uDJidbFqbQi
 Q5w4BOH+IXu8ZledNffY9qoesEO/7XGhtMz6YJZVdAWafCgNuQEIfvWXyY6mnrxaZqIE
 Aa9PEnoyfDVqWGZfY/aFeNtNV5r7VRGoZ33QZB1E7cuydoAORRwjuqJEQlxI8+G70HAx
 bjlw==
X-Gm-Message-State: AOAM5331SVyhiCTQ9IWaTgOxbDsWt/+qcKL/GQGGriONmOIKLHi3yUsX
 VEes3hXXCXNhgHzI4fvqz+P0FMwm31eCmKnf1F7jxePr+6GtolqoD99J2lDX0MjyoaqpByfgYav
 UkYdRhpzO+JC1Cig=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr867873wme.122.1599755871363; 
 Thu, 10 Sep 2020 09:37:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8IIWQCnCbVAWs4w/gozgejkJ7u58eymUoIJmbKqY/VQ2hiEUARtlsnPmnLAnybrbMQvkmWQ==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr867853wme.122.1599755871139; 
 Thu, 10 Sep 2020 09:37:51 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm4493219wma.16.2020.09.10.09.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 09:37:50 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-4-philmd@redhat.com>
 <20200910104435.GA45048@stefanha-x1.localdomain>
 <4df84b90-68f6-7d69-024a-30ab2af5cc7e@redhat.com>
 <20200910102949.2502144d@w520.home>
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
Message-ID: <ec5cf8aa-642a-bd11-00fa-a7b9c809172d@redhat.com>
Date: Thu, 10 Sep 2020 18:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910102949.2502144d@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 6:29 PM, Alex Williamson wrote:
> On Thu, 10 Sep 2020 17:29:25 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Hi Stefan, Alex.
>>
>> On 9/10/20 12:44 PM, Stefan Hajnoczi wrote:
>>> On Wed, Sep 09, 2020 at 04:23:53PM +0200, Philippe Mathieu-DaudÃ© wrote:  
>>>> +/**
>>>> + * Initialize device MSIX IRQs and register event notifiers.
>>>> + * @irq_count: pointer to number of MSIX IRQs to initialize
>>>> + * @notifier: Array of @irq_count notifiers (each corresponding to a MSIX IRQ)
>>>> +
>>>> + * If the number of IRQs requested exceeds the available on the device,
>>>> + * store the number of available IRQs in @irq_count and return -EOVERFLOW.
>>>> + */
>>>> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *notifier,
>>>> +                                 unsigned *irq_count, Error **errp)
>>>> +{
>>>> +    int r;
>>>> +    size_t irq_set_size;
>>>> +    struct vfio_irq_set *irq_set;
>>>> +    struct vfio_irq_info irq_info = {
>>>> +        .argsz = sizeof(irq_info),
>>>> +        .index = VFIO_PCI_MSIX_IRQ_INDEX
>>>> +    };
>>>> +
>>>> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
>>>> +        error_setg_errno(errp, errno, "Failed to get device interrupt info");
>>>> +        return -errno;
>>>> +    }
>>>> +    if (irq_info.count < *irq_count) {
>>>> +        error_setg(errp, "Not enough device interrupts available");
>>>> +        *irq_count = irq_info.count;
>>>> +        return -EOVERFLOW;
>>>> +    }
>>>> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
>>>> +        error_setg(errp, "Device interrupt doesn't support eventfd");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    irq_set_size = sizeof(*irq_set) + *irq_count * sizeof(int32_t);
>>>> +    irq_set = g_malloc0(irq_set_size);
>>>> +
>>>> +    /* Get to a known IRQ state */
>>>> +    *irq_set = (struct vfio_irq_set) {
>>>> +        .argsz = irq_set_size,
>>>> +        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
>>>> +        .index = irq_info.index,
>>>> +        .start = 0,
>>>> +        .count = *irq_count,
>>>> +    };
>>>> +
>>>> +    for (unsigned i = 0; i < *irq_count; i++) {
>>>> +        ((int32_t *)&irq_set->data)[i] = event_notifier_get_fd(&notifier[i]);
>>>> +    }
>>>> +    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
>>>> +    g_free(irq_set);
>>>> +    if (r <= 0) {
>>>> +        error_setg_errno(errp, errno, "Failed to setup device interrupts");
>>>> +        return -errno;
>>>> +    } else if (r < *irq_count) {
>>>> +        error_setg(errp, "Not enough device interrupts available");
>>>> +        *irq_count = r;
>>>> +        return -EOVERFLOW;
>>>> +    }  
>>>
>>> EOVERFLOW can occur in two cases: VFIO_DEVICE_GET_IRQ_INFO and
>>> VFIO_DEVICE_SET_IRQS.  
>>
>> Yes.
>>
>>>
>>> If it happens in the second case the notifier[] array has been
>>> registered successfully.  
>>
>> No, I don't think so:
>>
>> vfio_pci_set_msi_trigger() register the notifier only if
>> vfio_msi_enable() succeeded (returned 0). If vfio_msi_enable()
>> failed it returns the number of vectors available but do
>> not register the notifiers.
>>
>> Alex, do you confirm?
> 
> Yes, if we can't setup what the user requested we don't setup anything.
> However, I think we return zero on success, which seems to fall into
> your error condition.  Has this been tested?  Thanks,

Not v6 as I didn't have the testing setup handy, and thought
v5 -> v6 change was trivial enough :S

Good news: my next task is to add a test :)

> 
> Alex
> 
>>> The caller has no way of distinguishing the two cases. Therefore the
>>> caller doesn't know if the eventfds will be used by the kernel after
>>> EOVERFLOW.
>>>
>>> If the second case can ever happen then this function should probably
>>> call VFIO_DEVICE_SET_IRQS again with VFIO_IRQ_SET_DATA_NONE to
>>> unregister the eventfds before returning EOVERFLOW.
>>>
>>> STefan
>>>   
>>
> 


