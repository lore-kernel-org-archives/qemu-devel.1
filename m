Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1692C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9FB204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kNCjceR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9FB204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3plP-0003SU-Bs
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pfJ-0000pT-LN; Thu, 06 Aug 2020 19:51:17 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pfI-0004xo-6u; Thu, 06 Aug 2020 19:51:17 -0400
Received: by mail-ej1-x643.google.com with SMTP id l4so139758ejd.13;
 Thu, 06 Aug 2020 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yhkYD6jNFI1oia6iMO0Anl2+YSRaapDxeQ9aaFom5pk=;
 b=kNCjceR6EPcGdSpwr2fvgeuwaRGK9efwwUYSiD8oyvl9Fwfly+jB9YXFL/4ndSpxgI
 iVdF7A4giFCF2bYDp/EGkIzLbOy0wr4+ZSdlJ0KiBuanE6facd1VWo3NW0gKx6MW25j+
 GGs3huX9/GsYEnZC24oxTo+GxjoJUwIfXFPVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yhkYD6jNFI1oia6iMO0Anl2+YSRaapDxeQ9aaFom5pk=;
 b=Az8qstLUS4Lk1UYbjKqX7CXo4hVViJrDezmWswJf4nFOB+fKzqaU3fYpl+sc29XgDy
 jMcik0pnR3FGirtoW96tyxtNI5l8Vov3X67HSxNpPG8BHd8G6GpAAejmAkz1Utn+KMfM
 axJbdz4XJLk6I5mcBVubvJROxOBHtSOmwO7/SLe6Du58RQkUzgBp6EbfZOPOj9Bo0CfD
 y71RZ/QojTsCeyYiDlVTPnPhT+Y2nPkQlmQKJzug6jVyfPth5oKAMLd5mD9w9CQdWpPA
 5SBXGlxexqM19HgxYR1I6lQbQtC2lPdOO9+wybD6jyX7GMcxhgyceX8v91wob5G/LEM+
 LhIQ==
X-Gm-Message-State: AOAM532WDZNW0TPXOwK/TP1tjeSJbol57x+qSUaw2x1P8tDeiQWNbMTy
 BNG41TT6UhLvczaLG1syCsKi/kCelNjdeWibulQ=
X-Google-Smtp-Source: ABdhPJysMJNLcVeZcpkXVXF8lZb9PyA/7hYyTSboyecdk1XxiWC1uoEhFnEIcQqLw5XUe2pGSgE98Fjx0TlN6x0+JzM=
X-Received: by 2002:a17:906:c187:: with SMTP id
 g7mr7047421ejz.108.1596757873675; 
 Thu, 06 Aug 2020 16:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-13-clg@kaod.org>
In-Reply-To: <20200806132106.747414-13-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:51:01 +0000
Message-ID: <CACPK8XdUOhLVDxjBJoAZmOxGafsHhajyhb1jXiVvY8BqqTxNQw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 12/19] ftgmac100: Change interrupt status when a
 DMA error occurs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x643.google.com
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
 Frederic Konrad <konrad.frederic@yahoo.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The model uses today the "No transmit buffer unavailable" interrupt
> status which it is not appropriate. According to the Aspeed specs, no
> interrupts are raised in that case. An "AHB error" status seems like a
> better modeling choice for all implementations since it is covered by
> the Linux kernel.

The datasheet calls it this:

 NPTXBUF UNAVA: Normal priority transmit buffer unavailable

Perhaps we should say this:

The model uses today the "Normal priority transmit buffer unavailable"
interrupt status which is not appropriate.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/ftgmac100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 5c0fe2d8cb75..014980d30aca 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -517,7 +517,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32=
_t tx_ring,
>          if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ =
0x%x\n",
>                            __func__, bd.des3);
> -            s->isr |=3D FTGMAC100_INT_NO_NPTXBUF;
> +            s->isr |=3D FTGMAC100_INT_AHB_ERR;
>              break;
>          }
>
> --
> 2.25.4
>

