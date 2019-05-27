Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FDC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359C220859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpii0h0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359C220859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFK3-0008UR-5r
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVFJ9-00086S-UR
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVFJ7-0002QZ-Vp
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:04:55 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVFJ7-0002Or-SD
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:04:53 -0400
Received: by mail-qk1-x742.google.com with SMTP id i125so15610808qkd.6
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sYrbdPaFZQeW8bu0p+SAc2lsKK8dNsc5lRW5gpBl0oI=;
	b=qpii0h0Fw1WxKEA3wc+xAdOzlpvv1DIlXsqYLo+qataqRP6fvAP0SD9k/LAZiVkXe2
	CqWYl4bjXY515BrY0bWjZO/fB5cbTcww67Yb1GbyviHglghvm5clEBf7inSFxGwrZvGG
	TAwuhU/043KCDeb6aueVUrhWYOs/6EFvHASJIHvWpw/E56XTbDsWd9bRM5ddrYNGNRSv
	5ZwJhaPEEgSVV0gv25myLSGqbTk0c8BAWDSQT81sN71s60u4wNQT4BgJkBEgs18SPM8Q
	fMxzV/Jz8B8QXwmjwkY6Acio51PNmwyZ/59Jw2leRwwn3pe4cxLTJJQMtLuIe7PxdMJv
	bgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sYrbdPaFZQeW8bu0p+SAc2lsKK8dNsc5lRW5gpBl0oI=;
	b=rSvI8MBP6qOpYXHstOQwjx+wSwmnNw519XzJiq3Z1lffnis9/pDZllJtVALmSxWGMf
	Ltq9qLt4hG7vhQNqxTV78UDxdGdMX2XknGOJJgAclUDhUSgl5NCcxclx2RosAC4h6v3z
	LVKAOdTdKxJVStTtt/8kyKJ/Koi1t+8tZVxAfPZN7GsfLclsCDNq0k939c03Iail5Qi8
	T+4M7K2tuI93oA1Eng1fq77jm54dpmN3B37qmvM7UiMq3VwBSBI6L1IULF+Orlg5PAMB
	KZZS+IFLKsWQuO/weF2kCiynR+kvsX+NcT7wx8Sv/O21gYU18X1YX/wxVyWkLMX9+7Nv
	ToBw==
X-Gm-Message-State: APjAAAUAJ/btk24bdEjCxhYqrc9GKL58CKsjxMl9H6ZANdEb8qaFFL9j
	nE12b5G+U2m1KGO4V2iBRg8noNXo0a0MHWX/zsg6yw==
X-Google-Smtp-Source: APXvYqzgB8lDrkPMy//qrGpzfTEnrFUhcJMZyT2ClbWDVkK3G2CTQsdcV8R1FI3TvZWaYg5QUc+oMnCFhejs3bOt3z8=
X-Received: by 2002:a05:620a:16c1:: with SMTP id
	a1mr3617774qkn.269.1558962290904; 
	Mon, 27 May 2019 06:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
	<20190527124446.6b809c7f@bahia.lan>
