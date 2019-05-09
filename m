Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B1C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3DF206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3DF206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOf9m-0002DS-G1
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:16:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOf8l-0001kB-Qr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOf8k-00026P-3J
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOf8j-00025N-QG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:14:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E61533092664
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 09:14:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E56BC608E4;
	Thu,  9 May 2019 09:14:54 +0000 (UTC)
Date: Thu, 9 May 2019 10:14:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190509091452.GF31299@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874l646nbh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 09 May 2019 09:14:56 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mprivozn@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
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

I think it is feasible to use QAPI to declare the QOM object type,
QOM parent type, list of QOM interfaces and QOM properties in a
declarative manner. From that generate all the tedious boilerplate
code. The dev then just has to provide the "interesting" code for
the object.

I'd really like to do a PoC of this but never have free time :-(
Perhaps an interesting task for someone who wants to delve into
some new work...


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

We certainly won't apply the suggested replacement as in many cases
it is not going to be a functionally equivalent drop-in.

If QEMU logs it to stderr, it will end up in the per-VM log file
libvirt has under /var/log/libvirt/qemu/$GUESTNAME.log.  If QEMU
doesn't log it to stderr, then libvirt would just write it to
that same log file itself.

If libvirt gains some API or event for notifying apps of deprecation
we might bubble it up to the mgmt app that way.

I still feel it is useful to have the suggested replacement in the
logs, rather  than only leaving it in qemu-deprecated.texi.  This
way the info is immediately visible to both app developers and any
support person dealing with bugs.

If the app dev see the suggested replacement upfront they're more
likely to make an immediate decision to update their code if the
suggestion is trivial. If they need to go find the QEMU docs to
lookup what action is required I feel they'll more likely just
put the item on their long todo list where it will languish.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

