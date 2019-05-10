Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78B0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6A520881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syE0Tz9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6A520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCRF-0006bZ-7U
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:48:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCQ2-0005dH-VR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCQ0-0005ue-ST
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:47:02 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCQ0-0005r1-GZ; Fri, 10 May 2019 16:47:00 -0400
Received: by mail-lf1-x142.google.com with SMTP id u27so5040135lfg.10;
	Fri, 10 May 2019 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=UVkrA+yZxM5eUicTpGAnPTCbWprivFcVAHXVqoYE3mc=;
	b=syE0Tz9z1g4pJwVwOEMKONGAunATkQVmld6EMuWakiiR75vAo6W7B6wBMgqO89sgLO
	3DWrA1GaSVflZAsl/4AYC98UF/Zv1xZ4IR6sP7HmoWBDZcwRiyO91X2W2r5pdgdoFayN
	BRHKIQ2YvWitKOfmIyCJLXp3hMxtYRo4EGDqtYZdASjyCrhSRTqSfbg/UWkoJ9wYIunZ
	a1x9eC/ep5obCjgXFRy6G1SJVpyym87IKemlG1hp0/7pw9ckKuO3yP+jiDJ1FH+gx/3W
	t3ISwQfGjCLQ+282AAa/OEEANnOyTYnUNwQLC8yffLTz8cf45dfU7J7KCXOlwVch9u+s
	pkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=UVkrA+yZxM5eUicTpGAnPTCbWprivFcVAHXVqoYE3mc=;
	b=ZZoJviEg+/OP0cuCvxSLISzToc6xmbRwQd2mU52TgVUzZlUb8KI4BATfS3JqjqMCOa
	OFwdMGpHvi06tCAruUCzs3Ils1Uh6rZXnSDa9pTS04JBoWzG2LPBvM0GvQfkM5JBfdvh
	0OCgoQ0BuFAZ39swLK8h7NbYfPBIAu/lnL8vqwAq9XcruWvpb1SG60o0YmWzUHYDhCLM
	SSy2VTfK6O4nTJbikQHlq0aTwfc8+Y6vonJm3ehBYoTVXpy5JJm83M8zEfdm7m7ZWut+
	gNEmOPLcW/IUCSqLbEbS5hYyc3nQ8wSyODfPDnMXsTIHJwjeF9q+vvzT/fQqRj6DVjf9
	VEJw==
X-Gm-Message-State: APjAAAVitfdrpS91TCbagj08D7HLn7TDwL/Z52WX5PSmaE7mrr09INSb
	Y7GZJRnq3kL9bPbQNWjp79tdvmYgbiX+XzxrE3Q=
X-Google-Smtp-Source: APXvYqyyM1sv+ziTBT6YP5BcoOgRwbe5tsrzXPN4G4vwt5RUWZ6TXABVzlyGkzn5Qaz4mG6n3b+Uc47xcjrhMBnzq1Q=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr6529493lfc.121.1557521218123; 
	Fri, 10 May 2019 13:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-9-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:44:49 -0700
Message-ID: <CAKmqyKOSDqLz-nPB17jk+03ZwLnhU0aiEixtj3RT_aJH8uuDQw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v2 08/16] hw/arm: Use
 object_initialize_child for correct reference counting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"open list:New World" <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> As explained in commit aff39be0ed97:
