Received: from eggs.gnu.org ([2001:4830:134:3::10]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpbHj-0007Z0-5n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpbHf-0004Hn-3w
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dpbHe-0004H8-UR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:26:27 -0400
Date: Wed, 6 Sep 2017 10:26:25 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <999621119.9320303.1504707985807.JavaMail.zimbra@redhat.com>
In-Reply-To: <87fuc0awfh.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-23-marcandre.lureau@redhat.com>
	<87fuc0awfh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 22/54] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>



----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Add 'ifcond' condition to QLit objects.
> >
> > to_qlit() handles the (obj, ifcond) tuples.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> I my testing, the generated code changes like this:
>=20
>     diff -rup qapi-gen-21-64300535f0/test-qmp-introspect.c
>     qapi-gen-22-050f2a5d9d/test-qmp-introspect.c
>     --- qapi-gen-21-64300535f0/test-qmp-introspect.c=092017-09-06
>     12:02:11.808681800 +0200
>     +++ qapi-gen-22-050f2a5d9d/test-qmp-introspect.c=092017-09-06
>     12:02:19.085578791 +0200
>     @@ -51,19 +51,31 @@ const QLitObject test_qmp_schema_qlit =3D
>              { "name", QLIT_QSTR("EVENT_F") },
>              {}
>          })),
>     -    QLIT_QDICT(((QLitDictEntry[]) {
>     +
>     +#if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
>     +
> --> +QLIT_QDICT(((QLitDictEntry[]) {
>              { "arg-type", QLIT_QSTR("5") },
>              { "meta-type", QLIT_QSTR("command") },
>              { "name", QLIT_QSTR("TestIfCmd") },
>=20
> Indentation's off at the line I marked.
>=20

fixed, thanks
