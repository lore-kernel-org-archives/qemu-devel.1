Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86388C04AB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 02:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417F920675
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 02:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/YugryV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417F920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVSBz-0007nx-HM
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 22:50:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVSA3-0006pk-TR
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVSA2-0008Ih-LN
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:48:23 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVSA2-0008IL-Fj
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:48:22 -0400
Received: by mail-qk1-x743.google.com with SMTP id p18so20319672qkk.0
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=B0pGofklvxLkgUuukQFjRZJQn7Ab8/PnpJ0jFN26r1Q=;
	b=R/YugryVHw//QXQC8tl7Hij1kUk688ePULIQAyqH9FaQOaby4R4K9XAHa0YcC3qU62
	tZj54p04QC9Pidzh+bAJDJpt3u42z7OstQ1hKEPO/SL9M9/uzBrkuXdOZZMW7dUddT/E
	c6Q89QVukWglS6yoianI3jMBPkBT9YEKU26G3rvI2MH2F8zIrFQvuI9xSgsG6/zlNA+G
	dwSKkYQeEKpRlOTvpTS8yqqcOxUVpJknou7sgEQOs5JroFyDMHa+e6vQx7lIefOXAyax
	sH8+Gqq89yZU583Pft2VHpWmsufRCU63FX0lTM9pZmSLkH3UFY3wV28ygQEwNXH9R+yW
	F/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=B0pGofklvxLkgUuukQFjRZJQn7Ab8/PnpJ0jFN26r1Q=;
	b=C3tjYiHa+kReOG74fbHt1zyCvlde0DJGbOVZk3oTqR3GDEES8sP/YmnEKC8a2u20FM
	3cUu97P1n5k5bDKc74jxyVJSvUcJx9Ph0PkWnST6D8JDKDlo8hL5Loi7T5duwkPee+wr
	41DVnOjJUFcjDEyFCF52gDA8aK2gQEPXXsj2FbD2heayz0FWdZSyrAUBZqD5dwbC3cuU
	l+mb/rTkpmT0WkruIU2kRfhPKsJcZXzgHetaOwQk35YVfLfw7YIm6X9wCkakjVQtIzfA
	dtxc1yqMAeDin228/PmJ3mUGc/944d2ez9jQw2zagrRlz+Ud2h5Cf5BnMzkdFPgYwIsI
	Hlzg==
X-Gm-Message-State: APjAAAUSeQuthkdTMHmt+YfWNkFWeK81sZiZ4TJ3UGtXdXXq/1aGeVCs
	IoznedoQHb7rssondOYtnTsMIYP2OXOhzTf7oxY=
X-Google-Smtp-Source: APXvYqz23hKWQf0R43bTmJT3K0tvolFpBUv7oryTj/7MCMWETxdP8T9LKNmCvlLR3gvrGyjVcwIsebGhPj989htf+Ck=
X-Received: by 2002:a0c:b59c:: with SMTP id g28mr35672231qve.171.1559011701609;
	Mon, 27 May 2019 19:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
	<20190527124446.6b809c7f@bahia.lan>
	<20190527145329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190527145329-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 28 May 2019 10:48:09 +0800
Message-ID: <CAONzpcb6dtsnYhVW+yy0FijXtHoLavXX_bwStVEZC1hqJr9wSQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
	qemu-devel <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
	Xie Yongji <xieyongji@baidu.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 02:54, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 27, 2019 at 12:44:46PM +0200, Greg Kurz wrote:
