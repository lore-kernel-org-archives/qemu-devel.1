Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B304BC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8016D2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nb5tv+MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8016D2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iou2S-0005zc-Ms
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iou1d-0005Kh-Cc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iou1b-0004eo-QI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:56:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iou1b-0004eC-Lf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578423378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eC2tkBULAWqXhye0bf//BBmsWkRf4gna7XuvdCNzRnI=;
 b=Nb5tv+MIr9jnarbSndVBc1TLD07JuxmOUIzDGTlka0tgndQJ4gMOCAWZhLIYgTq4yaEXC6
 UqYvGfKiu8R0Azs5Fh0JPZ9nFje96xVoFxkM8XGGrErOgKfmb7A/t/0HK6zMXDR+qEgCI1
 YeajLJm8IMEr36VBPeHcct40ecPxuKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-ICI4B1HNM-eKDbFSompWvQ-1; Tue, 07 Jan 2020 13:56:15 -0500
X-MC-Unique: ICI4B1HNM-eKDbFSompWvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB65C801E72;
 Tue,  7 Jan 2020 18:56:12 +0000 (UTC)
Received: from w520.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76B785C1B0;
 Tue,  7 Jan 2020 18:56:02 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:56:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20200107115602.25156c41@w520.home>
In-Reply-To: <08b7f953-6ac5-cd79-b1ff-54338da32d1e@nvidia.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-2-git-send-email-kwankhede@nvidia.com>
 <20191216154406.023f912b@x1.home>
 <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
 <20191217114357.6496f748@x1.home>
 <3527321f-e310-8324-632c-339b22f15de5@nvidia.com>
 <20191219102706.0a316707@x1.home>
 <928e41b5-c3fd-ed75-abd6-ada05cda91c9@nvidia.com>
 <20191219140929.09fa24da@x1.home> <20200102182537.GK2927@work-vm>
 <20200106161851.07871e28@w520.home>
 <ce132929-64a7-9a5b-81ff-38616202b757@nvidia.com>
 <20200107100923.2f7b5597@w520.home>
 <08b7f953-6ac5-cd79-b1ff-54338da32d1e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 23:23:17 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 1/7/2020 10:39 PM, Alex Williamson wrote:
