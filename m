Received: from eggs.gnu.org ([2001:4830:134:3::10]:53746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxyU-0008J8-Rb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxyR-0004Ow-JU
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:41:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzxyR-0004NA-D0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:41:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
	<CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
Date: Thu, 05 Oct 2017 06:41:24 +0200
In-Reply-To: <CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 4 Oct 2017
	13:58:59 +0200")
Message-ID: <87sheyi4uj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> The QAPI schema parser has always accepted only single-quoted strings,
>> even though JSON strings are double-quoted.  Accept double-quoted
>> strings as well, so you can write strings containing single quotes
>> without backslash escapes.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> What's the motivation to allow both? If we were to switch from single
> to double quote only, that would make more sense.

Abandoning single quotes now would require us to touch pretty much every
line of code in the schemas.  I don't think correcting quotes is worth
wrecking git-blame.

Sadly, the schema language is neither JSON, nor an established extension
of JSON, nor Python.  This commit brings the schema language one step
closer to a superset of JSON.  I feel "homegrown superset" is a slightly
less bad idea than "homegrown with large overlap".

Naming the schema files .json was in bad taste.

> otherwise, patch looks good

Ready to upgrade to R-by now?

Want me to work more of my rationale into the commit message?
