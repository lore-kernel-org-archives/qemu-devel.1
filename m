Received: from eggs.gnu.org ([2001:4830:134:3::10]:54534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvyW-0004p1-Ub
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvy4-0002XC-WD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:01:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQvy3-0002VR-Qi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:00:32 -0500
Date: Mon, 18 Dec 2017 13:59:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218135954.GG16653@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-27-peterx@redhat.com>
	<20171214144712.GO14433@stefanha-x1.localdomain>
	<20171218095145.GS22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20171218095145.GS22308@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 26/26] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 05:51:45PM +0800, Peter Xu wrote:
> On Thu, Dec 14, 2017 at 02:47:12PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:52:00PM +0800, Peter Xu wrote:
> > > +    /* Try a fake capability, it should fail. */
> > > +    resp =3D qmp("{ 'execute': 'qmp_capabilities', "
> > > +               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] =
} }");
> > > +    g_assert(qdict_haskey(resp, "error"));
> >=20
> > Missing QDECREF(resp) here and throughout the rest of the function.
>=20
> I believe I missed four QDECREF()s.

Yes.

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8naAAoJEJykq7OBq3PIeQUH/0Kp3QwGWCBpgQrr7btOh/P2
jL9NvFa2xkSoD6qfn4Um7KrlBub7P1kJY40OCTlwk/V4A2cicQKvDBslzlWkUuN4
58dJLd+c0LOpULFCReQbYbO9KUl2jzxA3D/TeCVZIEtRZRx0vHcXph41fsWojN7g
hwkDySj3O//0ZPtMBy97tfrXBI2rXRY9IsGZD+9ftDnK+1EdjT91xmfiCKivrLbN
YUjXLjeXP1sw8D4tOT1+LiaVjr78uUZCBDARLGdh835+Gi3Z/Dnp15amljW9daqA
XiuEXxrzYhttUPsfyMvbO26tWK+YRfe0p7zYgfBOYu5uPpZKYNgR52T02IMqX0Y=
=U9og
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
