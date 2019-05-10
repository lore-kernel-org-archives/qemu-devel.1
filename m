Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE126C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBA42053B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBA42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1re-0002PM-9P
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:30:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP1qp-000219-0A
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP1qm-0000Uk-Eg
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hP1qm-0000UV-71
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:29:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66E8A86674
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:29:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D222B600C7;
	Fri, 10 May 2019 09:29:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 57D6D1132B35; Fri, 10 May 2019 11:29:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509181906.GN4189@habkost.net>
Date: Fri, 10 May 2019 11:29:53 +0200
In-Reply-To: <20190509181906.GN4189@habkost.net> (Eduardo Habkost's message of
	"Thu, 9 May 2019 15:19:06 -0300")
Message-ID: <87o94au06m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 10 May 2019 09:29:55 +0000 (UTC)
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

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
>> We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
>>=20
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>=20
>> > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >>=20
>> >> > On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrote:
>> >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> >>=20
>> >> >> > This series adds machine type deprecation information to the
>> >> >> > output of the `query-machines` QMP command.  With this, libvirt
>> >> >> > and management software will be able to show this information to
>> >> >> > users and/or suggest changes to VM configuration to avoid
>> >> >> > deprecated machine types.
>> >> >>=20
>> >> >> This overlaps with something I want to try, namely using Kevin's
>> >> >> proposed QAPI feature flags for deprecation markings.  Let's compa=
re the
>> >> >> two.
>> >> >>=20
>> >> >> To mark something as deprecated with your patches, you add a
>> >> >> @support-status member somewhere, where "somewhere" is related to
>> >> >> "something" by "provides information on".
>> >> >>=20
>> >> >> Example: MachineInfo (returned by query-machines) provides informa=
tion
>> >> >> on possible values of -machine parameter type.  If -machine was
>> >> >> QAPIfied, it would provide information on possible values of a QAPI
>> >> >> object type's member.  The type might be anonymous.  The member sh=
ould
>> >> >> be an enum (we currently use 'str' in MachineInfo).
>> >> >
>> >> > QAPIfying -machine, -cpu, and -device would be wonderful.
>> >> >
>> >> >>=20
>> >> >> Example: say we want to deprecate block driver "vfat",
>> >> >> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
>> >> >> multiple places; let's ignore all but BlockdevOptions.  We need to=
 add
