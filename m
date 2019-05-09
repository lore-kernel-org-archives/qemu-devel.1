Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1932120675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1932120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnf1-0006LD-93
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:20:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOndU-0005Q5-4b
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOndS-0006rk-2H
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOndR-0006r6-Ob
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C8C3307EAA9
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 18:19:12 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B10A60C81;
	Thu,  9 May 2019 18:19:11 +0000 (UTC)
Date: Thu, 9 May 2019 15:19:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190509181906.GN4189@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l646nbh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 09 May 2019 18:19:12 +0000 (UTC)
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

On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
> We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
> 
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrote:
> >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> >> 
> >> >> > This series adds machine type deprecation information to the
> >> >> > output of the `query-machines` QMP command.  With this, libvirt
> >> >> > and management software will be able to show this information to
> >> >> > users and/or suggest changes to VM configuration to avoid
> >> >> > deprecated machine types.
> >> >> 
> >> >> This overlaps with something I want to try, namely using Kevin's
> >> >> proposed QAPI feature flags for deprecation markings.  Let's compare the
> >> >> two.
> >> >> 
> >> >> To mark something as deprecated with your patches, you add a
> >> >> @support-status member somewhere, where "somewhere" is related to
> >> >> "something" by "provides information on".
> >> >> 
> >> >> Example: MachineInfo (returned by query-machines) provides information
> >> >> on possible values of -machine parameter type.  If -machine was
> >> >> QAPIfied, it would provide information on possible values of a QAPI
> >> >> object type's member.  The type might be anonymous.  The member should
> >> >> be an enum (we currently use 'str' in MachineInfo).
> >> >
> >> > QAPIfying -machine, -cpu, and -device would be wonderful.
> >> >
> >> >> 
> >> >> Example: say we want to deprecate block driver "vfat",
> >> >> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
> >> >> multiple places; let's ignore all but BlockdevOptions.  We need to add
> >> >> @support-status to something that provides information on
> >> >> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc query
> >> >> providing information on either of the two, because QAPI/QMP
> >> >> introspection has been sufficient.  What now?
> >> >> 
> >> >> Can we add deprecation information to (general) QAPI/QMP introspection
> >> >
> >> > Yes, we can.  I think it's a good idea.  But:
> >> >
> >> >> instead of ad hoc queries?
> >> >
> >> > I'm not sure about the "instead of" part.  I don't want perfect
> >> > to be the enemy of done, and I don't want QAPIfication of
> >> > -machine to be a requirement to start reporting machine type
> >> > deprecation information.
> >> 
> >> Valid point.  Still, I believe we should at least try to predict how the
> >> pieces we create now would fit with the pieces we plan to create later
> >> on.
> >
> > Sure.
> >
> >> 
> >> Note that full QAPIfication of -machine isn't necessary to make QAPI
> >> feature "deprecated" work for machine types.  Turning MachineInfo member
> >> @name into an enum, so we can tack "deprecated" onto its values, would
> >> suffice.
> >> 
> >> Such a QAPIfication of machine types is still hard: QOM types are
> >> defined at compile time just like the QAPI schema, but their definition
> >> is distributed, and collected into one place only at run time.  I
> >> discussed this on slide 39 of my "QEMU interface introspection: From
> >> hacks to solutions" talk (KVM Form 2015).  Just for device_add, but it's
> >> just a special case of QOM.  Choices listed there:
> >> 
> >> * Collect drivers at compile time? Hard...
> >> * Make QAPI schema dynamic? Hard...
> >> * Forgo driver-specific arguments in schema?
> >>   Defeats introspection...
> >> 
> >> I'd like to add to the last item:
> >> 
> >>   Provide QOM introspection on par with QAPI schema introspection
> >> 
> >> The QOM introspection we have (qom-list-types etc. is not on par.
> >
> > Agreed, but do we really want to do it?  We have been avoiding
> > exposing QOM internals to the outside on purpose.  I believe
> > there are at least two reasons for that:
> >
> > 1) Not every QOM type/property is supposed to be visible to the
> >    outside
> 
> True.
> 
> However, the parts of QOM exposed via device_add and object-add are
> definitely part of the stable external interface (unless explicitly
> marked unstable).
> 
> >            (and nobody really knows what's the full set of
> >    supported external QOM interfaces);
> 
> Also true.  And terrible.
> 
> > 2) QAPI is our preferred interface interface specification/introspection
> >    mechanism.
> 
> When preferences and requirements collide, preferences tend to get run
> over.
> 
> The QAPI schema is *declarative*: the schema declares QAPI objects and
> properties.  We generate C from the schema, which we then compile and
> link into QEMU.
> 
> QOM is by design *imperative*: we execute compiled C at QEMU run-time to
> define QOM objects and properties.  Maximizes flexibility.  See also
> Turing tarpit.
> 
> No matter how much we'd prefer to use QAPI to specify external
> interfaces to QOM, we can't without making QAPI much more dynamic or QOM
> much more static.  Either is hard.  Quite possibly infeasible.
> 
> We could try to extend QAPI/QMP introspection to somehow merge in
> additional information at run-time[1].  Could be regarded as a limited
> way to make QAPI more dynamic.  This is in the "vague idea, not sure
> it's feasible" stage.
> 
> We could try to rearchitect QOM so that you can optionally specify QOM
> stuff in the QAPI schema, then require that for QOM stuff that's part of
> a stable external interface.  Same "vague idea" stage, feasibility even
> more doubtful.
> 
> If I remember correctly, Paolo suggested to abandon the idea to have
> query-qmp-schema cover device_add as infeasible.  Instead, cover it
> separately.
> 
> I think this separate introspection mechanism should be as similar to
> query-qmp-schema as practical.  It should cover not just device_add, but
> also object-add, and whatever other external interface to QOM we deem
> stable.

