Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F1C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 07:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67E720862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 07:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67E720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTiXQ-0004Fk-1F
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 03:53:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTiWc-0003vd-OK
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTiWb-0007rq-9C
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTiWa-0007qs-N1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 03:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DED883179165;
	Thu, 23 May 2019 07:52:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E5867651;
	Thu, 23 May 2019 07:52:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 68BE81138648; Thu, 23 May 2019 09:52:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
Date: Thu, 23 May 2019 09:52:21 +0200
In-Reply-To: <CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 May 2019
	16:50:38 +0200")
Message-ID: <87tvdlhakq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 23 May 2019 07:52:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, May 21, 2019 at 4:18 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9, before you invest your time to answer my questions belo=
w: my
>> bandwidth for non-trivial QAPI features like this one is painfully
>> limited.  To get your QAPI conditionals in, I had to postpone other QAPI
>> projects.  I don't regret doing that, I'm rather pleased with how QAPI
>> conditionals turned out.  But I can't keep postponing all other QAPI
>> projects.  Because of that, this one will be slow going, at best.  Sorry
>> about that.
>
> We have different priorities, fair enough.

I wish I could give you better service.  But no use pretending.

>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Hi,
>> >
>> > HMP and QMP commands are handled synchronously in qemu today. But
>> > there are benefits allowing the command handler to re-enter the main
>> > loop if the command cannot be handled synchronously, or if it is
>> > long-lasting. Some bugs such as rhbz#1230527 are difficult to solve
>> > without it.
>> >
>> > The common solution is to use a pair of command+event in this case.
>>
>> In particular, background jobs (qapi/jobs.json).  They grew out of block
>> jobs, and are still used only for "blocky" things.  Using them more
>> widely would probably make sense.
>>
>> > But this approach has a number of issues:
>> > - you can't "fix" an existing command: you need a new API, and ad-hoc
>> >   documentation for that command+signal association, and old/broken
>> >   command deprecation
>>
>> Making a synchronous command asynchronous is an incompatible change.  We
>> need to let the client needs opt in.  How is that done in this series?
>
> No change visible on client side. I dropped the async command support
> a while ago already, based on your recommendations. I can dig the
> archive for the discussion if necessary.

Not right now.

>> > - since the reply event is broadcasted and 'id' is used for matching t=
he
>> >   request, it may conflict with other clients request 'id' space
>>
>> Any event that does that now is broken and needs to be fixed.  The
>> obvious fix is to include a monitor ID with the command ID.  For events
>> that can only ever be useful in the context of one particular monitor,
>> we could unicast to that monitor instead; see below.
>>
>> Corollary: this is just a fixable bug, not a fundamental advantage of
>> the async feature.
>
> I am just pointing out today drawbacks of turning a function async by
> introducing new commands and signals.

And I'm just pointing out that some of today's drawbacks could also be
addressed differently :)

>> > - it is arguably less efficient and elegant (weird API, useless return
>> >   in most cases, broadcast reply, no cancelling on disconnect etc)
>>
>> The return value is useful for synchronously reporting failure to start
>> the background task.  I grant you that background tasks may exist that
>> won't ever fail to start.  I challenge the idea that it's most of them.
>>
>> Broadcast reply could be avoided by unicasting events.  If I remember
>> correctly, Peter Xu even posted patches some time ago.  We ended up not
>> using them, because we found a better solution for the problem at hand.
>> My point is: this isn't a fundamental problem, it's just the way we
>> coded things up.
>>
>> What do you mean by "no cancelling on disconnect"?
>
> When the client disconnects, the background task keeps running, and
> there is no simple way to know about that event afaik. My proposal has
> a simple API for that (see "qmp: add qmp_return_is_cancelled()"
> patch).

Auto-cancellation on client disconnect may be exactly what's wanted for
simple use cases.

Jobs are designed with more use cases in mind.  Consider a backup job
that's take some time.  We certainly don't want to cancel it just
because the management application hiccups and disconnects.  Instead, we
want to permit the management application to recover, reconnect, find
the backup job, examine its state, and resume managing it.  To support
this, jobs have a unique ID.  Job cancellation is explicit.

Jobs could acquire a "auto-cancel on disconnect" feature if there's a
need.

I'm not sure how asynchronous commands could support reconnect and
resume.

>> I'm ignoring "etc" unless you expand it into something specific.
>>
>> I'm also not taking the "weird" bait :)
>> > The following series implements an async command solution instead. By
>> > introducing a session context and a command return handler, it can:
>> > - defer the return, allowing the mainloop to reenter
>> > - return only to the caller (instead of broadcast events for reply)
>> > - optionnally allow cancellation when the client is gone
>> > - track on-going qapi command(s) per client/session
>> >
>> > and without introduction of new QMP APIs or client visible change.
>>
>> What do async commands provide that jobs lack?
>>
>> Why do we want both?
>
> They are different things, last we discussed it: jobs are geared
> toward block device operations,

Historical accident.  We've discussed using them for non-blocky stuff,
such as migration.  Of course, discussions are cheap, code is what
counts.

>                                 and do not provide simple qmp-level
> facilities that I listed above. What I introduce is a way for an
> *existing* QMP command to be splitted, so it can re-enter the main
> loop sanely (and not by introducing new commands or signals or making
> things unnecessarily more complicated).
>
> My proposal is fairly small:
>   27 files changed, 877 insertions(+), 260 deletions(-)
>
> Including test, and the qxl screendump fix, which account for about
> 1/3 of the series.
>
>> I started to write a feature-by-feature comparison, but realized I don't
>> have the time to figure out either jobs or async from their (rather
>> sparse) documentation, let alone from code.
>>
>> > Existing qemu commands can be gradually replaced by async:true
>> > variants when needed, while carefully reviewing the concurrency
>> > aspects. The async:true commands marshaller helpers are splitted in
>> > half, the calling and return functions. The command is called with a
>> > QmpReturn context, that can return immediately or later, using the
>> > generated return helper, which allows for a step-by-step conversion.
>> >
>> > The screendump command is converted to an async:true version to solve
>> > rhbz#1230527. The command shows basic cancellation (this could be
>> > extended if needed). It could be further improved to do asynchronous
>> > IO writes as well.
>>
>> What is "basic cancellation"?
>> What extension(s) do you have in mind?
>
> It checks for cancellation in a few places, between IO. Full
> cancellation would allow to cancel at any time.
>
>>
>> What's the impact of screendump writing synchronously?
>
> It can be pretty bad, think about 4k screens. It is 33177600 bytes,
> written in PPM format, blocking the main loop..

My question was specifically about "could be further improved to do
asynchronous IO writes as well".  What's the impact of not having this
improvement?  I *guess* it means that even with the asynchronous
command, the synchronous writes still block "something", but I'm not
sure what "something" may be, and how it could impact behavior.  Hence
my question.

> QMP operation doing large IO (dumps), or blocking on events, could be
> switched to this async form without introducing user-visible change,

Letting the next QMP command start before the current one is done is a
user-visible change.  We can discuss whether the change is harmless.

> and with minimal effort compared to jobs.

To gauge the difference in effort, we'd need actual code to compare.

