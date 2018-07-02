Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZsSJ-0001rg-Jf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZsSH-0001OS-Nk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZsSH-0001OC-IN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:36:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
	<0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
	<87y3fky231.fsf@dusky.pond.sub.org>
	<87h8lrumny.fsf@dusky.pond.sub.org> <20180625150056.GF2390@work-vm>
	<874lhqr9lg.fsf@dusky.pond.sub.org> <20180629121701.GI2568@work-vm>
Date: Mon, 02 Jul 2018 08:36:55 +0200
In-Reply-To: <20180629121701.GI2568@work-vm> (David Alan Gilbert's message of
	"Fri, 29 Jun 2018 13:17:02 +0100")
Message-ID: <87601yb0u0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Dongli Zhang <dongli.zhang@oracle.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>=20
>> > * Markus Armbruster (armbru@redhat.com) wrote:
>> >> Markus Armbruster <armbru@redhat.com> writes:
>> >>=20
>> >> > Andreas F=C3=A4rber <afaerber@suse.de> writes:
>> >> >
>> >> >> Am 08.06.2018 um 11:41 schrieb Dr. David Alan Gilbert:
>> >> >>> * Andreas F=C3=A4rber (afaerber@suse.de) wrote:
>> >> >>>> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
>> >> >>>>> For debugging purposes it is very useful to:
>> >> >>>>>  - See the description of the field. This information is alread=
y filled
>> >> >>>>>    in but not shown in "qom-list" command.
>> >> >>>>
>> >> >>>> No objection on this part.
>> >> >>>>
>> >> >>>>>  - Display value of the field.
>> >> >>>>
>> >> >>>> That is by definition the qom-get operation, not qom-list. Just =
like the
>> >> >>>> ls command does not show file contents, there's cat etc. for tha=
t. For
>> >> >>>> debugging purposes we had a qom-tree (?) command that would comb=
ine
>> >> >>>> both.
>> >> >>>
>> >> >>> I'm not too bothered about distinguishing between the two command=
s;
>> >> >>> but it would be nice
>> >> >
>> >> > When an HMP and QMP both have a command with the same name, they sh=
ould
>> >> > do the same.
>> >> >
>> >> > HMP may add convenience features that aren't wanted in QMP, but I f=
eel
>> >> > extending an operation to list objects to also show their contents =
goes
>> >> > beyond that.  If we want an HMP command that does both, it should be
>> >> > named differently.  Perhaps that might even be more appropriate for=
 HMP
>> >> > than low-level commands qom-list and qom-get, but I leave that to t=
he
>> >> > HMP maintainer to decide.
>> >> >
>> >> >>>                      - one reason I'm not too bothered is because=
 we've
>> >> >>> failed to get a qom-get in multiple years of trying.
>> >> >
>> >> > We clearly haven't tried hard enough.
>> >> >
>> >> > If we can figure out how to show values in qom-list, surely we can
>> >> > figure out how to show them in qom-get.
>> >> >
>> >> >>>>       There might be unmerged patches on qemu-devel related to d=
isplay
>> >> >>>> of certain data types.
>> >> >>>=20
>> >> >>> Which ones?
>> >> >>
>> >> >> My original qom-info series needed StringOutputVisitor changes for=
 enums
>> >> >> (test case: rtc) that did not get accepted immediately and thus so=
me
>> >> >> part of HMP qom-info/qom-get got stuck due to risking assertions f=
or
>> >> >> qom-info / otherwise; QMP was not affected IIRC.
>> >> >
>> >> > Here's the last try I can find:
>> >> > [PATCH v2] qom: Implement qom-get HMP command
>> >> > Message-Id: <1473157086-12062-1-git-send-email-dgilbert@redhat.com>
>> >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.html
>> >>=20
>> >> Stalled on output format and consistency with qom-set.  I wrote back
>> >> then "We can take qom-get as is and improve its output later."  I'd l=
ike
>> >> to encourage you to dust it off.  Perfect's the enemy of good.
>> >>=20
>> >> Wanted improvements include:
>> >>=20
>> >> * Prettier output format.  I'd suggest creating a keyval variant of t=
he
>> >>   output visitor.
>> >
>> > I'm not too bothered about pretty at first, as long as we don't stop
>> > anyway of making it pretty later; especially if non-compound types work
>> > well.
>>=20
>> We've waited so long for "someone" to post a solution that satisfies all
>> wants.  We should take a solution that is useful and can grow.
>>=20
>> >> * Make qom-set input format consistent by switching to the matching
>> >>   input visitor.
>> >>=20
>> >> > Its v1 tries a different approach:
>> >> > [PATCH 0/2] qom-get [for 2.8]
>> >> > Message-Id: <1472117833-10236-1-git-send-email-dgilbert@redhat.com>
>> >> > Unfortunately the mailing list archive doesn't show the full thread=
, so
>> >> > you get to follow three links:
>> >> > https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03815.html
>> >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04261.html
>> >> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04267.html
>> >>=20
>> >> This one stalled on string visitor limitations.  You didn't feel like
>> >> addressing them just to get qom-get working.  Understandable.
>> >
>> > Have there been any changes in the last 2 years that have helped?
>>=20
>> There's been progress, but there are gaps left.
>>=20
>> Back then, we had the choice of string input/output visitors, and the
>> options visitor, all (severely) restricted to certain kinds of data.
>>=20
>> Now we have the qobject keyval input visitor, which is almost general.
>> There is no matching output visitor, yet, simply because we haven't had
>> the need.
>
> That's potentially a big help; is:

Before I answer your questions, let me reiterate: perfect's the enemy of
good.  Perfect is what has denied us qom-get in HMP.

>    a) Does keyval output here make sense (It seems reasonable, perhaps
>       with some wrapping etc)

I guess it wouldn't be my first choice on a green field.  But this field
is anything but green.

The data structure we need to print is a recursive QObject.  QObject is
basically a JSON AST.  One obvious way to print it is JSON.
Comptetitors in that space include YAML and TOML.

Unlike these three, "keyval" isn't recursive.  Instead, it uses dotted
keys to express the nesting.  Moreover, mapping from JSON to "keyval"
can lose information (see "bridge the gap" below).

But then CLI uses "keyval" syntax extensively, and HMP is related to CLI
(e.g. object_add's argument is like -object's argument).  Use of the
same format for printing information and for reading configuration is
generally appreciated by users.

QMP does that by using JSON for both.

qom-get and qom-set could do that by using "keyval" for both.

>    b) Is this the code in util/keyval.c + qapi/qobject-input-visitor.c ?

Yes.

util/keyval.c provides keyval_parse() to parse QEMU's traditional
KEY=3DVALUE,... syntax into a QDict.

The really traditional part of that syntax is flat.  Dotted key
convention provides depth, and was grafted on later.

The big comment in keyval.c spells out the flaws^Wcompromises we had to
accept to bridge the gap between KEY=3DVALUE,... and JSON.

qobject_input_visitor_new_keyval() converts a QDict made with
keyval_parse() into a QAPI type.

>    c) What's the right way to build the output - is it to use the
>       existing qobject_output_visitor and add a qobject_to_keyval - or
>       is it a job for a new visitor?

For the input visitor, I chose the former, i.e. to do the keyval visitor
as a variant of the existing qobject input visitor, simply because the
two share so much code.

I've since found talking about the two variants awkward due to
difficulties naming them.  Perhaps coining distinct, pithy names for
the two would help.

I recommend to keep output and input visitors paired, at least at the
interface.
