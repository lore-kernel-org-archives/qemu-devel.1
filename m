Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C1120675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C1120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOTBx-0008F8-1s
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 16:29:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOTB8-0007wq-Ow
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOTB5-0006QF-AS
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOTB5-0006P8-1p
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82287C05D275
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 20:28:33 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E143608E4;
	Wed,  8 May 2019 20:28:32 +0000 (UTC)
Date: Wed, 8 May 2019 17:28:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190508202830.GF4189@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfzh5mrh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 08 May 2019 20:28:33 +0000 (UTC)
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
Cc: mprivozn@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > This series adds machine type deprecation information to the
> >> > output of the `query-machines` QMP command.  With this, libvirt
> >> > and management software will be able to show this information to
> >> > users and/or suggest changes to VM configuration to avoid
> >> > deprecated machine types.
> >> 
> >> This overlaps with something I want to try, namely using Kevin's
> >> proposed QAPI feature flags for deprecation markings.  Let's compare the
> >> two.
> >> 
> >> To mark something as deprecated with your patches, you add a
> >> @support-status member somewhere, where "somewhere" is related to
> >> "something" by "provides information on".
> >> 
> >> Example: MachineInfo (returned by query-machines) provides information
> >> on possible values of -machine parameter type.  If -machine was
> >> QAPIfied, it would provide information on possible values of a QAPI
> >> object type's member.  The type might be anonymous.  The member should
> >> be an enum (we currently use 'str' in MachineInfo).
> >
> > QAPIfying -machine, -cpu, and -device would be wonderful.
> >
> >> 
> >> Example: say we want to deprecate block driver "vfat",
> >> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
> >> multiple places; let's ignore all but BlockdevOptions.  We need to add
> >> @support-status to something that provides information on
> >> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc query
> >> providing information on either of the two, because QAPI/QMP
> >> introspection has been sufficient.  What now?
> >> 
> >> Can we add deprecation information to (general) QAPI/QMP introspection
> >
> > Yes, we can.  I think it's a good idea.  But:
> >
> >> instead of ad hoc queries?
> >
> > I'm not sure about the "instead of" part.  I don't want perfect
> > to be the enemy of done, and I don't want QAPIfication of
> > -machine to be a requirement to start reporting machine type
> > deprecation information.
> 
> Valid point.  Still, I believe we should at least try to predict how the
> pieces we create now would fit with the pieces we plan to create later
> on.

Sure.

> 
> Note that full QAPIfication of -machine isn't necessary to make QAPI
> feature "deprecated" work for machine types.  Turning MachineInfo member
> @name into an enum, so we can tack "deprecated" onto its values, would
> suffice.
> 
> Such a QAPIfication of machine types is still hard: QOM types are
> defined at compile time just like the QAPI schema, but their definition
> is distributed, and collected into one place only at run time.  I
> discussed this on slide 39 of my "QEMU interface introspection: From
> hacks to solutions" talk (KVM Form 2015).  Just for device_add, but it's
> just a special case of QOM.  Choices listed there:
> 
> * Collect drivers at compile time? Hard...
> * Make QAPI schema dynamic? Hard...
> * Forgo driver-specific arguments in schema?
>   Defeats introspection...
> 
> I'd like to add to the last item:
> 
>   Provide QOM introspection on par with QAPI schema introspection
> 
> The QOM introspection we have (qom-list-types etc. is not on par.

Agreed, but do we really want to do it?  We have been avoiding
exposing QOM internals to the outside on purpose.  I believe
there are at least two reasons for that:

1) Not every QOM type/property is supposed to be visible to the
   outside (and nobody really knows what's the full set of
   supported external QOM interfaces);
2) QAPI is our preferred interface interface specification/introspection
   mechanism.

> 
> Back to exposing machine type deprecation.
> 
> I'm doubtful your proposed solution can be applied widely.  It relies on
> adding @support-status to something that provides information on
> whatever is deprecated.  The initial use is with a something that is an
> ad hoc query, namely query-machines.  To use it, the management
> application needs to understand what query-machines' @support-status
> applies to.  Certainly feasible.  But I fear every use will be a special
> case.  Furthermore, a suitable ad hoc query need not exist.  What then?
> Create suitable ad hoc queries just for communicating deprecation?
> 
> Instead, I'd like us to think about a more genral solution.  Or perhaps
> two: one for properly QAPIfied stuff, and one for QOM.

Should we really spend our time designing a second solution, if
we could build this on top of QAPI abstractions?  Making the QAPI
schema dynamic might be hard, but reinventing QAPI and
maintaining the two systems in parallel seems harder.


> 
> >> Kevin's proposed QAPI feature flags[*] extend the QAPI language so that
> >> struct types can optionally have a list of feature flags, which are
> >> strings.  Struct types suffice for his immediate needs.  I'd like to use
> >> feature flags to mark deprecation by tacking a "deprecated" feature onto
> >> whatever is deprecated.  This obviously needs feature support for
> >> everything we want to be able to deprecate: commands, and events, as
> >> well as members of enum and object types.
> >> 
> >> Example: to deprecate block driver "vfat", add feature "deprecated" to
> >> BlockdevDriver member @vfat.
> >> 
> >> Unlike your patches, this does not require finding a "somewhere" that
> >> provides information on "something".  You simply tack "deprecated" right
> >> onto "something".
> >> 
> >> Your patches provide more information, however: human-readable messages.
> >
> > It also includes a machine-friendly suggested alternative (which
> > I think is even more important that the human-readable message).
> 
> I agree we should point to a preferred replacement whenever we deprecate
> something.
> 
> We have to do it in documentation.  And we generally do, in
> qemu-deprecated.texi.
> 
> How useful would doing it in QMP as well be?  Depends on what management
> applications can do with the additional information.

I expect it to be useful for things that have obvious
replacements, like old machine type or CPU model versions.

> 
> > We could extend QAPI introspection to return that if necessary,
> > right?
> 
> I'm confident we can come up with *something*.  It might kill the neat
> and simple "use QAPI features to communicate deprecation" idea, though.
> 

If something is important enough to be communicated through
stderr, it's important enough to be communicated through QMP.
Is that enough reason to provide something more complex?

Do we need QAPI features to be just strings?  Can't they be a
more complex type, like a QAPI alternate?


> >> Food for thought :)
> >> 
> >> 
> >> [*] Hiding in
> >> Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI feature
> >> Date: Mon,  8 Apr 2019 16:35:39 +0200
> >> Message-Id: <20190408143543.3982-1-kwolf@redhat.com>

-- 
Eduardo

