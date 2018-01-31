Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtxl-0007gC-WC
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtxh-00018E-Tn
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:06:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egtxh-00017P-Me
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:06:09 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d978583-1846-aced-b281-9227cfc5fe8e@redhat.com>
Date: Wed, 31 Jan 2018 09:06:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8oE5obcQ3QGB2mbST41Pr0ox7jIa4Awbl"
Subject: Re: [Qemu-devel] [PATCH v2 02/19] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8oE5obcQ3QGB2mbST41Pr0ox7jIa4Awbl
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org
Message-ID: <0d978583-1846-aced-b281-9227cfc5fe8e@redhat.com>
Subject: Re: [PATCH v2 02/19] Clean up includes
References: <20180131144846.31697-1-armbru@redhat.com>
 <20180131144846.31697-3-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 08:48 AM, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
>=20
> This commit was created with scripts/clean-includes, with the change
> to target/s390x/gen-features.c manually reverted, and blank lines
> around deletions collapsed.

Is it worth tweaking scripts/clean-includes to add gen-features.c to the
whitelist of special cases (alongside *.inc.c, perhaps)?

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8oE5obcQ3QGB2mbST41Pr0ox7jIa4Awbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx21kACgkQp6FrSiUn
Q2pTYQgAkYM5gnddhDTmMlV7beZPrGaT4ZSWZDWI3kN4QBlDP2rR9Xyhpu6wyeih
P95PG2zDQbqgTRMKLlPz2WyAGvXSHVByMy16Kp/NznVrpcA9yyIMwf4dHBm20lU5
nWuOBTEtFITerus3+uh8nkEGFIBwURe/SIQFX68yU4XwXcLBP916yIOd5HJFVi5F
R0VNX6tf5/cJuMeUXPed5Rn3DAvjbAhOfiHElrr7yOxgGnRM+ONCYtPLcZOHOdu3
UX/grB9dLXPL3AUem5IkOTt8Bkw3fO81okoxPJwEg16vN5OQVce2upAld8qemfj8
yqX4/wHwyq/D6jRCRKU8lgczxU9vOQ==
=MjwF
-----END PGP SIGNATURE-----

--8oE5obcQ3QGB2mbST41Pr0ox7jIa4Awbl--
