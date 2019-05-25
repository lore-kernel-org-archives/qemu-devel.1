Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38911C282E5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 12:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBD42175B
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFpT3Mrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBD42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUVZw-0002Js-V8
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 08:15:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hUVYP-0001XJ-0o
	for qemu-devel@nongnu.org; Sat, 25 May 2019 08:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hUVXG-0002me-CW
	for qemu-devel@nongnu.org; Sat, 25 May 2019 08:12:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hUVXG-0002lM-67
	for qemu-devel@nongnu.org; Sat, 25 May 2019 08:12:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so12442561wrs.5
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=eYfocmhPDINnTz5r4utBlTegy9zwuqUqzrk//YNp/hk=;
	b=IFpT3MrfuK/Zeb5UglWd4o706+HGLuMoji5t16W0xgXn3/pX5Xu3U10LkhRDencwbk
	AA3D7CTjfH5LvXlJp1pu6tCdJLAaVAjNjuPrX1al8dijxVx19RlKUCuXGCZzPQ8eAcmp
	lo1h2r/HSV/bS8EaAPjbdfPz7i9Ij+q+NEjXHGDCyYx6ZBZNG9HQ1HrioGvaysmx7yz5
	sYvQ3rw8vTGdRotyTk6HnBjZM5wjPb2APG+wT2mzKiFmuWE+VVTWUUBClIEaFvxwUd+/
	rc9Ng+YGLuJpx2krwEp5dnh0jHs+XrXmM9alLBMKx4smcXKOuJgCgoG9axdMrhgd46xG
	hp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=eYfocmhPDINnTz5r4utBlTegy9zwuqUqzrk//YNp/hk=;
	b=NgYMJwviCZLN9iccmkKrGYCrdC9NV9Uosel5mn2NoNdSCY3WE9TOHVQBBbNixkdqf8
	Q/RLBK+/9/RQiuhduwDjT0o/k21HItCFqHFIxR8/oSak644ppTsSDkgq83/+VJKP9iCb
	htNX198XToIii6Y6aHSF07ZcAvgtcfnnSzx5u+7E6LMMifXe012dugEuZ5XACtC31pQL
	RhCtG9AblqDfN5+GOcbwbs0Zq157mdqtz4MsVHnqvlFpXOKTIHC5+mwAwjysaRARULPl
	WIJkYHKGFXC6myfgCSW9nvQygUtIOBnZl91lT1oDAbld8fln0EOZtwOIPELxCfYyo4kj
	zDLg==
X-Gm-Message-State: APjAAAX+Rn9nCCmzuqKLXmVpzwpUqI1iUNQ9hPTQu73XEFM6eqbZvYx7
	WnicEWnqv2ml2d7ArkdkSSTggB0ShmHsF2zgqRQ=
X-Google-Smtp-Source: APXvYqwH7vUr36wVeoPOC5nwzo5EqjfYIufUEzDe1uterpl+htXG7rS0pQssAm9kHK4eK66hEE3zdipW7VefD2eRNpo=
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr11330597wrn.201.1558786344430; 
	Sat, 25 May 2019 05:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	<87tvdlhakq.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvdlhakq.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 25 May 2019 14:12:12 +0200
Message-ID: <CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
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

On Thu, May 23, 2019 at 9:52 AM Markus Armbruster <armbru@redhat.com> wrote=
:
> I'm not sure how asynchronous commands could support reconnect and
> resume.

The same way as current commands, including job commands.

>
> >> I'm ignoring "etc" unless you expand it into something specific.
> >>
> >> I'm also not taking the "weird" bait :)
> >> > The following series implements an async command solution instead. B=
y
> >> > introducing a session context and a command return handler, it can:
> >> > - defer the return, allowing the mainloop to reenter
> >> > - return only to the caller (instead of broadcast events for reply)
> >> > - optionnally allow cancellation when the client is gone
> >> > - track on-going qapi command(s) per client/session
> >> >
> >> > and without introduction of new QMP APIs or client visible change.
> >>
> >> What do async commands provide that jobs lack?
> >>
> >> Why do we want both?
> >
> > They are different things, last we discussed it: jobs are geared
> > toward block device operations,
>
> Historical accident.  We've discussed using them for non-blocky stuff,
> such as migration.  Of course, discussions are cheap, code is what
> counts.

