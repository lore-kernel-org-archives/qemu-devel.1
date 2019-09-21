Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46627C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A739205F4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMR+QMxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A739205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbB7-00006P-6V
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBb8x-0006Dt-8K
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBb8u-0008B9-W9
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:53:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBb8u-0008As-SR
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569056004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tBh7t7NzsKmvAPAji3CwJmepSfcu5aR9r0YdTRxPUYA=;
 b=cMR+QMxjCNR8pKw0tTj125U01L3JQtPG4qwcX5Af0osGJO1Jz5YnkY2V9nqH/SlNfB4QSJ
 TVP65DXcGdyWa/4DXlc17/CJTu77Va1gySB2ZfmdyG2shKohuDq4Qv1BfS3HIwknH8VoeA
 tJ15xhLNUHA47ArJW80EsS1Tz+wkKgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-YP-uDdiLNNqbmkUaOIWFPw-1; Sat, 21 Sep 2019 04:53:22 -0400
Received: by mail-wm1-f70.google.com with SMTP id k184so2790704wmk.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6WForoZ07haDnFAIiqu7CBRwiMm0AVi80aP2nWRmURg=;
 b=DOoXKRSN/4kTxLOMmYONv13pq8KAtk6uCo7sZHDiYwGTxN0okxMVsCzqBXnk4R+PsK
 vHHdpYROVZLyxHdi/gTtaHfwjUEWY+w/Wvk8GArDn8QfLPrkB+awoWhJci63CI1SaBxB
 CghA86ingZVEmbO7xKWg+ihKiq2Hd1f+Cxghp2XrFdVUzQHnyp6Uwg3Efq7Scsf4qUaO
 uJwfJBMb9mdSHF5E45Gmyxpz49m9xxrNElmKY1aAUjfG+ECetIZvN7CW0WdJ+gzBasBk
 xwnv0x1FmeIyUnfjjZ4DnCrAdCOlyHrh3B3TqzMY+Z5xFXept73HhDqPjp+FAiHLQ8I+
 RhBg==
X-Gm-Message-State: APjAAAVjqqV0dKi2eslBKfCymdy51AgbAT3Gqc8qkz5H0ZkQ6Zz8Kjxb
 IDmZIErju7crLo1fORAhynX1T/nmIxsZZUOZ+/PoJVGGT8lwlqorYXQI0j+qvC1ZrD7+/IC/8mc
 LVcwU7SNJh7I9hw0=
X-Received: by 2002:a7b:c758:: with SMTP id w24mr5912701wmk.148.1569056001209; 
 Sat, 21 Sep 2019 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDciHQZohhc3R6L5DWX0Vcq6UAwtBOrAQCfa4u0hJ4AVqh0qwOFFMgvXNTfjU52NZtgA3Z+Q==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr5912692wmk.148.1569056001038; 
 Sat, 21 Sep 2019 01:53:21 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v2sm8598442wmf.18.2019.09.21.01.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:53:20 -0700 (PDT)
Subject: Re: [PATCH 1/7] target/alpha: Use array for FPCR_DYN conversion
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f60fbb71-edb6-bb0d-8e39-8a87b30d4cb0@redhat.com>
Date: Sat, 21 Sep 2019 10:53:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190921043256.4575-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: YP-uDdiLNNqbmkUaOIWFPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 6:32 AM, Richard Henderson wrote:
> This is a bit more straight-forward than using a switch statement.
> No functional change.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/helper.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 19cda0a2db..6c1703682e 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -36,6 +36,13 @@ uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
> =20
>  void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
>  {
> +    static const uint8_t rm_map[] =3D {
> +        [FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT] =3D float_round_nearest_even=
,
> +        [FPCR_DYN_CHOPPED >> FPCR_DYN_SHIFT] =3D float_round_to_zero,
> +        [FPCR_DYN_MINUS >> FPCR_DYN_SHIFT] =3D float_round_down,
> +        [FPCR_DYN_PLUS >> FPCR_DYN_SHIFT] =3D float_round_up,
> +    };
> +
>      uint32_t fpcr =3D val >> 32;
>      uint32_t t =3D 0;
> =20
> @@ -48,22 +55,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t=
 val)
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
> +    env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SH=
IFT];
> =20
>      env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ)=
;
>      env->fp_status.flush_inputs_to_zero =3D (fpcr & FPCR_DNZ) !=3D 0;
>=20


