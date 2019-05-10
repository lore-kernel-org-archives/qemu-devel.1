Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C61CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402E1208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402E1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9AS-0001kL-Hm
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:18:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hP993-00010R-SF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hP992-0006Zu-Cp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hP992-0006XG-3G
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60978285BE
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 17:17:15 +0000 (UTC)
Received: from localhost (ovpn-116-40.gru2.redhat.com [10.97.116.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5A9A17791;
	Fri, 10 May 2019 17:17:14 +0000 (UTC)
Date: Fri, 10 May 2019 14:17:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510171711.GS4189@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509181906.GN4189@habkost.net>
	<87o94au06m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o94au06m.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 10 May 2019 17:17:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: mprivozn@redhat.com, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 11:29:53AM +0200, Markus Armbruster wrote:
[...]
> >> >> > We could extend QAPI introspection to return that if necessary,
> >> >> > right?
> >> >> 
> >> >> I'm confident we can come up with *something*.  It might kill the neat
> >> >> and simple "use QAPI features to communicate deprecation" idea, though.
> >> >
> >> > If something is important enough to be communicated through
> >> > stderr, it's important enough to be communicated through QMP.
> >> 
> >> Mostly.  Differences are due to the different consumers.
> >> 
> >> stderr is primarily for human users.  We print stuff useful to human
> >> users.
> >
> > We have users that don't have access to stderr.  They might have
> > access to log files, but log files are pretty bad user
> > interfaces.  If it's important for some set of human users, apps
> > using libvirt or QMP need access to that information so they can
> > show it to their human users too.
> 
> Command line means stderr.

I disagree.

> 
> I'm afraid our command line is awkward both for machines and for humans,
> albeit for different reasons.
> 
> For humans doing simple things, the command line is okay.  But beyond
> that, it gets forbiddingly unwieldy[2].
> 
> Machines are fine with that kind of unwieldy, but would prefer something
> with more structure, both on input (talking to QEMU) and even more so on
> output (QEMU talking back).
> 
> Ideally, we'd support machines do their work in (structured) QMP,
> resorting to the command line only to set up a QMP monitor.  We're not
> anywhere close to this.
> 
> As long as management applications use the command line in not-trivial
> ways, they have to deal with configuration errors reported via stderr.

That's only true if we want to.

Command line is an interface usable by machines.  Not the ideal,
but it works.

Messages on stderr are not an interface for machines.  We must
provide something better, and I don't think "wait until we
convert everything to QMP" is a reasonable answer.


> 
> >> QMP is primarily for machines, secondarily for the humans building these
> >> machines.  We send stuff useful to the machines themselves, and stuff
> >> the machines can use to be more useful for their users (which may be
> >> machines or humans).  We can also send stuff to help the humans building
> >> the machines.
> >>
> >> In any case, the information we provide is limited by the cost to
> >> provide it.
> >
> > Absolutely.
> >
> >> 
> >> > Is that enough reason to provide something more complex?
> >> 
> >> We need to consider cost / benefit.
> >> 
> >> On benefit, I'd like to know what libvirt would do with the additional
> >> information beyond logging it.
> >
> > I'd say it should provide it to apps, otherwise this won't be
> > more useful than the existing log files.
> 
> A management application simply showing its user whatever error QEMU
> reports or hint it provides is bound to be confusing: since QEMU talks
> in QEMU terms, its errors and hints generally need translation to make
> sense at higher layers.  Translation involves recognizing specific
> messages, which means it's limited to special cases (and painfully
> brittle).
> 
> The farther you propagate QEMU's messages up the stack, the less sense
> they'll likely make.
> 
> Management applications logging QEMU's messages is useful anyway, mainly
> because it's better than nothing.
> 
> I doubt logging them some more further up the stack would be all that
> useful, but I might be wrong.
> 
> Discussed further elsewhere in this thread.
> 
> >> Is the additional information you propose to provide static or dynamic?
> >> 
> >> By "static", I mean each occurence of a feature in the QAPI schema is
> >> tied to one fixed instance of "additional information".
> >
> > I don't think I understand this description of "static".  I
> > expect the data to be fixed at build time, but I expect it to be
> > different in downstream distributions of QEMU.
> 
> Let me try differently.
> 
> QAPI features as currently envisaged convey one bit of information:
> there / not there.  The information is fixed at build time.  It is tied
> to a specific QAPI entity (command, object type, enumeration value,
> ...).
> 
> My question is about the difference between this and what you have in
> mind.  Specifically, is the difference only the amount of information
> (one bit vs. a pair of string literals), or is there more?

Right now, it's only in the amount of information.

> 
> "More" includes string values that can vary at run time or between
> different uses of the QAPI entity in the schema.

Right now, it includes string values that are fixed at build
time, but collected dynamically at run time (because we are
describing QOM types, which are collected dynamically).

> 
> >> > Do we need QAPI features to be just strings?  Can't they be a
> >> > more complex type, like a QAPI alternate?
> >> 
> >> Adds complexity.
> >> 
> >> We currently imagine QAPI features enum-like, i.e. a list of strings,
> >> optionally with conditions.  The conditions are evaluated at QAPI
> >> generation time, and not visible in introspection.
> >> 
> >> This is probably the stupidest solution that could possibly work.  The
> >> structure of features is trivial.
> >> 
> >> More expressive solutions include:
> >> 
> >> * List of 'any'.  Feels like a bad idea, because it's completely
> >>   unstructured.
> >
> > Agreed.
> >
> >> 
> >> * List of some 'QapiFeatures' object type.  Lets us expose the variable
> >>   structure of features in introspection.
> >> 
> >> * List of some 'QapiFeatures' alternate type.  Like the previous, but
> >>   permits coding simple feature flags as strings.
> >> 
> >> All of the more expressive solutions I listed treat the additional
> >> information as dynamic.  Overly general in case the information is
> >> actually always static.
> >
> > The static vs. dynamic distinction is getting me confused.  Why
> > are the more expressive solutions more dynamic than "list of
> > strings"?  Can you give examples?
> 
> Insufficiently precise thinking leads to vague and confusing prose.  Let
> me try again.
> 
> The scenario I had in mind is having only the (static) structure of the
> additional information in query-qmp-schema, and the actual (possibly
> dynamic) information elsewhere, say in query-machines, or a new member
> of the QMP success response.

The structure of the additional information can be part of the
schema, yes.  The actual information needs to be collected at
runtime so we won't be able to make it part of the QAPI schema.

> 
> > Also, why do we want to place all info inside the same "features"
> > attribute instead of just adding new fields to SchemaInfoObject?
> >
> > i.e. why are these options:
> >
> >   { "members" [ ... ],
> >     "features": [ "dynamic-read-only", "deprecated" ] }
> >
> >   { "members" [ ... ],
> >     "features": [ "dynamic-read-only",
> >                   { "deprecated": true, "hint": "FOO" } ] }
> >
> > better than these options:
> >
> >   { "members" [ ... ],
> >     "features": [ "dynamic-read-only" ],
> >     "deprecated": true }
> >
> >   { "members" [ ... ],
> >     "features": [ "dynamic-read-only" ],
> >     "deprecation-info": { "deprecated": true, "hint": "FOO" } }
> 
> I wouldn't claim "better".  I merely observe it takes its own QAPI
> language extension, unlike the 'neat and simple "use QAPI features to
> communicate deprecation" idea'.

I agree that "neat and simple" is a nice goal.  But it's not a
requirement, right?

> [...]

-- 
Eduardo

