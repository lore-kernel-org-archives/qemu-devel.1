Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE572080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHP0rIm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE572080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iop2i-0005bO-8q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iooOe-0005KR-N1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iooOd-0001Rf-JW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iooOd-0001Qq-ES
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so17623029oib.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XzjZWE8JyRGUki5pLLbTtdbgjosvpu578AcmP5jKKLQ=;
 b=wHP0rIm0RLuG6uexGR916jzCBkXRwyEew1qNLJu4YG5UCLvOcXut+ewWdz99z816Sv
 Sy9uMbxp0vXSMYQ2utyIi1m/DEkuVjTj1LBEWBJO0jr+ec4YVGh2ehnAomx5Fd0ME6ZG
 asEpeJyZ23FivwSmRsXVL9B+ZUfMxh4WD5eZMChKw5mydkLUZyvEhwMzXJKHsfaq4EGf
 +ErukNxU3KV4uaVhORy4ayCcQyERZUDoVN+wsDe7THkNDfyUVPzabrAVcH2MbRgEhTux
 L2LTonKTN9t1dytVeTT47KZ7ipI3Ov4tTkWQk+GuCGZvtRJEfmtxSzAuV+7zKqZzxCkG
 ZhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XzjZWE8JyRGUki5pLLbTtdbgjosvpu578AcmP5jKKLQ=;
 b=rPgWeGgEOrnn7shzKd3krlcugPHAm6ZcyfDR7usafsP7qZqIQflQTZs1pncJVVb1lW
 7Wr+jJhBbA14OQKotq0x7fVfHRIaO3cfgT7qm8+WG+r8Mu9LdbzUMDwEvvHSmXDUk0+1
 EC1NrEGlNb1S6xFpBL4QXUU7ZqWc0ZNikZqe0blwlOrRVz5QYRnB/t/ctGWdqPcCYZXE
 ecmkhxRO1Wgyf1adctYgau8OhOygJYAadgCDWZHVIp43QQo2T+cPaD01yaDRL5IqPN/6
 fY4nY/zj8bGZxrItZsRKcFoBjCtul1+z8/tjjdifZSPZYl8ePdzNWKajE5mYWJ6VMaem
 VUeQ==
X-Gm-Message-State: APjAAAWIo8arvBZ7kbhHPY/9ANHfB7S8jqeXmIy9vF9sy2XNaTVW15qn
 Boio3DKa7RKfZR0x+EdpGHwwYVMuueaOEWSXVy+dTg==
X-Google-Smtp-Source: APXvYqyCmVCjNzmgQwwTQ4kq/CZrAtPWWgkAiw/sth8K/IB4okJsea15SZnCR+3bv0JPI5lLlrO+2NIQLzAJWKY2KPA=
X-Received: by 2002:aca:570d:: with SMTP id l13mr6631969oib.146.1578401742423; 
 Tue, 07 Jan 2020 04:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-13-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 12:55:31 +0000
Message-ID: <CAFEAcA99ajBCrmG=E6wPru2d3VYFzbvopfno8F62xvO8o3NikQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 13:47, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Memory mapped serial device is in fact a sysbus device. The following
> patches will make use of sysbus facilities for resource and
> registration. In particular, "serial-mm: use sysbus facilities" will
> move internal serial realization to serial_mm_realize callback to
> follow qdev best practices.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> @@ -1068,30 +1080,56 @@ static const MemoryRegionOps serial_mm_ops[3] =3D=
 {
>      },
>  };
>
> -SerialState *serial_mm_init(MemoryRegion *address_space,
> +SerialMM *serial_mm_init(MemoryRegion *address_space,
>                              hwaddr base, int it_shift,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end)
>  {

You might want to fix the indent on the other lines of
arguments here, but either way

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

