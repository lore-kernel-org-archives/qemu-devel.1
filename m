Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02542C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC8720882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KK1FCyd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC8720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRVF-0003Zf-Bj
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRM2-0004pv-To
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRM1-0003Yh-RQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:38:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCRM1-0003YD-Ka
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:38:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so10034077wmi.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4iYBPV5kH0RT9QR+mMvnp41T8jOC200THIzrjz1eWk8=;
 b=KK1FCyd3dVf+fUJOQsM7JXLKg5D4J+BRjeEWr+P6X2W3qSQ4P+n8ZtTEoaWT4n9abT
 WcyfBvcvCPuJetgfLFaL+BL17A4QhlhEv75R/iVwlxkxKFy/SvDMLJkFW76F/NwCqn0K
 HFOJVUCVHxfuzv7wbQNjl6y5XWOh1e7d03Ous//XTpdNYks7cFNVIrP5kgy46cFWydu3
 LiTztHMRCSIdHWx9tt7dt8i9BBkmXA0PMJKa9Cks3c7ERX1iM53s9QzGoeP8S5epzI0p
 IRHyqQ7Q4895GfAmOxKQyFSzIZ5rA/K3VTP8iQNSbLp+3WRc5aBPPZ+X0hGcIDWMXf1G
 AWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4iYBPV5kH0RT9QR+mMvnp41T8jOC200THIzrjz1eWk8=;
 b=VUCEMj0DE2nUYoz6aWBvNefzx+2TvUZhd+EUar8SXg9BL7L4N8+9197KbJ993tlTxM
 kEUKF2G3g4BKhpbrWUuMCM5xUVwzDl5Tyq1/ycML8n10xGTww2PBbblLlvLud1WDZqsB
 iP+mZNaP/wa5ATuYVveKTOW+X9bCCJlrfYSO2kBbUp7IVENT30hWOZmWDLtSD3k//wuj
 LabShOj9wgm6t4Gy+sum7md0DFY+vIiWv23QevP19ibzOq4le8u8vrLPSN7hDPHMr9hT
 cR58UwLL9EBmESO3nP2QMycqsSbKU+ROx7yrNVr8W2Nl0GF6E9wu8Pk5bhQ3kyeT6eWj
 yNmQ==
X-Gm-Message-State: APjAAAWFuEwb3q6xq8tbDcPmrZbtl+Rtjxd8I3ejxmPR4XEOLijoKFzz
 5JARBqI+5+ualyFeRsO6o+l0rA==
X-Google-Smtp-Source: APXvYqzIkNiG3tu4UztzIK8h9j5VL79Jq02FQjcfOskuw6qK+gAba1v7qy8Xe/p1D0Iw878yJs9wNg==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr415360wmy.34.1569256704152; 
 Mon, 23 Sep 2019 09:38:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w125sm24779300wmg.32.2019.09.23.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:38:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C767B1FF87;
 Mon, 23 Sep 2019 17:38:22 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 5/7] target/alpha: Write to fpcr_flush_to_zero once
In-reply-to: <20190921043256.4575-6-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:38:22 +0100
Message-ID: <87o8zbary9.fsf@linaro.org>
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

> Tidy the computation of the value; no functional change.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 2f959c65ef..1b3479738b 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -69,14 +69,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_=
t val)
>      env->fpcr_exc_enable =3D ~t & FPCR_STATUS_MASK;
>
>      env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SH=
IFT];
> -
> -    env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
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
>
>  uint64_t helper_load_fpcr(CPUAlphaState *env)


--
Alex Benn=C3=A9e