> > On Fri, 24 May 2019 19:56:06 +0800
> > Yongji Xie <elohimes@gmail.com> wrote:
> >
> > > On Fri, 24 May 2019 at 18:20, Greg Kurz <groug@kaod.org> wrote:
> > > >
> > > > On Mon, 20 May 2019 19:10:35 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > >
> > > > > The virtio 1.0 transitional devices support driver uses the device
> > > > > before setting the DRIVER_OK status bit. So we introduce a started
> > > > > flag to indicate whether driver has started the device or not.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > > > Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  include/hw/virtio/virtio.h |  2 ++
> > > > >  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
> > > > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > > index 7140381e3a..27c0efc3d0 100644
> > > > > --- a/include/hw/virtio/virtio.h
> > > > > +++ b/include/hw/virtio/virtio.h
> > > > > @@ -105,6 +105,8 @@ struct VirtIODevice
> > > > >      uint16_t device_id;
> > > > >      bool vm_running;
> > > > >      bool broken; /* device in invalid state, needs reset */
> > > > > +    bool started;
> > > > > +    bool start_on_kick; /* virtio 1.0 transitional devices support that */
> > > > >      VMChangeStateEntry *vmstate;
> > > > >      char *bus_name;
> > > > >      uint8_t device_endian;
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index 28056a7ef7..5d533ac74e 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
> > > > >              }
> > > > >          }
> > > > >      }
> > > > > +    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> > > > > +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> > > > > +        vdev->start_on_kick = false;
> > > > > +    }
> > > > > +
> > > > >      if (k->set_status) {
> > > > >          k->set_status(vdev, val);
> > > > >      }
> > > > >      vdev->status = val;
> > > > > +
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
> > > > >          k->reset(vdev);
> > > > >      }
> > > > >
> > > > > +    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> > > > > +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> > > > > +    vdev->started = false;
> > > > >      vdev->broken = false;
> > > > >      vdev->guest_features = 0;
> > > > >      vdev->queue_sel = 0;
> > > > > @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
> > > > >
> > > > >  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
> > > > >  {
> > > > > +    bool ret = false;
> > > > > +
> > > > >      if (vq->vring.desc && vq->handle_aio_output) {
> > > > >          VirtIODevice *vdev = vq->vdev;
> > > > >
> > > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > > > -        return vq->handle_aio_output(vdev, vq);
> > > > > +        ret = vq->handle_aio_output(vdev, vq);
> > > > > +
> > > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > > +            vdev->started = true;
> > > > > +            vdev->start_on_kick = false;
> > > > > +        }
> > > > >      }
> > > > >
> > > > > -    return false;
> > > > > +    return ret;
> > > > >  }
> > > > >
> > > > >  static void virtio_queue_notify_vq(VirtQueue *vq)
> > > > > @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> > > > >
> > > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > > >          vq->handle_output(vdev, vq);
> > > > > +
> > > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > > +            vdev->started = true;
> > > > > +            vdev->start_on_kick = false;
> > > > > +        }
> > > > >      }
> > > > >  }
> > > > >
> > > > > @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
> > > > >      } else if (vq->handle_output) {
> > > > >          vq->handle_output(vdev, vq);
> > > > >      }
> > > > > +
> > > > > +    if (unlikely(vdev->start_on_kick)) {
> > > > > +        vdev->started = true;
> > > > > +        vdev->start_on_kick = false;
> > > > > +    }
> > > > >  }
> > > > >
> > > > >  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> > > > > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> > > > >      return vdev->broken;
> > > > >  }
> > > > >
> > > > > +static bool virtio_started_needed(void *opaque)
> > > > > +{
> > > > > +    VirtIODevice *vdev = opaque;
> > > > > +
> > > > > +    return vdev->started;
> > > >
> > > > Existing machine types don't know about the "virtio/started" subsection. This
> > > > breaks migration to older QEMUs if the driver has started the device, ie. most
> > > > probably always when it comes to live migration.
> > > >
> > > > My understanding is that we do try to support backward migration though. It
> > > > is a regular practice in datacenters to migrate workloads without having to
> > > > take care of the QEMU version. FWIW I had to fix similar issues downstream
> > > > many times in the past because customers had filed bugs.
> > > >
> > >
> > > If we do need to support backward migration, for this patch, what I
> > > can think of is to only migrate the flag in the case that guest kicks
> > > but not set DRIVER_OK. This could fix backward migration in most case.
> >
> > You mean something like that ?
> >
> > static bool virtio_started_needed(void *opaque)
> > {
> >     VirtIODevice *vdev = opaque;
> >
> >     return vdev->started && !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
> > }
> >
> > > Not sure if there is a more general approach...
> > >
> >
> > Another approach would be to only implement the started flag for
> > machine version > 4.0. This can be achieved by adding a "use-started"
> > property to the base virtio device, true by default and set to
> > false by hw_compat_4_0.
>
> I think this is best frankly.
>

Only implement the started flag for machine version > 4.0 might not be
good because vhost-user-blk now need to use this flag. How about only
migrating this flag for machine version > 4.0 instead?

Thanks,
Yongji

