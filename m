Received: from eggs.gnu.org ([2001:4830:134:3::10]:32977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9VX7-00025H-8i
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9VX3-0000Cy-Ld
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9VX3-0000Ci-CL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:25:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-10-marcandre.lureau@redhat.com>
	<87mut42c0c.fsf@dusky.pond.sub.org>
	<CAJ+F1C+WiGAd02PC=s50=kb4TT8kLmrHnYEhgyyvdGAQUbbVSw@mail.gmail.com>
Date: Mon, 08 Oct 2018 15:25:01 +0200
In-Reply-To: <CAJ+F1C+WiGAd02PC=s50=kb4TT8kLmrHnYEhgyyvdGAQUbbVSw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 2 Oct 2018
	23:04:36 +0400")
Message-ID: <87pnwk370y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/10] qga: process_event()
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
> On Thu, Aug 30, 2018 at 6:03 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Simplify the code around qmp_dispatch():
>> > - rely on qmp_dispatch/check_obj() for message checking
>> > - have a single send_response() point
>> > - constify send_response() argument
>> >
>> > It changes a couple of error messages:
>> >
>> > * When @req isn't a dictionary, from
>> >     Invalid JSON syntax
>> >   to
>> >     QMP input must be a JSON object
>> >
>> > * When @req lacks member "execute", from
>> >     this feature or command is not currently supported
>> >   to
>> >     QMP input lacks member 'execute'
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Can someone take the patch? thanks

Michael?
