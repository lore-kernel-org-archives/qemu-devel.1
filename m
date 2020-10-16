Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20D920679
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnFC6XJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20D920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSVF-0001uZ-Up
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSTU-0000rZ-5Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:21:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSTS-0000cV-1Z
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:20:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so3535254wru.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VDDkx93lhUJ9Wpcaqw+VhczNFMQRUQgyRUbW0sgqUwo=;
 b=lnFC6XJ8udkSndlyGErUHLxCqgoTl5rVGijMC5RE1Wz4/jWSUjEBDdoFbIvE4lE6O7
 pXtvRULvPx9wpNFphqUcXOzbcWx+G4owVwQBLmpctHIvrMGFHSbwhfqeaM2BOwvriifR
 yCTeCzyiL65igE5VKG4WDoghXF9npmsUz5C72Pmyu3deWKX/uOk4wqtQ8vs6xxpVnWWI
 FNwtXph4elKOJwgbyHUI0p5VUYG4k6Kz7nvlQNTSq8PXYGNS4GX6GkD2fvAI6zp3XQwF
 IV8MPsAUNSEygrKcBqD3XsJ9wpp+mMvI/V4ExuxynxfSvrpzpABHpdN0uzgvq0Us6L7t
 2A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VDDkx93lhUJ9Wpcaqw+VhczNFMQRUQgyRUbW0sgqUwo=;
 b=TBp2cbM7yaiVxhjzfIMKdXPMFSHrjd0cbxz6In96n800VONVRseyHviYUW83OElhMn
 ZEp9onGRUUSlGw8rG//FPuk6ANNpTEgQHN+Pn125TjGuQbDqLcdbksX0U2VhGucI6R3x
 g9G7MruC2otnPtmp5TrUYtq3N//g/kaT3ZpvTQeSGpL6gu8YygHC5iC0Q0uUrqCbMaGt
 AyIhFtzVl4tMHHvf0A/ausDrfs5x+Omvhn/vIxcf+0BDutp91mLXfy3gk+M0c+DkGhUK
 C4waOOjMjvOZeYHZIb/w4jGlQP0JWyIqacZbVHTXyJmjknZdzxESW3i3Zj1fXT8QhLyB
 H45Q==
X-Gm-Message-State: AOAM533S0/QAy3tdjIY2atKt88RTsHxgSM4SHbzE+ZzXMmGV9JQTScZf
 E7Uwt/DXHbrCK7OJ9NUYVFaUHQ==
X-Google-Smtp-Source: ABdhPJwcuuPbFTEv0rczQih62gKWqcaK/+iZRe1UX5yTl91CZmdNYYOicrX2+6wOIXj+JZCdkHomIg==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr4761518wrw.126.1602865255834; 
 Fri, 16 Oct 2020 09:20:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y10sm4071105wrq.73.2020.10.16.09.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:20:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E85B1FF7E;
 Fri, 16 Oct 2020 17:20:54 +0100 (BST)
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-6-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 05/10] softfloat: Inline pick_nan_muladd into its caller
In-reply-to: <20200925152047.709901-6-richard.henderson@linaro.org>
Date: Fri, 16 Oct 2020 17:20:54 +0100
Message-ID: <87wnzquopl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: bharata@linux.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Because of FloatParts, there will only ever be one caller.

Isn't that admitting defeat - after all the logic here will be the same
as the login in the up coming float128_muladd code and we only seem to
need additional information:

> Inlining allows us to re-use abc_mask for the snan test.

couldn't we just pass the masks in?

<snip>
> -    if (is_snan(a.cls)) {
> -        return parts_silence_nan(a, s);
> -    }
> -    return a;

here.

> -}
> -
>  /*
>   * Returns the result of adding or subtracting the values of the
>   * floating-point values `a' and `b'. The operation is performed
> @@ -1366,7 +1327,41 @@ static FloatParts muladd_floats(FloatParts a, Floa=
tParts b, FloatParts c,
>       * off to the target-specific pick-a-NaN routine.
>       */
>      if (unlikely(abc_mask & float_cmask_anynan)) {
> -        return pick_nan_muladd(a, b, c, inf_zero, s);
> +        int which;
> +
> +        if (unlikely(abc_mask & float_cmask_snan)) {
> +            float_raise(float_flag_invalid, s);
> +        }
> +
> +        which =3D pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
> +
> +        if (s->default_nan_mode) {
> +            /*
> +             * Note that this check is after pickNaNMulAdd so that funct=
ion
> +             * has an opportunity to set the Invalid flag for inf_zero.
> +             */
> +            which =3D 3;
> +        }
> +
> +        switch (which) {
> +        case 0:
> +            break;
> +        case 1:
> +            a =3D b;
> +            break;
> +        case 2:
> +            a =3D c;
> +            break;
> +        case 3:
> +            return parts_default_nan(s);
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        if (is_snan(a.cls)) {
> +            return parts_silence_nan(a, s);
> +        }
> +        return a;
>      }
>=20=20
>      if (unlikely(inf_zero)) {

I'm not totally against it given it's fairly simple logic but it seems a
shame to loose the commonality of processing which makes the parts code
so much nicer.

--=20
Alex Benn=C3=A9e

