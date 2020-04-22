Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4DC5518E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFB7214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP+txR+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFB7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRI5o-00009w-PI
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRI4R-000770-GO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRI4K-0006On-1v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:17:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRI4J-0006Cs-GH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587572266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKtwDxPfL3e/6bu1rhr1RdOYmK5oQKqr3TvbbqSUpuY=;
 b=TP+txR+g3/BYRbPOG+SGyc5HyfdS4X6dlOAiuf77D2YzD3hJLWtB58cgAFi8Vy9dDGTgEy
 5c7eEmrPtUGtHzdIGKhUaHyN9W/F50RkFihtTLMkQT1vXbW1PQs6OgH3pRVHRTSIL6brPd
 97IhdJd52k8MqrX+CciZ6eaIpRtTQtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-LO_cKapDNuW1FJ6ifKS1pg-1; Wed, 22 Apr 2020 12:17:44 -0400
X-MC-Unique: LO_cKapDNuW1FJ6ifKS1pg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6A33107ACC4;
 Wed, 22 Apr 2020 16:17:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0577D1010403;
 Wed, 22 Apr 2020 16:17:35 +0000 (UTC)
Subject: Re: [PATCH 1/5] Revert "hw/display/ramfb: initialize fw-config space
 with xres/ yres"
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-2-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <633bb8fd-a19e-7c72-76c0-da8c27f4d8da@redhat.com>
Date: Wed, 22 Apr 2020 18:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-2-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/22/20 12:02, Gerd Hoffmann wrote:
> This reverts commit f79081b4b71b72640bedd40a7cd76f864c8287f1.
> 
> Patch has broken byteorder handling: RAMFBCfg fields are in bigendian
> byteorder, the reset function doesn't care so native byteorder is used
> instead.  Given this went unnoticed so far the feature is obviously
> unused, so just revert the patch.
> 
> Cc: Hou Qiming <hqm03ster@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/display/ramfb.h    |  2 +-
>  hw/display/ramfb-standalone.c | 12 +-----------
>  hw/display/ramfb.c            | 16 +---------------
>  hw/vfio/display.c             |  4 ++--
>  stubs/ramfb.c                 |  2 +-
>  5 files changed, 6 insertions(+), 30 deletions(-)

Acked-by: Laszlo Ersek <lersek@redhat.com>


> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index f6c2de93b222..b33a2c467b28 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -4,7 +4,7 @@
>  /* ramfb.c */
>  typedef struct RAMFBState RAMFBState;
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(DeviceState *dev, Error **errp);
> +RAMFBState *ramfb_setup(Error **errp);
>  
>  /* ramfb-standalone.c */
>  #define TYPE_RAMFB_DEVICE "ramfb"
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index d76a9d0fe2c9..b18db97eeb1b 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -3,7 +3,6 @@
>  #include "qemu/module.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/isa/isa.h"
>  #include "hw/display/ramfb.h"
>  #include "ui/console.h"
>  
> @@ -13,8 +12,6 @@ typedef struct RAMFBStandaloneState {
>      SysBusDevice parent_obj;
>      QemuConsole *con;
>      RAMFBState *state;
> -    uint32_t xres;
> -    uint32_t yres;
>  } RAMFBStandaloneState;
>  
>  static void display_update_wrapper(void *dev)
> @@ -37,22 +34,15 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>      RAMFBStandaloneState *ramfb = RAMFB(dev);
>  
>      ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(dev, errp);
> +    ramfb->state = ramfb_setup(errp);
>  }
>  
> -static Property ramfb_properties[] = {
> -    DEFINE_PROP_UINT32("xres", RAMFBStandaloneState, xres, 0),
> -    DEFINE_PROP_UINT32("yres", RAMFBStandaloneState, yres, 0),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      dc->realize = ramfb_realizefn;
> -    device_class_set_props(dc, ramfb_properties);
>      dc->desc = "ram framebuffer standalone device";
>      dc->user_creatable = true;
>  }
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 7ba07c80f6e1..bd4746dc1768 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -13,7 +13,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu/option.h"
>  #include "hw/loader.h"
>  #include "hw/display/ramfb.h"
>  #include "ui/console.h"
> @@ -31,7 +30,6 @@ struct QEMU_PACKED RAMFBCfg {
>  struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
> -    uint32_t starting_width, starting_height;
>      struct RAMFBCfg cfg;
>      bool locked;
>  };
> @@ -117,11 +115,9 @@ static void ramfb_reset(void *opaque)
>      RAMFBState *s = (RAMFBState *)opaque;
>      s->locked = false;
>      memset(&s->cfg, 0, sizeof(s->cfg));
> -    s->cfg.width = s->starting_width;
> -    s->cfg.height = s->starting_height;
>  }
>  
> -RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
> +RAMFBState *ramfb_setup(Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
>      RAMFBState *s;
> @@ -133,16 +129,6 @@ RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
>  
>      s = g_new0(RAMFBState, 1);
>  
> -    const char *s_fb_width = qemu_opt_get(dev->opts, "xres");
> -    const char *s_fb_height = qemu_opt_get(dev->opts, "yres");
> -    if (s_fb_width) {
> -        s->cfg.width = atoi(s_fb_width);
> -        s->starting_width = s->cfg.width;
> -    }
> -    if (s_fb_height) {
> -        s->cfg.height = atoi(s_fb_height);
> -        s->starting_height = s->cfg.height;
> -    }
>      s->locked = false;
>  
>      rom_add_vga("vgabios-ramfb.bin");
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index f4977c66e1b5..a57a22674d62 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -353,7 +353,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_dmabuf_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
> +        vdev->dpy->ramfb = ramfb_setup(errp);
>      }
>      vfio_display_edid_init(vdev);
>      return 0;
> @@ -479,7 +479,7 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                            &vfio_display_region_ops,
>                                            vdev);
>      if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
> +        vdev->dpy->ramfb = ramfb_setup(errp);
>      }
>      return 0;
>  }
> diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> index 0799093a5d6e..48143f33542f 100644
> --- a/stubs/ramfb.c
> +++ b/stubs/ramfb.c
> @@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>  {
>  }
>  
> -RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
> +RAMFBState *ramfb_setup(Error **errp)
>  {
>      error_setg(errp, "ramfb support not available");
>      return NULL;
> 


