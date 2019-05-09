Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277BA216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlZ4QGDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOglR-0004oK-2h
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:59:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgkc-0004V9-44
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgka-0002HB-Q7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:58:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hOgka-0002Ga-Fz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:58:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id v11so2412614wru.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=r7wQAr+B95hWG85KlnTTzPmq69hPnDz7WG2ErnSMeYk=;
	b=mlZ4QGDYYkzc5l7bsDxWcgY3SevkIWl9yB7s+0jdJnb7PoSaIh90ZsIMK75o8SD3eE
	J+D6FsLrd6hrZOwH8/0gzdtUs6BqlRwBrsTRSkV9YxKrAMfF3e4wf49DmjdLFbsUpqBt
	WAWVLkBobVCZoBTLeiG4kQV3UAU+f22tY78+vmdNZOKJqKiAJbC+TghiuTeEAsaVSLaI
	5uUxMf6UiSqDyXOkVm/YFaEKsxVrKoIN7TPZjv/KKobBJ109RdTMycrGzI1x8/212gMi
	4NgqmFXVFnpRYoACrl7U7ap+UwOFywRroTyBp9mNmici6hJw+AVwsheZ/VZiFkEhaTLA
	XpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=r7wQAr+B95hWG85KlnTTzPmq69hPnDz7WG2ErnSMeYk=;
	b=AT8mSql3NIav5JCvq4mr4b+P4nnzCXEK+WhWqGJLg2tGPWcnOfsFwYkrj7YiQYSWtQ
	PyQqDmUYfMji+6uhNYLmkUvxL9QYRzjVsbtADLRUbvSsCfk8pWk042osiFOq8/CMYR2O
	snCNs3Z8wokw2uTJ3AKzc2Tu/u8wq6w0TrBaOy/3UiQwHwLZrNxBUEKsl7yHhG09rmba
	h506wlXRrvv2Z2iPAjLDs2bzNzqSPuKvdvtEzl+Tdi1numCFiiCXYr8sCLstQwr3dqKV
	i86Mj0JAhCzj8PWVOSamhGwh5sm6Vjem34nF8WhGDcwaBq0U2khKli+RPPhVsDc5PBEp
	IxRg==
X-Gm-Message-State: APjAAAU1Nn4ktTfFl9FgznwFMIO6HprnhFfVPJpkwMstu+IUC/RrzFi6
	UO6TBiobTY+8WOeDb/QDsfM=
X-Google-Smtp-Source: APXvYqzCADSDDJK6IEXbfb4YVnj9b0DH/CFDV2gnMSqHvXkrPcpdx2ygMkSf2OGjXa26VtICYxnT0A==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr1221104wrr.145.1557399487161; 
	Thu, 09 May 2019 03:58:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id f6sm2473255wro.12.2019.05.09.03.58.06
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 03:58:06 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
Date: Thu, 9 May 2019 13:58:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/9/19 10:58 AM, Hou Qiming wrote:
>
> Write an initial resolution to the configuration space on guest reset,
> which a later BIOS / OVMF patch can take advantage of.
>

I like the idea of moving the ramfb configuration to the PCI 
configuration space,
do you think is possible to move all the ramfb configuration there so we 
will
not need the fw-config file?
()

