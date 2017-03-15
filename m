Received: from eggs.gnu.org ([2001:4830:134:3::10]:56868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1co9UG-00006h-BM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1co9UA-00073q-Il
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:01:12 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1co9U9-00073D-V3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:01:06 -0400
Received: by mail-lf0-x235.google.com with SMTP id z15so7342219lfd.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<CAJ+F1CKiE2FHjS0_K2F+yS-ByZMtVVFh6+NLm_q4_myeg=_KdQ@mail.gmail.com>
	<87lgs974rd.fsf@dusky.pond.sub.org>
	<CAJ+F1CL_iQNVN5a=rZ93bWnnG89710aBkN7iT_eiqNtwJRk=7w@mail.gmail.com>
	<8760jd5nhw.fsf@dusky.pond.sub.org>
	<CAJ+F1C+FBx07+WBx4hZKDdWTS8-Z56JfiJgFzy2gLnWos17GYw@mail.gmail.com>
	<877f3rygwu.fsf@dusky.pond.sub.org>
In-Reply-To: <877f3rygwu.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Mar 2017 14:00:52 +0000
Message-ID: <CAJ+F1C+xbfZFb7rXWjZfKHOANMgsFFuNASbSj63ewXb6J0RHSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Hi

On Tue, Mar 14, 2017 at 8:14 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Mon, Mar 13, 2017 at 5:12 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Mon, Mar 13, 2017 at 4:14 PM Markus Armbruster <armbru@redhat.com=
>
> wrote:
> >> >
> >> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >> >>
> >> >> > Hi
> >> >> >
> >> >> > On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <
> armbru@redhat.com
> >> >
> >> >> > wrote:
> >> >> >
> >> >> >> I'm proposing this is 2.9 because it fixes a documentation
> regression.
> >> >> >> It affects only documentation; generated C code is unchanged
> except
> >> >> >> for the removal of trailing space in PATCH 46.
> >> >> >>
> >> >> >> Based on my qapi-next branch, which contains Marc-Andr=C3=A9's P=
ATCH
> 1/2.
> >> >> >>
> >> >> >> Marc-Andr=C3=A9's work to merge qmp-commands.txt and qmp-events.=
txt
> into
> >> >> >> the QAPI schema and generate their replacements from the schema
> >> >> >> (commit b6af8ea..56e8bdd) was a big step forward.  As committed,
> it
> >> >> >> also was a step back: the documentation lost information on JSON
> >> >> >> types, because I didn't like Marc-Andr=C3=A9's patch to add it. =
 He
> >> >> >> reposted it for further review afterwards:
> >> >> >>
> >> >> >>     Subject: [PATCH 0/2] qapi2texi: add type information
> >> >> >>     Message-Id: <
> 20170125130308.16104-1-marcandre.lureau@redhat.com>
> >> >> >>
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05432.html
> >> >> >>
> >> >> >> His PATCH 1/2 is a straightforward cleanup.  His PATCH 2/2 adds
> type
> >> >> >> descriptions in a new formal language to the generated
> documentation.
> >> >> >> Quoting the commit message:
> >> >> >>
> >> >> >>     Array types have the following syntax: type[]. Ex: str[].
> >> >> >>
> >> >> >>     - Struct, commands and events use the following members
> syntax:
> >> >> >>
> >> >> >>       { 'member': type, ('foo': str), ... }
> >> >> >>
> >> >> >>     Optional members are under parentheses.
> >> >> >>
> >> >> >>     A structure with a base type will have 'BaseStruct +'
> prepended.
> >> >> >>
> >> >> >>     - Alternates use the following syntax:
> >> >> >>
> >> >> >>       [ 'foo': type, 'bar': type, ... ]
> >> >> >>
> >> >> >>     - Simple unions use the following syntax:
> >> >> >>
> >> >> >>       { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar':
> type... ] }
> >> >> >>
> >> >> >>     - Flat unions use the following syntax:
> >> >> >>
> >> >> >>       BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar':
> type... ]
> >> >> >>
> >> >> >> End quote.  Looks like this in generated documentation:
> >> >> >>
> >> >> >>  -- Event: VNC_CONNECTED {'server': VncServerInfo, 'client':
> >> >> >>           VncBasicInfo}
> >> >> >>
> >> >> >>      Emitted when a VNC client establishes a connection
> >> >> >>      ''server''
> >> >> >>           server information
> >> >> >>      ''client''
> >> >> >>           client information
> >> >> >>
> >> >> >>      Note: This event is emitted before any authentication takes
> place,
> >> >> >>      thus the authentication ID is not provided
> >> >> >> [...]
> >> >> >>
> >> >> >>  -- Struct: VncServerInfo VncBasicInfo + {('auth': str)}
> >> >> >>
> >> >> >>      The network connection information for server
> >> >> >>      ''auth'' (optional)
> >> >> >>           authentication method used for the plain
> (non-websocket) VNC
> >> >> >>           server
> >> >> >>
> >> >> >>      Since: 2.1
> >> >> >>
> >> >> >>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =
=3D
> ['inet':
> >> >> >>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
> >> >> >>           VsockSocketAddress, 'fd': String] }
> >> >> >>
> >> >> >>      Captures the address of a socket, which could also be a
> named file
> >> >> >>      descriptor
> >> >> >>
> >> >> >>      Since: 1.3
> >> >> >>
> >> >> >> Here's my counter-proposal: instead of inventing a formal
> language,
> >> >> >> fix the natural language documentation to actually mention *all*
> >> >> >> members, and add type information in a plain, easy-to-understand
> way.
> >> >> >> Looks like this:
> >> >> >>
> >> >> >>  -- Event: VNC_CONNECTED
> >> >> >>
> >> >> >>      Emitted when a VNC client establishes a connection
> >> >> >>
> >> >> >>      Arguments:
> >> >> >>      'server: VncServerInfo'
> >> >> >>           server information
> >> >> >>      'client: VncBasicInfo'
> >> >> >>           client information
> >> >> >>
> >> >> >>      Note: This event is emitted before any authentication takes
> place,
> >> >> >>      thus the authentication ID is not provided
> >> >> >> [...]
> >> >> >>
> >> >> >>  -- Object: VncServerInfo
> >> >> >>
> >> >> >>      The network connection information for server
> >> >> >>
> >> >> >>      Members:
> >> >> >>      'auth: string' (optional)
> >> >> >>           authentication method used for the plain
> (non-websocket) VNC
> >> >> >>           server
> >> >> >>      The members of 'VncBasicInfo'
> >> >> >>
> >> >> >>      Since: 2.1
> >> >> >>
> >> >> >>  -- Object: SocketAddress
> >> >> >>
> >> >> >>      Captures the address of a socket, which could also be a
> named file
> >> >> >>      descriptor
> >> >> >>
> >> >> >>      Members:
> >> >> >>      'type'
> >> >> >>           One of "inet", "unix", "vsock", "fd"
> >> >> >>      'data: InetSocketAddress' when 'type' is "inet"
> >> >> >>      'data: UnixSocketAddress' when 'type' is "unix"
> >> >> >>      'data: VsockSocketAddress' when 'type' is "vsock"
> >> >> >>      'data: String' when 'type' is "fd"
> >> >> >>
> >> >> >>      Since: 1.3
> >> >> >>
> >> >> >>
> >> >> > I like both, to me they serve different purposes. I like to have =
a
> short
> >> >> > overview / signature and then a more detailed documentation for
> each
> >> >> field.
> >> >>
> >> >> I sympathize with the argument.  Unfortunately, the "short"
> signatures
> >> >> are anything but for real-world QAPI:
> >> >>
> >> >
> >> > That's a worse case, a regular case is more readable.
> >>
> >> There are readable cases, but there are plenty of cases that plainly
> >> aren't.
> >>
> >> 102 out of 472 signatures don't count because they're empty.
> >>
> >> Roughly half the non-empty signatures fit on a single line.  That's
> short.
> >>
> >> A bit under a third take two lines.  I guess that's still short enough=
.
> >>
> >> More than one in six signatures is three lines or more.
> >>
> >> >                                                       And it is stil=
l
> >> > useful anyway since the common members would be listed first.
> >>
> >> Whatever comes first in signatures comes first in the table of members=
,
> >> too.  The names are easier to spot there, because they're all on the
> >> left.
> >>
> >> Compare
> >>
> >>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['in=
et':
> >>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
> >>           VsockSocketAddress, 'fd': String] }
> >>
> >>      Captures the address of a socket, which could also be a named fil=
e
> >>      descriptor
> >>
> >>      Since: 1.3
> >>
> >> to
> >>
> >>  -- Object: SocketAddress
> >>
> >>      Captures the address of a socket, which could also be a named fil=
e
> >>      descriptor
> >>
> >>      Members:
> >>      'type'
> >>           One of "inet", "unix", "vsock", "fd"
> >>      'data: InetSocketAddress' when 'type' is "inet"
> >>      'data: UnixSocketAddress' when 'type' is "unix"
> >>      'data: VsockSocketAddress' when 'type' is "vsock"
> >>      'data: String' when 'type' is "fd"
> >>
> >>      Since: 1.3
> >>
> >> In my opinion, the three lines of signature add nothing but noise to t=
he
> >> six lines of member table.
> >>
> >
> > It is more natural and faster to read to me for commands and events for
> > example.  The verbose description is mixing description and sometime ev=
en
> > providing redundant information (ex: keys: array of KeyValue,  An array
> of
> > 'KeyValue' elements...), slowing reading even more.
>
> Doc comments that merely restate the type should be cleaned up.
>
>
It's not just that, it's also the verbosity of the description that
clutters the information you need.