I think we are in agreement here.  We don't need to make the new
introspection mechanism part of query-qmp-schema, but I think it
should use the same abstractions.

> 
> Should there be more stable external interfaces that can't be defined in
> the QAPI schema, we might want to cover them in this second
> introspection mechanism, too.

Agreed.

> 
> >> Back to exposing machine type deprecation.
> >> 
> >> I'm doubtful your proposed solution can be applied widely.  It relies on
> >> adding @support-status to something that provides information on
> >> whatever is deprecated.  The initial use is with a something that is an
> >> ad hoc query, namely query-machines.  To use it, the management
> >> application needs to understand what query-machines' @support-status
> >> applies to.  Certainly feasible.  But I fear every use will be a special
> >> case.  Furthermore, a suitable ad hoc query need not exist.  What then?
> >> Create suitable ad hoc queries just for communicating deprecation?
> >> 
> >> Instead, I'd like us to think about a more genral solution.  Or perhaps
> >> two: one for properly QAPIfied stuff, and one for QOM.
> >
> > Should we really spend our time designing a second solution, if
> > we could build this on top of QAPI abstractions?  Making the QAPI
> > schema dynamic might be hard, but reinventing QAPI and
> > maintaining the two systems in parallel seems harder.
> 
> I'd love to see a practical way forward that keeps QAPI/QMP
> introspection the only game in town.
> 
> >> >> Kevin's proposed QAPI feature flags[*] extend the QAPI language so that
> >> >> struct types can optionally have a list of feature flags, which are
> >> >> strings.  Struct types suffice for his immediate needs.  I'd like to use
> >> >> feature flags to mark deprecation by tacking a "deprecated" feature onto
> >> >> whatever is deprecated.  This obviously needs feature support for
> >> >> everything we want to be able to deprecate: commands, and events, as
> >> >> well as members of enum and object types.
> >> >> 
> >> >> Example: to deprecate block driver "vfat", add feature "deprecated" to
> >> >> BlockdevDriver member @vfat.
> >> >> 
> >> >> Unlike your patches, this does not require finding a "somewhere" that
> >> >> provides information on "something".  You simply tack "deprecated" right
> >> >> onto "something".
> >> >> 
> >> >> Your patches provide more information, however: human-readable messages.
> >> >
> >> > It also includes a machine-friendly suggested alternative (which
> >> > I think is even more important that the human-readable message).
> >> 
> >> I agree we should point to a preferred replacement whenever we deprecate
> >> something.
> >> 
> >> We have to do it in documentation.  And we generally do, in
> >> qemu-deprecated.texi.
> >> 
> >> How useful would doing it in QMP as well be?  Depends on what management
> >> applications can do with the additional information.
> >
> > I expect it to be useful for things that have obvious
> > replacements, like old machine type or CPU model versions.
> 
> I doubt a management application should apply suggested replacements
> automatically, and I doubt libvirt would.  Not even when QEMU developers
> deem them "obvious".
> 
> >> > We could extend QAPI introspection to return that if necessary,
> >> > right?
> >> 
> >> I'm confident we can come up with *something*.  It might kill the neat
> >> and simple "use QAPI features to communicate deprecation" idea, though.
> >
> > If something is important enough to be communicated through
> > stderr, it's important enough to be communicated through QMP.
> 
> Mostly.  Differences are due to the different consumers.
> 
> stderr is primarily for human users.  We print stuff useful to human
> users.

