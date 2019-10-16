Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98BC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B5B20650
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B5B20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfdM-0002KF-U5
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iKfcW-0001uF-Vi
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iKfcV-0001Sv-PA
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:29:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iKfcV-0001Sn-Ji
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:29:27 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A540383F51
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:29:26 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id p6so718814wmc.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jaQzz38vrnpF/QrELEwhAkMpmy9OSO9pwhD25RaHMfs=;
 b=unP4S9hvi7WHsO9T4GRDY05L9X+zatufc9Li5B9mo4T6LGnN4qnk9UYxh3/90NJ75r
 SAzWV1R4VjPM+YnRgfJ/dCyHHqlxkmtnoVxTZlcSvaF17EK4P1gg6jl7p/s57thw5JQd
 qxnlwy3U+r+L1rdqfLXw0RyLUw1wvi/owSuqpopkGubGRQzICOV6r9DD2itfWImGmc7I
 rpukCw0PyGBwt6geNFROQfCTTeuINI0dqE9G7D+4fYHRasc1ZUQ+2TserMg/fUgp6We9
 gQhathLrgIc3T2+BLshO94sT2tprGXKUSbuoZPKm1EvIL7w95YA5/WOE2WUX4Hq4vfvs
 jLoQ==
X-Gm-Message-State: APjAAAXF5yDiW1bxlfgtsMP7cUdsE03hVafm7H6cq4+ePIJVapVKZglo
 mtQq4Yf1qkmb0l7HYBBc14XqgWeWm+qN85uslytACgN7CI19dvBLXgWwY/E1vnrnts5EXwv/LHS
 fGGLEI2NdkeTFAfE=
X-Received: by 2002:adf:a799:: with SMTP id j25mr1575747wrc.277.1571218165241; 
 Wed, 16 Oct 2019 02:29:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymDwHxu7REmjZcgbzsFKZNkgSMQK26aQfIo5hbud4lpYl36pU/L+8r8lzaMHTkR5KiQMVM8Q==
X-Received: by 2002:adf:a799:: with SMTP id j25mr1575730wrc.277.1571218165015; 
 Wed, 16 Oct 2019 02:29:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id p85sm2107478wme.23.2019.10.16.02.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 02:29:24 -0700 (PDT)
Subject: Re: [PATCH v9 14/15] hw/i386: Introduce the microvm machine type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-15-slp@redhat.com>
 <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
 <a5863b05-4021-df51-d84f-1bb070fa6137@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8eec451f-3ee3-b111-2c03-3c29ade661a6@redhat.com>
Date: Wed, 16 Oct 2019 11:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a5863b05-4021-df51-d84f-1bb070fa6137@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com,
 rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/19 11:26, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/16/19 9:46 AM, Paolo Bonzini wrote:
>>
>>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>>> index c5c9d4900e..d399dcba52 100644
>>> --- a/hw/i386/Kconfig
>>> +++ b/hw/i386/Kconfig
>>> @@ -92,6 +92,10 @@ config Q35
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SMBIOS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FW_CFG_DMA
>>> =C2=A0 +config MICROVM
>>> +=C2=A0=C2=A0=C2=A0 bool
>>
>> Missing:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 select ISA_BUS
>> =C2=A0=C2=A0=C2=A0=C2=A0 select APIC
>> =C2=A0=C2=A0=C2=A0=C2=A0 select IOAPIC
>> =C2=A0=C2=A0=C2=A0=C2=A0 select I8259
>> =C2=A0=C2=A0=C2=A0=C2=A0 select MC146818RTC
>=20
> maybe 'select SERIAL_ISA' too?

Right, but only 'imply'.

Paolo

