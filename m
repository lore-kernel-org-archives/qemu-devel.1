Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIYu-00046C-T7
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIYu-0005P4-0a
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:58:44 -0400
References: <20170608222617.20376-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3629211-acc4-38e2-43b7-6a2d052d2aed@redhat.com>
Date: Fri, 9 Jun 2017 06:58:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JHvxJevk8ilAfBEUhEqrKK7mlgvFjOXfO"
Subject: Re: [Qemu-devel] [PATCH] nbd: Fix regression on resiliency to port
 scan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JHvxJevk8ilAfBEUhEqrKK7mlgvFjOXfO
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <f3629211-acc4-38e2-43b7-6a2d052d2aed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Fix regression on resiliency to port
 scan
References: <20170608222617.20376-1-eblake@redhat.com>
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

adding qemu-stable in cc

On 06/08/2017 05:26 PM, Eric Blake wrote:
> Back in qemu 2.5, qemu-nbd was immune to port probes (a transient
> server would not quit, regardless of how many probe connections
> came and went, until a connection actually negotiated).  But we
> broke that in commit ee7d7aa when removing the return value to
> nbd_client_new(), although that patch also introduced a bug causing
> an assertion failure on a client that fails negotiation.  We then
> made it worse during refactoring in commit 1a6245a (a segfault
> before we could even assert); the (masked) assertion was cleaned
> up in d3780c2 (still in 2.6), and just recently we finally fixed
> the segfault ("nbd: Fully intialize client in case of failed
> negotiation").  But that still means that ever since we added
> TLS support to qemu-nbd, we have been vulnerable to an ill-timed
> port-scan being able to cause a denial of service by taking down
> qemu-nbd before a real client has a chance to connect.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JHvxJevk8ilAfBEUhEqrKK7mlgvFjOXfO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOo1nAAoJEKeha0olJ0NqrEEH/2bfd4Vm0r+ncBJJpqp021iX
Aaqqh2hYH+5mBvnPat/r8G1C+J90429hX2Po+2GdKFRRIovuImdzieb8qMb7/j4v
SRomdaC72Wcc363/JGQl+hv48vWTcX8PC0/iDMp894n+9V4PRHymbIr4AuBFut9K
vD+/O948UPJKUNqni0MbV/Zq1IbVF5w1U/MlAFoDE4SmGRElHKehP18pdJDapSIW
Hz08rxqkAkCNt8PKEAmAYisM0w2m4pjYIXSWEO0qa5JTNC3+PT+QxQ+54Mg9EKin
fdSD3puIA43RfsQIeCyuTFJAMUHT9unXX8sT8hqGxGjnqbtCxn4ktHINx0uEDTo=
=a/Fb
-----END PGP SIGNATURE-----

--JHvxJevk8ilAfBEUhEqrKK7mlgvFjOXfO--
