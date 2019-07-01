Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8144C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BEB2173E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxlt2/8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BEB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8Z2-0001KB-De
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hi4ZM-0005RM-Py
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hi4ZJ-0003q9-VK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hi4ZJ-0003pY-Nt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so999852wme.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=E94XKKlFAYeJJ9fC8+9WNmnyYOD7z0vtFrqpDycTyH0=;
 b=fxlt2/8GKaGacr1eoDlnsC+9zqekU3G0BQ00oJ1ISDQLi2hy6OWHmY8Brfz1WFiC8i
 Sqc3TNx6GrO/eYxN7Bb5lul1jzLBBvOnn+zQCDjCkq0VcEty51qLQLPcaE2wp1Ay5jNp
 wkquNxsqv+2o6Z1lxtvZV72ZUyty4wY16Nzh7xxZA2VdEDbNLREgxlaYT9a6ewXPjS5O
 6m4YbQFPqBlXtmhUCJYnwSskCvVIT8KTrkNlSdxudpiCHrGcK2Ccj5HCyc0wSzPbXpxH
 0kL/zy1xMEVkTRwGjbKE2srAfeFs0nI5pGYEy9tzM5AvnZSXxvnjac0dVXHv43nrqpvf
 Jovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=E94XKKlFAYeJJ9fC8+9WNmnyYOD7z0vtFrqpDycTyH0=;
 b=Tf2B71cwDGxIggW6IFWGlsRyZBfADCq6g+QcE+NmtrlkTc3OnaQ5w3NLmdx72vSrZp
 CsD8f89/zFXV7O2gp4R4VJmyrJBnDt4Yi+E/X9Spw6YXvUyZEwRM4t0uEqGIy8eayMHk
 0siSamT3XIF/BnZdf13tut4xj/J3J4FWEASoJOjk2Cl0l8IUS4Te3PYps/xhEJqBHSkk
 e19imT+izsrFJ3IMWuqJ+2D0At0wwzJCLJn9EMBCfNAJqa/W+ri+pvspLOsFu0SwX0MX
 iT/pRWcBU8lmrAKM3kFc/tE7Yrh2NRpraMdz6akIzRj/akEnMXMOMX57NXTRwbVP37OE
 Mtkw==
X-Gm-Message-State: APjAAAUN6uDWbIlFPFfEsgT2t8Wo2Zc/Maqm5vKqDhEkHSR7Fl1zOeyu
 9hHrtuDM6Us7rD5rQI+GtcO4OjXtaqY=
X-Google-Smtp-Source: APXvYqw8YzHBggg5wu10nd8hlPzjf61PSkgu0dPn7vl6P60TSPr9qmJdy+iz0ayuHEgAuYT4KVIe7g==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr168058wmk.32.1561999863278; 
 Mon, 01 Jul 2019 09:51:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v204sm208873wma.20.2019.07.01.09.51.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:51:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3DF531FF87;
 Mon,  1 Jul 2019 17:51:02 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <CADYwmhFw8ujwz+NN9prKc+Za6=dD1aN==JnKmC0gnr4V7LPU4w@mail.gmail.com>
 <87r27n8i2f.fsf@zen.linaroharston>
 <CAJhHMCALe5K53OOmXae4dwa9wDn-RbDaPwdS-Xe+eA1PVbRG+Q@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <CAJhHMCALe5K53OOmXae4dwa9wDn-RbDaPwdS-Xe+eA1PVbRG+Q@mail.gmail.com>
Date: Mon, 01 Jul 2019 17:51:02 +0100
Message-ID: <871rz9snpl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 00/50] tcg plugin support
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> On Fri, Jun 21, 2019 at 1:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>> > * Register and memory read/write API
>> >
>> >   It would be great to have register and memory read/write API i.e., a=
bility
>> >   to read/write to registers/memory from within the callback. This giv=
es the
>> >   plugin ability to do system introspection. (Not sure if the current =
patchset
>> >   implements this already).
>>
>> Not currently. The trick is to have something flexible enough without
>> exposing internals. I guess we could consider the gdb register
>> enumeration or maybe hook into stuff declared as
>> tcg_global_mem_new_i[64|32]. That won't get every "register" but it
>> should certainly cover the main general purpose ones. Things like SVE
>> and AdvSIMD vector registers wouldn't be seen though.
>
> I guess general registers could be a good starting point. We can then
> implement arch specific register access APIs.
>
>>
>> > * Register callbacks
>> >
>> >   A callback needs to be invoked whenever a specified registers is rea=
d or
>> >   written to.
>>
>> Again tricky as not every register read/write is obvious from TCG -
>> vector registers tweaked from helpers would be a good example.
>>
>> >
>> > * Where do new plugins live in the tree?
>> >
>> >   The current source files in plugins (api, core etc.,) I think are be=
tter if
>> >   moved to tcg/plugins/.  The various plugins we write would then live=
 in the
