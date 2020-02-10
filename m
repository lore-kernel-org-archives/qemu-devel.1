Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F259C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B68B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCYy5Thl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B68B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j189y-00037Z-GX
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j189M-0002QC-SS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j189J-0004wu-Fa
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:26:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j189J-0004wP-A3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581337608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJOUdqnRoX4n5q15YShb09JIW4Qe1yDZFMTL6QZ8I94=;
 b=RCYy5ThlTZYM3iU2HOd12w974i1hVMMqbD2GNQ3ChHQd9j+rc9UrNdc2RBIP1opN9VaOq9
 US33W427GHLuEz5+9eTg/V/ptoyF1HAlu+GNs0wLEMxKa88gij1EGsRWm32ExGzlaLLpnu
 /JiYrzXGkeQEW6uc9xRq5nwRPAh7+Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-I9YOcEN8OR2w9pNrsLk65w-1; Mon, 10 Feb 2020 07:26:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65E5A107ACC5;
 Mon, 10 Feb 2020 12:26:42 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 535A790F57;
 Mon, 10 Feb 2020 12:26:31 +0000 (UTC)
Date: Mon, 10 Feb 2020 13:26:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200210122630.GB5955@linux.fritz.box>
References: <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206142143.GA4926@linux.fritz.box>
 <e0c6b15c-5411-6112-0327-ef9d51424153@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e0c6b15c-5411-6112-0327-ef9d51424153@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: I9YOcEN8OR2w9pNrsLk65w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.02.2020 um 22:23 hat John Snow geschrieben:
> On 2/6/20 9:21 AM, Kevin Wolf wrote:
> > I think this subthread shows that we actually have many separate
> > projects that people wish to have someone work on. Each of them is
> > probably a bit too small for a whole GSoC, but all of them together are
> > probably too much. So I'll guess the student would pick maybe two of
> > them, and if time is left at the end, more can be added as a bonus.
> >=20
>=20
> You're right, I am bundling together a few things.
>=20
> > 1. Something like --monitor mode=3Dqmp-shell that just spawns an extern=
al
> >    Python script and passes it a QMP socket. This is the fundamental
> >    building block for having any kind of external monitor script
> >    actually integrated in QEMU, so I think just running the existing
> >    qmp-shell this way (with proper support for at least stdio and vc
> >    chardevs) would make sense as a first milestone.
>=20
> This is a good standalone task, but
>=20
> > 2. Rewriting qmp-shell to use a better syntax for nested data
> >    structures. This would have to be defined before the project starts.
> >=20
>=20
> ... Can't start until we define the proper interface, because then we
> have to support it. Right now, qmp-shell is a developer toy because it's
> hidden in the tree.
>=20
> Promoting it to prime-time will be fruitless unless we come up with a
> convincing TUI for it.

I'm not sure what you mean by "support". We wouldn't have to support it
any more than qmp-shell in the initial phase. It wouldn't even have to
be any less hidden.

And in fact, even in the long run, as it is meant for human use, the
compatibility promise (if this is what you mean) would be the same as
HMP - we change it whenever we think that this improves its usability
for humans.

There is a big difference between making qmp-shell more usable and
promoting it to prime-time.

> > 3. Improving qmp-shell UI-wise, e.g. by having better autocompletion,
> >    support for counting brackets, or whatever else was mentioned. We
> >    have a few ideas, and there's room for the student to add their own
> >    ideas, too.
>=20
> Yes, this is all just great sugar. Completely optional, non-necessary.
> Forgive me for bringing up things like this so often.
>=20
> Not requisite to start on the project, but are great auxiliary tasks
> that would make it really shiny. Perfect GSoC/outreachy material.

I think some amount of sugar will actually be necessary. We don't want
to have something that barely works, but something that people would
actually prefer to HMP.

