Received: from eggs.gnu.org ([2001:4830:134:3::10]:50794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxhf-0004x9-IX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxhc-0006Ow-EW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzxhc-0006OX-7x
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:24:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-15-armbru@redhat.com>
	<CAJ+F1C+gsgG+Nbmj56DACRCAdWk==Ud=CCtfppc-jy4L41QoMw@mail.gmail.com>
Date: Thu, 05 Oct 2017 06:24:01 +0200
In-Reply-To: <CAJ+F1C+gsgG+Nbmj56DACRCAdWk==Ud=CCtfppc-jy4L41QoMw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 4 Oct 2017
	13:52:43 +0200")
Message-ID: <87376yjk7y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 14/32] qapi: Rework generated code for
 built-in types
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

> Hi
>
> On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> qapi-types.py and qapi-visit.py generate some C code for built-in
>> types.  To make this work with multiple schemas, we generate code for
>> built-ins into .c files only when the user asks for it with -b.  The
>> user is responsible for linking exactly one set of files generated
>> with -b per program.  We generate code for built-ins into .h
>> regardless of -b, but guard it with a preprocessor symbol.
>>
>> This is cumbersome and inflexible.  Move the code generated for
>> built-in types into separate files builtin-qapi-{types,visit}.{c,h}.
>> Run qapi-types.py and qapi-visit.py without a schema argument to
>> generate them.  Drop their option -b.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> Good idea!
> I think I would still prefer to see a seperate argument to generate
> builtin files (rather than absence of schema), but this is minor
> detail.

An option to generate built-ins would have to conflict with -p and the
positional argument.  I tried the stupidest solution that could possibly
work first.

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
