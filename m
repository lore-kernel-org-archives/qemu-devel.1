Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBDEC742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5383D2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5383D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlyg2-0000ql-GR
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlyfb-0007tk-91
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlyfZ-0003ZR-HN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:45:15 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlyfZ-0003UL-4v
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:45:13 -0400
Received: by mail-wm1-f46.google.com with SMTP id a15so9519017wmj.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 09:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2iJqK2wWzbRidHkzsbaQ5idnuCOPPps534A05a+y3YY=;
 b=njdiRREANA2dw37UhWK8lU3Pi0aa4aGVhfLgGPiQEVa+10S24iwnG0APZI1U1wcW5V
 6FA8wB2LAhZgCWW1WavfdwAPBYI3g3vnNvhlAsRyYlIBBxbV/oFtdxbsk8GUFOIGv+De
 AtxIKIrF/qTJOnhjqoaKAuOriL/LaCFOEKrHMnu4To7b82bgDEYHt1i+OfSoEfOI24vp
 8hPr1HUGpR38/xjBv6ouMp9ICjAjIx69yCebo8JQ440SXA4J/hyKleAFJsyt6+IeIeA0
 3hHKOLxTjK8idr1f/kROs2b6up5jd3tVCfGB/PB+AMEnYn4XV8izkTYkuaqBs75b9QIF
 otIg==
X-Gm-Message-State: APjAAAW4usQOYEZFJKaTAymetSwPfqT4yxUmL7QDywZld86KQhRZx3AB
 GosJrL7P6+xqlcyYWd4bViAq+A==
X-Google-Smtp-Source: APXvYqxPVbZ4rPEhJj0vE/ZJPgXvsugOA+syXH64n+1y81VD0g0AWGopCT1zQlvYO74LD0UJNAMyNQ==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr7937258wmk.147.1562949910336; 
 Fri, 12 Jul 2019 09:45:10 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id n14sm12873255wra.75.2019.07.12.09.45.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 09:45:09 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-3-philmd@redhat.com>
 <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
 <de30351b-6747-b976-16c5-c587b51f2b7a@redhat.com>
 <e2a6cb5d-b840-117f-728c-b5b1bf4c18d6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <49b41c61-fce7-3b5f-980a-20007125de9f@redhat.com>
Date: Fri, 12 Jul 2019 18:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e2a6cb5d-b840-117f-728c-b5b1bf4c18d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.46
Subject: Re: [Qemu-devel] [PATCH-for-4.1 2/7] hw/usb: Bluetooth HCI USB
 depends on USB & BLUETOOTH
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 4:58 PM, Paolo Bonzini wrote:
> On 12/07/19 16:16, Philippe Mathieu-Daudé wrote:
>> I wondered but am not sure, it is default to Yes, but Bluetooth code is
>> deprecated and print a big warning when you use it, so I think this
>> device should not be selected as default, neither pull in the deprecated
>> bluetooth code.
>>
>> So personally I'd respin without 'default y'. If you have a good reason
>> to use it, I can use 'select' instead.
> 
> There are two separate questions.  One is whether USB_BLUETOOTH should
> select BLUETOOTH and the answer there is almost certainly yes (in the
> words of kconfig.rst, BLUETOOTH is a "subsystem" while USB_BLUETOOTH is
> a "device"; devices select the bus that the device provides).

Fair :)

> The other is whether we want to enable USB_BLUETOOTH by default.  I
> wouldn't have any problem there, but if we disable it basically no one
> would ship/use it and we might as well delete the whole thing.

The only user is the ARM Nokia N-series board, so if we set default=n,
the Bluetooth subsystem will be only be selected on arm-softmmu (and
aarch64-softmmu).

This seems a sane cleanup. If another board wants to use the bluetooth
code, it should probably move it out of the orphan status.

