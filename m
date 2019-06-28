Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E8C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25312064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiuYmiVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25312064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtvV-0003Sl-T1
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtsP-00012w-Uf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtsN-00063N-U7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:37:29 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtsJ-0005uM-Ki; Fri, 28 Jun 2019 12:37:27 -0400
Received: by mail-lj1-x244.google.com with SMTP id h10so6633015ljg.0;
 Fri, 28 Jun 2019 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wLiGMD4EvsM7xTV7VFIvRXEr1Z8kXRHm79nNC4ag830=;
 b=jiuYmiVqa1MYe0Ism3xsecn/epcx6eBVWK0/TYKM/A5zhRv2/yG+l8jyb+/2q70oIw
 26XRw6CYuWCvRqsdQYVXVGKJ6O/7xsPK2tbjyXDH3wPwtVbdX8KVcKu/LRDwape/Y/6i
 WsFGkPeZqST80AqKKMNYWoa26CmhgtxRZFXh8tzYbyj8CJ42m1KncNtz43QB8GLbWEUa
 LM0ETtoE+ZGqpkaVKQMwi7tqGrYF1dJoqrrma68imortFetu5qWyObBLFnvIQar2gE7f
 bp2pSk2X04Npy883BrET2pDh2MgC8cu/X97pAUsmdxqD/7KwJi3nX6yYrQ73Zxeaxan6
 N9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wLiGMD4EvsM7xTV7VFIvRXEr1Z8kXRHm79nNC4ag830=;
 b=GGd+q8yQQiw+FXLTdVWuIrLB0mviyim4kVWr3TdKg10BlxcJS5Zlcl5CiX/QmqT06s
 eNO7BvNpilLz6OYYqUVsw5XyVHF8UQFINwUABX4VIakzzls6jkThN0G+EDUlpBRd+WxL
 yuxvQbv6bqI6J2f8mB1Jd0kaN0uNH56DN2LQgzR0loKyFFIQ65MC+2KS3hw4qKs46Hm8
 c3nNV3Gxc1laBkmmT0SnOjMsg1Au97ypRK27lRP6WJufJRPprZ15OZalq4Fc68FzKYJE
 H3pO9Uvr2c83XfnKvg+bI4wU4bY06N08a0zHynWUrSlCeMfAR+4hZrthSFIImdWHB2xM
 5J0g==
X-Gm-Message-State: APjAAAWajLOwTf0EOdgj0sM64LlRNvUNdBUn1URsL1A1HvJCOiJiem42
 Bijr34NaA0lBBiU94Bij2mhIUeYzBUlyjpW4isw=
X-Google-Smtp-Source: APXvYqwq00xKIxLjdwSGTIDwXGOypuBfcO7jBsEdoxWOgnrTLpZ5gvHy27Jah1+cvOihjIQc919k8oN/83NwUq1kOac=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr6861189ljg.119.1561739834973; 
 Fri, 28 Jun 2019 09:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-17-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-17-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:34:13 -0700
Message-ID: <CAKmqyKNW5e-X-qj3jKuXBO7Em8NasOwxFgS6vvjNObJLt3jyZw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v5 16/28] hw/block/pflash_cfi02: Hold the
 PRI table offset in a variable
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:34 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
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
>  hw/block/pflash_cfi02.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f1bac480f5..23d05a6308 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -552,6 +552,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>      pfl->status =3D 0;
>
>      /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
> +    const uint16_t pri_ofs =3D 0x31;
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
>      pfl->cfi_table[0x11] =3D 'R';
> @@ -560,8 +561,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>      pfl->cfi_table[0x13] =3D 0x02;
>      pfl->cfi_table[0x14] =3D 0x00;
>      /* Primary extended table address */
> -    pfl->cfi_table[0x15] =3D 0x31;
> -    pfl->cfi_table[0x16] =3D 0x00;
> +    pfl->cfi_table[0x15] =3D pri_ofs;
> +    pfl->cfi_table[0x16] =3D pri_ofs >> 8;
>      /* Alternate command set (none) */
>      pfl->cfi_table[0x17] =3D 0x00;
>      pfl->cfi_table[0x18] =3D 0x00;
> @@ -609,32 +610,34 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
>      pfl->cfi_table[0x2E] =3D (pfl->nb_blocs - 1) >> 8;
>      pfl->cfi_table[0x2F] =3D pfl->sector_len >> 8;
>      pfl->cfi_table[0x30] =3D pfl->sector_len >> 16;
> +    assert(0x30 < pri_ofs);
>
>      /* Extended */
> -    pfl->cfi_table[0x31] =3D 'P';
> -    pfl->cfi_table[0x32] =3D 'R';
> -    pfl->cfi_table[0x33] =3D 'I';
> +    pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
> +    pfl->cfi_table[0x01 + pri_ofs] =3D 'R';
> +    pfl->cfi_table[0x02 + pri_ofs] =3D 'I';
>
>      /* Extended version 1.0 */
> -    pfl->cfi_table[0x34] =3D '1';
> -    pfl->cfi_table[0x35] =3D '0';
> +    pfl->cfi_table[0x03 + pri_ofs] =3D '1';
> +    pfl->cfi_table[0x04 + pri_ofs] =3D '0';
>
>      /* Address sensitive unlock required. */
> -    pfl->cfi_table[0x36] =3D 0x00;
> +    pfl->cfi_table[0x05 + pri_ofs] =3D 0x00;
>      /* Erase suspend not supported. */
> -    pfl->cfi_table[0x37] =3D 0x00;
> +    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
>      /* Sector protect not supported. */
> -    pfl->cfi_table[0x38] =3D 0x00;
> +    pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
>      /* Temporary sector unprotect not supported. */
> -    pfl->cfi_table[0x39] =3D 0x00;
> +    pfl->cfi_table[0x08 + pri_ofs] =3D 0x00;
>
>      /* Sector protect/unprotect scheme. */
> -    pfl->cfi_table[0x3a] =3D 0x00;
> +    pfl->cfi_table[0x09 + pri_ofs] =3D 0x00;
>
>      /* Simultaneous operation not supported. */
> -    pfl->cfi_table[0x3b] =3D 0x00;
> +    pfl->cfi_table[0x0a + pri_ofs] =3D 0x00;
>      /* Burst mode not supported. */
> -    pfl->cfi_table[0x3c] =3D 0x00;
> +    pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
> +    assert(0x0b + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
>  }
>
>  static Property pflash_cfi02_properties[] =3D {
> --
> 2.20.1
>
>

