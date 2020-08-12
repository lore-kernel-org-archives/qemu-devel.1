Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A6F20656
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sorxV6Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A6F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nPD-0007GJ-7u
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5nOV-0006R1-4C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:50:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5nOT-0007Qs-28
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:50:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id c15so1389762wrs.11
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EqNTeNlhWWGiZujO9+PQbqeNQdDqn3rSM9YOtR6JszA=;
 b=sorxV6ZhGn5y+dU+u+quqPGdjJ2t0+ybOOm49i2ebJLQodkZgPJoPhk88XB/HI8PkT
 RChB5n04xEqppcAhm2nD3Y9J57QSkv52GAbzyDFtu1SI9jnhestbmZ5eT++d6VVD87FQ
 0xpJDzN+n0pJ18+1WINtZfdxowWLSnhpoFVhM0t6mlZRRHPkYFFlSQn32XL172IaXadN
 YmFLpUlxpKXidQlouCkUkXo4C5Tvdq6n3rQ+NIARPJgUof9ZWhua8EfDs0O5Yfd25aUA
 yQXUE3r79E2EDNBrZwGXRNeVgFE57f/A4OxXBDEZN6wlM3Cf4cmdVepvU58tYooTVNbb
 A42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EqNTeNlhWWGiZujO9+PQbqeNQdDqn3rSM9YOtR6JszA=;
 b=dCGaLpcUIJDBupJ5HPT+rCsYqdeI1E0EMGhdjLHhCbvn6WLEAEQ8QexP/3CeDoCEPv
 3m+HID0k5CBvaZd1Z2IjR9iSOQRn5QDHDwsazQ4/8WlYlFApkdVUePkb00atdIGufqk2
 QuT/nOoSW90NwQnRybfh9zLaNi3G/vhrm6U6KsYmZFnVWSrsr+CQFXoNI2fa8KC4/pub
 EFP47tKiZndlL0RZqw/OpaB/zgZaoXFkKVx4QV51VBlkcz77o+YbWYFVMJidcrA3MXDt
 M7EPR/BQ3MJydpc+xntiIUJb/jPvtsO+5/5FpIVReOjSUCVkJknMY2ptrXW5JxxYd/3y
 ZRfw==
X-Gm-Message-State: AOAM531NFLpe2FBavsp9Y7Oz8U6AMldOqMLm/rnALBg4JZJBMAT5troA
 5AbUnN68XSQ6wiA2Q7GLr3aP4n85shw=
X-Google-Smtp-Source: ABdhPJyApPAkzAsAfJByUan5FlNccgwa69zAEtS77NaPgOspFsq/GXWAltdYgWGNDykuE5B7MBu9Uw==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr36301325wrm.153.1597225799072; 
 Wed, 12 Aug 2020 02:49:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t17sm2749894wmj.34.2020.08.12.02.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 02:49:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67E261FF7E;
 Wed, 12 Aug 2020 10:49:57 +0100 (BST)
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-3-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] target/arm: Implement an IMPDEF pauth algorithm
In-reply-to: <20200812065339.2030527-3-richard.henderson@linaro.org>
Date: Wed, 12 Aug 2020 10:49:57 +0100
Message-ID: <87k0y419dm.fsf@linaro.org>
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Without hardware acceleration, a cryptographically strong
> algorithm is too expensive for pauth_computepac.
>
> Even with hardware accel, we are not currently expecting
> to link the linux-user binaries to any crypto libraries,
> and doing so would generally make the --static build fail.
>
> So choose XXH64 as a reasonably quick and decent hash.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/pauth_helper.c | 75 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
> index 6dbab03768..f1a4389465 100644
> --- a/target/arm/pauth_helper.c
> +++ b/target/arm/pauth_helper.c
> @@ -207,8 +207,8 @@ static uint64_t tweak_inv_shuffle(uint64_t i)
>      return o;
>  }
>=20=20
> -static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
> -                                 ARMPACKey key)
> +static uint64_t __attribute__((noinline))
> +pauth_computepac_architected(uint64_t data, uint64_t modifier, ARMPACKey=
 key)
>  {
>      static const uint64_t RC[5] =3D {
>          0x0000000000000000ull,
> @@ -272,6 +272,71 @@ static uint64_t pauth_computepac(uint64_t data, uint=
64_t modifier,
>      return workingval;
>  }
>=20=20
> +/*
> + * The XXH64 algorithm from
> + * https://github.com/Cyan4973/xxHash/blob/v0.8.0/xxhash.h
> + */
> +#define PRIME64_1   0x9E3779B185EBCA87ULL
> +#define PRIME64_2   0xC2B2AE3D27D4EB4FULL
> +#define PRIME64_3   0x165667B19E3779F9ULL
> +#define PRIME64_4   0x85EBCA77C2B2AE63ULL
> +#define PRIME64_5   0x27D4EB2F165667C5ULL
> +
> +static inline uint64_t XXH64_round(uint64_t acc, uint64_t input)
> +{
> +    return rol64(acc + input * PRIME64_2, 31) * PRIME64_1;
> +}
> +
> +static inline uint64_t XXH64_mergeround(uint64_t acc, uint64_t val)
> +{
> +    return (acc ^ XXH64_round(0, val)) * PRIME64_1 + PRIME64_4;
> +}
> +
> +static inline uint64_t XXH64_avalanche(uint64_t h64)
> +{
> +    h64 ^=3D h64 >> 33;
> +    h64 *=3D PRIME64_2;
> +    h64 ^=3D h64 >> 29;
> +    h64 *=3D PRIME64_3;
> +    /* h64 ^=3D h64 >> 32; -- does not affect high 64 for pauth */
> +    return h64;
> +}
> +
> +static uint64_t __attribute__((noinline))
> +pauth_computepac_impdef(uint64_t data, uint64_t modifier, ARMPACKey key)
> +{
> +    uint64_t v1 =3D 1 + PRIME64_1 + PRIME64_2;
> +    uint64_t v2 =3D 1 + PRIME64_2;
> +    uint64_t v3 =3D 1 + 0;
> +    uint64_t v4 =3D 1 - PRIME64_1;
> +    uint64_t h64;
> +
> +    v1 =3D XXH64_round(v1, data);
> +    v2 =3D XXH64_round(v2, modifier);
> +    v3 =3D XXH64_round(v3, key.lo);
> +    v4 =3D XXH64_round(v4, key.hi);
> +
> +    h64 =3D rol64(v1, 1) + rol64(v2, 7) + rol64(v3, 12) + rol64(v4, 18);
> +    h64 =3D XXH64_mergeround(h64, v1);
> +    h64 =3D XXH64_mergeround(h64, v2);
> +    h64 =3D XXH64_mergeround(h64, v3);
> +    h64 =3D XXH64_mergeround(h64, v4);
> +
> +    return XXH64_avalanche(h64);
> +}

You might find it easier to #include "qemu/xxhash.h" which we use for tb
hashing amongst other things.=20=20

--=20
Alex Benn=C3=A9e

