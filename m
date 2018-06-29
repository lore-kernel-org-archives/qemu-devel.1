Received: from eggs.gnu.org ([2001:4830:134:3::10]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fYsgX-0005J9-2P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fYsgT-0007HN-NF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:39:33 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
	([40.107.4.94]:4512
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ricardo.perez_blanco@nokia.com>)
	id 1fYsgT-0007DM-Co
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:39:29 -0400
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Fri, 29 Jun 2018 12:39:26 +0000
Message-ID: <DB7PR07MB38499C9E027EAAC0534AAE8BB34E0@DB7PR07MB3849.eurprd07.prod.outlook.com>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
	<0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
	<87y3fky231.fsf@dusky.pond.sub.org> <87h8lrumny.fsf@dusky.pond.sub.org>
	<20180625150056.GF2390@work-vm> <874lhqr9lg.fsf@dusky.pond.sub.org>
	<20180629121701.GI2568@work-vm>
In-Reply-To: <20180629121701.GI2568@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, June 29, 2018 2:17 PM
> To: Markus Armbruster <armbru@redhat.com>
> Cc: Perez Blanco, Ricardo (Nokia - BE/Antwerp)
> <ricardo.perez_blanco@nokia.com>; Andreas F=E4rber <afaerber@suse.de>;
> Dongli Zhang <dongli.zhang@oracle.com>; qemu-devel <qemu-
> devel@nongnu.org>
> Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when
> using "qom-list"
>=20
> * Markus Armbruster (armbru@redhat.com) wrote:
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >
> > > * Markus Armbruster (armbru@redhat.com) wrote:
> > >> Markus Armbruster <armbru@redhat.com> writes:
> > >>
> > >> > Andreas F=E4rber <afaerber@suse.de> writes:
> > >> >
> > >> >> Am 08.06.2018 um 11:41 schrieb Dr. David Alan Gilbert:
> > >> >>> * Andreas F=E4rber (afaerber@suse.de) wrote:
> > >> >>>> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
> > >> >>>>> For debugging purposes it is very useful to:
> > >> >>>>>  - See the description of the field. This information is alrea=
dy
> filled
> > >> >>>>>    in but not shown in "qom-list" command.
> > >> >>>>
> > >> >>>> No objection on this part.
> > >> >>>>
> > >> >>>>>  - Display value of the field.
> > >> >>>>
> > >> >>>> That is by definition the qom-get operation, not qom-list.
> > >> >>>> Just like the ls command does not show file contents, there's
> > >> >>>> cat etc. for that. For debugging purposes we had a qom-tree
> > >> >>>> (?) command that would combine both.
> > >> >>>
> > >> >>> I'm not too bothered about distinguishing between the two
> > >> >>> commands; but it would be nice
> > >> >
> > >> > When an HMP and QMP both have a command with the same name,
> they
> > >> > should do the same.
> > >> >
> > >> > HMP may add convenience features that aren't wanted in QMP, but I
> > >> > feel extending an operation to list objects to also show their
> > >> > contents goes beyond that.  If we want an HMP command that does
> > >> > both, it should be named differently.  Perhaps that might even be
> > >> > more appropriate for HMP than low-level commands qom-list and
> > >> > qom-get, but I leave that to the HMP maintainer to decide.
> > >> >
> > >> >>>                      - one reason I'm not too bothered is
> > >> >>> because we've failed to get a qom-get in multiple years of tryin=
g.
> > >> >
> > >> > We clearly haven't tried hard enough.
> > >> >
> > >> > If we can figure out how to show values in qom-list, surely we
> > >> > can figure out how to show them in qom-get.
> > >> >
> > >> >>>>       There might be unmerged patches on qemu-devel related to
> > >> >>>> display of certain data types.
> > >> >>>
> > >> >>> Which ones?
> > >> >>
> > >> >> My original qom-info series needed StringOutputVisitor changes
> > >> >> for enums (test case: rtc) that did not get accepted immediately
> > >> >> and thus some part of HMP qom-info/qom-get got stuck due to
> > >> >> risking assertions for qom-info / otherwise; QMP was not affected
> IIRC.
> > >> >
> > >> > Here's the last try I can find:
> > >> > [PATCH v2] qom: Implement qom-get HMP command
> > >> > Message-Id:
> > >> > <1473157086-12062-1-git-send-email-dgilbert@redhat.com>
> > >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.ht
> > >> > ml
> > >>
> > >> Stalled on output format and consistency with qom-set.  I wrote
> > >> back then "We can take qom-get as is and improve its output later."
> > >> I'd like to encourage you to dust it off.  Perfect's the enemy of go=
od.
> > >>
> > >> Wanted improvements include:
> > >>
> > >> * Prettier output format.  I'd suggest creating a keyval variant of =
the
> > >>   output visitor.
> > >
> > > I'm not too bothered about pretty at first, as long as we don't stop
> > > anyway of making it pretty later; especially if non-compound types
> > > work well.
> >
> > We've waited so long for "someone" to post a solution that satisfies
> > all wants.  We should take a solution that is useful and can grow.
> >
> > >> * Make qom-set input format consistent by switching to the matching
> > >>   input visitor.
> > >>
> > >> > Its v1 tries a different approach:
> > >> > [PATCH 0/2] qom-get [for 2.8]
> > >> > Message-Id:
> > >> > <1472117833-10236-1-git-send-email-dgilbert@redhat.com>
> > >> > Unfortunately the mailing list archive doesn't show the full
> > >> > thread, so you get to follow three links:
> > >> > https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03815.ht
> > >> > ml
> > >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04261.ht
> > >> > ml
> > >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04267.ht
> > >> > ml
> > >>
> > >> This one stalled on string visitor limitations.  You didn't feel
> > >> like addressing them just to get qom-get working.  Understandable.
> > >
> > > Have there been any changes in the last 2 years that have helped?
> >
> > There's been progress, but there are gaps left.
> >
> > Back then, we had the choice of string input/output visitors, and the
> > options visitor, all (severely) restricted to certain kinds of data.
> >
> > Now we have the qobject keyval input visitor, which is almost general.
> > There is no matching output visitor, yet, simply because we haven't
> > had the need.
>=20
> That's potentially a big help; is:
>    a) Does keyval output here make sense (It seems reasonable, perhaps
>       with some wrapping etc)
>    b) Is this the code in util/keyval.c + qapi/qobject-input-visitor.c ?
>    c) What's the right way to build the output - is it to use the
>       existing qobject_output_visitor and add a qobject_to_keyval - or
>       is it a job for a new visitor?
>=20
> Dave
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Hi guys,

This discussion is out of my field of expertise. I am still a newcomer in q=
emu's project : D

I developed the improvement in qom-list and not in qom-get as it was easier=
 and much more straight forward to me. Moreover, for debugging purposes, I =
found easier to see all values in one command and not to have to execute se=
veral times qom-get.

Nonetheless, I see this is a controversial topic (and I fully understand wh=
y it is) so I let up to you to make the final decision of accepting it or n=
ot.

Regarding code improvements/bugs, there are still a couple of points to be =
addressed:=20
-@Erik blake pointed an error in the "since version" is not correct
- I recall another colleague pointing that I should merge again with mainst=
ream.

If these are the only remarks, I will deliver a v3 patch with these and it =
is up to you to decide to make official or not.

Kr,

Ricardo
