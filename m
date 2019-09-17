Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD8921852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD8921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9nY-0002ZM-GK
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iA9gI-0003Wc-NL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iA9gH-0005GO-CO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:21:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iA9gH-0005Fn-4O
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:21:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C837C4627A
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:21:51 +0000 (UTC)
Received: from work-vm (ovpn-116-53.ams2.redhat.com [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB97B5D6B2;
 Tue, 17 Sep 2019 09:21:43 +0000 (UTC)
Date: Tue, 17 Sep 2019 10:21:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190917092141.GA3371@work-vm>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
 <20190818065944-mutt-send-email-mst@kernel.org>
 <20190821191118.GN3309@work-vm>
 <20190822085237.GA20491@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822085237.GA20491@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 17 Sep 2019 09:21:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: add vhost-user-fs base device
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
Cc: qemu-devel@nongnu.org, vgoyal@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Aug 21, 2019 at 08:11:18PM +0100, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Fri, Aug 16, 2019 at 03:33:20PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > > +static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > > > +{
> > > > +    /* Do nothing */
> > > 
> > > Why is this safe?  Is this because this never triggers?  assert(0) then?
> > > If it triggers then backend won't be notified, which might
> > > cause it to get stuck.
> > 
> > We never process these queues in qemu - always in the guest; so am I
> > correct in thinking those shouldn't be used?
> 
> s/guest/vhost-user backend process/
> 
> vuf_handle_output() should never be called.

It turns out it does get called in one case during cleanup, in the case
where the daemon died before qemu,  virtio_bus_cleanup_host_notifier goes
around the notifiers and calls all the ones where there's anything left
in the eventfd.

Dave

> > > > +}
> > > > +
> > > > +static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
> > > > +                                            bool mask)
> > > > +{
> > > > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > > > +
> > > > +    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
> > > > +}
> > > > +
> > > > +static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
> > > > +{
> > > > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > > > +
> > > > +    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
> > > > +}
> > > > +
> > > > +static void vuf_device_realize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > > +    VHostUserFS *fs = VHOST_USER_FS(dev);
> > > > +    unsigned int i;
> > > > +    size_t len;
> > > > +    int ret;
> > > > +
> > > > +    if (!fs->conf.chardev.chr) {
> > > > +        error_setg(errp, "missing chardev");
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!fs->conf.tag) {
> > > > +        error_setg(errp, "missing tag property");
> > > > +        return;
> > > > +    }
> > > > +    len = strlen(fs->conf.tag);
> > > > +    if (len == 0) {
> > > > +        error_setg(errp, "tag property cannot be empty");
> > > > +        return;
> > > > +    }
> > > > +    if (len > sizeof_field(struct virtio_fs_config, tag)) {
> > > > +        error_setg(errp, "tag property must be %zu bytes or less",
> > > > +                   sizeof_field(struct virtio_fs_config, tag));
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (fs->conf.num_queues == 0) {
> > > > +        error_setg(errp, "num-queues property must be larger than 0");
> > > > +        return;
> > > > +    }
> > > 
> > > The strange thing is that actual # of queues is this number + 2.
> > > And this affects an optimal number of vectors (see patch 2).
> > > Not sure what a good solution is - include the
> > > mandatory queues in the number?
> > > Needs to be documented in some way.
> > 
> > Should we be doing nvectors the same way virtio-scsi-pci does it;
> > with a magic 'unspecified' default where it sets the nvectors based on
> > the number of queues?
> > 
> > I think my preference is not to show the users the mandatory queues.
> 
> I agree.  Users want to control multiqueue, not on the absolute number
> of virtqueues including mandatory queues.
> 
> > > > +
> > > > +    if (!is_power_of_2(fs->conf.queue_size)) {
> > > > +        error_setg(errp, "queue-size property must be a power of 2");
> > > > +        return;
> > > > +    }
> > > 
> > > Hmm packed ring allows non power of 2 ...
> > > We need to look into a generic helper to support VQ
> > > size checks.
> > 
> > Which would also have to include the negotiation of where it's doing
> > packaged ring?
> 
> It's impossible to perform this check at .realize() time since the
> packed virtqueue layout is negotiated via a VIRTIO feature bit.  This
> puts us in the awkward position of either failing when the guest has
> already booted or rounding up the queue size for split ring layouts
> (with a warning message?).


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

