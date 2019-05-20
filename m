Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287EBC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB77220675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ksVIdq3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSemZ-0001u3-0v
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:40:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hSele-0001ZZ-B4
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hSelc-0003CM-QB
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:39:38 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:58556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hSelc-0003Be-9q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:39:36 -0400
Received: from [172.16.11.119] (unknown [172.16.11.119])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 09DB996F50;
	Mon, 20 May 2019 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1558345173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=jduvyp0Gji3Bq5BXm4iMgcmfOlZSo73em97VmwFaNj8=;
	b=ksVIdq3tWlIViUPXeF0kqWWegwTrGWhpscLQmPxS8HsQCAM7f20YKzNtNLWX3+XQZarh+w
	3QMKEPXv05cxVo5PxP2K9qSDOxJHRqdbKG5znaPxWDCzNiBCYt+EUEZ75NChTSPC1vr5U+
	LZZn3L0avOyIWB9Dn43AF1skMSGYYwE=
To: Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
Date: Mon, 20 May 2019 11:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1558345173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=jduvyp0Gji3Bq5BXm4iMgcmfOlZSo73em97VmwFaNj8=;
	b=B5xIUm6zT6/8H6KgL5fdQyLgDNDu9gSFxL6SdLzdOahwPpaedUkgEnpgqJHGs+CvaxaCki
	6GMUEwYQupXgK8yOMB/v04U1tz4Z3v9se11dhNEC7W77oa8HGERRT2vkBPB+nDWPvV5rWj
	d5wJRV6RtWQBbqawwhy5Alag7GVSats=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1558345173; a=rsa-sha256; cv=none;
	b=eijYQtwiQxrxJ5zP0FTkQ5OBD1Nv0MoJsVVg4frzQK7W5dJkwmU0bEakiTCncFQ2c+XOa+
	dso0BLgQPJ5a4F3ozk2JdqtwvkuEU6fHcD/onJvU1jFq9PLFhE+Z9mlLHa/SbFMnzSjqXQ
	iEMwDeH6pJQqjOEqvIrsvynNTObAUNc=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/16/19 11:19 AM, Peter Maydell wrote:
