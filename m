Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0869F22CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P16WFoKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0869F22CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3CVF-0004bZ-OY
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 02:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3CUZ-0004B5-Q2
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3CUX-0005of-BP
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596607292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uYgvwyHb7zMNrYivXA+AlWroqgE1RFneym+wEowXYF8=;
 b=P16WFoKYxyaB8gHCNvpJY9Dhc7QCsQFwaENSnwi0sgoXqM0WZgfYUVl6nAxy+d43tqRf3T
 98DbQvhIrM77IczA/fdzc3aPZK+bW/31zmQP5WkUfcbYzqgqtpzdEghg031wjAUqeuVr8F
 M2+MOzXwAf7xyG+snAJxW5ep+/l7F8s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-dVKceudFPzW6NUg7OwmvBw-1; Wed, 05 Aug 2020 02:01:28 -0400
X-MC-Unique: dVKceudFPzW6NUg7OwmvBw-1
Received: by mail-wr1-f71.google.com with SMTP id 5so13131130wrc.17
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 23:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uYgvwyHb7zMNrYivXA+AlWroqgE1RFneym+wEowXYF8=;
 b=nVjus1YiK92fqAbS7D+4vCkcbWrts4/Mx/7fOHlmjYA6lBlVjScfdRXaddFJtqSzKv
 pbFneiobH8Oo1aWdNPGtWm+JY6lVpcjF/4Qyv6U4OVhhcxzKhNMJ6eeS0wTBCGVdWfRF
 icZ4ZPrJWtzi3/bO68LSqOK8idMYbl82MooG9/Y2igpO/cWlGgvGWQFGsj7B5OjyEdaj
 nCu+EaaiRSXi5U1J2MFpCKJKWSYifM8p9s4RQJpBP0gprNFENy4Q/5oTZG0IdScMVx0x
 vRdbtt+HstaOIKILluGis26ZsygKQtIpiX4wCVAoYqDYIZhYZXMENhBY7Vx3RJNF6AcH
 qkxg==
X-Gm-Message-State: AOAM533y8UfPoBiQPqsrV/cTHD0Fp3Xaj3EXBDnKIx0gG7KauHxFYnj3
 NUkFNJC9WtlWEaKUn+rMKIuRTsVnJf9BESqg1SOYRBTWnXaK5h2MBfsVNOKogRMaW27LF+YfmjV
 N7UzY72nOzAxccfM=
X-Received: by 2002:adf:e712:: with SMTP id c18mr1304055wrm.92.1596607287063; 
 Tue, 04 Aug 2020 23:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJusXM++lyYWaBV9v4QZQS8tHpeMmCry6mqbcPhPl2dAkL0cCe8y175FWIoo9kBf+ZIypHow==
X-Received: by 2002:adf:e712:: with SMTP id c18mr1304033wrm.92.1596607286840; 
 Tue, 04 Aug 2020 23:01:26 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z6sm1292813wrs.36.2020.08.04.23.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 23:01:26 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
 <1b61a51a-0419-1bd3-2728-e5c11606f99e@redhat.com>
 <c0ea77ce-bd5f-aa3b-2dd0-e4793800208a@redhat.com>
 <fabf9f04-fbc8-79e5-4ae7-beb9a2a05f16@redhat.com>
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
Message-ID: <b4b1b0d4-6a94-3ab7-62a2-fd3e43804d15@redhat.com>
Date: Wed, 5 Aug 2020 08:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fabf9f04-fbc8-79e5-4ae7-beb9a2a05f16@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 7:56 AM, Philippe Mathieu-Daudé wrote:
> On 3/19/20 11:02 AM, Paolo Bonzini wrote:
>> On 19/03/20 10:42, Philippe Mathieu-Daudé wrote:
>>> On 3/19/20 10:36 AM, Paolo Bonzini wrote:
>>>> On 18/03/20 23:15, Philippe Mathieu-Daudé wrote:
>>>>> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
>>>>> function are not documented in the PIIX4 datasheet.
>>>>> This appears to be a PC-only feature added in commit 5e3cb5347e
>>>>> ("initialize hot add system / acpi gpe") which was then moved
>>>>> to the PIIX4 device model in commit 9d5e77a22f ("make
>>>>> qemu_system_device_hot_add piix independent")
>>>>> Add a property (default enabled, to not modify the current
>>>>> behavior) to allow machines wanting to model a simple PIIX4
>>>>> to disable this feature.
>>>>
>>>> Yes, all hotplug stuff (PCI/memory/CPU) are custom additions by QEMU.
>>>>
>>>>> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
>>>>> +                     use_acpi_system_hotplug, true),
>>>>
>>>> Why not cpu-hotplug-support?
>>>
>>> Because I have no idea what this code is about, and it seems more than
>>> cpu (pci, memory):
>>
>> Right, I should have been more verbose.  You mentioned I/O port 0xaf00
>> which is CPU hotplug.  Perhaps unless you can also crash with PCI
>> hotplug (0xae00-0xae0f) it's worth removing only CPU hotplug from MIPS
>> machines, and keep PCI hotplug.
> 
> I am sorry I don't understand what PCI hotplug has to do with PIIX which
> is a PCI-slave southbridge... If MIPS or other arch is interested in PCI
> hotplug feature, that would be managed by the northbridge or another PCI
> bridge.

Ah, writing that comment made me realize the problem might be these
'virtualization' features have been implemented in the wrong place.
Maybe the less disruptive path is to move them to the i440fx
northbridge. That way we shouldn't need to maintain a piix_hw.c and
piix_virt_twisted.c (child of piix_hw overloaded with hotplug features).

I haven't looked at the history yet, maybe the problem happened when
i440fx/piix was split.

> 
>>
>> Paolo
>>
>>> static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>>>                                            PCIBus *bus, PIIX4PMState *s)
>>> {
>>>     memory_region_init_io(&s->io_gpe, OBJECT(s), &piix4_gpe_ops, s,
>>>                           "acpi-gpe0", GPE_LEN);
>>>     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>>>
>>>     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>>>                     s->use_acpi_pci_hotplug);
>>>
>>>     s->cpu_hotplug_legacy = true;
>>>     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
>>>                              piix4_get_cpu_hotplug_legacy,
>>>                              piix4_set_cpu_hotplug_legacy,
>>>                              NULL);
>>>     legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
>>>                                  PIIX4_CPU_HOTPLUG_IO_BASE);
>>>
>>>     if (s->acpi_memory_hotplug.is_enabled) {
>>>         acpi_memory_hotplug_init(parent, OBJECT(s),
>>> &s->acpi_memory_hotplug,
>>>                                  ACPI_MEMORY_HOTPLUG_BASE);
>>>     }
>>> }
>>>
>>
> 


