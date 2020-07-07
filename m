Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E8220702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrPWA+57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E8220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskqN-0001j0-9r
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskpn-0001EM-5X
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:28:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskpl-0004QU-4L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:28:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so42726574wmg.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p+iyROxKk6N5yZzgwF2YGEAM+nqLh739JgpDap1FNe0=;
 b=DrPWA+571uxdePEvE2XYZTSDeRpZHYbQu3GEo3nJkHf+mm2pTVqyu3jOc9M5kca+Hf
 pAzswQXw6O+WKgC2leBtX6+r/oj6IKczORMr2C3cN89boC3E63wsvjyuV2oXKzXq1Bs9
 rnUBfdFzdPCIWaUZVCq9Nfh5DAdHhD+SFu3OhiiLBV3T8u/TfbR63WYBhRQ0yG2xE9+G
 4dZ9CJDSrhMEYJLTUV0ROzusOLRm2LPXQkm2o6Y1B7UkCca8HYQov8aCf80FBV8IlthH
 qzmGsq/yWsuQBS5s/fi0jG41YcDbIKcKAA5TF8B3BtNv0DtKhBm0xxVW9GrgX100TEdN
 B5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p+iyROxKk6N5yZzgwF2YGEAM+nqLh739JgpDap1FNe0=;
 b=WYPCbEzkrzPsojLAE/Cb6dEhF1DW6tANAyRHt8Iiukj9y4RMZQd/g0Z+9ws7ZvAjDf
 e77VAAy34x9+fjxBVAbyIFA2FEJwN/QN6ANY3KMAR6gbyLKfGwhz8LSzoBl+0ZHPwNuk
 VreS6w3s3MLgcI7WQKJa2eNn5SgW/BjwRQbFP090KAKAtR2W5ufxAA6j81FHjl4Fm33b
 wd329d314YeXgZc5SE5pTmIEt5FH0hkXzzHt3s4b69jiuoEWWekSCOGh4ABZZ8Fvrudt
 uauffLOzXne84D0tPMefbEOat6vtDqpDPeK+3PSbNSZC4mLi2W829+3LQgbWk8IESKHT
 JAwQ==
X-Gm-Message-State: AOAM533MT+dmsCmC9Rew/g1/4Cvs3rioCm5HGBkbliMamhrxkzlutcdr
 qDwlhK5pQWA695kkyDTlOZd/sw==
X-Google-Smtp-Source: ABdhPJzk8tVYuZNC6Rugt3jjrb0KTuC62bZoVPoIggRkRzA+hPtpk26KSALPqmy6NxfMysmREru1sQ==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr3514340wml.33.1594117695448; 
 Tue, 07 Jul 2020 03:28:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm520703wrb.78.2020.07.07.03.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:28:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC9C51FF7E;
 Tue,  7 Jul 2020 11:28:13 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-2-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 01/21] softfloat: make NO_SIGNALING_NANS runtime property
In-reply-to: <20200706234737.32378-2-jcmvbkbc@gmail.com>
Date: Tue, 07 Jul 2020 11:28:13 +0100
Message-ID: <871rlnpqki.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> target/xtensa, the only user of NO_SIGNALING_NANS macro has FPU
> implementations with and without the corresponding property. With
> NO_SIGNALING_NANS being a macro they cannot be a part of the same QEMU
> executable.
> Replace macro with new property in float_status to allow cores with
> different FPU implementations coexist.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  fpu/softfloat-specialize.inc.c  | 228 ++++++++++++++++----------------
>  include/fpu/softfloat-helpers.h |   5 +
>  include/fpu/softfloat-types.h   |   1 +
>  3 files changed, 117 insertions(+), 117 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.in=
c.c
> index 44f5b661f831..b26bc039b0b6 100644
> --- a/fpu/softfloat-specialize.inc.c
> +++ b/fpu/softfloat-specialize.inc.c
> @@ -79,13 +79,6 @@ this code that are retained.
>   * version 2 or later. See the COPYING file in the top-level directory.
>   */
>=20=20
> -/* Define for architectures which deviate from IEEE in not supporting
> - * signaling NaNs (so all NaNs are treated as quiet).
> - */
> -#if defined(TARGET_XTENSA)
> -#define NO_SIGNALING_NANS 1
> -#endif
> -
>  /* Define how the architecture discriminates signaling NaNs.
>   * This done with the most significant bit of the fraction.
>   * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
> @@ -111,12 +104,12 @@ static inline bool snan_bit_is_one(float_status *st=
atus)
>=20=20
>  static bool parts_is_snan_frac(uint64_t frac, float_status *status)
>  {
> -#ifdef NO_SIGNALING_NANS
> -    return false;
> -#else
> -    bool msb =3D extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
> -    return msb =3D=3D snan_bit_is_one(status);
> -#endif
> +    if (status->no_signaling_nans) {
> +        return false;

I have no objection in principle but seeing as we go to the trouble of
allowing snan_bit_is_one() to constant fold away I think it would be
worth doing the same with a no_signalling_nans(status). We can then
avoid an admittedly well predicted test for the non XTENSA case.

> +    } else {
> +        bool msb =3D extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
> +        return msb =3D=3D snan_bit_is_one(status);
> +    }
>  }
>=20=20
>  /*----------------------------------------------------------------------=
------
> @@ -170,9 +163,10 @@ static FloatParts parts_default_nan(float_status *st=
atus)
>=20=20
>  static FloatParts parts_silence_nan(FloatParts a, float_status *status)
>  {
> -#ifdef NO_SIGNALING_NANS
> -    g_assert_not_reached();

We could then keep the assert:

  g_assert(!no_signaling_nan(status))

<snip>
>      return status->tininess_before_rounding;
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 7680193ebc1c..10bd208e559f 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -167,6 +167,7 @@ typedef struct float_status {
>      bool default_nan_mode;
>      /* not always used -- see snan_bit_is_one() in
>      softfloat-specialize.h */

and then expand this comment:

    /* the flags bellow are not used on all specializations and may
     * constant fold away (see snan_bit_is_one()/no_signalling_nans() in
     * softfloat-specialize.h)
     */

>      bool snan_bit_is_one;
> +    bool no_signaling_nans;
>  } float_status;
>=20=20
>  #endif /* SOFTFLOAT_TYPES_H */


--=20
Alex Benn=C3=A9e

