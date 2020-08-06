Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B738C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0257E2075A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NcTIUuR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0257E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3pKu-0000uP-WB
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pFX-0007OO-5b; Thu, 06 Aug 2020 19:24:39 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pFV-0001zx-Oe; Thu, 06 Aug 2020 19:24:38 -0400
Received: by mail-ej1-x642.google.com with SMTP id d6so124260ejr.5;
 Thu, 06 Aug 2020 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dfzZw2rK2VM8hG7Azfy7HADF2kDjdHPtkiMjK8eRub8=;
 b=NcTIUuR3UR8l8CqksIHI1vGWmbSPFrtUYWhlOy0oK6t039CbgxSSvvT9Kw+J3FAAoh
 hP+TrIB8R40o4h4EifBteOqcfxwdWcwO1jAtrZcSQJ4NRc7HFlKTrfRo9MN5nPG0Rz9a
 k17Cl1G3gkc57HavhKQWl+ZyFF+mdik7KgnRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dfzZw2rK2VM8hG7Azfy7HADF2kDjdHPtkiMjK8eRub8=;
 b=TC4KfCMO5wP92Jj6QBQwXeMSLs/oJcp7rnmz5P4+3aEEpKIG8QhKOWn5LhSJcii087
 Ld6IB3NPRduMX5SSlpV3uRjImu40AIC19MPz5LySr7xc64H/VAV1unqCIKmh0LAYsqLQ
 DIs+49xkYO+jAECFXqyL2YjfDwq+G0m+4JqYOWaW4pmWx6GJaa0JisMNquMqLu3zV81W
 d+MmEhdkSECb2ox68EB2XrIQagVFw1tyqufd7kMmYKI/ifkHL4y4BnXdIc0X7DZu2XW3
 yNf3q69yRszljyeMonvoulLQE5WHySfvS5B51m4nVAHKLvQba3DglfT7DzEZKnJWvqix
 qSeA==
X-Gm-Message-State: AOAM5334wJKcRl85it/K6bpKYiMKXe3Jy92fdYwDy8FYYT93N/GwNh7m
 rKT69KGqVThSC6K0/GB+kITK9HJs79t46RgXaoM=
X-Google-Smtp-Source: ABdhPJz6yCJqYKQrxuFmD9rE6KoaCGSBfLZNc9If7JUMNd6NGXhXJBOkqeR9zX4DxLvre78fs8M0TG8c+vYSYZWwSI4=
X-Received: by 2002:a17:906:c187:: with SMTP id
 g7mr6961093ejz.108.1596756275722; 
 Thu, 06 Aug 2020 16:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-7-clg@kaod.org>
In-Reply-To: <20200806132106.747414-7-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:24:23 +0000
Message-ID: <CACPK8XfJ=D1N09jFeF3=FJ1t=DuHqHNE4DUYrL=OVDPkKx=4kg@mail.gmail.com>
Subject: Re: [PATCH for-5.2 06/19] aspeed/smc: Fix MemoryRegionOps definition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x642.google.com
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:23, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Unaligned access support is a leftover from the initial commit. There
> is no such need on this device register mapping. Remove it.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/ssi/aspeed_smc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 4fab1f5f855e..0646e0dca72e 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -1299,10 +1299,8 @@ static const MemoryRegionOps aspeed_smc_ops =3D {
>      .read =3D aspeed_smc_read,
>      .write =3D aspeed_smc_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
> -    .valid.unaligned =3D true,
>  };
>
> -
>  /*
>   * Initialize the custom address spaces for DMAs
>   */
> --
> 2.25.4
>

