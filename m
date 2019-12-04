Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B7C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC12120833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w52TPOv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC12120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTq4-0002Yu-C8
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icTGh-0005iG-NQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icTGX-0006kp-C6
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:56:23 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icTGW-0006HA-20
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:56:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so6723249wmg.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RVPzbJlUj4l2gfWqnQM/tLIoXopJvbtoUDZRcW12RB8=;
 b=w52TPOv2wXksms0+VZnYrOEkzmu0RZkf6X67O70cAmh+DPmMVd34eqmuDKPkBAEfdm
 4rOr1vUqIKqQnW+DuAek3pqHuYbi0fc8yAwRP0sDeB6RU3NQzkzW+B9VHpOnSPrNnG/N
 oW7V/UUsFUMLSYP4uf6youpBJMDRlLW52Ypppnszmqe8a4y8b8fyYjMCDm4TBiqciUVd
 3lJa1RbW7X3btMBeuvvhNi8NnMIVWgl0A8w770G4xtpCE3X4ERQk+2r53JrLo0TpIDOv
 P8dIbmf1H/MAMU93GhCjjMW65i9C3OGx6PRwyIqq7hlyzBik5pdN2iESxJU7VA1oeGiz
 qkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RVPzbJlUj4l2gfWqnQM/tLIoXopJvbtoUDZRcW12RB8=;
 b=s0QmHYDyaBEDhUMzc1eUvyKoH6TNPdw+fqmmW38rDVh6h3Q5tpeEycBNQkZm7JY2dY
 eS4zCpDVUtQHfSYn+97PVKOFjtOX6TDP9yGpw53QgmzwaLONCNyXR/RpANzaWj/NEXGN
 50WZSxE04TFAvbKY257YO514gmsGtx33fXIG4ZgXhoBuLp4+wIgwteT3UouLxfLbqlUQ
 xgfBL8YhFVhCzu3i1UnOZvuw2001k9fub4VZlR4Svnlc5gRXP510OW74ePSSSNheSd8Z
 lqHU0axRZywC5fpUdi0HBYvlzLXvS4w4kW3R++U7yycUIRhKXsnO180MS21XC/4wF96s
 STIQ==
X-Gm-Message-State: APjAAAXjUDNEyIT27GoPJmjSnLOZd+I2rtiMK3vDQSP92al95d06H++M
 AoWaxFbR1vEd/vr85z6uj4xXnw==
X-Google-Smtp-Source: APXvYqy5aUiYn7x4ANhNDPza0I/plC8pIWGW7FwlcPrP7VTUbOGHSUqLd3Rsw7Eb+vS3EebC5/p0Wg==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr28692084wma.91.1575460574218; 
 Wed, 04 Dec 2019 03:56:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm7405894wrj.10.2019.12.04.03.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:56:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 728831FF87;
 Wed,  4 Dec 2019 11:56:12 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 16/40] target/arm: Rearrange ARMMMUIdxBit
In-reply-to: <20191203022937.1474-17-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:56:12 +0000
Message-ID: <87sgm08ftv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Define via macro expansion, so that renumbering of the base ARMMMUIdx
> symbols is automatically reflexed in the bit definitions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5f295c7e60..6ba5126852 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2886,27 +2886,34 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_Stage1_E1 =3D 1 | ARM_MMU_IDX_NOTLB,
>  } ARMMMUIdx;
>=20=20
> -/* Bit macros for the core-mmu-index values for each index,
> +/*
> + * Bit macros for the core-mmu-index values for each index,
>   * for use when calling tlb_flush_by_mmuidx() and friends.
>   */
> +#define TO_CORE_BIT(NAME) \
> +    ARMMMUIdxBit_##NAME =3D 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX=
_MASK)
> +
>  typedef enum ARMMMUIdxBit {
> -    ARMMMUIdxBit_EL10_0 =3D 1 << 0,
> -    ARMMMUIdxBit_EL10_1 =3D 1 << 1,
> -    ARMMMUIdxBit_E2 =3D 1 << 2,
> -    ARMMMUIdxBit_SE3 =3D 1 << 3,
> -    ARMMMUIdxBit_SE0 =3D 1 << 4,
> -    ARMMMUIdxBit_SE1 =3D 1 << 5,
> -    ARMMMUIdxBit_Stage2 =3D 1 << 6,
> -    ARMMMUIdxBit_MUser =3D 1 << 0,
> -    ARMMMUIdxBit_MPriv =3D 1 << 1,
> -    ARMMMUIdxBit_MUserNegPri =3D 1 << 2,
> -    ARMMMUIdxBit_MPrivNegPri =3D 1 << 3,
> -    ARMMMUIdxBit_MSUser =3D 1 << 4,
> -    ARMMMUIdxBit_MSPriv =3D 1 << 5,
> -    ARMMMUIdxBit_MSUserNegPri =3D 1 << 6,
> -    ARMMMUIdxBit_MSPrivNegPri =3D 1 << 7,
> +    TO_CORE_BIT(EL10_0),
> +    TO_CORE_BIT(EL10_1),
> +    TO_CORE_BIT(E2),
> +    TO_CORE_BIT(SE0),
> +    TO_CORE_BIT(SE1),
> +    TO_CORE_BIT(SE3),
> +    TO_CORE_BIT(Stage2),
> +
> +    TO_CORE_BIT(MUser),
> +    TO_CORE_BIT(MPriv),
> +    TO_CORE_BIT(MUserNegPri),
> +    TO_CORE_BIT(MPrivNegPri),
> +    TO_CORE_BIT(MSUser),
> +    TO_CORE_BIT(MSPriv),
> +    TO_CORE_BIT(MSUserNegPri),
> +    TO_CORE_BIT(MSPrivNegPri),
>  } ARMMMUIdxBit;
>=20=20
> +#undef TO_CORE_BIT
> +
>  #define MMU_USER_IDX 0
>=20=20
>  static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)


--=20
Alex Benn=C3=A9e

