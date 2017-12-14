Received: from eggs.gnu.org ([2001:4830:134:3::10]:51922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUnQ-00007q-10
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUnP-0001kL-BR
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:47:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePUnP-0001is-4z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:47:35 -0500
Date: Thu, 14 Dec 2017 14:47:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214144712.GO14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-27-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UOYwgDhKKQYesrzQ"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-27-peterx@redhat.com>
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


--UOYwgDhKKQYesrzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 01:52:00PM +0800, Peter Xu wrote:
> +    /* Try a fake capability, it should fail. */
> +    resp = qmp("{ 'execute': 'qmp_capabilities', "
> +               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }");
> +    g_assert(qdict_haskey(resp, "error"));

Missing QDECREF(resp) here and throughout the rest of the function.

Besides that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UOYwgDhKKQYesrzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMo7wAAoJEJykq7OBq3PIsm4IAIBUAkrQ8DGLDNgOIeVUInoh
KH1bBKNzurfEHT8Kke7hRNfnBx8A3/Bb+jvImfX2xBCmpCklj4PzxWaUwFWTh86m
3MGMG1QLZnoaN7zc/TyNroLvMz6L+CJXomWThxxnf60MPvQL18eoEyx2LZRzHNhD
Mygv4xzNrH0V6EF3ycmrA8IbGlhsTG+RhJI2GNVeUSXkqub+ALNrGVNE6ngTAYL0
M1G7oOlhFwYGUQV2SHueq1rTHNkOmB+LtAx1V1nrIIReIof6OYoMHmitQ1ZoxRj9
r0W6n2kIyECFuh+F57YgwyWefce/HWlarf7jhKiKcAbq/SEMaa/tExv/K9DZiXQ=
=ehsb
-----END PGP SIGNATURE-----

--UOYwgDhKKQYesrzQ--
