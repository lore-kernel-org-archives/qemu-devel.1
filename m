Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18A32075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YUbTplOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18A32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3q1B-0001ql-M8
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pz1-0000m1-Lt; Thu, 06 Aug 2020 20:11:40 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pyz-0007Pr-QQ; Thu, 06 Aug 2020 20:11:39 -0400
Received: by mail-ed1-x544.google.com with SMTP id l23so22708431edv.11;
 Thu, 06 Aug 2020 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Egw1RCFdj6joX5l5R8CpYFJ3boYu4uDaCD/EFl6gn2M=;
 b=YUbTplOwt6L/TTav+wd5G9F4R/hQclbFG9M6lst1spfSl3lUTmIa+YNoycqU0QNKxT
 TVpvK+Vx2s0V5xeUfbL3Ei/r+Q3LWE9NhqTiVXp2RKPjQX5dg4fPXLSuKq9XwM0smaKg
 LMRSd3UgYFnFUvnIKji10vJ8OIHZ+zQG208CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Egw1RCFdj6joX5l5R8CpYFJ3boYu4uDaCD/EFl6gn2M=;
 b=pjvjaaVJnRnxFhYrNNBZ9krNwSH8wKJnbEn5A2LInD2JHrNiGcHWneNUFUm6xctD46
 751xkjA61k9vngLMBwe4HmC6tRx7koTFPH89dn5nPRJOKeZkPCg6HNGwKRMy8BxGZgom
 r8UQ4+U1Goj4nbVpUeHlGYDJ5ymJK2VMUgUqPioVQUdMbgRZYACN/FySzFpLufZ9flJW
 Z803d8fh8Pcvg2grCiPYgNQEtfAiznIHT2aYJuQrWIGLxLfuAamwZ9oUybd7oJRBTOqw
 0VHDXfI7QkWOqPsKiSFZHWTpb5/2z4Ck61te1Vxf4AongWaZxSGro2BisvKG+yCQVWhm
 qr3Q==
X-Gm-Message-State: AOAM533COiDRWTq23YA22tlx1wY7OF/StFuJXCZo8jnbOfdFf/jyvoSD
 HLNMHxUXsbZkPiRRqQIhUe2wnSqlGfE5TZo/9+M=
X-Google-Smtp-Source: ABdhPJx4JVMVHjfF0/VjAau1bm9XTI1gYq7xXbT/k+lScxXf6djTQvGImSRjG4ct3Beo/MlxkMuYMKusYQAlAjkV/1E=
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr6770722edw.172.1596759095342; 
 Thu, 06 Aug 2020 17:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-19-clg@kaod.org>
In-Reply-To: <20200806132106.747414-19-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Aug 2020 00:11:23 +0000
Message-ID: <CACPK8XfgEgKKdrN4OGv1=pj9wCXbRijL5opxAXnUsBb3m8d=bA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 18/19] aspeed/sdmc: Simplify calculation of RAM
 bits
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Changes in commit 533eb415df2e ("arm/aspeed: actually check RAM size")
> introduced a 'valid_ram_sizes' array which can be used to compute the
> associated bit field value encoding the RAM size. The field is simply
> the index of the array.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/misc/aspeed_sdmc.c | 79 ++++++++++++++-----------------------------
>  1 file changed, 25 insertions(+), 54 deletions(-)
>
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 81c73450ab5d..08f856cbda7e 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -159,57 +159,6 @@ static const MemoryRegionOps aspeed_sdmc_ops =3D {
>      .valid.max_access_size =3D 4,
>  };
>
> -static int ast2400_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 64:
> -        return ASPEED_SDMC_DRAM_64MB;
> -    case 128:
> -        return ASPEED_SDMC_DRAM_128MB;
> -    case 256:
> -        return ASPEED_SDMC_DRAM_256MB;
> -    case 512:
> -        return ASPEED_SDMC_DRAM_512MB;
> -    default:
> -        g_assert_not_reached();
> -        break;
> -    }
> -}
> -
> -static int ast2500_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 128:
> -        return ASPEED_SDMC_AST2500_128MB;
> -    case 256:
> -        return ASPEED_SDMC_AST2500_256MB;
> -    case 512:
> -        return ASPEED_SDMC_AST2500_512MB;
> -    case 1024:
> -        return ASPEED_SDMC_AST2500_1024MB;
> -    default:
> -        g_assert_not_reached();
> -        break;
> -    }
> -}
> -
> -static int ast2600_rambits(AspeedSDMCState *s)
> -{
> -    switch (s->ram_size >> 20) {
> -    case 256:
> -        return ASPEED_SDMC_AST2600_256MB;
> -    case 512:
> -        return ASPEED_SDMC_AST2600_512MB;
> -    case 1024:
> -        return ASPEED_SDMC_AST2600_1024MB;
> -    case 2048:
> -        return ASPEED_SDMC_AST2600_2048MB;
> -    default:
> -        g_assert_not_reached();
> -        break;
> -    }
> -}
> -
>  static void aspeed_sdmc_reset(DeviceState *dev)
>  {
>      AspeedSDMCState *s =3D ASPEED_SDMC(dev);
> @@ -324,10 +273,32 @@ static const TypeInfo aspeed_sdmc_info =3D {
>      .abstract   =3D true,
>  };
>
> +static int aspeed_sdmc_get_ram_bits(AspeedSDMCState *s)
> +{
> +    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
> +    int i;
> +
> +    /*
> +     * The bitfield value encoding the RAM size is the index of the
> +     * possible RAM size array
> +     */
> +    for (i =3D 0; asc->valid_ram_sizes[i]; i++) {
> +        if (s->ram_size =3D=3D asc->valid_ram_sizes[i]) {
> +            return i;
> +        }
> +    }
> +
> +    /*
> +     * Invalid RAM sizes should have been excluded when setting the
> +     * SoC RAM size.
> +     */
> +    g_assert_not_reached();
> +}
> +
>  static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32=
_t data)
>  {
>      uint32_t fixed_conf =3D ASPEED_SDMC_VGA_COMPAT |
> -        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
> +        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
>
>      /* Make sure readonly bits are kept */
>      data &=3D ~ASPEED_SDMC_READONLY_MASK;
> @@ -385,7 +356,7 @@ static uint32_t aspeed_2500_sdmc_compute_conf(AspeedS=
DMCState *s, uint32_t data)
>      uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
>          ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
>          ASPEED_SDMC_CACHE_INITIAL_DONE |
> -        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
> +        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
>
>      /* Make sure readonly bits are kept */
>      data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
> @@ -451,7 +422,7 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedS=
DMCState *s, uint32_t data)
>  {
>      uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(3) |
>          ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> -        ASPEED_SDMC_DRAM_SIZE(ast2600_rambits(s));
> +        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
>
>      /* Make sure readonly bits are kept (use ast2500 mask) */
>      data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
> --
> 2.25.4
>