> Signed-off-by: HOU Qiming <hqm03ster@gmail.com 
> <mailto:hqm03ster@gmail.com>>
> ---
>  hw/display/ramfb-standalone.c | 12 +++++++++++-
>  hw/display/ramfb.c            | 16 +++++++++++++++-
>  hw/vfio/display.c             |  4 ++--
>  hw/vfio/pci.c                 |  6 ++++--
>  include/hw/display/ramfb.h    |  2 +-
>  stubs/ramfb.c                 |  2 +-
>  6 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index da3229a..6441449 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/loader.h"
> +#include "hw/isa/isa.h"
>  #include "hw/display/ramfb.h"
>  #include "ui/console.h"
>  #include "sysemu/sysemu.h"
> @@ -11,6 +12,8 @@ typedef struct RAMFBStandaloneState {
>      SysBusDevice parent_obj;
>      QemuConsole *con;
>      RAMFBState *state;
> +    uint32_t xres;
> +    uint32_t yres;
>  } RAMFBStandaloneState;
>
>  static void display_update_wrapper(void *dev)
> @@ -33,15 +36,22 @@ static void ramfb_realizefn(DeviceState *dev, 
> Error **errp)
>      RAMFBStandaloneState *ramfb = RAMFB(dev);
>
>      ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(dev, errp);
>  }
>
> +static Property ramfb_properties[] = {
> +    DEFINE_PROP_UINT32("xres", RAMFBStandaloneState, xres, 0),
> +    DEFINE_PROP_UINT32("yres", RAMFBStandaloneState, yres, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      dc->realize = ramfb_realizefn;
> +    dc->props = ramfb_properties;
>      dc->desc = "ram framebuffer standalone device";
>      dc->user_creatable = true;
>  }
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index fa6296b..0033ac8 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -12,6 +12,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/option.h"
>  #include "hw/loader.h"
>  #include "hw/display/ramfb.h"
>  #include "ui/console.h"
> @@ -29,6 +30,7 @@ struct QEMU_PACKED RAMFBCfg {
>  struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
> +    uint32_t starting_width, starting_height;
>      hwaddr addr, length;
>      struct RAMFBCfg cfg;
>      bool locked;
> @@ -120,9 +122,11 @@ static void ramfb_reset(void *opaque)
>      RAMFBState *s = (RAMFBState *)opaque;
>      s->locked = false;
>      memset(&s->cfg, 0, sizeof(s->cfg));
> +    s->cfg.width = s->starting_width;
> +    s->cfg.height = s->starting_height;
>  }
>
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
>      RAMFBState *s;
> @@ -134,6 +138,16 @@ RAMFBState *ramfb_setup(Error **errp)
>
>      s = g_new0(RAMFBState, 1);
>
> +    const char *s_fb_width = qemu_opt_get(dev->opts, "xres");
> +    const char *s_fb_height = qemu_opt_get(dev->opts, "yres");
> +    if (s_fb_width) {
> +        s->cfg.width = atoi(s_fb_width);
> +        s->starting_width = s->cfg.width;
> +    }
> +    if (s_fb_height) {
> +        s->cfg.height = atoi(s_fb_height);
> +        s->starting_height = s->cfg.height;
> +    }
>      s->locked = false;
>
>      rom_add_vga("vgabios-ramfb.bin");
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index a3d9c8f..2c2d3e5 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -352,7 +352,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice 
> *vdev, Error **errp)
> &vfio_display_dmabuf_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
>      }
>      vfio_display_edid_init(vdev);
>      return 0;
> @@ -478,7 +478,7 @@ static int vfio_display_region_init(VFIOPCIDevice 
> *vdev, Error **errp)
> &vfio_display_region_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
>      }
>      return 0;
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8cecb53..5d64daa 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3080,8 +3080,10 @@ static void vfio_realize(PCIDevice *pdev, Error 
> **errp)
>              error_setg(errp, "xres and yres properties require 
> display=on");
>              goto out_teardown;
>          }
> -        if (vdev->dpy->edid_regs == NULL) {
> -            error_setg(errp, "xres and yres properties need edid 
> support");
> +        if (vdev->dpy->edid_regs == NULL && !vdev->enable_ramfb) {
> +            error_setg(errp,
> +                       "xres and yres properties need edid support"
> +                       " or ramfb=on");

Is this chunk related to this patch? If not, you may want to split it.

Thanks,
Marcel

>              goto out_teardown;
>          }
>      }
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index b33a2c4..f6c2de9 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -4,7 +4,7 @@
>  /* ramfb.c */
>  typedef struct RAMFBState RAMFBState;
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(DeviceState *dev, Error **errp);
>
>  /* ramfb-standalone.c */
>  #define TYPE_RAMFB_DEVICE "ramfb"
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 48143f3..0799093 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>  {
>  }
>
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
>  {
>      error_setg(errp, "ramfb support not available");
>      return NULL;
> -- 
> 2.17.1
>
>


