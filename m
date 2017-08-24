Received: from eggs.gnu.org ([2001:4830:134:3::10]:50553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkw6m-000611-85
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkw6k-0005Mf-8v
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:39:55 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37ba0eb3-3bb0-65dd-8bf3-c5d55be66240@redhat.com>
Date: Thu, 24 Aug 2017 12:39:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170824153345.2244-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="keD5vCcMXtEEf5LctI2N1mv5bj2mLQSDa"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: improve
 nbd-fault-injector.py startup protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--keD5vCcMXtEEf5LctI2N1mv5bj2mLQSDa
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37ba0eb3-3bb0-65dd-8bf3-c5d55be66240@redhat.com>
Subject: Re: [PATCH 2/3] qemu-iotests: improve nbd-fault-injector.py startup
 protocol
References: <20170824153345.2244-1-stefanha@redhat.com>
 <20170824153345.2244-3-stefanha@redhat.com>
In-Reply-To: <20170824153345.2244-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
> Currently 083 waits for the nbd-fault-injector.py server to start up by=

> looping until netstat shows the TCP listen socket.
>=20
> The startup protocol can be simplified by passing a 0 port number to
> nbd-fault-injector.py.  The kernel will allocate a port in bind(2) and
> the final port number can be printed by nbd-fault-injector.py.
>=20
> This should make it slightly nicer and less TCP-specific to wait for
> server startup.  This patch changes nbd-fault-injector.py, the next one=

> will rewrite server startup in 083.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/nbd-fault-injector.py | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--keD5vCcMXtEEf5LctI2N1mv5bj2mLQSDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfD18ACgkQp6FrSiUn
Q2rALgf/XR6C8pVek64qHIGZByhYXI+F00hfcSpcUj9bmtXyJQrluSK42cPCcpQ3
Uw1eivj0AorZTvI3V/1ifla0f8a2GRGMsjNgzUyZqlU1A6kN+mvMpKS+c0CngJwV
og+6WYWiHHk91tUt8JHe8rAhQe3z3sJ88WHEb7SCFJ2hUVhno/NEc/xzxYMU/UAe
+k+idqC4zBBelLhIdKkfxd/l9h4S0Vxx92JLeMClG4J5v23vuG9sTj8W+Myo1mvz
htpIJorcTYubNohLvryDUzANLW8AKSLq97l+X/oMDTfGQwp1LRsDoAlIv4BDNUTo
h2R2EbhOqu+6+mUTVoeFBzGXztL5+Q==
=kwSJ
-----END PGP SIGNATURE-----

--keD5vCcMXtEEf5LctI2N1mv5bj2mLQSDa--
