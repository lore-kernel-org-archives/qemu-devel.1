Received: from eggs.gnu.org ([209.51.188.92]:55890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Cql-0000dD-P5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Cql-0006hy-0H
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:35:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h2Cqk-0006hk-Of
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:35:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00B60C07013D
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 10:35:34 +0000 (UTC)
Date: Fri, 8 Mar 2019 10:35:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190308103532.GF12318@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20190222153254.22739-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 03:32:54PM +0000, Stefan Hajnoczi wrote:
> QMP clients can usually detect the presence of features via schema
> introspection.  There are rare features that do not involve schema
> changes and are therefore impossible to detect with schema
> introspection.
>=20
> This patch adds the query-qemu-capabilities command.  It returns a list
> of capabilities that this QEMU supports.
>=20
> The decision to make this a command rather than something statically
> defined in the schema is intentional.  It allows QEMU to decide which
> capabilities are available at runtime, if necessary.
>=20
> This new interface is necessary so that QMP clients can discover that
> migrating disk image files is safe with cache.direct=3Doff on Linux.
> There is no other way to detect whether or not QEMU supports this.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qmp.c          | 18 ++++++++++++++++++
>  2 files changed, 60 insertions(+)

Markus: query-qemu-features is no longer needed by the page cache
invalidation feature since a related QMP schema change is being made now
and clients can detect the feature via that change.

I'm inclined to leave this patch series for now.  Later someone can pick
it up again if there is a feature that cannot be detected via a schema
change.

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgkV0AAoJEJykq7OBq3PIRsgIAJyj2wzx/7np1Qie3kHFBinU
b28OfB2qaQkEhLds2uBa0qpMubnhy7YiC+TkE+Nkf2GpsBvOJcosyjK90Ly6T1Tw
XNH7kLjuJFQxyKeQguSjFhCgII+/i4836KwhepBde7Av64Xi/wcQRA2CEqkNPv9L
abKC/sylBXO50dZJfyqcqjFPw0x6aRt6qk/y8tIakJcpXV0aZinAYCD4XWPAT0zQ
Teae+X1Ta7GoWHxJr/kuT7ok7JgVG0PF3cqL584l1yTdaryBgMzrGZmjwUA+hNpA
y72skCzg9CB/PvtldQN9ACEXFQ463jfLLzuIekOH3O/xc66eBU1W/IFvvH46/qY=
=6R8S
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
