Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A78C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F16A2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iX+T92qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F16A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL2L-0008Az-Od
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiKvK-0006tj-Do
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:46:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiKvJ-0007sJ-5c
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:46:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so183559wmh.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ukTo7SPGJsbWUaktAMaguRvwu02zy+paMfdYZwiolxU=;
 b=iX+T92qAf5iXlo0ZFGocOB3jV8YhKETenU0zhkw0VlIigcY0oKR7JuXDZ1QNH3iGZK
 ZYNha+cjpwhj4McnzV0A6cMckBsO1Nm6YWj9+on09wJjXl8grTVtUjpMlrIIfM2JO/m8
 Hd46IHO9cyvXCljD8TDI/zMhRuCQK3QGRXM/W53QN3rbHri42go9A1Jjx0ShSWOR/eLj
 bYsKTG2hTma+DiQiemye1z8xudlRjO5o1C9RE1ApC4wLD1KVTpCpMKvGAl6FShFl7Eat
 rG+aPKOapwGDA6hFGjGKq6oMqHne8yF/vKVRDkLV1VTayOwu+EHLv2rwWFb4gc29HRFB
 No3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ukTo7SPGJsbWUaktAMaguRvwu02zy+paMfdYZwiolxU=;
 b=HBFZr3yLfdn54WtgdYl7IWI/F5zkFUwS4QtuAcSuRX6mR+6ZlZ9Mxef2Y0uo9ZVuXf
 FpCLi5GBD1sNCNBhhpm0XONhNWVz9xUx0tKmqaZCH/xepxAO7sSAyDY4GpAFXs6JwUaz
 atZ0qahmvuKeRNRTKdbWDw/La9gbYw9/0+JO8/J1enaLhHLpoO3018YPqUTGcye3+st8
 NXPs4vxPkmtDk0w1eRcUKFsAdRQp+Q4iEzQCdFvtbiM/sN9zEpmu/g4+evPdhBYWXsPn
 SkadTcXgYVlluZMaQbyxf1RlxqeMORKb9twJru/H4W8EGnKDQsrLsU8499vqpdqiBlGP
 j7hw==
X-Gm-Message-State: AOAM530rqUaEJVKQWH/J6PR8zPBMRZfI/wwgQD0+TP6L6rsKT2t8Goj9
 LJWXp3nRjufHtDfFYAIDPBq9wg==
X-Google-Smtp-Source: ABdhPJw+JEtwHDFLL9dHzB6eEg3a5Tfcx1mRT4UyZrhFqX84rmo6CVDvIK5GHGWjnOnz7ehyNcnO6A==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr222137wmk.91.1591634814850; 
 Mon, 08 Jun 2020 09:46:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm248767wrn.88.2020.06.08.09.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:46:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30A0B1FF7E;
 Mon,  8 Jun 2020 17:46:52 +0100 (BST)
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 6/7] target/i386: reimplement fprem1 using floatx80
 operations
In-reply-to: <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
Date: Mon, 08 Jun 2020 17:46:52 +0100
Message-ID: <87a71d5wub.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, qemu-devel@nongnu.org,
 laurent@vivier.eu, pbonzini@redhat.com, aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> The x87 fprem1 emulation is currently based around conversion to
> double, which is inherently unsuitable for a good emulation of any
> floatx80 operation.  Reimplement using the soft-float floatx80
> remainder operations.
>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  target/i386/fpu_helper.c | 96 +++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 51 deletions(-)
>
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 8ef5b463ea..bab35e00a0 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -934,63 +934,57 @@ void helper_fxtract(CPUX86State *env)
>      merge_exception_flags(env, old_flags);
>  }
>=20=20
> -void helper_fprem1(CPUX86State *env)
> +static void helper_fprem_common(CPUX86State *env, bool mod)
>  {
> -    double st0, st1, dblq, fpsrcop, fptemp;
> -    CPU_LDoubleU fpsrcop1, fptemp1;
> -    int expdif;
> -    signed long long int q;
> -
> -    st0 =3D floatx80_to_double(env, ST0);
> -    st1 =3D floatx80_to_double(env, ST1);
> -
> -    if (isinf(st0) || isnan(st0) || isnan(st1) || (st1 =3D=3D 0.0)) {
> -        ST0 =3D double_to_floatx80(env, 0.0 / 0.0); /* NaN */
> -        env->fpus &=3D ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
> -        return;
> -    }
> -
> -    fpsrcop =3D st0;
> -    fptemp =3D st1;
> -    fpsrcop1.d =3D ST0;
> -    fptemp1.d =3D ST1;
> -    expdif =3D EXPD(fpsrcop1) - EXPD(fptemp1);
> -
> -    if (expdif < 0) {
> -        /* optimisation? taken from the AMD docs */
> -        env->fpus &=3D ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
> -        /* ST0 is unchanged */
> -        return;
> -    }
> +    uint8_t old_flags =3D save_exception_flags(env);

Hmm where did this come from:

/home/alex/lsrc/qemu.git/target/i386/fpu_helper.c: In function =E2=80=98hel=
per_fprem_common=E2=80=99:
/home/alex/lsrc/qemu.git/target/i386/fpu_helper.c:784:25: error: implicit d=
eclaration of function =E2=80=98save_exception_flags=E2=80=99; did you mean=
 =E2=80=98raise_exception_ra=E2=80=99? [-Werror=3Dimplicit-function-declara=
tion]
     uint8_t old_flags =3D save_exception_flags(env);
                         ^~~~~~~~~~~~~~~~~~~~
                         raise_exception_ra
/home/alex/lsrc/qemu.git/target/i386/fpu_helper.c:784:25: error: nested ext=
ern declaration of =E2=80=98save_exception_flags=E2=80=99 [-Werror=3Dnested=
-externs]
/home/alex/lsrc/qemu.git/target/i386/fpu_helper.c:827:5: error: implicit de=
claration of function =E2=80=98merge_exception_flags=E2=80=99; did you mean=
 =E2=80=98get_float_exception_flags=E2=80=99? [-Werror=3Dimplicit-function-=
declaration]
     merge_exception_flags(env, old_flags);
     ^~~~~~~~~~~~~~~~~~~~~
     get_float_exception_flags
/home/alex/lsrc/qemu.git/target/i386/fpu_helper.c:827:5: error: nested exte=
rn declaration of =E2=80=98merge_exception_flags=E2=80=99 [-Werror=3Dnested=
-externs]
cc1: all warnings being treated as errors

--=20
Alex Benn=C3=A9e