>> >> >> @support-status to something that provides information on
>> >> >> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc q=
uery
>> >> >> providing information on either of the two, because QAPI/QMP
>> >> >> introspection has been sufficient.  What now?
>> >> >>=20
>> >> >> Can we add deprecation information to (general) QAPI/QMP introspec=
tion
>> >> >
>> >> > Yes, we can.  I think it's a good idea.  But:
>> >> >
>> >> >> instead of ad hoc queries?
>> >> >
>> >> > I'm not sure about the "instead of" part.  I don't want perfect
>> >> > to be the enemy of done, and I don't want QAPIfication of
>> >> > -machine to be a requirement to start reporting machine type
>> >> > deprecation information.
>> >>=20
>> >> Valid point.  Still, I believe we should at least try to predict how =
the
>> >> pieces we create now would fit with the pieces we plan to create later
>> >> on.
>> >
>> > Sure.
>> >
>> >>=20
>> >> Note that full QAPIfication of -machine isn't necessary to make QAPI
>> >> feature "deprecated" work for machine types.  Turning MachineInfo mem=
ber
>> >> @name into an enum, so we can tack "deprecated" onto its values, would
>> >> suffice.
>> >>=20
>> >> Such a QAPIfication of machine types is still hard: QOM types are
>> >> defined at compile time just like the QAPI schema, but their definiti=
on
>> >> is distributed, and collected into one place only at run time.  I
>> >> discussed this on slide 39 of my "QEMU interface introspection: From
>> >> hacks to solutions" talk (KVM Form 2015).  Just for device_add, but i=
t's
>> >> just a special case of QOM.  Choices listed there:
>> >>=20
>> >> * Collect drivers at compile time? Hard...
>> >> * Make QAPI schema dynamic? Hard...
>> >> * Forgo driver-specific arguments in schema?
>> >>   Defeats introspection...
>> >>=20
>> >> I'd like to add to the last item:
>> >>=20
>> >>   Provide QOM introspection on par with QAPI schema introspection
>> >>=20
>> >> The QOM introspection we have (qom-list-types etc. is not on par.
>> >
>> > Agreed, but do we really want to do it?  We have been avoiding
>> > exposing QOM internals to the outside on purpose.  I believe
>> > there are at least two reasons for that:
>> >
>> > 1) Not every QOM type/property is supposed to be visible to the
>> >    outside
>>=20
>> True.
>>=20
>> However, the parts of QOM exposed via device_add and object-add are
>> definitely part of the stable external interface (unless explicitly
>> marked unstable).
>>=20
>> >            (and nobody really knows what's the full set of
>> >    supported external QOM interfaces);
>>=20
>> Also true.  And terrible.
>>=20
>> > 2) QAPI is our preferred interface interface specification/introspecti=
on
>> >    mechanism.
>>=20
>> When preferences and requirements collide, preferences tend to get run
>> over.
>>=20
>> The QAPI schema is *declarative*: the schema declares QAPI objects and
>> properties.  We generate C from the schema, which we then compile and
>> link into QEMU.
>>=20
>> QOM is by design *imperative*: we execute compiled C at QEMU run-time to
>> define QOM objects and properties.  Maximizes flexibility.  See also
>> Turing tarpit.
>>=20
>> No matter how much we'd prefer to use QAPI to specify external
>> interfaces to QOM, we can't without making QAPI much more dynamic or QOM
>> much more static.  Either is hard.  Quite possibly infeasible.
>>=20
>> We could try to extend QAPI/QMP introspection to somehow merge in
>> additional information at run-time[1].  Could be regarded as a limited
>> way to make QAPI more dynamic.  This is in the "vague idea, not sure
>> it's feasible" stage.
>>=20
>> We could try to rearchitect QOM so that you can optionally specify QOM
>> stuff in the QAPI schema, then require that for QOM stuff that's part of
>> a stable external interface.  Same "vague idea" stage, feasibility even
>> more doubtful.
>>=20
>> If I remember correctly, Paolo suggested to abandon the idea to have
>> query-qmp-schema cover device_add as infeasible.  Instead, cover it
>> separately.
>>=20
>> I think this separate introspection mechanism should be as similar to
>> query-qmp-schema as practical.  It should cover not just device_add, but
>> also object-add, and whatever other external interface to QOM we deem
>> stable.
>
> I think we are in agreement here.  We don't need to make the new
> introspection mechanism part of query-qmp-schema, but I think it
> should use the same abstractions.

I agree we're basically in agreement :)

Covering dynamically defined external interfaces (such as device_add and
object-add) in query-qmp-schema would certainly be nice, but it's not a
hard requirement.  If we can't, then having separate introspection
commands share abstractions as much as practical is desirable.

>> Should there be more stable external interfaces that can't be defined in
>> the QAPI schema, we might want to cover them in this second
>> introspection mechanism, too.
>
> Agreed.
>
>>=20
>> >> Back to exposing machine type deprecation.
>> >>=20
>> >> I'm doubtful your proposed solution can be applied widely.  It relies=
 on
