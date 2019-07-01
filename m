Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53DCC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825CA208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCStNmCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825CA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwDL-0002pI-LE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhw1r-0002j6-Oh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhw1n-0007xH-UI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:07:29 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhw1n-0007J8-Oe
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:07:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id w196so9872543oie.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GFpVemuNL7UhbLtjtR7O0P9wazBxTV9UABGaJgXIshY=;
 b=dCStNmCPt9WreNdovNC0xder7dlBrJLvhhkZWT1qlkbg4dEiQbVJB3ZbzBGNofHaJl
 FdyLODZlX5wuBaaQjzrsBf5KNT6WqFQN3Ic3lxvAxailNNP4JBrxfpVQE0dqc+jlP5V4
 y6cLwJ7TG4Z1hLR8v02XTRhZgCp6CpJ47hmnvZLTLioFGv8C0N+OByjGnj71F3UzXNaw
 1mtn3Ig4tnqxTIoYmKuvwEnvmMVroXAVbyiaiRyb6CwK8zKAY6PyNE2k5cq5hPmNKIIX
 fMKNg/r6sksMRIRK+6U9rEoyp8Q4W1Zt1k9mRUKF7lW9W15sjyfYxlCw5VNlDPlILwNk
 BMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GFpVemuNL7UhbLtjtR7O0P9wazBxTV9UABGaJgXIshY=;
 b=BoO3b4KRIFwhHEwwOFucuyM+onTJMuSTETsOQQNtwIYfX2//bJS0u41ix9YDJstyB2
 ty6pzWIYLPeUUnI5K1ZLxh2MEM2MI+PiLDw/LIuR3rwHaO0ydXpSuBPfw5/lhNxxzz8Q
 wMzW7Uc1Ii1pRzIGO3ltCLDGqgcvhhFI0Z4mnrrp65FqJd4wL8mAGvv/wJTPjvdRwnkg
 piySFZ6GqWCrIWPG87bQ+L4eY0F5dVjMG+NNyqGqceRfA+ul8VL9m4YimYilhrfh/Q7W
 Nhz8wM4h/YKu3Go0kRb1okHfEQ3evIoY0wEDtlQ0Xj/rKpdSJOvBVZP6ibQN+VUHOBZa
 l8rA==
X-Gm-Message-State: APjAAAXdpKkZzmFF4wopGcmo0E345nyrqq0RZYLUdtTKBdLPz+1c/dqY
 Z/v5lxZ4HVjvciFz2DFwsA6U+UhAw+x8jLlGYFVIrg==
X-Google-Smtp-Source: APXvYqwvba2MQMyS7jLMKDl454jZLaiXhButHVexL7HSy/SUqsJ6RAdi7pyD/yDQVq2pi+l9JeCmOjzaQB1rxa+Y8lo=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr6542560oie.48.1561986407265; 
 Mon, 01 Jul 2019 06:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-16-clg@kaod.org>
In-Reply-To: <20190618165311.27066-16-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 14:06:36 +0100
Message-ID: <CAFEAcA-J+bS2-EtX6pTFYJ1XMaNLx0roYEoQMxV_=-mwMSPDgg@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 15/21] aspeed/smc: add support for DMAs
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 17:55, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The FMC controller on the Aspeed SoCs support DMA to access the flash
> modules. It can operate in a normal mode, to copy to or from the flash
> module mapping window, or in a checksum calculation mode, to evaluate
> the best clock settings for reads.
>
> The model introduces two custom address spaces for DMAs: one for the
> AHB window of the FMC flash devices and one for the DRAM. The latter
> is populated using a "dram" link set from the machine with the RAM
> container region.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Acked-by: Joel Stanley <joel@jms.id.au>
> +/*
> + * Accumulate the result of the reads to provide a checksum that will
> + * be used to validate the read timing settings.
> + */
> +static void aspeed_smc_dma_checksum(AspeedSMCState *s)
> +{
> +    MemTxResult result;
> +    uint32_t data;
> +
> +    if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid direction for DMA checksum\n",  __fun=
c__);
> +        return;
> +    }
> +
> +    while (s->regs[R_DMA_LEN]) {
> +        result =3D address_space_read(&s->flash_as, s->regs[R_DMA_FLASH_=
ADDR],
> +                                    MEMTXATTRS_UNSPECIFIED,
> +                                    (uint8_t *)&data, 4);

This does a byte-by-byte read into a local uint32_t...

> +        if (result !=3D MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed @%08x\=
n",
> +                          __func__, s->regs[R_DMA_FLASH_ADDR]);
> +            return;
> +        }
> +
> +        /*
> +         * When the DMA is on-going, the DMA registers are updated
> +         * with the current working addresses and length.
> +         */
> +        s->regs[R_DMA_CHECKSUM] +=3D data;

...which we then use as a (host-endian) 32-bit value.

This will behave differently on big endian and little endian hosts.
If the h/w behaviour is to to load a 32-bit data type you probably
want address_space_ldl_le() (or _be() if it's doing a big-endian load).

> +        s->regs[R_DMA_FLASH_ADDR] +=3D 4;
> +        s->regs[R_DMA_LEN] -=3D 4;
> +    }
> +}
> +
> +static void aspeed_smc_dma_rw(AspeedSMCState *s)
> +{
> +    MemTxResult result;
> +    uint32_t data;
> +
> +    while (s->regs[R_DMA_LEN]) {
> +        if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> +            result =3D address_space_read(&s->dram_as, s->regs[R_DMA_DRA=
M_ADDR],
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        (uint8_t *)&data, 4);
> +            if (result !=3D MEMTX_OK) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed @%0=
8x\n",
> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
> +                return;
> +            }
> +
> +            result =3D address_space_write(&s->flash_as,
> +                                         s->regs[R_DMA_FLASH_ADDR],
> +                                         MEMTXATTRS_UNSPECIFIED,
> +                                         (uint8_t *)&data, 4);
> +            if (result !=3D MEMTX_OK) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash write failed @=
%08x\n",
> +                              __func__, s->regs[R_DMA_FLASH_ADDR]);
> +                return;
> +            }
> +        } else {
> +            result =3D address_space_read(&s->flash_as, s->regs[R_DMA_FL=
ASH_ADDR],
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        (uint8_t *)&data, 4);
> +            if (result !=3D MEMTX_OK) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed @%=
08x\n",
> +                              __func__, s->regs[R_DMA_FLASH_ADDR]);
> +                return;
> +            }
> +
> +            result =3D address_space_write(&s->dram_as, s->regs[R_DMA_DR=
AM_ADDR],
> +                                         MEMTXATTRS_UNSPECIFIED,
> +                                         (uint8_t *)&data, 4);
> +            if (result !=3D MEMTX_OK) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed @%=
08x\n",
> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
> +                return;
> +            }
> +        }

Since the code here doesn't do anything with the data the
address_space_read/write here aren't wrong, but you might
prefer to use the ldl and stl functions to avoid the casts
to uint8_t* and need to specify the length.

thanks
-- PMM

