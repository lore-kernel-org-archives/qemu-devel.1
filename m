Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C92C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B1D207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iquvxkF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B1D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6ok-0003mz-Ti
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6mT-0000GS-NW; Wed, 26 Aug 2020 21:32:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6mR-0006o2-W0; Wed, 26 Aug 2020 21:32:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id t7so3164596otp.0;
 Wed, 26 Aug 2020 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m+U2MTwdMoG9PqKsjSFaUQ6xkrv2vLd0zliD/g3ABBU=;
 b=iquvxkF6uad3UVn56aWg+9oY1aZWOe/Qa60naVHz/iw/P2c5XZNrGQ0UGlBtJGhTxo
 KP/NZO2kBSNK0qH93dA5ScdbFfTW1oGSPKPfIQSbfwaAtaWuGIpmI3BhnVjuuiCvQoBC
 /SnA36AY9QAtwfpwuB1F1O2Q+qd+hXBWnid0dQvYE1nE8B5N3Uk2oATKvDXyJjYgcLIB
 WD0IR4hJqzMfpcinWx/bEaHh1PGt9iSvqYnR5u/v0/ZYDlzgD317V/uTFE5IEvMsyB3g
 9nGTtkzelv9ahGVN88zGytNiIjxTG1Q+JcVZjorT1xSiRYNQ2HVQTy8auI3bD/S6i6tz
 CVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m+U2MTwdMoG9PqKsjSFaUQ6xkrv2vLd0zliD/g3ABBU=;
 b=IIGOmukwNdZuypGxWYo/MvN4qlNFuXANrtpDPQU4d53AErvCkwfosJGpXAtwWnEHnq
 olNjVRjHr/P47uOvwjtc5ULwIALt1/aZyaO7j0Jy8lGOLOKFDA+/5MH6IAlv1LYIelYh
 5aJtGCzn3pZudHTYTAAcDkfWWKBB/+8X++9ExQJmG5P5DSDjTKltK1jrTJKGM0065k99
 lY0SMNxYBJRtn8aw4pCy7dF0EUaS179ipUDvNpUS3IXrBRPiDtMzTuT/9PsCahGKGTaq
 6W3SuzHILpNLcXOQAEZMjQNU00PiRihMyvWKAGDnrIjXwATfijM/kUv92VldONNfz9Iy
 pxRQ==
X-Gm-Message-State: AOAM5322iklmxFiUe1YqUn000ORd1e+5K6FqA8qVv7YpbnEa8GT/+EJH
 hh+GS42hKVS2yMXXr4a8xscYRlKT0KbRw7yDIFY=
X-Google-Smtp-Source: ABdhPJy9MXfAtERcOjAOzPCagQYyoTHm801WL3WNfHLzUkOrKUKJ2Y0MSiYnPUwD2C8lzqtQeeznOIHGkPshQP5YOgI=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr8315286ote.353.1598491962341; 
 Wed, 26 Aug 2020 18:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-7-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-7-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:32:06 +0800
Message-ID: <CAKXe6S+nFmcCz+iyOuHJm+0=_CjXcDOrJhb0v8B97Ufa03jucw@mail.gmail.com>
Subject: Re: [PATCH 6/8] tosa: Use TYPE_TOSA_MISC_GPIO constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:50=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/tosa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index e29566f7b3..90eef1f14d 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -316,7 +316,7 @@ static const TypeInfo tosa_ssp_info =3D {
>  };
>
>  static const TypeInfo tosa_misc_gpio_info =3D {
> -    .name          =3D "tosa-misc-gpio",
> +    .name          =3D TYPE_TOSA_MISC_GPIO,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(TosaMiscGPIOState),
>      .instance_init =3D tosa_misc_gpio_init,
> --
> 2.26.2
>
>

