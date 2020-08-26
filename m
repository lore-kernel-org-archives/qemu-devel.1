Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB15C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 20:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECA1207DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 20:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR38mS5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECA1207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB1uw-0006Zv-Rh
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 16:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kB1tz-000656-LP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 16:20:11 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kB1tx-0004h9-Uq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 16:20:11 -0400
Received: by mail-qk1-x742.google.com with SMTP id x69so3537413qkb.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MSjjLAIMB/ZyQA9S1gXv2f0fDXxr11ah9XT/8CC1Dwg=;
 b=LR38mS5AWZ6LBN8O5D4BHQYhhb4nmMFWuvfVuM/I9uqSsS0JcfJLoTNJn+efmr3ZBk
 hEZSHKfWmpgODukG8/Ae+x/cDPEj1JOxbuFSg3xAOZ+N7Xxs2Osi8GdFKEm4zkUctv4+
 X+n59q8CtdS70nGTNI2cLbs3sgSBgVeXjtV28xNUraMOBj96kAkF8YHHu97bwJu7ZBlL
 cRhvmaq83PnTc31/XMW4h2chhMx/oFIhhASTQFXhBqsZ/EOTqI3zo9H6gAKByKnVTtHy
 gd591r6a05M15ig0Blvf7ge8EFe+xZgJshVkqQBntHmuqycqrVGDRCs2k2QVCRqqn8jN
 wSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MSjjLAIMB/ZyQA9S1gXv2f0fDXxr11ah9XT/8CC1Dwg=;
 b=J6q2uavNDqoKJEBr5GtPmkpnfl7DsGGSkuzo08QUE5qISyJIQf6Zs9YZZvedd4AT7b
 y6wq+iB4H1HyboNhd9hQEJBJybjllUqqZXX114ZoiFvR0/jFgTrX2TdDU2wy+hDefcCr
 TwmA8KDpiqJkG6XqWPTz/bfQWXLK0Vt4+y5seGJZQ6pgWHFK/PMFnH5WuCN3UpP5tLcf
 Ct2Fw0YSyFnu75x963tFdcMC5VnmcBiDhRVuh5LH3gHvB9/J0jv5/Vd1nnBQeg4H8CQM
 eL1jx/Ji/Ve760PfFZjSkChEMCahYeSCK6YSVtJlQXco8z4XyZQ5sFZh556WucP+BfdC
 hmTQ==
X-Gm-Message-State: AOAM530Qbbm7aK1CtL71GLj92wVz0RgSlT6TrZGAbMffeC47Rp5eFWl/
 n72poeITEOX3v4XFd4jl2rfDr6/iIb8j/8PqPy0=
X-Google-Smtp-Source: ABdhPJwn+M9+6q6ZgYjVjdoFkQOG8u3wRNZ96LVViq4wZPb/VJP6midii1y5l0CpUBsYxqygHvbXosiKxPuHTFaU5Rk=
X-Received: by 2002:a37:e52:: with SMTP id 79mr15129389qko.460.1598473208612; 
 Wed, 26 Aug 2020 13:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200814163924.11662-1-f4bug@amsat.org>
In-Reply-To: <20200814163924.11662-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 26 Aug 2020 23:19:31 +0300
Message-ID: <CAK4993hM=nZqkCr-CSPHabUz3YiwWMv=zMK8u1rZw2f3U88-xg@mail.gmail.com>
Subject: Re: [PATCH 0/5] hw/avr: Start using the Clock API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000c84a2c05adcd8b63"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=mrolnik@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c84a2c05adcd8b63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Michael Rolnik <mrolnik@gmail.com>

On Fri, Aug 14, 2020 at 7:39 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> In this series we slowly start to use the recently added
> Clock API in the AVR ATmega MCU.
>
> As the Clock Control Unit is not yet modelled, we simply
> connect the XTAL sink to the UART and Timer sources.
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/avr/atmega: Introduce the I/O clock
>   hw/timer/avr_timer16: Use the Clock API
>   hw/char/avr_usart: Restrict register definitions to source
>   hw/char/avr_usart: Use the Clock API
>   hw/char/avr_usart: Trace baudrate changes
>
>  hw/avr/atmega.h                |  2 ++
>  include/hw/char/avr_usart.h    | 32 ++---------------------
>  include/hw/timer/avr_timer16.h |  3 ++-
>  hw/avr/atmega.c                |  8 ++++--
>  hw/char/avr_usart.c            | 46 ++++++++++++++++++++++++++++++++++
>  hw/timer/avr_timer16.c         | 12 +++------
>  hw/char/trace-events           |  3 +++
>  7 files changed, 65 insertions(+), 41 deletions(-)
>
> --
> 2.21.3
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000c84a2c05adcd8b63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-il">Tested</span>-<span class=3D"gmai=
l-il">by</span>: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 7:39 PM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"=
_blank">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">In this series we slowly start to use the recently a=
dded<br>
Clock API in the AVR ATmega MCU.<br>
<br>
As the Clock Control Unit is not yet modelled, we simply<br>
connect the XTAL sink to the UART and Timer sources.<br>
<br>
Philippe Mathieu-Daud=C3=A9 (5):<br>
=C2=A0 hw/avr/atmega: Introduce the I/O clock<br>
=C2=A0 hw/timer/avr_timer16: Use the Clock API<br>
=C2=A0 hw/char/avr_usart: Restrict register definitions to source<br>
=C2=A0 hw/char/avr_usart: Use the Clock API<br>
=C2=A0 hw/char/avr_usart: Trace baudrate changes<br>
<br>
=C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 ++<br>
=C2=A0include/hw/char/avr_usart.h=C2=A0 =C2=A0 | 32 ++---------------------=
<br>
=C2=A0include/hw/timer/avr_timer16.h |=C2=A0 3 ++-<br>
=C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 8 ++++--<br>
=C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 46 +++=
+++++++++++++++++++++++++++++++<br>
=C2=A0hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++-----=
-<br>
=C2=A0hw/char/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +++<br>
=C2=A07 files changed, 65 insertions(+), 41 deletions(-)<br>
<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>

--000000000000c84a2c05adcd8b63--

