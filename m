Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4856BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1336420738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRE4r8de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoW0-0007Oz-Bs
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgoV6-0006Tq-PD
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:57:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgoV5-0007L6-Og
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:57:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id c3so5750191wru.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wjoAoIl6WWwYcykC7dKNo1Is6E6zTiEz5Nys5MU3gp0=;
 b=ZRE4r8deysKucWDJMM+M8HlElJW65ietmNaT87BV2VF9DkegFFmS3yVu/BPKiJrZHv
 xtk60i7c6+9ibYbSXZi8hhxRiVbWxEqc/0fMdJWzAfNETqgkQYtCdNC8T6A97OocOR47
 3bDO2g3QKymyxg7PHoYzAkQA25ANP9AF0zQBm5600i73JTy6aQk48QDgDAy546Ro/oxn
 oUMPwmElUHgSBWTYFJqxfxLj8Jvf91uG3nfNsKgbPCgzF7vf28TeWTi3N4wEbSnSbPkb
 5zAZ0oBJ+qDdnaStPDjDiTSFzcq+g/iCPqZNmrzW7vhVRWQeuLmePCcKmHKUeHF6z7TQ
 nDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wjoAoIl6WWwYcykC7dKNo1Is6E6zTiEz5Nys5MU3gp0=;
 b=p68Qb917keJHJLK4Kg5yrTvB9Qpi7+VZ7kGqKimNEFajoXRenIepY0b/PZHo+QogDo
 V+zdolxwmCczgJoDVI1jjz3CF/8jZQ0X/u/FdnoEBpYiDbps9ZElAWPkReG84EAVatqy
 KSqflZAo5EaLyqqMwKqK6ido47333qtF5h4K+pqOAtzO1Bc69T23c3aEMfYhq0Vp5UTy
 zl+Q+cAgh8iIZckgVSlEsvBPJQcTqMUkdY7Xj8RQkhjCvUyXCcmgmjokvaYAqrlm9Htc
 uvRADFhdzgumPW+U+QLWEID+jOhooLxid9Js52Jieprsioou5p9hqRGc+SVoL1YsD26X
 EvSA==
X-Gm-Message-State: AOAM533dWWQ+lrpoHRt2QTA5vAQBW3TKZeD+KLFMmMB+UsnhRBN5oEcl
 r+I6GToKq9BoQemyuVpD8XmV+A1+nuBiX/vlH4sC0NPF
X-Google-Smtp-Source: ABdhPJy0/xI6bCLm27GQKwA780txZNTZ65LlHbVRyMR0C+UJ4IjfMAMfLpiV+gQGNyrWUggqClHwHeDcnRKg9/wISpg=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr4047748wrn.402.1591271853986; 
 Thu, 04 Jun 2020 04:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
In-Reply-To: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 4 Jun 2020 13:57:22 +0200
Message-ID: <CAHiYmc5Rz542mz2Cg6Qgpq07pLBOVCJqKKuHzQFBU-Tqd6ZBVQ@mail.gmail.com>
Subject: Re: target/mips: Enable Hardware page table walker and CMGCR features
 for P5600
To: oliveriandrea@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=83=D0=B1, 25. =D0=B0=D0=BF=D1=80 2020. =D1=83 20:20 <oliveriandre=
a@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:
>
> Hi,
> I have discovered that MIPS hardware page table walker is not enabled
> for any CPU currently available. In this patch I have enable it (and
> also CMGCR feature) for P5600 which supports both but they are not
> enabled.
>
> This is my first patch to QEMU, I hope it is well formatted and correct.
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Will be applied to the next mips queue.

Sorry for waiting for so long.

Welcome to QEMU development, and please send more contributions!

Aleksandar

> Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
> index 6d145a905a..482cfe2123 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -366,7 +366,7 @@ const mips_def_t mips_defs[] =3D
>      },
>      {
>          /* FIXME:
> -         * Config3: CMGCR, PW, VZ, CTXTC, CDMM, TL
> +         * Config3: VZ, CTXTC, CDMM, TL
>           * Config4: MMUExtDef
>           * Config5: MRP
>           * FIR(FCR0): Has2008
> @@ -380,10 +380,11 @@ const mips_def_t mips_defs[] =3D
>                         (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_D=
A) |
>                         (1 << CP0C1_PC) | (1 << CP0C1_FP),
>          .CP0_Config2 =3D MIPS_CONFIG2,
> -        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MS=
AP) |
> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) |
> +                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
>                         (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_S=
C) |
> -                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) | (1 << CP0C=
3_LPA) |
> -                       (1 << CP0C3_VInt),
> +                       (1 << CP0C3_PW) | (1 << CP0C3_ULRI) | (1 << CP0C3=
_RXI) |
> +                       (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
>          .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE=
) |
>                         (0x1c << CP0C4_KScrExist),
>          .CP0_Config4_rw_bitmask =3D 0,
>

