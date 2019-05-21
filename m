Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A561C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D3D21743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODXxVFVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D3D21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT67M-0007qs-30
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:51:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hT66Q-00074Q-J6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hT66O-00077O-UT
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:50:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hT66O-00075R-Nd
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:50:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id b18so18907377wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=JS0X1WDIBQo2R/MfIEWtzIZuPRBkLpAYO9SK+5tqQ/I=;
	b=ODXxVFVvlphZATvQl2VIsZ8aGWxRmnggDPgyMa0+PaqlfELh+Ala71AXLgYzOG+jRv
	LpTJRLjhafJm/Fk347kRjR6QghH+dI2aw0QWglg26AE9eKKMyzGwKXyQw6y+PEyE4ytC
	8A821lQwoq1YZWjARjF5X9gzmowq7UchiGjrleY3to0VPG0B1VDNHJiALKSjk9+gIei6
	owa6Ae5k59xbwjpcg/JdZHHWJ3eWbL5pPQkPSG8UbkIFEAT5tolDEkwogZbi6zDJUOHY
	yHmaV595T8OZgNomjAFwJKgxyyGAjhxkcdD1VD2dXsHdNTcWCaoF1JQlAuK+LuwqvLkB
	L7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=JS0X1WDIBQo2R/MfIEWtzIZuPRBkLpAYO9SK+5tqQ/I=;
	b=ICUMy5eKFfOvnkDfrilw3mvaYNRhe87CxiJeE/lhpVhVSiqdZkPYe+wx0ly8BfQOnE
	05eofMgojC9EbzXwwu81NEd/KL3TDxPGwZcYMg4QI8Xh8Z7BWLfe82FeSxOSQ6b0uZL7
	4ygZNISyWVPEOrt1Qncg6hFZdiz84KkiqtuGGEhlRlXuJBmY0XR66iBUD15X/000Z3fm
	4cob1t/saSa87lsyNBYoxcrhhS7RvF2aKhElcEt61jeb62CHNoe2peVtEJ0AA+73HCOd
	oeC4hqXCtBmoueBO7zziBmYFb51bRFI163l+ZLYUX9OQfESDqA8OdFxajvx7WLqbDzif
	jj0A==
X-Gm-Message-State: APjAAAXmssTRxOmMd/n79ezoXoHGCezxTBVU/+rwvJCF2aj2rUbIrOxA
	v6PA1VFP8QQleE0ST8VeIvdw6HCUDmZhhOckAhsua37A2Lc=
X-Google-Smtp-Source: APXvYqx467aCG6QU+PTODQwHzgpAf7hGfqIf2oxW3Si5P5pnjBjFG17S0mSquReTpgojx2x/ID0V0bpP1SuHQCLP9a8=
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr23111249wre.31.1558450250382; 
	Tue, 21 May 2019 07:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgt7sxhy.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 May 2019 16:50:38 +0200
Message-ID: <CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, May 21, 2019 at 4:18 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9, before you invest your time to answer my questions below=
: my
> bandwidth for non-trivial QAPI features like this one is painfully
> limited.  To get your QAPI conditionals in, I had to postpone other QAPI
> projects.  I don't regret doing that, I'm rather pleased with how QAPI
> conditionals turned out.  But I can't keep postponing all other QAPI
> projects.  Because of that, this one will be slow going, at best.  Sorry
> about that.

We have different priorities, fair enough.

>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi,
> >
> > HMP and QMP commands are handled synchronously in qemu today. But
> > there are benefits allowing the command handler to re-enter the main
> > loop if the command cannot be handled synchronously, or if it is
> > long-lasting. Some bugs such as rhbz#1230527 are difficult to solve
> > without it.
> >
> > The common solution is to use a pair of command+event in this case.
>
> In particular, background jobs (qapi/jobs.json).  They grew out of block
> jobs, and are still used only for "blocky" things.  Using them more
> widely would probably make sense.
>
> > But this approach has a number of issues:
> > - you can't "fix" an existing command: you need a new API, and ad-hoc
> >   documentation for that command+signal association, and old/broken
> >   command deprecation
>
> Making a synchronous command asynchronous is an incompatible change.  We
> need to let the client needs opt in.  How is that done in this series?

