Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3EFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C906220718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWF9iaJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C906220718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7gt-0005zS-1I
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7eO-0004bj-VM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7eL-000597-3y
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:02:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7eK-00058n-4W
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574424174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qqp1bQCtnOA38nEDjudybzwk8dZdSL/3Jw5V9zkc0E=;
 b=HWF9iaJw7Kxz85dGZXe6OpPQJ/qKPjhi4cPCg0TWoyAAQnHPqtqqUaq/Qk29B2oY/upwz/
 uJYAjwmnhFktH7ba/7I15l5xM5rGAS57cFBtDyO6Ge3dV+H34GHXjJC98wI5T2FZ/FmUp7
 IVxIGHoaSJKDx+hfAYYOlT9uznIUQyM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-vErzXCLyPxm0WrAlb1W4WA-1; Fri, 22 Nov 2019 07:02:51 -0500
Received: by mail-wr1-f71.google.com with SMTP id g17so3811060wru.4
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BbG3Qoy1OQAkkonrI22UigMm9E2ica7aZx9Hmwevn8s=;
 b=VhAwiR5WgTXwOW+T7ARyXd+Im/GHg9Hmj/63McOn0XS3R2nCoVoMfXk7UCPshkJmZX
 Rvs0MdfB0JrhNQItK+sCg6XQ+PQF0xUH4nAiLGYzRgsVbRQeDei8HKf1dF+cgsqhqJBc
 VvDaCJBHbfhKTo1hFAqaWHTkCA2l9BCV8vOtx+aeBeHRdXdgyre6ze61CANxHJzC9Eep
 wrIqm8AY2jyzDEl5Tdju6AMQtAhz0890YVEhYWnXAv9Mel246+g0lSsHsYazpJfNRBoz
 iPVhzHsH18MhaGnoZVuugfW4R+wuEVjLIQRIp/qm8BxSzClbtds5rkaAwUihk6ZHMLuE
 ddJg==
X-Gm-Message-State: APjAAAVxKMzmDyxJzYRJWuf6NAaST3CQPnm7cMph2xycnYJix0zk6uYm
 WvJrM3sFiFgrn5DAHUIzqTnOmTdMA4thKHs0ac0yneyKXD707qpo2615gJTs4Bd/A33Ykrj1IBX
 pOUd3OQsA7suCR5M=
X-Received: by 2002:a5d:6706:: with SMTP id o6mr17295285wru.54.1574424169839; 
 Fri, 22 Nov 2019 04:02:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPYFSy9jweOY9SEnVzn0BHTY2KjfcpC1iaAvqiSkxMI0JahGYtvvUfit/RLhlTGpuxAHLDHQ==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr17295265wru.54.1574424169591; 
 Fri, 22 Nov 2019 04:02:49 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id o189sm3430787wmo.23.2019.11.22.04.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 04:02:49 -0800 (PST)
Subject: Re: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-11-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c8a8db9-e81a-baa0-db03-81523d2c6f0e@redhat.com>
Date: Fri, 22 Nov 2019 13:02:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-11-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: vErzXCLyPxm0WrAlb1W4WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, Sarah Harris <S.E.Harris@kent.ac.uk>,
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> From: Sarah Harris <S.E.Harris@kent.ac.uk>
>=20
> These were designed to facilitate testing but should provide enough funct=
ion to be useful in other contexts.
> Only a subset of the functions of each peripheral is implemented, mainly =
due to the lack of a standard way to handle electrical connections (like GP=
IO pins).
>=20
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ---
>   hw/char/Kconfig                |   3 +
>   hw/char/Makefile.objs          |   1 +
>   hw/char/avr_usart.c            | 324 ++++++++++++++++++
>   hw/misc/Kconfig                |   3 +
>   hw/misc/Makefile.objs          |   2 +
>   hw/misc/avr_mask.c             | 112 ++++++
>   hw/timer/Kconfig               |   3 +
>   hw/timer/Makefile.objs         |   2 +
>   hw/timer/avr_timer16.c         | 605 +++++++++++++++++++++++++++++++++
>   include/hw/char/avr_usart.h    |  97 ++++++
>   include/hw/misc/avr_mask.h     |  47 +++
>   include/hw/timer/avr_timer16.h |  97 ++++++
>   12 files changed, 1296 insertions(+)
>   create mode 100644 hw/char/avr_usart.c
>   create mode 100644 hw/misc/avr_mask.c
>   create mode 100644 hw/timer/avr_timer16.c
>   create mode 100644 include/hw/char/avr_usart.h
>   create mode 100644 include/hw/misc/avr_mask.h
>   create mode 100644 include/hw/timer/avr_timer16.h

I haven't read all the other review comments yet, so I'm not sure you=20
need to respin a new version of this series.

In another review I suggested to rename 'avr' -> 'avr8'.

If you have to send another version, can you split this patch in 3?
IRQ/TMR/UART.

[...]
> +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
> +{
> +    uint16_t divider =3D 0;
> +    switch (CLKSRC(t16)) {
> +    case T16_CLKSRC_EXT_FALLING:
> +    case T16_CLKSRC_EXT_RISING:
> +        ERROR("external clock source unsupported");
> +        goto end;
> +    case T16_CLKSRC_STOPPED:
> +        goto end;
> +    case T16_CLKSRC_DIV1:
> +        divider =3D 1;
> +        break;
> +    case T16_CLKSRC_DIV8:
> +        divider =3D 8;
> +        break;
> +    case T16_CLKSRC_DIV64:
> +        divider =3D 64;
> +        break;
> +    case T16_CLKSRC_DIV256:
> +        divider =3D 256;
> +        break;
> +    case T16_CLKSRC_DIV1024:
> +        divider =3D 1024;
> +        break;
> +    default:
> +        goto end;
> +    }
> +    t16->freq_hz =3D t16->cpu_freq_hz / divider;
> +    t16->period_ns =3D 1000000000ULL / t16->freq_hz;

Please use NANOSECONDS_PER_SECOND here.

> +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%f =
s)",
> +             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
> +end:
> +    return;
> +}

While trying this patch it looks the timer fires too fast (or maybe=20
doesn't use the correct clock rate).

When looking at the instructions in GDB render the debugging of timing=20
issues pointless (which is why I wanted to compare the asm executed with=20
the IRQ timed events on stdout).

I should have some time to continue investigating Sunday evening.

Regards,

Phil.


