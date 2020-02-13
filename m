Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5CB20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHUzxY/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5CB20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GWu-0000Jn-PN
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2GV0-0007XR-3A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2GUy-0006uk-06
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2GUx-0006ox-Sl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581608026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDWid6/iq8siU8ZHevmjU4sE5uKGLFLX3QyEuxy3bsw=;
 b=ZHUzxY/41PCmSI5T/ZxUUbcXehYsLvqnBLjMLSLa+SUgdAaYh2sPvDQlGurGCd2vANLl+i
 Mrf9FtiEVXu5O5PQfMZXuJkGzY2CYKn1jjJdUFX6yDE8vL5BLLS4t2d19eQ50w/F6MY1vD
 0cSHE1E9HXCilpT/j7plgeYd6AgAINk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-wh8a24o0PFGD9s4QztFBRg-1; Thu, 13 Feb 2020 10:33:40 -0500
Received: by mail-wr1-f70.google.com with SMTP id t6so2495250wru.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 07:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lnyI72nC5aJyDHvLxnHY68BclaJOoav9SKihz+lhs3s=;
 b=jeD3fdfscrOTNH114mEHhGTdQHiBdL3YLubH2crMs9CebNVpuU4t89pZpO4dfIG4ld
 Hct8AKvbBb/pyihbV66nswzJAixr76LDNzqUscRrKlqeW6q7kSJmpvx4TIfIVbN0kKqR
 wvadWl9MA+p1dt9da5d/JscX6qnN8rE9w2z5b4jtfxn++5XV1FbAKXeTMH4CpcjV+9vN
 9s7KmHX9owNKOTXy7WTsoUmArVgQIfIcug4+AOP17x2EXHlrD4AvDd1lZruoKx4Ux1EM
 mmD7Gl9fNnsK0YC69n++WpFKN3BrHXMUnMMMBGtcfQC3Mb02a4X6Q9ZdzyXaD0+qvFok
 uQyA==
X-Gm-Message-State: APjAAAXl2uHv2W3CW20VC1DrleeBYngZpYHwo/3HiGHOySzAtfIXYs8B
 DJjabCTshxnNLLEJ5Y0GrEhicNxDNoXBZNzXQWKBJL9e1Pu4aDGM7yrWVQGlE3IqmYr1xecQbVG
 ARZKk1bsemVNsax8=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr23495891wrs.217.1581608019534; 
 Thu, 13 Feb 2020 07:33:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg/1vydOdoQIVQxpqJka6ohDjJsEBhtsdTV8ZkKJuOBOl3rs7y1oILJtTWgHUWvWlsniXojg==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr23495868wrs.217.1581608019289; 
 Thu, 13 Feb 2020 07:33:39 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t128sm3618227wmf.28.2020.02.13.07.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 07:33:38 -0800 (PST)
Subject: Re: [PATCH v3 12/13] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-13-f4bug@amsat.org>
 <CAFEAcA8e4NqwKPM6qx=vKm6NOz__=S90trhUuhaSNe_yJ8GeXg@mail.gmail.com>
 <0d72fad3-3eef-66ff-2162-f0c07ba01ff2@redhat.com>
 <CAFEAcA9x6=Hxqwjacc3ZXUJy1P0xxKt-oqiZf1Fm=f1d8f63xQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d3e9caeb-345c-4596-eff1-059a8cc94a8e@redhat.com>
Date: Thu, 13 Feb 2020 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9x6=Hxqwjacc3ZXUJy1P0xxKt-oqiZf1Fm=f1d8f63xQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: wh8a24o0PFGD9s4QztFBRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 3:32 PM, Peter Maydell wrote:
> On Thu, 13 Feb 2020 at 14:16, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> On 2/13/20 2:59 PM, Peter Maydell wrote:
>>> The natural way to implement this is to have the .class_data
>>> be a pointer to a struct which is in an array and defines
>>> relevant per-class stuff, the same way we do in
>>> bcm2836_register_types(). That way the struct can indicate
>>> both the board revision number and also "is this a legacy
>>> board that needs transaction-failures disabled?".
>>
>> IIUC Igor insists explaining that he doesn't accept anymore a
>> ".class_data pointer to a struct which is in an array and defines
>> relevant per-class stuff" and we should not use this pattern anymore.
>=20
> Huh? How else would you do this? I'm kinda dubious about the
> pattern this patch series uses of just stuffing a 32-bit board
> ID number into the class_data field, to be honest -- I let that
> pass partly not to hold up the series but partly because I
> expect that we'll need to turn it back into a proper pointer
> to a data struct soonish.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg678305.html

Igor> we sometimes use .class_data when creating many
       derived types (typical example CPU types (x86))
       where it's impractical to code leaf class_init
       functions. I'd use .class_data in cases where I
       can't get away with explicit .class_init

Which I understand as:

- avoid .class_data (pointers to structures)
- explicitly set ObjectClass::fields in .class_init()
   by open-coding all.


