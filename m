Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A000FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6016A2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6016A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlN9-0004y3-OL
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:54:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOlLo-0003zI-R4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOlLn-0000x0-3e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOlLm-0000wj-Rf
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22065307EA9F
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 15:52:50 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1F1360CC0;
	Thu,  9 May 2019 15:52:48 +0000 (UTC)
Date: Thu, 9 May 2019 12:52:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190509155247.GJ4189@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509091452.GF31299@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190509091452.GF31299@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 09 May 2019 15:52:50 +0000 (UTC)
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
Cc: mprivozn@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 10:14:52AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
> > We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
> >=20
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >=20
> > > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote:
> > >> Eduardo Habkost <ehabkost@redhat.com> writes:
> > >>=20
> > >> > On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrot=
e:
> > >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> > >> >>=20
> > >> >> > This series adds machine type deprecation information to the
> > >> >> > output of the `query-machines` QMP command.  With this, libvi=
rt
> > >> >> > and management software will be able to show this information=
 to
> > >> >> > users and/or suggest changes to VM configuration to avoid
> > >> >> > deprecated machine types.
> > >> >>=20
> > >> >> This overlaps with something I want to try, namely using Kevin'=
s
> > >> >> proposed QAPI feature flags for deprecation markings.  Let's co=
mpare the
> > >> >> two.
> > >> >>=20
> > >> >> To mark something as deprecated with your patches, you add a
> > >> >> @support-status member somewhere, where "somewhere" is related =
to
> > >> >> "something" by "provides information on".
> > >> >>=20
> > >> >> Example: MachineInfo (returned by query-machines) provides info=
rmation
> > >> >> on possible values of -machine parameter type.  If -machine was
> > >> >> QAPIfied, it would provide information on possible values of a =
QAPI
> > >> >> object type's member.  The type might be anonymous.  The member=
 should
> > >> >> be an enum (we currently use 'str' in MachineInfo).
> > >> >
> > >> > QAPIfying -machine, -cpu, and -device would be wonderful.
> > >> >
> > >> >>=20
> > >> >> Example: say we want to deprecate block driver "vfat",
> > >> >> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used =
in
> > >> >> multiple places; let's ignore all but BlockdevOptions.  We need=
 to add
> > >> >> @support-status to something that provides information on
> > >> >> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad ho=
c query
> > >> >> providing information on either of the two, because QAPI/QMP
> > >> >> introspection has been sufficient.  What now?
> > >> >>=20
> > >> >> Can we add deprecation information to (general) QAPI/QMP intros=
pection
> > >> >
> > >> > Yes, we can.  I think it's a good idea.  But:
> > >> >
> > >> >> instead of ad hoc queries?
> > >> >
> > >> > I'm not sure about the "instead of" part.  I don't want perfect
> > >> > to be the enemy of done, and I don't want QAPIfication of
> > >> > -machine to be a requirement to start reporting machine type
> > >> > deprecation information.
> > >>=20
> > >> Valid point.  Still, I believe we should at least try to predict h=
ow the
> > >> pieces we create now would fit with the pieces we plan to create l=
ater
> > >> on.
> > >
> > > Sure.
> > >
> > >>=20
> > >> Note that full QAPIfication of -machine isn't necessary to make QA=
PI
> > >> feature "deprecated" work for machine types.  Turning MachineInfo =
member
> > >> @name into an enum, so we can tack "deprecated" onto its values, w=
ould
> > >> suffice.
> > >>=20
> > >> Such a QAPIfication of machine types is still hard: QOM types are
> > >> defined at compile time just like the QAPI schema, but their defin=
ition
> > >> is distributed, and collected into one place only at run time.  I
> > >> discussed this on slide 39 of my "QEMU interface introspection: Fr=
om
> > >> hacks to solutions" talk (KVM Form 2015).  Just for device_add, bu=
t it's
> > >> just a special case of QOM.  Choices listed there:
> > >>=20
> > >> * Collect drivers at compile time? Hard...
> > >> * Make QAPI schema dynamic? Hard...
> > >> * Forgo driver-specific arguments in schema?
> > >>   Defeats introspection...
> > >>=20
> > >> I'd like to add to the last item:
> > >>=20
> > >>   Provide QOM introspection on par with QAPI schema introspection
> > >>=20
> > >> The QOM introspection we have (qom-list-types etc. is not on par.
> > >
> > > Agreed, but do we really want to do it?  We have been avoiding
> > > exposing QOM internals to the outside on purpose.  I believe
> > > there are at least two reasons for that:
> > >
> > > 1) Not every QOM type/property is supposed to be visible to the
> > >    outside
> >=20
> > True.
> >=20
> > However, the parts of QOM exposed via device_add and object-add are
> > definitely part of the stable external interface (unless explicitly
> > marked unstable).
> >=20
> > >            (and nobody really knows what's the full set of
> > >    supported external QOM interfaces);
> >=20
> > Also true.  And terrible.
> >=20
> > > 2) QAPI is our preferred interface interface specification/introspe=
ction
> > >    mechanism.
> >=20
> > When preferences and requirements collide, preferences tend to get ru=
n
> > over.
> >=20
> > The QAPI schema is *declarative*: the schema declares QAPI objects an=
d
> > properties.  We generate C from the schema, which we then compile and
> > link into QEMU.
> >=20
> > QOM is by design *imperative*: we execute compiled C at QEMU run-time=
 to
