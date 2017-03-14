Received: from eggs.gnu.org ([2001:4830:134:3::10]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnp5k-0000XT-9O
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnp5h-0004kC-20
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnp5g-0004k4-PX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:14:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<CAJ+F1CKiE2FHjS0_K2F+yS-ByZMtVVFh6+NLm_q4_myeg=_KdQ@mail.gmail.com>
	<87lgs974rd.fsf@dusky.pond.sub.org>
	<CAJ+F1CL_iQNVN5a=rZ93bWnnG89710aBkN7iT_eiqNtwJRk=7w@mail.gmail.com>
	<8760jd5nhw.fsf@dusky.pond.sub.org>
	<CAJ+F1C+FBx07+WBx4hZKDdWTS8-Z56JfiJgFzy2gLnWos17GYw@mail.gmail.com>
Date: Tue, 14 Mar 2017 17:14:25 +0100
In-Reply-To: <CAJ+F1C+FBx07+WBx4hZKDdWTS8-Z56JfiJgFzy2gLnWos17GYw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 14 Mar 2017
	13:22:24 +0000")
Message-ID: <877f3rygwu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 5:12 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > On Mon, Mar 13, 2017 at 4:14 PM Markus Armbruster <armbru@redhat.com> =
wrote:
>> >
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> >>
>> >> > Hi
>> >> >
>> >> > On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.c=
om
>> >
>> >> > wrote:
>> >> >
>> >> >> I'm proposing this is 2.9 because it fixes a documentation regress=
ion.
>> >> >> It affects only documentation; generated C code is unchanged except
>> >> >> for the removal of trailing space in PATCH 46.
>> >> >>
>> >> >> Based on my qapi-next branch, which contains Marc-Andr=C3=A9's PAT=
CH 1/2.
>> >> >>
>> >> >> Marc-Andr=C3=A9's work to merge qmp-commands.txt and qmp-events.tx=
t into
>> >> >> the QAPI schema and generate their replacements from the schema
>> >> >> (commit b6af8ea..56e8bdd) was a big step forward.  As committed, it
>> >> >> also was a step back: the documentation lost information on JSON
>> >> >> types, because I didn't like Marc-Andr=C3=A9's patch to add it.  He
>> >> >> reposted it for further review afterwards:
>> >> >>
>> >> >>     Subject: [PATCH 0/2] qapi2texi: add type information
>> >> >>     Message-Id: <20170125130308.16104-1-marcandre.lureau@redhat.co=
m>
>> >> >>     https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05432=
.html
>> >> >>
>> >> >> His PATCH 1/2 is a straightforward cleanup.  His PATCH 2/2 adds ty=
pe
>> >> >> descriptions in a new formal language to the generated documentati=
on.
>> >> >> Quoting the commit message:
>> >> >>
>> >> >>     Array types have the following syntax: type[]. Ex: str[].
>> >> >>
>> >> >>     - Struct, commands and events use the following members syntax:
>> >> >>
>> >> >>       { 'member': type, ('foo': str), ... }
>> >> >>
>> >> >>     Optional members are under parentheses.
>> >> >>
>> >> >>     A structure with a base type will have 'BaseStruct +' prepende=
d.
>> >> >>
>> >> >>     - Alternates use the following syntax:
>> >> >>
>> >> >>       [ 'foo': type, 'bar': type, ... ]
>> >> >>
>> >> >>     - Simple unions use the following syntax:
>> >> >>
>> >> >>       { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type=
... ] }
>> >> >>
>> >> >>     - Flat unions use the following syntax:
>> >> >>
>> >> >>       BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type.=
.. ]
>> >> >>
>> >> >> End quote.  Looks like this in generated documentation:
>> >> >>
>> >> >>  -- Event: VNC_CONNECTED {'server': VncServerInfo, 'client':
>> >> >>           VncBasicInfo}
>> >> >>
>> >> >>      Emitted when a VNC client establishes a connection
>> >> >>      ''server''
>> >> >>           server information
>> >> >>      ''client''
>> >> >>           client information
>> >> >>
>> >> >>      Note: This event is emitted before any authentication takes p=
lace,
>> >> >>      thus the authentication ID is not provided
>> >> >> [...]
>> >> >>
>> >> >>  -- Struct: VncServerInfo VncBasicInfo + {('auth': str)}
>> >> >>
>> >> >>      The network connection information for server
>> >> >>      ''auth'' (optional)
>> >> >>           authentication method used for the plain (non-websocket)=
 VNC
>> >> >>           server
>> >> >>
>> >> >>      Since: 2.1
>> >> >>
>> >> >>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D =
['inet':
>> >> >>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
>> >> >>           VsockSocketAddress, 'fd': String] }
>> >> >>
>> >> >>      Captures the address of a socket, which could also be a named=
 file
