Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsufS-0006NH-5W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsufR-0007W2-88
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:44:42 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2b847ce-acab-dfa8-0cbe-6f647c2d88ca@redhat.com>
Date: Fri, 15 Sep 2017 12:44:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qxc8mv9OVlC4d4v63rpeRUj36IOXqfkm3"
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-io: Reset qemuio_blk permissions
 before each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qxc8mv9OVlC4d4v63rpeRUj36IOXqfkm3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <f2b847ce-acab-dfa8-0cbe-6f647c2d88ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-io: Reset qemuio_blk permissions
 before each command
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-2-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> qemu-io provides a 'reopen' command that allows switching from writable=

> to read-only access. We need to make sure that we don't try to keep
> write permissions to a BlockBackend that becomes read-only, otherwise
> things are going to fail.
>=20
> command() already makes sure to request any additional permissions that=

> a qemu-io command requires, so just resetting the permissions to values=

> that are safe for read-only images is enough to fix this.
>=20
> As a side effect, this makes the output of qemu-iotests case 187 more
> consistent.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io.c                  | 13 +++++++++++++
>  tests/qemu-iotests/187.out |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Qxc8mv9OVlC4d4v63rpeRUj36IOXqfkm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8EX4ACgkQp6FrSiUn
Q2rZxAf9EkZPUbyy7FueIIoxJNvMEy9gRzlCCHTGoEvWEM7DrgI97ESUhs0SPHgN
4uRAIJv27bHzGB4pHmEf45lacYfblX+87q0uqfJvl38qlZuPG7pyNxJOgp1kMc2E
CdI6zf4TLuYeg0NcREkkicEezAg5jllkqYueyAZQSKHTrFaB8K2y9BKvQxjoQWVJ
AFe8qG4rjsKJQ+srR0ZOTYARIw0NUrTsmJA4zUy8OI+3UkirvRfISjDypm2qJiJT
J4J5cztae0S00VR415q5iVHAxATl1UTE9ycNrVH1xb0uWz8LySH946GOScC6kkew
SlplsB52Qf2CNSdWGz7IAGoZuj6YBA==
=gUlW
-----END PGP SIGNATURE-----

--Qxc8mv9OVlC4d4v63rpeRUj36IOXqfkm3--
