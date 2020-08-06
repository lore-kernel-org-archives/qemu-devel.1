Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90196C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880ED2075D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DMZE+cVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880ED2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ped-0008VL-FN
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pbk-0007Xi-KL; Thu, 06 Aug 2020 19:47:36 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pbj-0004dM-2G; Thu, 06 Aug 2020 19:47:36 -0400
Received: by mail-ed1-x542.google.com with SMTP id m20so26908659eds.2;
 Thu, 06 Aug 2020 16:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MqG69mo06b8/njU6u2OaiwDXzJPGk81pA8dJpDSpz+A=;
 b=DMZE+cVgEtdMnT8UC9GCIuGNRcUIy+26FpxBWq9kkj3i4VbbVKw/g4dYWldZqwTFLL
 y6xFnkiMlhYWnZp+5d1UVBQ8cWiQ+asmlQI33PsdDn9+02380oVgWdjtE3De1W09X5zn
 qyBrSaOPa7AhjCjmj3/0ZyIlvzJ3bRskDoMFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MqG69mo06b8/njU6u2OaiwDXzJPGk81pA8dJpDSpz+A=;
 b=QO8UyTz5cuP93+Px283IoG2CEhrCuujlX/DIBtoD3ohsyLcrVR5m/pIka0BNEBr+w5
 F2DDsTGDJ/Qu7MMrSdgyWQ1gWPUhAWsDI0GkuSjFV+Yw4CqQewddHhcvtSBwLltCHBwa
 D2ZwpjjnCZscComaT2DC8pWUSpYw7laLqbzLKKM9PsFV6BjxVISJ8n3VHCSbe6c67kaR
 JsP7EytlkulBrH3jn2jD+TKyH0iXhL0qT6lERbG/C2fBUZUsmrb9+6PhcgpkDU4hgtcE
 0yeFJekI2Q4gKUAbX3aKRvZ6cUYKJpAzl5oCLyFWHJlGwlDFQEeY8HVbQgE7Z7cf4o09
 1H5w==
X-Gm-Message-State: AOAM531advqPsVMGqx0g2+vgiYrSkRG5eNkBzQw7Cq86de9NkuOAjS4R
 Z8SDZjn2l9zhqiElMIeUh2GFG1KD1xt3p6Dq5vXtbN/4
X-Google-Smtp-Source: ABdhPJwBHqdrWyQlP/hGGtmER5qjIg/QIEbKsZ3632inWrJoVwmYOkqIma+8R1FBLSU3aPnx2/ZwscnRWrRXhQclWHs=
X-Received: by 2002:aa7:d304:: with SMTP id p4mr6072060edq.267.1596757653188; 
 Thu, 06 Aug 2020 16:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-11-clg@kaod.org>
In-Reply-To: <20200806132106.747414-11-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:47:21 +0000
Message-ID: <CACPK8XdWztzwTfqX5Mkk8wbdrL13nfhw_pTw0R6ra06cOXenBA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 10/19] ftgmac100: Fix interrupt status "Packet
 transmitted on ethernet"
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x542.google.com
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
> The second field of the TX descriptor has a set of flags to choose
> when the transmit interrupt is raised : after the packet has been sent
> on the ethernet or after it has been moved into the TX FIFO. But we
> don't model that today.

Does any software depend on this behaviour? Perhaps mention it in the
commit message so we remember why we changed it.

>
> Simply raise the "Packet transmitted on ethernet" the interrupt status
> bit as soon as the packet is sent by QEMU.

delete the second 'the'?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/ftgmac100.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 0348fcf45676..aa3c05ef9882 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -547,9 +547,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32=
_t tx_ring,
>              qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_siz=
e);
>              ptr =3D s->frame;
>              frame_size =3D 0;
> -            if (flags & FTGMAC100_TXDES1_TXIC) {
> -                s->isr |=3D FTGMAC100_INT_XPKT_ETH;
> -            }
> +            s->isr |=3D FTGMAC100_INT_XPKT_ETH;
>          }
>
>          if (flags & FTGMAC100_TXDES1_TX2FIC) {
> --
> 2.25.4
>

