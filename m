Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA302C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809FF2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809FF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zsA-0004zD-O9
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i2zrS-0004aP-6Q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i2zrQ-0004GJ-Fu
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i2zrQ-0004Ft-8Q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4198B308FBA6;
 Wed, 28 Aug 2019 15:27:47 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 903B75DC18;
 Wed, 28 Aug 2019 15:27:40 +0000 (UTC)
Date: Wed, 28 Aug 2019 17:27:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190828172738.7c09e114@redhat.com>
In-Reply-To: <87ftlmeg92.fsf@dusky.pond.sub.org>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <20190816152011.0c673027@redhat.com>
 <20190816165635.GC3908@habkost.net>
 <87sgq0qprn.fsf@dusky.pond.sub.org>
 <20190826165135.03e97e1b@redhat.com>
 <87ftlmeg92.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 28 Aug 2019 15:27:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 18:15:53 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Sat, 17 Aug 2019 08:17:48 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>   
> >> > On Fri, Aug 16, 2019 at 03:20:11PM +0200, Igor Mammedov wrote:    
> >> >> On Thu, 15 Aug 2019 15:38:03 -0300
> >> >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> >>     
> >> >> > We have this issue reported when using libvirt to hotplug CPUs:
> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> >> >> > 
> >> >> > Basically, libvirt is not copying die-id from
> >> >> > query-hotpluggable-cpus, but die-id is now mandatory.    
> >> >> 
> >> >> this should have been gated on compat property and affect
> >> >> only new machine types.
> >> >> Maybe we should do just that instead of fixup so libvirt
> >> >> would finally make proper handling of query-hotpluggable-cpus.
> >> >> 
> >> >>      
> >> >> > We could blame libvirt and say it is not following the documented
> >> >> > interface, because we have this buried in the QAPI schema
> >> >> > documentation:    
> >> >> 
> >> >> I wouldn't say buried, if I understand it right QAPI schema
> >> >> should be the authoritative source of interface description.
> >> >> 
> >> >> If I recall it's not the first time, there was similar issue
> >> >> for exactly the same reason (libvirt not passing through
> >> >> all properties from query-hotpluggable-cpus).
> >> >> 
> >> >> And we had to fix it up on QEMU side (numa_cpu_pre_plug),
> >> >> but it seems 2 years later libvirt is still broken the same way :(
> >> >> 
> >> >> Should we really do fixups or finaly fix it on libvirt side?    
> >> >
> >> > Is it truly a bug in libvirt?  Making QEMU behave differently
> >> > when getting exactly the same input sounds like a bad idea, even
> >> > if we documented that at the QAPI documentation.
> >> >
> >> > My suggestion is to instead drop the comment below from the QAPI
> >> > documentation.  New properties shouldn't become mandatory.    
> >> 
> >> The "comment below" is this one, in qapi/machine.json:
> >>   
> >> >> > > Note: currently there are 5 properties that could be present
> >> >> > > but management should be prepared to pass through other
> >> >> > > properties with device_add command to allow for future
> >> >> > > interface extension. This also requires the filed names to be kept in
> >> >> > > sync with the properties passed to -device/device_add.      
> >> 
> >> Goes back to commit d4633541ee0, v2.7.0.  @die-id was the first such
> >> interface extension.
> >> 
> >> A rule like "to use command C, you must pass it whatever you get from
> >> command Q" punches a hole into the "QMP is a stable interface" promise.
> >> Retroactively tacking it onto an existing interface like device-add
> >> some-existing-device is even more problematic than specifying it for a
> >> new interface.  Mind, this is not a categorical "can't ever do that".
> >> It's more like "you better show this is less bad than all the
> >> alternatives we can think of, and we've thought pretty hard".
> >> Since this particular hole failed us the first time anybody actually
> >> tried to wiggle through it, I think Eduardo has a point when he calls
> >> for filling it in by deleting the comment.  
> >
> > That was a consensus we were able to reach when discussing cpu hotplug
> > QMP interface. If I recall correctly idea was that it should work for
> > different targets (cpu topology properties target specific) and be
> > extensible without breaking old mgmt stack  or requiring its update
> > in lock step.
> >
> > If implemented correctly mgmt would not only query from QEMU/machine
> > possible CPUs (with properties and valid values needed to plug it in,
> > which it does already) but also 'keep' them around and pass back to
> > device_add. In that case it would have worked as designed just fine.
> >
> > But this also shows a problem that we still need versioned machine type
> > to keep old set of properties for old machine types anyway and we can
> > miss it during review as tests we have might be not enough
> > (tests/cpu-plug-test didn't detect it for some reason).  
> 
> I think the lesson to learn here is "non-trivial rules on correct
> interface use need to be backed by integration tests".
> 
> The rule in question is "a CPU hot-plug with device_add must specify all
> the properties returned by query-hotpluggable-cpus".
> 
> Sadly, stipulating such rules does not change the de facto API.  Case in
> point: libvirt did not obey this one, and even though it's been in place
> for years, yet we're (rightly!) unwilling to blame libvirt for the
> regression.  The stipulation was futile.
it will be futile while we continue fixing up QEMU.
practice shows there will be nothing to motivate fixing
client side for years (really, why even bother???).

> How could we increase our chances that management applications pick up
> such rules?  I can see only one promising way: make tests fail unless
> they do.  Add some arbitray dummy property, fail the hot plug unless
> it's given.  Of course, we can't do that, because it's exactly the
> breakage we're trying to avoid.  So do it only when QEMU is run with
> --future, then have integration tests run it that way.
Unfortunately it didn't work this time,
it was too late when integration tests caught die-id issue.
Adding random property would ensure that client won't be able
to implement only 'dummy' instead of copying all properties,
but too late detected bug issue would remain the same.

PS:
it's also me to blame not paying much attention to series and
breaking tests/cpu-plug-test, which allowed this issue to sip
through without any notice. We had test_plug_with_device_add_x86()
which would caught issue if it was run and I did break it with
commit bc1fb850a31. /me looking into fixing it/

 
> Aside: I'm afraid "# TODO: Better documentation; currently there is
> none" didn't exactly help with query-hotpluggable-cpus uptake.
> [...]