> > 4. Something HMP-like. This isn't QMP any more, so it could as well be =
a
> >    separate script (hmp-shell?). But it could also be integrated in
> >    qmp-shell in the form of additional commands that are implemented
> >    client-side. Or maybe have a single shell, but have a QMP mode and a=
n
> >    HMP mode and the user can switch between these modes.
> >=20
> >    The syntax for the HMP shell/mode could be the same or different fro=
m
> >    the QMP syntax. This would have to be defined beforehand, too.
> >=20
>=20
> More or less my suggestion for offering e.g. "?info block" sugar
> commands in the qmp-shell: an interface for executing sugar commands in
> a unified human shell.
>=20
> So, I don't know if "The final death of HMP" is something we want to
> pursue as a project

I would start with "Creating something that could eventually evolve into
something that makes HMP useless".

> (Even though I bring it up often, I consider it an open question -- do
> we want this? I actually don't know. I had assumed that working on a
> fancy qmp-shell would only be interesting if it meant the death of
> HMP, but perhaps I am wrong.)

I don't know either. I can tell you when I see the alternative. Having
the alternative implemented as an external script allows for some
experimentation without fully committing to it yet. qmp-shell has lived
for a long time in the tree without replacing HMP, so if we just end up
with a more usable qmp-shell that still doesn't replace HMP, I would
still see it as progress.

> Before we integrate qmp-shell into the GUI, I suspect we at least want
> to answer ourselves what we want qmp-shell to be:
>=20
> - QMP only, but nice for humans to interface with, or
> - QMP with extras, like "?info block"
>=20
> This mission statement will inform our basic premise for the syntax,
> and getting the basic syntax right is important for having a
> successful GSoC/outreachy project.

I think the former would be a subset of the latter, so starting with the
former shouldn't result in wasted work.

Personally, I like the idea of supporting some extras to perform high
level operations that QMP doesn't provide. I don't like the idea of
prefixing the extras with "?" to make them second-class commands.
Instead of having "?info block", I think "query-block" should be able to
print something readable by default and switching it to raw JSON would
be optional.

> > 5. Probably more that I just forgot now.
> >=20
> > Suggesting the exact goals is part of the student application process,
> > but for fundamental things like the syntax we should probably already
> > know what we want.
> >=20
>=20
> The goals for the intership yes, but I am merely suggesting we come up
> with a goal for what we want qmp-shell *to be* and what it is for, and
> why it will benefit us.
>=20
> Otherwise, it will be hard to offer direction to a student trying to
> write code in a very political and opinionated area of our codebase.
>=20
> So as requisites, I think we just need to answer:
>=20
> - Do we want to get rid of HMP?

Possibly.

> - Roughly, how do we want qmp-shell to act? Is it a REPL?

What else would it be?

> Are we convinced there is a workable QMP-compatible syntax that will
> be "easy to use" (subjective) and "easy to parse" (subjective) in such
> a system?