Using job API means providing new (& more complex) APIs to client.

The screendump fix here doesn't need new API, it needs new internal
dispatch of QMP commands: the purpose of this series.

Whenever we can solve things on qemu side, I would rather not
deprecate current API.

> >                                 and do not provide simple qmp-level
> > facilities that I listed above. What I introduce is a way for an
> > *existing* QMP command to be splitted, so it can re-enter the main
> > loop sanely (and not by introducing new commands or signals or making
> > things unnecessarily more complicated).
> >
> > My proposal is fairly small:
> >   27 files changed, 877 insertions(+), 260 deletions(-)
> >
> > Including test, and the qxl screendump fix, which account for about
> > 1/3 of the series.
> >
> >> I started to write a feature-by-feature comparison, but realized I don=
't
> >> have the time to figure out either jobs or async from their (rather
> >> sparse) documentation, let alone from code.
> >>
> >> > Existing qemu commands can be gradually replaced by async:true
> >> > variants when needed, while carefully reviewing the concurrency
> >> > aspects. The async:true commands marshaller helpers are splitted in
> >> > half, the calling and return functions. The command is called with a
> >> > QmpReturn context, that can return immediately or later, using the
> >> > generated return helper, which allows for a step-by-step conversion.
> >> >
> >> > The screendump command is converted to an async:true version to solv=
e
> >> > rhbz#1230527. The command shows basic cancellation (this could be
> >> > extended if needed). It could be further improved to do asynchronous
> >> > IO writes as well.
> >>
> >> What is "basic cancellation"?
> >> What extension(s) do you have in mind?
> >
> > It checks for cancellation in a few places, between IO. Full
> > cancellation would allow to cancel at any time.
> >
> >>
> >> What's the impact of screendump writing synchronously?
> >
> > It can be pretty bad, think about 4k screens. It is 33177600 bytes,
> > written in PPM format, blocking the main loop..
>
> My question was specifically about "could be further improved to do
> asynchronous IO writes as well".  What's the impact of not having this
> improvement?  I *guess* it means that even with the asynchronous
> command, the synchronous writes still block "something", but I'm not
> sure what "something" may be, and how it could impact behavior.  Hence
> my question.

It blocks many things since the BQL is taken.

The goal is not to improve responsiveness at this point, but to fix
the QXL screendump bug, by introducing a split dispatch in QMP
commands: callback for starting, and a separate return function. This
is not rocket science. See below.

>
> > QMP operation doing large IO (dumps), or blocking on events, could be
> > switched to this async form without introducing user-visible change,
>
> Letting the next QMP command start before the current one is done is a
> user-visible change.  We can discuss whether the change is harmless.

Agree, from cover letter:
Existing qemu commands can be gradually replaced by async:true
variants when needed, while carefully reviewing the concurrency
aspects.

>
> > and with minimal effort compared to jobs.
>
> To gauge the difference in effort, we'd need actual code to compare.

It's a no-go to me, you don't want to teach all users out there with
new job API for existing commands when you can improve or fix things
in QEMU.

The QEMU change for the command can't really be simpler than what I
propose. You go from:

qmp_foo() {
  // do foo synchronously and
  return something
}

to:

qmp_foo_async(QmpReturn *r) {
  // do foo asynchronously (or return synchronously)
}

foo_done() {
  qmp_foo_async_return(r, something)
}

See "scripts: learn 'async' qapi commands" for the details.

thanks

--=20
Marc-Andr=C3=A9 Lureau

