Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AC32173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7TFWWcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6CU-0001eH-NQ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6BV-00011Y-Il
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6BU-0002rX-7n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT6BU-0002rA-1H
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:08 -0400
Received: by mail-ot1-x344.google.com with SMTP id s19so16606543otq.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DG4luh4FkZE05yxH4wHEsX91aEXAABS6U0fcL8uaAJI=;
	b=S7TFWWcBygMUbcK6eIp+lYBNbare8oLB/XNXuFdfe/6Ca1MLdgrKC9bH6TSlYvIFNQ
	3QxeivXuwCOGfIbdXeK2pzhxFwsZbJlxeSoAD4fg347LiuqztmwP7mACXdCsQy1b/ObK
	f3nvV1vTTJ+NlO7XEVTiNmUf1EgWz5xssN0z3ZwZSnRg20cEkZo2XlzgNUTPZnClZdAv
	bCP34h7PvdJ5x1in/yJWVz0HLgRZ0ch8/eibfQRWWlwwTOR5DSnouQn+yULBbvEkKDl6
	4QgpH76i3fCOxc8iOibQ7vHC2v5bG+AHtn39XNfDWy3tmCYagidTqqMT+v1aiNxnRZPF
	OleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DG4luh4FkZE05yxH4wHEsX91aEXAABS6U0fcL8uaAJI=;
	b=WHjkOomVoGrHm+QjZ/AcskAJJ0Saa7nGy9IBHII5097T4QOVFQ3pxh/QDet7QU7BCA
	cHqj15iK/LKLupkBVFXdmbWvdlHXqJp4EaRLjP6QJivtymvbPv7tEboEOuP9g1hKc0w2
	UIXoxIwp2SyW7G5f8gwKmGm+kPg+lLiAuN/sQw/RbJPbleJPf59W8kZ1joqLNoznpuLI
	kA5C5/zEBVYHAHhCq34oxYPFoOdeDQu10/3P+Flu6BLC/2ZT2+JQudZXhzLRtutpOJuu
	OWhOiBQ6uCHNT5fiHa0KbCb6N/yRD+TCEz4i6AVszpuO+KnD9qPOOQTwgFiAlfCTW5LI
	Onng==
X-Gm-Message-State: APjAAAWnQjSm0Xt3ZX+3lNrXqPcEv8AWDJo264y46TZ1ayo78eGv6U+8
	PMLfhzippHzrsbMn+oRpFwJuq+NxvBccZPc6yDlRUQ==
X-Google-Smtp-Source: APXvYqzAtAfc0CMzugTOGC3WvSksx9ANq7XjwX8Cl0lILD+xUzCXnGfg3W21UBcy9wXaR/S5YlHlKgKGgsU8B6Lxljk=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr20064898otq.221.1558450567033; 
	Tue, 21 May 2019 07:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
In-Reply-To: <87imu3swp2.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 15:55:56 +0100
Message-ID: <CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Tue, 21 May 2019 at 15:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> Damien Hedde <damien.hedde@greensocs.com> writes:
>
> > On 5/16/19 11:19 AM, Peter Maydell wrote:
> >> On Thu, 16 May 2019 at 06:37, Markus Armbruster <armbru@redhat.com> wrote:
> >>>
> >>> A registry of callbacks to run on certain events is a fine technique.
> >>> Relying on registration order, however, is in bad taste.  We should
> >>> model dependencies between reset functions explicitly.
> >>
> >> That might be nice, but in practice we have no such model at
> >> all, and I don't think I've seen anybody propose one.
>
> Well, we do have qbus_reset_all() & friends reset buses and devices in
> post order.  That's a model, isn't it?  I guess it can't model *all*
> dependencies.  Still, shouldn't we use it wherever it actually suffices?

It's a well-defined order, but it doesn't actually help in a
lot of cases, because often the thing you care about ordering
on is not a device or is not in the same tree as the thing
it depends on. (For instance, there's an annoying ordering
issue between the rom-loader's "reset" function which copies rom
blob contents into RAM, and the Arm M-profile CPU reset method,
which needs to read the starting PC and SP out of RAM. [*])
It's also still an implicit ordering, in the sense that if
there's a dependency between device A (in subtree A') and device
B (in subtree B') then this will all work fine up until somebody
at the top level innocently reorders A' and B' in the list of
children of their mutual parent for some reason and then finds
they've broken an implicit dependency.

[*] aside: this one would actually be fixed by the multi-phase reset
proposal, since the definition of the reset phases is such that
the rom-loader should write to memory in phase 2 ('hold') and
the CPU should read from it in phase 3 ('exit').

> hw/input/pckbd.c is instructive.  The qemu_register_reset() in
> i8042_mm_init() is inded for a non-qdevified device.  The one in
> i8042_realizefn() has no such excuse.
>
> Does not contradict what you wrote, of course.  Still, shouldn't we at
> least get rid of the latter kind?

Yes, absolutely. Also we should qdevify the non-qdev devices.
This part is something where we have a clear path forwards
for making cleanups (no tricky design decisions/debate required),
it just requires somebody to write the actual code.

> >> The other reason for having to have a qemu_register_reset() handler
> >> to reset something that's a Device is if that Device is not on
> >> a qbus. The most common example of this is CPUs -- since those
> >> don't have a bus to live on they don't get reset by the "reset
> >> everything that's on a QOM bus reachable from the main system
> >> bus" logic. I'm not sure what the nicest way to address this is:
> >> transitioning away from "reset of devices is based on the qdev tree"
> >> to something else seems between difficult and impossible, even
> >> though logically speaking the QOM tree is in many cases closer
> >> to the actual hardware hierarchy of reset.
> >
> > One "solution" to reduce the qemu_register_reset usage would be to do
> > handle in the Device base class (at creation or realize) if it has no
> > parent bus like it is done for buses. But this would probably have an
> > impact on reset ordering.
>
> I'm afraid *any* improvement will have an impact on reset ordering.
> Most reorderings will be just fine.  How terrible could the
> less-than-fine ones be?

If you get "CPU reset" and "built in bootloader sets the PC to the
initial address specified by the -kernel file" the wrong way around
then we break booting :-)

> >>> Registered handlers run in (implicitly defined) registration order,
> >>> reset methods in (explicit) qdev tree post order.  Much better as long
> >>> as that's the order we want.
> >>>
> >>> Say we managed to clean up this mess somehow, so reset handler
> >>> registration order doesn't matter anymore.  Then moving the
> >>> qemu_register_reset() for main_system_bus from main() to wherever we
> >>> create main_system_bus would make sense, wouldn't it?
> >>
> >> I guess so... (There's an argument that the main system bus
> >> should be a child bus of the Machine object, logically speaking,
> >> but Machines aren't subtypes of Device so that doesn't work.)
>
> We could replace the special case "bus's parent is null" by the special
> case "bus's parent is a machine instead of a device", but I'm not sure
> what exactly it would buy us.

It's mostly just logically neater -- you could imagine a future
QEMU version that supported one simulation which had models
of more than one machine simultaneously, in which case there
ought to be two system buses, one per machine. And it's
logical that vl.c has to create the machine that the user
asked for, but it's a bit odder that it also has to create the
system bus specially extra, even though it's really just part
of the machine. But as I say, because Machine isn't a subtype of
Device you can't make buses be children of Machine anyway.
Fixing that is more effort than would be warranted for "it looks
slightly nicer this way around".

thanks
-- PMM

