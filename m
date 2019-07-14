Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3756CC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 16:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A182063F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 16:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A182063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmgwN-0004BA-Qk
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 12:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmgwA-0003h6-8U
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmgw9-0004Ru-DI
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:01:18 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmgw9-0004R3-5r
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:01:17 -0400
Received: by mail-wr1-f48.google.com with SMTP id y4so14576189wrm.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tu0CKk/DaGf8dbDBBxibhOQehNaT7jFlyBh2+tX3JCY=;
 b=ST62gkmVxksQPnRiB8QjZ8ynowjql9bP7oGM2EXDO8rbikkHKx0R24scV19TlQTSP8
 aHb8upya/evr9ziBAE8ipqxE8O4NB4524ddBMg9zVyvZrmaR0t69IwdnCXRcRVWHaon2
 DxBvTnR2P782ouIh00z9Vbjl/oJEKOjYxIAYEHg7k0xt4jgZMI3/k+doErzAKh46xaqO
 Z+cBS9jrRla9o1cV1hh3gRlVz4lmTDO0JNWVBjhZMqoGLR5emRM4muCEeWKIUu0p55LD
 ferd0QoCzS3Sa3+VIk9z9CIeoJccgEUZxmRsIu2rGGApmFwSfVQJR1CxByAwiJ2IT+0V
 9A9g==
X-Gm-Message-State: APjAAAVyKsPjvYZ9sAyO/a8P905iCLzZyuXo71mB0c6fnuUtCx9iUH3A
 ATG8yqoDaX/Q6dAZbRfxbkcHXA==
X-Google-Smtp-Source: APXvYqz/1tb9ydwueEJxs2WnRfRwRi8vRnN+OjzeeOUMvnmPkY6994SWETdaDCafDfUa9Z5gmL9Zzw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr24551840wrw.304.1563120075572; 
 Sun, 14 Jul 2019 09:01:15 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id l17sm1895100wrr.94.2019.07.14.09.01.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 09:01:14 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-3-philmd@redhat.com>
 <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
 <de30351b-6747-b976-16c5-c587b51f2b7a@redhat.com>
 <e2a6cb5d-b840-117f-728c-b5b1bf4c18d6@redhat.com>
 <49b41c61-fce7-3b5f-980a-20007125de9f@redhat.com>
 <993dbb9e-6813-e927-fd69-d16015ea1fc2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8dc2d98e-fd69-b1d5-3d60-c5457e7b363b@redhat.com>
Date: Sun, 14 Jul 2019 18:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <993dbb9e-6813-e927-fd69-d16015ea1fc2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.48
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

Hi Paolo,

On 7/12/19 7:31 PM, Paolo Bonzini wrote:
> On 12/07/19 18:45, Philippe Mathieu-Daudé wrote:
>> On 7/12/19 4:58 PM, Paolo Bonzini wrote:
>>> The other is whether we want to enable USB_BLUETOOTH by default.  I
>>> wouldn't have any problem there, but if we disable it basically no one
>>> would ship/use it and we might as well delete the whole thing.
>>
>> The only user is the ARM Nokia N-series board, so if we set default=n,
>> the Bluetooth subsystem will be only be selected on arm-softmmu (and
>> aarch64-softmmu).

Using (1):

+    default y if BLUETOOTH
     depends on USB
+    select BLUETOOTH

I get:

    KconfigDataError: cycle found including BLUETOOTH

This works but doesn't follow kconfig.rst (2):

+    default y if BLUETOOTH
     depends on USB

This works (kconfig.rst compliant, 3):

+    default n
     depends on USB
+    select BLUETOOTH

Are you OK with (2) or you prefer (3)?

>>
>> This seems a sane cleanup. If another board wants to use the bluetooth
>> code, it should probably move it out of the orphan status.
> 
> Fair! ;)
> 
> Paolo
> 