>> >> adding @support-status to something that provides information on
>> >> whatever is deprecated.  The initial use is with a something that is =
an
>> >> ad hoc query, namely query-machines.  To use it, the management
>> >> application needs to understand what query-machines' @support-status
>> >> applies to.  Certainly feasible.  But I fear every use will be a spec=
ial
>> >> case.  Furthermore, a suitable ad hoc query need not exist.  What the=
n?
>> >> Create suitable ad hoc queries just for communicating deprecation?
>> >>=20
>> >> Instead, I'd like us to think about a more genral solution.  Or perha=
ps
>> >> two: one for properly QAPIfied stuff, and one for QOM.
>> >
>> > Should we really spend our time designing a second solution, if
>> > we could build this on top of QAPI abstractions?  Making the QAPI
>> > schema dynamic might be hard, but reinventing QAPI and
>> > maintaining the two systems in parallel seems harder.
>>=20
>> I'd love to see a practical way forward that keeps QAPI/QMP
>> introspection the only game in town.
>>=20
>> >> >> Kevin's proposed QAPI feature flags[*] extend the QAPI language so=
 that
>> >> >> struct types can optionally have a list of feature flags, which are
>> >> >> strings.  Struct types suffice for his immediate needs.  I'd like =
to use
>> >> >> feature flags to mark deprecation by tacking a "deprecated" featur=
e onto
>> >> >> whatever is deprecated.  This obviously needs feature support for
>> >> >> everything we want to be able to deprecate: commands, and events, =
as
>> >> >> well as members of enum and object types.
>> >> >>=20
>> >> >> Example: to deprecate block driver "vfat", add feature "deprecated=
" to
>> >> >> BlockdevDriver member @vfat.
>> >> >>=20
>> >> >> Unlike your patches, this does not require finding a "somewhere" t=
hat
>> >> >> provides information on "something".  You simply tack "deprecated"=
 right
>> >> >> onto "something".
>> >> >>=20
>> >> >> Your patches provide more information, however: human-readable mes=
sages.
>> >> >
>> >> > It also includes a machine-friendly suggested alternative (which
>> >> > I think is even more important that the human-readable message).
>> >>=20
>> >> I agree we should point to a preferred replacement whenever we deprec=
ate
>> >> something.
>> >>=20
>> >> We have to do it in documentation.  And we generally do, in
>> >> qemu-deprecated.texi.
>> >>=20
>> >> How useful would doing it in QMP as well be?  Depends on what managem=
ent
>> >> applications can do with the additional information.
>> >
>> > I expect it to be useful for things that have obvious
>> > replacements, like old machine type or CPU model versions.
>>=20
>> I doubt a management application should apply suggested replacements
>> automatically, and I doubt libvirt would.  Not even when QEMU developers
>> deem them "obvious".
>>=20
>> >> > We could extend QAPI introspection to return that if necessary,
>> >> > right?
>> >>=20
>> >> I'm confident we can come up with *something*.  It might kill the neat
>> >> and simple "use QAPI features to communicate deprecation" idea, thoug=
h.
>> >
>> > If something is important enough to be communicated through
>> > stderr, it's important enough to be communicated through QMP.
>>=20
>> Mostly.  Differences are due to the different consumers.
>>=20
>> stderr is primarily for human users.  We print stuff useful to human
>> users.
>
> We have users that don't have access to stderr.  They might have
> access to log files, but log files are pretty bad user
> interfaces.  If it's important for some set of human users, apps
> using libvirt or QMP need access to that information so they can
> show it to their human users too.

Command line means stderr.

I'm afraid our command line is awkward both for machines and for humans,
albeit for different reasons.

For humans doing simple things, the command line is okay.  But beyond
that, it gets forbiddingly unwieldy[2].

Machines are fine with that kind of unwieldy, but would prefer something
with more structure, both on input (talking to QEMU) and even more so on
output (QEMU talking back).

Ideally, we'd support machines do their work in (structured) QMP,
resorting to the command line only to set up a QMP monitor.  We're not
anywhere close to this.

As long as management applications use the command line in not-trivial
ways, they have to deal with configuration errors reported via stderr.

