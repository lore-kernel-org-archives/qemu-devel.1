Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3F620748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mFedqXKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3F620748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3orL-0007BT-4T
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 18:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3op7-00062H-FL; Thu, 06 Aug 2020 18:57:21 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3op5-0007iO-VM; Thu, 06 Aug 2020 18:57:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id a26so80594ejc.2;
 Thu, 06 Aug 2020 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X+IxDrTb6WKRXsCWuzJFD3rPRYDnU0xSRi/GSEo8MoA=;
 b=mFedqXKUmOHwRIYhMtDBCVnB8CaJM2tMYiAlaGRdTPB5Ak6v/c3CdZVtQ8YqD2qu+L
 Ld6hupFm3t7zuJ96ZktIZ9Mr1BiqxMWuFxgrBmWqPw7N/kqecp1xNoewtwzixu5Y5jJg
 ahRZ45EZK8We1hdxD62AgrbkNAyKqX2cDl/go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X+IxDrTb6WKRXsCWuzJFD3rPRYDnU0xSRi/GSEo8MoA=;
 b=IqagjM5xDIjrL3wQwLQAd4v8wYVjfNTBNnmlliOEd++9Bi9G8WYQMPxB+EvA4tt69X
 m+oz5hHv8EmPfxcIOSJ0bno1gz9l/CMZZim1xD1Qgz3fDxEpWQxydTt+LIz+EdYjfSPM
 dCnQzbCu3hjuhiChH/bM+rboaO8n5YWGa8sHpJi36b48LmdftQBVBS7DtRQEgOJfVA1U
 XvsqtVd9FPbrIjT7gwVUNecNLETEDzKn8OCXTmefi7VzjDMcSx1xF0VGzaeZrcLgL+fd
 kjWDvsvA4i54j4yv2cDjF1/lvqzWxL5MXg9bulDYqg8Om/bxhwxknlaYsjWBzB26mRv9
 mczw==
X-Gm-Message-State: AOAM530+FPJySjGUxYMV+IuRkFmvwam/tLdy1M51iUYx/msRDPdMCOR5
 PaPyyV4J6qdp+QXrMJrc13lB7DK073J8agHNKtcT0QyzbUU=
X-Google-Smtp-Source: ABdhPJynF3ombZ79DhQ8/Mj2povDNr1LJlFpigjOD9zvZ3fnliCrnWUjRfPlRP1M3SlqaM9g1XXVwZzrqDAdHkXisrI=
X-Received: by 2002:a17:906:1ed3:: with SMTP id
 m19mr6350906ejj.396.1596754637999; 
 Thu, 06 Aug 2020 15:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-5-clg@kaod.org>
In-Reply-To: <20200806132106.747414-5-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 22:57:05 +0000
Message-ID: <CACPK8XeWDDL0L=FKho+aXe4cx1CLB2BSq-=ERGBc1X6L76ZryQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 04/19] aspeed/scu: Fix valid access size on AST2400
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
 erik-smit <erik.lucas.smit@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The read access size of the SCU registers can be 1/2/4 bytes and write
> is 4 bytes. Set the min access size to 1 byte to cover both read and
> write operations on the AST2400 but keep the min access size of the
> other SoCs to 4 bytes as this is an unusual access size.
>
> This fixes support for some old firmware doing 2 bytes reads on the
> AST2400 SoC.
>
> Reported-by: erik-smit <erik.lucas.smit@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/misc/aspeed_scu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index ec4fef900e27..764222404bef 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -328,9 +328,10 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops =
=3D {
>      .read =3D aspeed_scu_read,
>      .write =3D aspeed_ast2400_scu_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
> -    .valid.min_access_size =3D 4,
> -    .valid.max_access_size =3D 4,
> -    .valid.unaligned =3D false,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  static const MemoryRegionOps aspeed_ast2500_scu_ops =3D {
> --
> 2.25.4
>

