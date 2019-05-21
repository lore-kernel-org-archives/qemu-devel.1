Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE8C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122C321773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122C321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5sI-0000EZ-Dh
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:36:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hT5qv-0007eU-4i
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hT5qs-0003Um-9Y
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hT5qq-0003TW-D0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EA00356E8;
	Tue, 21 May 2019 14:34:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01DFF646A9;
	Tue, 21 May 2019 14:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 52E7E1138648; Tue, 21 May 2019 16:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
Date: Tue, 21 May 2019 16:34:33 +0200
In-Reply-To: <f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com> (Damien
	Hedde's message of "Mon, 20 May 2019 11:39:32 +0200")
Message-ID: <87imu3swp2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 21 May 2019 14:34:42 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Damien Hedde <damien.hedde@greensocs.com> writes:

> On 5/16/19 11:19 AM, Peter Maydell wrote:
>> On Thu, 16 May 2019 at 06:37, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
>>>> some qbus buses not being connected to qdev devices -- if the
>>>> bus has no parent object then we register a reset function which
>>>> resets the bus on system reset.
>>>>
>>>> Nearly a decade later, we have now no buses in the tree which
>>>> are created with non-NULL parents, so we can remove the
>>>> workaround and instead just assert that if the bus has a NULL
>>>> parent then it is the main system bus.
>>>>
>>>> (The absence of other parentless buses was confirmed by
>>>> code inspection of all the callsites of qbus_create() and
>>>> qbus_create_inplace() and cross-checked by 'make check'.)
>>>
>>> Could we assert(parent || bus == main_system_bus) in qbus_realize()?
>> 
>> Er, that's what this patch is doing.

You're right; I got confused.

>>> Aside: I hate sysbus_get_default().  It creates main_system_bus on first
>>> call, wherever that call may be hiding.  I feel we should create it
>>> explicitly.  I'd then make main_system_bus public, and delete
>>> sysbus_get_default().
>> 
>> Yes, I think that would be a reasonable thing to do.
>> The implicit creation is weird since we effectively
>> rely on a main system bus existing anyway (it is the root
>> of the reset tree).
>> 
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>> While I was reviewing Damian's reset patchset I noticed this
>>>> code which meant that we theoretically had multiple 'roots' to
>>>> the set of things being reset, so I wondered what was actually
>>>> using it. It turns out nothing was :-)
>>>>
>>>> Commit 80376c3fc2c38fdd453 also added a TODO in vl.c suggesting
>>>> that there is the wrong place to register the reset function
>>>> which effectively resets the whole system starting at the
>>>> root which is the main system bus:
>>>>    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
>>>> I don't understand why vl.c is a bad place to put that, and I'd
>>>> rather not move it to qdev.c (where in qdev.c?) because that
>>>> would reshuffle reset ordering which seems liable to cause
>>>> regressions. So maybe we should just delete that TODO comment?
>>>
>>> Hmm.
>>>
>>> The one in vl.c arranges to run qbus_reset_all(main_system_bus), which
>>> walks the tree rooted at main_system_bus, resetting its buses and
>>> devices in post-order.
>>>
>>> A registry of callbacks to run on certain events is a fine technique.
>>> Relying on registration order, however, is in bad taste.  We should
>>> model dependencies between reset functions explicitly.
>> 
>> That might be nice, but in practice we have no such model at
>> all, and I don't think I've seen anybody propose one.

Well, we do have qbus_reset_all() & friends reset buses and devices in
post order.  That's a model, isn't it?  I guess it can't model *all*
dependencies.  Still, shouldn't we use it wherever it actually suffices?

>>                                                       I hope we
>> don't have too many accidental ordering dependencies, but I'm
>> not confident that we have none at all, and would prefer not to
>> prod that sleeping dragon...
>> 
>> The multi-phase-reset patches Damien has on list at the moment
>> would allow some of the reset ordering issues to be sidestepped
>> because "phase 1" for all devices happens before "phase 2" so
>> you have "before" and "after" places to put the logic in different
>> devices.
>> 
>>> That said, we can't ignore dependencies just because we've coded them
>>> badly.
>>>
>>> I count more than 100 qemu_register_reset(), and most of them look like
>>> they reset hardware.  Why do devices use qemu_register_reset() instead
>>> of DeviceClass method reset?
>> 
>> Most of the ones for hardware are "this device hasn't been
>> converted to be a QOM Device" (eg hw/arm/omap1.c, hw/input/pckbd.c,
>> lots of the stuff in hw/ppc).

hw/input/pckbd.c is instructive.  The qemu_register_reset() in
i8042_mm_init() is inded for a non-qdevified device.  The one in
i8042_realizefn() has no such excuse.

Does not contradict what you wrote, of course.  Still, shouldn't we at
least get rid of the latter kind?

>> The other reason for having to have a qemu_register_reset() handler
>> to reset something that's a Device is if that Device is not on
>> a qbus. The most common example of this is CPUs -- since those
>> don't have a bus to live on they don't get reset by the "reset
>> everything that's on a QOM bus reachable from the main system
>> bus" logic. I'm not sure what the nicest way to address this is:
>> transitioning away from "reset of devices is based on the qdev tree"
>> to something else seems between difficult and impossible, even
>> though logically speaking the QOM tree is in many cases closer
>> to the actual hardware hierarchy of reset.
>
> One "solution" to reduce the qemu_register_reset usage would be to do
> handle in the Device base class (at creation or realize) if it has no
> parent bus like it is done for buses. But this would probably have an
> impact on reset ordering.

I'm afraid *any* improvement will have an impact on reset ordering.
Most reorderings will be just fine.  How terrible could the
less-than-fine ones be?

>>> Registered handlers run in (implicitly defined) registration order,
>>> reset methods in (explicit) qdev tree post order.  Much better as long
>>> as that's the order we want.
>>>
>>> Say we managed to clean up this mess somehow, so reset handler
>>> registration order doesn't matter anymore.  Then moving the
>>> qemu_register_reset() for main_system_bus from main() to wherever we
>>> create main_system_bus would make sense, wouldn't it?
>> 
>> I guess so... (There's an argument that the main system bus
>> should be a child bus of the Machine object, logically speaking,
>> but Machines aren't subtypes of Device so that doesn't work.)

We could replace the special case "bus's parent is null" by the special
case "bus's parent is a machine instead of a device", but I'm not sure
what exactly it would buy us.

>>> If it does make sense, we should keep the TODO in main(), because it
>>> asks for exactly that.  Perhaps delete "by qdev.c".
[...]

