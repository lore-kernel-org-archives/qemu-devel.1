Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BBD2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BBD2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLhu-0001Dz-Ds
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnLhF-0000f0-L0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:37:09 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:34479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnLhD-0002yl-IV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:37:09 -0400
Received: from player731.ha.ovh.net (unknown [10.108.57.245])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id DF5BF14412C
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 14:37:02 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 59DCC1368FC40;
 Mon, 22 Jun 2020 12:37:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051a6411cf-979f-4045-80c0-8cef1ca3e3c0,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 13/22] aspeed: Clean up roundabout error propagation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-14-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6cbeb3fb-9cc7-ed38-6691-d64ece5f2122@kaod.org>
Date: Mon, 22 Jun 2020 14:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622104250.1404835-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11956494061055675200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekvddgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.72.44; envelope-from=clg@kaod.org;
 helo=9.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 08:37:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 12:42 PM, Markus Armbruster wrote:
> Replace
> 
>         sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
>         error_propagate(&err, local_err);
>         if (err) {
>             error_propagate(errp, err);
>             return;
> 	}
> 
> by
> 
>         sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
>         if (err) {
>             error_propagate(errp, err);
>             return;
> 	}
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  hw/arm/aspeed_ast2600.c | 10 ++++------
>  hw/arm/aspeed_soc.c     | 10 ++++------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 6da687299f..08b3592e36 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -228,7 +228,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      int i;
>      AspeedSoCState *s = ASPEED_SOC(dev);
>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    Error *err = NULL, *local_err = NULL;
> +    Error *err = NULL;
>      qemu_irq irq;
>  
>      /* IO space */
> @@ -394,8 +394,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>          object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
> -        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
> -        error_propagate(&err, local_err);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
> @@ -446,11 +445,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < sc->macs_num; i++) {
>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
>                                   &err);
> -        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
> -        error_propagate(&err, local_err);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
> -           return;
> +            return;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                          sc->memmap[ASPEED_ETH1 + i]);
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 810cf9b6cc..ec21de50ce 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -218,7 +218,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      int i;
>      AspeedSoCState *s = ASPEED_SOC(dev);
>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    Error *err = NULL, *local_err = NULL;
> +    Error *err = NULL;
>  
>      /* IO space */
>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
> @@ -340,8 +340,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      /* SPI */
>      for (i = 0; i < sc->spis_num; i++) {
>          object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
> -        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
> -        error_propagate(&err, local_err);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
> @@ -392,11 +391,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < sc->macs_num; i++) {
>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
>                                   &err);
> -        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
> -        error_propagate(&err, local_err);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
> -           return;
> +            return;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                          sc->memmap[ASPEED_ETH1 + i]);
> 


