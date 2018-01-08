Received: from eggs.gnu.org ([2001:4830:134:3::10]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYfaL-0003YC-Gp
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYfaG-0007XI-T8
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:08:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYfaG-0007Wz-MU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:07:56 -0500
References: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
Date: Mon, 8 Jan 2018 16:07:53 -0600
MIME-Version: 1.0
In-Reply-To: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrlCTaKkInr4b3DYwc0FLWkVjKQvWteQ2"
Subject: Re: [Qemu-devel] how to pass pcid to guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrlCTaKkInr4b3DYwc0FLWkVjKQvWteQ2
From: Eric Blake <eblake@redhat.com>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
 qemu-devel <qemu-devel@nongnu.org>
Message-ID: <a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
Subject: Re: [Qemu-devel] how to pass pcid to guest?
References: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
In-Reply-To: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 02:03 PM, Stefan Priebe - Profihost AG wrote:
> Hello,
>=20
> for meltdown mitigation and performance it's important to have the pcid=

> flag passed down to the guest (f.e.
> https://groups.google.com/forum/m/#!topic/mechanical-sympathy/L9mHTbeQL=
NU).

Indeed; you are still waiting on the qemu patch mentioned here:
https://www.qemu.org/2018/01/04/spectre/

which is still undergoing the review process, but should be up (in the
form of 2.11.1) "in the next few days".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrlCTaKkInr4b3DYwc0FLWkVjKQvWteQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpT67oACgkQp6FrSiUn
Q2qeUAf/Yt2Xj2wDFoQUiyQWTr6o0LTYYs9TdoKGsCgso6DfrybHM/vFwptkZE08
BWY+UJDPAjDT7aRpcqIfK9OXKrXf6OwqZirZMJqrj27Eb/uo2EWAkOYGd0HNifPk
er9P3AiE2nVfRF15dL4JtgesP8+pnJKaMzC71VrNz9JU/MGe76tWlxRSVQZ2tWql
suy/n89mfWJtugoCA/dUTVBoqGK4uo6qFjHzTMiP0ammkd2zCXEZbP4iTwlZCfYw
bS1FI7SwkEmIEPFLx9znn5BMycYO5YjTo638ronDb3C8lq8zT63Vuq2amo4XEtD9
zix7QjJuaosablEEmRSro9c/VNkH5w==
=fs0V
-----END PGP SIGNATURE-----

--LrlCTaKkInr4b3DYwc0FLWkVjKQvWteQ2--
