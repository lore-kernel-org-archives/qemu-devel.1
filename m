Received: from eggs.gnu.org ([2001:4830:134:3::10]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2uD-0006xc-5v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2uC-0001Jn-Ar
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dn2uC-0001Ih-56
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:19:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DD767E43B
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 13:19:39 +0000 (UTC)
Date: Wed, 30 Aug 2017 09:19:39 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <243440747.6086481.1504099179043.JavaMail.zimbra@redhat.com>
In-Reply-To: <8760d5dx8f.fsf@dusky.pond.sub.org>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
	<87val5gta4.fsf@dusky.pond.sub.org>
	<844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
	<8760d5dx8f.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Hi
> >
> > ----- Original Message -----
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>=20
> >> > They are not considered constant expressions in C, producing an erro=
r
> >> > when compiling a const QLit.
> >>=20
> >> A const QLit?  Do you mean a non-const one?
> >
> > Really a const QLitObject:
> >
> >
> > const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
> >              QLIT_QNULL,
> >              {}
> >          }));
> >
> > qmp-introspect.c:17:63: error: initializer element is not constant
> >   const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
> >                                                                 ^
> > Removing the "compound literals" fixes this error.
>=20
> Does QLIT_QLIST(((const QLitObject[]) { ... } work?

No. Even if I put "const" all over the place (in member, in compound type e=
tc).

Give it a try, see if you can make it const, I am out of luck.
