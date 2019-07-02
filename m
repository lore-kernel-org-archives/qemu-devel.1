Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F6221721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ain3huJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMXC-0003qY-SC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLWB-0005ig-0B
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLW7-0002NC-6w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:20:29 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLW3-0002Iv-Rs; Tue, 02 Jul 2019 12:20:25 -0400
Received: by mail-lf1-x143.google.com with SMTP id j29so11804877lfk.10;
 Tue, 02 Jul 2019 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q4ef92tiRiSMYTng3BuuzrGksSLOIr5Nj23io44N++Q=;
 b=Ain3huJIOq1YLO+yEM2eSrxp2dL/ufBrdSTdEo+pPAnJuXIlO0j4JtbL12HGa24w1S
 dmSoHWraS0YFtgOtepC0i9b5QjfO6I5oXXOArwf2lvyQq6v9JLKCWCthzLDhUTSu7xk/
 aBBbFagK9pyNquYQSdw578aaWRSoS2gdZ7hHvMfrgrN3a5wewK7//VQCZ8RJ6T137TjU
 WO9sjzcEgisr9gGkpIOYChzLoJQgFZe+T8OZzNWtp6l2XMjLxfRZQAJcTj6Nrjc4333J
 HrpGIHpSxfxQr/Kl6PL/DNDyXqEyl+IKdCdASpAYAC2tWNjcE3tpUTXkxmJbxRADtmb9
 Wh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q4ef92tiRiSMYTng3BuuzrGksSLOIr5Nj23io44N++Q=;
 b=Wd7sbkd8FvpHD9ZJZ57jIxcmwlq0ugkii2ES5ns5HULtLE+7ovNUOK779yC5sSCmNS
 NgYDTNxKSpdCLBFeNeZijdQnBKPkWYITx2DJlTqn87Gj5t5hLkqM0ihTgUyXydYhAhFb
 v7ziFkzVcwe9FM8JR/znUxW/w4Pn9tLalBLIPGRx0kkzctvaw+mDVXimmSLKE2pAz7Q/
 K8BuvG9HY/RyVPEbOJFW9YZ9LH4UQcxbEqa7su3W9bvWZE+KtiyZEwsU6OXDP1rDAkS7
 ApBcNxRjhNZksM1B6lX57OYKzlXZrGml7OzYwyK/c0KV3kgTEiQnJOQDiJ6SMycRiWxr
 VBbg==
X-Gm-Message-State: APjAAAX1daYQJ1gtyTsEyFv4pBByf8lcVr3Xg91Zb7NZKFrSDLPOaigX
 /Z1Z7mdvpKSabqttBINyIlY05kzh6EH7Cj2tpY8=
X-Google-Smtp-Source: APXvYqy73ouNbN/LjJtX6BMysXGKdI+0hXtek/vjy8AN6R9s8jFk97Lu4515Znjsbdd7HXnMRMwvvbsVQ2UVZGA9P9o=
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr2214883lff.135.1562084416249; 
 Tue, 02 Jul 2019 09:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-10-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:17:12 -0700
Message-ID: <CAKmqyKM0uQa-dRLoZNhU9gD9-X2wpA6k1GfqAJh0ZH3UzBH7Fw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v2 9/9] hw/block/pflash_cfi01: Hold the PRI
 table offset in a variable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 5:16 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Manufacturers are allowed to move the PRI table, this is why the
> offset is queryable via fixed offsets 0x15/0x16.
> Add a variable to hold the offset, so it will be easier to later
> move the PRI table.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index e891112b67..f65840eb2b 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -762,6 +762,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>      }
>
>      /* Hardcoded CFI table */
> +    const uint16_t pri_ofs =3D 0x31;
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
>      pfl->cfi_table[0x11] =3D 'R';
> @@ -770,14 +771,17 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>      pfl->cfi_table[0x13] =3D 0x01;
>      pfl->cfi_table[0x14] =3D 0x00;
>      /* Primary extended table address (none) */
> -    pfl->cfi_table[0x15] =3D 0x31;
> -    pfl->cfi_table[0x16] =3D 0x00;
> +    pfl->cfi_table[0x15] =3D pri_ofs;
> +    pfl->cfi_table[0x16] =3D pri_ofs >> 8;
>      /* Alternate command set (none) */
>      pfl->cfi_table[0x17] =3D 0x00;
>      pfl->cfi_table[0x18] =3D 0x00;
>      /* Alternate extended table (none) */
>      pfl->cfi_table[0x19] =3D 0x00;
>      pfl->cfi_table[0x1A] =3D 0x00;
> +
> +    /* CFI: System Interface Information */
> +
>      /* Vcc min */
>      pfl->cfi_table[0x1B] =3D 0x45;
>      /* Vcc max */
> @@ -802,6 +806,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>      pfl->cfi_table[0x25] =3D 0x04;
>      /* Max timeout for chip erase */
>      pfl->cfi_table[0x26] =3D 0x00;
> +
> +    /* CFI: Device Geometry Definition */
> +
>      /* Device size */
>      pfl->cfi_table[0x27] =3D ctz32(device_len); /* + 1; */
>      /* Flash device interface (8 & 16 bits) */
> @@ -826,26 +833,30 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>      pfl->cfi_table[0x2E] =3D (blocks_per_device - 1) >> 8;
>      pfl->cfi_table[0x2F] =3D sector_len_per_device >> 8;
>      pfl->cfi_table[0x30] =3D sector_len_per_device >> 16;
> +    assert(0x30 < pri_ofs);
> +
> +    /* CFI: Primary-Vendor Specific */
>
>      /* Extended */
> -    pfl->cfi_table[0x31] =3D 'P';
> -    pfl->cfi_table[0x32] =3D 'R';
> -    pfl->cfi_table[0x33] =3D 'I';
> +    pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
> +    pfl->cfi_table[0x01 + pri_ofs] =3D 'R';
> +    pfl->cfi_table[0x02 + pri_ofs] =3D 'I';
>
> -    pfl->cfi_table[0x34] =3D '1';
> -    pfl->cfi_table[0x35] =3D '0';
> +    pfl->cfi_table[0x03 + pri_ofs] =3D '1';
> +    pfl->cfi_table[0x04 + pri_ofs] =3D '0';
>
> -    pfl->cfi_table[0x36] =3D 0x00;
> -    pfl->cfi_table[0x37] =3D 0x00;
> -    pfl->cfi_table[0x38] =3D 0x00;
> -    pfl->cfi_table[0x39] =3D 0x00;
> +    pfl->cfi_table[0x05 + pri_ofs] =3D 0x00; /* Optional features */
> +    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
> +    pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
> +    pfl->cfi_table[0x08 + pri_ofs] =3D 0x00;
>
> -    pfl->cfi_table[0x3a] =3D 0x00;
> +    pfl->cfi_table[0x09 + pri_ofs] =3D 0x00; /* Func. supported after su=
spend */
>
> -    pfl->cfi_table[0x3b] =3D 0x00;
> -    pfl->cfi_table[0x3c] =3D 0x00;
> +    pfl->cfi_table[0x0a + pri_ofs] =3D 0x00; /* Block status register ma=
sk */
> +    pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
>
> -    pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
> +    pfl->cfi_table[0x0e + pri_ofs] =3D 0x01; /* Number of protection fie=
lds */
> +    assert(0x0e + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
>  }
>
>  static void pflash_cfi01_system_reset(DeviceState *dev)
> --
> 2.20.1
>

