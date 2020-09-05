Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 00:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDADA2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al0ILXYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDADA2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEMY8-00074V-JF
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 20:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kEMXZ-0006NF-Qc; Fri, 04 Sep 2020 20:58:49 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:42641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kEMXY-0007AM-8q; Fri, 04 Sep 2020 20:58:49 -0400
Received: by mail-oo1-xc41.google.com with SMTP id a6so2042204oog.9;
 Fri, 04 Sep 2020 17:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rTk/9yIBQj2wtr1pcLS4FVGlR4Au0jYG2QniZaZ1pi0=;
 b=Al0ILXYhTTJpqqCH8fUapKZAIKQh6adg/kTWltnYw9XN5MaEvc1vXuV4BOr093Qy1s
 CEiRKLxglplTHeZbtFKeowzvbic6iV8Con5Kw/5cT5Gsd8WZB13qnjnT7VI0yscb3NgO
 dzISoiks1E0wxX2Ktudd/ifmcYh07j9J4pNHhM4o1/egbvi6ixpDsUlKIsivMvFpjw0J
 YIAExigMWXnHzJI3125TZSn0YiSYVS1xqtdpjsT550kpTpjqI2NhcVK2CQlTsIAGMYlS
 jKW6ciOvNqaInHRdHcUt46nVoNKKNiwePoj6CVNOw1jLTf72BkdNVv5cDaTmM2hIiuwK
 UURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rTk/9yIBQj2wtr1pcLS4FVGlR4Au0jYG2QniZaZ1pi0=;
 b=MDSff1yzM92y7btIM0IPOXnNRJR/qps8EMBUxgR4sZ8H7P/Uz5clGa01Yfkclf4Aey
 mVDUextBKwi3vv8Y7CU+CDdJwcA+y0IRmlZNJw+QxfAMmgEeA8mqd4d/IB1I/S/Hp5jJ
 MpgiiUuBjx4IxBTnIuYloPw061rcCMJnh/hjIbMXse/ti8QevKxRd6z4NoKAbB1eFpHZ
 wTbP0+eI2w5zq7BRtxqtL0MQjyO5NSPKedG98B5iZL0HdQKpNljuC7ZlINs4sdIpi5Er
 BaDbA7bhJ8agneIDFax/RWNyT4lo6XA2l9EPqgKt2+38GBO6hN6a1cRXbGbfgPF0bmDv
 rTQQ==
X-Gm-Message-State: AOAM530A28kcvSpTTLLLAEa2w1CxpryBAKUkEgIYPYv0zNNF6QsjkTOD
 /8kDJBlzgfFazsPcShe7QndHGjdB722+0zcDCIM=
X-Google-Smtp-Source: ABdhPJz7urNp3qWoEoWTY2v7sN1Gr83rEwHYjNO1iwvP0+saXtufztIv+bAenwBZ66qTCfGS8BinCM7bCuUTScoN4d8=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr7835389ooj.1.1599267526828;
 Fri, 04 Sep 2020 17:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200904131402.590055-1-f4bug@amsat.org>
 <20200904131402.590055-3-f4bug@amsat.org>
In-Reply-To: <20200904131402.590055-3-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 5 Sep 2020 08:58:10 +0800
Message-ID: <CAKXe6SJ6nrAm-LDK_gv__5vcK4Py62zQ7-RfVJodAghuMfdfJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/net/e1000e: Remove duplicated write handler for
 FLSWDATA register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc41.google.com
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:14=E5=86=99=E9=81=93=EF=
=BC=9A
>
> The FLSWDATA register writeop handler is initialized twice:
>
>   3067 #define e1000e_putreg(x)    [x] =3D e1000e_mac_writereg
>   3068 typedef void (*writeops)(E1000ECore *, int, uint32_t);
>   3069 static const writeops e1000e_macreg_writeops[] =3D {
>   ....
>   3102     e1000e_putreg(FLSWDATA),
>   ....
>   3145     e1000e_putreg(FLSWDATA),
>
> To avoid confusion, remove the duplicated initialization.
>
> Fixes: 6f3fbe4ed0 ("net: Introduce e1000e device emulation")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Noticed after looking for other cases of the previous patch.
> ---
>  hw/net/e1000e_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 5170e6a4563..bcfd46696ff 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -3141,7 +3141,6 @@ static const writeops e1000e_macreg_writeops[] =3D =
{
>      e1000e_putreg(RXCFGL),
>      e1000e_putreg(TSYNCRXCTL),
>      e1000e_putreg(TSYNCTXCTL),
> -    e1000e_putreg(FLSWDATA),
>      e1000e_putreg(EXTCNF_SIZE),
>      e1000e_putreg(EEMNGCTL),
>      e1000e_putreg(RA),
> --
> 2.26.2
>
>

