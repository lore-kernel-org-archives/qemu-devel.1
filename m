Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA61208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA61208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7iC-0003Qo-Kr
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:34:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT7hB-000340-TQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT7hA-0008Tf-QS
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hT7hA-0008SV-HL; Tue, 21 May 2019 12:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F36B581F0F;
	Tue, 21 May 2019 16:32:46 +0000 (UTC)
Received: from gondolin (ovpn-204-120.brq.redhat.com [10.40.204.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B05D8600CC;
	Tue, 21 May 2019 16:32:39 +0000 (UTC)
Date: Tue, 21 May 2019 18:32:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190521183235.7c3d0b37.cohuck@redhat.com>
In-Reply-To: <f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 21 May 2019 16:32:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 12:29:56 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/7/19 11:47 AM, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/css.c              |  27 +++++++--
> >  hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
> >  include/hw/s390x/s390-ccw.h |   3 +
> >  3 files changed, 134 insertions(+), 6 deletions(-)
> > 

> > +int vfio_ccw_handle_clear(SubchDev *sch)
> > +{
> > +    S390CCWDevice *cdev = sch->driver_data;
> > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
> > +    int ret;
> > +
> > +    if (!vcdev->async_cmd_region) {
> > +        /* Async command region not available, fall back to emulation */
> > +        return -ENOSYS;
> > +    }
> > +
> > +    memset(region, 0, sizeof(*region));
> > +    region->command = VFIO_CCW_ASYNC_CMD_CSCH;  
> 
> Considering the serialization you added on the kernel side, what happens
> if another vcpu runs this code (or _halt) and clears the async region
> before the kernel code gains control from the pwrite() call below?
> Asked another way, there's nothing preventing us from issuing more than
> one asynchronous command concurrently, so how do we make sure the
> command gets to the kernel rather than "current command wins"  ?

This send me digging through the code, because if two threads can call
this at the same time for passthrough, we'd also have the same problem
for virtual.

If I followed the code correctly, all I/O instruction interpretation is
currently serialized via qemu_mutex_{lock,unlock}_iothread() (see
target/s390x/kvm.c respectively target/s390x/misc_helper.c). This
should mostly be enough to avoid stepping on each other's toes.

Why mostly? I'm not sure yet whether we handling multiple requests for
passthrough devices correctly yet (virtual should be fine.)

Start vs. (start|halt|clear) is fine, as the code checks whether
something is already pending before poking the kernel interface.
Likewise, halt vs. (start|halt|clear) is fine, as the code checks for
halt or clear and start and halt use different regions. The problematic
one is clear, as that's something that's always supposed to go through.
Probably fine if clear should always "win", but I need to think some
more about that.

> 
> That possibly worrisome question aside, this seems generally fine.
> 
> 
> > +
> > +again:
> > +    ret = pwrite(vcdev->vdev.fd, region,
> > +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
> > +    if (ret != vcdev->async_cmd_region_size) {
> > +        if (errno == EAGAIN) {
> > +            goto again;
> > +        }
> > +        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
> > +        ret = -errno;
> > +    } else {
> > +        ret = region->ret_code;
> > +    }
> > +    switch (ret) {
> > +    case 0:
> > +    case -ENODEV:
> > +    case -EACCES:
> > +        return 0;
> > +    case -EFAULT:
> > +    default:
> > +        sch_gen_unit_exception(sch);
> > +        css_inject_io_interrupt(sch);
> > +        return 0;
> > +    }
> > +}

