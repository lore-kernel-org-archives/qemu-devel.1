Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E4C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D8520868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D8520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOGM-0006Rc-B3
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:14:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTOFb-00063S-8b
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTOFa-00010D-71
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hTOFZ-0000x7-UI; Wed, 22 May 2019 06:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D099C308FEC0;
	Wed, 22 May 2019 10:13:31 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 625541975E;
	Wed, 22 May 2019 10:13:28 +0000 (UTC)
Date: Wed, 22 May 2019 12:13:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20190522121326.57043035.cohuck@redhat.com>
In-Reply-To: <36b4a7c3-2ff2-b0a1-06b0-59e83a1ff9ce@linux.ibm.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
	<20190521183235.7c3d0b37.cohuck@redhat.com>
	<36b4a7c3-2ff2-b0a1-06b0-59e83a1ff9ce@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 22 May 2019 10:13:31 +0000 (UTC)
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
Cc: Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 16:51:27 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 05/21/2019 12:32 PM, Cornelia Huck wrote:
> > On Mon, 20 May 2019 12:29:56 -0400
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> On 5/7/19 11:47 AM, Cornelia Huck wrote:  
> >>> A vfio-ccw device may provide an async command subregion for
> >>> issuing halt/clear subchannel requests. If it is present, use
> >>> it for sending halt/clear request to the device; if not, fall
> >>> back to emulation (as done today).
> >>>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>   hw/s390x/css.c              |  27 +++++++--
> >>>   hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
> >>>   include/hw/s390x/s390-ccw.h |   3 +
> >>>   3 files changed, 134 insertions(+), 6 deletions(-)
> >>>  
> >   
> >>> +int vfio_ccw_handle_clear(SubchDev *sch)
> >>> +{
> >>> +    S390CCWDevice *cdev = sch->driver_data;
> >>> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> >>> +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
> >>> +    int ret;
> >>> +
> >>> +    if (!vcdev->async_cmd_region) {
> >>> +        /* Async command region not available, fall back to emulation */
> >>> +        return -ENOSYS;
> >>> +    }
> >>> +
> >>> +    memset(region, 0, sizeof(*region));
> >>> +    region->command = VFIO_CCW_ASYNC_CMD_CSCH;  
> >>
> >> Considering the serialization you added on the kernel side, what happens
> >> if another vcpu runs this code (or _halt) and clears the async region
> >> before the kernel code gains control from the pwrite() call below?
> >> Asked another way, there's nothing preventing us from issuing more than
> >> one asynchronous command concurrently, so how do we make sure the
> >> command gets to the kernel rather than "current command wins"  ?  
> > 
> > This send me digging through the code, because if two threads can call
> > this at the same time for passthrough, we'd also have the same problem
> > for virtual.
> > 
> > If I followed the code correctly, all I/O instruction interpretation is
> > currently serialized via qemu_mutex_{lock,unlock}_iothread() (see
> > target/s390x/kvm.c respectively target/s390x/misc_helper.c). This
> > should mostly be enough to avoid stepping on each other's toes.
> > 
> > Why mostly? I'm not sure yet whether we handling multiple requests for
> > passthrough devices correctly yet (virtual should be fine.)  
> 
> 
> But don't virtual and passthrough device end up calling the same 
> ioinst_handle_* functions to interpret the I/O instructions?

Yes, they do.

> 
> As you mentioned all the ioinst_handle_* functions are called with the 
> qemu_mutex held. So I am confused as why virtual devices should be fine 
> and not passthrough? :)

I'm mostly worried about the "wipe the area, then call pwrite()"
sequence. We might wipe too often; but if clear is about hammering
through in any case, this is hopefully fine.

> 
> 
> > 
> > Start vs. (start|halt|clear) is fine, as the code checks whether
> > something is already pending before poking the kernel interface.
> > Likewise, halt vs. (start|halt|clear) is fine, as the code checks for
> > halt or clear and start and halt use different regions. The problematic
> > one is clear, as that's something that's always supposed to go through.
> > Probably fine if clear should always "win", but I need to think some
> > more about that.
> >   
> >>
> >> That possibly worrisome question aside, this seems generally fine.
> >>
> >>  
> >>> +
> >>> +again:
> >>> +    ret = pwrite(vcdev->vdev.fd, region,
> >>> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
> >>> +    if (ret != vcdev->async_cmd_region_size) {
> >>> +        if (errno == EAGAIN) {
> >>> +            goto again;
> >>> +        }
> >>> +        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
> >>> +        ret = -errno;
> >>> +    } else {
> >>> +        ret = region->ret_code;
> >>> +    }
> >>> +    switch (ret) {
> >>> +    case 0:
> >>> +    case -ENODEV:
> >>> +    case -EACCES:
> >>> +        return 0;
> >>> +    case -EFAULT:
> >>> +    default:
> >>> +        sch_gen_unit_exception(sch);
> >>> +        css_inject_io_interrupt(sch);
> >>> +        return 0;
> >>> +    }
> >>> +}  
> > 
> >   
> 


