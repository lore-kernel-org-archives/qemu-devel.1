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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDEBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CAE20645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc1KhUaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CAE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtYf-0002fk-7U
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtOL-0003sK-T7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtOK-0002nb-B5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:06:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtOJ-0002W1-FD; Fri, 28 Jun 2019 12:06:23 -0400
Received: by mail-lj1-x243.google.com with SMTP id i21so6532647ljj.3;
 Fri, 28 Jun 2019 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8jFMOYmI7QdV5FMGFGU2VKnMJYWvON7mqPy5EHHdbJE=;
 b=Cc1KhUaLoNoVpgt7g2iuKt73ZsttB5Dia/qu1367RgQJueuzOY5irn3WKcs+uA1urh
 jECJkxPwgOARgF6VRe1xY0bgbjRTFp2Q4QzkDo+fbnW8sl2EptrR7hSIqRGibhhbAQuP
 /7u66ysgodKudbqa49oBm+Owf63/Nulq15o92hsOwBzrhhF3UbF7EUlhTQfMyFebmoO3
 7o3OGnI1aXdLY7bqkFuFQB/upGdgybnIICFO5dED68tAz7Qaap3un71b6z5RwGUi7/N8
 ZzuvUQANkEGD4mQ2I18d1JVMjGH1SQRyzyIR4LKIDDWNRw4yJx58zNahD5ROa2e/8Nof
 NqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8jFMOYmI7QdV5FMGFGU2VKnMJYWvON7mqPy5EHHdbJE=;
 b=s6ZM0DnwFibCzjrpPdrmlbgHhqdCqTxpEd6CBAwfOX512I8wqW/Uvt2EcVD4zyEOK7
 KX3BmZhi2TUF17bqFp08WipLMwCv9fenr5jLelcn2IDWdItuA5UV8znWwhkvp7cze8hy
 jlX0X1DyAml96KiczRa+NlCD/sbNWTxMeTid1Bnuo3rZxqhq31rpMYiPIC6PeZGjGOYL
 GGV3RpZPi2go/LLjS5HLhqXlr+/DqesgNynqDrNOEEk8aO5p0jrcs6u+ej2vyoru5z2V
 L5c02eDudpI111423mDn0OFsHQe/NAZLg7rYEM4XFUNXZMD5NBWZC54uJmRXn940loiY
 a74g==
X-Gm-Message-State: APjAAAW3MGT4qzgtXaY4cq65HWt1dRp6qcZaOr6fyScTYQpPFV5DLZqu
 WrHT9Q+hZ7CoY+tPB6N0U2USkutr76Jfa010BFw=
X-Google-Smtp-Source: APXvYqx1Iiilr8yceqrgt4XreuMDOrGt35G0cRJTrwJ7Rs3vDLx/PiSdgpm5cXOA+gaUw1gJNXb5KCDk2g9Mo+yqmHY=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr6411709lja.94.1561737967423; 
 Fri, 28 Jun 2019 09:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-9-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:03:07 -0700
Message-ID: <CAKmqyKPBSZhKw1D83omSi95vXf1YK=jRTFCycYayXwDU12SLjg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v5 08/28] hw/block/pflash_cfi02: Use the
 ldst API in pflash_write()
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

On Thu, Jun 27, 2019 at 1:43 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The load/store API eases code review.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 38 ++++++++------------------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 9e8c28af8f..ae38ed0bae 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -365,38 +365,16 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr o=
ffset,
>              goto check_unlock0;
>          case 0xA0:
>              trace_pflash_data_write(offset, width << 1, value, 0);
> -            p =3D pfl->storage;
>              if (!pfl->ro) {
> -                switch (width) {
> -                case 1:
> -                    p[offset] &=3D value;
> -                    pflash_update(pfl, offset, 1);
> -                    break;
> -                case 2:
> -                    if (be) {
> -                        p[offset] &=3D value >> 8;
> -                        p[offset + 1] &=3D value;
> -                    } else {
> -                        p[offset] &=3D value;
> -                        p[offset + 1] &=3D value >> 8;
> -                    }
> -                    pflash_update(pfl, offset, 2);
> -                    break;
> -                case 4:
> -                    if (be) {
> -                        p[offset] &=3D value >> 24;
> -                        p[offset + 1] &=3D value >> 16;
> -                        p[offset + 2] &=3D value >> 8;
> -                        p[offset + 3] &=3D value;
> -                    } else {
> -                        p[offset] &=3D value;
> -                        p[offset + 1] &=3D value >> 8;
> -                        p[offset + 2] &=3D value >> 16;
> -                        p[offset + 3] &=3D value >> 24;
> -                    }
> -                    pflash_update(pfl, offset, 4);
> -                    break;
> +                p =3D (uint8_t *)pfl->storage + offset;
> +                if (pfl->be) {
> +                    uint64_t current =3D ldn_be_p(p, width);
> +                    stn_be_p(p, width, current & value);
> +                } else {
> +                    uint64_t current =3D ldn_le_p(p, width);
> +                    stn_le_p(p, width, current & value);
>                  }
> +                pflash_update(pfl, offset, width);
>              }
>              /*
>               * While programming, status bit DQ7 should hold the opposit=
e
> --
> 2.20.1
>
>