> > define QOM objects and properties.  Maximizes flexibility.  See also
> > Turing tarpit.
> >=20
> > No matter how much we'd prefer to use QAPI to specify external
> > interfaces to QOM, we can't without making QAPI much more dynamic or =
QOM
> > much more static.  Either is hard.  Quite possibly infeasible.
> >=20
> > We could try to extend QAPI/QMP introspection to somehow merge in
> > additional information at run-time[1].  Could be regarded as a limite=
d
> > way to make QAPI more dynamic.  This is in the "vague idea, not sure
> > it's feasible" stage.
> >=20
> > We could try to rearchitect QOM so that you can optionally specify QO=
M
> > stuff in the QAPI schema, then require that for QOM stuff that's part=
 of
> > a stable external interface.  Same "vague idea" stage, feasibility ev=
en
> > more doubtful.
>=20
> I think it is feasible to use QAPI to declare the QOM object type,
> QOM parent type, list of QOM interfaces and QOM properties in a
> declarative manner. From that generate all the tedious boilerplate
> code. The dev then just has to provide the "interesting" code for
> the object.
>=20
> I'd really like to do a PoC of this but never have free time :-(
> Perhaps an interesting task for someone who wants to delve into
> some new work...
>=20
>=20
> > >> >> Example: to deprecate block driver "vfat", add feature "depreca=
ted" to
> > >> >> BlockdevDriver member @vfat.
> > >> >>=20
> > >> >> Unlike your patches, this does not require finding a "somewhere=
" that
> > >> >> provides information on "something".  You simply tack "deprecat=
ed" right
> > >> >> onto "something".
> > >> >>=20
> > >> >> Your patches provide more information, however: human-readable =
messages.
> > >> >
> > >> > It also includes a machine-friendly suggested alternative (which
> > >> > I think is even more important that the human-readable message).
> > >>=20
> > >> I agree we should point to a preferred replacement whenever we dep=
recate
> > >> something.
> > >>=20
> > >> We have to do it in documentation.  And we generally do, in
> > >> qemu-deprecated.texi.
> > >>=20
> > >> How useful would doing it in QMP as well be?  Depends on what mana=
gement
> > >> applications can do with the additional information.
> > >
> > > I expect it to be useful for things that have obvious
> > > replacements, like old machine type or CPU model versions.
> >=20
> > I doubt a management application should apply suggested replacements
> > automatically, and I doubt libvirt would.  Not even when QEMU develop=
ers
> > deem them "obvious".
>=20
> We certainly won't apply the suggested replacement as in many cases
> it is not going to be a functionally equivalent drop-in.

Who's "we"?

>=20
> If QEMU logs it to stderr, it will end up in the per-VM log file
> libvirt has under /var/log/libvirt/qemu/$GUESTNAME.log.  If QEMU
> doesn't log it to stderr, then libvirt would just write it to
> that same log file itself.
>=20
> If libvirt gains some API or event for notifying apps of deprecation
> we might bubble it up to the mgmt app that way.
>=20
> I still feel it is useful to have the suggested replacement in the
> logs, rather  than only leaving it in qemu-deprecated.texi.  This
> way the info is immediately visible to both app developers and any
> support person dealing with bugs.
>=20
> If the app dev see the suggested replacement upfront they're more
> likely to make an immediate decision to update their code if the
> suggestion is trivial. If they need to go find the QEMU docs to
> lookup what action is required I feel they'll more likely just
> put the item on their long todo list where it will languish.

Agreed.  However, note that the audience for deprecation
information is not just developers and support people.  End users
need to know when they are relying on a deprecated feature, and
applications should make it as easy as possible for them to
update their configurations.

I'm not suggesting the alternative would be applied
automatically.  But having the alternative available in a
machine-friendly way may be the difference between a unhelpful UI
that just tells the user there's some problem but can't give a
solution, and one that can really assist the user to fix the
problem.

--=20
Eduardo

