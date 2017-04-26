Received: from eggs.gnu.org ([2001:4830:134:3::10]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R2o-0000WG-2t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R2n-0007PF-6e
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:48:02 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-19-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2050075-1e87-1f1a-b02a-ac44a9176b73@redhat.com>
Date: Wed, 26 Apr 2017 12:47:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-19-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UP2rGLK51CMde76sM7Ef04tfeCDqStrko"
Subject: Re: [Qemu-devel] [PATCH v6 18/18] block: pass option prefix down to
 crypto layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UP2rGLK51CMde76sM7Ef04tfeCDqStrko
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <a2050075-1e87-1f1a-b02a-ac44a9176b73@redhat.com>
Subject: Re: [PATCH v6 18/18] block: pass option prefix down to crypto layer
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-19-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-19-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> While the crypto layer uses a fixed option name "key-secret",
> the upper block layer may have a prefix on the options. e.g.
> "luks-key-secret", "aes-key-secret", in order to avoid clashes

Another commit message that will need cleanups to match the new reality.

> between crypto option names & other block option names. To
> ensure the crypto layer can report accurate error messages,
> we must tell it what option name prefix was used.
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UP2rGLK51CMde76sM7Ef04tfeCDqStrko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAN1IAAoJEKeha0olJ0NqI1IH/Aia3ia/e9QSIjPCZfYbUQ0J
wxZGlvWc4y5RsG+6buNfVZhcyLh9hvyKNLiY7fdrFz5uDfzD8rFBctyHbjunFjPM
1wCUUbHXuYkGeiMhqXaNc5gnUdQPECJyKnQhNd2eAq5Nf7E60KpdVyvvGOeJE8Dy
u2bewr+GrnHutQyFmfnbGSPBYG9yq/r7FWDWe7r4bldGQ+C9b1yqUgEOPvWVBsY5
7OYf5vQOF2swh+CX3dSl1qWNhjveyjm9m4iCLa8ZUypuekE82yQH33VU71DNFJae
QOhqN192wALNe02bcOKLDucqmkwayFlzpkVukBLCjwSj1k5VT/JoIMRurPMZRsE=
=P4/g
-----END PGP SIGNATURE-----

--UP2rGLK51CMde76sM7Ef04tfeCDqStrko--
