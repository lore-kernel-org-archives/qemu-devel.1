Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C0BC04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 06:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3487E20879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 06:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3487E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hThOb-0000PT-6K
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 02:40:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hThNf-00007W-Aj
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hThNd-00034Y-R6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hThNd-00034N-Jg
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D741488302;
	Thu, 23 May 2019 06:39:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6565C5B681;
	Thu, 23 May 2019 06:39:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C33B51138648; Thu, 23 May 2019 08:39:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
Date: Thu, 23 May 2019 08:39:05 +0200
In-Reply-To: <CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	(Peter Maydell's message of "Tue, 21 May 2019 15:55:56 +0100")
Message-ID: <87ef4pisja.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 23 May 2019 06:39:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 May 2019 at 15:34, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>
>> > On 5/16/19 11:19 AM, Peter Maydell wrote:
>> >> On Thu, 16 May 2019 at 06:37, Markus Armbruster <armbru@redhat.com> wrote:
>> >>>
>> >>> A registry of callbacks to run on certain events is a fine technique.
>> >>> Relying on registration order, however, is in bad taste.  We should
>> >>> model dependencies between reset functions explicitly.
>> >>
>> >> That might be nice, but in practice we have no such model at
>> >> all, and I don't think I've seen anybody propose one.
>>
>> Well, we do have qbus_reset_all() & friends reset buses and devices in
>> post order.  That's a model, isn't it?  I guess it can't model *all*
>> dependencies.  Still, shouldn't we use it wherever it actually suffices?
>
> It's a well-defined order, but it doesn't actually help in a
> lot of cases, because often the thing you care about ordering
> on is not a device or is not in the same tree as the thing
> it depends on.

Dependencies need some kind of connection.

In the physical world, connections are a scarce resource.  This leads to
somewhat regular dependencies.  Reset order follows wiring.  The wiring
isn't always a tree, but it's tree-like enough to make trees a useful
concept there.

In the virtual world, connections aren't scarce; we can create
dependencies between anything.  Some dependencies, however, are just
sloppy modelling.

>                (For instance, there's an annoying ordering
> issue between the rom-loader's "reset" function which copies rom
> blob contents into RAM, and the Arm M-profile CPU reset method,
> which needs to read the starting PC and SP out of RAM. [*])

As your [*] explains, this is an artifact of sloppy modelling.

> It's also still an implicit ordering, in the sense that if
> there's a dependency between device A (in subtree A') and device
> B (in subtree B') then this will all work fine up until somebody
> at the top level innocently reorders A' and B' in the list of
> children of their mutual parent for some reason and then finds
> they've broken an implicit dependency.

Yes, implicit dependencies are brittle.  One of the reasons why making
them explicit can be worthwhile.

> [*] aside: this one would actually be fixed by the multi-phase reset
> proposal, since the definition of the reset phases is such that
> the rom-loader should write to memory in phase 2 ('hold') and
> the CPU should read from it in phase 3 ('exit').
>
>> hw/input/pckbd.c is instructive.  The qemu_register_reset() in
>> i8042_mm_init() is inded for a non-qdevified device.  The one in
>> i8042_realizefn() has no such excuse.
>>
>> Does not contradict what you wrote, of course.  Still, shouldn't we at
>> least get rid of the latter kind?
>
> Yes, absolutely. Also we should qdevify the non-qdev devices.
> This part is something where we have a clear path forwards
> for making cleanups (no tricky design decisions/debate required),
> it just requires somebody to write the actual code.

After all these years, the transition to qdev is still incomplete, and
the incompleteness still bogs us down.

We don't even know what still needs to be converted.  If we had a list
of such device models, and which machines depend on them, we could apply
a bit more force to the problem.

>> >> The other reason for having to have a qemu_register_reset() handler
>> >> to reset something that's a Device is if that Device is not on
>> >> a qbus. The most common example of this is CPUs -- since those
>> >> don't have a bus to live on they don't get reset by the "reset
>> >> everything that's on a QOM bus reachable from the main system
>> >> bus" logic. I'm not sure what the nicest way to address this is:
>> >> transitioning away from "reset of devices is based on the qdev tree"
>> >> to something else seems between difficult and impossible, even
>> >> though logically speaking the QOM tree is in many cases closer
>> >> to the actual hardware hierarchy of reset.
>> >
>> > One "solution" to reduce the qemu_register_reset usage would be to do
>> > handle in the Device base class (at creation or realize) if it has no
>> > parent bus like it is done for buses. But this would probably have an
>> > impact on reset ordering.
>>
>> I'm afraid *any* improvement will have an impact on reset ordering.
>> Most reorderings will be just fine.  How terrible could the
>> less-than-fine ones be?
>
> If you get "CPU reset" and "built in bootloader sets the PC to the
> initial address specified by the -kernel file" the wrong way around
> then we break booting :-)

Wonderfully unsubtle failure!  Even the stupidest of smoke tests should
catch it.

Would you be willing to hazard a guess on the risk of creating bugs
subtle enough to survive basic smoke tests?

>> >>> Registered handlers run in (implicitly defined) registration order,
>> >>> reset methods in (explicit) qdev tree post order.  Much better as long
>> >>> as that's the order we want.
>> >>>
>> >>> Say we managed to clean up this mess somehow, so reset handler
>> >>> registration order doesn't matter anymore.  Then moving the
>> >>> qemu_register_reset() for main_system_bus from main() to wherever we
>> >>> create main_system_bus would make sense, wouldn't it?
>> >>
>> >> I guess so... (There's an argument that the main system bus
>> >> should be a child bus of the Machine object, logically speaking,
>> >> but Machines aren't subtypes of Device so that doesn't work.)
>>
>> We could replace the special case "bus's parent is null" by the special
>> case "bus's parent is a machine instead of a device", but I'm not sure
>> what exactly it would buy us.
>
> It's mostly just logically neater -- you could imagine a future
> QEMU version that supported one simulation which had models
> of more than one machine simultaneously, in which case there
> ought to be two system buses, one per machine. And it's
> logical that vl.c has to create the machine that the user
> asked for, but it's a bit odder that it also has to create the
> system bus specially extra, even though it's really just part
> of the machine. But as I say, because Machine isn't a subtype of
> Device you can't make buses be children of Machine anyway.
> Fixing that is more effort than would be warranted for "it looks
> slightly nicer this way around".

Concur.

On a green field, we'd perhaps create things so that these buses can be
children of machines.  But our field looks quite ploughed.

