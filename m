Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5AC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F41720449
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PC1jVLwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F41720449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRQ1-00069Y-BH
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPwc-0003AF-IF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPwa-0004ij-LO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:39:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPwZ-0004fL-Kr
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:39:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so10187668wmm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ia/JSwWFDgm+FggLxLr1qz7HA8mNm3uExaFdEQORjo8=;
 b=PC1jVLwUArhi4XhkVFcc18fXpjhMkNZ6pcxghSfEJz6LEojTUzHS6ShXkpelwWmPKF
 BCY9F9LEf2CQF4gHvrhcuvCtzCiDVuzDEwhQBMY3muIwpVBpfwJ0Dfc58RzvVt/2TRsG
 MMGKL/IccZAVEcYnpwMWMTCLSr48m+C2wAz4eZhDHj5+jPW9pT0jPew5j4nFsqrgrk24
 47QMVYf4v3yjBsWJU2y2rSiysLTGkJUB9x4HXe09Cdc0oX2UJEwJ3V1y9H5v8uS/l1IC
 fup0LVSEu1gfst8fQ5VXoUF031WAvmxWXvzZ8WnDkW8OIp7geofAfTxwLOX/TaF06EO9
 D76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ia/JSwWFDgm+FggLxLr1qz7HA8mNm3uExaFdEQORjo8=;
 b=J15dBpyv3GrGvDxye6AjrVOuuD6Z76hc3T7YkScGgWUO/ltLe84DFANacS2PLuhKy0
 gLNE1/fSlbHEIg8ihkK2z9+BuEy+va19MHxAEY0sxtNVy3uCatpavWwB1rYkcXLdvBXy
 yxU0u5qHxJQUje5uM0ftEQgIl7jkTt4QgE/y0X4PMawBiXN2bNUnW9RBswk3S8FuyV9k
 SXhpPdq2L3kyC7bZ3kbdR2OfTN/1L0941Eyk+b4+WvP2fUSPnmfrsa4at8IpJP8ziofu
 r/rK7B/yHy+aFaUdyGmNT/70OerQ8u8x5K10QVJLri3NUvjJZtBU9/DswPzWUrQlCwr0
 whLQ==
X-Gm-Message-State: APjAAAWqyq9zFq2rC3nAcdYEy/UC7nM4/fI3nO0EQsiUy1uRxxFWN4mo
 +g3gsY3megIv1fkjBRFDXqdgiQ==
X-Google-Smtp-Source: APXvYqxecN5IcBJV7Rfk2M7xD6wCSIV7G3En8mkP6/IqHmny2IQAiYTIYY48EYyfvF/a+QbpvYrnFw==
X-Received: by 2002:a1c:a541:: with SMTP id o62mr3938468wme.84.1560433143134; 
 Thu, 13 Jun 2019 06:39:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w14sm3574435wrt.59.2019.06.13.06.39.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:39:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3EBFA1FF87;
 Thu, 13 Jun 2019 14:39:02 +0100 (BST)
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-5-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190517174046.11146-5-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 14:39:02 +0100
Message-ID: <875zp9ehah.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/4] hw/arm: Correctly disable
 FPU/DSP for some ARMSSE-based boards
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The SSE-200 hardware has configurable integration settings which
> determine whether its two CPUs have the FPU and DSP:
>  * CPU0_FPU (default 0)
>  * CPU0_DSP (default 0)
>  * CPU1_FPU (default 1)
>  * CPU1_DSP (default 1)
>
> Similarly, the IoTKit has settings for its single CPU:
>  * CPU0_FPU (default 1)
>  * CPU0_DSP (default 1)
>
> Of our four boards that use either the IoTKit or the SSE-200:
>  * mps2-an505, mps2-an521 and musca-a use the default settings
>  * musca-b1 enables FPU and DSP on both CPUs
>
> Currently QEMU models all these boards using CPUs with
> both FPU and DSP enabled. This means that we are incorrect
> for mps2-an521 and musca-a, which should not have FPU or DSP
> on CPU0.
>
> Create QOM properties on the ARMSSE devices corresponding to the
> default h/w integration settings, and make the Musca-B1 board
> enable FPU and DSP on both CPUs. This fixes the mps2-an521
> and musca-a behaviour, and leaves the musca-b1 and mps2-an505
> behaviour unchanged.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Given the ever growing configurable nature of the v7m platform what do we do
to ensure the various combinations are tested on instantiating qemu? Or is
this a case of relying on the wider community to shout if users actually
find a combination that breaks? I guess fuzz testing would be a bit of a
sledgehammer approach.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/armsse.h |  7 +++++
>  hw/arm/armsse.c         | 58 ++++++++++++++++++++++++++++++++---------
>  hw/arm/musca.c          |  8 ++++++
>  3 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
> index 81e082cccf8..84080c22993 100644
> --- a/include/hw/arm/armsse.h
> +++ b/include/hw/arm/armsse.h
> @@ -50,6 +50,11 @@
>   *    address of each SRAM bank (and thus the total amount of internal S=
RAM)
>   *  + QOM property "init-svtor" sets the initial value of the CPU SVTOR =
register
>   *    (where it expects to load the PC and SP from the vector table on r=
eset)
> + *  + QOM properties "CPU0_FPU", "CPU0_DSP", "CPU1_FPU" and "CPU1_DSP" w=
hich
> + *    set whether the CPUs have the FPU and DSP features present. The de=
fault
> + *    (matching the hardware) is that for CPU0 in an IoTKit and CPU1 in =
an
> + *    SSE-200 both are present; CPU0 in an SSE-200 has neither.
> + *    Since the IoTKit has only one CPU, it does not have the CPU1_* pro=
perties.
>   *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for =
CPU 0,
>   *    which are wired to its NVIC lines 32 .. n+32
>   *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts=
 for
