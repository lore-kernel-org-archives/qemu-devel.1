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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DEC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEA82086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtTjyv2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtvd-0003rJ-Fr
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtP9-000464-Oo
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtP8-0003bp-5Y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:07:15 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtP6-000372-Ml; Fri, 28 Jun 2019 12:07:12 -0400
Received: by mail-lj1-x242.google.com with SMTP id i21so6534520ljj.3;
 Fri, 28 Jun 2019 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nYXIz97V9wvyZolGcpgiftQcXo0IIhYnZQZXcYls+Wk=;
 b=LtTjyv2s1AzNOXanwZ7cPO08G2WmEXFUMsztACAyJcaOR5+VVESAdpHUOWzyvhPekm
 2PLg8h56+XiRAi7V287QL/YHB23PiMXwqh7ZjiiXFI9W0xoCsYpvLRIdvjTHpYr+nv0i
 /FKKo/LFk1odd1P3AIbLMXqEzG2g+srHuQB6I/g8lZeLrFqsQ8vjEfmt+tzILxEURpYQ
 7KWsBYJnDhHplcorSE4zvQYzhPAk62wdEZsavoiZWMPHocqSrxd7vd1zQpVHnBagPp1Z
 2icDBupsjcvKVL2LRMF0/u0aZNV8gNHwWEkSQI4sQeAQ+w7ovmEE/ot16CSlhkkzNyu/
 jOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nYXIz97V9wvyZolGcpgiftQcXo0IIhYnZQZXcYls+Wk=;
 b=ZDCDnuvYzquUrtLsll6h1/z6a7efe8YYif70isfusggv6tJNM0jvi+JgX1CA51udlZ
 x97+/awxb78GkvfUH+6gBTwp8I2OTF00g3M/y6NbVs9E1o/oO7b2CbeP8KX33xqz8OF3
 ET4UmQ6rhcKdwmhpiECC13ZWO6p13Li9CRis+3iOsRi74sZfKCcNPn6jw9q9bRO+5ikd
 0ELfBtCzIDniIz8mWXbebB41A3EgEjqZTIS3qyQMZoqnxCcnua3mv72d2FiVBDJ7e8iY
 PxG7ZgRHZHzEEZH3at85VbDKK/HBg/67IGtrlW+wuxErUV+wziCydm1v+tTKJDXm3r5c
 PM/Q==
X-Gm-Message-State: APjAAAW2xwp9vrLYD1ynBLg8JOGpMI+BxD73Y2Blv9OQPjmJZkSL3FVS
 Erb+fLVpyCa8uX/3k68p5nI2+YxaDh5eTIOoyC0h8UXLdcg=
X-Google-Smtp-Source: APXvYqzHrsJd+2ScdTmlLRrBFt/qLfl2nvIpO8vTR+U0MiCa/+E041wDNLMwqSIP8lgBYBAniy5f151RdEzgTr4g+e0=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr6779251ljg.119.1561738003485; 
 Fri, 28 Jun 2019 09:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-10-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:03:43 -0700
Message-ID: <CAKmqyKPt+LwXVPDJEDJOX2kH50hZc5sGhi528VW91u5Po=VYww@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 09/28] hw/block/pflash_cfi02: Use the
 ldst API in pflash_read()
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

On Thu, Jun 27, 2019 at 1:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The load/store API eases code review.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch, simplified tracing]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 32 +++++---------------------------
>  1 file changed, 5 insertions(+), 27 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index ae38ed0bae..49afecb921 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -196,33 +196,11 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
>      case 0x00:
>      flash_read:
>          /* Flash area read */
> -        p =3D pfl->storage;
> -        switch (width) {
> -        case 1:
> -            ret =3D p[offset];
> -            break;
> -        case 2:
> -            if (be) {
> -                ret =3D p[offset] << 8;
> -                ret |=3D p[offset + 1];
> -            } else {
> -                ret =3D p[offset];
> -                ret |=3D p[offset + 1] << 8;
> -            }
> -            break;
> -        case 4:
> -            if (be) {
> -                ret =3D p[offset] << 24;
> -                ret |=3D p[offset + 1] << 16;
> -                ret |=3D p[offset + 2] << 8;
> -                ret |=3D p[offset + 3];
> -            } else {
> -                ret =3D p[offset];
> -                ret |=3D p[offset + 1] << 8;
> -                ret |=3D p[offset + 2] << 16;
> -                ret |=3D p[offset + 3] << 24;
> -            }
> -            break;
> +        p =3D (uint8_t *)pfl->storage + offset;
> +        if (pfl->be) {
> +            ret =3D ldn_be_p(p, width);
> +        } else {
> +            ret =3D ldn_le_p(p, width);
>          }
>          trace_pflash_data_read(offset, width << 1, ret);
>          break;
> --
> 2.20.1
>
>

