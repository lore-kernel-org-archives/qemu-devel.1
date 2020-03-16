Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2909220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiTWxJjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2909220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrMI-0006Xc-QJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDpta-0004Yo-Sv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDptY-0004h1-Ji
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDptY-0004eZ-G0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584365704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5y3zVJ9agYfIkSjCshsJDOCBV1/JfkGzSPzfPFAb4eQ=;
 b=iiTWxJjYyD/6qbCyOdkfgMJ0Ht2I3YYY6JBJblQ3N4iRMSnh5vWmIuBLUbYPYob28EcfZI
 uy3gC1mZiZ96BvG9Tn7oLsFCJlV9dcsMBP8nE4G2KkjX4ZNjVZ33IUpc9gg0cVnE0LpkRU
 dFptqfiBWBmGo3i63jxAQZ1QBwmAgjY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Vaifnft0OV2ERjojuQIAOg-1; Mon, 16 Mar 2020 09:35:00 -0400
X-MC-Unique: Vaifnft0OV2ERjojuQIAOg-1
Received: by mail-ed1-f72.google.com with SMTP id g11so15159248edu.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L8NZaPRy5KahWMSzf917XoQ45S1hIb5hIHIVmKrDkkM=;
 b=mom6EtetQlioXkRLiT9TDx4ggUqKC2CxfMwVuaixqnKyAshcdekCEk95aa1VjNWR5u
 oeQdoSlgLz+UQgruysJ9mrWykVcwPou4MXtjVmde13aqqfs160k22289CDbe/qFyW/XT
 ETqlIhvVdlGI0ffzbT3OThL6uBNUWSOl2fuseRDEy5swgPwBdduPWfRIYELch63HPPRx
 y8EWYO57wcZUX68okahVoQvEjZjmh8yruOHwv4afefY8tbrwBq1tUpwFV6RXP68war5S
 NOz1Q6VsyH5ZPh+VMYcm8Qv1wuPGnFPzPRM4A0/fPS2iZVnejCaKRjmoHRLLG/28etfY
 fjWA==
X-Gm-Message-State: ANhLgQ1+AQ7pVKoGqhh7ZG/C2kDWUG7Eb/ge57xM2FQGNPxXJgOlqVHl
 gzLP75YuQIDKg23rK/CoYAowHNt3pPHI2eQz42CT8ba2FlcDE80AcMxzkKvOBAnP4Y836uMYLs9
 VoYvARpGBnH/DEAM=
X-Received: by 2002:a17:907:20b3:: with SMTP id
 pw19mr23663997ejb.210.1584365699413; 
 Mon, 16 Mar 2020 06:34:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuXauRjTbwp1ztMkbxumcioXxJl4WKLFDEbtP7vMcP+u8Rs3SmvUvIx86o4QG8aQphAazEYiQ==
X-Received: by 2002:a17:907:20b3:: with SMTP id
 pw19mr23663974ejb.210.1584365699163; 
 Mon, 16 Mar 2020 06:34:59 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id v23sm190947eji.81.2020.03.16.06.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 06:34:58 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Mark the LatticeMico32 target as orphan
To: Michael Walle <michael@walle.cc>
References: <20200316122641.14017-1-philmd@redhat.com>
 <ea275f93229c9ec81a5f6cf3cc0f546a@walle.cc>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6896175e-2b24-1152-8bf4-8672a1b1ce6f@redhat.com>
Date: Mon, 16 Mar 2020 14:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ea275f93229c9ec81a5f6cf3cc0f546a@walle.cc>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 2:32 PM, Michael Walle wrote:
> Hi,
>=20
>=20
> Am 2020-03-16 13:26, schrieb Philippe Mathieu-Daud=C3=A9:
>> Michael Walle expressed his desire to orphan the lm32 target [*]:
>>
>> =C2=A0 I guess it is time to pull the plug. Mainly, because I have
>> =C2=A0 no time for this anymore. I've always worked on this on my
>> =C2=A0 spare time and life changed. And secondly, I guess RISC-V is
>> =C2=A0 taking over ;) It has a far better ecosystem. Also, to my
>> =C2=A0 knowledge the only (public) user of LM32 is milkymist and this
>> =C2=A0 project is dead for years now..
>>
>> =C2=A0 So time to say goodbye. It was fun and I've learned a lot -
>> =C2=A0 technically and also how a huge open source project works.
>> =C2=A0 Thank you everyone for that :)
>>
>> =C2=A0 Basically everything still works and there are even TCG test
>> =C2=A0 cases which covers all instructions the processor has.
>>
>> Many thanks to Michael for his substantial contributions to QEMU,
>> and for maintaining the LM32 target for various years!
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
>>
>> Cc: Michael Walle <michael@walle.cc>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Michael: Do you want to keep your M: entry, switch it to R: or remove?
>=20
> You can change it to R:

OK. Can I amend your Ack-by tag too?

>=20
> -michael
>=20
>> ---
>> =C2=A0MAINTAINERS | 2 +-
>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 32867bc636..5376c59581 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -184,7 +184,7 @@ F: include/hw/net/lasi_82596.h
>>
>> =C2=A0LM32 TCG CPUs
>> =C2=A0M: Michael Walle <michael@walle.cc>
>> -S: Maintained
>> +S: Orphan
>> =C2=A0F: target/lm32/
>> =C2=A0F: disas/lm32.c
>> =C2=A0F: hw/lm32/
>=20