>> QMP is primarily for machines, secondarily for the humans building these
>> machines.  We send stuff useful to the machines themselves, and stuff
>> the machines can use to be more useful for their users (which may be
>> machines or humans).  We can also send stuff to help the humans building
>> the machines.
>>
>> In any case, the information we provide is limited by the cost to
>> provide it.
>
> Absolutely.
>
>>=20
>> > Is that enough reason to provide something more complex?
>>=20
>> We need to consider cost / benefit.
>>=20
>> On benefit, I'd like to know what libvirt would do with the additional
>> information beyond logging it.
>
> I'd say it should provide it to apps, otherwise this won't be
> more useful than the existing log files.

A management application simply showing its user whatever error QEMU
reports or hint it provides is bound to be confusing: since QEMU talks
in QEMU terms, its errors and hints generally need translation to make
sense at higher layers.  Translation involves recognizing specific
messages, which means it's limited to special cases (and painfully
brittle).

The farther you propagate QEMU's messages up the stack, the less sense
they'll likely make.

Management applications logging QEMU's messages is useful anyway, mainly
because it's better than nothing.

I doubt logging them some more further up the stack would be all that
useful, but I might be wrong.

Discussed further elsewhere in this thread.

>> Is the additional information you propose to provide static or dynamic?
>>=20
>> By "static", I mean each occurence of a feature in the QAPI schema is
>> tied to one fixed instance of "additional information".
>
> I don't think I understand this description of "static".  I
> expect the data to be fixed at build time, but I expect it to be
> different in downstream distributions of QEMU.

Let me try differently.

QAPI features as currently envisaged convey one bit of information:
there / not there.  The information is fixed at build time.  It is tied
to a specific QAPI entity (command, object type, enumeration value,
...).

My question is about the difference between this and what you have in
mind.  Specifically, is the difference only the amount of information
(one bit vs. a pair of string literals), or is there more?

"More" includes string values that can vary at run time or between
different uses of the QAPI entity in the schema.

>> > Do we need QAPI features to be just strings?  Can't they be a
>> > more complex type, like a QAPI alternate?
>>=20
>> Adds complexity.
>>=20
>> We currently imagine QAPI features enum-like, i.e. a list of strings,
>> optionally with conditions.  The conditions are evaluated at QAPI
>> generation time, and not visible in introspection.
>>=20
>> This is probably the stupidest solution that could possibly work.  The
>> structure of features is trivial.
>>=20
>> More expressive solutions include:
>>=20
>> * List of 'any'.  Feels like a bad idea, because it's completely
>>   unstructured.
>
> Agreed.
>
>>=20
>> * List of some 'QapiFeatures' object type.  Lets us expose the variable
>>   structure of features in introspection.
>>=20
>> * List of some 'QapiFeatures' alternate type.  Like the previous, but
>>   permits coding simple feature flags as strings.
>>=20
>> All of the more expressive solutions I listed treat the additional
>> information as dynamic.  Overly general in case the information is
>> actually always static.
>
> The static vs. dynamic distinction is getting me confused.  Why
> are the more expressive solutions more dynamic than "list of
> strings"?  Can you give examples?

Insufficiently precise thinking leads to vague and confusing prose.  Let
me try again.

The scenario I had in mind is having only the (static) structure of the
additional information in query-qmp-schema, and the actual (possibly
dynamic) information elsewhere, say in query-machines, or a new member
of the QMP success response.

> Also, why do we want to place all info inside the same "features"
> attribute instead of just adding new fields to SchemaInfoObject?
>
> i.e. why are these options:
>
>   { "members" [ ... ],
>     "features": [ "dynamic-read-only", "deprecated" ] }
>
>   { "members" [ ... ],
>     "features": [ "dynamic-read-only",
>                   { "deprecated": true, "hint": "FOO" } ] }
>
> better than these options:
>
>   { "members" [ ... ],
>     "features": [ "dynamic-read-only" ],
>     "deprecated": true }
>
>   { "members" [ ... ],
>     "features": [ "dynamic-read-only" ],
>     "deprecation-info": { "deprecated": true, "hint": "FOO" } }

