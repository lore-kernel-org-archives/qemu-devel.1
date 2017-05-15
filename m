Received: from eggs.gnu.org ([2001:4830:134:3::10]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHU7-0007gA-8o
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAHU6-00047E-Dc
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:00:31 -0400
References: <20170515141014.25793-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efc90945-9b9e-9e52-80b6-96ab49294858@redhat.com>
Date: Mon, 15 May 2017 10:00:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170515141014.25793-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MM0koiRnqC2AhJFFovG4CSi23AnPqLqd9"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix leakage of options on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MM0koiRnqC2AhJFFovG4CSi23AnPqLqd9
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <efc90945-9b9e-9e52-80b6-96ab49294858@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix leakage of options on error
References: <20170515141014.25793-1-famz@redhat.com>
In-Reply-To: <20170515141014.25793-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 09:10 AM, Fam Zheng wrote:
> Reported by Coverity.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MM0koiRnqC2AhJFFovG4CSi23AnPqLqd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGcKAAAoJEKeha0olJ0NqxPwIAK8npkcABfeHPuh1HQNFGgxa
tCQgwwrV+eB6S383KkyCPx9gE2SpU618ezjRu5uaQP4s+lgPRshjUUOTDkymXf3r
1doVIfGsmjyitsfZI1iXQb8YsOmldcg5jhoZbtYUi3f08hvCEIrnpPRZ214yzBBw
kCsDjg0kr6yusoLKg1ReEBfRSuHfMIrSYS78jk7W8u8FbL5YRaeazBN5MM/bFBYc
jErplmFDPPNaEUIfrSiVZqS5xM90cxxfxy4X0aGGVivAnIHISIaQq/GpC9E+emww
KK1paRMGZuQr9GimLIFp2uF1KdZf9PCywLTwtRTuiIWnlhYGbhnGz/D7JgCCmQk=
=i6Qo
-----END PGP SIGNATURE-----

--MM0koiRnqC2AhJFFovG4CSi23AnPqLqd9--
