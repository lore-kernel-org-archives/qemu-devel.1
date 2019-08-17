Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B5C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 06:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1CA21019
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 06:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1CA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hys2z-0003GU-Ds
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 02:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hys2F-0002nb-LY
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 02:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hys2E-00060M-2X
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 02:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hys2D-0005zU-Rf
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 02:17:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 914251089041;
 Sat, 17 Aug 2019 06:17:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C183860CCD;
 Sat, 17 Aug 2019 06:17:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D72E10E6CCA; Sat, 17 Aug 2019 08:17:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <20190816152011.0c673027@redhat.com>
 <20190816165635.GC3908@habkost.net>
Date: Sat, 17 Aug 2019 08:17:48 +0200
In-Reply-To: <20190816165635.GC3908@habkost.net> (Eduardo Habkost's message of
 "Fri, 16 Aug 2019 13:56:35 -0300")
Message-ID: <87sgq0qprn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Sat, 17 Aug 2019 06:17:52 +0000 (UTC)
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Aug 16, 2019 at 03:20:11PM +0200, Igor Mammedov wrote:
>> On Thu, 15 Aug 2019 15:38:03 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>> 
>> > We have this issue reported when using libvirt to hotplug CPUs:
>> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
>> > 
>> > Basically, libvirt is not copying die-id from
>> > query-hotpluggable-cpus, but die-id is now mandatory.
>> 
>> this should have been gated on compat property and affect
>> only new machine types.
>> Maybe we should do just that instead of fixup so libvirt
>> would finally make proper handling of query-hotpluggable-cpus.
>> 
>>  
>> > We could blame libvirt and say it is not following the documented
>> > interface, because we have this buried in the QAPI schema
>> > documentation:
>> 
>> I wouldn't say buried, if I understand it right QAPI schema
>> should be the authoritative source of interface description.
>> 
>> If I recall it's not the first time, there was similar issue
>> for exactly the same reason (libvirt not passing through
>> all properties from query-hotpluggable-cpus).
>> 
>> And we had to fix it up on QEMU side (numa_cpu_pre_plug),
>> but it seems 2 years later libvirt is still broken the same way :(
>> 
>> Should we really do fixups or finaly fix it on libvirt side?
>
> Is it truly a bug in libvirt?  Making QEMU behave differently
> when getting exactly the same input sounds like a bad idea, even
> if we documented that at the QAPI documentation.
>
> My suggestion is to instead drop the comment below from the QAPI
> documentation.  New properties shouldn't become mandatory.

The "comment below" is this one, in qapi/machine.json:

>> > > Note: currently there are 5 properties that could be present
>> > > but management should be prepared to pass through other
>> > > properties with device_add command to allow for future
>> > > interface extension. This also requires the filed names to be kept in
>> > > sync with the properties passed to -device/device_add.  

Goes back to commit d4633541ee0, v2.7.0.  @die-id was the first such
interface extension.

A rule like "to use command C, you must pass it whatever you get from
command Q" punches a hole into the "QMP is a stable interface" promise.
Retroactively tacking it onto an existing interface like device-add
some-existing-device is even more problematic than specifying it for a
new interface.  Mind, this is not a categorical "can't ever do that".
It's more like "you better show this is less bad than all the
alternatives we can think of, and we've thought pretty hard".

Since this particular hole failed us the first time anybody actually
tried to wiggle through it, I think Eduardo has a point when he calls
for filling it in by deleting the comment.

By the way, the line preceding the comment

     # @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to

is actually two lines run together.  Messed up when @die-id was added
(commit 176d2cda0de).  Minor review fail (I didn't look even though I
was cc'ed on v2; I wasn't on v3).  Let's fix that, too.

>> > But I don't think this would be reasonable from us.  We can just
>> > make QEMU more flexible and let CPU properties to be omitted when
>> > there's no ambiguity.  This will allow us to keep compatibility
>> > with existing libvirt versions.
>> 
>> I don't really like making rule from exceptions so I'd suggest doing
>> it only for  die_id if we have to do fix it up (with fat comment
>> like in numa_cpu_pre_plug).
>> The rest are working fine as is.
>
> I will insist we make it consistent for all properties, but I
> don't want this discussion to hold the bug fix.  So I'll do this:
>
> I will submit a new patch that makes only die-id optional, and CC
> qemu-stable.
>
> After that, i will submit this patch again, and we can discuss
> whether we should make all properties optional.

Makes sense, go ahead.

