Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEA2C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80792098B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80792098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBnD-0001RC-LK
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEBmV-0000av-H7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:29:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEBmR-0004De-50
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:29:30 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-nV9aH7dsNcC233I4UgZnZw-1; Fri, 04 Sep 2020 09:29:23 -0400
X-MC-Unique: nV9aH7dsNcC233I4UgZnZw-1
Received: by mail-wr1-f70.google.com with SMTP id v12so2329334wrm.9
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hYKOT3gzTCUJU53IryTj1pF5m2Knb1m76Xv2YrstHnA=;
 b=cNHqLB1zDhWfcpWGVT2Z4Vekp21Sp/DWmIkXr2lFizkZ/Lzsx73A7Fl3h0UruqfMGj
 mYdNcxQ5A99ZDQKy0YtK9iYu61LBSfN9b15Udn8AHgFWHc0vglg+aFxNVxl2NA2nRO5o
 v7P81+qo3BLJ7lGcxovtPeWH2T/FLeT5sDKKVWWEJxfudRNtR++vPyB+5pCFDQshV2/w
 pjjYPr7G5SDbnQh7IFFUW8amLV2ZI8FAxYwrvhC/Pms78Z3FKomruyVhWgR0+DQDOVQy
 1u24O/7pGIOTP61DYts1mm9PCK7Svue/FEfqHqhBF/j2KqfrO9lIqC/eihIXm4Wdfj/a
 QWYg==
X-Gm-Message-State: AOAM533X3SYmCqML3aAOZ0q6uNpwA6DhRfYpj2Xh/N2TQg/4ePqJ7aQ2
 8vvSLY2FqD0o0znqFkfTRPBOe7qNvmHArsa6GK0M8KXtyHk8L6CxLjjBVX/2uKbI8/6ZKFWzajx
 +VWruH82JsJqR2+c=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr7998043wmj.134.1599226161796; 
 Fri, 04 Sep 2020 06:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY+upMu9y75nBktQ1xypT7tJWE9OuUyLbZUvbGDuucRV3MZtiq0M495a39nQpqwEzz/mrGwg==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr7998003wmj.134.1599226161244; 
 Fri, 04 Sep 2020 06:29:21 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d5sm11984828wrb.28.2020.09.04.06.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 06:29:20 -0700 (PDT)
Subject: Re: [PATCH v2] i440fx/acpi: disable hotplug of cold plugged bridges
 regarldless of hotplug switch
To: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org
References: <20200904124404.9894-1-ani@anisinha.ca>
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
Message-ID: <2ba66be7-d4f2-6994-7794-c07fbb50151f@redhat.com>
Date: Fri, 4 Sep 2020 15:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904124404.9894-1-ani@anisinha.ca>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ani,

On 9/4/20 2:44 PM, Ani Sinha wrote:
> Cold plugged bridges should not be hot unpluggable, even when their hotplug
> property (acpi-pci-hotplug-with-bridge-support) is turned off. However, with
> the current implementaton, windows would try to hot-unplug a pci bridge when
> it's hotplug switch is off. This is regardless of whether there are devices
> attached to the bridge. When devices are attached to the bridge, the bridge
> is ultimately not hot-unpluggable. We have a demo video here:
> https://youtu.be/pME2sjyQweo
> 
> In this fix, we identify a cold plugged bridge and for cold plugged bridges,
> we do not add the appropriate amls and acpi methods that are used by the OS
> to identify a hot-unpluggable pci device. After this change, Windows does not
> show an option to eject the PCI bridge. A demo video is here:
> https://youtu.be/kbgej5B9Hgs
> 
> While at it, I have also updated a stale comment.
> 
> This change is tested with a Windows 2012R2 guest image and Windows 2019 server
> guest image running on Ubuntu 18.04 host. This change is based off of upstream
> qemu master branch tag v5.1.0.

Can you add a test reproducer?

Looking at tests/qtest/virtio-rng-test.c it shouldn't be that
hard / time consuming.

Thanks!

Phil.

> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Changelog:
> v2: cosmetic commit log update.
> v1: initial patch.
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..90b863f4ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          int slot = PCI_SLOT(i);
>          bool hotplug_enabled_dev;
>          bool bridge_in_acpi;
> +        bool cold_plugged_bridge;
>  
>          if (!pdev) {
>              if (bsel) { /* add hotplug slots for non present devices */
> @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          pc = PCI_DEVICE_GET_CLASS(pdev);
>          dc = DEVICE_GET_CLASS(pdev);
>  
> -        /* When hotplug for bridges is enabled, bridges are
> -         * described in ACPI separately (see build_pci_bus_end).
> -         * In this case they aren't themselves hot-pluggable.
> +        /*
> +         * Cold plugged bridges aren't themselves hot-pluggable.
>           * Hotplugged bridges *are* hot-pluggable.
>           */
> -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> -            !DEVICE(pdev)->hotplugged;
> +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
>  
> -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
>  
>          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
>              continue;
> 


