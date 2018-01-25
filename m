Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eej2s-00088k-SL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eej2k-0008Rv-6N
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:02:30 -0500
References: <20180125144557.25502-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e869061-a9ab-80ef-8257-1c683f386aef@redhat.com>
Date: Thu, 25 Jan 2018 09:01:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180125144557.25502-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6K4QxO7GYg8DKmOpbKmaN3S4fUSG5HCst"
Subject: Re: [Qemu-devel] [PATCH] hmp: Add nbd_server_remove to mirror QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, dgilbert@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6K4QxO7GYg8DKmOpbKmaN3S4fUSG5HCst
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, dgilbert@redhat.com, qemu-block@nongnu.org
Message-ID: <9e869061-a9ab-80ef-8257-1c683f386aef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: Add nbd_server_remove to mirror QMP
 command
References: <20180125144557.25502-1-eblake@redhat.com>
In-Reply-To: <20180125144557.25502-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 08:45 AM, Eric Blake wrote:
> Since everything else about the nbd-server-* QMP commands is
> accessible from HMP, we might as well make removing an export
> available as well.  For now, I went with a bool flag rather
> than a mode string for choosing between safe (default) and
> hard modes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Based-on: <20180119135719.24745-1-vsementsov@virtuozzo.com>
> ([PATCH v3 0/5] nbd export qmp interface)

Since that series is on my NBD queue, I'm happy to take this one through
the NBD queue as well rather than the HMP queue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6K4QxO7GYg8DKmOpbKmaN3S4fUSG5HCst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpp8V0ACgkQp6FrSiUn
Q2qEIwgAg1mtIJoEls63rOEeuPiSBzjPr0b7I501+LUlQ5FjSaXOiM+URDLutJow
cgCqFYukSOG0yvK6I0TGuI3NjNCp1Qg51KatcO0olA55TE8stEHoT76ke6HOYRY/
/ArmkA3ZOqYZKG1BRGeoxzXrvJzRCU3KAvHXXqBnWoekq6DA6ZNXYsvvG9l7CFlP
FnpDY/r+IjcWrcm2QZvWM2lZN1UXPl8dqP+7vTfrJ+A9IRQ139ZjI2JMiBGJsA8S
aS3DjFhsM2vvU0MM0xBcz3sWOGCI7A1J4ohyYe1t+qNPKXViXJAl6EmjqEZoHuYk
hoyWQ/9ImG8+Oa2BDf2xZi4nTWZRbQ==
=dPrg
-----END PGP SIGNATURE-----

--6K4QxO7GYg8DKmOpbKmaN3S4fUSG5HCst--
