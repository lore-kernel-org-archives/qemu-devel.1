Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C156C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5E220673
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5E220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyF6-0003AO-5u
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:03:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVyDs-0002Lg-9c
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVyDq-0003J0-Qe
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:02:28 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hVyDq-0003HL-LW
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:02:26 -0400
Received: from player794.ha.ovh.net (unknown [10.108.57.53])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5B0B612FB41
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 15:02:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player794.ha.ovh.net (Postfix) with ESMTPSA id 31EF5648F690;
	Wed, 29 May 2019 13:02:14 +0000 (UTC)
Date: Wed, 29 May 2019 15:02:13 +0200
From: Greg Kurz <groug@kaod.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190529150213.51143f1c@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190529123818.GG2882@work-vm>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<20190528000854.GA11618@umbus.fritz.box>
	<20190528083909.65ba8be4@bahia.lan> <20190529111849.GD2882@work-vm>
	<20190529135434.34c46b39@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190529123818.GG2882@work-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9429974671723829554
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddvjedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.146
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
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Xie Yongji <xieyongji@baidu.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 13:38:19 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Greg Kurz (groug@kaod.org) wrote:
> > On Wed, 29 May 2019 12:18:50 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Greg Kurz (groug@kaod.org) wrote:  
> > > > On Tue, 28 May 2019 10:08:54 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >     
> > > > > On Fri, May 24, 2019 at 12:19:09PM +0200, Greg Kurz wrote:    
> > > > > > On Mon, 20 May 2019 19:10:35 -0400
> > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > >       
> > > > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > > > > 
> > > > > > > The virtio 1.0 transitional devices support driver uses the device
> > > > > > > before setting the DRIVER_OK status bit. So we introduce a started
> > > > > > > flag to indicate whether driver has started the device or not.
> > > > > > > 
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > > > > > Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> > > > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > ---
> > > > > > >  include/hw/virtio/virtio.h |  2 ++
> > > > > > >  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
> > > > > > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > > > > index 7140381e3a..27c0efc3d0 100644
> > > > > > > --- a/include/hw/virtio/virtio.h
> > > > > > > +++ b/include/hw/virtio/virtio.h
> > > > > > > @@ -105,6 +105,8 @@ struct VirtIODevice
> > > > > > >      uint16_t device_id;
> > > > > > >      bool vm_running;
> > > > > > >      bool broken; /* device in invalid state, needs reset */
> > > > > > > +    bool started;
> > > > > > > +    bool start_on_kick; /* virtio 1.0 transitional devices support that */
> > > > > > >      VMChangeStateEntry *vmstate;
> > > > > > >      char *bus_name;
> > > > > > >      uint8_t device_endian;
> > > > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > > > index 28056a7ef7..5d533ac74e 100644
> > > > > > > --- a/hw/virtio/virtio.c
> > > > > > > +++ b/hw/virtio/virtio.c
> > > > > > > @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
> > > > > > >              }
> > > > > > >          }
> > > > > > >      }
> > > > > > > +    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
> > > > > > > +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> > > > > > > +        vdev->start_on_kick = false;
> > > > > > > +    }
> > > > > > > +
> > > > > > >      if (k->set_status) {
> > > > > > >          k->set_status(vdev, val);
> > > > > > >      }
> > > > > > >      vdev->status = val;
> > > > > > > +
> > > > > > >      return 0;
> > > > > > >  }
> > > > > > >  
> > > > > > > @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
> > > > > > >          k->reset(vdev);
> > > > > > >      }
> > > > > > >  
> > > > > > > +    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> > > > > > > +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
> > > > > > > +    vdev->started = false;
> > > > > > >      vdev->broken = false;
> > > > > > >      vdev->guest_features = 0;
> > > > > > >      vdev->queue_sel = 0;
> > > > > > > @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
> > > > > > >  
> > > > > > >  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
> > > > > > >  {
> > > > > > > +    bool ret = false;
> > > > > > > +
> > > > > > >      if (vq->vring.desc && vq->handle_aio_output) {
> > > > > > >          VirtIODevice *vdev = vq->vdev;
> > > > > > >  
> > > > > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > > > > > -        return vq->handle_aio_output(vdev, vq);
> > > > > > > +        ret = vq->handle_aio_output(vdev, vq);
> > > > > > > +
> > > > > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > > > > +            vdev->started = true;
> > > > > > > +            vdev->start_on_kick = false;
> > > > > > > +        }
> > > > > > >      }
> > > > > > >  
> > > > > > > -    return false;
> > > > > > > +    return ret;
> > > > > > >  }
> > > > > > >  
> > > > > > >  static void virtio_queue_notify_vq(VirtQueue *vq)
> > > > > > > @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> > > > > > >  
> > > > > > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > > > > >          vq->handle_output(vdev, vq);
> > > > > > > +
> > > > > > > +        if (unlikely(vdev->start_on_kick)) {
> > > > > > > +            vdev->started = true;
> > > > > > > +            vdev->start_on_kick = false;
> > > > > > > +        }
> > > > > > >      }
> > > > > > >  }
> > > > > > >  
> > > > > > > @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
> > > > > > >      } else if (vq->handle_output) {
> > > > > > >          vq->handle_output(vdev, vq);
> > > > > > >      }
> > > > > > > +
> > > > > > > +    if (unlikely(vdev->start_on_kick)) {
> > > > > > > +        vdev->started = true;
> > > > > > > +        vdev->start_on_kick = false;
> > > > > > > +    }
> > > > > > >  }
> > > > > > >  
> > > > > > >  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> > > > > > > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> > > > > > >      return vdev->broken;
> > > > > > >  }
> > > > > > >  
> > > > > > > +static bool virtio_started_needed(void *opaque)
> > > > > > > +{
> > > > > > > +    VirtIODevice *vdev = opaque;
> > > > > > > +
> > > > > > > +    return vdev->started;      
> > > > > > 
> > > > > > Existing machine types don't know about the "virtio/started" subsection. This
> > > > > > breaks migration to older QEMUs if the driver has started the device, ie. most
> > > > > > probably always when it comes to live migration.
> > > > > > 
> > > > > > My understanding is that we do try to support backward migration though. It
> > > > > > is a regular practice in datacenters to migrate workloads without having to
> > > > > > take care of the QEMU version. FWIW I had to fix similar issues downstream
> > > > > > many times in the past because customers had filed bugs.
> > > > > > 
> > > > > > Cc'ing David for his opinion.      
> > > > > 
> > > > > Uh.. did you mean to CC me, or Dave Gilbert?
> > > > >     
> > > > 
> > > > Oops... Dave Gilbert indeed, but you're thoughts on that matter are valuable
> > > > as well. I remember being involved in backward migration fixes for spapr
> > > > several times.
> > > >     
> > > > > I mean, I think you're right that we should try to maintain backwards
> > > > > migration, but this isn't really my area of authority.
> > > > >     
> > > > 
> > > > Cc'ing Dave Gilbert :)    
> > > 
> > > Right, I need to maintain backwards migration compatibility; tie the
> > > feature to a machine type so it's only used on newer machine types and
> > > then we'll be safe.
> > > 
> > > Having said that, what's the symptom when this goes wrong?
> > >   
> > 
> > Since the started flag is set as soon as the guest driver begins to use
> > the device and remains so until next reset, the associated subsection is
> > basically always emitted when migrating a booted guest. This causes
> > migration to always fail on the target in this case:  
> 
> I meant what's the symptom without this patch series at all?
> 

Oh sorry... if I got it right, migrating when the guest first kicked the
device but not set the DRIVE_OK bit yet would result in a guest hang on
the destination. Yongji might elaborate a bit more on that.

> Dave
> 
> > qemu-system-ppc64: Failed to load virtio-net:virtio
> > qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:00.0/virtio-net'
> > qemu-system-ppc64: load of migration failed: No such file or directory
> > 
> > Xie Yongji has just sent a series to fix that, with you in Cc:
> > 
> > Cheers,
> > 
> > --
> > Greg
> >   
> > > Dave
> > >   
> > > > Cheers,
> > > > 
> > > > --
> > > > Greg    
> > > 
> > > 
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK  
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


