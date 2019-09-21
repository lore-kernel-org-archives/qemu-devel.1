Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D5DC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6C8205F4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGarr5Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6C8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbBk-0000Y4-61
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbAN-0007yj-21
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbAI-0000hs-Gg
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbAI-0000ha-Bz
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569056089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lXbTEAxtaocxOW4ghQXcJ2LOZmb8OHO7E+Xhh/1eTyY=;
 b=QGarr5TjAyOK2HkQ3dcyk0OF7fvJHnMyx6bVkOOHuYXJmt34ZjSx27sHFBklaPSPuTc0pw
 Rv0xBMmgXQ8MuyLAdX7zTblT9gvcNVI/MuYx1xIB+eN+5pJ+QcAFq3LGed9J3qEUfzDBeT
 Z6MC10eWFLC0jzJBDO2FWeLNrsgN4TQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Z8nPyM_sNBWVaKF6ZZK-wA-1; Sat, 21 Sep 2019 04:54:48 -0400
Received: by mail-wm1-f70.google.com with SMTP id j125so2780100wmj.6
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lsn/rbUrbW1N9QFgq8K+mavhIeKJJlWCo8Iru8CCkss=;
 b=MmoOsFsOV2Ax/qE7LrdYbycPEANzso7q3pnPXwq6X2w/+tHDAw+xqfM1ACaIeLbdX0
 Dbws/n2F1vpjauLzJ50iKNk/CDbF18C4B4k+Ln8UcXhmU3KKS6fOTfPrA/LrpYkLRku+
 8hSoUA/pmRJbWMOqXDHTHgz5KFSlZ+sVuJVYBw5qvTlDhHDFhqrb+bPYlMrLDXma2P31
 p/zrjZyJNXVsywoVeUIj1B5KpsXYXzb5LtJRsRoGex09MtUaAeb9aSAirwngFVmZ5cIK
 OCiHknc9iBHkgA5hKqFi80eHiRP24tg2v1Q7V9nMvojH/2E79Udz9Bbs1ECQPqFXNBgQ
 jacw==
X-Gm-Message-State: APjAAAUkV5kacxMc07dpidIzSduMtPGEmIxy0BUMSvXh8cLnipSeJy+b
 ZD3GInwdh8Inmn9LxZbOu6uj5nV+5N82eYtxXJ1lfZcFGo5nivZhHU6Zmecr7C9igR8OZ1nQYy4
 Jgp6MUrqIpSjiVTU=
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr6930696wmf.42.1569056086768; 
 Sat, 21 Sep 2019 01:54:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyG8EWqCan3/oysLvSlrdhL9qtSAIGgt93eXYoLI4vsN0bNt66elL0GRXmKWmBSHhI/s+IA1A==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr6930688wmf.42.1569056086592; 
 Sat, 21 Sep 2019 01:54:46 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b15sm4182207wmb.28.2019.09.21.01.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:54:45 -0700 (PDT)
Subject: Re: [PATCH 5/7] target/alpha: Write to fpcr_flush_to_zero once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ebfe5441-ea3c-5019-7ea1-fd7db578f999@redhat.com>
Date: Sat, 21 Sep 2019 10:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190921043256.4575-6-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: Z8nPyM_sNBWVaKF6ZZK-wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> Tidy the computation of the value; no functional change.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 2f959c65ef..1b3479738b 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -69,14 +69,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_=
t val)
>      env->fpcr_exc_enable =3D ~t & FPCR_STATUS_MASK;
> =20
>      env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SH=
IFT];
> -
> -    env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ)=
;
>      env->fp_status.flush_inputs_to_zero =3D (fpcr & FPCR_DNZ) !=3D 0;
> +
> +    t =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
>  #ifdef CONFIG_USER_ONLY
> -    if (env->swcr & SWCR_MAP_UMZ) {
> -        env->fpcr_flush_to_zero =3D 1;
> -    }
> +    t |=3D (env->swcr & SWCR_MAP_UMZ) !=3D 0;
>  #endif
> +    env->fpcr_flush_to_zero =3D t;
>  }
> =20
>  uint64_t helper_load_fpcr(CPUAlphaState *env)
>=20


