Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD03C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74A92070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njLzv78u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74A92070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUor-0002go-WE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsUSG-0005hZ-Ug
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:58:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsUSE-0005nn-Qc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:58:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so30617269wrl.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version:content-transfer-encoding;
 bh=LIcEjIebpkVZqxUUtE1ONzS7ZlwjXksr8z4YAXj3pAU=;
 b=njLzv78u9pQynoJ6n/peCpC6z98NrkeF9kUZQmOuelkSkoR7h7IYD8lRFkRxZxdPHZ
 ljy4Qkpu/LgLP9MjR5YA21LBmHE+9zvWFS4puW80aWVLies5NFIuvYwBR01vFKBhsbJN
 D4qpCyVlWhX0oEPLS2Q+HG22dhH3WeX1AQf6ZZcjgsedPeGap0JkPNwWmjlalD9t4zIS
 62L7umT4ua76OJCyNOeNDVvFLb4yWAKNwlfSlQ0bdR/0z023XnO6wOrLfTFaEyggYAC0
 kofxIyZQfUEIMxTnj7fa6bvAwfgf7HbsDSj+a/IYxRG5IdzkaJG9AY5x4QNF1+BPTFcV
 SHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version:content-transfer-encoding;
 bh=LIcEjIebpkVZqxUUtE1ONzS7ZlwjXksr8z4YAXj3pAU=;
 b=NfVSIYz3Pbvk7i0IFtsOxq/CsYsaBol6sy0WccVtGUiIevHE+mDKpxMI+aBdlVcYzl
 w+4cShYrF+9w/L5TVyxoH8Boqrdv5QI0IQHPd74dt11d5bSfXhSiDgxA/gFtv+c2CTMG
 dfV/ehh2c9vpN8y7HEEH+ll0Z/O/3H90JmvkFBw06qMYr02x//ddg+LFN1o1LRxv5GG8
 W/7Hhy6G0pMKAxXce/+cfZNbjkhZsndnt599ioYGhBFK0AAEnjXPFvaIjY0Pq1Y8yA9C
 aFFQGHSKq2TTN3lv0OCTeAL/0dW/kbOL0Rfc8q27RkGe9Ya93gPtCUZkT/hci/2Yvn2M
 4Quw==
X-Gm-Message-State: AOAM530qMD6iHJoUb5kmOVbKg4LomAO5uDBMWJlV+p4qNLQbi7uRssRN
 h74sxhhy/27vkvxBPVKonfYQ5y7R4pg=
X-Google-Smtp-Source: ABdhPJyuNH3Plkw7aDRkjdnmnJPeIQHfIHOnxI8Gh90pelwRZF+sxHN579HM4ujWSMwvdYnuXmIwrg==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr55092998wrn.157.1594054731979; 
 Mon, 06 Jul 2020 09:58:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d81sm572787wmc.0.2020.07.06.09.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 09:58:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E70051FF7E;
 Mon,  6 Jul 2020 17:58:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] softfloat,m68k: disable floatx80_invalid_encoding() for
 m68k
References: <20200612140400.2130118-1-laurent@vivier.eu>
Date: Mon, 06 Jul 2020 17:58:49 +0100
In-Reply-To: <20200612140400.2130118-1-laurent@vivier.eu> (Laurent Vivier's
 message of "Fri, 12 Jun 2020 16:04:00 +0200")
Message-ID: <87o8ospol2.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <laurent@vivier.eu> writes:

> According to the comment, this definition of invalid encoding is given
> by intel developer's manual, and doesn't comply with 680x0 FPU.
>
> With m68k, the explicit integer bit can be zero in the case of:
>  - zeros                (exp =3D=3D 0, mantissa =3D=3D 0)
>  - denormalized numbers (exp =3D=3D 0, mantissa !=3D 0)
>  - unnormalized numbers (exp !=3D 0, exp < 0x7FFF)
>  - infinities           (exp =3D=3D 0x7FFF, mantissa =3D=3D 0)
>  - not-a-numbers        (exp =3D=3D 0x7FFF, mantissa !=3D 0)
>
> For infinities and NaNs, the explicit integer bit can be either one or
> zero.
>
> The IEEE 754 standard does not define a zero integer bit. Such a number
> is an unnormalized number. Hardware does not directly support
> denormalized and unnormalized numbers, but implicitly supports them by
> trapping them as unimplemented data types, allowing efficient conversion
> in software.
>
> See "M68000 FAMILY PROGRAMMER=E2=80=99S REFERENCE MANUAL",
>     "1.6 FLOATING-POINT DATA TYPES"
>
> We will implement in the m68k TCG emulator the FP_UNIMP exception to
> trap into the kernel to normalize the number. In case of linux-user,
> the number will be normalized by QEMU.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Apologies for the private reply, was using my fallback tooling while
email was down and that doesn't automatically include the group address.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

By all means take it via the m68k tree.=20

> ---
>  include/fpu/softfloat.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 16ca697a73b7..f6eda4ca8e6c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -791,7 +791,31 @@ static inline bool floatx80_unordered_quiet(floatx80=
 a, floatx80 b,
>  *-----------------------------------------------------------------------=
-----*/
>  static inline bool floatx80_invalid_encoding(floatx80 a)
>  {
> +#if defined(TARGET_M68K)
> +    /*------------------------------------------------------------------=
-------
> +    | With m68k, the explicit integer bit can be zero in the case of:
> +    | - zeros                (exp =3D=3D 0, mantissa =3D=3D 0)
> +    | - denormalized numbers (exp =3D=3D 0, mantissa !=3D 0)
> +    | - unnormalized numbers (exp !=3D 0, exp < 0x7FFF)
> +    | - infinities           (exp =3D=3D 0x7FFF, mantissa =3D=3D 0)
> +    | - not-a-numbers        (exp =3D=3D 0x7FFF, mantissa !=3D 0)
> +    |
> +    | For infinities and NaNs, the explicit integer bit can be either on=
e or
> +    | zero.
> +    |
> +    | The IEEE 754 standard does not define a zero integer bit. Such a n=
umber
> +    | is an unnormalized number. Hardware does not directly support
> +    | denormalized and unnormalized numbers, but implicitly supports the=
m by
> +    | trapping them as unimplemented data types, allowing efficient conv=
ersion
> +    | in software.
> +    |
> +    | See "M68000 FAMILY PROGRAMMER=E2=80=99S REFERENCE MANUAL",
> +    |     "1.6 FLOATING-POINT DATA TYPES"
> +    *-------------------------------------------------------------------=
-----*/
> +    return false;
> +#else
>      return (a.low & (1ULL << 63)) =3D=3D 0 && (a.high & 0x7FFF) !=3D 0;
> +#endif
>  }
>=20=20
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)

--=20
Alex Benn=C3=A9e

