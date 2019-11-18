Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3237DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED86620643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="HUaaufw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED86620643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpil-0000YI-WB
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iWpfx-00089L-TJ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iWpfw-0004bH-Hi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:39:17 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iWpft-0004a9-OW; Mon, 18 Nov 2019 17:39:14 -0500
Received: by mail-qk1-x742.google.com with SMTP id m125so16035904qkd.8;
 Mon, 18 Nov 2019 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TGggC5p1vYh+ANvxx79W3lxEqoD5ExQeTUojSCJr9WQ=;
 b=HUaaufw0yp4XdXnRvuehzliyt8UHmXVX9+PFijXRDrTiddMF47f3b7g5qOQvtshcWq
 ouDZtQxoI6GyGAYl9GmxwLP0wt9hCc6WNKdgSYAP2szwTe1Bfw9jqOV+bi1f3TjlD0sQ
 r/eEr8LHfL2RZQ6JgAcX/NqPdRCS2FKSILZGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TGggC5p1vYh+ANvxx79W3lxEqoD5ExQeTUojSCJr9WQ=;
 b=L1dlBDj9Cd69nPpKuxtLXpiVmWEWoP1Dx0/SzYEQQO0zXM0TJAjN008CnjoZKajxh4
 yKbAriOAzj84odNVtRD2TCjMGufduCELkWlIXKVxI0MIs/VAwtpZUC+Llrg+GiaOY5Cq
 wCWbLe1gOH231gdB+k/K4QyfhpJj6lLA9Ix8dTs0m+LUzlGSQc8cQ/masFmjDTQQs2HX
 hkMkuVvEvIsEtYXg+/y6XHMx+Vjp69lsZPD7zKFtyuGud9Q9YPBf/VNKpjoaUzK76/Eg
 fCUnzXOS0PdP2Mf2ziJkHIbZL/2MO695VY1kpSs7QAEKeQJHFig1hWw/n1iqIDSMElSn
 vA+g==
X-Gm-Message-State: APjAAAV12zFL5c71debBI5gJnUAqW1CVKRmFeKpa8GXLR2uCPsDWbyrB
 u+Go04nKsxR9F0J/1FkKgTBso4lj0omyNr/VZNl9mU+7
X-Google-Smtp-Source: APXvYqzLKU8s9cuDHGMoIVStkoIVb364TUsLexul2Gq12RIzmxOVAylHKEwR1d/Bpfa9XH5p/JSj7VbaAuxRWqh54ro=
X-Received: by 2002:a37:aa07:: with SMTP id t7mr17774709qke.414.1574116752802; 
 Mon, 18 Nov 2019 14:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20191118161712.6712-1-clg@kaod.org>
 <20191118161712.6712-3-clg@kaod.org>
In-Reply-To: <20191118161712.6712-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Nov 2019 22:39:00 +0000
Message-ID: <CACPK8Xecx2CQcJ39AE+rUywiEYLwThoJ2KehS6XHpQw91AnGZg@mail.gmail.com>
Subject: Re: [PATCH for-5.0 2/2] aspeed: change the "nic" property definition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
 qemu-arm <qemu-arm@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 16:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The Aspeed MII model has a link pointing to its associated FTGMAC100
> NIC in the machine.
>
> Change the "nic" property definition so that it explicitly sets the
> pointer. The property isn't optional : not being able to set the link
> is a bug and QEMU should rather abort than exit in this case.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed_ast2600.c |  5 ++---
>  hw/net/ftgmac100.c      | 19 +++++++++----------
>  2 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 810fd7de0c06..be88005dab8f 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -183,9 +183,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
>
>          sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i=
]),
>                                TYPE_ASPEED_MII);
> -        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
> -                                       OBJECT(&s->ftgmac100[i]),
> -                                       &error_abort);
>      }
>
>      sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
> @@ -441,6 +438,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                             aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
>
> +        object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac10=
0[i]),
> +                                 "nic", &error_abort);
>          object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
>                                   &err);
>          if (err) {
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index eb8b441461a1..86ac25894a89 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1204,17 +1204,8 @@ static void aspeed_mii_realize(DeviceState *dev, E=
rror **errp)
>  {
>      AspeedMiiState *s =3D ASPEED_MII(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> -    Object *obj;
> -    Error *local_err =3D NULL;
>
> -    obj =3D object_property_get_link(OBJECT(dev), "nic", &local_err);
> -    if (!obj) {
> -        error_propagate(errp, local_err);
> -        error_prepend(errp, "required link 'nic' not found: ");
> -        return;
> -    }
> -
> -    s->nic =3D FTGMAC100(obj);
> +    assert(s->nic);
>
>      memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
>                            TYPE_ASPEED_MII, 0x8);
> @@ -1231,6 +1222,13 @@ static const VMStateDescription vmstate_aspeed_mii=
 =3D {
>          VMSTATE_END_OF_LIST()
>      }
>  };
> +
> +static Property aspeed_mii_properties[] =3D {
> +    DEFINE_PROP_LINK("nic", AspeedMiiState, nic, TYPE_FTGMAC100,
> +                     FTGMAC100State *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void aspeed_mii_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -1239,6 +1237,7 @@ static void aspeed_mii_class_init(ObjectClass *klas=
s, void *data)
>      dc->reset =3D aspeed_mii_reset;
>      dc->realize =3D aspeed_mii_realize;
>      dc->desc =3D "Aspeed MII controller";
> +    dc->props =3D aspeed_mii_properties;
>  }
>
>  static const TypeInfo aspeed_mii_info =3D {
> --
> 2.21.0
>

