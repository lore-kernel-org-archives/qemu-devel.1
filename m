Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSY1-00082A-Mm
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSY0-00053C-Os
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:06:53 -0500
References: <20170103170010.25905-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <493424e7-49ab-d2e6-9843-6616e235b65c@redhat.com>
Date: Tue, 3 Jan 2017 11:06:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170010.25905-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qDLKu6RH94aQnJwrcx57iRTGT7bjQq8m9"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: add support for --object with
 'dd' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qDLKu6RH94aQnJwrcx57iRTGT7bjQq8m9
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <493424e7-49ab-d2e6-9843-6616e235b65c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: add support for --object with 'dd'
 command
References: <20170103170010.25905-1-berrange@redhat.com>
In-Reply-To: <20170103170010.25905-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:00 AM, Daniel P. Berrange wrote:
> The qemu-img dd command added --image-opts support, but missed
> the corresponding --object support. This prevented passing
> secrets (eg auth passwords) needed by certain disk images.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qDLKu6RH94aQnJwrcx57iRTGT7bjQq8m9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa9olAAoJEKeha0olJ0Nqe38H/i9ZavymbUcRHrqRv7CFiP6S
EZnrZ4nysWC1qYK5yl0uRQklMcB5tkU3+vidjBN6bWioI1ZWSgMINpXXpPQvtfqt
X22fzT3gjmGez121q2vNoh382udcM03bPmvW2CD6Rq6hWumZ0r/xskX5MZdCCwXz
e+DzoZzkCe30yw+LqGfGCFesNH7i0/p25y5sspN2k+E31VnEn+gE1Ps0Xv2ObKDZ
unsj64sHjK0vq1jPpx0eaygQ0P7gTYgNS90x1G3Bkn/4Br74wAk0e99FozYsDwsR
ACX4fhptQ+OEbuyfZeTZsaT7u2VcBcBJ+Sh8J1rhqOL/mEw3BXCD9jGYklObMYg=
=ndve
-----END PGP SIGNATURE-----

--qDLKu6RH94aQnJwrcx57iRTGT7bjQq8m9--
