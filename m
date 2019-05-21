Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC6C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C10621773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C10621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5bo-0001Bt-2F
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:19:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hT5aF-0000Qb-Iw
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hT5aB-0003D6-Pk
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hT5a9-0002pT-Tw
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:17:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D96D88830A;
	Tue, 21 May 2019 14:17:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F9371001F5B;
	Tue, 21 May 2019 14:17:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 854301138648; Tue, 21 May 2019 16:17:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
Date: Tue, 21 May 2019 16:17:13 +0200
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 Apr 2019 18:09:49 +0200")
Message-ID: <87sgt7sxhy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 21 May 2019 14:17:21 +0000 (UTC)
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
	qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9, before you invest your time to answer my questions below: =
my
bandwidth for non-trivial QAPI features like this one is painfully
limited.  To get your QAPI conditionals in, I had to postpone other QAPI
projects.  I don't regret doing that, I'm rather pleased with how QAPI
conditionals turned out.  But I can't keep postponing all other QAPI
projects.  Because of that, this one will be slow going, at best.  Sorry
about that.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> HMP and QMP commands are handled synchronously in qemu today. But
> there are benefits allowing the command handler to re-enter the main
> loop if the command cannot be handled synchronously, or if it is
> long-lasting. Some bugs such as rhbz#1230527 are difficult to solve
> without it.
>
> The common solution is to use a pair of command+event in this case.

In particular, background jobs (qapi/jobs.json).  They grew out of block
jobs, and are still used only for "blocky" things.  Using them more
widely would probably make sense.

> But this approach has a number of issues:
> - you can't "fix" an existing command: you need a new API, and ad-hoc
>   documentation for that command+signal association, and old/broken
>   command deprecation

Making a synchronous command asynchronous is an incompatible change.  We
need to let the client needs opt in.  How is that done in this series?

> - since the reply event is broadcasted and 'id' is used for matching the
>   request, it may conflict with other clients request 'id' space

Any event that does that now is broken and needs to be fixed.  The
obvious fix is to include a monitor ID with the command ID.  For events
that can only ever be useful in the context of one particular monitor,
we could unicast to that monitor instead; see below.

Corollary: this is just a fixable bug, not a fundamental advantage of
the async feature.

> - it is arguably less efficient and elegant (weird API, useless return
>   in most cases, broadcast reply, no cancelling on disconnect etc)

The return value is useful for synchronously reporting failure to start
the background task.  I grant you that background tasks may exist that
won't ever fail to start.  I challenge the idea that it's most of them.

Broadcast reply could be avoided by unicasting events.  If I remember
correctly, Peter Xu even posted patches some time ago.  We ended up not
using them, because we found a better solution for the problem at hand.
My point is: this isn't a fundamental problem, it's just the way we
coded things up.

What do you mean by "no cancelling on disconnect"?

I'm ignoring "etc" unless you expand it into something specific.

I'm also not taking the "weird" bait :)

> The following series implements an async command solution instead. By
> introducing a session context and a command return handler, it can:
> - defer the return, allowing the mainloop to reenter
> - return only to the caller (instead of broadcast events for reply)
> - optionnally allow cancellation when the client is gone
> - track on-going qapi command(s) per client/session
>
> and without introduction of new QMP APIs or client visible change.

What do async commands provide that jobs lack?

Why do we want both?

I started to write a feature-by-feature comparison, but realized I don't
have the time to figure out either jobs or async from their (rather
sparse) documentation, let alone from code.

> Existing qemu commands can be gradually replaced by async:true
> variants when needed, while carefully reviewing the concurrency
> aspects. The async:true commands marshaller helpers are splitted in
> half, the calling and return functions. The command is called with a
> QmpReturn context, that can return immediately or later, using the
> generated return helper, which allows for a step-by-step conversion.
>
> The screendump command is converted to an async:true version to solve
> rhbz#1230527. The command shows basic cancellation (this could be
> extended if needed). It could be further improved to do asynchronous
> IO writes as well.

What is "basic cancellation"?

What extension(s) do you have in mind?

What's the impact of screendump writing synchronously?