>                                                     Often you don't need
> to
> > read the documentation / description, you want to quickly check the
> return
> > type, and remind you the arguments.
>
> Point taken.
>
> A formal description of unbounded (and often excessive) length can't
> serve that purpose, though.
>

In which case we are screwed anyway in any form


>
> A sufficiently condensed summaries just might.  Perhaps names only, no
> types.  Certainly no more than a few.
>
> For instance, having
>
>  -- Command: block-job-set-speed device speed
>
> instead of just
>
>  -- Command: block-job-set-speed
>
> feels okay; the additional two words are technically redundant, but they
> might occasionally serve someone as a reminder, and they're not
> distracting.
>

In my generated pdf, using my type proposal (I use it daily), I have:

block-job-set-speed (=E2=80=99device=E2=80=99: str , =E2=80=99speed=E2=80=
=99: int )

Which I find useful. I am going to lack it, and in fact I'll probably
maintain my own version of the document if we don't have that declaration
form. At least for a while, until I get used to your type version
eventually).

It feels like bikeshedding at this point, and you are the maintainer, so
I'll probably stop arguing, but it doesn't mean I am satisfied with your
proposal.


> But I feel
>
>  -- Command: blockdev-mirror [job-id] device target [replaces] sync
>           [speed] [granularity] [buf-size] [on-source-error]
>           [on-target-error] [filter-node-name]
>
> is pushing it.
>
> So this begs the question which ones to omit when there are more than a
> few.  I'm afraid asking a stupid computer program to pick out
> "important" arguments is asking for too much.  For high-quality
> summaries, we'd have to pick ourselves.
>
> Moreover, what to do for truly complex commands like blockdev-add?
> Simply omitting all variant members is one option:
>
>  -- Command: blockdev-add driver [node-name] [discard] [cache]
>           [read-only] [detect-zeroes] ...
>
> But what may work for blockdev-add need not work for other complex
> commands.
>
> > struct/objects are more commonly declared with a line per member, so it
> > doesn't bother me as much.
> >
> > I would appreciate if can have the declarative form for commands and
> events
> > at least. Other types are usually more complex or long, so that may cle=
ar
> > your concerns for the long declarations.
>
> The worst offenders are actually commands such as blockdev-add and
> block_set_io_throttle, unless we give up on the "reminder" mission for
> them and merely add a reference to their (named) argument type.
>
--=20
Marc-Andr=C3=A9 Lureau
