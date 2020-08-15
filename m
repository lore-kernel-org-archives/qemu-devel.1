Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D47C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5897523A75
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmqaEzVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5897523A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yFe-00082s-CL
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yDa-0004ia-Em; Sat, 15 Aug 2020 11:35:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yDY-0005Kb-Oe; Sat, 15 Aug 2020 11:35:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id z18so9987662otk.6;
 Sat, 15 Aug 2020 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=amruQQ/323bR7IWKQu1N2p2X9VkYie5hsW91okNherU=;
 b=gmqaEzVBne/ZqOAqhtSAhi0JT+z4VlTsXuhhrZkIileC/SRAdoShdgNwqG+ZARp9zl
 1QJiF6IeZ38WmgTPQuHvvRHeo5InLutbsZM3XIqnYLhp2lbvTXFo03uy6EuvE2Ddlzxe
 l56wbRMLJm2bv4Fue9Jj645Ph19kCVwz35m3Tkmf0SfWEiByR1Fo2y1e6B3fjf0HX+tC
 hmon9uIXMeoPI7vhDOIoOWVnfOG6VVSX4jqD3swZQW2L7uqFMr3mAa0asCl5OGYLF8iB
 rXxVyCqeejgl5QzETXU+UyOo6KRTcQforVnLY61/bsZOuK6aDPASDwLALZkx6lzxxBeX
 pUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=amruQQ/323bR7IWKQu1N2p2X9VkYie5hsW91okNherU=;
 b=QLAzhIqgSlgcqd7JnhlKLgxdV3AD1grWB5+Mx0kCTPpwR0Ve/CqpWXeiRde5O7IX+3
 wibfoELIx+YdSJ/npAXyz9FaSHBha+Vjo07cTOBFqztcztJeHMWiJJGaG0xVdD1WTqIs
 eR6+NuYQkbEMWXNDwmd1747TtAsCsujNq+cDUc01/sP/bZyE5tDqt3htph5RpUMD1iOL
 vp20lqfeK7wpr9ad6M9KJKhg3Vm7tFC8ZP3SfNUfoRJIQNyjLIzaTeVghx0GdRrgnuxc
 iKaBaLSmGBo+Jt7gufspuWXmrGYLNShzOgnCX59vB1fdqXXYXZNCTU+zJWFwYSnzQ2+Y
 K2ng==
X-Gm-Message-State: AOAM532Eu7TNGd2bepvLLSYxss7+t06l706yDiz8PCwALajvz6gYdWRu
 exLKdZR/3a7YsBg9UwoQpfrRbp5H/tccMTSrlEo08INlfOk=
X-Google-Smtp-Source: ABdhPJyTnwYAzNoCfUZk0vQ8w01vse0v6ZtmNf70Y8pUm2yU79Lq6eVJc+QZty2XbvKeHaWiiCYuiuuR0IV4wbgcWxw=
X-Received: by 2002:a9d:748e:: with SMTP id t14mr3890934otk.333.1597461813117; 
 Fri, 14 Aug 2020 20:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-6-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-6-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:22:57 +0800
Message-ID: <CAKXe6SK5au1C0dXOu0VEYW1wn17Vtk9iuU2UeRA8Y7_cu1Dt-g@mail.gmail.com>
Subject: Re: [PATCH 5/7] hw/ide/atapi: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:30=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Use self-explicit definitions instead of magic '512' value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/ide/atapi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index 17a9d635d8..14a2b0bb2f 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -824,9 +824,9 @@ static void cmd_get_configuration(IDEState *s, uint8_=
t *buf)
>       *
>       *      Only a problem if the feature/profiles grow.
>       */
> -    if (max_len > 512) {
> +    if (max_len > BDRV_SECTOR_SIZE) {
>          /* XXX: assume 1 sector */
> -        max_len =3D 512;
> +        max_len =3D BDRV_SECTOR_SIZE;
>      }
>
>      memset(buf, 0, max_len);
> @@ -1186,8 +1186,8 @@ static void cmd_read_dvd_structure(IDEState *s, uin=
t8_t* buf)
>          }
>      }
>
> -    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * 512 + 4 ?
> -           IDE_DMA_BUF_SECTORS * 512 + 4 : max_len);
> +    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 =
?
> +           IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
>
>      switch (format) {
>          case 0x00 ... 0x7f:
> --
> 2.21.3
>
>

