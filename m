Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837372075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="X0K1p8U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837372075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ptP-0006sX-GT
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pqw-0005vu-Hv; Thu, 06 Aug 2020 20:03:18 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pqv-0006K9-1Z; Thu, 06 Aug 2020 20:03:18 -0400
Received: by mail-ed1-x541.google.com with SMTP id v22so8051edy.0;
 Thu, 06 Aug 2020 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=36skZ/Fqp0hzGFyizluyH7sOhrXB27+uSzT8RYATHZw=;
 b=X0K1p8U+6sh6cvpVPLBNTUR1452pTRNBgAYBrrsZMjs0xW5RsJaaRzJB383cTH+R2L
 RBd8aSZsWS6f/67hrDibWwsJ82UtBB49lD45iS+MI2PWfU7ifTJ922CzeNmcw8VrXneA
 VOMrjmkZVxejA0uOGPLtyMJcGT/caO2pSgWmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=36skZ/Fqp0hzGFyizluyH7sOhrXB27+uSzT8RYATHZw=;
 b=QRBOv8coP8NAk2UswR5WpUrO7uBuCuvskcMlGtimXq52d/HU3LeZhwsBpbxldA7yOi
 7D0/taqbSTGgf8ILXu4vMYC3jzegFIqxmaB4dmcfUxbngi6V8juDU38V8AdStfs00au7
 x6HziwBGXtmfZjOpIWgR3XUxo219Dv2LLsI/MPHLk6bxxsqs+6j9Wa+gd0R/+7dRa2wU
 xN4rooLwa3bFeAhNfFb3roFBFrFYe/7M6kQFso6m4u8ORiy60pIpTw30NU/PBpcWjCiO
 C+cLsXBT4WAVaYm+i3Z8YKIplUlou0/WiTXu+JdfUoxT/3iOlXD/m7aYP5ub+D91jEt1
 o87A==
X-Gm-Message-State: AOAM530WksHpkOtqDuFaO6JCqRNnZT9kIkkU0hDcfMqoF1AmpOv04lz7
 pLNRSQ1WYLhn/N3zslWv2dml6v7JJ1+yBPLSuss=
X-Google-Smtp-Source: ABdhPJwBJ+rUhp17CDFpcMD16KhB6mQPiVzL1gXprgmRq4MOCyvHbBBFeXPuSEq6CzoWnRW/OcVVFsZR4bG9bsc81f0=
X-Received: by 2002:aa7:c406:: with SMTP id j6mr6310927edq.143.1596758594814; 
 Thu, 06 Aug 2020 17:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-16-clg@kaod.org>
In-Reply-To: <20200806132106.747414-16-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Aug 2020 00:03:02 +0000
Message-ID: <CACPK8XdW0nysvS99Su7edNN7vzxwvYgZJRQ=VGV073UEik3YGQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 15/19] ftgmac100: Improve software reset
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x541.google.com
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
> The software reset of the MAC needs a finer granularity. Not all
> registers are reseted and some setting in MACCR are kept.

'settings'

This makes the software reset incorrect, but the power on reset values
correct. Was that your goal?

If so, perhaps put that in the commit message.

>
> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
> Fixes: bd44300d1afc ("net: add FTGMAC100 support")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/ftgmac100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 987b843fabc4..0740049c5268 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -655,11 +655,10 @@ static void ftgmac100_reset(DeviceState *d)
>      s->itc =3D 0;
>      s->aptcr =3D 1;
>      s->dblac =3D 0x00022f00;
> -    s->revr =3D 0;
>      s->fear1 =3D 0;
>      s->tpafcr =3D 0xf1;
>
> -    s->maccr =3D 0;
> +    s->maccr &=3D FTGMAC100_MACCR_GIGA_MODE | FTGMAC100_MACCR_FAST_MODE;
>      s->phycr =3D 0;
>      s->phydata =3D 0;
>      s->fcr =3D 0x400;
> @@ -812,6 +811,7 @@ static void ftgmac100_write(void *opaque, hwaddr addr=
,
>      case FTGMAC100_MACCR: /* MAC Device control */
>          s->maccr =3D value;
>          if (value & FTGMAC100_MACCR_SW_RST) {
> +            /* TODO: rework software reset to have a finer granularity *=
/
>              ftgmac100_reset(DEVICE(s));
>          }
>
> --
> 2.25.4
>

