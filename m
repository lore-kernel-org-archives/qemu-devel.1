Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB534C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E7820882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxYNrkMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E7820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRa9-0008Fk-CZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRHF-0000XQ-HK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRHD-0001LD-Ji
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:33:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCRHA-0001JP-JW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:33:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id x2so10739110wmj.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+afsgYaiG5Npfsc5OF+jPcwWxj/en5EfOlGmBL9Ooqs=;
 b=UxYNrkMXs4manuGHj/Z0klAc+GuT2J1codxXduEbS4RlWgeNspDdgYY5DbH3hghXwP
 Kwyxhw9/+UlQo8qcEal7D+lFgMLxJz4qc7QqbmYZ1Fm+xnn1EG8Fd1v1BmYTJWquarN+
 3XNtF3pWwFSTATbpKPjIeaHuhYEZR+T89Rez4jgs4Kxyw8lM9hgxKOWlw+RJTTo8jSjR
 iPDvqr1YDRn/+Mdw0Oe8EVAqmeyeyyAor8mAaklgyLEkGOCYb2cU9u8f8FUWkhH1n5Lt
 8T4Xx81Ndec7o9Auo4cU4D0GkuKLjIlgbebwjojZhNpnHg3HXUvJQpV9MCESvb2CceEQ
 JuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+afsgYaiG5Npfsc5OF+jPcwWxj/en5EfOlGmBL9Ooqs=;
 b=HeXkucKk8v6F4UJNwcYpib491UbbO4/O2Q4d2DGt6kivsPQ9y0mlUJ+89QQ3ngzIXD
 tY3bwoaHe+76Pj1hhFqAYAkxwaUyIgzjLOT1JpC+b+KHwPWq0p/tSBO+J65E7+rMisfm
 JZvfgJKeEwi9RgAqqCFxHTTasoJ4YFDPfzhNoEvXJS9sjA/tyvKi0O4a3Euz0xObroV4
 +K0iaKC5MzemO+7PrlEag47o4wy9nUGkmZpyKZTiZLKrNtgjyJQ7L3UCOX8/G4vAqx1r
 Z4eqAF1Re9pt/85aCDvV5nKSdyo3Fs/qfcBILBspr2xASGGVxtGwyGkKBJ17r0r/QxXF
 vZbQ==
X-Gm-Message-State: APjAAAUd7RqO5cUcTwk253Q3ScNcxLjCxGMe9BdHkQ4AdN7H5BP41DYI
 df/SBsKAMPFenI+o3xycTmfTqQ==
X-Google-Smtp-Source: APXvYqyAp2+g9tTG6+JwOgALfSL6XMAQAxSjT05Ej5cE3XHEgmDmspl8yMVFLGD2oxzEJSzqmzmS+g==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr423054wma.120.1569256402126; 
 Mon, 23 Sep 2019 09:33:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d193sm15656731wmd.0.2019.09.23.09.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:33:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEA0F1FF87;
 Mon, 23 Sep 2019 17:33:20 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/7] target/alpha: Fix SWCR_MAP_UMZ
In-reply-to: <20190921043256.4575-3-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:33:20 +0100
Message-ID: <87pnjras6n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We were setting the wrong bit.  The fp_status.flush_to_zero
> setting is overwritten

".. in the generated code.."?

> by either the constant 1 or the value
> of fpcr_flush_to_zero depending on bits within an fp insn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 6c1703682e..10602fb339 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -71,7 +71,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t =
val)
>          env->fp_status.flush_inputs_to_zero =3D 1;
>      }
>      if (env->swcr & SWCR_MAP_UMZ) {
> -        env->fp_status.flush_to_zero =3D 1;
> +        env->fpcr_flush_to_zero =3D 1;
>      }
>      env->fpcr_exc_enable &=3D ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32=
);
>  #endif


--
Alex Benn=C3=A9e

