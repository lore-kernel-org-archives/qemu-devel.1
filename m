Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025D820748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="XKMR4sb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025D820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3opk-000679-10
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 18:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3onT-0004fd-OD; Thu, 06 Aug 2020 18:55:39 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3onR-0007WR-8o; Thu, 06 Aug 2020 18:55:39 -0400
Received: by mail-ej1-x642.google.com with SMTP id o23so83072ejr.1;
 Thu, 06 Aug 2020 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7Kv3tbuiDOZTDYkzw3VcpO73XHlPN/u3caV0G6GNCJQ=;
 b=XKMR4sb2pzeZuvD0YRbHJ7lYjBiw8qOk5ZXDl9VCrTnDQuY8ZjhvWV5ebCCQKM2RGs
 PXoi8SScqkKLvJZCdv3hKUkEbBUfENyhJJxWZyt34ZnDQoJTOQMz3txOyGm1zxnsogUR
 IRuUKDGrBVnnNpsl/v+N8jQauVhDHiw+nOE/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7Kv3tbuiDOZTDYkzw3VcpO73XHlPN/u3caV0G6GNCJQ=;
 b=uZ7acwfiwDpmlctnc5BVWErUz5ZSXBit4z53h7pH/Ywh63cKkqjCqylpZrQE4tfcbS
 C8n/4XofBQJ/ZZg6HtrSroQjUEjt46EN67RTPB1JMvunssnjDesKIV27VxOiyEGOMm34
 701f9h5zI9gkx84qAaiJZe4Y8C/WTDH3M1teK+A8MtgRcaPpUNrtxc85ngGp5Fseh7RD
 6OHIXdcwqDBaSpreZ9qOJblrJ48ejvdUJufcd5eJqDQi3icuqGUpzWo3EnWdWWn3uCR3
 txFtb9gj7mhEFnFgq0N3ArehKa4z04vTmPfij26hjTrAVWaklJPc5NXXGvYKqNcLqxeX
 J2/g==
X-Gm-Message-State: AOAM530Qd7xjXSG48Y6c9wMnj7iVTtc3/+1FbZOshZkdDSDccHJlnPJ9
 aYoiJfZYihW/aOO8ufWNa6x5k2lxerH7SwuHsZQ=
X-Google-Smtp-Source: ABdhPJxYjIUkSlmKi7VD7m09X0VgbEfRc9CHFNOCsc36UnPHM4EnKm/XZzQUagGgN31G7cTRRzUtWek3YOpTq7Qip+E=
X-Received: by 2002:a17:906:c143:: with SMTP id
 dp3mr6504715ejc.504.1596754534905; 
 Thu, 06 Aug 2020 15:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-3-clg@kaod.org>
In-Reply-To: <20200806132106.747414-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 22:55:22 +0000
Message-ID: <CACPK8XddhjsdTF2tiiuFoDZ9L+LqOSJLydE-YUAqkbGs4OvquA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 02/19] m25p80: Add support for mx25l25635f
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The mx25l25635f is an extenstion of the mx25l25635e. It includes QPI
> support, 4-Byte Address Command Set and faster transfers. See this
> document for more details :
>
> https://www.macronix.com/Lists/ApplicationNote/Attachments/1892/AN0200V1_=
MGRT_MX25L25635E_25735E%20to%20MX25L25635F_25735F.pdf
>
> Both devices have the same 3bytes JEDEC ID: 0xc22019. They can be
> distinguished with the QPIID command which is only available on
> mx25l25635f. The mx25l25635f also has a longer JEDEC ID that we can
> use for the model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

We don't have support for this one in upstream Linux. It's the one
that Alexander tried to get merged by renaming the mysterious
mx66l51235l.


> ---
>  hw/block/m25p80.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 605ff55c6756..1696ab1f7821 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -218,6 +218,7 @@ static const FlashPartInfo known_devices[] =3D {
>      { INFO("mx25l12805d", 0xc22018,      0,  64 << 10, 256, 0) },
>      { INFO("mx25l12855e", 0xc22618,      0,  64 << 10, 256, 0) },
>      { INFO6("mx25l25635e", 0xc22019,     0xc22019,  64 << 10, 512, 0) },
> +    { INFO("mx25l25635f", 0xc22019,      0xc200,  64 << 10, 512, 0) },
>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_=
32K) },
>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_=
32K) },
> --
> 2.25.4
>

