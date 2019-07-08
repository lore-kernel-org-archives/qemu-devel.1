Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D8C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 02:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B8020665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 02:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMkzvG1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B8020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkJlP-00023D-1y
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 22:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hkJkk-0001cF-37
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 22:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hkJki-0002Kt-1D
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 22:51:42 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hkJkh-0002KH-R6
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 22:51:39 -0400
Received: by mail-qt1-x842.google.com with SMTP id a15so16607091qtn.7
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2019 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V/DkqYPUPZAUgQbAVxnCSRE9Q6fe5Vn18f3vUzkd9Qc=;
 b=aMkzvG1f7JRGNIldieGUtulw9vSUysLaO6NhdOTxJlqws/D+bAJd+zpsLVw+1LMHOV
 f5Nue6gngUIJQfSzbdneADLWEagEePvaFjoFNt/Kw2JST/zWbNXDRmG1htHbw+pcuMow
 6wuoWM5gGo0RDdaQ2jtJ9kfhwQ409FSkwzhUOrv29UlTa6mG6dvQOEQZJwCHlRbHhQVp
 +znyRZk1DnsKLKDjudaWZtF37Vy9L1UYofC2PiewAW8ugM16xpliZURJu88TpmIGfcEv
 gsswaxqL2VbJyAl8RaxAeZbxYMG4jnJ8HhLNXndT8J7oyxHpRASkpsmNPpfzm1ODUo6Y
 /UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V/DkqYPUPZAUgQbAVxnCSRE9Q6fe5Vn18f3vUzkd9Qc=;
 b=f0lA+RDmJLZOG5Qzh1jw6DarVpfN2fu/j/VNrpcEIosYoeEjISj0BU49HmLNRcroap
 oJSLsv3lvn9E1VHGeqBDgfcQ9sKRYBItW6UsbwYiqdjNrggD8/47FYrBsDWSksiK7lMr
 zqYKL79CtJ3OnezNKB/ApEOgh9inAHvXDkEekCugzSSUdHSDCdxm+FWgU6A0CL/aHSc6
 i3zCJ69g0omqJnlRlZwY4bO60tQat/Kt1kbKG/1YisA8ySuX/0EYCGE9Qas16hIjX6UG
 dozB9mYFfP2VaCDJXoCO+6Jmz91bpAZaw1Am6gVJ7S5DtLj3MQc20JDa8vC8S+D5+OPW
 Zq8A==
X-Gm-Message-State: APjAAAXrffMwLuRyqvhREpTaADJm32L83I0pFoe1cXryDtFXqMRukoPe
 kYsx8GHdrXsoYIQjfYLXF20G/wp51JVA9rMVJgA=
X-Google-Smtp-Source: APXvYqxswkoj5WZAUpBkHt136mSPdhQjEL0veyIW0WtNdc3vaUOCYc8SnpYkL3MNN6NL0unQzzrmLykv08uQQj1b+NE=
X-Received: by 2002:a0c:c3c7:: with SMTP id p7mr12744064qvi.125.1562554297524; 
 Sun, 07 Jul 2019 19:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
 <877e8wk2nm.fsf@dusky.pond.sub.org> <87tvc0v99m.fsf@zen.linaroharston>
 <87lfxbelsl.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfxbelsl.fsf@dusky.pond.sub.org>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Sun, 7 Jul 2019 23:51:26 -0300
Message-ID: <CAMzYVD2PdctttsTeZm8hPcyip-Cm8Y3ZJBEM1Mj_WQRB1M6c=w@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus,

Thank you for your comments! Based on your questions and suggestions of
writing a more complete explanation in my commits, I decided to start to
describe our whole work on the wiki:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality
I will update and expand it weekly, so I can link and cite it in future
patches to give a better whole vision for anyone interested.

Btw, thank you for your QMP tips, I will discuss with Alex how to address
it in our approach.

[]'s
Vanderson M. Rosario


On Sat, Jul 6, 2019 at 3:09 AM Markus Armbruster <armbru@redhat.com> wrote:

