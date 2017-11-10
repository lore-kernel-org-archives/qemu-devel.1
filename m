Received: from eggs.gnu.org ([2001:4830:134:3::10]:43956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHB5-0007gn-1F
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHB3-00048s-RQ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:49:31 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <598f9eea-ceb6-f525-4cc9-57fb5cd993ac@redhat.com>
Date: Fri, 10 Nov 2017 15:49:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VroAkO8fTQSifkddVkl8lUGN6NWMe1P6f"
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VroAkO8fTQSifkddVkl8lUGN6NWMe1P6f
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <598f9eea-ceb6-f525-4cc9-57fb5cd993ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-5-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:31 PM, Max Reitz wrote:
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728661
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.h              |  6 ------
>  block/qcow2-refcount.c     | 26 +++++++++++++++++++++++++-
>  tests/qemu-iotests/060     | 46 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/060.out | 22 ++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VroAkO8fTQSifkddVkl8lUGN6NWMe1P6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGHt8ACgkQp6FrSiUn
Q2qkXQf/akkXntquPNSw+k8w/uW5eHctTgNn887BCQJ4IroIH4Ey2m5vP+Vhgvup
/pqos364gMYTntH1xdGoOey1w9UV+ok5F7gEelnnkQa6He13GP/X/1QO01Uq0Fuw
S59gQFydb1jIsK6yg7RFHTnWwj58Eo8B+Y1pcRRiScgdfXfA49LCGh1QzD5nArtL
L9Cckmd/wOuMZC02hPElseKkylsgrKYRclUjLtVx92XG3jGx+jEDfDe0B5t9HwNL
4AhjigrmI054kRKFmb2NNpOxDksHRaAuPK9BvuFisVk0H/Eq+rflTR1DeVYKBTt0
WjCZJMajqat9TMoQweee4pipnJRBVg==
=0/Mn
-----END PGP SIGNATURE-----

--VroAkO8fTQSifkddVkl8lUGN6NWMe1P6f--
