Received: from eggs.gnu.org ([209.51.188.92]:52422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn8Eo-00053J-2N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn8En-0003fn-Ai
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:38:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gn8El-0003bY-DU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:38:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F5B1B0815
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 20:37:59 +0000 (UTC)
References: <20190125172229.23025-1-cfergeau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6a10395-fc93-cb19-6bfa-5ddc48e50ec7@redhat.com>
Date: Fri, 25 Jan 2019 14:37:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190125172229.23025-1-cfergeau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WGdA82qvVB6eEQKg2mzDIcntXmdDhNNtl"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] qemu-io: Use error_[gs]et_progname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WGdA82qvVB6eEQKg2mzDIcntXmdDhNNtl
From: Eric Blake <eblake@redhat.com>
To: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f6a10395-fc93-cb19-6bfa-5ddc48e50ec7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] qemu-io: Use error_[gs]et_progname()
References: <20190125172229.23025-1-cfergeau@redhat.com>
In-Reply-To: <20190125172229.23025-1-cfergeau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/25/19 11:22 AM, Christophe Fergeau wrote:

Don't forget the 0/2 cover letter for series :)

> qemu-io reimplements itself what
> error_get_progname()/error_set_progname() already does.
> This commit switches it to use this API from qemu-error.h
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  qemu-io.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--WGdA82qvVB6eEQKg2mzDIcntXmdDhNNtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxLc6MACgkQp6FrSiUn
Q2obWgf9Fh7YLDpU1U34MF3ucMsIanvuWp9YKqH7/Qzi9xes82wXW+r9jIXEeZ1D
jh1GSbXJil+cp+N2ZAcZo6hLH+Td+HNCkOZOeVnMXUU4AWTE0dD60cCAcITzeNP1
+EmZKhUp4W6i6Ddliy77uJrevYm2Hw0Ina+jlBw6N0wHCvvQaMaqVnBt6d7MGIkb
GvXCU5KR84ea+lfEJN1s9x+/C3C1iuH68kSBIyniYg0wdTw1WkIuvUBCpJzyrflE
hfbl7cEy9qtZym6yZ6vZqXOK1SnF+0TzQP5cnNa0FuRXArzTZE6uCoZ05DBo5W7m
gvCHv/cA3h8PxWGNGAXUIMid+RDwuA==
=kfgE
-----END PGP SIGNATURE-----

--WGdA82qvVB6eEQKg2mzDIcntXmdDhNNtl--