We have users that don't have access to stderr.  They might have
access to log files, but log files are pretty bad user
interfaces.  If it's important for some set of human users, apps
using libvirt or QMP need access to that information so they can
show it to their human users too.

> 
> QMP is primarily for machines, secondarily for the humans building these
> machines.  We send stuff useful to the machines themselves, and stuff
> the machines can use to be more useful for their users (which may be
> machines or humans).  We can also send stuff to help the humans building
> the machines.
> 
> In any case, the information we provide is limited by the cost to
> provide it.

Absolutely.

> 
> > Is that enough reason to provide something more complex?
> 
> We need to consider cost / benefit.
> 
> On benefit, I'd like to know what libvirt would do with the additional
> information beyond logging it.

I'd say it should provide it to apps, otherwise this won't be
more useful than the existing log files.

> 
> Is the additional information you propose to provide static or dynamic?
> 
> By "static", I mean each occurence of a feature in the QAPI schema is
> tied to one fixed instance of "additional information".

I don't think I understand this description of "static".  I
expect the data to be fixed at build time, but I expect it to be
different in downstream distributions of QEMU.


> 
> > Do we need QAPI features to be just strings?  Can't they be a
> > more complex type, like a QAPI alternate?
> 
> Adds complexity.
> 
> We currently imagine QAPI features enum-like, i.e. a list of strings,
> optionally with conditions.  The conditions are evaluated at QAPI
> generation time, and not visible in introspection.
> 
> This is probably the stupidest solution that could possibly work.  The
> structure of features is trivial.
> 
> More expressive solutions include:
> 
> * List of 'any'.  Feels like a bad idea, because it's completely
>   unstructured.

Agreed.

> 
> * List of some 'QapiFeatures' object type.  Lets us expose the variable
>   structure of features in introspection.
> 
> * List of some 'QapiFeatures' alternate type.  Like the previous, but
>   permits coding simple feature flags as strings.
> 
> All of the more expressive solutions I listed treat the additional
> information as dynamic.  Overly general in case the information is
> actually always static.

The static vs. dynamic distinction is getting me confused.  Why
are the more expressive solutions more dynamic than "list of
strings"?  Can you give examples?

Also, why do we want to place all info inside the same "features"
attribute instead of just adding new fields to SchemaInfoObject?

i.e. why are these options:

  { "members" [ ... ],
    "features": [ "dynamic-read-only", "deprecated" ] }

  { "members" [ ... ],
    "features": [ "dynamic-read-only",
                  { "deprecated": true, "hint": "FOO" } ] }

better than these options:

  { "members" [ ... ],
    "features": [ "dynamic-read-only" ],
    "deprecated": true }

  { "members" [ ... ],
    "features": [ "dynamic-read-only" ],
    "deprecation-info": { "deprecated": true, "hint": "FOO" } }



> 
> >> >> Food for thought :)
> >> >> 
> >> >> 
> >> >> [*] Hiding in
> >> >> Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI feature
> >> >> Date: Mon,  8 Apr 2019 16:35:39 +0200
> >> >> Message-Id: <20190408143543.3982-1-kwolf@redhat.com>
> 
> 
> [1] Special case of "merge additional information into QAPI/QMP
> introspection at run-time, relegated to a footnote, because I think it's
> of mostly historical interest now.
> 
> Qdev was designed to be declarative, but the declarations always got
> collected only at run-time.  It has since been rebased onto imperative
> QOM.  Since you can mix declarative qdev and imperative QOM, the
> combination is effectively imperative.
> 
> We could collect the declarative parts of qdev at compile-time somehow,
> and fold them into QAPI introspection.  That's the "Collect drives at
> compile time" item from the slide I quoted.  I think this idea has
> become pretty much worthless, since it would cover device_add only in
> part, and object-add not at all.

-- 
Eduardo