> Cc: Marc-Andr=C3=A9, who has patches that might be useful here.
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> vandersonmr <vandersonmr2@gmail.com> writes:
> >>
> > <snip>
> >
> > I'll leave Vanderson to address your other comments.
> >
> >>
> >> Debugging commands are kind of borderline.  Debugging is commonly a
> >> human activity, where HMP is just fine.  However, humans create tools =
to
> >> assist with their activities, and then QMP is useful.  While I wouldn'=
t
> >> encourage HMP-only for the debugging use case, I wouldn't veto it.
> >>
> >> Your (overly terse!) commit message and help texts make me guess the
> >> commands are for gathering statistics.  Statistics can have debugging
> >> uses.  But they often have non-debugging uses as well.  What use cases
> >> can you imagine for these commands?
> >
> > So this is all really aimed at making TCG go faster - but before we can
> > make it go faster we need better tools for seeing where the time is
> > being spent and examining the code that we generate. So I expect the
> > main users of this functionality will be QEMU developers.
> >
> > That said I can see a good rationale for supporting QMP because it is
> > more amenable to automation. However this is early days so I would
> > caution about exposing this stuff too early least we bake in a woolly
> > API.
>
> Development tools should exempt themselves from QMP's interface
> stability promise: prefix the command names with 'x-'.
>
> > The other wrinkle is we do have to take control of the emulator to
> > safely calculate some of the numbers we output. This essentially means
> > the HMP commands are asynchronous - we kick of safe work which waits
> > until all vCPU threads are stopped before we go through the records and
> > add up numbers. This is fine for the HMP because we just output to the
> > monitor FD when we are ready. I assume for QMP commands there is more
> > housekeeping to do? Can QMP commands wait for a response to be
> > calculated by another thread? Are there any existing commands that have
> > to support this sort of pattern?
>
> Let me clarify "synchronous" to avoid confusion.
>
> Both QMP and HMP commands are synchronous protocols in the sense that
> commands are executed one after the other, without overlap.  When a
> client sends multiple commands, it can assume that each one starts only
> after the previous one completed.
>
> Both HMP and QMP commands execute synchronously in the sense that the
> command runs to completion without ever yielding the thread.  Any
> blocking operations put the thread to sleep (but see below).
>
> HMP runs in the main thread.  Putting the main thread to sleep is
> generally undesirable.
>
> QMP used to run in the main thread, too.  Nowadays, the QMP core runs in
> an I/O thread shared by all monitors, and dispatches commands to the
> main thread.  Moving command execution out of the main thread as well
> requires careful review of the command's code for hidden assumptions.
> Major project.
>
> Fine print: OOB commands are a special case, but I doubt you want to
> know more.
>
> Fine print: certain character devices can't support use of an I/O
> thread; QMP runs in the main thread then.  The ones you want to use with
> QMP all support I/O threads.
>
> You wrote "we kick of safe work which waits until all vCPU threads are
> stopped before we go through the records and add up numbers [...] we
> just output to the monitor FD".  Does this mean the HMP command kicks
> off the work, terminates, and some time later something else prints
> results to the monitor?  How much later?
>
> If "later" is actually "soon", for a suitable value of "soon",
> Marc-Andr=C3=A9's work on "asynchronous" QMP might be pertinent.  I put
> "asynchronous" in scare quotes, because of the confusion it has caused.
> My current understanding (Marc-Andr=C3=A9, please correct me if wrong): i=
t
> lets QMP commands to block without putting their thread to sleep.  It
> does not make QMP an asynchronous protocol.
>
> If "later" need not be "soon", read on.
>
> In QMP, there are two established ways to do potentially long-running
> work.  Both ways use a command that kicks off the work, then terminates
> without waiting for it to complete.
>
> The first way is traditional: pair the kick off command with a query
> command and optionally an event.
>
> When the work completes, it fires off the event.  The event is broadcast
> to all QMP monitors (we could implement unicast if we have a compelling
> use case).
>
> The query command reports whether the work has completed, and if yes,
> the work's results, if any.
>
> You need the event if you want to avoid polling.
>
> Even with an event, you still need a query command.  If your management
> application loses its QMP connection temporarily, you can miss the
> event.  You want to poll on reconnect, with the query command.
>
> If more than one instance of the work can be pending at any one time,
> event and query need to identify the instance somehow.  This is
> completely ad hoc.
>
> The second way is a full-blown "job".  This provides more control: you
> can cancel, pause, resume, ...  It also provides a job ID.  More
> featureful and more structured.
>
> Jobs have grown out of block jobs.  I'd love to see some uses outside
> the block subsystem.
>
> Hope this helps!
>
