Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E778DC04AB5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2CD25918
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOj/LdeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2CD25918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44181 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXzLL-0005cz-HF
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 22:38:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXzKM-0005E3-QD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXzKL-0000Xd-93
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:37:30 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hXzKK-0000Un-Uu
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:37:29 -0400
Received: by mail-qt1-x842.google.com with SMTP id z19so11984692qtz.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 19:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1L0sp2Y+cVN3gQD1eluHazIlI23CSczA94AErtou1R8=;
	b=YOj/LdeZkYDJnpYrhESdDiCoZ5vbifEIN9Vr064fXdfZvZA4ZQjYsPH/yZVgtjPrnO
	3UMLK1G7rFy0QzMVr97DlzWHcXd/mv1VDwMmzEY+kTEvP9fBPEkwcoeAyVmBYzfjo98u
	Z+a6cvpFt0yVrb1TYkYv29g5RXFotGcotu4BHbLv8jZQj6Es8iUOtPd12oM/yNFhYy/R
	1Q5FEgt23m8fd24VSS5SrxhkWSAEZsNo6aiNvRA04QTcCurf/Gd9IaDlr5jt08SrKmmF
	tXsomUb30KJq/wXdDEZFoAMWH4bd24YfWZU5wbuxGbZ1317JfvtS3Ewcf5ZhvKehkyzv
	sdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1L0sp2Y+cVN3gQD1eluHazIlI23CSczA94AErtou1R8=;
	b=owgFG1tSanNO3DubIOz6GvFv+iE23b1WB8P2zBgfpl4yQYZOq4t6rJa8+9y4s6H7Xa
	W6CaZvtVkmhF1cYpClofVQY/CD17gEctdlYOd8E5HgWrk7Bjt1pE3zB8AaS++iLgAL1I
	z7EbId/pc6zc7h82SPRq0eUSCufOmXrMgwtS0zcZGx+WPoDZG0IqETrYLh5rWI2OgCwA
	W67tzyOoEb8qjVOTH0G5pLVjyWsmDvokE7p4E3n8jTIU0EGeyeEQoS+6Q00tnBL1rjCU
	yo/dzwwzVjJxCqhXEU2b8ufyNki/xXMwRtCHfZL1RdcsGW+5kl56lUSKljSL5HUx72i7
	7p/A==
X-Gm-Message-State: APjAAAVSUt96w9E3IrEc2w3qUC+eQMGbnZUZm1C7BRDg70eHU5Fc+8qa
	PM7VA0MabdHI/wjrbJx0K+OcTocc+dVMDFtoO60=
X-Google-Smtp-Source: APXvYqyvHE4oL6Il/eBU2vEwxmPua86zbvPVZDviqjX7m40onDeVZdqSLnyJrzgAmqeIC0zr8h4McOMjjt2vfwgJEHw=
X-Received: by 2002:aed:3e86:: with SMTP id n6mr9430771qtf.315.1559615847841; 
	Mon, 03 Jun 2019 19:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-6-xieyongji@baidu.com>
	<20190603224930.4f3c14fe@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190603224930.4f3c14fe@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 4 Jun 2019 10:37:15 +0800
Message-ID: <CAONzpcY09TNKNnni0pDK044UGPTCKA5PO-S6b4wL291rU2Gs8A@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH 5/5] virtio: add "use-started" property
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Xie Yongji <xieyongji@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 04:49, Greg Kurz <groug@kaod.org> wrote:
>
> On Wed, 29 May 2019 15:09:55 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > In order to avoid migration issues, we introduce a "use-started"
> > property to the base virtio device to indicate whether "started"
> > and "start_on_kick" flag could be used. This property will be
> > true by default and set to false when machine type <= 4.0.
> >
> > Suggested-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
> >  hw/block/vhost-user-blk.c  |  8 ++++++--
> >  hw/core/machine.c          |  4 +++-
> >  hw/virtio/virtio.c         |  7 ++++---
> >  include/hw/virtio/virtio.h | 10 ++++++++++
> >  4 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 9cb61336a6..520c5d3d4b 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -191,9 +191,13 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >  static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > -    bool should_start = vdev->started;
> > +    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
>
> I guess you need the above because the set_status callback is called
> before setting vdev->status, and virtio_device_started() thus doesn't
> return the expected result for older machine types ?
>

Yes, that's case.

> What about adding a status argument to virtio_device_started() ?
>
>     bool should_start = virtio_device_started(vdev, status);
>

Looks fine to me.

> >      int ret;
> >
> > +    if (virtio_device_started(vdev)) {
> > +        should_start = true;
> > +    }
> > +
> >      if (!vdev->vm_running) {
> >          should_start = false;
> >      }
> > @@ -317,7 +321,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
> >      }
> >
> >      /* restore vhost state */
> > -    if (vdev->started) {
> > +    if (virtio_device_started(vdev)) {
>
>     if (virtio_device_started(vdev, vdev->status)) {
>
> and so on...
>
> >          ret = vhost_user_blk_start(vdev);
> >          if (ret < 0) {
> >              error_report("vhost-user-blk: vhost start failed: %s",
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 934c1bcceb..1730d28c1b 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -24,7 +24,9 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/mem/nvdimm.h"
> >
> > -GlobalProperty hw_compat_4_0[] = {};
> > +GlobalProperty hw_compat_4_0[] = {
> > +    { "virtio-device", "use-started", "false" },
> > +};
> >  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
> >
> >  GlobalProperty hw_compat_3_1[] = {
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 9e17293d46..4c05a9efe3 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1803,14 +1803,14 @@ static bool virtio_started_needed(void *opaque)
> >  {
> >      VirtIODevice *vdev = opaque;
> >
> > -    return vdev->started;
> > +    return vdev->started && vdev->use_started;
>
> Hmm... the idea is that vdev->started should never be set when
> "use-started" is "off". Instead of checking vdev->use_started
> here, you should rather assign it to vdev->started everywhere
> you currently assign true.
>

Will do it in v2.

Thanks,
Yongji

