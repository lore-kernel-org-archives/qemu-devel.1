Received: from eggs.gnu.org ([2001:4830:134:3::10]:52017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxn8-0005qq-E0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzxn5-0002SD-A9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzxn5-0002RH-3w
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:29:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-16-armbru@redhat.com>
	<CAJ+F1CKSuJ2Zk6B4baESAdmM6RNeGFszJ1H41ZWxg+dXEcW7zQ@mail.gmail.com>
Date: Thu, 05 Oct 2017 06:29:39 +0200
In-Reply-To: <CAJ+F1CKSuJ2Zk6B4baESAdmM6RNeGFszJ1H41ZWxg+dXEcW7zQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 4 Oct 2017
	14:02:54 +0200")
Message-ID: <87wp4ai5e4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/32] tests/qapi-schema: Improve
 simple union coverage
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
>> This demonstrates a bug in the lowering of simple unions: if more than
>> one schema uses the same built-in type T for a simple union member,
>> they all generate the same q_obj_T_wrapper into their qapi-types.h.
>> They clash when you include more than one schema's qapi-types.h.
>
> Ah, I don't remember seeing that when I splitted the schema in my
> qapi-if / conditional series.

Simple union members of built-in type are rare.  I spotted the problem
with options, then realized it's already possible with simple unions.

> Could it happen with non-built-in types ?

Yes, but multiple q_obj_T_wrapper can clash only when their T also
clash.  Name your types more wisely then.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
