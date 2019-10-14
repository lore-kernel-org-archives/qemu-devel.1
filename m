Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D712C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5BF20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjfUaD8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5BF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54821 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4NS-0003nD-MF
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3O1-0007lu-Tl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3O0-0005IR-IY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:39:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK3O0-0005Ha-AF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:39:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id v8so20519004wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fTZTa1X8Ued9EKu5wJDqZ4sgEoAepINZP1QNVK08sro=;
 b=UjfUaD8l+Bix5k1kDTayyKU0yxbpqwoxq8gkKDwcbbM96cLgxBm03zG13Zmv0znCah
 AuvdP7xd5ZGYAVyRaczvCEXt1WOENxBLqENON4XHsAYPKYuXiEywiMy6u1pq2mFLK+Lw
 XhWCV1DJXw7kIxDNVr7fqNOX5BN2V+MkM7/Xdl1967EcJayfKbEjDUnCdaqmQ4T0FqIb
 ZrBszt4zLmjyk/34QmGP6nS8twWOkO4T32nQ0HYwPdepfftxbL9qTznwtR0ArSh2BYzL
 lvx/QvfLvg9Zm5EnAL9bvgxDWr7BUTqPaGvqILNbsLaU9VOcuCw2QjHyaMV5xdVqhZyj
 Wx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fTZTa1X8Ued9EKu5wJDqZ4sgEoAepINZP1QNVK08sro=;
 b=fKd1oncguzP52E4OTly7At7oAWLDXcow0lTBV7UE7j3Q6/hhxaGtInSZ/xpLF5/0Z7
 cH0S+NjaswDy6fScpuGZlhO6vg0cGw4/W4WyOP3XNamDtdaY76w0VWdJfForURHdbb21
 xUVaeRYH6XSF8QuhL9/Vf+7JmTiCe0wYVcstLi4olxeTe8CbGJnRxlxw5Lg9q9VK/UIu
 67PByjs24s7VTN3Nu4jlOOjiEYGR1Wfs23270jp60QEYeCmExv6caUC9uGTmb1NQXkfX
 D4XTyCwpjm18rA0+iPZzeIBgURqELFN+lhdC3alv70sPD7J2scVbRlLM8DC+dvCvKa9o
 gMrg==
X-Gm-Message-State: APjAAAUXqgTxKD1I5dc3mveA+1yDEbg0qRfOBd5Aebgq1ib1PL8kk4eV
 oCWBEbQZaQcPbVK4SxDl4wCznw==
X-Google-Smtp-Source: APXvYqxC1savmplNTTAjB1N+KTflJF+x1AYLQOoD39sAC33EKpgiCwGwCkwHJwvb2Err9oyWmiRu1w==
X-Received: by 2002:adf:8068:: with SMTP id 95mr28634980wrk.249.1571071194692; 
 Mon, 14 Oct 2019 09:39:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d193sm33043084wmd.0.2019.10.14.09.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:39:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41AB11FF87;
 Mon, 14 Oct 2019 17:39:53 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 09/20] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
In-reply-to: <20191011155546.14342-10-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:39:53 +0100
Message-ID: <87k197mgbq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We do not need to compute any of these values for M-profile.
> Further, XSCALE_CPAR overlaps VECSTRIDE so obviously the two
> sets must be mutually exclusive.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ddd21edfcf..e2a62cf19a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11235,21 +11235,28 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>              }
>          } else {
>              flags =3D rebuild_hflags_a32(env, fp_el, mmu_idx);
> +
> +            /*
> +             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
> +             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
> +             */
> +            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32,
> +                                   XSCALE_CPAR, env->cp15.c15_cpar);
> +            } else {
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, VECLEN,
> +                                   env->vfp.vec_len);
> +                flags =3D FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
> +                                   env->vfp.vec_stride);
> +            }
>          }
>
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len=
);
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_=
stride);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
>          if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
>              || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)=
) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
>          }
> -        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
> -        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
> -            flags =3D FIELD_DP32(flags, TBFLAG_A32,
> -                               XSCALE_CPAR, env->cp15.c15_cpar);
> -        }
>      }
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine


--
Alex Benn=C3=A9e

