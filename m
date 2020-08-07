Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C187C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C372075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="K6jhK8Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C372075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3q0c-0001M5-HL
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pyF-0000Lm-E7; Thu, 06 Aug 2020 20:10:51 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pyD-0007F8-2M; Thu, 06 Aug 2020 20:10:51 -0400
Received: by mail-ej1-x641.google.com with SMTP id a26so224870ejc.2;
 Thu, 06 Aug 2020 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=njCC5Drn2l8IGdXb+z4b87FsoJXkq2Mrguft79UZRiU=;
 b=K6jhK8AkGA6uG+ZNW/n8G2fKCaYyYzifSsgHOqolyBt1wroTZ1AP3XkD7wlwEcvXaI
 h2iVKmHo5M/VZlhP982VM0oFPRThSG0ZaawnqWMKcwzCln3SBNqnZ3PAGmxiwmtODbDp
 8QwHgS/NyxopZNc6pJLLtXFmT092IRm5yWIqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=njCC5Drn2l8IGdXb+z4b87FsoJXkq2Mrguft79UZRiU=;
 b=eKWX+VcW4omhrzbckAiv+P7PHtdwWwFOnuOl0lyFMFRdFFicQ59qipbF2e7jNdxqiC
 hoNGdb52rxfF/vyjdLc1BARpUPsJI4jPhPQmIjTCU2v8TbddZosYQpEGGa2wW4pwGV3A
 vTfB+4dd1qKPpiqaG/VjghIA3/aeN/jeatMW3EOPbaI7IxKQ6XrPsQst+Mb5kGv17kJc
 yecdl36ggKw3SGok1fz3EKTEUCnBQdnGJrL8geiHwJ6Y+Ff87muIzkzyY5NhkCfsFl58
 ncely8P9G0rs+GabkahbUU4JfldYsYPsXcYD+m36wy1itNK43d0UWyIq39NBcy6whO4d
 Of+Q==
X-Gm-Message-State: AOAM531vjf69OZvOztPC7YpDqkX+5bQxr4gaFxNhrTl+2KCafFUevXzz
 X40Pvs+V5hfeDULgBU2x4LzpelgqT8L5MpWOhzo=
X-Google-Smtp-Source: ABdhPJygkxHPN5OWn63IFzuILL0q5HLWyKRaiBLDNFZwg9CiV3B/mT9u445jTQgdi7VAPclk7m2zCxtqQJDnCeq4AeI=
X-Received: by 2002:a17:906:1ed3:: with SMTP id
 m19mr6589017ejj.396.1596759046797; 
 Thu, 06 Aug 2020 17:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-17-clg@kaod.org>
 <56f83c0b-b5eb-241e-c848-56f038633398@amsat.org>
In-Reply-To: <56f83c0b-b5eb-241e-c848-56f038633398@amsat.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Aug 2020 00:10:34 +0000
Message-ID: <CACPK8XcN0Oq-4uKjxUg=DR6KZSkYqs+AFnM=SFoxwWiB9rXktw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 16/19] aspeed/sdmc: Perform memory training
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x641.google.com
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
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

> > @@ -206,6 +206,19 @@ static void aspeed_sdmc_reset(DeviceState *dev)
> >
> >      /* Set ram size bit and defaults values */
> >      s->regs[R_CONF] =3D asc->compute_conf(s, 0);
> > +
> > +    /*
> > +     * PHY status:
> > +     *  - set phy status ok (set bit 1)
> > +     *  - initial PVT calibration ok (clear bit 3)
> > +     *  - runtime calibration ok (clear bit 5)
> > +     */
> > +    s->regs[0x100] =3D BIT(1);
>
> This is usually implemented with a one-shot timer, see
> sd_ocr_powerup() in hw/sd/sd.c (migration is handled).

You mean we could have the calibration done bits become set at a later time=
?

It would be hard to work out what to do. We have no documentation for
the register, I modelled it based on the code in u-boot doing this:

         /* make sure DDR-PHY is ready before access */
        do {
                reg =3D readl(priv->phy_status) & BIT(1);
        } while(reg =3D=3D 0);

So I think there would be limited value in modelling it.

Thanks for the suggestion though, I'll keep the one shot timer idea in
mind for future models.

Cheers,

Joel

