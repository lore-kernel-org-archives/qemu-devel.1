Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DBC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E68C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3S3CGKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E68C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUTY-0007J3-Ln
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixUSS-0006Om-B8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixUSO-0007FU-0X
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:27:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixUSN-0007DO-Pd
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:27:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so8592717wmc.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uYT3rEFH051Tcak1oJ4NJQ2vIW2W5pUZT+IMZiUrtNs=;
 b=b3S3CGKY3wzAVdgbr943Yy9c66tmpB7MRyJwjNmqQNl5S5TT44leOjaWtsj3GB9QbI
 czqzFORO8D9too5iw3FMNdJmzR8dKXGZkCVGrGCKYpYsQ0xuBSfdDyr2URi6YPaLlLF+
 as5txrN7eey4oPi2ghoW2SQrxTZnxPRZSqHTJNceaA0u9FiKVkt+l98vmelZamsfingk
 r+oa/8an20PtEzuKCkckwH1V5/zmKxviv/6DQEsXGwjA1qcN12f26rJjGtSAPiwjuUaM
 FkMOMd8N9ldUi3bg2SWu/Z/c37dB1KXSW4IDnXqwRsMTsrZ5dpJ86x4Kz0xt8G2pw1pL
 GYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uYT3rEFH051Tcak1oJ4NJQ2vIW2W5pUZT+IMZiUrtNs=;
 b=ONRU7xTfI5HNTKcH9IxnGETuZLEMR7bYwMxt++FgNTK3i9QouOeYqtNuL3HbUcNgrT
 fx+Ht0mmG4R8qGlDbJk4V9rup1ByumGnhitT3DlcHwI4SnMa3xxS2gBqJFgZuRCemSjW
 jPaVfmaJdNnepQpciZQAoMTn5Z2xlTeCLqSBBvWoDMEltRqgVP80cCr2MmDbz3r7oxZJ
 jbzgfeJKUd19vVLl2y0AJPEC2jzOtUQa6U0L4GrEZamYdeH2s9wut6sXO1LRb0eE7OXA
 aZEFb607jcCNnppTglv+DfU5O8mCzluA3P4LyM0PkrE3CIoUTiURefVMghJJi5RDFUgR
 cLbA==
X-Gm-Message-State: APjAAAWTNIZ4QhIPLe7flk/XGS82RLPO4M018ryz4UpqCseklojdx7Wy
 P/jpNsiMI256hQU8YGuSXc6czw==
X-Google-Smtp-Source: APXvYqy6x6jovxxCKg4g+2Pgl86VvEdySJMuHERaNOaoigzlDXP5fuajXByjdPdO9xiBodCS2Ksqog==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr12376922wmc.185.1580470046480; 
 Fri, 31 Jan 2020 03:27:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d8sm11132125wrx.71.2020.01.31.03.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 03:27:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73B2D1FF87;
 Fri, 31 Jan 2020 11:27:24 +0000 (GMT)
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
 <20200131010941.10636-2-philmd@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] !fixup "hw/misc: Add limited support for AVR power
 device"
In-reply-to: <20200131010941.10636-2-philmd@redhat.com>
Date: Fri, 31 Jan 2020 11:27:24 +0000
Message-ID: <87sgjv9883.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> - convert DB_PRINT() to trace-events
> - fix style/indentation
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/misc/avr_power.c  | 17 +++++++++--------
>  hw/misc/trace-events |  4 ++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
> index 598bc7279c..65ff7c4405 100644
> --- a/hw/misc/avr_power.c
> +++ b/hw/misc/avr_power.c
> @@ -27,9 +27,7 @@
>  #include "qemu/log.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/irq.h"
> -
> -#define DB_PRINT(fmt, args...) /* Nothing */
> -/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## ar=
gs)*/
> +#include "trace.h"
>=20=20
>  static void avr_mask_reset(DeviceState *dev)
>  {
> @@ -48,19 +46,20 @@ static uint64_t avr_mask_read(void *opaque, hwaddr of=
fset, unsigned size)
>      assert(offset =3D=3D 0);
>      AVRMaskState *s =3D opaque;
>=20=20
> +    trace_avr_power_read(s->val);
> +
>      return (uint64_t)s->val;
>  }
>=20=20
>  static void avr_mask_write(void *opaque, hwaddr offset,
> -                              uint64_t val64, unsigned size)
> +                           uint64_t val64, unsigned size)
>  {
>      assert(size =3D=3D 1);
>      assert(offset =3D=3D 0);
>      AVRMaskState *s =3D opaque;
>      uint8_t val8 =3D val64;
>=20=20
> -    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> -
> +    trace_avr_power_write(val8);

You've dropped offset in this trace point which is probably worth
keeping so you track where is being written to. Same with the read.


>      s->val =3D val8;
>      for (int i =3D 0; i < 8; i++) {
>          qemu_set_irq(s->irq[i], (val8 & (1 << i)) !=3D 0);
> @@ -71,7 +70,9 @@ static const MemoryRegionOps avr_mask_ops =3D {
>      .read =3D avr_mask_read,
>      .write =3D avr_mask_write,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
> -    .impl =3D {.max_access_size =3D 1}
> +    .impl =3D {
> +        .max_access_size =3D 1,
> +    },
>  };
>=20=20
>  static void avr_mask_init(Object *dev)
> @@ -80,7 +81,7 @@ static void avr_mask_init(Object *dev)
>      SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);
>=20=20
>      memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MAS=
K,
> -            0x01);
> +                          0x01);
>      sysbus_init_mmio(busdev, &s->iomem);
>=20=20
>      for (int i =3D 0; i < 8; i++) {
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 7f0f5dff3a..f716881bb1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -179,3 +179,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=3D%=
u value=3D0x%02x"
>  via1_rtc_cmd_pram_write(int addr, int value) "addr=3D%u value=3D0x%02x"
>  via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value)=
 "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
>  via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value=
) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
> +
> +# avr_power.c
> +avr_power_read(uint8_t value) "power_reduc read value:%u"
> +avr_power_write(uint8_t value) "power_reduc write value:%u"


--=20
Alex Benn=C3=A9e

