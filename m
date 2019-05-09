Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF3C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87E72173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87E72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOldk-0007Y0-VF
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOlcX-0006sT-UM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOlcN-00030x-7I
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:10:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOlcK-0002TK-Tx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C966D3078ABB
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 16:08:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28D7F60CCD;
	Thu,  9 May 2019 16:08:13 +0000 (UTC)
Date: Thu, 9 May 2019 17:08:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190509160811.GL31299@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509091452.GF31299@redhat.com>
	<20190509155247.GJ4189@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509155247.GJ4189@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 09 May 2019 16:08:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 12:52:47PM -0300, Eduardo Habkost wrote:
> On Thu, May 09, 2019 at 10:14:52AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
> > > We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
> > >=20
> > > Eduardo Habkost <ehabkost@redhat.com> writes:
> > >=20
> > > > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote=
:
> > > >> Eduardo Habkost <ehabkost@redhat.com> writes:
> > > >>=20
> > > >> > On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wr=
ote:
> > > >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> > > >> >>=20
> > > >> >> > This series adds machine type deprecation information to th=
e
> > > >> >> > output of the `query-machines` QMP command.  With this, lib=
virt
> > > >> >> > and management software will be able to show this informati=
on to
> > > >> >> > users and/or suggest changes to VM configuration to avoid
> > > >> >> > deprecated machine types.
> > > >> >>=20
> > > >> >> This overlaps with something I want to try, namely using Kevi=
n's
> > > >> >> proposed QAPI feature flags for deprecation markings.  Let's =
compare the
> > > >> >> two.
> > > >> >>=20
> > > >> >> To mark something as deprecated with your patches, you add a
> > > >> >> @support-status member somewhere, where "somewhere" is relate=
d to
> > > >> >> "something" by "provides information on".
> > > >> >>=20
> > > >> >> Example: MachineInfo (returned by query-machines) provides in=
formation
> > > >> >> on possible values of -machine parameter type.  If -machine w=
as
> > > >> >> QAPIfied, it would provide information on possible values of =
a QAPI
> > > >> >> object type's member.  The type might be anonymous.  The memb=
er should
> > > >> >> be an enum (we currently use 'str' in MachineInfo).
> > > >> >
> > > >> > QAPIfying -machine, -cpu, and -device would be wonderful.
> > > >> >
> > > >> >>=20
> > > >> >> Example: say we want to deprecate block driver "vfat",
> > > >> >> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is use=
d in
> > > >> >> multiple places; let's ignore all but BlockdevOptions.  We ne=
ed to add
> > > >> >> @support-status to something that provides information on
> > > >> >> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad =
hoc query
> > > >> >> providing information on either of the two, because QAPI/QMP
> > > >> >> introspection has been sufficient.  What now?
> > > >> >>=20
> > > >> >> Can we add deprecation information to (general) QAPI/QMP intr=
ospection
> > > >> >
> > > >> > Yes, we can.  I think it's a good idea.  But:
> > > >> >
> > > >> >> instead of ad hoc queries?
> > > >> >
> > > >> > I'm not sure about the "instead of" part.  I don't want perfec=
t
> > > >> > to be the enemy of done, and I don't want QAPIfication of
> > > >> > -machine to be a requirement to start reporting machine type
> > > >> > deprecation information.
> > > >>=20
> > > >> Valid point.  Still, I believe we should at least try to predict=
 how the
> > > >> pieces we create now would fit with the pieces we plan to create=
 later
> > > >> on.
> > > >
> > > > Sure.
> > > >
> > > >>=20
> > > >> Note that full QAPIfication of -machine isn't necessary to make =
QAPI
> > > >> feature "deprecated" work for machine types.  Turning MachineInf=
o member
> > > >> @name into an enum, so we can tack "deprecated" onto its values,=
 would
