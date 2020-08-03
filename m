Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6210C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A222076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQUVJSJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A222076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aWg-0006Jh-M2
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2aVb-0005Ky-4F
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:28:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2aVV-0004Q9-U4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:28:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id k8so15456203wma.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MVx+iRVYWciH3ZMzhSkQQWk7hvrYonOTOl41FsROIR4=;
 b=iQUVJSJkD3OyIN83QBBBkF/hnx4EqdLZdYr4hKI6+6zinstEiU6UKaVb2XKDc2i6AY
 af/PEVHiDT+xT0knChgvm9VmQFYc+81C+8KbekzbFjE3Ai7inzwdm/367A/XX4lEJ5BU
 zYqylI289PPccTXX9BtJxbp+Y5hEyKQBQrZceTBI+xImqgY8UxJB1yyb84lEx2RwHkgI
 wwh36df+GJ/IXJv4R5f9z4+HeqM04H46Suf+dyeG9I5LjMqlvAh+bha6mR7uskTFyzKS
 A1iUs2Nw+QJzaK5v61eE/pjyLxsj6yrb9I5jIShCG6u9A7LThi+ieIX3lcbhMxX74DOb
 BIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MVx+iRVYWciH3ZMzhSkQQWk7hvrYonOTOl41FsROIR4=;
 b=DBvXLu/z8rjWfgEzSlacHdacqRw11onhwQQEHId7I6EZyiIiG8hA9DnDbj69zrBDRp
 hsqiO1QYj5n5GwEy9tGoMlgYibgtIhdKKX2db9Y0XQ8fd4yutqszA2KONt+ALD2TFiGm
 0oyRJV+BA8w6a8luigLxS6U0dJBXY5sL8awGhTezeY5rEdXi3A+FbjHoAeu0zzH2nV6W
 Cg+YtcBXiHttvnB2jX7dPKocO1ARO1M8T0wgfgi/7W8KMotiiBGxlpeaFNWQL/JCRjXh
 5vaJvrAZy43aUIZb0nWtMDjUEetbSodFc0qtAXJDTMljUY3okKnVfqDhgVA5u9O4mE2w
 k+NQ==
X-Gm-Message-State: AOAM533YhiOWBaQZyl1iqz8Va1DOLzh5jtTMwMp0+0RiYCoKiAqVX3Xm
 ypc0efuBvFprhazfrVpzftVUvw==
X-Google-Smtp-Source: ABdhPJwQQeqa9vAQfBY34wTop01OmzeVA+nfCsyX4pazajWBqoonFcL3HSEml56i00hiE/FNgHVBZA==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr55975wme.174.1596461279443;
 Mon, 03 Aug 2020 06:27:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 62sm25172217wrq.31.2020.08.03.06.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 06:27:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 152C71FF7E;
 Mon,  3 Aug 2020 14:27:57 +0100 (BST)
References: <20200803124848.18295-1-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Delete unused VFP_DREG macros
In-reply-to: <20200803124848.18295-1-peter.maydell@linaro.org>
Date: Mon, 03 Aug 2020 14:27:57 +0100
Message-ID: <873653oo4i.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> As part of the Neon decodetree conversion we removed all
> the uses of the VFP_DREG macros, but forgot to remove the
> macro definitions. Do so now.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c39a929b938..27bf6cd8b51 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2471,21 +2471,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_=
t insn)
>      return 1;
>  }
>=20=20
> -#define VFP_REG_SHR(x, n) (((n) > 0) ? (x) >> (n) : (x) << -(n))
> -#define VFP_DREG(reg, insn, bigbit, smallbit) do { \
> -    if (dc_isar_feature(aa32_simd_r32, s)) { \
> -        reg =3D (((insn) >> (bigbit)) & 0x0f) \
> -              | (((insn) >> ((smallbit) - 4)) & 0x10); \
> -    } else { \
> -        if (insn & (1 << (smallbit))) \
> -            return 1; \
> -        reg =3D ((insn) >> (bigbit)) & 0x0f; \
> -    }} while (0)
> -
> -#define VFP_DREG_D(reg, insn) VFP_DREG(reg, insn, 12, 22)
> -#define VFP_DREG_N(reg, insn) VFP_DREG(reg, insn, 16,  7)
> -#define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
> -
>  static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
>  {
>  #ifndef CONFIG_USER_ONLY


--=20
Alex Benn=C3=A9e