> > On Tue, 7 Jan 2020 12:58:22 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 1/7/2020 4:48 AM, Alex Williamson wrote:  
> >>> On Thu, 2 Jan 2020 18:25:37 +0000
> >>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >>>      
> >>>> * Alex Williamson (alex.williamson@redhat.com) wrote:  
> >>>>> On Fri, 20 Dec 2019 01:40:35 +0530
> >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>         
> >>>>>> On 12/19/2019 10:57 PM, Alex Williamson wrote:
> >>>>>>
> >>>>>> <Snip>
> >>>>>>         
> >>>>
> >>>> <snip>
> >>>>     
> >>>>>>
> >>>>>> If device state it at pre-copy state (011b).
> >>>>>> Transition, i.e., write to device state as stop-and-copy state (010b)
> >>>>>> failed, then by previous state I meant device should return pre-copy
> >>>>>> state(011b), i.e. previous state which was successfully set, or as you
> >>>>>> said current state which was successfully set.  
> >>>>>
> >>>>> Yes, the point I'm trying to make is that this version of the spec
> >>>>> tries to tell the user what they should do upon error according to our
> >>>>> current interpretation of the QEMU migration protocol.  We're not
> >>>>> defining the QEMU migration protocol, we're defining something that can
> >>>>> be used in a way to support that protocol.  So I think we should be
> >>>>> concerned with defining our spec, for example my proposal would be: "If
> >>>>> a state transition fails the user can read device_state to determine the
> >>>>> current state of the device.  This should be the previous state of the
> >>>>> device unless the vendor driver has encountered an internal error, in
> >>>>> which case the device may report the invalid device_state 110b.  The
> >>>>> user must use the device reset ioctl in order to recover the device
> >>>>> from this state.  If the device is indicated in a valid device state
> >>>>> via reading device_state, the user may attempt to transition the device
> >>>>> to any valid state reachable from the current state."  
> >>>>
> >>>> We might want to be able to distinguish between:
> >>>>     a) The device has failed and needs a reset
> >>>>     b) The migration has failed  
> >>>
> >>> I think the above provides this.  For Kirti's example above of
> >>> transitioning from pre-copy to stop-and-copy, the device could refuse
> >>> to transition to stop-and-copy, generating an error on the write() of
> >>> device_state.  The user re-reading device_state would allow them to
> >>> determine the current device state, still in pre-copy or failed.  Only
> >>> the latter would require a device reset.
> >>>      
> >>>> If some part of the devices mechanics for migration fail, but the device
> >>>> is otherwise operational then we should be able to decide to fail the
> >>>> migration without taking the device down, which might be very bad for
> >>>> the VM.
> >>>> Losing a VM during migration due to a problem with migration really
> >>>> annoys users; it's one thing the migration failing, but taking the VM
> >>>> out as well really gets to them.
> >>>>
> >>>> Having the device automatically transition back to the 'running' state
> >>>> seems a bad idea to me; much better to tell the hypervisor and provide
> >>>> it with a way to clean up; for example, imagine a system with multiple
> >>>> devices that are being migrated, most of them have happily transitioned
> >>>> to stop-and-copy, but then the last device decides to fail - so now
> >>>> someone is going to have to take all of them back to running.  
> >>>
> >>> Right, unless I'm missing one, it seems invalid->running is the only
> >>> self transition the device should make, though still by way of user
> >>> interaction via the reset ioctl.  Thanks,
> >>>      
> >>
> >> Instead of using invalid state by vendor driver on device failure, I
> >> think better to reserve one bit in device state which vendor driver can
> >> set on device failure. When error bit is set, other bits in device state
> >> should be ignored.  
> > 
> > Why is a separate bit better?  Saving and Restoring states are mutually
> > exclusive, so we have an unused and invalid device state already
> > without burning another bit.  Thanks,
> >   
> 
> There are 3 invalid states:
>   *  101b => Invalid state
>   *  110b => Invalid state
>   *  111b => Invalid state
> 
> why only 110b should be used to report error from vendor driver to 
> report error? Aren't we adding more confusions in the interface?

I think the only chance of confusion is poor documentation.  If we
define all of the above as invalid and then say any invalid state
indicates an error condition, then the burden is on the user to
enumerate all the invalid states.  That's not a good idea.  Instead we
could say 101b (_RESUMING|_RUNNING) is reserved, it's not currently
used but it might be useful some day.  Therefore there are no valid
transitions into or out of this state.  A vendor driver should fail a
write(2) attempting to enter this state.

That leaves 11Xb, where we consider _RESUMING and _SAVING as mutually
exclusive, so neither are likely to ever be valid states.  Logically,
if the device is in a failed state such that it needs to be reset to be
recovered, I would hope the device is not running, so !_RUNNING (110b)
seems appropriate.  I'm not sure we need that level of detail yet
though, so I was actually just assuming both 11Xb states would indicate
an error state and the undefined _RUNNING bit might differentiate
something in the future.

Therefore, I think we'd have:

 * 101b => Reserved
 * 11Xb => Error

Where the device can only self transition into the Error state on a
failed device_state transition and the only exit from the Error state
is via the reset ioctl.  The Reserved state is unreachable.  The vendor
driver must error on device_state writes to enter or exit the Error
state and must error on writes to enter Reserved states.  Is that still
confusing?

> Only 3 bits from 32 bits are yet used, one bit can be spared to 
> represent error state from vendor driver.

I just don't see that it adds any value to use a separate bit, we
already have more error states than we need with the 3 bits we have.
Thanks,

Alex


