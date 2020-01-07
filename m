Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D475C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53344208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrCVIOXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53344208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqfV-0001PB-W5
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioq55-0004gS-Ud
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioq54-0006GI-Hs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:43:39 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioq54-0006Fp-Bg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:43:38 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so59324otd.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mbRCzViKxv9HK4gEwYQNiZSD8xAj3xlM48H99QuJpXM=;
 b=nrCVIOXAxNsLISHyL8ob8ZThMqNYG+T1HSzMsvLKzvCjyz19tVKHcDFAXyvqYbyWdf
 g2i20bbjHOfRLuy8MK32GVr8IY1RLpxUu1+A/fG1BupThXDVsf/m/fF1WZZz1MMxU4Zj
 4FLjNtpB77A1TTXriBXaD1Rphn58BYDI+h2L3CfpCTn26XkUQmJp6uaErYvnf7rj3rzr
 Q6ce4U+2bAgHfqudQWPgXAdRI6SLGJGcNH40dj/zdeytwMxuUdM+htcJGnasLAetEhgG
 fkunnwt2RKlA8UBtUoloGBGMqOFmKH9FOjk1XZpLojJra1EbEtaVntwRlldv0P3DydSn
 kNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mbRCzViKxv9HK4gEwYQNiZSD8xAj3xlM48H99QuJpXM=;
 b=apVLa8lN8lirJiZb3AhRxK/ALvWhlxLYXBRjwflnzgGnjWxWsvscZQT62LDxVWl9xW
 SAK+XfFMkAChgpKjB0Q0ew6RP+WxF8KNu7Qhm0LuRACBfudAQ0oq7sIPubFrUf4nhPQg
 /fOe7T5GGd3pxBOWHOMynVoDSrAZivAQPzKARiOaU3G2zaSXbsjjYJWPpw0M8db7ZGbL
 nntNdRE6HsNQXPkVyWISPlD/SI6rVPWL1c5ow9ycVMnUEKfe5mX0huBwncq7BuMwBvVK
 aZZVJ+ecQmU/UmVA9FBt5sY0QYrO1oCwihuYVVN5SA0Kd7wm95BynGkP29+das1sv9Mv
 Ni3A==
X-Gm-Message-State: APjAAAXdspz2OdeUrVxRmSWWk+heW1MM+nju7L7CkxgqaThy1O7YaEOB
 ALZ93TKjwDBnSoI5PWbev090sT4vW8VBnEG2ck/naA==
X-Google-Smtp-Source: APXvYqynPwkJAKaGBFzUdgkFvBOBYI8WXy9tj5w5bCaOSxMLLPsr7Mn9E8on6V7VDK1rjHT+9uFRxgCtax8B4TlpR6E=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr36445otf.221.1578408217588;
 Tue, 07 Jan 2020 06:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
 <20191217044322.351838-2-david@gibson.dropbear.id.au>
In-Reply-To: <20191217044322.351838-2-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 14:43:25 +0000
Message-ID: <CAFEAcA_NpwX8i74UisTB8xT=cve5w4eBRHxmqSs36mHRA1bdCQ@mail.gmail.com>
Subject: Re: [PULL 01/88] ppc/pnv: Add a PNOR model
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@fr.ibm.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 04:43, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> From: C=C3=A9dric Le Goater <clg@fr.ibm.com>
>
> On a POWERPC PowerNV system, the host firmware is stored in a PNOR
> flash chip which contents is mapped on the LPC bus. This model adds a
> simple dummy device to map the contents of a block device in the host
> address space.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Message-Id: <20191021131215.3693-2-clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/Makefile.objs      |   4 +-
>  hw/ppc/pnv.c              |  14 ++++
>  hw/ppc/pnv_pnor.c         | 135 ++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/pnv.h      |   3 +
>  include/hw/ppc/pnv_pnor.h |  25 +++++++
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 hw/ppc/pnv_pnor.c
>  create mode 100644 include/hw/ppc/pnv_pnor.h

Hi; Coverity finds some issues in this patch:

> +static void pnv_pnor_update(PnvPnor *s, int offset, int size)
> +{
> +    int offset_end;
> +
> +    if (s->blk) {
> +        return;
> +    }
> +
> +    offset_end =3D offset + size;
> +    offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> +    offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> +
> +    blk_pwrite(s->blk, offset, s->storage + offset,
> +               offset_end - offset, 0);

Here we call blk_pwrite() but don't check whether it
succeeded or failed. (CID 1412228)

> +static void pnv_pnor_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPnor *s =3D PNV_PNOR(dev);
> +    int ret;
> +
> +    if (s->blk) {
> +        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
> +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
> +        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
> +        if (ret < 0) {
> +            return;
> +        }
> +
> +        s->size =3D blk_getlength(s->blk);
> +        if (s->size <=3D 0) {

blk_getlength() returns an int64_t, but s->size is a uint32_t.
This means that this attempt to check for <=3D 0 doesn't
actually catch the negative values which are errors...

> +            error_setg(errp, "failed to get flash size");
> +            return;
> +        }
> +
> +        s->storage =3D blk_blockalign(s->blk, s->size);

...so we'll pass a very large positive number to
blk_blockalign() (since it takse a size_t argument), which
Coverity correctly identifies as doing the wrong thing.
(CID 1412226)

Side note: the blk functions here seem a bit inconsistent:
blk_getlength() returns int64_t
blk_blockalign() takes size_t
blk_pread() takes int

> +
> +        if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
> +            error_setg(errp, "failed to read the initial flash content")=
;
> +            return;
> +        }
> +    } else {
> +        s->storage =3D blk_blockalign(NULL, s->size);
> +        memset(s->storage, 0xFF, s->size);
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
> +                          TYPE_PNV_PNOR, s->size);
> +}

thanks
-- PMM

