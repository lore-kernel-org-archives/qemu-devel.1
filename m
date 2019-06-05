Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4AFC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246382075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEWHoCvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246382075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYS1l-0007AX-9B
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:16:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYS0C-0006KG-ST
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYS0B-0002YO-LG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:36 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hYS0B-0002Xn-HK
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:14:35 -0400
Received: by mail-qt1-x844.google.com with SMTP id a15so2625915qtn.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=FtFtsU6U88IN5RpKuHv7yxObRlS0Xu7LoarH7nGrYVs=;
	b=JEWHoCvY9yXc0Xi13Mn3He9FnBX9/6diJoLCXGVy3CqcAdUZ8KZbNrrtRzG0Oh8CaH
	JcF/dbpkPs9LxrcdRc0K0nVjf7w0AURtwOABf+HyJsRq7/h6saBGP3D+h0oQoCpHvAsj
	oju+Q84YjUH850lTaVwvGW0r46j060GwMoVwbf1e/4rKlOn5pfpms43swOrBwXifsyZR
	VA6kobPcTeBd7gsUTvHfzDY2nkcHClxmt8AuF0mBxriH1yDuVta3dhnXOkCVFM9rQIGY
	0H9c6KhyDSkafhl707Oxgw0JTN0OMUoKRNRk3B+ektyQSiXZUlsSQ6EhWRmxSwoiZrcS
	d9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=FtFtsU6U88IN5RpKuHv7yxObRlS0Xu7LoarH7nGrYVs=;
	b=jPwU2yyyrApp4lT5vq31JKr6771XbJ3BWDBKpdRaRLHlKxv2CvRfNPgA0YoYxjVYi3
	+R9Qh7WUb+rXzsotzExpZqTfomrUNDyHvI+G7O8O9zs45bxDSY5o/toGdXMPOK7L++ok
	BpXcuMAUk9W4cXzyGu9ou2f2PNcTyj5yZgUCsA7OdB0cy5YaPK1x3tALUhd1IcBM32li
	7C4WtDtTF75V5kM+/H4+hst3/fQnfwVL4J4M7Tx/3Xw1FXhsm2cPqTSyf8hpyYb3V0Dn
	z+6ptnqN/kr6DYakcD80k9scQhtcicUTyjIfOezheD2llH9mTgdjwuf960vBRYTUDqmo
	p9iw==
X-Gm-Message-State: APjAAAUFRC0QOglYJc5OCbN2Ss4nxXa2wHvpczYGHb/YyYhkxzSr3JNh
	4nHYQyvtvHQnT2GKry/ao9BChRerVCfVmIoxRnc=
X-Google-Smtp-Source: APXvYqzBb9PNf+PGFNSsXOjXenvHEFm3pg+sFGIIxZ8Y7QMId7b5GZ0aRsDclAxDU0dkPoTFJBs8gvNMunaJYp/KT0o=
X-Received: by 2002:ac8:30c4:: with SMTP id w4mr32412034qta.314.1559726074899; 
	Wed, 05 Jun 2019 02:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-6-xieyongji@baidu.com>
	<20190605105951.21c838a7@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190605105951.21c838a7@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 5 Jun 2019 17:14:23 +0800
Message-ID: <CAONzpcafmhw9-OPL=fqrcJFWfc5Bo65ZdxpRUuvZU0OgXwXp1g@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 5/5] virtio: add "use-started" property
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 17:00, Greg Kurz <groug@kaod.org> wrote:
>
> On Tue,  4 Jun 2019 15:34:59 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > In order to avoid migration issues, we introduce a "use-started"
> > property to the base virtio device to indicate whether use
> > "started" flag or not. This property will be true by default and
> > set to false when machine type <= 4.0.1.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
> >  hw/block/vhost-user-blk.c  |  4 ++--
> >  hw/core/machine.c          |  4 +++-
> >  hw/virtio/virtio.c         | 21 ++++++++-------------
> >  include/hw/virtio/virtio.h | 21 +++++++++++++++++++++
> >  4 files changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9cb61336a6..85bc4017e7 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -191,7 +191,7 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >  static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > -    bool should_start = vdev->started;
> > +    bool should_start = virtio_device_started(vdev, status);
> >      int ret;
> >
> >      if (!vdev->vm_running) {
> > @@ -317,7 +317,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
> >      }
> >
> >      /* restore vhost state */
> > -    if (vdev->started) {
> > +    if (virtio_device_started(vdev, vdev->status)) {
> >          ret = vhost_user_blk_start(vdev);
> >          if (ret < 0) {
> >              error_report("vhost-user-blk: vhost start failed: %s",
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index f1a0f45f9c..133c113ebf 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -24,7 +24,9 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/mem/nvdimm.h"
> >
> > -GlobalProperty hw_compat_4_0_1[] = {};
> > +GlobalProperty hw_compat_4_0_1[] = {
> > +    { "virtio-device", "use-started", "false" },
> > +};
> >  const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
>
> I'm discovering hw_compat_4_0_1, which seems to be only used by the
> pc-q35-4.0.1 machine type...
>

Oops, my mistake.

> >
> >  GlobalProperty hw_compat_4_0[] = {};
>
> Not sure if it's the way to go but the same line should at least be added
> here for all other machine types that use hw_compat_4_0[] eg. pseries-4.0
> and older, which are the ones I need this fix for.
>

I agree.

> Cc'ing core machine code maintainers for advice.
>
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 3960619bd4..9af2e339af 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1165,10 +1165,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
> >
> >      if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
> >          (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > -        vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> > -        if (unlikely(vdev->start_on_kick && vdev->started)) {
> > -            vdev->start_on_kick = false;
> > -        }
> > +        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>
> virtio_set_started() takes a bool as second argument, so this should
> rather be !!(val & VIRTIO_CONFIG_S_DRIVER_OK) to avoid potential
> warnings from picky compilers.
>

Will fix it in v3.

> The rest looks good, but I'm wondering if this patch should be the first
> one in the series to narrow the range of commits where backward migration
> is broken.
>

It's OK to me.

Thanks,
Yongji

