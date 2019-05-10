Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D4C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 05:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9372070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 05:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9372070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOxg9-0003WW-Ie
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 01:02:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOxfE-0003FL-Ah
	for qemu-devel@nongnu.org; Fri, 10 May 2019 01:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOxfC-0001Ti-C6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 01:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOxfC-0001TM-3X
	for qemu-devel@nongnu.org; Fri, 10 May 2019 01:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 222A03086200;
	Fri, 10 May 2019 05:01:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9CCE1001E6E;
	Fri, 10 May 2019 05:01:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id ECD59A1E1; Fri, 10 May 2019 07:01:39 +0200 (CEST)
Date: Fri, 10 May 2019 07:01:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Hou Qiming <hqm03ster@gmail.com>
Message-ID: <20190510050139.jpxrghxzahejpteu@sirius.home.kraxel.org>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 10 May 2019 05:01:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] ramfb enhancement
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 03:58:02PM +0800, Hou Qiming wrote:
> Only allow one resolution change per guest boot, which prevents a
> crash when the guest writes garbage to the configuration space (e.g.
> when rebooting).

Hmm?  Did you see that happen in practice?
It is not easy to write to fw_cfg by accident ...

> 
> Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
> ---
>  hw/display/ramfb.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index c27fcc7..fa6296b 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -31,6 +31,7 @@ struct RAMFBState {
>      uint32_t width, height;
>      hwaddr addr, length;
>      struct RAMFBCfg cfg;
> +    bool locked;
>  };
> 
>  static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
> @@ -73,11 +74,11 @@ static DisplaySurface
> *qemu_create_displaysurface_guestmem(
>  static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>  {
>      RAMFBState *s = dev;
> -    uint32_t fourcc, format;
> +    uint32_t fourcc, format, width, height;
>      hwaddr stride, addr, length;
> 
> -    s->width  = be32_to_cpu(s->cfg.width);
> -    s->height = be32_to_cpu(s->cfg.height);
> +    width     = be32_to_cpu(s->cfg.width);
> +    height    = be32_to_cpu(s->cfg.height);
>      stride    = be32_to_cpu(s->cfg.stride);
>      fourcc    = be32_to_cpu(s->cfg.fourcc);
>      addr      = be64_to_cpu(s->cfg.addr);
> @@ -85,9 +86,16 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset,
> size_t len)
>      format    = qemu_drm_format_to_pixman(fourcc);
> 
>      fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
> -            s->width, s->height, addr);
> +            width, height, addr);
> +    if (s->locked) {
> +        fprintf(stderr, "%s: resolution locked, change rejected\n",
> __func__);
> +        return;
> +    }
> +    s->locked = true;
>      s->addr = addr;
>      s->length = length;
> +    s->width = width;
> +    s->height = height;
>      s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
>                                                  format, stride, s->addr);
>  }
> @@ -107,6 +115,13 @@ void ramfb_display_update(QemuConsole *con, RAMFBState
> *s)
>      dpy_gfx_update_full(con);
>  }
> 
> +static void ramfb_reset(void *opaque)
> +{
> +    RAMFBState *s = (RAMFBState *)opaque;
> +    s->locked = false;
> +    memset(&s->cfg, 0, sizeof(s->cfg));
> +}
> +
>  RAMFBState *ramfb_setup(Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
> @@ -119,9 +134,12 @@ RAMFBState *ramfb_setup(Error **errp)
> 
>      s = g_new0(RAMFBState, 1);
> 
> +    s->locked = false;
> +
>      rom_add_vga("vgabios-ramfb.bin");
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
>                               &s->cfg, sizeof(s->cfg), false);
> +    qemu_register_reset(ramfb_reset, s);
>      return s;
>  }
> -- 
> 2.17.1