I wouldn't claim "better".  I merely observe it takes its own QAPI
language extension, unlike the 'neat and simple "use QAPI features to
communicate deprecation" idea'.

>> >> >> Food for thought :)
>> >> >>=20
>> >> >>=20
>> >> >> [*] Hiding in
>> >> >> Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI f=
eature
>> >> >> Date: Mon,  8 Apr 2019 16:35:39 +0200
>> >> >> Message-Id: <20190408143543.3982-1-kwolf@redhat.com>
>>=20
>>=20
>> [1] Special case of "merge additional information into QAPI/QMP
>> introspection at run-time, relegated to a footnote, because I think it's
>> of mostly historical interest now.
>>=20
>> Qdev was designed to be declarative, but the declarations always got
>> collected only at run-time.  It has since been rebased onto imperative
>> QOM.  Since you can mix declarative qdev and imperative QOM, the
>> combination is effectively imperative.
>>=20
>> We could collect the declarative parts of qdev at compile-time somehow,
>> and fold them into QAPI introspection.  That's the "Collect drives at
>> compile time" item from the slide I quoted.  I think this idea has
>> become pretty much worthless, since it would cover device_add only in
>> part, and object-add not at all.

[2] Example quoted from my "Towards a more expressive and introspectable
QEMU command line" talk at KVM Forum 2017 (predating -blockdev, which
spices up things even more):
/usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name boxes-unknown -S -ma=
chine pc-i440fx-1.6,accel=3Dkvm,usb=3Doff -cpu Penryn -m 3115 -realtime mlo=
ck=3Doff -smp 4,sockets=3D1,cores=3D4,threads=3D1 -uuid 8bd53789-adab-484f-=
8c53-a6df9d5f1dbf -no-user-config -nodefaults -chardev socket,id=3Dcharmoni=
tor,path=3D/home/guillaume/.config/libvirt/qemu/lib/boxes-unknown.monitor,s=
erver,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc ba=
se=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard -no-shu=
tdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot=
 strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -de=
vice ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifuncti=
on=3Don,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,b=
us=3Dpci.0,addr=3D0x5.0x1-device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=
=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -device virtio-serial-pci,id=3Dvirtio-seria=
l0,bus=3Dpci.0,addr=3D0x6 -device usb-ccid,id=3Dccid0 -drive file=3D/home/g=
uillaume/.local/share/gnome-boxes/images/boxes-unknown,if=3Dnone,id=3Ddrive=
-ide0-0-0,format=3Dqcow2,cache=3Dnone -device ide-hd,bus=3Dide.0,unit=3D0,d=
rive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddri=
ve-ide0-1-0,readonly=3Don,format=3Draw -device ide-cd,bus=3Dide.1,unit=3D0,=
drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev tap,fd=3D23,id=3Dhostnet0 -dev=
ice rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:db:56:54,bus=3Dpci.0=
,addr=3D0x3 -chardev spicevmc,id=3Dcharsmartcard0,name=3Dsmartcard -device =
ccid-card-passthru,chardev=3Dcharsmartcard0,id=3Dsmartcard0,bus=3Dccid0.0 -=
chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3D=
serial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtseri=
alport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,n=
ame=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput0 -spice port=3D5901,=
addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff,seamless-migrati=
on=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D6710886=
4,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -device AC97,id=3Dsound0,bus=3Dpci.=
0,addr=3D0x4 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-=
redir,chardev=3Dcharredir0,id=3Dredir0 -chardev spicevmc,id=3Dcharredir1,na=
me=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1 -chardev s=
picevmc,id=3Dcharredir2,name=3Dusbredir -device usb-redir,chardev=3Dcharred=
ir2,id=3Dredir2 -chardev spicevmc,id=3Dcharredir3,name=3Dusbredir -device u=
sb-redir,chardev=3Dcharredir3,id=3Dredir3 -incoming fd:20 -device virtio-ba=
lloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=3Don