>> >> >>      descriptor
>> >> >>
>> >> >>      Since: 1.3
>> >> >>
>> >> >> Here's my counter-proposal: instead of inventing a formal language,
>> >> >> fix the natural language documentation to actually mention *all*
>> >> >> members, and add type information in a plain, easy-to-understand w=
ay.
>> >> >> Looks like this:
>> >> >>
>> >> >>  -- Event: VNC_CONNECTED
>> >> >>
>> >> >>      Emitted when a VNC client establishes a connection
>> >> >>
>> >> >>      Arguments:
>> >> >>      'server: VncServerInfo'
>> >> >>           server information
>> >> >>      'client: VncBasicInfo'
>> >> >>           client information
>> >> >>
>> >> >>      Note: This event is emitted before any authentication takes p=
lace,
>> >> >>      thus the authentication ID is not provided
>> >> >> [...]
>> >> >>
>> >> >>  -- Object: VncServerInfo
>> >> >>
>> >> >>      The network connection information for server
>> >> >>
>> >> >>      Members:
>> >> >>      'auth: string' (optional)
>> >> >>           authentication method used for the plain (non-websocket)=
 VNC
>> >> >>           server
>> >> >>      The members of 'VncBasicInfo'
>> >> >>
>> >> >>      Since: 2.1
>> >> >>
>> >> >>  -- Object: SocketAddress
>> >> >>
>> >> >>      Captures the address of a socket, which could also be a named=
 file
>> >> >>      descriptor
>> >> >>
>> >> >>      Members:
>> >> >>      'type'
>> >> >>           One of "inet", "unix", "vsock", "fd"
>> >> >>      'data: InetSocketAddress' when 'type' is "inet"
>> >> >>      'data: UnixSocketAddress' when 'type' is "unix"
>> >> >>      'data: VsockSocketAddress' when 'type' is "vsock"
>> >> >>      'data: String' when 'type' is "fd"
>> >> >>
>> >> >>      Since: 1.3
>> >> >>
>> >> >>
>> >> > I like both, to me they serve different purposes. I like to have a =
short
>> >> > overview / signature and then a more detailed documentation for each
>> >> field.
>> >>
>> >> I sympathize with the argument.  Unfortunately, the "short" signatures
>> >> are anything but for real-world QAPI:
>> >>
>> >
>> > That's a worse case, a regular case is more readable.
>>
>> There are readable cases, but there are plenty of cases that plainly
>> aren't.
>>
>> 102 out of 472 signatures don't count because they're empty.
>>
>> Roughly half the non-empty signatures fit on a single line.  That's shor=
t.
>>
>> A bit under a third take two lines.  I guess that's still short enough.
>>
>> More than one in six signatures is three lines or more.
>>
>> >                                                       And it is still
>> > useful anyway since the common members would be listed first.
>>
>> Whatever comes first in signatures comes first in the table of members,
>> too.  The names are easier to spot there, because they're all on the
>> left.
>>
>> Compare
>>
>>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['inet=
':
>>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
>>           VsockSocketAddress, 'fd': String] }
>>
>>      Captures the address of a socket, which could also be a named file
>>      descriptor
>>
>>      Since: 1.3
>>
>> to
>>
>>  -- Object: SocketAddress
>>
>>      Captures the address of a socket, which could also be a named file
>>      descriptor
>>
>>      Members:
>>      'type'
>>           One of "inet", "unix", "vsock", "fd"
>>      'data: InetSocketAddress' when 'type' is "inet"
>>      'data: UnixSocketAddress' when 'type' is "unix"
>>      'data: VsockSocketAddress' when 'type' is "vsock"
>>      'data: String' when 'type' is "fd"
>>
>>      Since: 1.3
>>
>> In my opinion, the three lines of signature add nothing but noise to the
>> six lines of member table.
>>
>
> It is more natural and faster to read to me for commands and events for
> example.  The verbose description is mixing description and sometime even
> providing redundant information (ex: keys: array of KeyValue,  An array of
> 'KeyValue' elements...), slowing reading even more.

Doc comments that merely restate the type should be cleaned up.

>                                                     Often you don't need =
to
> read the documentation / description, you want to quickly check the return
> type, and remind you the arguments.

Point taken.

A formal description of unbounded (and often excessive) length can't
serve that purpose, though.

A sufficiently condensed summaries just might.  Perhaps names only, no
types.  Certainly no more than a few.

For instance, having

 -- Command: block-job-set-speed device speed

instead of just

 -- Command: block-job-set-speed

feels okay; the additional two words are technically redundant, but they
might occasionally serve someone as a reminder, and they're not
distracting.

But I feel

 -- Command: blockdev-mirror [job-id] device target [replaces] sync
          [speed] [granularity] [buf-size] [on-source-error]
          [on-target-error] [filter-node-name]

is pushing it.

So this begs the question which ones to omit when there are more than a
few.  I'm afraid asking a stupid computer program to pick out
"important" arguments is asking for too much.  For high-quality
summaries, we'd have to pick ourselves.

Moreover, what to do for truly complex commands like blockdev-add?
Simply omitting all variant members is one option:

 -- Command: blockdev-add driver [node-name] [discard] [cache]
          [read-only] [detect-zeroes] ...

But what may work for blockdev-add need not work for other complex
commands.

> struct/objects are more commonly declared with a line per member, so it
> doesn't bother me as much.
>
> I would appreciate if can have the declarative form for commands and even=
ts
> at least. Other types are usually more complex or long, so that may clear
> your concerns for the long declarations.

The worst offenders are actually commands such as blockdev-add and
block_set_io_throttle, unless we give up on the "reminder" mission for
them and merely add a reference to their (named) argument type.
