Received: from eggs.gnu.org ([2001:4830:134:3::10]:52624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddIBl-00074q-3F
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddIBk-00063R-8y
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:37:29 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21a14ce0-7c6a-6527-807c-d31555921d59@redhat.com>
Date: Thu, 3 Aug 2017 10:37:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LvoBTLNjD089bApLgtRr26WUaJ9eKCulM"
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/5] qemu-io: Allow reopen
 read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LvoBTLNjD089bApLgtRr26WUaJ9eKCulM
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <21a14ce0-7c6a-6527-807c-d31555921d59@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/5] qemu-io: Allow reopen
 read-write
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-5-kwolf@redhat.com>
In-Reply-To: <20170803150301.10177-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:03 AM, Kevin Wolf wrote:
> This allows qemu-iotests to test the switch between read-only and
> read-write mode for block devices.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io-cmds.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LvoBTLNjD089bApLgtRr26WUaJ9eKCulM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDQy8ACgkQp6FrSiUn
Q2qpKQgAiVZfz36cvG8oKEaYCZMwk8VrqOXJPM49yAIU40O78E4UiYgNX9tdBx4q
mbqw0WYL0njPVKgBcSwX8T1cxQWx+krYp0mLD7AvpDRu40HCl5L9AMj38LOsi5Xa
0M9SeiqpQu3W50dxxcFGVWpyFROL2CkXB/I2dAe/2ePn+8p2HXQtdq8rArB8O7TD
k0JzVQShBiBV9sIIhv066hBMCnJGmy9YdM2NLstGd8YWGhGdA6Xo65j1B/M2BTg2
uc2cTflvesJ0m0sPZabPvREFSxVpYcM/E+nMVSfQgz2UTJoZPRw3XDuSD+8kCHCI
ue8Y8PAa6AniFAY2K9aD1/aMqwinAg==
=G11S
-----END PGP SIGNATURE-----

--LvoBTLNjD089bApLgtRr26WUaJ9eKCulM--
