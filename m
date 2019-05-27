Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F3C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7919A20859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919A20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKlx-0000eC-Nb
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:55:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVKl1-00008w-5F
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVKkz-0007Kp-Tw
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:54:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVKkz-0007KZ-OX
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:54:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id x184so11188314vsb.5
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 11:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=jLqJrZ1kGnTm02CoiD7AygtwzxcwPdrmbjKROwiR2C4=;
	b=i5iOM65cteskc7ARvzCP1uAZ+x9sAHnen4ay49TEAkCo+xQbFfM+tvhzvyiHk7g+Jk
	TnuwTgR5v5FadVaZ5l7Y/lgfDbaeRtln3jPTlD511NajKY9eRiWNqold+CA2iFQ0+ZCT
	LEenzebzpNcrKMSb55w18bhusNJfrmEWky+iKkFv+9SFXbemQaazq95zaBjg1Zvn8Cey
	v6K5JAYxRZeiHff/Mwl286rkRH+ocvuD8Agmhqg8+3a0PlV1WcG21vAk07Xs+ySJ0qEq
	jwCHnifTjAwTyk5ub2Axr2XpIEgahm9okhBNBF+8dlOfKc6r338Mx3vYPO4b90eamQQ/
	lB3w==
X-Gm-Message-State: APjAAAX6XQgvz7HoY8SZ+dbMVRZij3jFiZhtzw8wv7dYRMhHvJgU0osY
	EJjd0MyWE/qcDqRyqG0FW+nYwQ==
X-Google-Smtp-Source: APXvYqzubuAXxUuROdoWw+4YbfZ2U71yM2M93TEHGaog5BemOXWLY9D7yjfYRKS/p1M1pEzEpFnBJw==
X-Received: by 2002:a67:be18:: with SMTP id x24mr62411066vsq.66.1558983241045; 
	Mon, 27 May 2019 11:54:01 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	u11sm1922017vsl.29.2019.05.27.11.53.59
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 27 May 2019 11:53:59 -0700 (PDT)
Date: Mon, 27 May 2019 14:53:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190527145329-mutt-send-email-mst@kernel.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
	<20190527124446.6b809c7f@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527124446.6b809c7f@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.217.67
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
	qemu-devel <qemu-devel@nongnu.org>, Yongji Xie <elohimes@gmail.com>,
	Xie Yongji <xieyongji@baidu.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 12:44:46PM +0200, Greg Kurz wrote:
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
> > Not sure if there is a more general approach...
> > 
> 
> Another approach would be to only implement the started flag for
> machine version > 4.0. This can be achieved by adding a "use-started"
> property to the base virtio device, true by default and set to
> false by hw_compat_4_0.

I think this is best frankly.


> > Thanks,
> > Yongji

