Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB8C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF33206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF33206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzWV-0007JA-Nb
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmzWK-0006ur-H6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmzWJ-0004hI-E1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:51:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmzWJ-0004h2-8G
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:51:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so16819649wru.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l27so6Hdn0kOSN7VkdlCzk9A3tPcFCRMqx4qrgTv6ZY=;
 b=prgnCPZ8bqGuaWh1bqechtq6nwwyw5NgSzpzCzyMFXNXcRzahoCxJpGz5MLD9FB5if
 t9XwBOAKmVDzao3c8Mrqydn+RYiKORckEuCNHpU/bzuFuh0vA0GQ7eTpT7CbesOgyPOx
 hSJQ+Kth7oyGFfl4YLhtjNljtIP2xznNBbbosrhJyl7x+SULV1hpbBT1Zu6+EmLEsp3v
 uSsnTgb70vPBd8hu84r3fxIb6rs/MGyZ6+BRCwXAy6HbQRbHoxjbgsAAdlLansH4Arft
 Ai5THJnc93aMbgmLTvl7KICkZTnAYXu+DPiztQSthxn6I7cHKUEyguXsSqv4N3OZuydH
 W+4A==
X-Gm-Message-State: APjAAAUYYE+XbwEdxZbPzwdMp52eAmTuBBfByqbMXxc5Zz4nMMRSpu6r
 7u/JGDkioWHRPvI84aYrF846Mg==
X-Google-Smtp-Source: APXvYqwJThfjWvlRCICs1pykT3p02MIB3Iup3Dt5yCpSuAPn9EfdeRN7QT5CWQy6VNVSKjSOQ/VsWw==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr28079181wrl.127.1563191510189; 
 Mon, 15 Jul 2019 04:51:50 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
 by smtp.gmail.com with ESMTPSA id z1sm18372347wrv.90.2019.07.15.04.51.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:51:49 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190714124755.14356-1-philmd@redhat.com>
 <ebd6d5a3-4f3e-b0ef-50c7-333996375b96@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c3c9ba9-15bb-95cc-9b92-a9d94a37a10b@redhat.com>
Date: Mon, 15 Jul 2019 13:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ebd6d5a3-4f3e-b0ef-50c7-333996375b96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH-for-4.1] hw/lm32/Kconfig: Milkymist One
 provides a USB 1.1 Controller
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Walle <michael@walle.cc>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 13:47, Philippe Mathieu-Daudé wrote:
> On 7/14/19 2:47 PM, Philippe Mathieu-Daudé wrote:
>> The Milkymist SoftUSB block provides the OHCI USB standard
>> (missed in 0858746b835).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/lm32/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
>> index 3d09c2dd6f..ed2e3060b0 100644
>> --- a/hw/lm32/Kconfig
>> +++ b/hw/lm32/Kconfig
>> @@ -11,3 +11,4 @@ config MILKYMIST
>>      select PFLASH_CFI01
>>      select FRAMEBUFFER
>>      select SD
>> +    select USB_OHCI
>>
> 
> Markus asked me how I noticed that, if it was auditing the code.
> 
> I ran 'qemu-system-lm32 -device help' and noticed all the USB devices
> had disappeared.
> 

Queued, thanks.

Paolo

