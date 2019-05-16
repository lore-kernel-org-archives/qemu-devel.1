Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535FEC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6A220833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpEuoXq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6A220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFvq-0006nW-Ac
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:56:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFiA-0003df-J5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFi7-0002GF-HK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:42:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRFi7-0002Eq-AX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:42:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id t187so2354204oie.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Mu+5BpM2hOtGtd/f/dn1CGFFMve5wBCOhTGy3vRJJRM=;
	b=YpEuoXq18fl6WyjFA0C8qRb2qdzVqe35xizuilWGkl5H/kN9eBAqejuSUaUdvnCOgq
	ND4F2C5Aw7eozSL1k/6sjuZNxBqZNPUDbO+AYjGcgpoTCmgYswYaY7nbzM8Ee1hde7QW
	KZecfVJ6lhGrw4awhIKgEkHw2uFe2GXyXXmbKMVek0RtzAiYmEiF/nmUq43OucipcPc4
	0MoetXD67AdAZ9g6+f0IpFGn7MRdncI/Fi3OVUbYavIGbVOOlaKcQ4C+Up8zb8mhuJgk
	yQ1X/yzAYHxQigKfp0UrN2D1D7mAMNZX0jBYlWOQBrWHR5O57vo2kEirHkP0FE8mBH1l
	c/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Mu+5BpM2hOtGtd/f/dn1CGFFMve5wBCOhTGy3vRJJRM=;
	b=L54h9w+JxljDiNUfgiZr5JOABzim7nquW+AqvuPZTYqyDuhAQ4Ta2nbTTZCst8+0C4
	rxTR5dJ27lsS7L51M7JJGNUfOaDI2UB7R3/m9XnKYMz1SPTT4sISgBnjKr426vjVlujS
	2NnvAg/nNdQ4ebLoOX29jC/1NN75nrD0rr7EIclaA78GCJ8rGDJ3E8pP4OatFzMiJD6C
	x2YK9o0aZmxZsYOgGSCGJHbIw8+BHPAqH2fHFLKgWL9ws+o2ymDXEQMRSF268zaJXyFi
	AuwIGVgsy3ze3MqcEa1LO12l8izD0ZEEOYeOIcO0u49hslMSgsDIhMF0KfWUPGM2F2pU
	nb7w==
X-Gm-Message-State: APjAAAU9f5tSuSN2tKl1+rHW8K6gBCKYlFd4RqjeP8gtoSBmdXTpOAn3
	GlCxCWn/j3myptLoixarmDfsU/WB9bbycYZZA0qVfA==
X-Google-Smtp-Source: APXvYqxxia1y0LA+nmPcez615hPQ+Vuwl6lmuaHQR9Dtb7O/chx0c8uu6vtZF1QegpprISskB/xz4ohmtNABhzfALUM=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr10313014oib.170.1558010530123;
	Thu, 16 May 2019 05:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553510737.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1553510737.git.damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 13:41:59 +0100
Message-ID: <CAFEAcA-84KBmZhRqugQzmEkWVcFBuSAdLtp_HGjRxLeVj1SLXA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [RFC 00/17] multi-phase reset mechanism
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Mark Burton <mark.burton@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Mar 2019 at 11:02, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi all,
>
> This series is a proposal to implement the multi-phase reset we've discussed
> here (https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00310.html) and
> more recently there
> (https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00081.html).
>
> To summarize, we need a multi-phase reset to allow for a more complex
> initialization of a platform. In particular we need to "propagate" a clock
> tree, but we have to ensure that every device is initialized first.

Hi; I finally managed to get my thoughts about reset coherent
enough to write down in an email.


OVERVIEW

I had a read through the patchset and spent a while trying to
understand what we currently have.

Our current (device) reset model is:
 * single-phase
    -- there is only one 'reset' method
 * implicit
    -- devices don't need to be explicitly registered anywhere
       in a "reset hierarchy"; instead they are reset by virtue
       of being in the bus heirarchy they are already in
 * bus-based
    -- sysbus reset is registered in vl.c; free-floating other buses[*]
       (ie those with a NULL parent) have a reset registered in qbus_realize;
       buses with parents (ie anything with a non-NULL parent passed to
       qbus_create() or qbus_create_inplace()) will get traversed by
       the recursive traversal of whatever bus their parent is on.
 * not exhaustive
    -- any devices not put on a bus, or put on a bus whose parent device
       is not on a bus, will not get reset
 * not modelling GPIO reset signal lines

[*] It turns out we actually don't have any of these any more, so
we can remove the code that deals with them. The only parentless bus
is the main system bus, which is the root of the "reset hierarchy".

This patchset is trying to address:
 * changing to multi-phase
 * modelling of GPIO reset signal lines

