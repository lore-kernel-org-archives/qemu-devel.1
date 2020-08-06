Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B0BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59462075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="D3N/ufOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59462075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3pq7-0005Jn-FG
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pfw-0001Ga-N4; Thu, 06 Aug 2020 19:51:56 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pfv-00050q-0J; Thu, 06 Aug 2020 19:51:56 -0400
Received: by mail-ej1-x643.google.com with SMTP id f24so170746ejx.6;
 Thu, 06 Aug 2020 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d+9pBZZwPa0pV77+wNPY0Un0t5VNfMN9t4dWRP7btB0=;
 b=D3N/ufOpiYAQHcaWoKDlV+6OaIu3LAhP3wfT+QMvgxFTwgi3MqUXU7sTXp0Wr5Q2vh
 VwAJfMu7APpMIZAgz9SPKK6l9t/vin6zT9TfMN6c0/YxAjw+Cw7cweFwBpbxpKSn7GD3
 HY09XV1Q+qW61i0sBQL0li3q3dk3l8GC7IPKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d+9pBZZwPa0pV77+wNPY0Un0t5VNfMN9t4dWRP7btB0=;
 b=AylEoxM5dSmX9lz7gyQJJTnFxpQoRSYiuUjQmC52dDqv6SDUfBNcy4RoTflrVUpNYR
 dL2PVFVHcWyDG3zDmNuolgFFvbUDCW1t6IJt19iqktLVx118KLoo6sihHOAS9pez2mLz
 iJ8b6YazkiD9zLC9PIhhsn+sJFfPMx2IhQjEuD/kNYHMvg+QmF+SFlXTyGwxEv8J9OUp
 NCELh0TuQPF1sDcW3ZCMkVrzYkXds8M/d5ni9VM6SQ+LCxxjwWZ8oGVuvdz/eYM1c2ta
 6vMxPj5kQmUe/S3nY8986inu96s4rcAfFN6aPFByXDY2ZF47/ggb9k2CPnNwn9Cs2pkk
 ebkg==
X-Gm-Message-State: AOAM531k7zO2xYu2/9bAxELSJoN94uDKLynMRbCtlX3LcUO3kfwK7lzh
 ngGOseJupGbR0GlgEm4if6yY7Q8SckFsI1zQ5kI=
X-Google-Smtp-Source: ABdhPJyta5YbOnXfQYvOKApR2DT3LfCjEgyRvg+NzIcqRA1gfz+5fYJ0xDr7b1KZ5mmtHv/91OE1Hs5GVkTzFdt8vlM=
X-Received: by 2002:a17:906:4ec3:: with SMTP id
 i3mr6634458ejv.215.1596757913041; 
 Thu, 06 Aug 2020 16:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-14-clg@kaod.org>
In-Reply-To: <20200806132106.747414-14-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:51:41 +0000
Message-ID: <CACPK8XeB=G12CyJNm5Zt7F6NGfq-fX8MgZMOXLgm7yNFHDJBvA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 13/19] ftgmac100: Check for invalid len and
 address before doing a DMA transfer
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
> According to the Aspeed specs, no interrupts are raised in that case
> but a "Tx-packets lost" status seems like a good modeling choice for
> all implementations. It is covered by the Linux kernel.
>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/net/ftgmac100.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 014980d30aca..280aa3d3a1e2 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -507,6 +507,15 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint3=
2_t tx_ring,
>          }
>
>          len =3D FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
> +        if (!len) {
> +            /*
> +             * 0 is an invalid size, however the HW does not raise any
> +             * interrupt. Flag an error because the guest is buggy.
> +             */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid segment size\n",
> +                          __func__);
> +        }
> +
>          if (frame_size + len > sizeof(s->frame)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes=
\n",
>                            __func__, len);
> --
> 2.25.4
>