In-Reply-To: <20190527124446.6b809c7f@bahia.lan>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 27 May 2019 21:04:38 +0800
Message-ID: <CAONzpcaiPpSqjETGBpYS4pKXBdCXu-JwgKoASrrmMmhDk=GNfQ@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Xie Yongji <xieyongji@baidu.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 May 2019 at 18:44, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 24 May 2019 19:56:06 +0800
> Yongji Xie <elohimes@gmail.com> wrote:
>
> > On Fri, 24 May 2019 at 18:20, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > On Mon, 20 May 2019 19:10:35 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > The virtio 1.0 transitional devices support driver uses the device
> > > > before setting the DRIVER_OK status bit. So we introduce a started
> > > > flag to indicate whether driver has started the device or not.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > > Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  include/hw/virtio/virtio.h |  2 ++
> > > >  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > index 7140381e3a..27c0efc3d0 100644
> > > > --- a/include/hw/virtio/virtio.h
> > > > +++ b/include/hw/virtio/virtio.h
> > > > @@ -105,6 +105,8 @@ struct VirtIODevice
> > > >      uint16_t device_id;
> > > >      bool vm_running;
> > > >      bool broken; /* device in invalid state, needs reset */
> > > > +    bool started;
> > > > +    bool start_on_kick; /* virtio 1.0 transitional devices support that */
> > > >      VMChangeStateEntry *vmstate;
> > > >      char *bus_name;
> > > >      uint8_t device_endian;
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 28056a7ef7..5d533ac74e 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
> > > >              }
> > > >          }
> > > >      }
> > > > +    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> > > > +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> > > > +        vdev->start_on_kick = false;
> > > > +    }
> > > > +
> > > >      if (k->set_status) {
> > > >          k->set_status(vdev, val);
> > > >      }
> > > >      vdev->status = val;
> > > > +
> > > >      return 0;
> > > >  }
> > > >
> > > > @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
> > > >          k->reset(vdev);
> > > >      }
> > > >
> > > > +    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> > > > +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> > > > +    vdev->started = false;
> > > >      vdev->broken = false;
> > > >      vdev->guest_features = 0;
> > > >      vdev->queue_sel = 0;
> > > > @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
> > > >
> > > >  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
> > > >  {
> > > > +    bool ret = false;
> > > > +
> > > >      if (vq->vring.desc && vq->handle_aio_output) {
> > > >          VirtIODevice *vdev = vq->vdev;
> > > >
> > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > > -        return vq->handle_aio_output(vdev, vq);
> > > > +        ret = vq->handle_aio_output(vdev, vq);
> > > > +
> > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > +            vdev->started = true;
> > > > +            vdev->start_on_kick = false;
> > > > +        }
> > > >      }
> > > >
> > > > -    return false;
> > > > +    return ret;
> > > >  }
> > > >
> > > >  static void virtio_queue_notify_vq(VirtQueue *vq)
> > > > @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> > > >
> > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > >          vq->handle_output(vdev, vq);
> > > > +
> > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > +            vdev->started = true;
> > > > +            vdev->start_on_kick = false;
> > > > +        }
> > > >      }
> > > >  }
> > > >
> > > > @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
> > > >      } else if (vq->handle_output) {
> > > >          vq->handle_output(vdev, vq);
> > > >      }
> > > > +
> > > > +    if (unlikely(vdev->start_on_kick)) {
> > > > +        vdev->started = true;
> > > > +        vdev->start_on_kick = false;
> > > > +    }
> > > >  }
> > > >
> > > >  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> > > > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> > > >      return vdev->broken;
> > > >  }
> > > >
> > > > +static bool virtio_started_needed(void *opaque)
> > > > +{
> > > > +    VirtIODevice *vdev = opaque;
> > > > +
> > > > +    return vdev->started;
> > >
> > > Existing machine types don't know about the "virtio/started" subsection. This
> > > breaks migration to older QEMUs if the driver has started the device, ie. most
> > > probably always when it comes to live migration.
> > >
> > > My understanding is that we do try to support backward migration though. It
> > > is a regular practice in datacenters to migrate workloads without having to
> > > take care of the QEMU version. FWIW I had to fix similar issues downstream
> > > many times in the past because customers had filed bugs.
> > >
> >
> > If we do need to support backward migration, for this patch, what I
> > can think of is to only migrate the flag in the case that guest kicks
> > but not set DRIVER_OK. This could fix backward migration in most case.
>
> You mean something like that ?
>
> static bool virtio_started_needed(void *opaque)
> {
>     VirtIODevice *vdev = opaque;
>
>     return vdev->started && !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
> }
>

Yes.

> > Not sure if there is a more general approach...
> >
>
> Another approach would be to only implement the started flag for
> machine version > 4.0. This can be achieved by adding a "use-started"
> property to the base virtio device, true by default and set to
> false by hw_compat_4_0.
>

If so, the problem that I tried to fix in this patch would still be
exist in old machine type, right?

Now I think the first approach may be more reasonable. Blocking a
migration that will cause guest hang instead of allowing that.

Thanks,
Yongji

