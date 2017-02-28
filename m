Received: from eggs.gnu.org ([2001:4830:134:3::10]:38181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimiL-0000LC-ST
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimiI-0002dt-Px
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:41:33 -0500
References: <1488303601-23741-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01709a2f-9230-8c1e-ca6f-396f9ecc4e10@redhat.com>
Date: Tue, 28 Feb 2017 12:41:27 -0600
MIME-Version: 1.0
In-Reply-To: <1488303601-23741-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dGrebtlFex2ntpdv3GvNGIt2iAxrLAO5I"
Subject: Re: [Qemu-devel] [PATCH] docs: Add a note about mixing bootindex
 with "-boot order"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laszlo Ersek <lersek@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dGrebtlFex2ntpdv3GvNGIt2iAxrLAO5I
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Laszlo Ersek <lersek@redhat.com>
Message-ID: <01709a2f-9230-8c1e-ca6f-396f9ecc4e10@redhat.com>
Subject: Re: [PATCH] docs: Add a note about mixing bootindex with "-boot
 order"
References: <1488303601-23741-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1488303601-23741-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 11:40 AM, Thomas Huth wrote:
> Occasionally the users try to mix the bootindex properties with the
> "-boot order" parameter - and this likely does not give the expected
> results. So let's add a proper statement that these two concepts
> should not be used together.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/bootindex.txt | 9 +++++++++
>  qemu-options.hx    | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dGrebtlFex2ntpdv3GvNGIt2iAxrLAO5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtcRXAAoJEKeha0olJ0NqyAEH/jyj2I4DJdTDXAmiMBbtjp66
ZyDnffpRRORSEl70dq6CymE5h5eLr76rnyiFxJeeSG9p+fAO3Yc701rU5LPI2BmR
Vs1KJuGS+kwoVyijORTi5l8ofjRyOd+fdyeMZaOGswGcMQz21VZ/eLh2+bcdqnDD
evqBWYq66rRClPmAcREi2UJ4cPfOVUEAJtHQjXdwAw/ZIsbpUrqV6Q2kthDs51O2
k41x+Lbwih4c9gx3+WZRF8Is1+d7UOwHllEkGplvoIzaJO1d4pXurRkVBxyBDO3C
B1LXY5tCEXCI2ZjXP3edE/XVflwishRHBqabFNou42xr8dWQQCxcqQyEVMsowBw=
=A2+E
-----END PGP SIGNATURE-----

--dGrebtlFex2ntpdv3GvNGIt2iAxrLAO5I--
