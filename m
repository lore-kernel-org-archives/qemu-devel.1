Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F94C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFFF20883
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Kia4tsT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFFF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasbr-00080t-UK
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 22:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hasOT-0004M9-2d
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1has9b-0000dl-Mz
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:34:23 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1has9N-0000KY-K0; Tue, 11 Jun 2019 21:34:08 -0400
Received: by mail-qk1-x744.google.com with SMTP id i125so8972023qkd.6;
 Tue, 11 Jun 2019 18:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CCdsGXdAc4LVHo6Ua/mKk9JIE+ePyTMU9xQxKZFmY4s=;
 b=Kia4tsT7tSVWJLaqe6Dw8fW7lTg8xYGTvxMvajFvXxKVM6MGPxFSZMSfxwtbVnVzTu
 6AbiASkNsPlb7PINLJBDpphnnkKDZoIdYwbVKKMEYexkOXQH+WtXKsweWnbmdaAxGVzz
 b4cewO4Wq0Euy8Sr0Kp0kqHhwSQR/SX0pBytc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CCdsGXdAc4LVHo6Ua/mKk9JIE+ePyTMU9xQxKZFmY4s=;
 b=groQ44ISmM99cpfQ+5gACVlvnVuzm3bQmnhGLYEVdpMSJk4c/6k5qqBl1PYL/JixZT
 ipYE3zv18BGVyvV0T0QFKP/p2iYSKtJ0iFRB0t1DQsNafyr6chGwROeWZ8jHYh9pnbia
 ztUOu3w37DEXrywTsmlHddMEG6fF3drJ7oOqJJmHftbu7NFZNlqpCTdFDqJdVPONNhgS
 bIdS7ZuXK4xlYlGFtOeX3AfLrm++LZkH+z1RfR/R2lDqlZw+eEk1kFbTmZew135nodhW
 nTdE0EYaVDYuIwdhHEilPKcuq/A0s+88+ATIwAygDBwzca8KlftleVhvJF2BoZKljyzM
 hfFg==
X-Gm-Message-State: APjAAAW8eB/dLSSSTOn9qpvcccbZpgZfuDn6MKD1zjHC85UsTtgkptGo
 LbQGpggo2jSG0S/DqiLeXEI+l01J1gFcmPXks6Q=
X-Google-Smtp-Source: APXvYqzhlgmi179pxx1gr4tcBbpgG9BEv94Xn4JI7OvbkQHOY3VYZsEgx6GwfYtaKCGdFRq8hAUw4vRQRr/qtou3KrA=
X-Received: by 2002:a37:de13:: with SMTP id h19mr60964963qkj.59.1560303172167; 
 Tue, 11 Jun 2019 18:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-7-clg@kaod.org>
In-Reply-To: <20190525151241.5017-7-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Jun 2019 01:32:40 +0000
Message-ID: <CACPK8Xet-EQFKbjykuE774pCo4aSNoy=SNpSRW16pJjXW=4J5w@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 06/19] aspeed: introduce a configurable
 number of CPU per machine
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 May 2019 at 15:13, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The current models of the Aspeed SoCs only have one CPU but future
> ones will support SMP. Introduce a way to configure the maximum number
> of CPU per machine. SMP support will be activated when models for such
> SoCs are implemented.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/arm/aspeed.h     |  1 +
>  include/hw/arm/aspeed_soc.h |  3 ++-
>  hw/arm/aspeed.c             |  8 ++++++--
>  hw/arm/aspeed_soc.c         | 17 +++++++++++------
>  4 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 02073a6b4d61..f2f238ea83cc 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -23,6 +23,7 @@ typedef struct AspeedBoardConfig {
>      uint32_t num_cs;
>      void (*i2c_init)(AspeedBoardState *bmc);
>      uint32_t ram;
> +    uint32_t num_cpus;
>  } AspeedBoardConfig;
>
>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index fa0ba957a611..7247f6da2505 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -24,13 +24,14 @@
>
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
> +#define ASPEED_CPUS_NUM  2
>
>  typedef struct AspeedSoCState {
>      /*< private >*/
>      DeviceState parent;
>
>      /*< public >*/
> -    ARMCPU cpu;
> +    ARMCPU cpu[ASPEED_CPUS_NUM];
>      MemoryRegion sram;
>      AspeedVICState vic;
>      AspeedRtcState rtc;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 10ba3f50481a..004b0c318951 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -29,7 +29,6 @@
>
>  static struct arm_boot_info aspeed_board_binfo =3D {
>      .board_id =3D -1, /* device-tree-only board */
> -    .nb_cpus =3D 1,
>  };
>
>  struct AspeedBoardState {
> @@ -231,6 +230,7 @@ static void aspeed_board_init(MachineState *machine,
>      aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
>      aspeed_board_binfo.ram_size =3D ram_size;
>      aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
> +    aspeed_board_binfo.nb_cpus =3D cfg->num_cpus;
>
>      if (cfg->i2c_init) {
>          cfg->i2c_init(bmc);
> @@ -327,7 +327,7 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
>
>      mc->desc =3D board->desc;
>      mc->init =3D aspeed_machine_init;
> -    mc->max_cpus =3D 1;
> +    mc->max_cpus =3D ASPEED_CPUS_NUM;
>      mc->no_sdcard =3D 1;
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
> @@ -357,6 +357,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .num_cs    =3D 1,
>          .i2c_init  =3D palmetto_bmc_i2c_init,
>          .ram       =3D 256 * MiB,
> +        .num_cpus  =3D 1,
>      }, {
>          .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
>          .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
> @@ -367,6 +368,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .num_cs    =3D 1,
>          .i2c_init  =3D ast2500_evb_i2c_init,
>          .ram       =3D 512 * MiB,
> +        .num_cpus  =3D 1,
>      }, {
>          .name      =3D MACHINE_TYPE_NAME("romulus-bmc"),
>          .desc      =3D "OpenPOWER Romulus BMC (ARM1176)",
> @@ -377,6 +379,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .num_cs    =3D 2,
>          .i2c_init  =3D romulus_bmc_i2c_init,
>          .ram       =3D 512 * MiB,
> +        .num_cpus  =3D 1,
>      }, {
>          .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
> @@ -387,6 +390,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .num_cs    =3D 2,
>          .i2c_init  =3D witherspoon_bmc_i2c_init,
>          .ram       =3D 512 * MiB,
> +        .num_cpus  =3D 1,
>      },
>  };
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index d1dc8f03f35c..b983d5efc5d1 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -172,8 +172,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      int i;
>
> -    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
> -                            sc->info->cpu_type, &error_abort, NULL);
> +    for (i =3D 0; i < MIN(smp_cpus, ASPEED_CPUS_NUM); i++) {

What's the intent of this test?

If we're checking that the user hasn't requested more CPUs that the
SoC supports, shoudln't it be testing against ->num_cpus instead of
ASPEED_CPUS_NUM?

> +        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
> +                                sizeof(s->cpu[i]), sc->info->cpu_type,
> +                                &error_abort, NULL);
> +    }
>
>      sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
>                            TYPE_ASPEED_SCU);
> @@ -242,10 +245,12 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
>                                  ASPEED_SOC_IOMEM_SIZE);
>
>      /* CPU */
> -    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i =3D 0; i < smp_cpus; i++) {

Can you explain why we use smp_cpus instead of ->num_cpus?

> +        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &=
err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>      }
>
>      /* SRAM */
> --
> 2.20.1
>

