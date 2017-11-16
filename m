Received: from eggs.gnu.org ([2001:4830:134:3::10]:54113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFBHS-0001Km-7M
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFBHO-0000WH-BM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:55:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eFBHO-0000Vg-1w
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:55:54 -0500
References: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e211649-ccf6-efd9-cabd-a346af7e501d@redhat.com>
Date: Wed, 15 Nov 2017 21:55:50 -0600
MIME-Version: 1.0
In-Reply-To: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9XGfd2diVSEBWdUpU7HfEMsLkCaQJWuGR"
Subject: Re: [Qemu-devel] [PATCH v3] net: Transmit zero UDP checksum as
 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Jason Wang <jasowang@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9XGfd2diVSEBWdUpU7HfEMsLkCaQJWuGR
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>, Jason Wang <jasowang@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org
Message-ID: <5e211649-ccf6-efd9-cabd-a346af7e501d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] net: Transmit zero UDP checksum as 0xFFFF
References: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 09:07 PM, Ed Swierk via Qemu-devel wrote:

[meta-comment]

> The checksum algorithm used by IPv4, TCP and UDP allows a zero value
> to be represented by either 0x0000 and 0xFFFF. But per RFC 768, a zero
> UDP checksum must be transmitted as 0xFFFF, as 0x0000 is a special
> value meaning no checksum.
>=20
> Substitute 0xFFFF whenever a checksum is computed as zero when
> modifying a UDP datagram header. Doing this on IPv4 packets and TCP
> segments is unnecessary but legal. Add a wrapper for
> net_checksum_finish() that makes the substitution.
>=20
> (We can't just change net_checksum_finish(), as that function is also
> used by receivers to verify checksums, and in that case the expected
> value is always 0x0000.)

This part below...

>=20
> v3:
>=20
> Leave net_tx_pkt_update_ip_checksums() alone since it's only computing
> a partial sum of the IP pseudo-header.
>=20
> Rename wrapper to net_checksum_finish_nozero() for clarity.
>=20
> v2:
>=20
> Add a wrapper net_checksum_finish_hdr() rather than duplicating the
> logic at every caller.

=2E..through here, belongs...

>=20
> Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
> ---

=2E..here, after the --- separator (you can have more than one ---; 'git
am' stops parsing at the first).  It is data that is useful to
reviewers, but will be meaningless a year from now when browsing git
history (at which point we won't care how many revisions the patch went
through on the list, but only what was checked in).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9XGfd2diVSEBWdUpU7HfEMsLkCaQJWuGR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloNDEYACgkQp6FrSiUn
Q2pj8gf6AlHIbuj/gxnr6CeNe7IK644t2zNRKLnaYLC66XnK/IOGzqveSLLkmPgm
DudNsa6RnuekToxl06BaQsMf7KhgK0kOGDUXb7Oa/TJWDX0e5B0apIqe2M0tChx+
v9ytPNh+k5r7o35BuGXFsslHeQZBjJqB+zn+JJ2GH2IM8Beg0BUEdxE5NJ/qZOmm
xLnpqYGK1CkK94zTFD4dSDczhpGDrXEz8NzMeqkOGWDqIws58N0WAgQ0VIkIHAjD
TN/3FUWenz9vIDuck1Pwq9XREjNMzfRSf0SYFfg5zTt27YbY7ITfWurVe9/vcH0D
yYLux/o3VPYe0keS9tn26hKEhPQwUA==
=PN2x
-----END PGP SIGNATURE-----

--9XGfd2diVSEBWdUpU7HfEMsLkCaQJWuGR--