I think so. QMP-compatible basically just means that we need to be able
to distinguish QTypes (where the schema doesn't already disambiguate)
and to allow nesting.

> - Do we like the existing syntax? (I assume we do not.)

It makes sense for scalar options, so I think we'll want to keep these
cases working. We'll probably want something different for lists and
dicts.

Compared to HMP, a difference is that qmp-shell always requires you to
specify the option name. Introducing "positional arguments" like in HMP
could probably make things considerably easier to use.

> And all the rest is details that can be worked out by discussions,
> review, the student proposal, etc.
>=20
> >>>> I think those are the hardest parts.
> >>>>
> >>>> Below, some musings:
> >>>>
> >>>> - An integrated QMP shell would be a great usability boost to users =
of
> >>>> bare QEMU.
> >>>>
> >>>> - It is undesirable in general to support two interfaces. Feature
> >>>> disparity is a problem, as is needing to document and test two separ=
ate
> >>>> interfaces. The quality disparity between the two is also an issue.
> >>>>
> >>>> - Offering HMP via the GTK interface but not QMP is a discoverabilit=
y
> >>>> problem. Unfamiliar users might assume that HMP is our flagship
> >>>> interface. It is not.
> >>>>
> >>>> - We are unlikely to re-expand HMP to cover everything QMP does; wri=
ting
> >>>> a QMP shell that makes QMP easy to interface with is a better soluti=
on
> >>>> for removing redundancy and complexity.
> >=20
> > I'm not entirely convinced of this because QMP is often too low-level t=
o
> > actually address the practical high-level needs of users.
> >=20
> > But these HMP-ish things are probably easier to maintain as scripts
> > outside of the QEMU binary, so I think some kind of "QMP with
> > extensions" for human could be the solution.
> >=20
> > Once it's an external script, it will also be easy to exchange the shel=
l
> > for another one depending on user preference, or to hack in whatever
> > functionality they are missing.
> >=20
>=20
> Yes! This is exactly what I want with "?info block" style commands in
> qmp-shell: standalone qmp-shell extensions that implement one nugget of
> functionality that make a task easy at the human level.
>=20
> Things that are important to "make easy" will get extensions.
>=20
> Things that aren't, won't.
>=20
> Let's say we do remove HMP: Anyone who misses some of that functionality
> ... Well, if you care, please do contribute a qmp-shell plugin that adds =
it.

I think we should keep removing HMP completely out of this discussion.
If at some point we agree that qmp-shell has been improved to the extent
that none of us use HMP any more anyway, that's probably the point when
we should talk about removing HMP.

Let's just talk about improving qmp-shell for now.

> >>>> - I suspect that the target audience for users of naked QEMU are:
> >>>>   - QEMU developers
> >>>>   - Upper-layer developers (RHV, oVirt, KubeVirt, libvirt, kata, et =
al)
> >>>> researching, testing, and debugging integration.
> >>>>   - Devops professionals testing, implementing and debugging
> >>>>     configuration & infrastructure
> >>>>   - Security/infosec researchers
> >>>>   - Embedded platform developers
> >>>>   - Academic researchers
> >=20
> > Maybe kernel developers should be mentioned separately, but yes, this
> > list looks plausible to me.
>=20
> Oh, sure. This list is primarily here to state that there are very valid
> reasons to make QEMU usable *directly* to people because there are
> extremely valid reasons to be driving it directly.
>=20
> I think the *exact nature* of all of these use cases is not as important
> so much as they unambiguously exist.
>=20
> These users are technical, but may or may not be intricately familiar
> with QEMU inner workings.

Yes, I agree.

> Two takeaways:
>=20
> - Having some sugar that doesn't assume they know *too much* is
> important. A little bit of hand-holding is nice.
>=20
> - Having an interface that does not get in your way when you know
> exactly what you want is important to QEMU developers. (Allowing
> raw/direct QMP input, showing raw/pretty-printed incoming and outgoing
> QMP for writing documentation, etc.)

Yes, even if we have human-oriented output for a command, there should
always be a way to see the raw JSON. And probably also a way to send raw
JSON.

> >>>> So please correct me if I am off the mark;
> >>>>
> >>>> Design Goals:
> >>>>   - The removal of HMP
> >>>>   - An easy-to-use interface that remains reasonably "close" to the
> >>>> machine API such that it provides a smooth transition to scripting Q=
EMU.
> >>>>   - Integration with our GTK interface for discoverability and conve=
nience
> >=20
> > As I listed above, I think these are actually three separate projects,
> > rather than goals for a single big projects.
>=20
> Yes, so let me say that the *deliverable* goals for a GSoC/Outreachy
> project should just simply be *compatible* with our long-term roadmap/goa=
ls.

That's a good way to phrase it.

> Having an idea for where we want to head will allow us to define a
> tighter bound on what we want this summer without wasting effort.
>=20
> (And will allow us to give more rapid feedback to the student without
> arguing between ourselves what we even want. I just want us to agree on
> a mission statement.)

We should have a rough idea, but I don't think we need to know exactly
what the final state will look like. Let's keep some room for
experimentation. And even if we now implement something that turns out a
less than optional decision later, we can still change it. It's a human
interface, we don't have to be careful with respect to compatibility.

Kevin