> > > >> suffice.
> > > >>=20
> > > >> Such a QAPIfication of machine types is still hard: QOM types ar=
e
> > > >> defined at compile time just like the QAPI schema, but their def=
inition
> > > >> is distributed, and collected into one place only at run time.  =
I
> > > >> discussed this on slide 39 of my "QEMU interface introspection: =
From
> > > >> hacks to solutions" talk (KVM Form 2015).  Just for device_add, =
but it's
> > > >> just a special case of QOM.  Choices listed there:
> > > >>=20
> > > >> * Collect drivers at compile time? Hard...
> > > >> * Make QAPI schema dynamic? Hard...
> > > >> * Forgo driver-specific arguments in schema?
> > > >>   Defeats introspection...
> > > >>=20
> > > >> I'd like to add to the last item:
> > > >>=20
> > > >>   Provide QOM introspection on par with QAPI schema introspectio=
n
> > > >>=20
> > > >> The QOM introspection we have (qom-list-types etc. is not on par=
.
> > > >
> > > > Agreed, but do we really want to do it?  We have been avoiding
> > > > exposing QOM internals to the outside on purpose.  I believe
> > > > there are at least two reasons for that:
> > > >
> > > > 1) Not every QOM type/property is supposed to be visible to the
> > > >    outside
> > >=20
> > > True.
> > >=20
> > > However, the parts of QOM exposed via device_add and object-add are
> > > definitely part of the stable external interface (unless explicitly
> > > marked unstable).
> > >=20
> > > >            (and nobody really knows what's the full set of
> > > >    supported external QOM interfaces);
> > >=20
> > > Also true.  And terrible.
> > >=20
> > > > 2) QAPI is our preferred interface interface specification/intros=
pection
> > > >    mechanism.
> > >=20
> > > When preferences and requirements collide, preferences tend to get =
run
> > > over.
> > >=20
> > > The QAPI schema is *declarative*: the schema declares QAPI objects =
and
> > > properties.  We generate C from the schema, which we then compile a=
nd
> > > link into QEMU.
> > >=20
> > > QOM is by design *imperative*: we execute compiled C at QEMU run-ti=
me to
> > > define QOM objects and properties.  Maximizes flexibility.  See als=
o
> > > Turing tarpit.
> > >=20
> > > No matter how much we'd prefer to use QAPI to specify external
> > > interfaces to QOM, we can't without making QAPI much more dynamic o=
r QOM
> > > much more static.  Either is hard.  Quite possibly infeasible.
> > >=20
> > > We could try to extend QAPI/QMP introspection to somehow merge in
> > > additional information at run-time[1].  Could be regarded as a limi=
ted
> > > way to make QAPI more dynamic.  This is in the "vague idea, not sur=
e
> > > it's feasible" stage.
> > >=20
> > > We could try to rearchitect QOM so that you can optionally specify =
QOM
> > > stuff in the QAPI schema, then require that for QOM stuff that's pa=
rt of
> > > a stable external interface.  Same "vague idea" stage, feasibility =
even
> > > more doubtful.
> >=20
> > I think it is feasible to use QAPI to declare the QOM object type,
> > QOM parent type, list of QOM interfaces and QOM properties in a
> > declarative manner. From that generate all the tedious boilerplate
> > code. The dev then just has to provide the "interesting" code for
> > the object.
> >=20
> > I'd really like to do a PoC of this but never have free time :-(
> > Perhaps an interesting task for someone who wants to delve into
> > some new work...
> >=20
> >=20
> > > >> >> Example: to deprecate block driver "vfat", add feature "depre=
cated" to
> > > >> >> BlockdevDriver member @vfat.
> > > >> >>=20
> > > >> >> Unlike your patches, this does not require finding a "somewhe=
re" that
> > > >> >> provides information on "something".  You simply tack "deprec=
ated" right
> > > >> >> onto "something".
> > > >> >>=20
> > > >> >> Your patches provide more information, however: human-readabl=
e messages.
> > > >> >
> > > >> > It also includes a machine-friendly suggested alternative (whi=
ch
> > > >> > I think is even more important that the human-readable message=
).
> > > >>=20
> > > >> I agree we should point to a preferred replacement whenever we d=
eprecate
> > > >> something.
> > > >>=20
> > > >> We have to do it in documentation.  And we generally do, in
> > > >> qemu-deprecated.texi.
> > > >>=20
> > > >> How useful would doing it in QMP as well be?  Depends on what ma=
nagement
> > > >> applications can do with the additional information.
> > > >
> > > > I expect it to be useful for things that have obvious
> > > > replacements, like old machine type or CPU model versions.
> > >=20
> > > I doubt a management application should apply suggested replacement=
s
> > > automatically, and I doubt libvirt would.  Not even when QEMU devel=
opers
> > > deem them "obvious".
> >=20
> > We certainly won't apply the suggested replacement as in many cases
> > it is not going to be a functionally equivalent drop-in.
>=20
> Who's "we"?

I was refering to libvirt here.

> > If QEMU logs it to stderr, it will end up in the per-VM log file
> > libvirt has under /var/log/libvirt/qemu/$GUESTNAME.log.  If QEMU
> > doesn't log it to stderr, then libvirt would just write it to
> > that same log file itself.
> >=20
> > If libvirt gains some API or event for notifying apps of deprecation
> > we might bubble it up to the mgmt app that way.
> >=20
> > I still feel it is useful to have the suggested replacement in the
> > logs, rather  than only leaving it in qemu-deprecated.texi.  This
> > way the info is immediately visible to both app developers and any
> > support person dealing with bugs.
> >=20
> > If the app dev see the suggested replacement upfront they're more
> > likely to make an immediate decision to update their code if the
> > suggestion is trivial. If they need to go find the QEMU docs to
> > lookup what action is required I feel they'll more likely just
> > put the item on their long todo list where it will languish.
>=20
> Agreed.  However, note that the audience for deprecation
> information is not just developers and support people.  End users
> need to know when they are relying on a deprecated feature, and
> applications should make it as easy as possible for them to
> update their configurations.
>=20
> I'm not suggesting the alternative would be applied
> automatically.  But having the alternative available in a
> machine-friendly way may be the difference between a unhelpful UI
> that just tells the user there's some problem but can't give a
> solution, and one that can really assist the user to fix the
> problem.

For some aspects of QEMU it might be possible, but considering the
broader set of things which can be deprecated, I don't think it is
possible to expose a machine consumable "suggestion".

Consider the deprecation of the ACL feature. We deprecated monitor
commands "acl_add", "acl_policy", "acl_reset", etc. The suggested
replacement is to use one of the many possible QAuthZ types combined
with the -object arg. Even if we invented some way to express this
in the schema, I don't think any app would usefully consume it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