No change visible on client side. I dropped the async command support
a while ago already, based on your recommendations. I can dig the
archive for the discussion if necessary.

>
> > - since the reply event is broadcasted and 'id' is used for matching th=
e
> >   request, it may conflict with other clients request 'id' space
>
> Any event that does that now is broken and needs to be fixed.  The
> obvious fix is to include a monitor ID with the command ID.  For events
> that can only ever be useful in the context of one particular monitor,
> we could unicast to that monitor instead; see below.
>
> Corollary: this is just a fixable bug, not a fundamental advantage of
> the async feature.

I am just pointing out today drawbacks of turning a function async by
introducing new commands and signals.

>
> > - it is arguably less efficient and elegant (weird API, useless return
> >   in most cases, broadcast reply, no cancelling on disconnect etc)
>
> The return value is useful for synchronously reporting failure to start
> the background task.  I grant you that background tasks may exist that
> won't ever fail to start.  I challenge the idea that it's most of them.
>
> Broadcast reply could be avoided by unicasting events.  If I remember
> correctly, Peter Xu even posted patches some time ago.  We ended up not
> using them, because we found a better solution for the problem at hand.
> My point is: this isn't a fundamental problem, it's just the way we
> coded things up.
>
> What do you mean by "no cancelling on disconnect"?

When the client disconnects, the background task keeps running, and
there is no simple way to know about that event afaik. My proposal has
a simple API for that (see "qmp: add qmp_return_is_cancelled()"
patch).

>
> I'm ignoring "etc" unless you expand it into something specific.
>
> I'm also not taking the "weird" bait :)
> > The following series implements an async command solution instead. By
> > introducing a session context and a command return handler, it can:
> > - defer the return, allowing the mainloop to reenter
> > - return only to the caller (instead of broadcast events for reply)
> > - optionnally allow cancellation when the client is gone
> > - track on-going qapi command(s) per client/session
> >
> > and without introduction of new QMP APIs or client visible change.
>
> What do async commands provide that jobs lack?
>
> Why do we want both?

They are different things, last we discussed it: jobs are geared
toward block device operations, and do not provide simple qmp-level
facilities that I listed above. What I introduce is a way for an
*existing* QMP command to be splitted, so it can re-enter the main
loop sanely (and not by introducing new commands or signals or making
things unnecessarily more complicated).

My proposal is fairly small:
  27 files changed, 877 insertions(+), 260 deletions(-)

Including test, and the qxl screendump fix, which account for about
1/3 of the series.

> I started to write a feature-by-feature comparison, but realized I don't
> have the time to figure out either jobs or async from their (rather
> sparse) documentation, let alone from code.
>
> > Existing qemu commands can be gradually replaced by async:true
> > variants when needed, while carefully reviewing the concurrency
> > aspects. The async:true commands marshaller helpers are splitted in
> > half, the calling and return functions. The command is called with a
> > QmpReturn context, that can return immediately or later, using the
> > generated return helper, which allows for a step-by-step conversion.
> >
> > The screendump command is converted to an async:true version to solve
> > rhbz#1230527. The command shows basic cancellation (this could be
> > extended if needed). It could be further improved to do asynchronous
> > IO writes as well.
>
> What is "basic cancellation"?
> What extension(s) do you have in mind?

It checks for cancellation in a few places, between IO. Full
cancellation would allow to cancel at any time.

>
> What's the impact of screendump writing synchronously?

It can be pretty bad, think about 4k screens. It is 33177600 bytes,
written in PPM format, blocking the main loop..

QMP operation doing large IO (dumps), or blocking on events, could be
switched to this async form without introducing user-visible change,
and with minimal effort compared to jobs.


--=20
Marc-Andr=C3=A9 Lureau

