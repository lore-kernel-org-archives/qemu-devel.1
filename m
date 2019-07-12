Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D1BC742C4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EFD21670
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EFD21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwMM-00038X-Fx
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlwMA-0002e9-O7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlwM8-0005dQ-PH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:17:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlwM8-0005c5-Jm
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:17:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so10197736wrm.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 07:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Woz8/m+h9vyanjb6qA+tEUReKa+Sp9AHCYlwtnP22g=;
 b=Q5cloJyMgLajMWmx6T4bZe1o9prsDQrCE+ufcbIdbBAYryDSs5A4GZQrH40gIkR4lH
 buVHuEGlJeo2mFOJT6+BfOwIY5WQPSiWFzZqqF/h/45Aqr56ednfIvbN51R2PRmNvRvZ
 N7+U2+QdDMj7utCdApFRZMK114J4mcUinAdHTqkDZkww9GsgMIMtCjeF3p8M6j0pXFhD
 8sDu6xH5ULzDBRZ/8zLm/9S346J0crPNCZ5+2XIxdo2I5/DErKIF1c8mH5srcNC8i/YU
 BN/M0tFwhQoCYFgIT2def8/sBo2rZ4768w1HAz1/trb2yKIgCe3qEq0AJWVW+1VPJbw0
 wZYQ==
X-Gm-Message-State: APjAAAVFsgYK1oOgMezLlAdWBDqOqZWMFQ3+D+JlfnivpVB56HgJBzCT
 21axj/IrsU9GagAFra4xKqdVqg==
X-Google-Smtp-Source: APXvYqw1Ye4xOd4G5rSp3FwD63O/VC3/9qRS16hHUyQAm6n5kBiawbbGNTX9/hfFieQ24djI9mGdzQ==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr12759602wrv.30.1562941018996; 
 Fri, 12 Jul 2019 07:16:58 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id f10sm1572210wrs.22.2019.07.12.07.16.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 07:16:58 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-3-philmd@redhat.com>
 <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de30351b-6747-b976-16c5-c587b51f2b7a@redhat.com>
Date: Fri, 12 Jul 2019 16:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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

On 7/12/19 3:58 PM, Paolo Bonzini wrote:
> On 12/07/19 15:39, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/usb/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>> index 564305e283..1b435ec002 100644
>> --- a/hw/usb/Kconfig
>> +++ b/hw/usb/Kconfig
>> @@ -82,7 +82,7 @@ config USB_NETWORK
>>  config USB_BLUETOOTH
>>      bool
>>      default y
>> -    depends on USB
>> +    depends on USB && BLUETOOTH
>>  
>>  config USB_SMARTCARD
>>      bool
>>
> 
> Shouldn't it select BLUETOOTH instead?

I wondered but am not sure, it is default to Yes, but Bluetooth code is
deprecated and print a big warning when you use it, so I think this
device should not be selected as default, neither pull in the deprecated
bluetooth code.

So personally I'd respin without 'default y'. If you have a good reason
to use it, I can use 'select' instead.

Regards,

Phil.