>
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>
> This patch was generated using the following Coccinelle script
> (with a bit of manual fix-up for overly long lines):
>
>  @use_object_initialize_child@
>  expression parent_obj;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
>  +                           child_type, &error_abort, NULL);
>      ... when !=3D parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 NULL);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  |
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
>  +                            child_type, errp, NULL);
>      ... when !=3D parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 errp);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  )
>
>  @use_sysbus_init_child_obj@
>  expression parent_obj;
>  expression dev;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize_child(parent_obj, child_name, child_ptr, child_siz=
e,
>  -                           child_type, errp, NULL);
>  +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
>  +                         child_type);
>      ...
>  -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
>  |
>  -   object_initialize_child(parent_obj, child_name, child_ptr, child_siz=
e,
>  -                           child_type, errp, NULL);
>  +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
>  +                         child_type);
>  -   dev =3D DEVICE(child_ptr);
>  -   qdev_set_parent_bus(dev, sysbus_get_default());
>  )
>
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> This choice also matches when using sysbus_init_child_obj(),
> since its code is:
>
>   void sysbus_init_child_obj(Object *parent,
>                              const char *childname, void *child,
>                              size_t childsize, const char *childtype)
>   {
>       object_initialize_child(parent, childname, child, childsize,
>                               childtype, &error_abort, NULL);
>
>       qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>   }
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2:
>  - Tweaked cocci to improve digic_init (Thomas)
>  - Described new use of &error_abort (Markus)
> ---
>  hw/arm/digic.c       | 17 ++++++-----------
>  hw/arm/imx25_pdk.c   |  5 ++---
>  hw/arm/kzm.c         |  5 ++---
>  hw/arm/raspi.c       |  7 +++----
>  hw/arm/sabrelite.c   |  5 ++---
>  hw/arm/xlnx-zcu102.c |  5 ++---
>  hw/arm/xlnx-zynqmp.c |  8 ++++----
>  7 files changed, 21 insertions(+), 31 deletions(-)
>
> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
> index 726abb9b485..6ef26c6bac3 100644
> --- a/hw/arm/digic.c
> +++ b/hw/arm/digic.c
> @@ -32,27 +32,22 @@
>  static void digic_init(Object *obj)
>  {
>      DigicState *s =3D DIGIC(obj);
> -    DeviceState *dev;
>      int i;
>
> -    object_initialize(&s->cpu, sizeof(s->cpu), "arm946-" TYPE_ARM_CPU);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            "arm946-" TYPE_ARM_CPU, &error_abort, NULL);
>
>      for (i =3D 0; i < DIGIC4_NB_TIMERS; i++) {
>  #define DIGIC_TIMER_NAME_MLEN    11
>          char name[DIGIC_TIMER_NAME_MLEN];
>
> -        object_initialize(&s->timer[i], sizeof(s->timer[i]), TYPE_DIGIC_=
TIMER);
> -        dev =3D DEVICE(&s->timer[i]);
> -        qdev_set_parent_bus(dev, sysbus_get_default());
>          snprintf(name, DIGIC_TIMER_NAME_MLEN, "timer[%d]", i);
> -        object_property_add_child(obj, name, OBJECT(&s->timer[i]), NULL)=
;
> +        sysbus_init_child_obj(obj, name, &s->timer[i], sizeof(s->timer[i=
]),
> +                              TYPE_DIGIC_TIMER);
>      }
>
> -    object_initialize(&s->uart, sizeof(s->uart), TYPE_DIGIC_UART);
> -    dev =3D DEVICE(&s->uart);
> -    qdev_set_parent_bus(dev, sysbus_get_default());
> -    object_property_add_child(obj, "uart", OBJECT(&s->uart), NULL);
> +    sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
> +                          TYPE_DIGIC_UART);
>  }
>
>  static void digic_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 9f3ee147390..eef1b184b0d 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -72,9 +72,8 @@ static void imx25_pdk_init(MachineState *machine)
>      unsigned int alias_offset;
>      int i;
>
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX25);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            TYPE_FSL_IMX25, &error_abort, NULL);
>
>      object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
>
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 139934c4ecf..44cba8782bf 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -71,9 +71,8 @@ static void kzm_init(MachineState *machine)
>      unsigned int alias_offset;
>      unsigned int i;
>
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX31);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            TYPE_FSL_IMX31, &error_abort, NULL);
>
>      object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 66899c28dc1..0a6244096cc 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -175,10 +175,9 @@ static void raspi_init(MachineState *machine, int ve=
rsion)
>      BusState *bus;
>      DeviceState *carddev;
>
> -    object_initialize(&s->soc, sizeof(s->soc),
> -                      version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM2836);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM28=
36,
> +                            &error_abort, NULL);
>
>      /* Allocate and map RAM */
>      memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
> diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
> index ee140e5d9eb..f1b00de2294 100644
> --- a/hw/arm/sabrelite.c
> +++ b/hw/arm/sabrelite.c
> @@ -55,9 +55,8 @@ static void sabrelite_init(MachineState *machine)
>          exit(1);
>      }
>
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX6);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            TYPE_FSL_IMX6, &error_abort, NULL);
>
>      object_property_set_bool(OBJECT(&s->soc), true, "realized", &err);
>      if (err !=3D NULL) {
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index b6bc6a93b89..c802f26fbdf 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -91,9 +91,8 @@ static void xlnx_zcu102_init(MachineState *machine)
>      memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
>                                           ram_size);
>
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_XLNX_ZYNQMP);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            TYPE_XLNX_ZYNQMP, &error_abort, NULL);
>
>      object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
>                           "ddr-ram", &error_abort);
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 4f8bc41d9d4..6e991903022 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -191,10 +191,10 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
>      for (i =3D 0; i < num_rpus; i++) {
>          char *name;
>
> -        object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
> -                          "cortex-r5f-" TYPE_ARM_CPU);
> -        object_property_add_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
> -                                  OBJECT(&s->rpu_cpu[i]), &error_abort);
> +        object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
> +                                &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
> +                                "cortex-r5f-" TYPE_ARM_CPU, &error_abort=
,
> +                                NULL);
>
>          name =3D object_get_canonical_path_component(OBJECT(&s->rpu_cpu[=
i]));
>          if (strcmp(name, boot_cpu)) {
> --
> 2.20.1
>
>

