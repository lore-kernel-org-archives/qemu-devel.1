Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F36C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 04:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F18B206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 04:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWGT9mzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F18B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwfLx-0002g7-Nj
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 23:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oohall@gmail.com>) id 1iweR1-0004aR-7b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oohall@gmail.com>) id 1iweR0-0003z1-6K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:54:35 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <oohall@gmail.com>)
 id 1iweQx-0003uP-N3; Tue, 28 Jan 2020 22:54:31 -0500
Received: by mail-io1-xd41.google.com with SMTP id x1so17009312iop.7;
 Tue, 28 Jan 2020 19:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hsHsOOw82JozGDUYHUPYYsueH21rnVXvpPAeBr9C3U8=;
 b=FWGT9mzukhDOI9+BuLkkbZGLFV9ngiPdCwH1NysR52vfWUHJU+gNCgS6sHpPzB0GXY
 9RPLPlojQ1VvukcUSUhAGxdGp2oTmMEd5JtWuxyZVaK4O10enYEwZ2t2J4pr4kTJkbVl
 SyAYDWpZvZpul9IXuBX3uyHCorFjgkvQ9s6pLKBKXYmfPqULug31OvFKoIblEhE4kIM2
 OHO0sMaTwUDLNVZ8foaGkhMC3eMoG4y/TFV3JOzL6Dt6GbbT7HDMb2+GrT+8wz2d1dKo
 OOus0gj3y/m3sClka6paZjwiiQNvylvxgKzHsQDvgLutmuRi/KHgByjMXuAWITSJ/kDz
 DjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hsHsOOw82JozGDUYHUPYYsueH21rnVXvpPAeBr9C3U8=;
 b=EuhpFd+AeVfnvpSHg9QSBSwpLL5tpl/cqM3JVjDfEE2RQiW3D5vpL2hWq+gX6GDeAe
 /tIk8Dv4z3brBdsaD1Faj1h186eNsCjxDU1aeUkTPEHhbTeoWgaiu6UYzwTfjN3+Dw87
 25LsO795mAEwzALpRwVEbEuw3qx22FEX/u5uRhAlHEs3xAm5cxMu68ll5N1i7eZVnv+D
 VW/UnSXhp/7lkuRvqPBUzRFQfDg6heYln8XQ90Z/MMsYx6YkjoyihWBp5dNwKBk1CPxi
 ehVXRkN3dKLVQvUO02Oova/YpNvM1w3VddffQ7GmCAFkfZ2EOOAVNizc4+WXQQaoGPFY
 kyeQ==
X-Gm-Message-State: APjAAAV+2brxdabbyf6fMVp7eyE7E4QPANhl1ACiZVAPgl5yJ1B7mqU+
 3Ho+HRYO+5f3cXudUNXqFZslnQ6SuTv8+Ce9p9A=
X-Google-Smtp-Source: APXvYqxdZ7XrgRr3OtMKol9AU3Y66STYYA2Bd8b5p9hzWJQcGtZMVITZXcdx66FMYDInq4GBOBMbh/LlLsk5weY8E9s=
X-Received: by 2002:a5e:970a:: with SMTP id w10mr19452875ioj.195.1580270070647; 
 Tue, 28 Jan 2020 19:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20200127144506.11132-1-clg@kaod.org>
 <20200127144506.11132-2-clg@kaod.org>
 <20200129030920.GX42099@umbus.fritz.box>
In-Reply-To: <20200129030920.GX42099@umbus.fritz.box>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 29 Jan 2020 14:54:19 +1100
Message-ID: <CAOSf1CHvYOMd2cjQDLT44QxyQakkV6a8eBrWX+V6FhQMQh2GWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
X-Mailman-Approved-At: Tue, 28 Jan 2020 23:52:43 -0500
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 2:09 PM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Mon, Jan 27, 2020 at 03:45:05PM +0100, C=C3=A9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >

*snip*

> > +
> > +/*
> > + * The CONFIG_DATA register expects little endian accesses, but as the
> > + * region is big endian, we have to swap the value.
> > + */
> > +static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
> > +                                  unsigned size, uint64_t val)
> > +{
> > +    uint32_t cfg_addr, limit;
> > +    PCIDevice *pdev;
> > +
> > +    pdev =3D pnv_phb4_find_cfg_dev(phb);
> > +    if (!pdev) {
> > +        return;
> > +    }
> > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
> > +    cfg_addr |=3D off;
> > +    limit =3D pci_config_size(pdev);
> > +    if (limit <=3D cfg_addr) {
> > +        /*
> > +         * conventional pci device can be behind pcie-to-pci bridge.
> > +         * 256 <=3D addr < 4K has no effects.
> > +         */
> > +        return;
> > +    }
> > +    switch (size) {
> > +    case 1:
> > +        break;
> > +    case 2:
> > +        val =3D bswap16(val);
>
> I'm a little confused by these byteswaps.  As I see below the device
> is set to big endian, so the values passed in here should already be
> in host-native endian.  Why do you need the swap?  Are some of the
> registers in the bank BE and some LE?

All the registers are BE except for CONFIG_DATA, which isn't actually
a register. It's really a window into the config space of the device
specified in CONFIG_ADDR so it doesn't do any byte-swapping.

> > +        break;
> > +    case 4:
> > +        val =3D bswap32(val);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
> > +}

