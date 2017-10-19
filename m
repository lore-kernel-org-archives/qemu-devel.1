Received: from eggs.gnu.org ([2001:4830:134:3::10]:54682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5DXW-0003ik-VJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5DXS-0000TU-Mt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5DXS-0000S4-Dk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63E4D4E4D1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 16:19:17 +0000 (UTC)
References: <20171018140620.25790-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a60a456f-7056-d35c-e8fc-57309dcc9f11@redhat.com>
Date: Thu, 19 Oct 2017 11:19:15 -0500
MIME-Version: 1.0
In-Reply-To: <20171018140620.25790-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G0Jls4lgTQdwgwWLb7oWg3TIJVgVaIxDJ"
Subject: Re: [Qemu-devel] [PATCH v2] io: introduce a network socket listener
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0Jls4lgTQdwgwWLb7oWg3TIJVgVaIxDJ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a60a456f-7056-d35c-e8fc-57309dcc9f11@redhat.com>
Subject: Re: [PATCH v2] io: introduce a network socket listener API
References: <20171018140620.25790-1-berrange@redhat.com>
In-Reply-To: <20171018140620.25790-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 09:06 AM, Daniel P. Berrange wrote:
> The existing QIOChannelSocket class provides the ability to
> listen on a single socket at a time. This patch introduces
> a QIONetListener class that provides a higher level API
> concept around listening for network services, allowing
> for listening on multiple sockets.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +/**
> + * qio_net_listener_add:
> + * @listener: the network listener object
> + * @sioc: the socket I/O channel
> + *
> + * Associate a listening socket I/O channel with the
> + * listener. The listener will acquire an new reference

s/an new/a new/


> +/**
> + * qio_net_listener_is_connected:
> + * @listener: the network listener object
> + *
> + * Determine if the listener is connected to any socket
> + * channels
> + *
> + * Returns: TRUE if connected, FALSE otherwise
> + */
> +bool qio_net_listener_is_connected(QIONetListener *listener);

s/TRUE/true/, s/FALSE/false/

With those typo fixes,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G0Jls4lgTQdwgwWLb7oWg3TIJVgVaIxDJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlno0IMACgkQp6FrSiUn
Q2r6OQf/f+khoWFQen9i0Dj7cP6yEmhM+QgacTQrIoRzXz5nlLo+dZUaS6jL12y8
bz+PIlWpzehrp8ULXEKbgQmEZMAEThoKDAkJKBED0Seav6PMfB6zWkQbA+LAMZT+
ug/FhRxRm+i9JvXGBECFOd5y0AouQa1vY53uNLkB9ObHH/P8qKbFSqKeVkg2HN7N
FUETj2gMjP/c4JR4/EqtOhQyPrXmwvGT49FcuPa9sLjM2QnKMrd5rx+UCJY6xUh8
N2jAcQk9Z8kayEt5YeBZnqMoz5+68+uRpHo2LbY+ZsH7y06AKyQXOFFV5jbrqP/T
B6FG5I3YmvLr4ohEdUvy20tuy6eudQ==
=vxvP
-----END PGP SIGNATURE-----

--G0Jls4lgTQdwgwWLb7oWg3TIJVgVaIxDJ--
