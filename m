Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45256C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 09:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE9A20862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKr1OTL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE9A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRCYa-0007Ko-DT
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 05:20:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRCXn-000727-Vh
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRCXm-0002jv-F2
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:19:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRCXm-0002hO-9C
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:19:18 -0400
Received: by mail-oi1-x244.google.com with SMTP id m204so2015775oib.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QKjuy3JfBTOf8LNbLLcYz5nvNEKJaZ4L2XbAcEpWSPc=;
	b=tKr1OTL7D9MwJMcN+rHrYcNh8mfZvksq729/fh48vLtpxYySe5YTlGPiMsBZSvSdnH
	tbEfcPx17JYNU4k5DE7h9nuT6/4/lLLPZoqFHyT/8Ivsno651piLoFLaj0lmAWEtq/cE
	CXQbsPZvvs8LQGyxBrgv9nTTGskJb3odbTjLQCHSqGMSCAHKcd6cR/lR5pXgvpDU5USq
	8XF9NE5yNgUulW8SKRcqBsXejV9P5iRZFhzERh9FnrssUIVHPTVNTcwLTHC3G1XSKngi
	yakXu9+Tir+ajk6I/PwgrDZ22JygS5DjMxAypugLXydbuW+9BW/WQO+ITojaY/ZNCVak
	av9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QKjuy3JfBTOf8LNbLLcYz5nvNEKJaZ4L2XbAcEpWSPc=;
	b=T2+XVPinmRwFpZgKP8BXL2hMsvo/AdGa6S9BcpdkswMnPVhTC9arYugizrzyHm6Dzt
	AAK09lGdriR6HurSYDE9pEwq9yujGZBbI4diypDn+dCAacHnogGALMu4Jo1zsA3cIIpn
	LMiPyBBxJYDzDZG/XrOZ7RN3nkHumBME02s/AqXQ6Qx4RiR14k0LoIPq0vuL+Z2HNRff
	wYUiJxHp3kPTICYYHpIMp30YSD5ctC1o0djKDdQYSOvGvcHqhUgFNiTtIPx5K3t7AzDL
	7hFnMzpcEnKQHmxzxgPSyf70r/5uLO0Ytm6ExNkIbhN+NSCADRF69yr4AhyqONEe6UCc
	EHWw==
X-Gm-Message-State: APjAAAXC7e7avXJBTQwAmIpJpBQHVgedvdzEbDmR/910ypKWYDwENaUp
	tiPD7ZdpCcbnHzKYBgQLvHZbIuZwkOyRXWzdREz3zQ==
X-Google-Smtp-Source: APXvYqygRCVfvgFOWXAzf5x1uJGgjWof3efuTwXhmnsfkvUkHcZWqlqfb1hT+s5AkNu1ylTXitr1k6V4gNm4j7NFPOg=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr1010223oig.146.1557998356904; 
	Thu, 16 May 2019 02:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
In-Reply-To: <878sv7yn6t.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 10:19:05 +0100
Message-ID: <CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Thu, 16 May 2019 at 06:37, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
> > some qbus buses not being connected to qdev devices -- if the
> > bus has no parent object then we register a reset function which
> > resets the bus on system reset.
> >
> > Nearly a decade later, we have now no buses in the tree which
> > are created with non-NULL parents, so we can remove the
> > workaround and instead just assert that if the bus has a NULL
> > parent then it is the main system bus.
> >
> > (The absence of other parentless buses was confirmed by
> > code inspection of all the callsites of qbus_create() and
> > qbus_create_inplace() and cross-checked by 'make check'.)
>
> Could we assert(parent || bus == main_system_bus) in qbus_realize()?

Er, that's what this patch is doing.

> Aside: I hate sysbus_get_default().  It creates main_system_bus on first
> call, wherever that call may be hiding.  I feel we should create it
> explicitly.  I'd then make main_system_bus public, and delete
> sysbus_get_default().

Yes, I think that would be a reasonable thing to do.
The implicit creation is weird since we effectively
rely on a main system bus existing anyway (it is the root
of the reset tree).

> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > While I was reviewing Damian's reset patchset I noticed this
> > code which meant that we theoretically had multiple 'roots' to
> > the set of things being reset, so I wondered what was actually
> > using it. It turns out nothing was :-)
> >
> > Commit 80376c3fc2c38fdd453 also added a TODO in vl.c suggesting
> > that there is the wrong place to register the reset function
> > which effectively resets the whole system starting at the
> > root which is the main system bus:
> >    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
> > I don't understand why vl.c is a bad place to put that, and I'd
> > rather not move it to qdev.c (where in qdev.c?) because that
> > would reshuffle reset ordering which seems liable to cause
> > regressions. So maybe we should just delete that TODO comment?
>
> Hmm.
>
> The one in vl.c arranges to run qbus_reset_all(main_system_bus), which
> walks the tree rooted at main_system_bus, resetting its buses and
> devices in post-order.
>
> A registry of callbacks to run on certain events is a fine technique.
> Relying on registration order, however, is in bad taste.  We should
> model dependencies between reset functions explicitly.

That might be nice, but in practice we have no such model at
all, and I don't think I've seen anybody propose one. I hope we
don't have too many accidental ordering dependencies, but I'm
not confident that we have none at all, and would prefer not to
prod that sleeping dragon...

The multi-phase-reset patches Damien has on list at the moment
would allow some of the reset ordering issues to be sidestepped
because "phase 1" for all devices happens before "phase 2" so
you have "before" and "after" places to put the logic in different
devices.

> That said, we can't ignore dependencies just because we've coded them
> badly.
>
> I count more than 100 qemu_register_reset(), and most of them look like
> they reset hardware.  Why do devices use qemu_register_reset() instead
> of DeviceClass method reset?

Most of the ones for hardware are "this device hasn't been
converted to be a QOM Device" (eg hw/arm/omap1.c, hw/input/pckbd.c,
lots of the stuff in hw/ppc).

The other reason for having to have a qemu_register_reset() handler
to reset something that's a Device is if that Device is not on
a qbus. The most common example of this is CPUs -- since those
don't have a bus to live on they don't get reset by the "reset
everything that's on a QOM bus reachable from the main system
bus" logic. I'm not sure what the nicest way to address this is:
transitioning away from "reset of devices is based on the qdev tree"
to something else seems between difficult and impossible, even
though logically speaking the QOM tree is in many cases closer
to the actual hardware hierarchy of reset.

> Registered handlers run in (implicitly defined) registration order,
> reset methods in (explicit) qdev tree post order.  Much better as long
> as that's the order we want.
>
> Say we managed to clean up this mess somehow, so reset handler
> registration order doesn't matter anymore.  Then moving the
> qemu_register_reset() for main_system_bus from main() to wherever we
> create main_system_bus would make sense, wouldn't it?

I guess so... (There's an argument that the main system bus
should be a child bus of the Machine object, logically speaking,
but Machines aren't subtypes of Device so that doesn't work.)

> If it does make sense, we should keep the TODO in main(), because it
> asks for exactly that.  Perhaps delete "by qdev.c".
>
> > ---
> >  hw/core/bus.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/core/bus.c b/hw/core/bus.c
> > index e09843f6abe..e50287c2b35 100644
> > --- a/hw/core/bus.c
> > +++ b/hw/core/bus.c
> > @@ -96,10 +96,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
> >          bus->parent->num_child_bus++;
> >          object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
> >          object_unref(OBJECT(bus));
> > -    } else if (bus != sysbus_get_default()) {
> > -        /* TODO: once all bus devices are qdevified,
> > -           only reset handler for main_system_bus should be registered here. */
> > -        qemu_register_reset(qbus_reset_all_fn, bus);
> > +    } else {
> > +        /* The only bus without a parent is the main system bus */
> > +        assert(bus == sysbus_get_default());
> >      }
> >  }
>
> You delete a qemu_register_reset() because it's unreachable.  The commit
> that added it also added a qemu_unregister_reset().  It's now in
> bus_unparent().  Why is it still needed?

You're right, the bus_unparent() logic should also be cleaned up.

thanks
-- PMM