> @@ -208,6 +213,8 @@ typedef struct ARMSSE {
>      uint32_t mainclk_frq;
>      uint32_t sram_addr_width;
>      uint32_t init_svtor;
> +    bool cpu_fpu[SSE_MAX_CPUS];
> +    bool cpu_dsp[SSE_MAX_CPUS];
>  } ARMSSE;
>
>  typedef struct ARMSSEInfo ARMSSEInfo;
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 76cc6905798..e138aee673f 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -37,6 +37,33 @@ struct ARMSSEInfo {
>      bool has_cachectrl;
>      bool has_cpusecctrl;
>      bool has_cpuid;
> +    Property *props;
> +};
> +
> +static Property iotkit_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> +    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
> +    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
> +    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
> +    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
> +    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static Property armsse_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> +    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
> +    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
> +    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
> +    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], false),
> +    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], false),
> +    DEFINE_PROP_BOOL("CPU1_FPU", ARMSSE, cpu_fpu[1], true),
> +    DEFINE_PROP_BOOL("CPU1_DSP", ARMSSE, cpu_dsp[1], true),
> +    DEFINE_PROP_END_OF_LIST()
>  };
>
>  static const ARMSSEInfo armsse_variants[] =3D {
> @@ -52,6 +79,7 @@ static const ARMSSEInfo armsse_variants[] =3D {
>          .has_cachectrl =3D false,
>          .has_cpusecctrl =3D false,
>          .has_cpuid =3D false,
> +        .props =3D iotkit_properties,
>      },
>      {
>          .name =3D TYPE_SSE200,
> @@ -65,6 +93,7 @@ static const ARMSSEInfo armsse_variants[] =3D {
>          .has_cachectrl =3D true,
>          .has_cpusecctrl =3D true,
>          .has_cpuid =3D true,
> +        .props =3D armsse_properties,
>      },
>  };
>
> @@ -532,6 +561,20 @@ static void armsse_realize(DeviceState *dev, Error *=
*errp)
>                  return;
>              }
>          }
> +        if (!s->cpu_fpu[i]) {
> +            object_property_set_bool(cpuobj, false, "vfp", &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
> +        }
> +        if (!s->cpu_dsp[i]) {
> +            object_property_set_bool(cpuobj, false, "dsp", &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
> +        }
>
>          if (i > 0) {
>              memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
> @@ -1221,16 +1264,6 @@ static const VMStateDescription armsse_vmstate =3D=
 {
>      }
>  };
>
> -static Property armsse_properties[] =3D {
> -    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
> -                     MemoryRegion *),
> -    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> -    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
> -    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
> -    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
> -    DEFINE_PROP_END_OF_LIST()
> -};
> -
>  static void armsse_reset(DeviceState *dev)
>  {
>      ARMSSE *s =3D ARMSSE(dev);
> @@ -1243,13 +1276,14 @@ static void armsse_class_init(ObjectClass *klass,=
 void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      IDAUInterfaceClass *iic =3D IDAU_INTERFACE_CLASS(klass);
>      ARMSSEClass *asc =3D ARMSSE_CLASS(klass);
> +    const ARMSSEInfo *info =3D data;
>
>      dc->realize =3D armsse_realize;
>      dc->vmsd =3D &armsse_vmstate;
> -    dc->props =3D armsse_properties;
> +    dc->props =3D info->props;
>      dc->reset =3D armsse_reset;
>      iic->check =3D armsse_idau_check;
> -    asc->info =3D data;
> +    asc->info =3D info;
>  }
>
>  static const TypeInfo armsse_info =3D {
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index 23aff43f4bc..736f37b774c 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -385,6 +385,14 @@ static void musca_init(MachineState *machine)
>      qdev_prop_set_uint32(ssedev, "init-svtor", mmc->init_svtor);
>      qdev_prop_set_uint32(ssedev, "SRAM_ADDR_WIDTH", mmc->sram_addr_width=
);
>      qdev_prop_set_uint32(ssedev, "MAINCLK", SYSCLK_FRQ);
> +    /*
> +     * Musca-A takes the default SSE-200 FPU/DSP settings (ie no for
> +     * CPU0 and yes for CPU1); Musca-B1 explicitly enables them for CPU0.
> +     */
> +    if (mmc->type =3D=3D MUSCA_B1) {
> +        qdev_prop_set_bit(ssedev, "CPU0_FPU", true);
> +        qdev_prop_set_bit(ssedev, "CPU0_DSP", true);
> +    }
>      object_property_set_bool(OBJECT(&mms->sse), true, "realized",
>                               &error_fatal);


--
Alex Benn=C3=A9e

