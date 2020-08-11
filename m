Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62FBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B8D2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyZDG/iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B8D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WOt-0005kF-17
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WOA-0005EA-Qx
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:40:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k5WO9-00040X-6j
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:40:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id x24so10463274otp.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VvCDwEUqFSp8193AGfTq0mG7xTrs09bACAepJfYSZAs=;
 b=DyZDG/iQr7NnpDh1gjUBmh9Ce+EPzdj/rCoh9fdA35V+QHtuCBh7qtpww8vIkYm2Gn
 NktYZQ2S0ERQsKcgmka8N+MzW8nQyxKu9+es1XydbYbmB0afyXAcSPC6xvd12snqCY06
 NridyLP+gjsPAuy0m0Gi9F0OyeBbUSvu8XP1AEInE0foeB0AHplK88AsGiFlT5GSYBlT
 9sJntc0We0XhjHIqH3bXC6T10eS3CBp6Vr4cQ4wuAXLFxHJoXq+ztEc4q07j4wc0UHXG
 1liFOW6ccG8JfnDHHZe8bNLdNFgKqXwzHXy9MBvkb+EX+fUt6vUWk+V2vMc84Exq3t5f
 Zj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VvCDwEUqFSp8193AGfTq0mG7xTrs09bACAepJfYSZAs=;
 b=F5pEozkAgSG96zZSpnY5PFU5Q56YHKwphoF0vCnC6GfjKXD5OtKHszC5JU/CrftBUq
 sRsA1rw34W3536o7KEDmN/IFfHTy0zXtfBqmY7xjNhjNAVcKccCgJY+BqCYtw/Bsqvb2
 NDKoBfnao3rAXwGjoWkVaa20oFNOqkidbh1w7kw6DGERoT2wJ9JwSok9KrhV7bEjfUER
 RshprIP6gO0K56IvjSaomB5nEJnldM/S5mIisIqb+jzNLQMmnWSo2K6B3f8Sd581Qt1K
 ptPzIeveKv13WyHu3Cw0wRkmWkL0SsSAr840LqZ+Cbe4sMfnLh1J5Hyl2W5iKB5YoG87
 Ry/w==
X-Gm-Message-State: AOAM532PMDgo0pOcz4N94BkopFPMtoYRk8kHiRW46k80UIhXPYMvOZ19
 xUIdtZslSfIR0wyIxoM8SkR+JLeQO0k3U/oL64k=
X-Google-Smtp-Source: ABdhPJyE8X2ugzqMSoIWreJ1dXVSZoFIY/i6/Odq4kN/UBZ6hBcMMDO/f4dWAf8JJutJpCZaWZrDsQ2eo1F/WHBcIkI=
X-Received: by 2002:a9d:2926:: with SMTP id d35mr5277350otb.181.1597160431532; 
 Tue, 11 Aug 2020 08:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-8-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-8-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 11 Aug 2020 23:39:55 +0800
Message-ID: <CAKXe6SKKY77u08iYEq039mGu_c0Qf=KyvNFk05ZDmLKSkuetfg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add tz-ppc-dummy mmio read/write methods to avoid assert failure
> during initialisation.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/misc/tz-ppc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> Update v4: add Reviewed-by tag
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05303.ht=
ml
>
> diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
> index 6431257b52..36495c68e7 100644
> --- a/hw/misc/tz-ppc.c
> +++ b/hw/misc/tz-ppc.c
> @@ -196,7 +196,21 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwadd=
r addr,
>      g_assert_not_reached();
>  }
>
> +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned si=
ze)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    g_assert_not_reached();
> +}
> +
>  static const MemoryRegionOps tz_ppc_dummy_ops =3D {
> +    /* define r/w methods to avoid assert failure in memory_region_init_=
io */
> +    .read =3D tz_ppc_dummy_read,
> +    .write =3D tz_ppc_dummy_write,
>      .valid.accepts =3D tz_ppc_dummy_accepts,
>  };
>
> --
> 2.26.2
>

