Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6692AC742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4046B20665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4046B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzOw-0002eb-77
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzOj-00029d-4F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzOh-0007HH-M3
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:31:53 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzOh-0007Gg-39
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:31:51 -0400
Received: by mail-wm1-f51.google.com with SMTP id f17so9645642wme.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H8er3Um6nwfRz2Bm6YZwaRTZIER+nSM6JmK3tm/TRPw=;
 b=MvwYnB8zJn+W4PAgBGxQ/elD4QRBqAxfJR3eCCZhHAn4kulnlx10aO8y+jvwg+fvvw
 ZYxd34PgBnTgHwo4uVGb8RoJvK03rgPls/kPfn2pqXwphBVIJbKtjyFxHKn0e0vHSD0g
 BKhJ+zlka+qzzyILF0w3EHwAJZpGGYJFU9ZP81lhzzIzE4/3oB6gz4vVir15PMB1P2Ne
 Hh5GK65E9CsXSj0Q5zuKdyfDb/YdyNLR0YE982aAx8VoRaXB2ZR0tQhxF8/ocS02tc0V
 85kIUxD3dmE/bu/sQh78gcuY5gLGrPvMpC60ONsTk4oOttU29CISqR2Yw5fEG7+ucu9T
 cSxQ==
X-Gm-Message-State: APjAAAWdbThm8VvYRs35+iyPEh4e6zcjzbeUMXI4cucoCpVwJUFKTiJS
 6quy7UV7yY62L6AMCgops7YX6w==
X-Google-Smtp-Source: APXvYqwqciV47T6WWKkkIjZgy2HRHoxd7RBJ255EDEC6osqbUEPHdesoG7GxAXBI+E3KpWJ1hSaTRg==
X-Received: by 2002:a05:600c:218d:: with SMTP id
 e13mr10774776wme.29.1562952709803; 
 Fri, 12 Jul 2019 10:31:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id d1sm6875597wrs.94.2019.07.12.10.31.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:31:49 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-3-philmd@redhat.com>
 <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
 <de30351b-6747-b976-16c5-c587b51f2b7a@redhat.com>
 <e2a6cb5d-b840-117f-728c-b5b1bf4c18d6@redhat.com>
 <49b41c61-fce7-3b5f-980a-20007125de9f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <993dbb9e-6813-e927-fd69-d16015ea1fc2@redhat.com>
Date: Fri, 12 Jul 2019 19:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <49b41c61-fce7-3b5f-980a-20007125de9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
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

On 12/07/19 18:45, Philippe Mathieu-Daudé wrote:
> On 7/12/19 4:58 PM, Paolo Bonzini wrote:
>> The other is whether we want to enable USB_BLUETOOTH by default.  I
>> wouldn't have any problem there, but if we disable it basically no one
>> would ship/use it and we might as well delete the whole thing.
> 
> The only user is the ARM Nokia N-series board, so if we set default=n,
> the Bluetooth subsystem will be only be selected on arm-softmmu (and
> aarch64-softmmu).
> 
> This seems a sane cleanup. If another board wants to use the bluetooth
> code, it should probably move it out of the orphan status.

Fair! ;)

Paolo