It leaves reset as bus-based: currently we do this via qbus_walk_children/
qdev_walk_children, which traverse the bus->children and dev->child_bus
lists, and in the patchset's implementation of Resettable for qdev/qbus
the methods iterate through those.

I think this is reasonable -- we don't want to try to tackle every
reset related problem at once. The two issues the patchset is looking
at fit well together, because the GPIO-reset-lines are a motivation
for switching to multiphase (you need to handle both entering and
leaving reset).

("not exhaustive" is the thing we should really try to
fix at some point, but I have no good ideas for how to do this.)

API DESIGN

On what the right APIs should be: I think we should separate
"the API that's nice for devices to implement" from "the API that's
nice for callers wanting to reset a device". Here's my suggestion
for doing that:


Have the Resettable interface be:
 * init
 * hold
 * exit
 * get_reset_count
 * increment_reset_count (returns previous count)
 * decrement_reset_count (returns new count)
 * some method for "iterate over any Resettable child objects"
   (probably a "call this callback for each child" type API)

Individual devices implement init/hold/exit
Device base class implements the reset_count methods
Device base class implements a default 'init' method that calls dc->reset
  and default hold/exit that are no-ops
Device base class has a new vmstate subsection which migrates the
  reset count, subsection's needed function says "only send
  if reset count is non-zero". Back-compat here should be fine
  as current machines don't implement any way that a device in
  the system can be being held in reset at the point where a
  migration happens. If future changes add features to a
  machine model that permit that, the migration is forwards-compatible.
Device base class implements the iterate-over-children method to
 iterate over the dev->child_bus buses
Bus base class implements reset_count methods
Bus base class implements default no-op init/hold/exit
Bus base class implements the iterate-over-children method to
 iterate over the bus->children devices
Handling migration of the bus base class reset count is a little
 awkward -- we'll need to put it in a vmstate subsection which
 is part of the vmstate of the device which owns the bus.
 (I talked to David Gilbert on IRC about this and have some
 possibilities for how to do it, but will postpone writing them
 out until we've decided whether we like the APIs.)

The "API for devices to implement" is then the init/hold/exit
methods of the Resettable interface -- they don't need to worry
about these methods possibly being called multiple times, and
they don't need to handle the reference count or passing on
the calling of the phase methods to their children. They
just need to implement the correct behaviour for their device
for this phase.

The "API for callers wanting to reset a device" is a set of
helper functions that take a pointer to a Resettable object.
It's these that deal with the reset count and children:

resettable_assert_reset(Resettable *r)
{
   if (r->increment_reset_count() == 0) {
       r->init();
       r->foreach_child(do_call_init);
       r->hold();
       r->foreach_child(do_call_hold);
   }
}

resettable_deassert_reset(Resettable *r)
{
   if (r->decrement_reset_count() == 0) {
      r->foreach_child(do_call_exit);
      r->exit();
   }
}

plus a utility function for "call assert then deassert",
and maybe one that wraps the get_reset_count method.
So callers that want to reset devices (or buses) don't need
to care about phases, they just assert and then deassert reset.

Do you think that works ?


API TRANSITIONS

The other issue here is API transitions: the patchset essentially
obsoletes the old DeviceClass::reset function, for instance. I think
we should be clear about what the old and new APIs here are, and
what our plans for transitioning to the new ones are. In some cases
there are really very few users of the old API -- for instance the
patchset makes qbus_reset_all(bus) a synonym for qbus_reset(bus, false),
but there are only a dozen or so users of qbus_reset_all(). I think
we should just go ahead and convert them all. (For purposes of
structuring the patchset starting with a patch that says "reimplement
qbus_reset_all() in terms of qbus_reset()" is OK, but then we should
fix up the callers afterwards.) There are of course a lot more
implementations of DeviceState::reset so transitioning away from
that is a lot trickier, but we could look at a coccinelle script
that could automate it.

If you could describe in the cover letter of the next version of
the patchseries all the old APIs being deprecated and the new
ones that replace them, I think that would be very helpful.


MISCELLANEOUS MINOR POINTS

I know I suggested the idea of a ResetDomain object, but in the
series as it stands I'm not sure it's serving very much purpose;
perhaps we should drop it for the moment (just leaving the legacy
reset handlers and sysbus reset the way they are) ? We can come back
to it later as a concept.

The "support reset via GPIO line" patch looks generally OK, but
you can't just add fields to the DeviceState vmstate struct -- you'll
break migration from older QEMU versions. The new fields need to
go in a vmstate subsection with an appropriate 'needed' function.

We should definitely make sure we have good documentation for
what device authors should do to implement reset.

thanks
-- PMM

