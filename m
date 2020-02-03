Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE0C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98482082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98482082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycMT-0007Az-VL
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1iycKS-0004UX-Tj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1iycKQ-00084P-Pi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:28208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1iycKQ-0007kK-FC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Feb 2020 06:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; d="scan'208";a="403449950"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.50])
 by orsmga005.jf.intel.com with ESMTP; 03 Feb 2020 06:03:43 -0800
Date: Mon, 3 Feb 2020 21:56:47 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20200203135647.GA1263@yangzhon-Virtual>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
 <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
 <20200110061051.GA1626@yangzhon-Virtual>
 <be72c787-50f8-4b63-59bc-d9ac802541b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be72c787-50f8-4b63-59bc-d9ac802541b6@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 05:22:47PM +0100, Paolo Bonzini wrote:
> I have just found this email... sorry for the delay.
> 
> On 10/01/20 07:10, Yang Zhong wrote:
> >> No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk needs
> >> no check in cpu count, vhost-user-blk also doesn't.
> >>
> >> You need to check first if the bug is in QEMU or the vhost-user-blk server.
> >
> >   (1). Seabios issue
> >   In init_virtio_blk() function, which set VIRTIO_CONFIG_S_DRIVER_OK
> >   status to qemu vhost-user-blk device.
> > 
> >   // the related code
> >   ......
> >   status |= VIRTIO_CONFIG_S_DRIVER_OK;
> >   vp_set_status(&vdrive->vp, status);
> >   ......
> > 
> >   I think there is no need for seabios to set VIRTIO_CONFIG_S_DRIVER_OK
> >   status to qemu vhost-user-blk device.
> 
> It does so because it cannot know how it will be used.  It could be used
> by the guest boot loader to load a kernel, for example.  SeaBIOS sets
> DRIVER_OK because it has loaded a driver for the disk; that's exactly
> what DRIVER_OK signals.
> 
  Yes, the virtio_blk driver in seabios is mainly for virtio format
  images. I did not consider this. Thanks Paolo!
  
  Yang
> 
> >     In fact, this time vhost_user_blk_start almost do nothing because
> >     the real guest virtio-blk driver still not started yet. This time,
> >     there is only one vq can be used(this vq should be inited in seabios).
> > 
> >     When the guest virtio-blk driver really start and complet the
> >     probe(), the guest virtio-blk driver will set
> >     VIRTIO_CONFIG_S_DRIVER_OK to vhost-user-blk device again. This
> >     time, this driver will allocate RIGHT queue num according to
> >     MIN(vcpu, num_vqs).
> 
> Doesn't it first reset the status to 0?
> 
  I checked the virtio_blk drivers in seabios and guest kernel, all do
  the reset before driver probe(). thanks!

  Yang

> >     (2). DPDK issue
> >      DPDK does not know the real queue number used by guest virtio-blk
> >      driver and it only know the queue number from vhost-user-blk
> >      commond line. Once the guest virtio-blk driver change the queue
> >      number according to MIN(vcpu, num_vqs), DPDK still use previous
> >      queue number and it think virtio is never ready by
> >      virtio_is_ready() function.
> 
> What is virtio_is_ready()?  The virtio device should not wait for all
> the queues to be set.  A device is ready when it sets DRIVER_OK, and
> that's it.
> 
  In spdk/dpdk/lib/librte_vhost/vhost_user.c
  static int
  virtio_is_ready(struct virtio_net *dev)
  {
      struct vhost_virtqueue *vq;
      uint32_t i;

      if (dev->nr_vring == 0)
          return 0;

      for (i = 0; i < dev->nr_vring; i++) {
          vq = dev->virtqueue[i];

          if (!vq_is_ready(dev, vq))
              return 0;
      }

      RTE_LOG(INFO, VHOST_CONFIG,
          "virtio is now ready for processing.\n");
      return 1;
  }

  static bool
  vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
  {
      bool rings_ok;

      if (!vq)
          return false;

      if (vq_is_packed(dev))
          rings_ok = !!vq->desc_packed;
      else
          rings_ok = vq->desc && vq->avail && vq->used;

      return rings_ok &&
             vq->kickfd != VIRTIO_UNINITIALIZED_EVENTFD &&
             vq->callfd != VIRTIO_UNINITIALIZED_EVENTFD;
  }

  The dev->nr_vring is equal to the queue number set in qemu cmdline, 
  which maybe different with guest virtio_blk driver by MIN(vcpu, num_vqs).
  If like this scenario, the virtio is NEVER ready from
  virtio_is_ready() because DPDK still check the left
  queues(i.e num_vqs-vcpu), which are not initialized by the guest
  driver.
  
  Yang
  
> >      or DPDK can get the real queue number by checking if the vring.desc
> >      is NON-NULL.
> 
> Note that there is no requirement that the driver initializes a
> consecutive number of virtqueues.  It is acceptable for it to initialize
> virtqueues 0, 1 and 57.  It seems like the bug is in DPDK, possibly more
> than one...
> 
  Yes, it seems the bug is in DPDK side. But one strange issue here, the
  virtio_net driver do the same thing to get real num_vqs by MIN(..),
  the DPDK with virtio_net can avoid this kind of issue(Sorry, i did not
  fully dig out the virtio_net and DPDK code and only hope to get the
  best solution to fix this issue). Anyway, i will firstly check this from 
  DPDK side. Thanks for your great help!

  Yang

> Paolo
> 
> >      By the way, vhost SCSI device has the same issue with
> >      vhost-user-blk device. 
> > 
> >      Yang
> > 
> >> Paolo
> > 

