Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6847D2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="lvLNfHNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847D2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaqLf-0006qW-F9
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 20:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jaqHj-00058G-US; Mon, 18 May 2020 20:39:07 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jaqHh-0004Lh-NR; Mon, 18 May 2020 20:39:07 -0400
Received: by mail-ej1-x643.google.com with SMTP id x1so10341810ejd.8;
 Mon, 18 May 2020 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XHr1u4Up0QpG/c/A3SDWCSoQmzZzYbzXevGQqA1OMKo=;
 b=lvLNfHNKiG8o0SqLjl2nCcZzw9vBV4OE+lBoxXHzK+MozzrdbUUCn2of2X8BJrR+KZ
 5FEDgw36ldHQ/jtvF8FR2943+7l0EV/OARDlnPzJpti3x+tLtLh4wKUnF8d5dFMcmCfS
 34jSvxo17Y9AgjuBPgHSbaK0ocLQz5AJTiYuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XHr1u4Up0QpG/c/A3SDWCSoQmzZzYbzXevGQqA1OMKo=;
 b=QOY68aEe7pvIyZulGCmf1tOyzJ3Urao8I7VsSFmY7h66JXMnWB3SzM17wClwfUAnVQ
 8h3+Pz+ivviXSGiVqZpvkMtNF7aeb36xyYcmxjFu4rRvNJQM1G8ENYt5ioigV469BrBd
 AyNBTBoXKQlKo6v2PEw/yhYyOER1Tckldh90XE4rfDod9Y3L/aThBtr41vN+9KhBRAtv
 /KC1XCCwzRMv7SZiZVBdN6C+jG2aWNcmlT//hI8I43+sUSYyGKF9zD9WM44sB5hFP6Id
 sSiwnS/eFOFwiHB7ocpH4/YP0Jrvxr5hL6wiMwveCaPX/R/XQTvKARJCiothG23O5TV+
 Pv3w==
X-Gm-Message-State: AOAM532Rk9wtZTVqRSmHUTP1XWdarCRVBBtpg6Re9MhSUoh6S3o4zEKJ
 4f6+fdcHJtZ8lUz0c8G8l/r/jH3NAE7SqfMxAxs=
X-Google-Smtp-Source: ABdhPJwZChou1Bb5wOYcg8osKciwiWRWy8ZwA3j9RL67LklW2PsHGvu/TQ+glnPn7MeJrKoppZ9X7CplNDRfOakcIKw=
X-Received: by 2002:a17:906:1f87:: with SMTP id
 t7mr13935251ejr.50.1589848743574; 
 Mon, 18 May 2020 17:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
 <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
In-Reply-To: <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 19 May 2020 00:38:51 +0000
Message-ID: <CACPK8XcxVrA3E-c=jkszXd2Z6PMLO=tWDF60DTu-E3cyUdXD2A@mail.gmail.com>
Subject: Re: [PATCH 04/24] aspeed: Don't create unwanted "ftgmac100",
 "aspeed-mmi" devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 12:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 5/18/20 7:03 AM, Markus Armbruster wrote:
> > These devices are optional, and controlled by @nb_nics.
> > aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
> > supported number.  aspeed_soc_ast2600_realize() and
> > aspeed_soc_realize() realize only the wanted number.  Works, although
> > it can leave unrealized devices hanging around in the QOM composition
> > tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
> > romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
> >
> > Make the init functions create only the wanted ones.  Visible in "info
> > qom-tree"; here's the change for ast2600-evb:
> >
> >      /machine (ast2600-evb-machine)
> >        [...]
> >        /soc (ast2600-a1)
> >          [...]
> >          /ftgmac100[0] (ftgmac100)
> >            /ftgmac100[0] (qemu:memory-region)
> >     -    /ftgmac100[1] (ftgmac100)
> >     -    /ftgmac100[2] (ftgmac100)
> >     -    /ftgmac100[3] (ftgmac100)
> >          /gpio (aspeed.gpio-ast2600)
> >          [...]
> >          /mii[0] (aspeed-mmi)
> >            /aspeed-mmi[0] (qemu:memory-region)
> >     -    /mii[1] (aspeed-mmi)
> >     -    /mii[2] (aspeed-mmi)
> >     -    /mii[3] (aspeed-mmi)
> >          /rtc (aspeed.rtc)
> >
> > I'm not sure creating @nb_nics devices makes sense.  How many does the
> > physical chip provide?
>
> The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machine
> define the one it uses, generally MAC0 but the tacoma board uses MAC3.
>
> Shouldn't the model reflect the real address space independently from
> the NIC backends defined on the command line ?

Agreed, the MAC hardware is present in all instances of the AST2600,
so they should be present in qemu. Only some boards wire up a network
device to the other side.

It would be advantageous for us to be able to specify which device is
being connected to on the command line. Currently we do this by
connecting all devices up to the one we care about which is an ugly
workaround.

> How should we proceed in such cases ?
>
> Thanks,
>
> C.
>
> >
> > Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: qemu-arm@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  hw/arm/aspeed_ast2600.c | 2 +-
> >  hw/arm/aspeed_soc.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> > index 71a0acfe26..0a6a77dd54 100644
> > --- a/hw/arm/aspeed_ast2600.c
> > +++ b/hw/arm/aspeed_ast2600.c
> > @@ -188,7 +188,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
> >                                sizeof(s->wdt[i]), typename);
> >      }
> >
> > -    for (i =3D 0; i < sc->macs_num; i++) {
> > +    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
> >          sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac10=
0[i]),
> >                                sizeof(s->ftgmac100[i]), TYPE_FTGMAC100)=
;
> >
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index cf6b6dd116..7ca860392a 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
> > @@ -203,7 +203,7 @@ static void aspeed_soc_init(Object *obj)
> >                                sizeof(s->wdt[i]), typename);
> >      }
> >
> > -    for (i =3D 0; i < sc->macs_num; i++) {
> > +    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
> >          sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac10=
0[i]),
> >                                sizeof(s->ftgmac100[i]), TYPE_FTGMAC100)=
;
> >      }
> >
>

