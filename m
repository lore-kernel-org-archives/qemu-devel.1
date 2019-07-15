Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E72C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ECE20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ECE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmz2V-0002wZ-1J
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmz2F-0002L0-9C
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmz2E-00054P-ET
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:20:47 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmz2E-000542-7k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:20:46 -0400
Received: by mail-wr1-f47.google.com with SMTP id n4so16696730wrs.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xuZ17Wl+Vo820DgCe+PNldumzhl2p89ckdeUukJIQlA=;
 b=LrW2EcaX1/RY+Wyc5PaaXn/DJ8rt5CF51WitqtSTpVKE9QB4WKn50OnaGtLT6/wR4B
 kS39uwtIdKs2Z6znbFL0yBV/j6Br0fkKaln1PHyQkG2SnfSsjhs5YczZPvuvVltu2u6O
 0pteCOgxYr/+IE2oT/S0SBQcDqQxRpjS9Nqno4mzxi2DtFBn2fYf5Zn4A3RyRNiAU9nA
 muAIZpeBzlfWt297NiLLzkCZWZ1PeqKIqbI+hcnQMRr16WGMACRvf2HQBuq7iaiipFo/
 Xc7virFj5VkYH0Xg26qJWToauXcHS4DH3XGmoRgAA4FIpoBVYE/s1xHuDNrRHlxvg2xu
 VK6Q==
X-Gm-Message-State: APjAAAUvdBBsg6EqolpwVCnfRHYQLQeyaRoG4DNnySci3+srRilrBHUd
 GN1fnNGFapO8cowQiYHzKkzeRQ==
X-Google-Smtp-Source: APXvYqwG3fsh2EUG+5QE0EJdg8fft9YdExPlRK00uAXYEFkshpt0CtFWD6+HvL5EQX1Y79zhRBzbMw==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr16037835wrp.258.1563189645214; 
 Mon, 15 Jul 2019 04:20:45 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
 by smtp.gmail.com with ESMTPSA id t13sm18616243wrr.0.2019.07.15.04.20.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:20:44 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-3-philmd@redhat.com>
 <alpine.BSF.2.21.9999.1907151251210.6546@zero.eik.bme.hu>
 <64dd9cd5-8599-b157-3ba2-0ec565cee709@redhat.com>
 <alpine.BSF.2.21.9999.1907151309190.6546@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8a6e23a6-2101-3aaa-21b2-a724fea160ac@redhat.com>
Date: Mon, 15 Jul 2019 13:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1907151309190.6546@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.47
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH-for-4.2 2/3] hw/usb/Kconfig: Add
 CONFIG_USB_EHCI_PCI
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 13:10, BALATON Zoltan wrote:
>>
>> If you want to compile without USB_EHCI_PCI and without USB_EHCI_SYSBUS,
>> but with USB (e.g. due to XHCI), I think we should not include
>> hcd-ehci.o file in the build. So I think it's fine that we have a
>> separate config switch for this file.
> 
> So shouldn't build depend on either USB_EHCI_PCI or USB_EHCI_SYSBUS
> selected then?

No, USB_EHCI is never selected by the user.  The board or default-config
file selects either USB_EHCI_PCI or USB_EHCI_SYSBUS, which brings in
USB_EHCI, which brings in USB, which (optionally) brings in the USB devices.

Paolo

