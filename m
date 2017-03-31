Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1N4-0006Ib-Rt
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1N3-0002tK-RT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:34:02 -0400
References: <20170331170512.10381-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59f0e6b5-f0b3-873f-8b23-09ae2237bed6@redhat.com>
Date: Fri, 31 Mar 2017 13:33:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170331170512.10381-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hB6PLVlAfOSKE8hBBhGCBWW2i6e3MGAKP"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/parallels: Avoid overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hB6PLVlAfOSKE8hBBhGCBWW2i6e3MGAKP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <59f0e6b5-f0b3-873f-8b23-09ae2237bed6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/parallels: Avoid overflows
References: <20170331170512.10381-1-mreitz@redhat.com>
In-Reply-To: <20170331170512.10381-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 12:05 PM, Max Reitz wrote:
> Change the types of variables in allocate_clusters() to int64_t so we d=
o
> not have to worry about potential overflows.
>=20
> Add an assertion that our accesses to s->bat[] do not result in a buffe=
r
> overflow and that the implicit conversion performed when invoking
> bat_entry_off() does not result in an integer overflow.
>=20
> Coverity-id: 1307776
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> This supercedes Peter's patch "block/parallels.c: avoid integer overflo=
w
> in allocate_clusters()".
> ---
>  block/parallels.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hB6PLVlAfOSKE8hBBhGCBWW2i6e3MGAKP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3qEPAAoJEKeha0olJ0NqMccIAIsmK7WkNUYWd1ggV9coLHii
Kj6YLZ+Y8hLlEM1gD5z6CcMI7rdN9y2UP3bIkemZ9CX/IXdhAngg13frF/qFttBK
YACEufnOsV3dI8E/Tn76zZTkTBrPLS+e2fwD6GMG09rM8WNUrwVPOWKeON8zZfvb
Jqlfep9a+k6SP8aaseprkR8XPycQRuQ76d6XLC1peXVDuM7tzDeThPdOOU8Ornbh
/VdHmt2Cs/VRFH1b5dw85+wCE5PRVehaBgtymxaAi/lAfkEVv5/UCTCNcTl8NDAD
q0IWT3ftNPz+C4S1EMXcTFIRaGbIcpylBayi2yjZm3LEw/qpUSCzfrtKLDbPU7k=
=pE8a
-----END PGP SIGNATURE-----

--hB6PLVlAfOSKE8hBBhGCBWW2i6e3MGAKP--
