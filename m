Received: from eggs.gnu.org ([2001:4830:134:3::10]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOURM-0003hC-6Y
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOURL-0002yG-BG
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:08:08 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebc5de5c-bb52-1fb5-510f-1561abf211a2@redhat.com>
Date: Tue, 3 Jan 2017 13:08:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qBaDxGBEUSF0flVJ4IDUhsOH17PDkAE3r"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] iotests: reduce PBKDF iterations
 when testing LUKS
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
--qBaDxGBEUSF0flVJ4IDUhsOH17PDkAE3r
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <ebc5de5c-bb52-1fb5-510f-1561abf211a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] iotests: reduce PBKDF iterations when
 testing LUKS
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-4-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> By default the PBKDF algorithm used with LUKS is tuned
> based on the number of iterations to produce 1 second
> of running time. This makes running the I/O test with
> the LUKS format orders of magnitude slower than with
> qcow2/raw formats.
>=20
> When creating LUKS images, set the iteration time to
> a 10ms to reduce the time overhead for LUKS, since
> security does not matter in I/O tests.
>=20
> Previsouly a full 'check -luks' would take

s/Previsouly/Previously/

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qBaDxGBEUSF0flVJ4IDUhsOH17PDkAE3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/aQAAoJEKeha0olJ0Nq0DIH/0h2nD4II7gyhqxi4bEfws/n
C/nCaTudG6+Lv73KvjJir70VDcdlrijHuSWqE2QmXtWykXSjwbcYFWLbx9+lKUE0
EGDI4nnW2Y/0ZITqDuzKUVCMx/qfKf0E14Ae2d63QFxctjvNJ814+XpqELpJQt71
mT/Oep1C5PxQo/cj7zm4DvQnfW9wU8yQyqc8B5wHiTZWsyjku4/7kOv6lHEMIz87
g+DHtY59pz31b743U2ipmTxut/D4Jicnt4HNjz9Th3zP6oyE4BMNTsLRJOGtoN8+
b2F+OFZ6kQxOkNUEkh/qT1593QfSPeP4GoARumowlZrleJUaVaozZSMjrfn0r5E=
=fWar
-----END PGP SIGNATURE-----

--qBaDxGBEUSF0flVJ4IDUhsOH17PDkAE3r--
