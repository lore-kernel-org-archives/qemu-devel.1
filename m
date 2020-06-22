Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFF320732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFF320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLiq-0002Tc-FA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnLi7-0001W7-NV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:38:03 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:40180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnLi5-000345-H9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:38:03 -0400
Received: from player729.ha.ovh.net (unknown [10.110.171.131])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id CC9BE24155A
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 14:37:58 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 0FE7B13C02A11;
 Mon, 22 Jun 2020 12:37:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005a94ee40a-c2a1-414b-9d77-f01feaf249e5,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 17/22] hw/arm: Drop useless object_property_set_link()
 error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-18-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0cad765e-879c-973f-ea87-c691b410625d@kaod.org>
Date: Mon, 22 Jun 2020 14:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622104250.1404835-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11972256660866632624
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekvddgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.33.109; envelope-from=clg@kaod.org;
 helo=10.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 08:37:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 12:42 PM, Markus Armbruster wrote:
> object_property_set_link() fails when the property doesn't exist, is
> not settable, or its .check() method fails.  These are all programming
> errors here, so passing it &error_abort is appropriate.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

For the Aspeed parts,
 
Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  hw/arm/armsse.c         | 53 ++++++++++-------------------------------
>  hw/arm/armv7m.c         |  7 ++----
>  hw/arm/aspeed_ast2600.c | 20 ++++------------
>  hw/arm/aspeed_soc.c     | 14 ++++-------
>  hw/arm/nrf51_soc.c      |  6 +----
>  5 files changed, 24 insertions(+), 76 deletions(-)
> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index e8f8f60abc..c73cc6badf 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -564,16 +564,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>                                                  &s->container, -1);
>          }
>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
> -                                 "memory", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> -        object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +                                 "memory", &error_abort);
> +        object_property_set_link(cpuobj, OBJECT(s), "idau", &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err);
>          if (err) {
>              error_propagate(errp, err);
> @@ -700,11 +692,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>          object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
> -                                 "downstream", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +                                 "downstream", &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
> @@ -755,11 +743,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
>                         armsse_get_common_irq_in(s, 3));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer0), 0);
> -    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]",
> +                             &error_abort);
>  
>      qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
>      sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err);
> @@ -770,12 +755,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
>                         armsse_get_common_irq_in(s, 4));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
> -    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> +    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]",
> +                             &error_abort);
>  
>      qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
>      sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err);
> @@ -786,11 +767,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
>                         armsse_get_common_irq_in(s, 5));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dualtimer), 0);
> -    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]",
> +                             &error_abort);
>  
>      if (info->has_mhus) {
>          /*
> @@ -815,12 +793,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>              port = g_strdup_printf("port[%d]", i + 3);
>              mr = sysbus_mmio_get_region(mhu_sbd, 0);
>              object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr),
> -                                     port, &err);
> +                                     port, &error_abort);
>              g_free(port);
> -            if (err) {
> -                error_propagate(errp, err);
> -                return;
> -            }
>  
>              /*
>               * Each MHU has an irq line for each CPU:
> @@ -967,11 +941,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
>                         armsse_get_common_irq_in(s, 2));
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
> -    object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]",
> +                             &error_abort);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err);
>      if (err) {
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index ce83586e03..3308211e9c 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -170,11 +170,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>      object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
>                               &error_abort);
>      if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
> -        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
> -        if (err != NULL) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +        object_property_set_link(OBJECT(s->cpu), s->idau, "idau",
> +                                 &error_abort);
>      }
>      if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
>          object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 08b3592e36..4efac02e2b 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -341,11 +341,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* I2C */
> -    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -363,11 +360,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* FMC, The number of CS is set at the board level */
> -    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
> +                             &error_abort);
>      object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
>                              "sdram-base", &err);
>      if (err) {
> @@ -388,11 +382,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      /* SPI */
>      for (i = 0; i < sc->spis_num; i++) {
>          object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
> -                                 "dram", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +                                 "dram", &error_abort);
>          object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
>          sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
>          if (err) {
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index ec21de50ce..03b91bade6 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -300,11 +300,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* I2C */
> -    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -315,11 +312,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>                         aspeed_soc_get_irq(s, ASPEED_I2C));
>  
>      /* FMC, The number of CS is set at the board level */
> -    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
> +                             &error_abort);
>      object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
>                              "sdram-base", &err);
>      if (err) {
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 5a8961ddbb..20dd8b5897 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -66,11 +66,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>  
>      object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
> -            &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err);
>      if (err) {
>          error_propagate(errp, err);
> 


