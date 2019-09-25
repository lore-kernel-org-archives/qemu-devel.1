Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A103C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E94D2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E94D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFtw-0002hJ-Ax
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFsy-0001oZ-Fv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFsx-0004NE-Br
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFsx-0004L6-0Y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:35:47 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA4203DE04
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:35:45 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so118371wma.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IRNbb8cL/H9zfN2RjmBwa4adDIil1sm1HrdnexMh2pA=;
 b=D9b3B4n+O/Y7p0xlmUeKqHCDOiqYd0AaUpXdPd0XyYi/kHZ5L51mlzSCapFHqmE5q1
 5xIUid/NDSlt4f1Si2XKRXFIxadat9Y1bqGqTPT0sefTli0SXMrEbcgcAtgkW7VEbIQx
 WgSPEFgbWbjqxLKg5gY6Y+NzaqdbHLIqayOGiEscIe4RfAxnkXvYzG11ehWn6YQckfDa
 CERVvhwZgqu9L0ZyLXesnfYZS4dUirXBq/GAs7M7Is/irOp+CJL683XZrJ0b9dIuxjgf
 z48yCkNimQ1ZsJAK3OBljjZpqFKo5cwcEL3ya5Izu8UKSTHUNq7uvULQYZljC4Rc5rYb
 vqSg==
X-Gm-Message-State: APjAAAVQzfuGNTx9mEfRq4kxKKYxVPkmMfem7et6cvukn++Q4eVfCNZL
 ZYsOxxYp/hKfAHhkKBXhffMkVuxX+9FnLEgTdnqRli0xoIzygR2Lf0r8UuYGeOCiK61lu6OcNBl
 j2l6gWho35MdLtpA=
X-Received: by 2002:a5d:6384:: with SMTP id p4mr430233wru.180.1569450944688;
 Wed, 25 Sep 2019 15:35:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2jbGUOXHEVU2vB8Gaz6RIFSmHeCKQuRKmJZ4ZuGStx4NYpF3OA/sreP7iNKNMgqA/qYc36A==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr430224wru.180.1569450944523;
 Wed, 25 Sep 2019 15:35:44 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f17sm343469wru.29.2019.09.25.15.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:35:43 -0700 (PDT)
Subject: Re: [PATCH v3 01/33] target/alpha: Use array for FPCR_DYN conversion
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0efac54b-e14c-03f0-1011-860f48aa9fdd@redhat.com>
Date: Thu, 26 Sep 2019 00:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-2-alex.bennee@linaro.org>
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
> This is a bit more straight-forward than using a switch statement.
> No functional change.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190921043256.4575-2-richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/helper.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 19cda0a2db5..6c1703682e0 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -36,6 +36,13 @@ uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
> =20
>  void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
>  {
> +    static const uint8_t rm_map[] =3D {
> +        [FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT] =3D float_round_nearest_ev=
en,
> +        [FPCR_DYN_CHOPPED >> FPCR_DYN_SHIFT] =3D float_round_to_zero,
> +        [FPCR_DYN_MINUS >> FPCR_DYN_SHIFT] =3D float_round_down,
> +        [FPCR_DYN_PLUS >> FPCR_DYN_SHIFT] =3D float_round_up,
> +    };
> +
>      uint32_t fpcr =3D val >> 32;
>      uint32_t t =3D 0;
> =20
> @@ -48,22 +55,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64=
_t val)
>      env->fpcr =3D fpcr;
>      env->fpcr_exc_enable =3D ~t & FPCR_STATUS_MASK;
> =20
> -    switch (fpcr & FPCR_DYN_MASK) {
> -    case FPCR_DYN_NORMAL:
> -    default:
> -        t =3D float_round_nearest_even;
> -        break;
> -    case FPCR_DYN_CHOPPED:
> -        t =3D float_round_to_zero;
> -        break;
> -    case FPCR_DYN_MINUS:
> -        t =3D float_round_down;
> -        break;
> -    case FPCR_DYN_PLUS:
> -        t =3D float_round_up;
> -        break;
> -    }
> -    env->fpcr_dyn_round =3D t;
> +    env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_=
SHIFT];
> =20
>      env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UND=
Z);
>      env->fp_status.flush_inputs_to_zero =3D (fpcr & FPCR_DNZ) !=3D 0;
>=20

