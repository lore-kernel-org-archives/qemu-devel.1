Received: from eggs.gnu.org ([2001:4830:134:3::10]:39503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIXn-000352-68
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIXm-0004nm-C5
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:57:35 -0400
References: <20170527030421.28366-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d2e41ea-eb40-3f0b-627f-a30787eed53f@redhat.com>
Date: Fri, 9 Jun 2017 06:57:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170527030421.28366-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P3IDtfv1PaWXpcqpdl9wtG0vTxw0L4rvP"
Subject: Re: [Qemu-devel] [PATCH] nbd: Fully initialize client in case of
 failed negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P3IDtfv1PaWXpcqpdl9wtG0vTxw0L4rvP
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <4d2e41ea-eb40-3f0b-627f-a30787eed53f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Fully initialize client in case of
 failed negotiation
References: <20170527030421.28366-1-eblake@redhat.com>
In-Reply-To: <20170527030421.28366-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 10:04 PM, Eric Blake wrote:
> If a non-NBD client connects to qemu-nbd, we would end up with
> a SIGSEGV in nbd_cilent_put() because we were trying to
> unregister the client's association to the export, even though
> we skipped inserting the client into that list.  Easy trigger
> in two terminals:
>=20
> $ qemu-nbd -p 30001 --format=3Draw file
> $ nmap 127.0.0.1 -p 30001

Since this is now part of a CVE fix, I'm adding qemu-stable in cc.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P3IDtfv1PaWXpcqpdl9wtG0vTxw0L4rvP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOo0mAAoJEKeha0olJ0NqZo8H/1opPWwbf3RgyamG/sTXRBU0
6qBicANtgdouMiT7dn1njoQk1swcg7xmwIiKcZwibPX77k9Kw5LS3aoY/oRumGdc
mGCk+Qvp+XSb6Vj2gglygjE92CNbDztvPQfyzdC/jzAo13l+amCl8gwVD8IpWisY
L1B1IpJDOihhOcts5V7R/2PIX3vLubFuiB+mGEnEQjWxaYMH3P5nqUB9ki7Prd/v
bk2BAYWodUeANqCXvoVH8DBBJIfBHgBIbI73fXL7fFpBrF2s5apf+vnv65wxUEeU
SzAQIUCh2dzlnZI7NCZraTcYY9KZ/Iva20OvVDQFXF/5HW8iM4k6QzFRiMcDq1g=
=pTvx
-----END PGP SIGNATURE-----

--P3IDtfv1PaWXpcqpdl9wtG0vTxw0L4rvP--
