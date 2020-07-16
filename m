Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D11E20739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZj4gLw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D11E20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6kP-0006jE-Hd
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6jX-0005t7-Ie
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:27:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6jV-0004O5-Si
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:27:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id w17so4674489otl.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ScoVINGlgfjGqDbzrrOJ3j3V+rrZMzmFKcDXiYTT9ws=;
 b=qZj4gLw6k+50nEr62irkYRiN9ICRkzfXWl6iiHIy3/WfSfTHG3TW8dEzJXVxlYGrow
 +ty21DIZtkBGs8XqP5Pk1RR1aSWbpzVlPtfU1PnwUGfR6IrWOYNIGTOW+5TDrOPB127O
 4KLjO+sOj4c0rEgZ9R4rhCo/AXhUoalcT/83KzzesjwgGCKSYwNaDD52CX4+pDA3W3gR
 7KBTUjq2FCXX3Sj9ifsM10rEF1wMiHQrsLjirUA20ct1ne7J/+dFkFxlzNi/FB6wQsEl
 qULXmJEWbGbIdp72t81PjQpjIFUhnsiQzcTzHHEUxQdUp6HsHioN4GNihnVQxZ5XDeXL
 3TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ScoVINGlgfjGqDbzrrOJ3j3V+rrZMzmFKcDXiYTT9ws=;
 b=YTgEQxBLX15nOn8nUlUtNKgbhyqC+WnZa+C+5vmXxPC5W84cQmu7epyrepi8Bazsk6
 MqzVfmcDesdG3SGGT8MUAgD4JQ/zPgion5U0LoBBqjf61UoVP+OlXWu3dTX0DsSu0GGY
 M8zTZ/V9IIgt75uBD8DwloANGxdqN1m/KcBj5gSjULzhWug73CK1PJ4H16GCRUDER3N9
 K5drr1G4rShgfFkZqplfDoitnRqwgiUpbAI7ACKHOJMfLtE3Inq6sn0IiTplWG0b6Skv
 GYN+nEpfIQNz+kxc0TXIVmQf+JEEukcKfs6BMGZFAcEfUZYXTQ9Ik5ZDHjduItARQBJQ
 uJ+Q==
X-Gm-Message-State: AOAM5332ZRLyxsLKdeKWS2R+4zbbYKDUHYU3ZwUzOLL5HgmGjFrmtaBL
 C9ow/Yzu3YPjQa/x+kSsiIH5J/KNkodcHfCrCdh5+g==
X-Google-Smtp-Source: ABdhPJynR21N+qRPfxR/peExZ7hYALWaWwaAOu7NMqjfK/v+0Hk0nGjQ/OnC4LYeL0JVxMLXTkNVwgpUtdu9/T5ajEo=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr5005986otk.221.1594916860755; 
 Thu, 16 Jul 2020 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
In-Reply-To: <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:27:29 +0100
Message-ID: <CAFEAcA8s8-OCmKEJsp6bJXBXH+JiyxrtSbHPiLimCj8+xz3obw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
To: Li Qiang <liq3ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 12:18, Li Qiang <liq3ea@gmail.com> wrote:
>
> P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > Add nrf51_soc mmio read method to avoid NULL pointer dereference
> > issue.
> >
> > Reported-by: Lei Sun <slei.casper@gmail.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/nvram/nrf51_nvm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > Update v2: return ldl_le_p()
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04972.htm=
l
> >
> > diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
> > index f2283c1a8d..8000ed530a 100644
> > --- a/hw/nvram/nrf51_nvm.c
> > +++ b/hw/nvram/nrf51_nvm.c
> > @@ -273,6 +273,13 @@ static const MemoryRegionOps io_ops =3D {
> >          .endianness =3D DEVICE_LITTLE_ENDIAN,
> >  };
> >
> > +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> > +
> > +    assert(offset + size <=3D s->flash_size);
> > +    return ldl_le_p(s->storage + offset);
> > +}
>
> The 'flash_ops' is for ROM, though I don't see where it calls
> 'memory_region_rom_device_set_romd'
> to ROMD, so this MR is in MMIO mode and it needs a read callback.

I think that 'romd mode' (ie reads-go-directly-to-RAM) is
the default: memory_region_initfn() sets romd_mode to true.
So unless the device actively calls memory_region_rom_device_set_romd(mr, f=
alse)
then the read callback can't be reached.

thanks
-- PMM

