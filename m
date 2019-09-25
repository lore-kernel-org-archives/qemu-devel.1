Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C496DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939E02054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939E02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFtK-0001vB-Pi
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFsW-0001Kp-5K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFsR-0003JU-3F
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFsQ-0003Ft-Oh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:14 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 487015AFE3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:35:13 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n3so171883wmf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xu+VNSkP2OgmkqzyOJNDI/CixMUY/AGVgFqmKJoT6nQ=;
 b=RrZL1Up9ksWUWzobVgMD8/4kTjXhH4sRn770PGKYnOcTRQPgOelBg0k9d80pH2JJMb
 pKRW/OQ5P9zSZiZ4bVjtfX7WEAI/LsFnvn0/8LhK5H11F8cxXHuxsf47QEEpxPjPGz4+
 yz5EnwgoSXNIflhsccW6ZfoWu/YIwi4+4WOl8lZYNaqFXtvtgFlLCd59OJx7NnZ5fZ8a
 l/CoubeClQBixbjJ0hN/RjyCuVKcGwLP1jncCO3ikLTvDcXif/E0otrWzyPKAvCIzML0
 sxgJmkOfgxRzWKyu//8HotUHuMij2lIHodD+CdQgOfS5H7JH5WOGQCT1jxq4KqaC53+x
 GacA==
X-Gm-Message-State: APjAAAWENI9pSyGZ9yGFYUVmgfayi+Oe3SG7m95ADKFV+IzjHO3QJyn6
 NPH0ugJx9n2y4v8zHALuRLBpYKCf9y3dGDVhmhbC8tGYdnAxMbZW4bZDhYNtak54OcyxCFn6edi
 yn5fNX9zCTlnFNMA=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr435856wrj.269.1569450912081; 
 Wed, 25 Sep 2019 15:35:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUF26LPwAvQbnrxdU0b1KR8ifj8ptD1r/CR70V/zuqS+Q48p3F3n1FlJg2mT2P4/+Z3qp61w==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr435849wrj.269.1569450911897; 
 Wed, 25 Sep 2019 15:35:11 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q10sm1126456wrd.39.2019.09.25.15.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:35:11 -0700 (PDT)
Subject: Re: [PATCH v3 03/33] target/alpha: Fix SWCR_TRAP_ENABLE_MASK
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5e214978-f456-3edf-f0be-e747f1ff008f@redhat.com>
Date: Thu, 26 Sep 2019 00:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: jsnow@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>=20
> The CONFIG_USER_ONLY adjustment blindly mashed the swcr
> exception enable bits into the fpcr exception disable bits.
>=20
> However, fpcr_exc_enable has already converted the exception
> disable bits into the exception status bits in order to make
> it easier to mask status bits at runtime.
>=20
> Instead, merge the swcr enable bits with the fpcr before we
> convert to status bits.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190921043256.4575-4-richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/helper.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 10602fb3394..e21c488aa32 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -46,34 +46,39 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint6=
4_t val)
>      uint32_t fpcr =3D val >> 32;
>      uint32_t t =3D 0;
> =20
> +    /* Record the raw value before adjusting for linux-user.  */
> +    env->fpcr =3D fpcr;
> +
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * Override some of these bits with the contents of ENV->SWCR.
> +     * In system mode, some of these would trap to the kernel, at
> +     * which point the kernel's handler would emulate and apply
> +     * the software exception mask.
> +     */
> +    uint32_t soft_fpcr =3D alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
> +    fpcr |=3D soft_fpcr & FPCR_STATUS_MASK;
> +#endif
> +
>      t |=3D CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
>      t |=3D CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
>      t |=3D CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
>      t |=3D CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
>      t |=3D CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
> =20
> -    env->fpcr =3D fpcr;
>      env->fpcr_exc_enable =3D ~t & FPCR_STATUS_MASK;
> =20
>      env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_=
SHIFT];
> =20
>      env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UND=
Z);
>      env->fp_status.flush_inputs_to_zero =3D (fpcr & FPCR_DNZ) !=3D 0;
> -
>  #ifdef CONFIG_USER_ONLY
> -    /*
> -     * Override some of these bits with the contents of ENV->SWCR.
> -     * In system mode, some of these would trap to the kernel, at
> -     * which point the kernel's handler would emulate and apply
> -     * the software exception mask.
> -     */
>      if (env->swcr & SWCR_MAP_DMZ) {
>          env->fp_status.flush_inputs_to_zero =3D 1;
>      }
>      if (env->swcr & SWCR_MAP_UMZ) {
>          env->fpcr_flush_to_zero =3D 1;
>      }
> -    env->fpcr_exc_enable &=3D ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> =
32);
>  #endif
>  }
> =20
>=20

