Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxLN-0004gn-HC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxLI-0008NZ-Ex
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:27:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cpxLI-0008NI-7s
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:27:24 -0400
Date: Mon, 20 Mar 2017 09:27:20 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1268717042.9839783.1490016440609.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490015515-25851-5-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-5-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/6] tests/qapi-schema: Make
 test-qapi.py print docs again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, mdroth@linux.vnet.ibm.com



----- Original Message -----
> test-qapi.py used to print the internal representation of doc comments
> (commit 3313b61).  This went away when we dropped the doc comments in
> positive tests (commit 87c16dc).  Bring it back, because I'm going to
> add real positive doc comment tests.

Yup, as I pointed out in the previous series, but since you biring it back =
modified:


>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qapi-schema/test-qapi.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index ef74e2c..c7724d3 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -55,3 +55,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
> =20
>  schema =3D QAPISchema(sys.argv[1])
>  schema.visit(QAPISchemaTestVisitor())
> +
> +for doc in schema.docs:
> +    if doc.symbol:
> +        print 'doc symbol=3D%s' % doc.symbol
> +    else:
> +        print 'doc freeform'
> +    print '    body=3D\n%s' % doc.body
> +    for arg, section in doc.args.iteritems():
> +        print '    arg=3D%s\n%s' % (arg, section)
> +    for section in doc.sections:
> +        print '    section=3D%s\n%s' % (section.name, section)
> --
> 2.7.4
>=20
>=20
