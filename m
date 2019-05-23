Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECF7C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CEA2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AX+mH2vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CEA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60081 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjVP-0001C0-PZ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:55:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjUe-0000s0-JO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjUc-0004HC-T5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:54:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTjUc-0004G2-7U
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:54:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id f4so3786672oib.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=uE5VxEx8wjMa6cvANabB1oB/rZD3/iVd2X9J0OMIccI=;
	b=AX+mH2vCpJ66D9iCsMQoRe3bjSSDIpWp+NzOv8tSs+gDvXDEsvpeh+I1h+PMEx2sgI
	LaaKPRQAoxhjAPK78HyF8+STclHLSXMTaBdDyT9RI7VgHmAHdQqz0dMRdH1Q30lILioo
	CgO6H5UiEka2LXUwDeTsrADMCw+OGAq/EwADHnQBu++P2NzE3Pwt0UbwFhk9wJayGhEq
	zTag3roCZiCIMNa8vtfM6wrYOtrBVG2pX2+yyljkzMeJTlbQ4/q2wVnB/SPyFIeVtGA1
	0VMujFK35mYlIexTxbVwdq5oYd3u7kEQx/u7xTZA7/9UWjN7w4UhJsfV3Ev/1zz2A5Yk
	zJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=uE5VxEx8wjMa6cvANabB1oB/rZD3/iVd2X9J0OMIccI=;
	b=g2CCcit58ZvQ9WMSqeY3DWZUtPJi4wMmHPP0eg28+fskit4MuAXQTb31EbT/OSIHSU
	x79wSNpDJh0WxeM76HhGoaeCYO3/ebbajcBiBd25DE2v/AREtlnu+7SuzbOTkrPU37F/
	B/ZWws1sFT/djSOHs9XzWKR7L3oIuQlSaVw3xVrN0lR+8g2nvJ49WICTUuxe6bSXqCA8
	O9yDc6M3+UrEeLhaoXpZHic3ij7vZND5scIjnyF83AxDPu79Xp6FBFyohzwYwOLqpAoQ
	70KHqMIJMUtb/2egM9fX5gnVobTQEYrl/dPxwAIwRGnmA9oeIZyfL44o35bhigv5Y4VC
	q7MA==
X-Gm-Message-State: APjAAAUXA90C49iUkkZlJza1iSXN5PT3SgJZdJNiB7fA21F7EhrtlxWp
	FyhYEYtA7yw7jDAy8isN6zcl6DeKsTHFJR4BrWk0Vg==
X-Google-Smtp-Source: APXvYqwnxVEcZSryz0Fq5hYywbqYipAH2vN0w8pJkXzuFQs6jJNssM/CQGeIrfJCUhGprF7CjmjMFw93bYlDVgemwaY=
X-Received: by 2002:aca:845:: with SMTP id 66mr2019458oii.163.1558601668570;
	Thu, 23 May 2019 01:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	<87ef4pisja.fsf@dusky.pond.sub.org>
In-Reply-To: <87ef4pisja.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 09:54:17 +0100
Message-ID: <CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Thu, 23 May 2019 at 07:39, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > It's a well-defined order, but it doesn't actually help in a
> > lot of cases, because often the thing you care about ordering
> > on is not a device or is not in the same tree as the thing
> > it depends on.
>
> Dependencies need some kind of connection.
>
> In the physical world, connections are a scarce resource.  This leads to
> somewhat regular dependencies.  Reset order follows wiring.  The wiring
> isn't always a tree, but it's tree-like enough to make trees a useful
> concept there.

I would say rather than in the physical world reset tends
to happen in parallel -- somebody pulls a reset line high
and everything connected to it simultaneously goes into a
state where it resets its internal state, and stays there.
Things like "don't read PC before memory is initialized" tend
to be handled by "memory is initialized while the CPU is being
held in reset, and then the CPU only reads it when it *leaves*
the reset state". (So the suggested multi-phasing does try
to make our emulation match the real hardware).

There is also some 'tree-like' behaviour in that where a
collection of devices can all be reset at once this is usually
based on the "composition tree", eg if you reset an SoC then
it's resetting all the devices in the SoC. Unfortunately QEMU's
qbus tree does not at all match this "composition tree". Our
QOM object tree gets closer, but I have no idea how you might
get from the qbus-reset world we have today to a world where
reset propagated down the QOM object tree.

> >> hw/input/pckbd.c is instructive.  The qemu_register_reset() in
> >> i8042_mm_init() is inded for a non-qdevified device.  The one in
> >> i8042_realizefn() has no such excuse.
> >>
> >> Does not contradict what you wrote, of course.  Still, shouldn't we at
> >> least get rid of the latter kind?
> >
> > Yes, absolutely. Also we should qdevify the non-qdev devices.
> > This part is something where we have a clear path forwards
> > for making cleanups (no tricky design decisions/debate required),
> > it just requires somebody to write the actual code.
>
> After all these years, the transition to qdev is still incomplete, and
> the incompleteness still bogs us down.
>
> We don't even know what still needs to be converted.  If we had a list
> of such device models, and which machines depend on them, we could apply
> a bit more force to the problem.

In this case we *do* have a clear list of things to fix:
we just need to search for places that are directly calling
qemu_register_reset() (and weed out the handful of "no, really
not a device" false positives). I think that this is actually
the case for most situations where failure-to-qdevify is a
blocker -- it's a blocker because there's a particular API we
want to get rid of or clean up or whatever, and then we just
need to look for uses of the API. If there happen to be non-qdev
devices which (perhaps buggily) don't use the API, we don't
need to care about them because they don't block us from the cleanup.

> >> I'm afraid *any* improvement will have an impact on reset ordering.
> >> Most reorderings will be just fine.  How terrible could the
> >> less-than-fine ones be?
> >
> > If you get "CPU reset" and "built in bootloader sets the PC to the
> > initial address specified by the -kernel file" the wrong way around
> > then we break booting :-)
>
> Wonderfully unsubtle failure!  Even the stupidest of smoke tests should
> catch it.
>
> Would you be willing to hazard a guess on the risk of creating bugs
> subtle enough to survive basic smoke tests?

Probably quite high, given that we don't have very good test
coverage even for 'basic smoke tests', and we certainly don't
have a smoke test that covers every device model. Which doesn't
mean we should be afraid of touching reset ordering entirely:
it just means that for this particular patch I wanted to
play safe, because "remove a TODO comment" doesn't seem like a
solid enough payoff for running the risk.

thanks
-- PMM

