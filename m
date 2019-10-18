Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2092ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1FD21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVZx+vdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1FD21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRTD-0002RO-1T
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRRX-0001YG-7X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRRT-0003ah-Bd
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:33:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLRRR-0003Xr-Fa
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:33:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id 83so5087842oii.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=78OJkJ4IhTQipG9ELDS8c/fdUHRcaCtnkATcqPXAcbI=;
 b=sVZx+vdOBBt8GNbzfXyHRYR7DUo4MQpQgPR9rKeLIox/6/g0jZ7UCNEPzCunWASjYG
 /D3Od5FkQudtwG595RlTczzyvaId7jOQ9e/shGKNPweh58SmRlTMu9g/SRNJBZxb2aP9
 adfp1wg1dgRQQ4E8iwCv1lMTk79y+vrfHxDl9AYwNs35PYG3DMdcdBbuam56PdROeU3t
 EJXThIV4JVz6CGgWBhPgr7abZzFCi2+qNBqXifzr8Y5QV8feJhyDs6EQmTDAF/A2uYbU
 AX1xcEfvl19HK2egzCHqwbQ7lospyvbaUNrCKLqyT0aNPTVuMmIYy3U2S/UGYdZt3DO1
 sgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=78OJkJ4IhTQipG9ELDS8c/fdUHRcaCtnkATcqPXAcbI=;
 b=MCxPu8++O/cYteRbuWii47EVsrpVGklT7nef4tcfsQPoQdkpx8dTuYconD1l2Io4gd
 AeZzPwvA5jdNbvkJXo+nCufNUcNRgFea7OLvgPEfyoe8C1SuwGgdMSPrwlh/MIh/A1ze
 MAzM4360C+/uICKDjN3ojRNLT2KJMZ1sx9y8uUE0FHmgxP2sXy7XKEgyw5X2YJhz0saB
 zm+JsJHpHBlOvMbG6j2ypas3LYlzFBQ17yZ4dtX8e4xZMGtpfUf0tAZG/CtzcIWu7yZM
 S4kjvvh/5OTmQUnUNal8cvhd8l9dduDTme8CpC2EdVqSC4qGjRjPeEmPWes0DEdvSLFR
 K5kQ==
X-Gm-Message-State: APjAAAWIt+gXsQfNZ2zeqZ0KirgO9n5Dz4agOk+oGkP9xcxLMzljncwj
 U1JF3zTVC8oA46CgC7zmHd9JzSRH7GWPEx5VNLu+0g==
X-Google-Smtp-Source: APXvYqzc6mhK81Pk/sLWTkyHUO21Iam+WOWOPM1kyx6DtiPTjqsCrDd8awCzoDQ/hvB/UfkgtRyvxJWLXVYZhE/vTNc=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr7479583oik.146.1571401984190; 
 Fri, 18 Oct 2019 05:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-18-richard.henderson@linaro.org>
In-Reply-To: <20191017185110.539-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 13:32:53 +0100
Message-ID: <CAFEAcA8h9CN_qarQdfXRonE8KYO2=s+Jh_o+LFs9qk9M20pweA@mail.gmail.com>
Subject: Re: [PATCH v7 17/20] target/arm: Rebuild hflags at MSR writes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 19:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Continue setting, but not relying upon, env->hflags.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 13 +++++++++++--
>  target/arm/translate.c     | 28 +++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 7 deletions(-)
> @@ -7068,14 +7070,30 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
>              }
>          }
>
> -        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_C=
P_IO)) {
> -            /* I/O operations must end the TB here (whether read or writ=
e) */
> -            gen_lookup_tb(s);
> -        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> -            /* We default to ending the TB on a coprocessor register wri=
te,
> +        /* I/O operations must end the TB here (whether read or write) *=
/
> +        need_exit_tb =3D ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
> +                        (ri->type & ARM_CP_IO));
> +
> +        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +            /*
> +             * A write to any coprocessor regiser that ends a TB

(typo: "register")

> +             * must rebuild the hflags for the next TB.
> +             */
> +            TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +            if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
> +            } else {
> +                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +            }
> +            tcg_temp_free_i32(tcg_el);

Why only rebuild hflags if !ARM_CP_SUPPRESS_TB_END ?
For instance on the Xscale CPUs we set SUPPRESS_TB_END for the SCTLR,
but some of the SCTLR bits are cached in hflags, right? Do we somehow
arrange to rebuild the hflags when the TB does eventually end ?

> +            /*
> +             * We default to ending the TB on a coprocessor register wri=
te,
>               * but allow this to be suppressed by the register definitio=
n
>               * (usually only necessary to work around guest bugs).
>               */
> +            need_exit_tb =3D true;
> +        }
> +        if (need_exit_tb) {
>              gen_lookup_tb(s);
>          }

thanks
-- PMM

