Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE977C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65F7233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65F7233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jGT-0003vm-2M
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0jFf-0003BC-Ar
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0jFe-0004Lm-3U
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1i0jFd-0004LF-SD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:19:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C17E85545
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:19:24 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F21F75888;
 Thu, 22 Aug 2019 09:19:18 +0000 (UTC)
Date: Thu, 22 Aug 2019 11:19:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190822111916.735fd3ce.cohuck@redhat.com>
In-Reply-To: <20190822085237.GA20491@stefanha-x1.localdomain>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
 <20190818065944-mutt-send-email-mst@kernel.org>
 <20190821191118.GN3309@work-vm>
 <20190822085237.GA20491@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 09:19:24 +0000 (UTC)
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 09:52:37 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, Aug 21, 2019 at 08:11:18PM +0100, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:  
> > > On Fri, Aug 16, 2019 at 03:33:20PM +0100, Dr. David Alan Gilbert (git) wrote:  

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

I agree as well, but let me advocate again for renaming this to
'num_request_queues' or similar to make it more obvious what this number
actually means.

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

I fear that is always going to be awkward if you allow to specify the
queue size via a property. Basically, you can do two things: fail to
accept FEATURES_OK if the queue size is not a power of 2 and the guest
did not negotiate packed ring, or disallow to set a non power of 2
value here, which is what the other devices with such a property
currently do (see also my other mail.) Would probably be good if all
devices used the same approach (when we introduced packed ring support.)

