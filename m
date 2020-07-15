Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580AEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267AF2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXOGGL/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267AF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlIj-0003DV-DC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvlIA-0002g7-PG; Wed, 15 Jul 2020 13:34:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvlI9-0001Pj-6e; Wed, 15 Jul 2020 13:34:02 -0400
Received: by mail-ot1-x342.google.com with SMTP id 95so2090094otw.10;
 Wed, 15 Jul 2020 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2NqkNZLxR64Hg9kor4X54jVyzWIPr9sqeSVfu8BhQfQ=;
 b=KXOGGL/Pp6SR4KxYMQAjyNrRPtfFddF+PZcMsyVogqPHodFKYQQ/jkULX2Jf6fp1z3
 8+S4XObNAUsOgBqNja20Iu28dItnV1ngrCHIgJNejCQrK6AxLBNoa+ybU+7lg801dtye
 fi6aas2K1Ki0ha8mFW3cX1SwiNxUTaohuvnW+UchUnTworg8Dm3ExV5xlEFBMmv/DRcM
 g0EAF3AIUxlNKYOmA72smWOnCBnlPY1Ls9CE7RQiNQPkhRyliuk+Bj/uTdirMeY4m3FK
 yXj0iXtErngrOLgNfNUY/mXuFnp0Crbz7n6MOJSXRlfi+g87jenOypJivdXrhTbRYX4P
 Rilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2NqkNZLxR64Hg9kor4X54jVyzWIPr9sqeSVfu8BhQfQ=;
 b=AMHcAU6iB/+TxNJSOtpCsCR8I83rn3sjIMsDie9PAAbY1YW8mUi0sFZ+/fQwmwY8NT
 eLqR8P9XX0IRT8ZM2QY/IWnHuYWTxToV/32w2NDE1EZMBD862batSwY/ADVYO18R9otb
 tJaSWfpJQwXs1laSaOs6OrYlMZkJicHeRTXlndOaGQ2tlE14YA6j2VTqQgzvQ1NjR7mG
 GTV7NtqQxjS0URko3ULA0HyUV/WYhz8AKsNH5DvYdQouEnbe/MvMp1TyMdcXPkyAB2fD
 t5kQW+27BZBeWdQZ0G/rzKcaZpIAGG1+RBVu+9FmVwqPAb7yMZcnq+7q+owIkLi2qeRx
 yb0w==
X-Gm-Message-State: AOAM530/1m36mPHM6KbE65g5Zih4a+SOq4Kal1RH/9zkwqpjMZZRM/Gb
 hC5NtrNrvNwx2HTPdLn42/VG/V2etyfGpU3QMKk=
X-Google-Smtp-Source: ABdhPJyx9CmfWmQvyI+dhlbmPS52u7E7UZaJT38G20CDxR4n/LVKbE/7tNUWU4Zt8VyfWPpaNeVmAvJD7vzlaewmpC8=
X-Received: by 2002:a9d:6c54:: with SMTP id g20mr713239otq.120.1594834439422; 
 Wed, 15 Jul 2020 10:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200714203604.5676-1-erik.lucas.smit@gmail.com>
 <be8642a8-7fcd-db96-98e8-4f98bf736992@kaod.org>
In-Reply-To: <be8642a8-7fcd-db96-98e8-4f98bf736992@kaod.org>
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Wed, 15 Jul 2020 19:33:49 +0200
Message-ID: <CA+MHfosxF+K+7LyVnk4g9Sc4PyXtGpURpZu3YQNYpYDwXSL=aA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/aspeed: Add board model for Supermicro X11 BMC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey C=C3=A9dric,

On Wed, 15 Jul 2020 at 15:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> > --
> > checkpatch was complaining about the length of
> > aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc, void *data=
)
>
> in which way ? line too long ?

Yes.

> If so, you can insert a return inside the parameter list.

Ok. Next patch coming up. Thanks for the input.

>
> > so I renamed it to aspeed_machine_smx11_bmc_class_init. Not sure if
> > that's the right way to go, since then it's out of sync with the machin=
e
> > name "supermicrox11-bmc". But renaming the machine name to "smx11-bmc"
> > makes it less descriptive...
>
> You should put the patch comments below the '---'

Thank you.

> > ---
> >  hw/arm/aspeed.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 379f9672a5..e74a89f427 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -57,6 +57,20 @@ struct AspeedMachineState {
> >          SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                     =
  \
> >          SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> >
> > +/* TODO: Find the actual hardware value */
>
> If you can access the BMC console, you can do that from u-boot.

I don't own this hardware anymore. Missing playing with this hardware
is one of the reasons I'm emulating it.

--=20
Best regards,

Erik Smit