>> >   plugins/ folder instead of the current tests/plugin/ folder.
>>
>> The example plugins are really just toys for experimenting with the API
>> - I don't see too much problem with them being in tests. However the
>> howvec plugin is very guest architecture specific so we could consider a
>> bit more of a hierarchy. Maybe these should all live in tests/tcg?
>>
>
> So where do you want 'real' plugins to live in the tree? It would be
> good to think about the structure for those.

I don't see whats wrong with tests/plugins for this. For the upstream
point of view they are there to test and exercise the plugin code.

>
>> >
>> > * Timer interrupts
>> >
>> >   What I observed is that the system execution is affected by what you=
 do in
>> >   the callbacks because of timer interrupts. For example, if you spend=
 time in
>> >   the memory callback doing a bit of processing and writing to a file,=
 you
>> >   will see more timer interrupt instructions. One solution to this wou=
ld be to
>> >   use 'icount', but it does not work that well. I think we need to do
>> >   something similar to what gdb does in debug mode. How would you hand=
le MTTCG
>> >   guests in that case?
>>
>> icount is going to be the best you can get for deterministic time -
>> other efforts to pause/restart virtual time going in and out of plugins
>> are just going to add a lot of overhead.
>
> I wonder why using icount is not working in this case. Are there any
> timers that fire non-deterministically even when icount is used?

Shouldn't be. What sort of problems are you seeing?

>> Remember QEMU doesn't even try to be a cycle accurate emulation so
>> expecting to get reasonable timing information out of these plugins is a
>> stretch. Maybe I should make that clearer in the design document?
>
> It is less about being cycle accurate and more about being
> deterministic. For example, when tracing using plugins+callbacks, you
> will see a lot more interrupt code in the trace than when if you
> execute without tracing. How do we get them to be more similar?
>
> Another idea would be to provide an API for the plugin to generate the
> timer interrupt. This allows the plugin to generate regular interrupts
> irrespective of what is being done in the callbacks.

I don't think allowing plugins to change behaviour of the code is
something we want to consider - at least for v1.

>
>>
>> The gdb behaviour is just a massive hack. When single-stepping in GDB we
>> prevent timer IRQs from being delivered - they have still fired and are
>> pending and will execute as soon as you hit continue.
>>
>> >   Another approach would be to offload callback generation to a separa=
te
>> >   plugin thread. The main thread will copy data required by a callback=
 and
>> >   invoke the callback asynchronously (std::async in C++ if you are
>> >   familiar).
>>
>> This would complicate things - the current iteration I'm working on
>> drops the haddr cb in favour of dynamically resolving the vaddr in the
>> callback. But that approach is only valid during the callback before
>> something else potentially pollutes the TLB.
>>
>
>> >
>> > * Starting and stopping callback generation
>> >
>> >   It would be great if we have a mechanism to dynamically start/stop c=
allbacks
>> >   when a sequence of code (magic instruction) is executed. This would =
be
>> >   useful to annotate region-of-interest (ROI) in benchmarks to
>> > generate callbacks.
>>
>> Well we have that now. At each TB generation event the callback is free =
to register
>> as many or few callbacks as it likes dynamically.
>
> But how does the plugin know that the TB being generated is the first
> TB in the ROI?

It has to track the information - I assume by a combination of looking
at addresses or looking through the instruction patterns.

> Similarly the plugin needs to know the then end of ROI has been reached.
>
> Also, please note that there can be multiple ROIs. It would be good to
> know if we can assign ids to each ROI for the plugin.

This all sounds like stuff the plugin can do for itself. What else does
it need to know from QEMU?

--
Alex Benn=C3=A9e