> On Thu, 16 May 2019 at 06:37, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
>>> some qbus buses not being connected to qdev devices -- if the
>>> bus has no parent object then we register a reset function which
>>> resets the bus on system reset.
>>>
>>> Nearly a decade later, we have now no buses in the tree which
>>> are created with non-NULL parents, so we can remove the
>>> workaround and instead just assert that if the bus has a NULL
>>> parent then it is the main system bus.
>>>
>>> (The absence of other parentless buses was confirmed by
>>> code inspection of all the callsites of qbus_create() and
>>> qbus_create_inplace() and cross-checked by 'make check'.)
>>
>> Could we assert(parent || bus == main_system_bus) in qbus_realize()?
> 
> Er, that's what this patch is doing.
> 
>> Aside: I hate sysbus_get_default().  It creates main_system_bus on first
>> call, wherever that call may be hiding.  I feel we should create it
>> explicitly.  I'd then make main_system_bus public, and delete
>> sysbus_get_default().
> 
> Yes, I think that would be a reasonable thing to do.
> The implicit creation is weird since we effectively
> rely on a main system bus existing anyway (it is the root
> of the reset tree).
> 
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> While I was reviewing Damian's reset patchset I noticed this
>>> code which meant that we theoretically had multiple 'roots' to
>>> the set of things being reset, so I wondered what was actually
>>> using it. It turns out nothing was :-)
>>>
>>> Commit 80376c3fc2c38fdd453 also added a TODO in vl.c suggesting
>>> that there is the wrong place to register the reset function
>>> which effectively resets the whole system starting at the
>>> root which is the main system bus:
>>>    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
>>> I don't understand why vl.c is a bad place to put that, and I'd
>>> rather not move it to qdev.c (where in qdev.c?) because that
>>> would reshuffle reset ordering which seems liable to cause
>>> regressions. So maybe we should just delete that TODO comment?
>>
>> Hmm.
>>
>> The one in vl.c arranges to run qbus_reset_all(main_system_bus), which
>> walks the tree rooted at main_system_bus, resetting its buses and
>> devices in post-order.
>>
>> A registry of callbacks to run on certain events is a fine technique.
>> Relying on registration order, however, is in bad taste.  We should
>> model dependencies between reset functions explicitly.
> 
> That might be nice, but in practice we have no such model at
> all, and I don't think I've seen anybody propose one. I hope we
> don't have too many accidental ordering dependencies, but I'm
> not confident that we have none at all, and would prefer not to
> prod that sleeping dragon...
> 
> The multi-phase-reset patches Damien has on list at the moment
> would allow some of the reset ordering issues to be sidestepped
> because "phase 1" for all devices happens before "phase 2" so
> you have "before" and "after" places to put the logic in different
> devices.
> 
>> That said, we can't ignore dependencies just because we've coded them
>> badly.
>>
>> I count more than 100 qemu_register_reset(), and most of them look like
>> they reset hardware.  Why do devices use qemu_register_reset() instead
>> of DeviceClass method reset?
> 
> Most of the ones for hardware are "this device hasn't been
> converted to be a QOM Device" (eg hw/arm/omap1.c, hw/input/pckbd.c,
> lots of the stuff in hw/ppc).
> 
> The other reason for having to have a qemu_register_reset() handler
> to reset something that's a Device is if that Device is not on
> a qbus. The most common example of this is CPUs -- since those
> don't have a bus to live on they don't get reset by the "reset
> everything that's on a QOM bus reachable from the main system
> bus" logic. I'm not sure what the nicest way to address this is:
> transitioning away from "reset of devices is based on the qdev tree"
> to something else seems between difficult and impossible, even
> though logically speaking the QOM tree is in many cases closer
> to the actual hardware hierarchy of reset.

One "solution" to reduce the qemu_register_reset usage would be to do
handle in the Device base class (at creation or realize) if it has no
parent bus like it is done for buses. But this would probably have an
impact on reset ordering.

> 
>> Registered handlers run in (implicitly defined) registration order,
>> reset methods in (explicit) qdev tree post order.  Much better as long
>> as that's the order we want.
>>
>> Say we managed to clean up this mess somehow, so reset handler
>> registration order doesn't matter anymore.  Then moving the
>> qemu_register_reset() for main_system_bus from main() to wherever we
>> create main_system_bus would make sense, wouldn't it?
> 
> I guess so... (There's an argument that the main system bus
> should be a child bus of the Machine object, logically speaking,
> but Machines aren't subtypes of Device so that doesn't work.)
> 
>> If it does make sense, we should keep the TODO in main(), because it
>> asks for exactly that.  Perhaps delete "by qdev.c".
>>
>>> ---
>>>  hw/core/bus.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/core/bus.c b/hw/core/bus.c
>>> index e09843f6abe..e50287c2b35 100644
>>> --- a/hw/core/bus.c
>>> +++ b/hw/core/bus.c
>>> @@ -96,10 +96,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
>>>          bus->parent->num_child_bus++;
>>>          object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
>>>          object_unref(OBJECT(bus));
>>> -    } else if (bus != sysbus_get_default()) {
>>> -        /* TODO: once all bus devices are qdevified,
>>> -           only reset handler for main_system_bus should be registered here. */
>>> -        qemu_register_reset(qbus_reset_all_fn, bus);
>>> +    } else {
>>> +        /* The only bus without a parent is the main system bus */
>>> +        assert(bus == sysbus_get_default());
>>>      }
>>>  }
>>
>> You delete a qemu_register_reset() because it's unreachable.  The commit
>> that added it also added a qemu_unregister_reset().  It's now in
>> bus_unparent().  Why is it still needed?
> 
> You're right, the bus_unparent() logic should also be cleaned up.
> 
> thanks
> -- PMM
> 

