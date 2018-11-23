Received: from eggs.gnu.org ([2001:4830:134:3::10]:56171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gQ6AY-0007Kq-9D
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gQ6AX-0002L6-Kk
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:46:30 -0500
Date: Fri, 23 Nov 2018 08:46:14 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181123074614.GD7812@andariel.pipo.sk>
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1542912487-279165-4-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <1542912487-279165-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/5] iotests: allow
 resume_drive by node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com, den@openvz.org, mreitz@redhat.com


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 21:48:05 +0300, Andrey Shinkevich wrote:
> After node graph changes, we may not be able to resume_drive by device
> name (backing files are not recursively searched). So, lets allow to
> resume by node-name. Set constant name for breakpoints, to avoid
> introducing extra parameters.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

This patch has a mismatch between the author name and the person signing
it off.

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlv3sEYACgkQHGwCByjY
1GqwHxAAyANbPqquz7nNc/9fnBughLd0lcixmWi8V+9nxPhEXiB0tkfR1bcroiT6
Esv9JV+2XNPsIsV9AfAy/L1p8HjhLu+bseIWULLV9u8RChc56lhsXexPNiyKsYVs
Ir7C0yNt9m9X/jY2Xagggrks/7aKMYbfZ6+60HoMoOMxHCvvrPiqTxEEzmW42+sG
a02YVgjX7qCZDSMFAyW/Up6V/gaAL7caTv0JTsaEapt3C7C0KF+D3i6cNbexqtAx
4XRxc6iyswQQrqIn/wGXz26YK5n9AlfMQOcmjTfeVL3kV0HOA90ucqPkVs29hcUK
wRfeYnrZ9x46Uh1Qoflh6INvBZdWcSvI8pG5174GF9HXKrja/2p6F5KynCXPz9pS
F9+R1API3veWYGeVtHRiMGKfAEvQ7tXJANgOyEpTkqPjyk9FkVbnP4sAWpjJKPHo
2loykbBsSHxHfIiq0td3J9Nl6bSQup6RNYRWOKjHzbHdoUzaRpeAQNicOVdSL3H8
5qJ5kHLY2qbYc9O1zeXJzzVR0t1EsNH56uS+BxGvescxgXzAtE46FT5LzEo/rWcn
jsVP3sFiC+FTF6KZcsDo0NghQXrwhEsQmEp2fX6wGjFC5fKg9ME4EA+6JOW1BEdE
M4ItvEqIX70jrtjsAgI1xowMU3IjPrnhZPAk5se9VaWRbQ2Fwmw=
=9ye9
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
