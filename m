Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D9C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53E220865
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4ZGH9a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53E220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibXlZ-0004XS-1J
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 17:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibXke-000400-6Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibXkc-0006KO-Tq
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:31:35 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibXkc-0006K9-Nr
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:31:34 -0500
Received: by mail-oi1-x244.google.com with SMTP id j22so311865oij.9
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w7F4VBjJzLVDVvrTxAEbhzicn/QifA6Kt+COVO7sJEY=;
 b=z4ZGH9a1AFSpuYwTuzSu5tCiP/SwhHW8TzxS2JG04NJ0Ybbgrn2AyMDAY0MbJBr5AN
 THpWmOXpFG8icza/X3kyrQkOB0bekH7a3Rg9CYaGQE6UNcp3d/mINh2RajVursy+v1SP
 qgqhG3G8I1vQOg27kBqKUYw1vzMgY8CMquFI4z7aV9/c5BDM2nIi3ooEjLj+RRpiVZWY
 O/ZwbWPiT422GnMaQs6+4WGoBoCbR9HCDmJxDaW9ZwL1Huq4qNUel11Pn59pkh+DekvZ
 yVHQYY5wm167TE6tUw3g/yTKua2qkhgUCVyCCpQO0HSXj9irc5geQZ5Z9LrHf+I1VUmj
 EXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w7F4VBjJzLVDVvrTxAEbhzicn/QifA6Kt+COVO7sJEY=;
 b=gsNLpITCWsF9b5xVxgN1ubJe2zGdaQ8y1RjeZjOtAR/z2qs3jJQfLhty5607ckevmx
 7EMe6zAbM0np73/MlE5hxc6Mq/6byIPgL7iZ/arHgTklgGlxfAkzPh9lrJMtw1RAsLne
 z4xsecR8bp4wNssA2lv6sRRTVBno36+gzYJoSIFxziYAfplOp93QM50pNxZDJmOOMf00
 FFJ0BkFUTJjZnGMp16GHjnocJ4pJo5YfEPL3C33ybNW/s0+jEA2XEl2Wq602XA85zOLx
 SQWJoRBvQcs0Q+HD5lVHcMDGZ6rXS2Jz4mSKTTR8RMNKVFFpqzmSQtACdF5wteBPFoaa
 w7JQ==
X-Gm-Message-State: APjAAAWYWyN5nbxVpBfC/C77DllTsdOH2hJMcjfbyFgcYH208Ti8ZRc6
 beHx2JBfp8U844DLo8sPH/rjr0SU7Yx7+cvLByD5dA==
X-Google-Smtp-Source: APXvYqy0sUyVSR/xwo4pjRRKuoPEtZ8KuA3KXTPeI/v8/tjIkzCtbgLrg6D+10AMK5CAxRj7MfUlBmY1xMLYYqv9oWM=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr10040049oih.98.1575239493528; 
 Sun, 01 Dec 2019 14:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
 <3e2857fd-aa5e-acc5-edd6-359715a636a6@linaro.org>
In-Reply-To: <3e2857fd-aa5e-acc5-edd6-359715a636a6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Dec 2019 22:31:22 +0000
Message-ID: <CAFEAcA90u0GsZZTX6EB0AzrS+A-ErTEGE2XVeJH8wvSmfF80tQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Allow loading elf from aliased ROM regions
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "martin.galvan@tallertechnologies.com"
 <martin.galvan@tallertechnologies.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Jean=2DHugues_Desch=C3=AAnes?= <Jean-Hugues.Deschenes@ossiaco.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Dec 2019 at 20:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/25/19 12:41 PM, Jean-Hugues Desch=C3=AAnes wrote:
> >              initial_msp =3D ldl_p(rom);
> >              initial_pc =3D ldl_p(rom + 4);
> >          } else {
> > -            /* Address zero not covered by a ROM blob, or the ROM blob
> > -             * is in non-modifiable memory and this is a second reset =
after
> > -             * it got copied into memory. In the latter case, rom_ptr
> > -             * will return a NULL pointer and we should use ldl_phys i=
nstead.
> > -             */
> > -            initial_msp =3D ldl_phys(s->as, vecbase);
> > -            initial_pc =3D ldl_phys(s->as, vecbase + 4);
> > +            /* See if the ROM blob is aliased somewhere */
> > +            hwaddr len =3D 0, xlat =3D 0;
> > +            MemoryRegion *mr =3D address_space_translate(s->as, vecbas=
e, &xlat,
> > +                    &len, false, MEMTXATTRS_UNSPECIFIED);
> > +
> > +            if (mr) {
> > +                rom =3D rom_ptr(mr->addr + xlat, 8);
> > +            } else {
> > +                rom =3D NULL;
> > +            }
> > +
> > +            if (rom) {
> > +                initial_msp =3D ldl_p(rom);
> > +                initial_pc =3D ldl_p(rom + 4);
> > +            } else {
> > +
> > +                /*
> > +                 * Address zero not covered by a ROM blob, or the ROM =
blob
> > +                 * is in non-modifiable memory and this is a second re=
set after
> > +                 * it got copied into memory. In the latter case, rom_=
ptr
> > +                 * will return a NULL pointer and we should use ldl_ph=
ys
> > +                 * instead.
> > +                 */
> > +                initial_msp =3D ldl_phys(s->as, vecbase);
> > +                initial_pc =3D ldl_phys(s->as, vecbase + 4);
> > +            }
> >          }
>
> Can this entire section, including the rom_ptr thing just above, be repla=
ced
> with two address_space_read()?

No. This is a reset ordering problem. The CPU reset happens
before the 'rom blob loader' reset, so at this point the
rom data (usually an ELF file segment) has not been written
into ram, and doing an address_space_read() will just read
zeroes. This is also why the aliasing issue happens at all --
the rom blob is at a particular address, but if the address
we use here to try to read the data is an aliased variant
of it then rom_ptr() does the wrong thing.

My preference for fixing this properly is:
 * get Damien's three-phase-reset patchset into master
 * make the ROM blob loader write its data into ram
   in phase 2 ('hold')
 * make the arm CPU reset read the data in phase 3 ('exit')

This last matches better what the hardware does -- the
M-profile CPU reads the vector table in the first couple
of clock cycles when it *leaves* reset, not while the
CPU is being *held* in reset. This kind of thing is
always awkward to model in an emulator, especially if
you were hoping to also handle allowing the PC to be
set from an ELF file entrypoint or by the user in the
gdbstub on startup...

thanks
-- PMM

