Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F1C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866722067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6rlhuoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866722067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9oa6-0003ss-Oq
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9oZ2-0003Ot-Cj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9oZ0-0007FO-6y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:48:59 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:44763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9oYw-0007C4-7x
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:48:56 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w6so7841521oie.11
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gidqp/+wCIOdU/Ink9nn+5CZpgw7x8SvzULjtnLSzYY=;
 b=j6rlhuoTVUvascH2/QIPjixotb0RLVMA10RGdg8LGubchRLgNSGF6FjgU6vkXef03o
 /53DpMi4W/c9ifenHTC7DNw5X9CbANvakznlKXgG3L7fQvuw5JXZ05w7iFmixjv0mD8C
 7V24gjYjeDYxGcPDqAYWtN2alGcqxY69CHdMQbmg+DwxZEwGxw1JKfXux8HhqAGCkFlQ
 flu2M4tt3wCroUAOofg0yr3fO7yUszSRFOX1N+5hUgIFnQkdsSpxumovTgz1CaWB80WF
 CbbyewXi57djUbR3GD9wz+c6N5qfUJPvTQq32Zso1KLHXxQx2/2Dniizef9rLuyJSXg2
 lu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gidqp/+wCIOdU/Ink9nn+5CZpgw7x8SvzULjtnLSzYY=;
 b=YwJ9dIl0Dq5CLNKjfqtXJoCLBx1OsI7FX2asnr+xQUFJRGztufITIcdxweHGsBXMwZ
 dQzNFRuzj03AAYVHb3fmwq03RLVBOZ4OpnD+EDv+n9iyde3W3a909c/EP+/QI5eDLX3N
 54mc9wrxv5/0rWmedByFYAFtmfinrw86rxz1RFEylfLM8TXOijma+0oqyLLE9TGHx5Br
 dVyk3eP02cyFH/+M9lnnMx5pY5pT8CJH7n0rqxbBzI6QVZm9p2zB50EZzPocXN7o7JOg
 1vCs3RhBuSpoWm7A5mBB8KFAl14scRr823y7zUwSH3Qh5Kchjj6Le7ssjuCCmD8ek4Gh
 BADw==
X-Gm-Message-State: APjAAAUtuOOHcMxGsiAZOGaIOa9bSiOmPqGQValOPNYewawEH7YFCQFz
 BixeHlbElmGGucqsbpS4PABmS3Mc53929BnEEBRTTr8K0AY=
X-Google-Smtp-Source: APXvYqzNYX58WHj3+dofkjGGybX5Nept7oX1p5eunNas4yv/wVzsl6+OceKY/m07CpBck+8BVmzRIADlT2asEhRwzuQ=
X-Received: by 2002:aca:b646:: with SMTP id g67mr4672690oif.163.1568630932161; 
 Mon, 16 Sep 2019 03:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190907154744.4136-1-huth@tuxfamily.org>
 <20190907154744.4136-4-huth@tuxfamily.org>
In-Reply-To: <20190907154744.4136-4-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2019 11:48:40 +0100
Message-ID: <CAFEAcA-cDGV-=dDTOcTZv+a5ffd5gq9YVPnbKS3e9vi-QkndOw@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 3/8] m68k: Add NeXTcube machine
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

On Sat, 7 Sep 2019 at 16:47, Thomas Huth <huth@tuxfamily.org> wrote:
>
> It is still quite incomplete (no SCSI, no floppy emulation, no network,
> etc.), but the firmware already shows up the debug monitor prompt in the
> framebuffer display, so at least the very basics are already working.
>
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>
> and altered quite a bit to fit the latest interface and coding convention=
s
> of the current QEMU.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190831074519.32613-4-huth@tuxfamily.org>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org

Hi; Coverity spotted an issue in this function
(CID 1405664):


> +static void nextscr2_write(NeXTState *s, uint32_t val, int size)
> +{
> +    static int led;
> +    static int phase;
> +    static uint8_t old_scr2;
> +    static uint8_t rtc_command;
> +    static uint8_t rtc_value;
> +    static uint8_t rtc_status =3D 0x90;
> +    static uint8_t rtc_return;
> +    uint8_t scr2_2;
> +


> +                /* read the status 0x31 */
> +                if (rtc_command =3D=3D 0x31) {
> +                    scr2_2 =3D scr2_2 & (~SCR2_RTDATA);
> +                    /* for now 0x00 */
> +                    if (0x00 & (0x80 >> (phase - 8))) {

0 & anything can never be true, so the line below here is dead code.

> +                        scr2_2 |=3D SCR2_RTDATA;
> +                    }
> +                    rtc_return =3D (rtc_return << 1) |
> +                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
> +                }
> +

Incidentally, I see that this file has quite a lot of
what seems to be essentially device emulation code in it
(a bunch of IO MemoryRegions defined locally) -- ideally
these could be split out into proper device objects at
some point.

thanks
-- PMM

