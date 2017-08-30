Received: from eggs.gnu.org ([2001:4830:134:3::10]:44390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn2eA-0007K4-Ry
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn2e5-00023b-AC
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dn2e5-00022V-21
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12557356D0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 13:03:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
	<87val5gta4.fsf@dusky.pond.sub.org>
	<844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
Date: Wed, 30 Aug 2017 15:02:56 +0200
In-Reply-To: <844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 30 Aug 2017
	08:11:51 -0400 (EDT)")
Message-ID: <8760d5dx8f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/14] qlit: remove compound literals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > They are not considered constant expressions in C, producing an error
>> > when compiling a const QLit.
>>=20
>> A const QLit?  Do you mean a non-const one?
>
> Really a const QLitObject:
>
>
> const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>              QLIT_QNULL,
>              {}
>          }));
>
> qmp-introspect.c:17:63: error: initializer element is not constant
>   const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>                                                                 ^
> Removing the "compound literals" fixes this error.

Does QLIT_QLIST(((const QLitObject[]) { ... } work?

> We may want to include it in the commit message, but I think it lacks a b=
it of "C standard" explanation. I think it is something like "compound lite=
rals" are not const. But then why does it work with (QLitObject[]) ? :)
